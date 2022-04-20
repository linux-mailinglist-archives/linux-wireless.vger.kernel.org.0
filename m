Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3685086E5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378042AbiDTL20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbiDTL2S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 07:28:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD93C4B5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qS4RzWD/rp9U12J+O+Qvd0P5ZJIxobZfplZjn25+BwI=; b=uZNefaz3LsfCRhA+RIfQewyOoi
        NuC9dyHe0MNvj0VllIX5lfJIUCM78+64/Mpfd6TD0K3bHoS50S8iNFxO81giIeykr0MQ83IQD51lA
        kfR4QAGeU1RZx/RcO/RkAqzmXsoUeZ0PAMJZvASz5PYUsTGYfF1mfWuxHX9G7mVl+vAw=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh8Se-0006a1-G7
        for linux-wireless@vger.kernel.org; Wed, 20 Apr 2022 13:25:28 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: do not attempt to reorder received 802.3 packets without agg session
Date:   Wed, 20 Apr 2022 13:25:24 +0200
Message-Id: <20220420112524.52430-1-nbd@nbd.name>
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

Fixes potential latency / packet drop issues in cases where a BA session has
not (yet) been established.

Fixes: e195dad14115 ("mt76: add support for 802.3 rx frames")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 9b8e1dfbc814..10cbd9e560e7 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -162,8 +162,9 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	if (!sta)
 		return;
 
-	if (!status->aggr && !(status->flag & RX_FLAG_8023)) {
-		mt76_rx_aggr_check_ctl(skb, frames);
+	if (!status->aggr) {
+		if (!(status->flag & RX_FLAG_8023))
+			mt76_rx_aggr_check_ctl(skb, frames);
 		return;
 	}
 
-- 
2.35.1

