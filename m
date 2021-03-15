Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51C33AD40
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCOIVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 04:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhCOIVQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D259864E83;
        Mon, 15 Mar 2021 08:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615796475;
        bh=PR6aL0f4ogbTkE1LJmwiBefnLpwn6NhqcxNI9uJ9vBs=;
        h=From:To:Cc:Subject:Date:From;
        b=ueUA/3Ru9kvX4ujmQnHHvUlB9PwfggeJxGua6gCk4RG50xyVfs2OitcZaEL8+DbQr
         ldNLUglrPCaeVCImye27HyATXKhKc+0R2eafzSm3n8xo1co4uHNknHdNuFC+LPzSRn
         Llc1ulPoqGp0XF0BGrDzNNY8vEhXGdblffYP1dMj1eQzmwxlOaN60o6Yx7vv9uCu0H
         KMwb5goSHhmcLIj7/+WwGcKn8hzaqYuCunwaD5R5GlUDKWtYbV+6t0vMKzOhhvB+FS
         4oqsncEYUnl++toQPq9VSDice/oFc7z48UjSR15unUcbs5SPk5z4azqFSxQcveyhZD
         gtwcnOCOXZUbw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: remove duplicated macros in mcu.h
Date:   Mon, 15 Mar 2021 09:21:10 +0100
Message-Id: <f62ac649262da522db2dd69d80745ccaef34ffa3.1615796386.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mcu definitions already available in mt76_connac_mcu.h

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index fd67838cb565..af8b42983a00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -177,25 +177,6 @@ enum {
 	MCU_PHY_STATE_OFDMLQ_CNINFO,
 };
 
-#define STA_TYPE_STA			BIT(0)
-#define STA_TYPE_AP			BIT(1)
-#define STA_TYPE_ADHOC			BIT(2)
-#define STA_TYPE_WDS			BIT(4)
-#define STA_TYPE_BC			BIT(5)
-
-#define NETWORK_INFRA			BIT(16)
-#define NETWORK_P2P			BIT(17)
-#define NETWORK_IBSS			BIT(18)
-#define NETWORK_WDS			BIT(21)
-
-#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
-#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
-#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
-#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
-#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
-#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
-#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
-
 struct sec_key {
 	u8 cipher_id;
 	u8 cipher_len;
-- 
2.30.2

