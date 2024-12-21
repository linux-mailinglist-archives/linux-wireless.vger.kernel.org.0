Return-Path: <linux-wireless+bounces-16697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68239FA0AC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AD71692DD
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F21F63FE;
	Sat, 21 Dec 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="jtF5jGcg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B91F5413;
	Sat, 21 Dec 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734785117; cv=none; b=Dmwe/U7L/TCKN9Zbun2bCKGpzp52AhcgOQfAzFgq5E8Ft3wEhl6yEOptjdyoxggbn76i9vTlZNd/RkKVTVWd3ABcSPae40Uis8uxexODiydFAu8QY0RZjWWfJD7WDWpqHZuRBjCsdCAuM1dv2lkUn6kv5RRY/CofCJwZqydkDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734785117; c=relaxed/simple;
	bh=4pfXzaNicloRk6U2loxPl1hGit+I3B3JF1vTGR1gG9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKlY0WFVwY6x16IvOqDtAcs/M95UKj4MiJWtG+W2ix6fEo4VcEFqUWz3Znm5CvOFwGhzlOCr+RiJG4PBUO8J8rltdrJdSX1Xhttsy2whoppK9zquXb8ueeG0rI5KYcEOcALr9N3ymYkgPYXf4a+hH30llCra9oWO/Kbi5K+KRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=jtF5jGcg; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734785115; x=1766321115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pfXzaNicloRk6U2loxPl1hGit+I3B3JF1vTGR1gG9Y=;
  b=jtF5jGcgPwIFQ+zsEeY/++6apjTSxGV5EUqZg0ZH1cISyX9/4UeYSsPj
   y4o5HuXTxy1iw0xWTuAcqeRFV1sm8RhzdHhzNbkRe8WWmG8zW/aJc6f/6
   RgZoQCapgVJtBWJyjorEckgNfl03OfPDZRk+m/dI2OAby+gO5EPv85+8K
   U=;
X-CSE-ConnectionGUID: 6Pg5Bo/0SgeKQpU0WyM1tg==
X-CSE-MsgGUID: 2DLvzNl9SJ+ZWKDFtz/Yiw==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28286108"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 13:45:14 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id D7DE32514;
	Sat, 21 Dec 2024 13:45:13 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/2] net/phy,neterion: Remove dead values
Date: Sat, 21 Dec 2024 13:39:33 +0100
Message-ID: <20241221124445.1094460-3-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity-ID: 1269173, 1575053
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 drivers/net/ethernet/neterion/s2io.c     | 2 --
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index f8016dc25e0a..4f89f9fd8043 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -1969,8 +1969,6 @@ static void en_dis_err_alarms(struct s2io_nic *nic, u16 mask, int flag)
 				   MC_ERR_REG_ECC_ALL_DBL | PLL_LOCK_N, flag,
 				   &bar0->mc_err_mask);
 	}
-	nic->general_int_mask = gen_int_mask;
-
 	/* Remove this line when alarm interrupts are enabled */
 	nic->general_int_mask = 0;
 }
diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 550ef08970f4..e15ab9ba2f50 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -818,7 +818,6 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
 	u32 cfg = 0;
 
 	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &cfg);
-	cfg &= ~MACSEC_RXSC_CFG_VF_MASK;
 	cfg = phy_secy->secy->validate_frames << MACSEC_RXSC_CFG_VF_OFF;
 
 	phydev_dbg(phydev, "validate frames %u\n",
-- 
2.47.1


