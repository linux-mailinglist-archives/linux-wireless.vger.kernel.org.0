Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6C14DD0D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgA3OrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:21 -0500
Received: from nbd.name ([46.4.11.11]:57430 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3OrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5tk146jQyqnisMeGnMOXsOPJB93TPSOgI0hpv6crZbU=; b=grJ5AlUCmpqmyl96au3JdQHUMS
        oD6QUghNi448w6pg3tCH9lI4sDsq9Nr9FqwfmDvkM6PTyi1nstbnJ/BgFRjiUr60sroVv4l2yGYjR
        zzT8CJ9OOtJ5O3q6pC8T8KONS32NvELmJzjKoJXhKeRP4DzOvk15hsTpyLxFv87JMo6A=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6F-0001VK-Kd
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id E69027AE4689; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 15/15] mt76: mt7615: add Kconfig entry for MT7622
Date:   Thu, 30 Jan 2020 15:47:18 +0100
Message-Id: <20200130144718.14298-15-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This enables building support for the MT7622 SoC built-in WLAN chip

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 4cabba9aa2ea..6afd4aea67ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -11,3 +11,14 @@ config MT7615E
 	  MU-MIMO up to 4 users/group and 160MHz channels.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7622_WMAC
+	bool "MT7622 (SoC) WMAC support"
+	depends on MT7615E
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select REGMAP
+	default y
+	help
+	  This adds support for the built-in WMAC on MT7622 SoC devices
+	  which has the same feature set as a MT7615, but limited to
+	  2.4 GHz only.
-- 
2.24.0

