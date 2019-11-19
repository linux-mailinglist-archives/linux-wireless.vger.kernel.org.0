Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC39102EF9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 23:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSWSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 17:18:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36005 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKSWSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 17:18:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so12711159pls.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vBAfRp2eo17FJWeUhw9jBgFzCylGCXFBG+0pN4r6/x0=;
        b=BRtx2wJaK/U2MvC7a7UYgLv4IbKl7Ecm0RsXdoZJZ470hIdGU0mYlgpnjGhKFFHypk
         tO5o2ZYVVHPTXlcY8f7xQS2NS23PWJsr4mQjJ6VYu0gQJpS8D6r9rtZbhxKAn5kygU2i
         dcvwaTHIPVuyXPZ5CBCAAIY0RwndKWQiXkv2UTakyi6Yem08usd+a9P6IAduVHwt/+bF
         6Fi/MYyuLhtEaT2NIxeZdPD82U0Ug5os0OTFrMiINRhe45uwQUJS63vk0EUd+Md3Wq1m
         gGneEXkdOXlgtaIVlQFJaP/hQXSZ0p/YoFq6bDZSFAgEs/c9QVto/Mq/Erqz3Ut2tZc8
         fAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vBAfRp2eo17FJWeUhw9jBgFzCylGCXFBG+0pN4r6/x0=;
        b=mK/6woArsR+71LbGkoa0yCVKj9tJLx8GMRTB3BS3pRqNUnQ1PvcaTl4CBxBprXArRk
         cORUJmSFiIvZ5ohayElMaHNEecmMvoj78rbbhf8QHjcVTZDqSLCh7HSHp7E/n7puw9NB
         DUaHs1Xwi5EC0GWK5NXJkvfP2vH/4ZZlVvmx9KDqvqefZWQgOqFCqYMw/wK9g7O7sorP
         J2EKPM7P6vZmV+nVU+8uGdIr7uZm6nlAGCuPICAA2EcYw1VOnIA54Nu5/S/5rzWFXtdC
         lMe7fOQdGqSNjBAscqcIpPZtvkkreORfBuKm0Fu+OHRtNaRvxh7Oi5HUKIZ8KsXwfexM
         gNjw==
X-Gm-Message-State: APjAAAV4PLrWhN4EwKOHX7F0QhSJFVHae/9jDZue2k6MMspw2aVx9k7j
        Q2ReEz/YBdOtH97xt20PDVh1QBWO
X-Google-Smtp-Source: APXvYqxLq4EszNyTT26Tj/kIh5I+3O1ySZzb9znffWeUrJV1yqjMv1aMCbZahPs+9WBJ+cLElnNu+w==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr12912098pls.238.1574201913203;
        Tue, 19 Nov 2019 14:18:33 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id r33sm4633866pjb.5.2019.11.19.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:18:32 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] mac80211_hwsim: support parent TSF feature
Date:   Tue, 19 Nov 2019 14:15:41 -0800
Message-Id: <20191119221541.11422-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only iwlwifi actually enables this feature, but the support for sending
parent TSF/BSSID values already exists in nl80211. This patch sets the
appropriate flag and mactime values in rx_status so that the parent TSF
value gets included in the scan results.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 772e54f0696f..01b2ac9707cc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2825,6 +2825,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			       NL80211_FEATURE_DYNAMIC_SMPS |
 			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BSS_PARENT_TSF);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
@@ -3237,6 +3238,8 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	int frame_data_len;
 	void *frame_data;
 	struct sk_buff *skb = NULL;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb_2->data;
+	u64 now;
 
 	if (!info->attrs[HWSIM_ATTR_ADDR_RECEIVER] ||
 	    !info->attrs[HWSIM_ATTR_FRAME] ||
@@ -3299,6 +3302,18 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	rx_status.rate_idx = nla_get_u32(info->attrs[HWSIM_ATTR_RX_RATE]);
 	rx_status.signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control)) {
+		rx_status.boottime_ns = ktime_get_boottime_ns();
+		now = data2->abs_bcn_ts;
+	} else {
+		now = mac80211_hwsim_get_tsf_raw();
+	}
+
+	rx_status.mactime = now + data2->tsf_offset;
+
+	rx_status.flag |= RX_FLAG_MACTIME_START;
+
 	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
 	data2->rx_pkts++;
 	data2->rx_bytes += skb->len;
-- 
2.17.1

