Return-Path: <linux-wireless+bounces-31419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPBVIGo9fmk6WgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 18:35:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21AC3496
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 18:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BC40300A314
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EA35BDA7;
	Sat, 31 Jan 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="gsaDFw7C";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="W/pI+f5Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cvsmtppost106.wmail.worksmobile.com (cvsmtppost106.wmail.worksmobile.com [125.209.209.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC1364056
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880851; cv=none; b=g69KoTfJgdNyJEHNZy8riun48qUkhno68gJRxNTiIt4XT4o/GCuqQtUq0Q7xO/SbsGkXxrQpePPDqV+ErqnHSmDHvdaTBFGd2iQAtyD3vafldS2U4ogy0Si9WSeSEJ6+4Q3c5g1jI5v8MSqlZ/HeUtBkAHZGWMZDeme3vLwXl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880851; c=relaxed/simple;
	bh=h0BHEf3EUV2XoZUux+VQ9dvTNp8V8LICsw0jUbT9E/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxG/CyNnRmEfT3M5bKWXvXZNVjubDhyn4e07/+7FaCLE84R/0BcRphlv7l6XR2R9tlVCKVqyMTYp6OAW420h6PcDtq9/AhvEXMhOn7Nt148itVRdubwo/O2mbHKdQd8X836pRrDid9y8u327iJTNlvj2jTtmFzBCBSwL1dMYpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=gsaDFw7C; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=W/pI+f5Y; arc=none smtp.client-ip=125.209.209.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769880237;
	bh=h0BHEf3EUV2XoZUux+VQ9dvTNp8V8LICsw0jUbT9E/E=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=gsaDFw7C2mQxqsB5sr/SbPw7BD63OZAuVrergK5MTJ6XAvvyQgx7YEhitgD2vihSW
	 f27mxjhkAriu8MU7XeYqsPc7tCCwflqZqMQLrdqpWz2Rr870H0+oIDcKgsK8TmoXMw
	 VAr4az0NZ8BSnosOGhwaT7grhOYpxwy59x3cvn00BurWuM08VncuC7oRXGLhJ/D0HJ
	 w5aviLQKDrZInL7OY3gZcyTfcgAAjlHBJto2PQd62rzzyh1Dxz2ZA1Bgob6Yvj8N9p
	 USMGwWEn1ecbgVzeRlp1W8s4Ui2l5JwbqUnC0fA51zpQTM0nsHC0vvFJnqFMUSIA+A
	 i5LynD1sMyvQg==
Received: from cvsendbo003.wmail ([10.113.20.165])
  by cvsmtppost106.wmail.worksmobile.com with ESMTP id 5c9rIlrZQyOiuHhcH2HE+Q
  for <linux-wireless@vger.kernel.org>;
  Sat, 31 Jan 2026 17:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769880237;
	bh=h0BHEf3EUV2XoZUux+VQ9dvTNp8V8LICsw0jUbT9E/E=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=W/pI+f5Yh9HQwZWjwUdlvNw5BP0pbZZhnu8UvCgKkdymnK/TMYgUq/P7T9ajSEPIS
	 GsA6GJXVZrXw0ttNfAommFfJ6LALbGiKM3+GCctAN+4IDXYwTbYXIcYyVQePL4dE5p
	 IIInfq/BMsE9/8VZZXHiIWWN7vxUNGymGuAh64MU=
X-Session-ID: 1W-InNWnSW2Nn+Ds4VGMFQ
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: A9bdaAvrFqJZ+HmXKq2X+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp402.gwmail.worksmobile.com with ESMTP id 1W-InNWnSW2Nn+Ds4VGMFQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 17:23:57 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: linux-wireless@vger.kernel.org
Cc: arend.vanspriel@broadcom.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH] wifi: brcmsmac: phy: Remove unreachable error handling code
Date: Sun,  1 Feb 2026 02:23:55 +0900
Message-Id: <20260131172355.3367673-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31419-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,worksmobile.com:dkim]
X-Rspamd-Queue-Id: BF21AC3496
X-Rspamd-Action: no action

wlc_phy_txpwr_srom_read_lcnphy() in wlc_phy_attach_lcnphy() always
returns true, making the error handling code unreachable. Change the
function's return type to void and remove the dead code, similar to
the cleanup done for wlc_phy_txpwr_srom_read_nphy() in commit
47f0e32ffe4e ("wifi: brcmsmac: phy: Remove unreachable code").

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 .../wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c   | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index b4bba67a45ec3..5258681218ea9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -4790,7 +4790,7 @@ void wlc_phy_init_lcnphy(struct brcms_phy *pi)
 	wlc_lcnphy_calib_modes(pi, PHY_PERICAL_PHYINIT);
 }
 
-static bool wlc_phy_txpwr_srom_read_lcnphy(struct brcms_phy *pi)
+static void wlc_phy_txpwr_srom_read_lcnphy(struct brcms_phy *pi)
 {
 	s8 txpwr = 0;
 	int i;
@@ -4879,8 +4879,6 @@ static bool wlc_phy_txpwr_srom_read_lcnphy(struct brcms_phy *pi)
 				sprom->ant_available_bg);
 	}
 	pi_lcn->lcnphy_cck_dig_filt_type = -1;
-
-	return true;
 }
 
 void wlc_2064_vco_cal(struct brcms_phy *pi)
@@ -4992,10 +4990,7 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
 	pi->pi_fptr.radioloftget = wlc_lcnphy_get_radio_loft;
 	pi->pi_fptr.detach = wlc_phy_detach_lcnphy;
 
-	if (!wlc_phy_txpwr_srom_read_lcnphy(pi)) {
-		kfree(pi->u.pi_lcnphy);
-		return false;
-	}
+	wlc_phy_txpwr_srom_read_lcnphy(pi);
 
 	if (LCNREV_IS(pi->pubpi.phy_rev, 1)) {
 		if (pi_lcn->lcnphy_tempsense_option == 3) {
-- 
2.34.1


