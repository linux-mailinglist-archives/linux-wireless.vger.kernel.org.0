Return-Path: <linux-wireless+bounces-25418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B70EB04C3C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAE93BF1B5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D64243956;
	Mon, 14 Jul 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdPqp6kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167C1DFCE;
	Mon, 14 Jul 2025 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535647; cv=none; b=XyPP28Pq9vSR8WxpbCVWdkY0Q4bwkLaqXRv+6ezS99+TnmKJf1xyu0a5wYPMdbX+OsxoFmAykC2n2RHWB2l5TZT9fNTK5OAFoEGDmxF2jccu6rFv1e/6U9ejGk3cQjy7PqfxoISBAIhRJQ/joLuysO4KgHX73DSNoAdRkNTt6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535647; c=relaxed/simple;
	bh=oSMnXm8xNMGu8kyySNLUWLKWniZxyLqIJbwxo2+Cymw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY8IMEVO1Xqqul0I8G2hCggiBY7+++34c5W0FKNlBUm7oF4BzuhjXYSwESuNTEr7NXdv0T0S8l0FSX8c/pEDZ5i1Ns+r95J6GsYeJt+ygnEx8OFnoZsfmnKqoCbC/yTnavgW+O4I/pA+vv3x8S9gw3JIbbPao+IodZ5Wmjfg9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdPqp6kt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso9060377a12.2;
        Mon, 14 Jul 2025 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752535644; x=1753140444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cWUdw/XWL0wKty/4mlXjtObOvYTaL5gOM763vl3Zdc=;
        b=BdPqp6kt6EpQn8WMNMOah/DVoZ9L3e5/jYIXheQTGUmvQ2jrgxYzPPuGU45lbrd5Tc
         eu0627fjogu0z3Gvj5SI5saRy59iFH9+RTTgTIIbhcFjjxOMyOAhW1nxUaxz8R0fKJ/R
         emgGnHd6/Zg4fDN+Y54lMHUnS1tthNU3vWexcnKWZZ6n/9gitzE7ASCzGCol+Q3Gex+Q
         AcidJJxHmEhYDu7bFKgbFm6by/TXlTe35jkNiBxI/uXFSjscri+kkC9hB7r2RUVogeMW
         w6a56/sC/dBStv44JcjtePWBEW2IYodxKmeFvsVfBOeYvCNiW3fOJq+4kX6sYQiFbYIV
         CkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535644; x=1753140444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cWUdw/XWL0wKty/4mlXjtObOvYTaL5gOM763vl3Zdc=;
        b=CUe385RzDTVpaNAd9ySdviNl9niB7B/qgWiDKtpkA6P7UfwBIIO0JQUwFYMqFTAM0h
         qVgsWWJK3MJBR2xVPsJsRfDL4r8sO0iEIGZQRjrpJqXih4kabSL98k2IsbtCK+wrr9gt
         CqrRKEu2bQG4O8wpEsHOMcYwTs7Atimb7tvwSn2drlxxuUn8FLipZNzT7iaFH/4q77lR
         VycYO/EFxJFpFXKzHgl6aTu57DCQPJaWzVkLwsyYnybbGkwKFk5a7Ioe3oRW2ebjnaej
         Ctmkp+sB9X/bFi3oRHLN2CdWpMLAwWNK1UKJDZvxT9yQrEAcNYZlOWKTAQOWNDKMn5Xr
         imAA==
X-Forwarded-Encrypted: i=1; AJvYcCW6OqnAontJfVAhNPo3jFxV2RCRC8jj2vrPDxQHiG/SkneWKPoYe1O6tlsvyZEOQq6LTRXcPD9nmBXofeHK@vger.kernel.org, AJvYcCXI5iczKmUn/nQ6zqgLPXSatlP0YpebpOmWk0Lv9Tv4SlbsRllwQRO/GycOWaSAeycE6OZLas44gv1D4xcuaxg=@vger.kernel.org, AJvYcCXJh90YXQY2vz3TrH5C0Jl5Ze+yRUXvvLaxLhfKUzk02idnWIIXbeBGlolDzabzPnGmyJwcfjckAIDe@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbJT9U8Zr9eUHyOCGcGm4vnvmnkIdpVI8FXECgRK3rFtdl0cU
	c6LfRw5OLpWlFOvSTZ/An4GSHuJLbqtPa8Z6lJgTxCPVIcuJWM7sVVDrCmrdS5WU/upUgUoUvmi
	zmnW3QKdbGMZg8qb/QKWcg7scZYGwv83m
X-Gm-Gg: ASbGncuVOWsw3H7yUB2oh+7RxgkiNDtVhGgZ3VEMmCZ6NoKFNSXqNhzlQrR4Hx4flGz
	CCBbgwq/6nL+Ept4i5qjJs2gKIsVdbx2alTcpvcY6I0XmA9KYCGP5oU3wiTOLxoKgWuONTe2zOW
	uHqvJm3nt9YCtFcc4mho8GGAFs853OiPPvlFWVqj8fGQuiDtfb4ZBkGy0DZrNq+rkICgahdS/kM
	YWXGys/XLKv9Tuvs5GMREQS3qEOgHPT8INWxugFQsUETyulHQ==
X-Google-Smtp-Source: AGHT+IE1PoTMFQT9rN7uOrNQbjO/MTvhGrGizKsF8Ga/T1DM3Q0YSP9nliT/80O/sEv8vzCBNVnaHRdoGdRfcsiVDlc=
X-Received: by 2002:a05:6402:5202:b0:608:50ab:7e38 with SMTP id
 4fb4d7f45d1cf-611e7c21fa9mr14227624a12.14.1752535644154; Mon, 14 Jul 2025
 16:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714173554.14223-1-daleyo@gmail.com> <20250714173554.14223-8-daleyo@gmail.com>
 <prrra3lon2p4pugkgeytf5ow5wls62lfdnwcdykztw3qzwity2@d26aqh6wdyln>
In-Reply-To: <prrra3lon2p4pugkgeytf5ow5wls62lfdnwcdykztw3qzwity2@d26aqh6wdyln>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Tue, 15 Jul 2025 01:26:48 +0200
X-Gm-Features: Ac12FXyokWE3P9WfHcZydzKzoz6l-6OPJ8mBLmVCv-L78yLEYDKASAdX8sAOtqw
Message-ID: <CA+kEDGFR3FB=ead50kFBAL23-1dXo-LOMqhT7f=WecNMf_MaNg@mail.gmail.com>
Subject: Re: [PATCH 7/9 RFC] dt-bindings: wireless: ath12k: Add disable-rfkill property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dale Whinham <daleyo@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Lingbo Kong <quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon. Jul 15, 2025 at 00:33, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote :
>
> On Mon, Jul 14, 2025 at 06:35:43PM +0100, Dale Whinham wrote:
> > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> >
> > Document the disable-rfkill property.
>
> Why? What does it mean? Why are you describing Linux driver firmware in
> the DT?

rfkill should be disabled according to the Surface Pro 11's DSDT.

https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc.com=
/
has added support to read the ACPI bitflag when ACPI is supported.

The idea was to expose one specific feature (DISABLE_RFKILL_BIT) for
devices described with a DT, so that the feature can be disabled.



> >
> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > index 9e557cb838c7..f15b630fb034 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > @@ -48,6 +48,9 @@ properties:
> >    vddpcie1p8-supply:
> >      description: VDD_PCIE_1P8 supply regulator handle
> >
> > +  disable-rfkill:
> > +    type: boolean
> > +
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.50.1
> >
>
> --
> With best wishes
> Dmitry

