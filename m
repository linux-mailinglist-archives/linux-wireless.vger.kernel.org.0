Return-Path: <linux-wireless+bounces-3954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F625860FB5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F171F22B2D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D3823C2;
	Fri, 23 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rSoImGCy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC6657CB
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684830; cv=none; b=l5Pg3bOKG5ILsdn/gmAGYMCH0C2PjkkFQJG2FZCuWwdt8v6F6qSzmsAQ9f8b2GBHgjPLDZgvksJyREbE9rW7BAcXsZDTyYBH/OKt1S9kBHv9e74ltG1Q7qHzIi/WIHgAJT7Iw9B5sgD66n7a80388BNjU93Pp3+a74f1XXthwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684830; c=relaxed/simple;
	bh=N9Ha5VP2I+HePfF7aTlALEIoCR4QFJDljzyfSp7aYWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvHI5Rep0s8wHUHoUdfIprIwrh7dOMW1U2DhiGPklyrHVXr5D2qjSWZCNpLXXMeX5Zkm+HSmzbnvxhUepmokFN6LjMjuxTPkh5uVrQbsEEWt09Cbdf36IC2jAt5UshfHl45ixAJU1byKD2rnALmpq/VBfWj7wuP79SLE1lT1gDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rSoImGCy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q6WJgDIUltkG8ruQDkYSpdMVic8dXTqLITH614bSoo4=;
	t=1708684828; x=1709894428; b=rSoImGCydEUyCJyeSxU76pC4xo7j3Mm4OMHg3piDn5ISODN
	f+FGOFsCNK2PFDMQw84yCYcJkM1S0ylnrUWx2X0Au3VoUV7hWMcftyChguy3Dnv9yau0BKDPtZfvm
	TVNuGg8k2Q5f+Sfuwb31s12OBP65C76CAS7uCDLSKIojMhfRfvhvSF/EZpfhFoCew70yYkhkECcx4
	3Cy4Op1EwQlnSyJoeFkSBOFosiXYFcAEi3U6QUqEgkSel5BRbiQBRqnMaf1YbLchJzmfdHx7WZh1o
	f3iYImZ4x0Tq2HDlovWcLoWAUJDEzxvVLrbgqJ+rOoFfM205fRMR93zsdGzuK58w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSyf-000000051om-3QZR;
	Fri, 23 Feb 2024 11:40:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] wifi: brcmsmac: silence sparse warnings
Date: Fri, 23 Feb 2024 11:40:24 +0100
Message-ID: <20240223114023.06e5ade90bcd.I41a0cbae1fa259cfbf5fa117ddfce908877475a2@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

sparse complains on this code about casts that lose bits
due to the usage of bitwise not, but really we do want
16 bits only, so clarify that by using masks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    |  2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c      | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 7717eb85a1db..aae2cf95fe95 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -3299,7 +3299,7 @@ wlc_lcnphy_run_samples(struct brcms_phy *pi,
 
 	if (iqcalmode) {
 
-		and_phy_reg(pi, 0x453, (u16) ~(0x1 << 15));
+		and_phy_reg(pi, 0x453, 0xffff & ~(0x1 << 15));
 		or_phy_reg(pi, 0x453, (0x1 << 15));
 	} else {
 		write_phy_reg(pi, 0x63f, 1);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 8580a2754789..ffa4b7c5ed25 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -17587,7 +17587,7 @@ static void wlc_phy_txpwrctrl_pwr_setup_nphy(struct brcms_phy *pi)
 	or_phy_reg(pi, 0x122, (0x1 << 0));
 
 	if (NREV_GE(pi->pubpi.phy_rev, 3))
-		and_phy_reg(pi, 0x1e7, (u16) (~(0x1 << 15)));
+		and_phy_reg(pi, 0x1e7, 0x7fff);
 	else
 		or_phy_reg(pi, 0x1e7, (0x1 << 15));
 
@@ -18086,7 +18086,7 @@ wlc_phy_rfctrlintc_override_nphy(struct brcms_phy *pi, u8 field, u16 value,
 						   (0x1 << 10));
 
 					and_phy_reg(pi, 0x2ff, (u16)
-						    ~(0x3 << 14));
+						    0xffff & ~(0x3 << 14));
 					or_phy_reg(pi, 0x2ff, (0x1 << 13));
 					or_phy_reg(pi, 0x2ff, (0x1 << 0));
 				} else {
@@ -21053,7 +21053,7 @@ wlc_phy_chanspec_nphy_setup(struct brcms_phy *pi, u16 chanspec,
 		      (val | MAC_PHY_FORCE_CLK));
 
 		and_phy_reg(pi, (NPHY_TO_BPHY_OFF + BPHY_BB_CONFIG),
-			    (u16) (~(BBCFG_RESETCCA | BBCFG_RESETRX)));
+			    0xffff & ~(BBCFG_RESETCCA | BBCFG_RESETRX));
 
 		bcma_write16(pi->d11core, D11REGOFFS(psm_phy_hdr_param), val);
 	}
@@ -21287,7 +21287,8 @@ void wlc_phy_antsel_init(struct brcms_phy_pub *ppi, bool lut_init)
 
 		bcma_set16(pi->d11core, D11REGOFFS(psm_gpio_oe), mask);
 
-		bcma_mask16(pi->d11core, D11REGOFFS(psm_gpio_out), ~mask);
+		bcma_mask16(pi->d11core, D11REGOFFS(psm_gpio_out),
+			    0xffff & ~mask);
 
 		if (lut_init) {
 			write_phy_reg(pi, 0xf8, 0x02d8);
@@ -23197,7 +23198,7 @@ void wlc_phy_stopplayback_nphy(struct brcms_phy *pi)
 		or_phy_reg(pi, 0xc3, NPHY_sampleCmd_STOP);
 	else if (playback_status & 0x2)
 		and_phy_reg(pi, 0xc2,
-			    (u16) ~NPHY_iqloCalCmdGctl_IQLO_CAL_EN);
+			    0xffff & ~NPHY_iqloCalCmdGctl_IQLO_CAL_EN);
 
 	and_phy_reg(pi, 0xc3, (u16) ~(0x1 << 2));
 
@@ -28202,8 +28203,9 @@ void wlc_phy_txpwrctrl_enable_nphy(struct brcms_phy *pi, u8 ctrl_type)
 
 		if (NREV_GE(pi->pubpi.phy_rev, 3))
 			and_phy_reg(pi, 0x1e7,
-				    (u16) (~((0x1 << 15) |
-					     (0x1 << 14) | (0x1 << 13))));
+				    0xffff & ~((0x1 << 15) |
+					       (0x1 << 14) |
+					       (0x1 << 13)));
 		else
 			and_phy_reg(pi, 0x1e7,
 				    (u16) (~((0x1 << 14) | (0x1 << 13))));
-- 
2.43.2


