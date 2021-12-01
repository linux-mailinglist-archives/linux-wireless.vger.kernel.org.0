Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B77464EEC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbhLANnT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 08:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349578AbhLANnT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 08:43:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B84C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 05:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00D38B81ED2
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 13:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1AEC53FAD
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638365995;
        bh=bOwuYeKHv1JxbgO2dxbqBHuuzR2n69bC5jWUYFEuHOw=;
        h=From:To:Subject:Date:From;
        b=J9lL1TWWhq3YFBwOXrBNxUs0CD8HLfTDswvoZjJGHrwBOK7nzurI+e0fRIBzkaFLQ
         920qnGRIZdkV3gKJB2u8vF0/W3OxG10thLaHjptZ+3+UFCAO3sKVFTbyObx2h+SxvH
         ywLMJnoH4LYVaLVTNBhivWX3gLiOWi4KlXZfgaJBajVdX+wXQKTnnKjIukN6dfZXxG
         1Q9HGy3vSa+dVOsv5MlXP/hkJQI4u1FOODyfPZU+x9BCPp6CDUQs3eNsDYwipH4ZCb
         FlxbXbLpmDjlpKJWcjonUmvDMCba/UV7HjwPxRg6ytvrf6Pcboz1blkP2pCTq0pFxO
         kaifiplYhMC2g==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless-drivers] MAINTAINERS: update Kalle Valo's email
Date:   Wed,  1 Dec 2021 15:39:52 +0200
Message-Id: <20211201133952.31744-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I switched to using kvalo@kernel.org, update MAINTAINERS file.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..22bea147c7d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3056,7 +3056,7 @@ F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
 
 ATHEROS ATH GENERIC UTILITIES
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/ath/*
@@ -3071,7 +3071,7 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath5k
 F:	drivers/net/wireless/ath/ath5k/
 
 ATHEROS ATH6KL WIRELESS DRIVER
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath6kl
@@ -13238,7 +13238,7 @@ F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdevice.h
 
 NETWORKING DRIVERS (WIRELESS)
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-wireless/list/
@@ -15694,7 +15694,7 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	ath10k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
@@ -15702,7 +15702,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath10k/
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	ath11k@lists.infradead.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
@@ -15866,7 +15866,7 @@ F:	Documentation/devicetree/bindings/media/*venus*
 F:	drivers/media/platform/qcom/venus/
 
 QUALCOMM WCN36XX WIRELESS DRIVER
-M:	Kalle Valo <kvalo@codeaurora.org>
+M:	Kalle Valo <kvalo@kernel.org>
 L:	wcn36xx@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
-- 
2.20.1

