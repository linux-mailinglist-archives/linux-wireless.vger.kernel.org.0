Return-Path: <linux-wireless+bounces-14633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A77A9B48C8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BF2B22DD0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5F205E1A;
	Tue, 29 Oct 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="A69ElzQa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DE205AD9
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202963; cv=none; b=NYRpEcQE6My3W2bNS5FbncrHZ61tR9M+pHLi+c2BATHx79oczYFK1poDwI06c8ajOE40BuSMAjCWTaAG9H93jjaX9O2I+AE1Zt+TLPPgBBVH2q7FzAqAxby7MEMDb44X8/MHW8WfpK4PBUNAqFrg/TwAOOEbGRdzuAV+nqVTn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202963; c=relaxed/simple;
	bh=tM4zTcYylN22EeDy6q+ZcO+lrYdW42sEhSCB3DWYfY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSmEaXaaCWayBSvBWEX7FMgpTjSEYgh29tq5sht/KJlFjxryOKepIM6l+M5crJqNxWTsdOz+fMDnT0Rui60jcUMo8PwBZByLPOMeH5wXy9K2OfJVEQ5QBSzJKTZgFpHHSWEdKccbORkEYFaM9KHlh3k25yMgKlGLH5HsECF4QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=A69ElzQa; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id 3EC2C699E9
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 14:49:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c110:0:640:2b5b:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id BE98E60E2D;
	Tue, 29 Oct 2024 14:49:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bnXHPp9XlGk0-aIYiTiJz;
	Tue, 29 Oct 2024 14:49:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730202578; bh=EGoRCJpDANAblBKUial/HJdHUrC3OLZ0+gCYr5JqCpw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=A69ElzQapZETwFGFeG+EYEf87vpYlGW+TDYBIkdO5zKMi3LZE0gFh3X1y3qBQYHIA
	 o0Bob51V3pfwrtXdOQR9ja9HNMmz44cSpTf9FL7WL0SI2Lxz3+QGKAOv6O77xVIERf
	 5TbTXpUuUrCcy9mQjlZOn7H4qUVHGgJDDZzwkIrE=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmsmac: simplify wlc_phy_rxcal_radio_setup_nphy()
Date: Tue, 29 Oct 2024 14:49:12 +0300
Message-ID: <20241029114912.1534179-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'tx_rx_cal_radio_saveregs[]' of 'struct brcms_phy' is 'u16',
'pi->tx_rx_cal_radio_saveregs[2] & 0xF0) >> 8' is always zero, so
a few duplicated snippets in 'wlc_phy_rxcal_radio_setup_nphy()'
may be reduced to compile-time constant (in fact, the same thing is
actually done by both gcc and clang I've tried). Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   | 44 ++-----------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d69879e1bd87..48343c820422 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -26201,7 +26201,6 @@ static void wlc_phy_calc_rx_iq_comp_nphy(struct brcms_phy *pi, u8 core_mask)
 
 static void wlc_phy_rxcal_radio_setup_nphy(struct brcms_phy *pi, u8 rx_core)
 {
-	u16 offtune_val;
 	u16 bias_g = 0;
 	u16 bias_a = 0;
 
@@ -26322,17 +26321,9 @@ static void wlc_phy_rxcal_radio_setup_nphy(struct brcms_phy *pi, u8 rx_core)
 						read_radio_reg(pi,
 							RADIO_2056_RX_LNAA_TUNE
 							| RADIO_2056_RX0);
-
-					offtune_val =
-						(pi->tx_rx_cal_radio_saveregs
-						 [2] & 0xF0) >> 8;
-					offtune_val =
-						(offtune_val <= 0x7) ? 0xF : 0;
-
 					mod_radio_reg(pi,
 						      RADIO_2056_RX_LNAA_TUNE |
-						      RADIO_2056_RX0, 0xF0,
-						      (offtune_val << 8));
+						      RADIO_2056_RX0, 0xF0, 0xF00);
 				}
 
 				write_radio_reg(pi,
@@ -26372,18 +26363,9 @@ static void wlc_phy_rxcal_radio_setup_nphy(struct brcms_phy *pi, u8 rx_core)
 							pi,
 							RADIO_2056_RX_LNAG_TUNE
 							| RADIO_2056_RX0);
-
-					offtune_val =
-						(pi->
-						 tx_rx_cal_radio_saveregs[2] &
-						 0xF0) >> 8;
-					offtune_val =
-						(offtune_val <= 0x7) ? 0xF : 0;
-
 					mod_radio_reg(pi,
 						      RADIO_2056_RX_LNAG_TUNE |
-						      RADIO_2056_RX0, 0xF0,
-						      (offtune_val << 8));
+						      RADIO_2056_RX0, 0xF0, 0xF00);
 				}
 
 				write_radio_reg(pi,
@@ -26446,18 +26428,9 @@ static void wlc_phy_rxcal_radio_setup_nphy(struct brcms_phy *pi, u8 rx_core)
 							pi,
 							RADIO_2056_RX_LNAA_TUNE
 							| RADIO_2056_RX1);
-
-					offtune_val =
-						(pi->
-						 tx_rx_cal_radio_saveregs[2] &
-						 0xF0) >> 8;
-					offtune_val =
-						(offtune_val <= 0x7) ? 0xF : 0;
-
 					mod_radio_reg(pi,
 						      RADIO_2056_RX_LNAA_TUNE |
-						      RADIO_2056_RX1, 0xF0,
-						      (offtune_val << 8));
+						      RADIO_2056_RX1, 0xF0, 0xF00);
 				}
 
 				write_radio_reg(pi,
@@ -26496,18 +26469,9 @@ static void wlc_phy_rxcal_radio_setup_nphy(struct brcms_phy *pi, u8 rx_core)
 							pi,
 							RADIO_2056_RX_LNAG_TUNE
 							| RADIO_2056_RX1);
-
-					offtune_val =
-						(pi->
-						 tx_rx_cal_radio_saveregs[2] &
-						 0xF0) >> 8;
-					offtune_val =
-						(offtune_val <= 0x7) ? 0xF : 0;
-
 					mod_radio_reg(pi,
 						      RADIO_2056_RX_LNAG_TUNE |
-						      RADIO_2056_RX1, 0xF0,
-						      (offtune_val << 8));
+						      RADIO_2056_RX1, 0xF0, 0xF00);
 				}
 
 				write_radio_reg(pi,
-- 
2.47.0


