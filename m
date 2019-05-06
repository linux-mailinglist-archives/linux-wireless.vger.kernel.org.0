Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642D81456E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 09:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEFHin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 03:38:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfEFHin (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 03:38:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so6294447pfg.6
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH0f+Eu6ZUxRZIXEvgdiO6zx0qQSRtdsKIC2yQILbks=;
        b=QaOdz86fyFLQbeHUAfpKUqy3CHKbeux5DBpACGjpPyo5X5D0c57mvy24MVgWmQMSvz
         1egUVxNVsRmcBa1TR61KPKVkgGejeSZq/pxfK9a/KsMK1rhJ0ejqJgqIU3lpo7i3oXRY
         z5gPdKl+vOu/z6ctMbqgWQHCiczTJp7MZqxQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH0f+Eu6ZUxRZIXEvgdiO6zx0qQSRtdsKIC2yQILbks=;
        b=N5eSRwGdgIOg43UFDGcCKK2oHxmRSj7r/WKzBViK9FeFWWkAVERbrcLzeL+oKAMT+q
         T2sx0WdjgfCm4wWBYr/tPZK+1qBmD5fZp2eQREd6hTEXTfGMlouL3GLC7qeqgHCzTgLf
         +fVLklHhSkNkewAKcQ8WtF8pvKRyjngakeyBBAn56kbqVV+Y5DEeqeoi7/DtyAsNkx2J
         B65HCb3VCMhCJU1DJjU+Z3SJA1H+UpOem86BO4Gq3jx2fUpDFkTMGz4NXyVFI+M9LAdK
         Tkeru/hoV01PI8HAUZt6pbzjQCcTaxQ3G3CzTsNJOd/bCnDjUS0PzAFFvLYmzN3RvJQM
         TLXw==
X-Gm-Message-State: APjAAAW73LaoJI+IvvdPFekd7A6XCfzvFqDqc0Ds5bec7gDiVzyqnAGA
        deXIN09GsAxN2LWDetiLIqUM5f4+QpvE8Q==
X-Google-Smtp-Source: APXvYqzq7+RiKLUM1UGBJdOhCrgnYMsbITyjWDoqQRHZeLPQtrTv4DFlBT7QlqC+j+2pVCeGskmVHA==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr31160168pfi.50.1557128322639;
        Mon, 06 May 2019 00:38:42 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id j189sm14464852pfc.72.2019.05.06.00.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 00:38:41 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        wgong@codeaurora.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] ath10k: acquire lock to fix lockdep's warning
Date:   Mon,  6 May 2019 15:38:36 +0800
Message-Id: <20190506073836.184059-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lockdep warns at lockdep_assert_held(&ar->data_lock) in
ath10k_htt_rx_pn_check_replay_hl(). Acquire ar->data_lock before calling
ath10k_htt_rx_pn_check_replay_hl() to fix it.

Call trace:
ath10k_htt_rx_pn_check_replay_hl+0x118/0x134 [ath10k_core]
ath10k_htt_rx_proc_rx_ind_hl+0xd8/0x250 [ath10k_core]
ath10k_htt_t2h_msg_handler+0x148/0xf30 [ath10k_core]
ath10k_htt_htc_t2h_msg_handler+0x24/0x40 [ath10k_core]
ath10k_sdio_irq_handler+0x374/0xaa4 [ath10k_sdio]

Fixes: 130c77495708 ("ath10k: add PN replay protection for high latency devices")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 9eed1cb17fda..3e3be1e5bbaf 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1952,6 +1952,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	int num_mpdu_ranges;
 	size_t tot_hdr_len;
 	struct ieee80211_channel *ch;
+	bool pn_invalid;
 
 	peer_id = __le16_to_cpu(rx->hdr.peer_id);
 
@@ -1983,9 +1984,13 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 		goto err;
 	}
 
-	if (check_pn_type == HTT_RX_PN_CHECK &&
-	    ath10k_htt_rx_pn_check_replay_hl(ar, peer, rx))
-		goto err;
+	if (check_pn_type == HTT_RX_PN_CHECK) {
+		spin_lock_bh(&ar->data_lock);
+		pn_invalid = ath10k_htt_rx_pn_check_replay_hl(ar, peer, rx);
+		spin_unlock_bh(&ar->data_lock);
+		if (pn_invalid)
+			goto err;
+	}
 
 	/* Strip off all headers before the MAC header before delivery to
 	 * mac80211
-- 
2.21.0.1020.gf2820cf01a-goog

