Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666A7490B6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfFQUC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 16:02:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34038 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFQUCZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 16:02:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so10611061ljg.1;
        Mon, 17 Jun 2019 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=el/lmx3URjPIgcoee+SzjF2RP1q5hM7+uu7Bj9EF3vk=;
        b=tZ5OnQajpIZ9SBlSH6SWDGOMWySXm6XR9I7pogLt4tUnlyVOoBR1TPYGl6VdN9GsnH
         +yhxHl1pAjCN3NO1qyVh9p65Q9oyiWJzkiQDlUJ8bHkYT2dE5rGB6/Po4IK9zp+Gdm4w
         gHoahmZFLuAndWzPYtY6ovrhldh7xTwjMmtmLkjzJq1N0vAG8Q7/XIsJUuO/QwDDybFC
         LCS5dhLZJ1KgbN5a29e/6JJyk65JfzbskDJc23CsxVVyo6c5/qRwsff4acnhMBXzZ/t7
         CpoklaFA3H4577VW265ZeIdm0DTxR8i2FhnbCyPOeK3IFNz1+jYrJhvET6pUUk6l5IQK
         qiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=el/lmx3URjPIgcoee+SzjF2RP1q5hM7+uu7Bj9EF3vk=;
        b=PHI30DWZhRc8Ac/rdHstDITBuTEHAmBbNNOJjxovIPGm/fBT/WhSmZwlcBNH4xEWTR
         68lSGTHwCEHFcvJzf49TpwXO4RITe5eIBbhc2fBTV0acHHt6wRvngbsyLBuNxqIDxi+U
         iOey3Mqvr0y9DJuMZv8vUdJR3JwbHNkTzUH8EMzCDU1dwOEBTqBLab9Al53VZwc1aT9W
         btIOQtA5SjR2zPLduITFkb9Zlu5Ojjy2+SwXGLqc77yEl+xuUFaeMUMCng+/NhkUautE
         XiLDsk7AfCFgaUHOoFzzvfORPAZTS7sVtpGJqk3h9ncRcYK4z8ZRDweJLTu9tYB39zOy
         qskA==
X-Gm-Message-State: APjAAAXclNp9hEgP3eqZ+wOiKc8MLw/Lur2avFo1itYCTuEK+dUAW4tw
        Miq61OC1g1TFtSD77Ml6epg=
X-Google-Smtp-Source: APXvYqytxTqltTU/5ZwjjxHJxPCf68q2+FZPL9kg5tufSXQY1XiNTsj5qLJJNsms3tadjNQ6qNKUfQ==
X-Received: by 2002:a2e:6313:: with SMTP id x19mr52311170ljb.25.1560801743538;
        Mon, 17 Jun 2019 13:02:23 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id j90sm2245780ljb.29.2019.06.17.13.02.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:02:23 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        davem@davemloft.net, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
Date:   Mon, 17 Jun 2019 22:01:40 +0200
Message-Id: <20190617200140.6189-2-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617200140.6189-1-erik.stromdahl@gmail.com>
References: <20190617200140.6189-1-erik.stromdahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since ath10k_mac_tx_push_txq() can be called from process context, we
must explicitly disable softirqs before the call into mac80211.

By calling ieee80211_tx_dequeue_ni() instead of ieee80211_tx_dequeue()
we make sure softirqs are always disabled even in the case when
ath10k_mac_tx_push_txq() is called from process context.

Calling ieee80211_tx_dequeue_ni() with softirq's already disabled
(e.g., from softirq context) should be safe as the local_bh_disable()
and local_bh_enable() functions (called from ieee80211_tx_dequeue_ni)
are fully reentrant.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 2d503d6cdcd2..bbed9f1b1778 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4033,7 +4033,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 	if (ret)
 		return ret;
 
-	skb = ieee80211_tx_dequeue(hw, txq);
+	skb = ieee80211_tx_dequeue_ni(hw, txq);
 	if (!skb) {
 		spin_lock_bh(&ar->htt.tx_lock);
 		ath10k_htt_tx_dec_pending(htt);
-- 
2.22.0

