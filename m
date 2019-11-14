Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A23FCF02
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 20:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNT5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 14:57:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41332 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNT5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 14:57:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id o3so8155171qtj.8
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rMcK0vfklBoc6jwJF8I3LX4UqIxKfyFKfTWU5PL1/kQ=;
        b=ZMNvrFUCCj2a/rX8ay5atF5ewlQZuBbwovERCmYFMDubfn9AIH1Xw+g7WbJx8L0DkY
         RjE/eTernivgOmmX4fikkwocwn1ntxtf2A/UwIfeAoiuXjlGgPcWqMf5aDQvS79Ov4qM
         E0C6ZI4cN0tdh3IMHvxmWQ7Po/3dC+gmEfZz9r43HK75Ucpqxr9HN1sus9yqeb/HxAYS
         iQdJkQiMeARWDlqUye91Jark3YaBKF/gvSkuBLtVKG4esR4jc95jFH69RVgVMddB8ugJ
         8LGXFiMBF5Rk2wFtw2GgstcDlx58jkciexU5nHUy73GsyRGLRtToKKwvzf0/VOnAwUZt
         MAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rMcK0vfklBoc6jwJF8I3LX4UqIxKfyFKfTWU5PL1/kQ=;
        b=sQ+Cj3t6b7vAmIZVIeUFnUtZeRC+cw7xQS38M5KdFQ89ios0ffcnOJWeTaFFbS29+P
         CL2i/vBhWeQm/zophYLkN23EaFcWrkXh57GyMD9OoKqmjMzyhD56ZbzxEvNmhWRxCkJ4
         eiFRQcHs6NKUBgn4e/hD4FOyVOJ5gSpsMSBpwkoK3+cnGwMPLdX40TK79c8qnBaCwbZR
         TpeaYtA+EQ5C0od7hOLC404Burv+CvKQTR06zaW4zo364uN7t9KGpT5Lp5K5/RAsaP0h
         HsGlAIrHTX9loag23gQffwPReKhuPLC/TT8NL+WpgY7B/DJNQH+VL9Nk37iwrZPBaWb4
         4Bmg==
X-Gm-Message-State: APjAAAVGyvZqBK9ZybaFrxPyqZEW6yY+2xWvHLI+ycShmfROlGH7bO2q
        PPMo+SNLeqR7eS8u2U0L/B5JM9E8opo=
X-Google-Smtp-Source: APXvYqyXaCdSCaSBEFPa6fRGH2eTvtM89Jp3qsw0/BcJ+gZBymrMuu+5knZtDEhXeAve/DmKE6O4WA==
X-Received: by 2002:ac8:342b:: with SMTP id u40mr9915509qtb.87.1573761463527;
        Thu, 14 Nov 2019 11:57:43 -0800 (PST)
Received: from ubuntu.wgti.net ([64.94.121.131])
        by smtp.gmail.com with ESMTPSA id r36sm3924852qta.27.2019.11.14.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:57:42 -0800 (PST)
From:   Ming Chen <ming032217@gmail.com>
X-Google-Original-From: Ming Chen <ming.chen@watchguard.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: [PATCH v2] mac80211: Drop the packets whose source or destination mac address is empty
Date:   Thu, 14 Nov 2019 11:57:12 -0800
Message-Id: <20191114195712.101568-1-ming.chen@watchguard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We occasionally found ath9k could receive some packets from Linux IP stack
with empty source and destination mac address,which will result in the
driver cannot find the station node in TX complete. And thus, the driver
will complete this buffer but without updating the block ack window.

To fix this issue, we should drop this kind of error packet before it
goes into the driver.
---

According to review feedback, use the is_zero_ether_addr to check if the
mac address is empty.

Signed-off-by: Ming Chen <ming.chen@watchguard.com>
---
 net/mac80211/tx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index db38be1b75fa..b18745a3f6b0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2489,6 +2489,13 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (IS_ERR(sta))
 		sta = NULL;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (is_zero_ether_addr(skb->data) ||
+	    is_zero_ether_addr(skb->data + ETH_ALEN)) {
+		ret = -ENOTCONN;
+		goto free;
+	}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	if (local->force_tx_status)
 		info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
@@ -3435,6 +3442,11 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
 		return false;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (is_zero_ether_addr(skb->data) ||
+	    is_zero_ether_addr(skb->data + ETH_ALEN))
+		return false;
+
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
 		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-- 
2.17.1

