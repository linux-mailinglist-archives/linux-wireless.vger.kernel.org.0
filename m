Return-Path: <linux-wireless+bounces-20855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2986A71B2E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C80B172BF5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6671F4622;
	Wed, 26 Mar 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VITi17hg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021471E5218
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004544; cv=none; b=dd0r4SCyB6dJnHY2fHdLlbqG7Xe2yLZ2/pVobp33JhoSzzyV+1P0yWtYdwRVIRLA9qEDKUcSlbDsNShmB/yS1nAlqtK+3HxG9Pe7zjHv4Z/+oxN34sOoCDTzhwoDgSYolvEaHtdLWe8gjxgttoV+wb58Y9MuJ7GYuig2Qm3pIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004544; c=relaxed/simple;
	bh=d6DI9p0q+ycxc2DrnQ5e/KfIt0uGPW0dpVICY5k0wmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ap5Sp3/YTZIkT6HsxOdxQLO6R9LuA146Y5a3nU0pcGoU0ZXj2/6iixXfRQ5D98gyguF3/nsn2sWnLP11r1hDslKPhwuaR9TOOhW3XlR1WgxCOITTJHA/tQ9evgzr2w/SecER8YWgBb9lROGXzFxb9+WqhoD3+PdS8XkhW6lP+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VITi17hg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j69Pnhz4rRIFXKrweFvZzBXUcEhGGcYOm3Cm0yhgZZM=;
	t=1743004543; x=1744214143; b=VITi17hgm3FqupFznsL/96KOY7slq6oIQFEKeXAqP+REI4H
	RKlYHupvWynt/RiDQTQjivHiWHMljirCAAxe3IqOosCecr3oTEAq6DLsVMQb0yAz61U6tKlKnlDae
	sZil+FZiFgrGduvYQ8YvWGL+BdRx5UIN0sxR9mCQ55ZMZVFEqigBMk3cAf5RtLsH2QCPJ699VT0Rl
	r6kpbs/d6dqUq2HzYU1eWyMa/JWn7noh0MqCXkvrQRhYkS4pqn6XxjEhSKGrf0vNQbYtvGDD5vBtO
	tcrgHa/W+2F9QF309agSYDEWg/fyjwsnAqzBZJZ+DiTnT8syDXusuyDUcUnbOA4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1txT6R-00000006I8j-2DL7;
	Wed, 26 Mar 2025 16:55:39 +0100
Message-ID: <6ef5049a68157bae0e121f48afc1d872a25087f7.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] wifi: rework MAINTAINERS entries a bit
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 26 Mar 2025 16:55:38 +0100
In-Reply-To: <085bfa6c-cad5-43cf-9432-811b744da506@oss.qualcomm.com>
References: 
	<20250306092831.f7fdfe7df7b2.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
	 <085bfa6c-cad5-43cf-9432-811b744da506@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-03-26 at 08:49 -0700, Jeff Johnson wrote:
>=20
> This patch has the unfortunate side-effect that get_maintainer.pl (and b4=
) no
> longer add linux-wireless to ath* patches, and hence they no longer show =
up in
> https://patchwork.kernel.org/project/linux-wireless/list/.
>=20

Oops. I _wanted_ that entry to no longer match so I don't get CC'ed on
everything ... I guess we need to add L: entries to all the things I
X:'ed. I sort of thought that might be there anyway, but I see that's
not the case for everything ... below change perhaps?

johannes

diff --git a/MAINTAINERS b/MAINTAINERS
index d19627afa652..09bd9827f318 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3655,11 +3655,11 @@ T:	git git://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
=20
-ATHEROS ATH GENERIC UTILITIES
+ATHEROS ATH WIRELESS UTILITIES AND DRIVERS
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-F:	drivers/net/wireless/ath/*
+F:	drivers/net/wireless/ath/
=20
 ATHEROS ATH5K WIRELESS DRIVER
 M:	Jiri Slaby <jirislaby@kernel.org>
@@ -6208,6 +6208,7 @@ F:	Documentation/process/cve.rst
=20
 CW1200 WLAN driver
 S:	Orphan
+L:	linux-wireless@vger.kernel.org
 F:	drivers/net/wireless/st/
 F:	include/linux/platform_data/net-cw1200.h
=20
@@ -13995,6 +13996,7 @@ S:	Odd fixes
 F:	drivers/net/ethernet/marvell/sk*
=20
 MARVELL LIBERTAS WIRELESS DRIVER
+L:	linux-wireless@vger.kernel.org
 L:	libertas-dev@lists.infradead.org
 S:	Orphan
 F:	drivers/net/wireless/marvell/libertas/
@@ -21727,6 +21729,7 @@ F:	drivers/platform/x86/touchscreen_dmi.c
=20
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
 F:	drivers/net/wireless/silabs/


