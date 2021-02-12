Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F299319842
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBLCOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 21:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBLCOe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 21:14:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ECC061797
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:17 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s24so7850986iob.6
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b//uXdEXn/IbyWUN9jECjkifnnE9MDyqXLg0odI7qQ8=;
        b=eXyRVsRfEN70euVgiAtmESC4LEMBc5UdUY6dgr3lsi5tPhEcUNuJKHboVU/N4Z265E
         g2OYFrPAw/oLLZRyqHCo//ujRwPC/5I0w7ywJ0ZJqi9IrwIo7aFiqcZrgyncJHuYJizB
         rXHnCfSBrNh4n6qGKt2bOvDMi0tLR4BhXM5w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b//uXdEXn/IbyWUN9jECjkifnnE9MDyqXLg0odI7qQ8=;
        b=BRfq5HK7TASW8kT5jcMcHIUMCwVPm26QnDo8PEhxubE+jycXXgBy6w5MDUfPL41oYM
         hcmqdkIGoN2928XW+BZh7W9emWlK3rfsST4gzkkDBcjcD0+KL98pNMq213mYM8IfqBhf
         +MsYWtfNAsM1ZRrzH7+8/GPSi2OcZMG0cp7kN9XPv0iDcUVQB/20q/1tWiTItIYYDPxh
         vScQOQEJm7dR5wHkZcRLCB1yQntHKVZBCyfIzPwjx5s1b+QIBKqDmT0vxg5czsWj6Zqa
         Q9Jqgn35JAwWyFikgkpo3/8dy+VkxCkRCmdAacnKyRUUYmSnsleGMUS8BN8kqoHgbK63
         hPUw==
X-Gm-Message-State: AOAM530brI1OvHD5GUs20ba1B75NrjW6mJ6HiX/y6GmB3JEly4uS21uy
        a2k7XyU7Gxkpjq+smnigQ4DHhA==
X-Google-Smtp-Source: ABdhPJx/RCdCsRX+e5oooz5vMln7HcisejHBH5jilCl4mDg+LF74Is7NKrlK5kw310Vr5GykMGekEA==
X-Received: by 2002:a6b:5a0f:: with SMTP id o15mr506350iob.49.1613095996797;
        Thu, 11 Feb 2021 18:13:16 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm3480594ilk.32.2021.02.11.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 18:13:16 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ath9k: fix ath_tx_process_buffer() potential null ptr dereference
Date:   Thu, 11 Feb 2021 19:13:08 -0700
Message-Id: <43ed9abb9e8d7112f3cc168c2f8c489e253635ba.1613090339.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613090339.git.skhan@linuxfoundation.org>
References: <cover.1613090339.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath_tx_process_buffer() references ieee80211_find_sta_by_ifaddr()
return pointer (sta) outside null check. Fix it by moving the code
block under the null check.

This problem was found while reviewing code to debug RCU warn from
ath10k_wmi_tlv_parse_peer_stats_info() and a subsequent manual audit
of other callers of ieee80211_find_sta_by_ifaddr() that don't hold
RCU read lock.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
- Note: This patch is compile tested. I don't have access to
  hardware.

 drivers/net/wireless/ath/ath9k/xmit.c | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 1d36aae3f7b6..735858144e3a 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -711,20 +711,24 @@ static void ath_tx_process_buffer(struct ath_softc *sc, struct ath_txq *txq,
 		ath_tx_count_airtime(sc, sta, bf, ts, tid->tidno);
 		if (ts->ts_status & (ATH9K_TXERR_FILT | ATH9K_TXERR_XRETRY))
 			tid->clear_ps_filter = true;
-	}
 
-	if (!bf_isampdu(bf)) {
-		if (!flush) {
-			info = IEEE80211_SKB_CB(bf->bf_mpdu);
-			memcpy(info->control.rates, bf->rates,
-			       sizeof(info->control.rates));
-			ath_tx_rc_status(sc, bf, ts, 1, txok ? 0 : 1, txok);
-			ath_dynack_sample_tx_ts(sc->sc_ah, bf->bf_mpdu, ts,
-						sta);
+		if (!bf_isampdu(bf)) {
+			if (!flush) {
+				info = IEEE80211_SKB_CB(bf->bf_mpdu);
+				memcpy(info->control.rates, bf->rates,
+				       sizeof(info->control.rates));
+				ath_tx_rc_status(sc, bf, ts, 1,
+						 txok ? 0 : 1, txok);
+				ath_dynack_sample_tx_ts(sc->sc_ah,
+							bf->bf_mpdu, ts, sta);
+			}
+			ath_tx_complete_buf(sc, bf, txq, bf_head, sta,
+					    ts, txok);
+		} else {
+			ath_tx_complete_aggr(sc, txq, bf, bf_head, sta,
+					     tid, ts, txok);
 		}
-		ath_tx_complete_buf(sc, bf, txq, bf_head, sta, ts, txok);
-	} else
-		ath_tx_complete_aggr(sc, txq, bf, bf_head, sta, tid, ts, txok);
+	}
 
 	if (!flush)
 		ath_txq_schedule(sc, txq);
-- 
2.27.0

