Return-Path: <linux-wireless+bounces-20956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB80A757E1
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 22:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ED93ACC10
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA63185935;
	Sat, 29 Mar 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TyQrnOMh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17371F956
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743282108; cv=none; b=Mv9AYukZYVUXB+D/B5N8JOIRUWRf1Sbp6QwpTl1OeRZoeMUpDR+9PVi8fPih8sWYp3pvRbgycH1VrIYNjAZkhRNU7d3SolF1W9H1nku2qx+us4Rp8ajbgNHNI5yblvz1rU14ifqrLL8DshQR+C05nWFf2dJW5xjf0Dd8pXSthYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743282108; c=relaxed/simple;
	bh=vmzFgUkcTcGf8NA+QAtEMvyMd2bU/8iWC7n/Bt7HfEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7PQ8BUe1Z5FKPRadSw3lRilfQ6p2GV3Y6m+Ewi8/NzpICJBndY6ro3Ke2n3LOj+ZFL8FLba4Io2m/GevSFSLd/uWnFtje16ruRAPadnwTb7Un7g1h2chcf8XbRFOQO8pO8yCOaYtcHi3DDeLqky66L54sQXB9EGRHJuM95dEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TyQrnOMh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=w/QN/utgBlPqOAqAp2qj8RkbwdQbcmD3gEzu7sTYQ/E=; t=1743282106; x=1744491706; 
	b=TyQrnOMh88/GLxFIEAg1S6Uh8V0FU2QRJJWRdNikLB5QtG4kgNattHPmg/K1i2YVoTA3yYTFztw
	JX7dqRMEOj4xdiesAYPKTufnAfta61S8ZBpin18bUgIpsU2hre1YbvZ2WDtW0L/uHMTyUv/ygmr6Y
	6NwNyWRXn0ww7M15s6J+hwj8u524pdfLNpoF5xq7PTQtZ8UDIEUyJ6HMWuGMU4kT11J0be3xHPvxA
	UzJaB1wn5aPxfJ+7p5gWdQe6u3vqjXSgrYAv5Blyui9JOSFUBTO0WQlOs2lMQpohM1jdPOEHQqUW+
	Shsthn0eCrzkvqv9mn0D0cCjX1XuuVsliwng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tydJB-00000009Ujy-2IFP;
	Sat, 29 Mar 2025 22:01:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: add wireless list to MAINTAINERS
Date: Sat, 29 Mar 2025 22:01:34 +0100
Message-ID: <20250329220135.8bfaffbad97d.I946354c2395f4a30b8c435857a92553b1b58df5b@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Johannes Berg <johannes.berg@intel.com>

Add the wireless list to MAINTAINERS entries for all
those drivers that are no longer covered by the entry
now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d19627afa652..f400f10de489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6208,6 +6208,7 @@ F:	Documentation/process/cve.rst
 
 CW1200 WLAN driver
 S:	Orphan
+L:	linux-wireless@vger.kernel.org
 F:	drivers/net/wireless/st/
 F:	include/linux/platform_data/net-cw1200.h
 
@@ -13995,6 +13996,7 @@ S:	Odd fixes
 F:	drivers/net/ethernet/marvell/sk*
 
 MARVELL LIBERTAS WIRELESS DRIVER
+L:	linux-wireless@vger.kernel.org
 L:	libertas-dev@lists.infradead.org
 S:	Orphan
 F:	drivers/net/wireless/marvell/libertas/
@@ -19388,6 +19390,7 @@ F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATH12K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
+L:	linux-wireless@vger.kernel.org
 L:	ath12k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath12k
@@ -19397,6 +19400,7 @@ N:	ath12k
 
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
+L:	linux-wireless@vger.kernel.org
 L:	ath10k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
@@ -19406,6 +19410,7 @@ N:	ath10k
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
+L:	linux-wireless@vger.kernel.org
 L:	ath11k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k
@@ -21727,6 +21732,7 @@ F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
 F:	drivers/net/wireless/silabs/
-- 
2.49.0


