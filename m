Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DADFD77A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 09:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKOIAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 03:00:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 03:00:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id p20so9938810qtq.5
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rUk2UFLWwTbCedOCxT8lGDtJxih2bllQMzQrq34KHmQ=;
        b=iCXSHc+He7qMtyxsj8AZYIpId42eipyXOIR3HQp9mJPlsDhQjerLvHXNq+4y1D1s/K
         yN2IWsHo2eIo/svDUqvUFDjVZqbp4KNjxmf+Sc9ZT7FTU+bDJmf1Woh3HA7zUj4Wj4U3
         k54eAvEZBZl4HVEw3Js0ASAXBIUkKxZeGIubh9zFiayUOiNnmdwJ8LYKC1hU+pHxgw22
         gpH7riNz4qwAqTcT5GU9TaSVxS3m2Eehdi9SMek3zfAZBgbg9MT6HFAq8LXcYjmXrdu6
         rDp58f0qUDuV8jK/cNc0WcUK/m1ttFpkp4dT/T/Z3RMGiBoX3jHeKHqAdxDEpRLXAJq+
         TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rUk2UFLWwTbCedOCxT8lGDtJxih2bllQMzQrq34KHmQ=;
        b=aT+oCF7geLCxTg5tuc0ptc3JZ+/5UuU5DtDnC573Par3maOk3Ihx91LLhenenY079+
         BSMeiNOUiLl8/jmwk28nOdqP449mmi9Dh3Ea1mLRI9QPSwz4vAotMedFcs/N/UZnjKsF
         yy1E3ls+rjtVWyfVmS5gc0UYPbGx+4amRB8OOoUQEDwjSw60YabYHLqS79L8WEI2vzeV
         g1Dvks3H4X2bFKPQGoUgiYMqUothjLwKhXRS6LgG6FjacDxUH40W+TQDTPuyk/9Y2ZpF
         0W6OtDdL9r04Hl19NdHtahypW61u+/UvwInI0AySY4GUQwjg5/nN6Eb9vIqJ/w+ep8Ol
         v4Kg==
X-Gm-Message-State: APjAAAUu2ZgArBnpC/iwfW81FGxxrMdaj2x8vv0LQxxeMtZBev271J0O
        yfUPr7dOsIeLohoYqnVisICdVIYA50M=
X-Google-Smtp-Source: APXvYqwGxzx1ziyou/DMIXWeYYuePiWX8ozXUQYKJL+pHrSicaomgxZDzpid+zFch+TMfA7ukWF5BA==
X-Received: by 2002:ac8:7216:: with SMTP id a22mr12431767qtp.187.1573804800744;
        Fri, 15 Nov 2019 00:00:00 -0800 (PST)
Received: from ubuntu.wgti.net ([64.94.121.131])
        by smtp.gmail.com with ESMTPSA id n56sm4554656qtb.73.2019.11.14.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 23:59:59 -0800 (PST)
From:   Ming Chen <ming032217@gmail.com>
X-Google-Original-From: Ming Chen <ming.chen@watchguard.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: [PATCH v3] mac80211: Drop the packets whose source or destination mac address is empty
Date:   Thu, 14 Nov 2019 23:59:42 -0800
Message-Id: <20191115075942.120943-1-ming.chen@watchguard.com>
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

Signed-off-by: Ming Chen <ming.chen@watchguard.com>
---

v3:
  -Fix s-o-b location

v2:
  -According to review feedback, use the is_zero_ether_addr to check if the mac address is empty.
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

