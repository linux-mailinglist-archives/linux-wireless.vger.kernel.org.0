Return-Path: <linux-wireless+bounces-19826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB4A50B4E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 20:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BB3188DE06
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A11DD9AC;
	Wed,  5 Mar 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lGFmSdAJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39591624F1
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202290; cv=none; b=c0gqSC8Uki0zszTJbxTnxQqcxAw2UHF8qxP0woI7Ik5qR5SzhrdlD9yIihiKzUwgMd/WjveJR84a8QzoppwZNsAi5B9SqjS2IAW16nrpU4xbknge0AZO2ELE0vPuKn4Kg3bvOIOx0T4DgCzI3GGMrut+RCA+NLJnNU7qg+qbh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202290; c=relaxed/simple;
	bh=BTWmtU6zyrT2KAkwgGiiCQzFKOM04JNCZmwPt1NRIDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIcuC2GLKOzCwPD8n+o37iRVWoTPHn/MpNAkePU+sjtON8LnemyXtvHcXXGQGnpwUS4Uj90U8j9i7Hw/BCFXByJiEYYWpwhigr+h8YRrxob62w7QEET1JkOshAyIvYvLxwSkIGkXnOtVi+BAhLbw1waWWZ4dUEwby4qIMken53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lGFmSdAJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=PU5jSbHmJJCQaOEGoIK5m2zB5Rq98dPYJ1+cYcZyM58=; t=1741202288; x=1742411888; 
	b=lGFmSdAJWSaJXxNuEQM12iux++GxUvQuCW43Th6dFJgx59xaaVz3CShkvBT9xPAwWoUapyOGew+
	Mazp0+tHTqJhfuCkdlOvlpl6gFcLxHn5poeZhkh4Fax3RGqcI9HZKXnTlqRidaSGmmvAWajyZiCZj
	Ucn79Ej+5wuMTvfFaKQ2jrA7EgwLx1/piqjxWhATRsdGQ2t1PVZM7wxa/W6mGwyRY+TJsIU67Lg6d
	bRTAkuI99O5hcTtMXsGLVYZR9PjZXVphF9IOXRhZ/Dun3cB46z7oALqU0pQTze06HQkXu06CZelXE
	vEmaHHcGI/RnSJZswKHJ+tVW0/kgfr6MiAZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpuFk-00000001xWf-2KU3;
	Wed, 05 Mar 2025 20:18:00 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: rework MAINTAINERS entries a bit
Date: Wed,  5 Mar 2025 20:17:48 +0100
Message-ID: <20250305201757.6abf00e86ed4.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
X-Mailer: git-send-email 2.48.1
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

Since I really don't want to be CC'ed on every patch
add X: entries for all the drivers that are otherwise
covered. In some cases, add a bit more to drivers that
have other entries, mostly for the vendor directories,
but for libertas also add libertas_tf.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 MAINTAINERS | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7078199fcebf..4189f59ee89d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,7 +514,7 @@ F:	drivers/hwmon/adm1029.c
 ADM8211 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/admtek/adm8211.*
+F:	drivers/net/wireless/admtek/
 
 ADP1050 HARDWARE MONITOR DRIVER
 M:	Radu Sabau <radu.sabau@analog.com>
@@ -6195,7 +6195,7 @@ F:	Documentation/process/cve.rst
 
 CW1200 WLAN driver
 S:	Orphan
-F:	drivers/net/wireless/st/cw1200/
+F:	drivers/net/wireless/st/
 F:	include/linux/platform_data/net-cw1200.h
 
 CX18 VIDEO4LINUX DRIVER
@@ -13984,6 +13984,7 @@ MARVELL LIBERTAS WIRELESS DRIVER
 L:	libertas-dev@lists.infradead.org
 S:	Orphan
 F:	drivers/net/wireless/marvell/libertas/
+F:	drivers/net/wireless/marvell/libertas_tf/
 
 MARVELL MACCHIATOBIN SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
@@ -15653,7 +15654,7 @@ M:	Ajay Singh <ajay.kathat@microchip.com>
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-F:	drivers/net/wireless/microchip/wilc1000/
+F:	drivers/net/wireless/microchip/
 
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
@@ -16439,6 +16440,23 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
 F:	Documentation/devicetree/bindings/net/wireless/
 F:	drivers/net/wireless/
+X:	drivers/net/wireless/ath/
+X:	drivers/net/wireless/broadcom/
+X:	drivers/net/wireless/intel/
+X:	drivers/net/wireless/intersil/
+X:	drivers/net/wireless/marvell/
+X:	drivers/net/wireless/mediatek/mt76/
+X:	drivers/net/wireless/mediatek/mt7601u/
+X:	drivers/net/wireless/microchip/
+X:	drivers/net/wireless/purelifi/
+X:	drivers/net/wireless/quantenna/
+X:	drivers/net/wireless/ralink/
+X:	drivers/net/wireless/realtek/
+X:	drivers/net/wireless/rsi/
+X:	drivers/net/wireless/silabs/
+X:	drivers/net/wireless/st/
+X:	drivers/net/wireless/ti/
+X:	drivers/net/wireless/zydas/
 
 NETWORKING [DSA]
 M:	Andrew Lunn <andrew@lunn.ch>
@@ -17823,7 +17841,7 @@ M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
-F:	drivers/net/wireless/intersil/p54/
+F:	drivers/net/wireless/intersil/
 
 PACKET SOCKETS
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
@@ -19100,7 +19118,7 @@ PURELIFI PLFXLC DRIVER
 M:	Srinivasan Raju <srini.raju@purelifi.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-F:	drivers/net/wireless/purelifi/plfxlc/
+F:	drivers/net/wireless/purelifi/
 
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
@@ -19651,7 +19669,7 @@ M:	Igor Mitsyanko <imitsyanko@quantenna.com>
 R:	Sergey Matyukevich <geomatsi@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-F:	drivers/net/wireless/quantenna
+F:	drivers/net/wireless/quantenna/
 
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
@@ -19732,7 +19750,7 @@ RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-F:	drivers/net/wireless/ralink/rt2x00/
+F:	drivers/net/wireless/ralink/
 
 RAMDISK RAM BLOCK DEVICE DRIVER
 M:	Jens Axboe <axboe@kernel.dk>
@@ -21699,7 +21717,7 @@ SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
-F:	drivers/net/wireless/silabs/wfx/
+F:	drivers/net/wireless/silabs/
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
@@ -26199,7 +26217,7 @@ F:	mm/zbud.c
 ZD1211RW WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/zydas/zd1211rw/
+F:	drivers/net/wireless/zydas/
 
 ZD1301 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
-- 
2.48.1


