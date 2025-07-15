Return-Path: <linux-wireless+bounces-25438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCBB04FA6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 06:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C57175EEF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFC2D0C73;
	Tue, 15 Jul 2025 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9hfz6KU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610F946A;
	Tue, 15 Jul 2025 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552136; cv=none; b=s4LCGNcM8sgO2abHaqraMIIPqc3R2p1wvnNTVMbde7+NW5AXOu3XErVZCVxOWTgN4q/VwcjpVwCi4sJhXGQTMul8vYc7riuXiL64mxpqcv//DVxPdTg/r0FpQStJDa5N5f3kaEN4+LEhCw6weW05ezHnwS2WHoMnO05Js6zyBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552136; c=relaxed/simple;
	bh=XTpTiYZCt+831D8WJ+GyCYjH/IxQRruB1cTTUcZo054=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCjZDV+vd124ZSpJqBJA+/Z0JgTZSKuiOwqbvbC+x250ZZ4F8/wNnmm+TbyVsp2TdidO2aAXa2WSyiOs7aka8sgz6Gc06ujtxygVUsQpKi26kJA0KOGHsUlzrjUdF2g+8ymJwAn9ztr/yXgzie4TwAxWzGRjexO4XPqhkZ9KaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9hfz6KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05AFC4CEE3;
	Tue, 15 Jul 2025 04:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552136;
	bh=XTpTiYZCt+831D8WJ+GyCYjH/IxQRruB1cTTUcZo054=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9hfz6KULY0Fap/fLlLOyRyIzj1Nakml0N8IWzcDYZXAhYbIWyUEubLZC7UwkF/Z2
	 Q6quDzNAJgUiG0z6HmPtLEuYL62Kdl4HTAs1t5XvnvRwsnHilPrNLcyibFVGi0JXWY
	 Jd59fRfZ4tyEblo4wBLXnPhFS3Zk4uOoss6IkeGXX/Llf7u6Kj7ntsr2YioodItpCe
	 KbUFOUMT76nuXnhhUrRLuTIUOPzNSZ17Mh1/zDItfUfzpMeL1WJi0rV16NoZoR5Ofg
	 j7x3eWdNBsJ4EDhnvydnCOIKjQy68PjiCUZGHeYmLYkqEpvwNVYUJT0Bvg1q8Hp69y
	 6nqsL1nGSth/g==
Date: Mon, 14 Jul 2025 23:02:15 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dale Whinham <daleyo@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lingbo Kong <quic_lingbok@quicinc.com>
Subject: Re: [PATCH 7/9 RFC] dt-bindings: wireless: ath12k: Add
 disable-rfkill property
Message-ID: <20250715040215.GA20887-robh@kernel.org>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-8-daleyo@gmail.com>
 <prrra3lon2p4pugkgeytf5ow5wls62lfdnwcdykztw3qzwity2@d26aqh6wdyln>
 <CA+kEDGFR3FB=ead50kFBAL23-1dXo-LOMqhT7f=WecNMf_MaNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+kEDGFR3FB=ead50kFBAL23-1dXo-LOMqhT7f=WecNMf_MaNg@mail.gmail.com>

On Tue, Jul 15, 2025 at 01:26:48AM +0200, Jérôme de Bretagne wrote:
> On Mon. Jul 15, 2025 at 00:33, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote :
> >
> > On Mon, Jul 14, 2025 at 06:35:43PM +0100, Dale Whinham wrote:
> > > From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > >
> > > Document the disable-rfkill property.
> >
> > Why? What does it mean? Why are you describing Linux driver firmware in
> > the DT?
> 
> rfkill should be disabled according to the Surface Pro 11's DSDT.
> 
> https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc.com/
> has added support to read the ACPI bitflag when ACPI is supported.
> 
> The idea was to expose one specific feature (DISABLE_RFKILL_BIT) for
> devices described with a DT, so that the feature can be disabled.

The commit msg should answer all this. That was the purpose of the 
questions.

Assuming it belongs in DT, why is this ath12k specific? Could be for any 
wireless chip...

> > > Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > > Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > > ---
> > >  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > > index 9e557cb838c7..f15b630fb034 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > > @@ -48,6 +48,9 @@ properties:
> > >    vddpcie1p8-supply:
> > >      description: VDD_PCIE_1P8 supply regulator handle
> > >
> > > +  disable-rfkill:
> > > +    type: boolean
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > --
> > > 2.50.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

