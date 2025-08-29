Return-Path: <linux-wireless+bounces-26858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019AB3B36A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4848D4E32A9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72622309B9;
	Fri, 29 Aug 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNIfukHf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE94220F2C;
	Fri, 29 Aug 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449059; cv=none; b=tVUbF4nHj/UL1XBCtKIEKUeqnal5vb5OPmcpLR28XyQo1FNWXMY+6UeJ1TJw6jHY2Pzhe9uLuA3FWS1aHi/9W78qnBFC/zKgP5lj04WX0bT3J0Jz6wYfGb7RZ2YUEFmVtcxEcmcX9VJoKKTPrhSBNLKsUKFZKAKaOPB/Oam+gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449059; c=relaxed/simple;
	bh=T8H1V3HWZLD2UtEQdd13m1QTiyyAs7ME8QUVDUN+OqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/UbgWTXhx4n2Uz+3DsScUuNPJazKDya9Qr2oLYjj/Z/q4WaQjIuDGCgrSzMGtGSbeQYQaR7FhPuZ8lL2KLDQxj+dl/AxH1hE+4Nbs8sKcdRARuwnDd/e25joiTolVjedGUM0wncbxlW2gTCuqYKOveoBDlW73P9zovwBlo8148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNIfukHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C94C4CEF0;
	Fri, 29 Aug 2025 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756449059;
	bh=T8H1V3HWZLD2UtEQdd13m1QTiyyAs7ME8QUVDUN+OqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNIfukHf7wXRrcE8vYPt7yyz8qghc+VlBtHbCYwEDVlVRuOOS9VYmFyWQ15KFnbpp
	 NVXzs+bhPibRXbP/jAKjTL4ibk3C2vI/llVOWCK2U9oF7tWQSktIRtAvy37Zf/HDbj
	 ML5HwKFtETCdAIIDPk/XWD869xIGHDwEGJRX8Zp4mYLvWhQrOWHnIbr9IapG+KXpTU
	 CDvQwo0RwlZjlPvKEeWNOsg6eGq5RP+qj5J2JGysceWgae47hxUYQA7dSULZ5Fv7rY
	 Ae6kRKDwJjvgqxyhDsY4K2pWQgbhgWgu9yLUgmAhIWiM7Rq9urGsaoq2BKXBmrPkms
	 xLqb7R0ZPRHgw==
Date: Fri, 29 Aug 2025 08:30:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: Re: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Message-ID: <20250829-sophisticated-macho-corgi-a27cf3@kuoka>
References: <20250827005658.3464-1-rosenp@gmail.com>
 <20250827005658.3464-2-rosenp@gmail.com>
 <175638709817.1370637.10754263567298002001.robh@kernel.org>
 <CAKxU2N-Zfme=84rqxQ=uJro1YMeFGorveT-uRhx6_HpJmB-fxA@mail.gmail.com>
 <9208c440-f9e3-4289-9c33-81bb35383d53@kernel.org>
 <CAKxU2N9o_jJd7mfVQE2yab5xX+-gKa8qB8hLkKJPqZq+YmzE4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKxU2N9o_jJd7mfVQE2yab5xX+-gKa8qB8hLkKJPqZq+YmzE4Q@mail.gmail.com>

On Thu, Aug 28, 2025 at 11:12:51PM -0700, Rosen Penev wrote:
> On Thu, Aug 28, 2025 at 11:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
> >
> > On 29/08/2025 03:47, Rosen Penev wrote:
> > >> dtschema/dtc warnings/errors:
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts=
:92.15-25: Warning (reg_format): /example-2/ahb/wifi@180c0000/led:reg: prop=
erty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=
=3D 1)
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts=
:91.17-94.15: Warning (unit_address_vs_reg): /example-2/ahb/wifi@180c0000/l=
ed: node has a reg or ranges property, but no unit name
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts=
:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c00=
00/led: Relying on default #address-cells value
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts=
:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c00=
00/led: Relying on default #size-cells value
> > >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb=
: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_defa=
ult_addr_size'
> > >>
> > >> doc reference errors (make refcheckdocs):
> > >>
> > >> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2=
0250827005658.3464-2-rosenp@gmail.com
> > > FFS. These reviews were garbage. The next series will effectively be
> >
> > What? My and Conor reviews were garbage?
> I was specifically referring to replacing led-sources with reg. The

You sent untested, broken code and you complain that reviews were
garbage?


> latter needs address and size-cells specified which is verbose for no
> good reason.
>=20
> Meaning the initial patchset was almost ideal. Just
> of_device_is_available needed to be fixed.
>=20
> I'm irritated as this will be up to v5 when it should have been up to v2.

Start testing your patches finally!

That's your job, not our infrastructure!

I think every damn patch from you was completely broken, because you did
not bother to test, but you call reviews of others "garbage".

That's not acceptable.

