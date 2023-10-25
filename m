Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB647D73D5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYTEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjJYTEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:05 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF5123
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:02 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 70D5A800070
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9724E13C2B0;
        Wed, 25 Oct 2023 12:03:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9724E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260639;
        bh=zhsLl1DtQm//XDgd6Sqxq8S9S+rAhB715Hpuo6voig8=;
        h=From:To:Cc:Subject:Date:From;
        b=KlM9+pBqCMSRP2AwmnG1dSAwUeHcf3oqKh8u368UC/QGZYCjGiYsBXIROT87c3NXU
         JPZKI+C2kkzArIMvxdPmBgNhbkrYosIsWiYDDYUv03iAMDTgAW+Drw4mXsNDIZHJYd
         6CfuvDe3OVVzO30oz/iboty1Gm9qNdRKVoF8b2CY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 01/12] wifi: mt76: mt7915: print out hw revision
Date:   Wed, 25 Oct 2023 12:03:43 -0700
Message-Id: <20231025190351.2141832-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-fcsu95SCbQIc
X-MDID-O: us5;at1;1698260641;fcsu95SCbQIc;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Help determine what version of silicon is in use.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

I've posted similar patches previously, these are rebased on top of
wireless-next.  I've lots more, including similar patches for other
mt76 drivers, but hoping I can get some of this upstream before posting
others.

 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index e7d8e03f826f..11919e5774a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -851,7 +851,7 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 
 	mdev->rev = (device_id << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
-	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
 	return 0;
 }
-- 
2.40.0

