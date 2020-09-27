Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEA27A203
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgI0RS7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI0RS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B29C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5RkjGxEbzXed/Ysc1Vlf14V1EgWEzf2/LcCjPFLCLh0=; b=nMMVPXxnrZmSNZLLTXSv6GWSvz
        dFTGjNpGmqekFH+CE7tO77c5nM2gUJ7y/QN1hlcFUQii5LTz/je9AGDdXuTOYGs+JDzNjzOObVShy
        zb7OSRo244ZYnmg3SJYLyimzrA1ZWSmanJaUuJ7Jhdml2j0YOytRqiMm+JEpB6muwg9U=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK6-0002oU-Ij
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/8] mt76: mt7915: fix processing txfree events
Date:   Sun, 27 Sep 2020 19:18:51 +0200
Message-Id: <20200927171852.48669-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the MT7915 info, the fields for the WLAN index / queue overlap with the
token id, and the MT_TX_FREE_PAIR bit indicates, which one is present.

If MT_TX_FREE_PAIR is set, skip processing the token index, since the data
will not be valid.

This fixes accidentally freeing tokens which are still in use by the
hardware with a wrong station pointer.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 44a5b4f8e43c..3456d9532f29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -972,6 +972,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 			if (list_empty(&msta->poll_list))
 				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
 			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
 		}
 
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
-- 
2.28.0

