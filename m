Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D113E58100
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0K6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 06:58:05 -0400
Received: from nbd.name ([46.4.11.11]:48852 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0K6D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 06:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/MwxVOHgiVTuJJ92lwSkiimsNyasKIgZ2KIpXJJKW7U=; b=NwhNlEJstTNdTgMZFpUVCfA8Uk
        qbzqS5CjN7aW8xGINyTK/eSzYc5OVvqzyVGQiQ+5y/PA/K4MvcRHN5oiJwIVSXNcgCt1b38cUP7Ql
        2EYha0F6YOvJuopMyxxB1G5JdGaLwNSy9Cd7NPEt8kfYskxtE9VCSuM9FHcJjOm+BpIE=;
Received: from p54ae90fe.dip0.t-ipconnect.de ([84.174.144.254] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hgS6M-0006rg-BU
        for linux-wireless@vger.kernel.org; Thu, 27 Jun 2019 12:58:02 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id BB32360843B6; Thu, 27 Jun 2019 12:58:01 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/4] mt76: mt7603: fix reading target tx power from eeprom
Date:   Thu, 27 Jun 2019 12:58:01 +0200
Message-Id: <20190627105801.64145-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607164355.51876-1-nbd@nbd.name>
References: <20190607164355.51876-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the external PA (TSSI OFF) case, the target power needs to be read
from a different location in EEPROM

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2:
 - fix patch prefix
 - limit change to mt7603 (mt7628 does not have this eeprom field)

 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
index f27b99b7e359..b893facfba48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
@@ -69,6 +69,8 @@ enum mt7603_eeprom_field {
 
 	MT_EE_CP_FT_VERSION =			0x0f0,
 
+	MT_EE_TX_POWER_TSSI_OFF =		0x0f2,
+
 	MT_EE_XTAL_FREQ_OFFSET =		0x0f4,
 	MT_EE_XTAL_TRIM_2_COMP =		0x0f5,
 	MT_EE_XTAL_TRIM_3_COMP =		0x0f6,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 4e269044f8a4..43baad7fd082 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -465,9 +465,13 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	u8 *eeprom = (u8 *)dev->mt76.eeprom.data;
 	int target_power = eeprom[MT_EE_TX_POWER_0_START_2G + 2] & ~BIT(7);
 	u8 *rate_power = &eeprom[MT_EE_TX_POWER_CCK];
+	bool ext_pa = eeprom[MT_EE_NIC_CONF_0 + 1] & BIT(1);
 	int max_offset, cur_offset;
 	int i;
 
+	if (ext_pa && is_mt7603(dev))
+		target_power = eeprom[MT_EE_TX_POWER_TSSI_OFF] & ~BIT(7);
+
 	if (target_power & BIT(6))
 		target_power = -(target_power & GENMASK(5, 0));
 
-- 
2.17.0

