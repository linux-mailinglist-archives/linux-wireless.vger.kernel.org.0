Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA144F1FF2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiDDXNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 19:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245452AbiDDXLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:52 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1842714
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 15:51:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E806B1A006F
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 22:51:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BE62890007C
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 22:51:01 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2271513C2B0;
        Mon,  4 Apr 2022 15:51:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2271513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1649112661;
        bh=eTxdnXb0GyBcyBa0Hmicj6RDB/2JX86y/qaBebGfSbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMgxhxiLLIgT3GjqaGN2Z9K0jiC3qtOJbLIBtGqzPuBgi6x9XCvVdzLYBJRxmo436
         ro1zat9x0mnZU3wCrMAclNAJg2Z6cN0CwgfWvjNkGzh0C0oS4pnnUmkOO+TJP88dS3
         SZNTZSFBndEvh00Em7wj5d5qgrNci8QXzELWryrk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] mt76: mt7915:  improve logging around unhandled events.
Date:   Mon,  4 Apr 2022 15:50:58 -0700
Message-Id: <20220404225058.32475-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220404225058.32475-1-greearb@candelatech.com>
References: <20220404225058.32475-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1649112662-vqgomUADLNrx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

It would be good to know of events that firmware is sending that
the driver does not currently handle.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c3c93338d56a..272b107b7e91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -820,6 +820,7 @@ enum {
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
 	MCU_EXT_EVENT_MURU_CTRL = 0x9f,
+	MCU_EXT_EVENT_IGMP_FLOODING = 0xBD, /* Seen on 7915 */
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d09cf89c4505..83af8e2ca95f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -487,7 +487,13 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	case MCU_EXT_EVENT_BCC_NOTIFY:
 		mt7915_mcu_rx_bcc_notify(dev, skb);
 		break;
+	case MCU_EXT_EVENT_IGMP_FLOODING:
+	case MCU_EXT_EVENT_PS_SYNC:
+		/* ignore some we know we do not care about */
+		break;
 	default:
+		/* in SDK, grep for EventExtEventHandler */
+		dev_info(dev->mt76.dev, "mt7915, unhandled rx_ext_event: 0x%x", rxd->ext_eid);
 		break;
 	}
 }
@@ -502,6 +508,7 @@ mt7915_mcu_rx_unsolicited_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt7915_mcu_rx_ext_event(dev, skb);
 		break;
 	default:
+		dev_info(dev->mt76.dev, "mt7915, unhandled unsolicited event: 0x%x", rxd->eid);
 		break;
 	}
 	dev_kfree_skb(skb);
@@ -2090,7 +2097,7 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 	case PATCH_NOT_DL_SEM_SUCCESS:
 		break;
 	default:
-		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
+		dev_err(dev->mt76.dev, "Failed to get patch semaphore: %d", sem);
 		return -EAGAIN;
 	}
 
@@ -2530,8 +2537,11 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	}
 
 	ret = mt7915_load_firmware(dev);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mcu-init: Failed to load firmware, err: %d",
+			 ret);
 		return ret;
+	}
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
-- 
2.20.1

