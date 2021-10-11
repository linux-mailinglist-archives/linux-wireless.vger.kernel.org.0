Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29C2428A91
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhJKKMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbhJKKMG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FAC061570
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CEp9SK2THAhiavjnyvyFXMvBhCVX42EpDIoO7m04Fuo=; b=paSEsLdqP962ly1Zvw/uCYX4US
        70U2Xb0I1be/kTUtuMVgFu8aavkCqRPeGdlEkgZKwcj8AN0TDNARTX7SSlaAj/8WZGXcHLczMjGEg
        sOk8lugkN6OXIrEkvxNbM5mBOxmq2lbKJlbuV/IZTSO1E5zqftnAKRqj9preA5S2cf8U=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mZsFw-0007uD-F3
        for linux-wireless@vger.kernel.org; Mon, 11 Oct 2021 12:10:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: do not access 802.11 header in ccmp check for 802.3 rx skbs
Date:   Mon, 11 Oct 2021 12:10:02 +0200
Message-Id: <20211011101002.53900-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoids false positive on detecting frags or encrypted mgmt frames

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5a6608f36ebc..766681a4f89e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -974,6 +974,10 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	if (!wcid || !wcid->rx_check_pn)
 		return 0;
 
+	security_idx = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+	if (status->flag & RX_FLAG_8023)
+		goto skip_hdr_check;
+
 	hdr = mt76_skb_get_hdr(skb);
 	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
 		/*
@@ -994,9 +998,8 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	if (ieee80211_is_mgmt(hdr->frame_control) &&
 	    !ieee80211_has_tods(hdr->frame_control))
 		security_idx = IEEE80211_NUM_TIDS;
-	else
-		security_idx = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 
+skip_hdr_check:
 	BUILD_BUG_ON(sizeof(status->iv) != sizeof(wcid->rx_key_pn[0]));
 	ret = memcmp(status->iv, wcid->rx_key_pn[security_idx],
 		     sizeof(status->iv));
-- 
2.30.1

