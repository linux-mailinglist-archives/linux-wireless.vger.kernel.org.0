Return-Path: <linux-wireless+bounces-14730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C89B61EE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2937B21908
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44101D0E30;
	Wed, 30 Oct 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kHzZDsQV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7701E00B6
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288092; cv=none; b=UGhwM/HKi3y60MWGRaR6FHTZ+ifGfOE8aa0kx1ceua5nWAmJdan0t1o3uInEjAgmAmJH0xZ8hnn6pFOMB54qeHLSW8Bs+9Cx4mq+c6ntw+9rc1SUabw7Jr6nFoFiA84AywbMjwMvoIJctcOyVz3KP5tTz1sNxFkiNOH8lKKbHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288092; c=relaxed/simple;
	bh=Tx86j+ghzz1Z1vefFa0YQe2v9AuCMV+SXCDvs2WBvvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8KvCA1JI0QafW5wIcbHOAPLxanvYnZ2FgQclJoLrmkBEQCPstk8S8G8ouUhfYIuDZQX8d74YYy2In8MTAxgZqDbZ2VNo1kFaxZ0Sxt1UNmkH/9qtQ6OtAiydpkxexMGwWFaujHeCTVwOBhlOAQCRYGZo4/pTRD9P34xlSZVaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kHzZDsQV; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:26a5:0:640:547b:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 9502860B51;
	Wed, 30 Oct 2024 14:34:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dYYqOq9uC0U0-joQRjnqu;
	Wed, 30 Oct 2024 14:34:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730288079; bh=0ef3xcMVzAhyaenH6ryh2sUkPJGj2rs/xCUo5kF/5qQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=kHzZDsQVzdUy0WpRRgg5TcKi70NRf1PvkjwsYw6IpsLfetzJpeGbHhGbavllMpsGY
	 KIbvautsSwS5T/BtbvjjI3ee5Qu31vdV5ziKAft4jLXntz5CIcoXvkPGk8rx15g4Ev
	 +aQiKxPL/d2Q6r0w3sWzfC4sziLscsaef8Q3ZRV0=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Colin King <colin.i.king@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: brcmsmac: simplify wlc_phy_rxcal_radio_setup_nphy()
Date: Wed, 30 Oct 2024 14:34:17 +0300
Message-ID: <20241030113417.375847-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <706a7971-71c1-4847-9c62-f9033557f746@broadcom.com>
References: <706a7971-71c1-4847-9c62-f9033557f746@broadcom.com>
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

Reported-by: Colin King <colin.i.king@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add Reported-by: as suggested by Arend
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


