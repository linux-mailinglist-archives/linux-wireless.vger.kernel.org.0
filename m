Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3508552A83B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiEQQhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351124AbiEQQhb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 12:37:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2A4EA1D
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 09:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E511B81AB4
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1039DC385B8;
        Tue, 17 May 2022 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652805436;
        bh=Tsqg1oWUzGNtmPormC2WV3SSQxG4PhnFZcA2XF25ffM=;
        h=From:To:Cc:Subject:Date:From;
        b=PEzir+t+jFSWYW0zvzVcOAhzSaRmJlnyaADV+0NvdbRc6pFefn6/ORWNkIE3cq11K
         1iwvzmctFtv9gzW6YwGeJ32l+e98MC+sOM073HaO+SRCZzW9eeQE4xupv1j8Z5lH0s
         aKn1X0OFc7WrH8uowdgIYlenl5434ASSyeOKiMwyGk99h2RBPwvYNjQvAE0ZuYsApT
         cLuWCFX5f7juNpBOR6PGn6i2FZC4M7B/6iMiZL50z2E7/JwafaqUioVZp9r9DniNuw
         LrChaRwDZZGyYKhorYczK2SIwaG6xI0UGR2J4adsSzx5UpZQKA4u9xakxhta7P9Qae
         HEiveWtrnfKXQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        soyer@irl.hu
Subject: [PATCH] mt76: mt76x02u: fix possible memory leak in __mt76x02u_mcu_send_msg
Date:   Tue, 17 May 2022 18:37:07 +0200
Message-Id: <2144b76681dba4e0d8f6aefb05cb0d171e5ce680.1652805354.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free the skb if mt76u_bulk_msg fails in __mt76x02u_mcu_send_msg routine.

Co-developed-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Fixes: 4c89ff2c74e39 ("mt76: split __mt76u_mcu_send_msg and mt76u_mcu_send_msg routines")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index 2953df7d8388..c6c16fe8ee85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -108,7 +108,7 @@ __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	ret = mt76u_bulk_msg(dev, skb->data, skb->len, NULL, 500,
 			     MT_EP_OUT_INBAND_CMD);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (wait_resp)
 		ret = mt76x02u_mcu_wait_resp(dev, seq);
-- 
2.35.3

