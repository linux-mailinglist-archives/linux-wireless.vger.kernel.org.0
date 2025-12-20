Return-Path: <linux-wireless+bounces-30019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080BCD2BD6
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 607AE300CAFA
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA82FD68D;
	Sat, 20 Dec 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tww/limY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C68287E;
	Sat, 20 Dec 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221939; cv=none; b=gfYPBSO+VpbW8nLpyyz0ofSCobeBvfa//n4V2Edr4U/i9UHYAK17VkYKstMuCUyKKcbRoclBe+DgnZ4LgSD4F1Sk+l0d8ztrI0XU0ZJ5DnmLa7gzxyDwoqgcERCVzUZ3AH5dR3OBT9E1rWFKHwavYuPqavavyRetdSBec4lGCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221939; c=relaxed/simple;
	bh=hYDqeJLk4fMx9mP+F0+rMSTvt8DAR2pALIwmlOoKT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNR/2mbZxHiVsx1HXyyNth6bfHeFJ0Lg9b1+VR923A8YStHgyNp7hHyhlxUFIhK98GGHFSKv7HbxYU5O2xbXWiWYJejVlXx71Arcf4ClYCAIsvCbQ4D3Q2nySZDkr7W8L7al/LbEV487CElKBB6LVxgr3RAFdXKuSSkvZ8eS7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tww/limY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4EFC4CEF5;
	Sat, 20 Dec 2025 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766221939;
	bh=hYDqeJLk4fMx9mP+F0+rMSTvt8DAR2pALIwmlOoKT0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tww/limY7l44Ini+Fmz+2jiIpRCWzR2fioOWFxZ6aozbV+o/WbMg73uNPvqNnjBdC
	 pd7EaqOPoQTNyRR+RW0G5t0mxMGluoBZ6/1azAv3+cRtCEKTxxeZoJwfWalbSJsAei
	 xgv6aLd4KMdGDS5ZqNRwE3UgtMzbuKcbgwkqVlU+YBNeXqgY29TPn+qYV+MmwY2NLq
	 NoOSL3iH2wt/C/aU7KiLk69LiLYJ+KWnu54alTHyHZ6BWIGENTOGo7nWOiF4HgeEgb
	 qnXa1tAINbNZd/CvwaFHyTukYOgN7yPFiay8mU+O1PZr8JiPHxrbql8JQEPMdPwzFE
	 obCx4ZIhguAuw==
Date: Sat, 20 Dec 2025 10:12:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: jerome.debretagne@gmail.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
Message-ID: <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>

On Sat, Dec 20, 2025 at 06:04:00AM +0000, Bryan O'Donoghue wrote:
> On 20/12/2025 00:21, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:
> > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> >=20
> > For some devices, Wi-Fi is entirely hard blocked by default making
> > the Wi-Fi radio unusable, except if rfkill is disabled as expected
> > on those models.
> >=20
> > Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> > disabling specific features based on ACPI bitflag") added a way to
> > support features set via ACPI, including the DISABLE_RFKILL bit.
> >=20
> > Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> > equivalent for devices described by a Devicetree instead of ACPI.
> >=20
> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > ---
> >   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 +++=
+++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.y=
aml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5ea=
ec2c7ff367fd93945 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > @@ -29,6 +29,12 @@ properties:
> >         different 5 GHz subbands. Using them incorrectly could not work=
 or
> >         decrease performance noticeably
> >=20
> > +  disable-rfkill:
> > +    type: boolean
> > +    description:
> > +      Disable rfkill for some devices on which Wi-Fi would be entirely=
 hard
> > +      blocked by default otherwise
> > +
> >   additionalProperties: true
> >=20
> >   examples:
> >=20
> > --
> > 2.47.3
> >=20
> >=20
> >=20
>=20
> Is this really a hardware description though ?
>=20
> Its really more of a logical/functional description. It tells the runtime
> what todo, not what the hardware is.
>=20
> You could also have a list of quirks in ath12k for this or have a user-sp=
ace
> utility look for the appropriate platform device string name and disable
> rfkill.
>=20
> I think this logic belongs in drivers/net/wireless/ath/ath12k/ triggering=
 on
> a compat string.

This is good point. Either this could be deducible from the compatible
or this should actually describe the hardware and whatever is there
wired/configured, not what OS should do.

Best regards,
Krzysztof


