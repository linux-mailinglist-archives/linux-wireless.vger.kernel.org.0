Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC8508636
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377782AbiDTKqa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376506AbiDTKqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 06:46:25 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0E3FDB4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T48u72zYkdxaToU1x2wH0NSnqQnzI4Q6H8B1nwJ6u0g=; b=Z85H5j4grx7YkTyEDV7Z+UqsXY
        AV/lKZhBCjMuq8QZeHbJf7DPam0vjLsxziWTr+XZPtvKFjDKTHWnmuN4GFNWArWQ/Ni0/nxJB706P
        iB67A4Cq0TD/Ia7ywaYG/atCRtADD1SSfFNzKOWT4f5R33Apv/0o0qbfHiqnO7RQPSDM=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh7oA-00052O-9r
        for linux-wireless@vger.kernel.org; Wed, 20 Apr 2022 12:43:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix rx reordering with non explicit / psmp ack policy
Date:   Wed, 20 Apr 2022 12:43:31 +0200
Message-Id: <20220420104331.32418-1-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the QoS ack policy was set to non explicit / psmp ack, frames are treated
as not being part of a BA session, which causes extra latency on reordering.
Fix this by only bypassing reordering for packets with no-ack policy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 72622220051b..9b8e1dfbc814 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -169,8 +169,7 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 
 	/* not part of a BA session */
 	ackp = status->qos_ctl & IEEE80211_QOS_CTL_ACK_POLICY_MASK;
-	if (ackp != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
-	    ackp != IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
+	if (ackp == IEEE80211_QOS_CTL_ACK_POLICY_NOACK)
 		return;
 
 	tid = rcu_dereference(wcid->aggr[tidno]);
-- 
2.35.1

