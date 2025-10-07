Return-Path: <linux-wireless+bounces-27848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49620BC08DF
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 10:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6A3C4FAA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60E238145;
	Tue,  7 Oct 2025 08:08:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD82223708;
	Tue,  7 Oct 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824482; cv=none; b=fn31CuLsq5XxDHeoiaEDXe/m1FOQIIQWLrzDAH+8sB7olFZwHWFDwP9GzFvB5omD8xR57C0jXdkWzfBhG3ZFNPsF0wwp9NQ8mAm89oM6HU7RMf9i6YI8xS3J1et5FjgbSKZiaaFnyXj7BEhRcL4PanKny1O3nNw9hbiFrkdUHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824482; c=relaxed/simple;
	bh=qWKN2WEXLgovobQ+XRoTlZ+/OzTZsOP8GvYnocwHauI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjd3pDMjx6djpcey1JQWmmIWX9kr2sTXLKc+RzBAEcJMjubl3qFJA81HHzOFlRX4/wnS/yIsYbjF0YfGLEaJEUaXkaxa2QcbJ7qRZrPMRi8A+wRN6qEuuUY6UCwKPnLINr+iioh4UMIkc66zo4OsUHX6QEFc5F9kL+L1rMTnPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300C597021AE00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:9702:1ae0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DFAA9FA12C;
	Tue,  7 Oct 2025 10:07:55 +0200 (CEST)
From: Sven Eckelmann <se@simonwunderlich.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-wireless@vger.kernel.org,
 Shayne Chen <shayne.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH mt76 v2 2/3] dt-bindings: net: wireless: mt76: introduce backoff
 limit properties
Date: Tue, 07 Oct 2025 10:07:52 +0200
Message-ID: <2249324.Mh6RI2rZIc@ripper>
In-Reply-To: <175978385977.561952.12777844195936444721.robh@kernel.org>
References:
 <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
 <20250926-backoff-table-support-v2-2-16d3726646c4@simonwunderlich.de>
 <175978385977.561952.12777844195936444721.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3717359.R56niFO833";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3717359.R56niFO833
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <se@simonwunderlich.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Oct 2025 10:07:52 +0200
Message-ID: <2249324.Mh6RI2rZIc@ripper>
MIME-Version: 1.0

On Monday, 6 October 2025 22:53:36 CEST Rob Herring (Arm) wrote:
> 
> On Fri, 26 Sep 2025 12:04:53 +0200, Sven Eckelmann (Plasma Cloud) wrote:
> > Introduce path backoff limit properties in mt76 binding in order to specify
> > beamforming and non-beamforming backoff limits for 802.11n/ac/ax.
> > 
> > Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
> > ---
> >  .../bindings/net/wireless/mediatek,mt76.yaml       | 60 ++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Though I know nothing about this. Is there any reason why this is 
> all specific to mt76 rather than being common? Perhaps these settings 
> are all just part of the opaque "calibration data" in the QCom case?

Yes, everyone handles it differently and has different requirement for the 
actual provided data. Qcom has the calibration data, pre-calibration data, 
calibration files and pre-calibration files (which also needs variants for 
different devices or regions). But the actual interpretation of this "opaque" 
blob is secret and handled directly by their firmware. Don't let me get 
started with the (sometimes) embedded regdb in their calibration data.

Regards,
	Sven
--nextPart3717359.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaOTKWAAKCRBND3cr0xT1
y1P6AQCJRqHBtM3JW0S3r67quInXoomehh1RARYb5qW8xjcSWgEAkGt4kjlOUGCC
mOCuYzAeIPd9MfFHxHxtcsvjodrRXQI=
=FPF3
-----END PGP SIGNATURE-----

--nextPart3717359.R56niFO833--




