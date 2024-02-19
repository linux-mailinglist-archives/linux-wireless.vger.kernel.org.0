Return-Path: <linux-wireless+bounces-3793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FD85AB67
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 19:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5922D2833B3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE4482EC;
	Mon, 19 Feb 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1VGGa1fm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457327714
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368515; cv=none; b=c4Zsg5FRzcwk8riZilGj85XN2lJIN99EBkL3ABueocTnpD9r+6jazs00VLIltpQwEB/M+Z44k1Em+Ed9B5ROLBmtuRWC8lRnZZXVxFIVg8cz6aBLnaCpwt7SWv5I0pmU5vrBhYv5V60E5UvFeqCwbkRx+mWfGlfCctQm88kemlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368515; c=relaxed/simple;
	bh=tWv3BTcXIRuvABZYmrMpTNLM1fVSSvR8wJ9miScNVZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/eiF0fwBU92hxAO3ENQwaJ5ikD2AQEYXGXQyVo0FEQyX86D+KVdh5ve/IXJVQOpX5NN6e3Cpj6at4g5yqdoWKH/j7Gbh11saSvE4JVpVMRTcEbPllyynYmMb9mOzU2e123LkUg5oP4G6PwlSrvxXocDZpLoHUTmtT3h5EiUIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1VGGa1fm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso2174049241.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708368512; x=1708973312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw+h6XA2eEk7N3nhL73ACZ3Q8FgRaHJnjAZBDU1Wfkk=;
        b=1VGGa1fmMaxjWD5xtBOgZYKLB62EqAJVXLgaLXI6WHf97nYa9CwwKXdkPuo7Vnzq/3
         R+Gm0JsxkC/2YN6UHYxTktPcQYoFjNdgKmHd00V7WUGoano+PdA8jljF18mKLtOEy4y7
         sXJ1XVpvc0KRXPoKI6DUmwJIrnAEvF+sftONKaI7f2pLDlPrbocdOCI3dpa45Ev6eAmz
         ku2hbAmLSRUX6y5fQ8AgWoCU6tEmjoqmI9fK7lW16qfH/uv2JaXqKf45LDMIwnTWfXiQ
         lDIkpCoNXuz7CDPdn+1wmb6l2Wl1WQddLgSqJKtLS/m4+SIORm2kmh1FEQrmVOJ9/wnA
         TLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708368512; x=1708973312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw+h6XA2eEk7N3nhL73ACZ3Q8FgRaHJnjAZBDU1Wfkk=;
        b=ZlAHlgpFlOK1Y50nkq1HTmY3/KwlF72EBDXisk4D5S/rboboBARO7G1uYGJHm+wLYw
         lhstYXm+m1CA5jc6a1TPjr5I3hXcvYHBjxyMaZXyj4B1rEuYZ7yVUOsFKlsJMW7mSQ1T
         A4Tn3nsmvz3VO50v723Dl+UbqadBKSflyk3jfwoYOC72l1l4ihrnw5WDyPehpnpi/rzv
         GT8ydCbxG7d8QdN3LqlwKsJttCNsbK3ym7FL8VUmzcbveurfKQmnQRVdT5wiJCJXwIK6
         wf20hFVM60aYP0be9ipOMc9uNHR0cBwUeeCwyQ0KnZhhV+ADXUUtOWAxiFSrz1zhHWZi
         bI0w==
X-Forwarded-Encrypted: i=1; AJvYcCUb7SeKdV1/86wz5q/4yW8KVj6OfVch3olZyYKdnoCCbjXYgfsEFv+G+v4gJ6DXz+Du+5vC8O9fxne5oMkzLzgGzR0DuUcNJ/wQnrZaYY4=
X-Gm-Message-State: AOJu0Yy4KeR+j2D0G3xJ5Yc4ghODnC9Xi0RS4fHuM+EHbHj+Fu/0eUjK
	fT+aKHk+b9Str9GHm/Qav0Yb5hpxA3pl/W/BkM1yo7uG8ErmzLwlAYb8OfS3PMmpoAxtVPnuBHx
	dbbjNeS2OS4/eVTyucuXlHZVYwlCQhyu1ei+bgA==
X-Google-Smtp-Source: AGHT+IFew0xpEP8/09qOXqEwkTDNNehQKTGr1SM0trRodxSgKcCNIctA84dQ/9qfd01qZ/b5K7TWSeVoDwJUt5v12E8=
X-Received: by 2002:a1f:e207:0:b0:4ca:f519:c25f with SMTP id
 z7-20020a1fe207000000b004caf519c25fmr2526721vkg.9.1708368512278; Mon, 19 Feb
 2024 10:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
In-Reply-To: <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 19:48:20 +0100
Message-ID: <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:
>
> > +                     vreg_pmu_aon_0p59: ldo1 {
> > +                             regulator-name =3D "vreg_pmu_aon_0p59";
> > +                             regulator-min-microvolt =3D <540000>;
> > +                             regulator-max-microvolt =3D <840000>;
> > +                     };
>
> That's a *very* wide voltage range for a supply that's got a name ending
> in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> Similarly for a bunch of the other supplies, and I'm not seeing any
> evidence that the consumers do any voltage changes here?  There doesn't
> appear to be any logic here, I'm not convinced these are validated or
> safe constraints.

No, the users don't request any regulators (or rather: software
representations thereof) because - as per the cover letter - no
regulators are created by the PMU driver. This is what is physically
on the board - as the schematics and the datasheet define it. I took
the values from the docs verbatim. In C, we create a power sequencing
provider which doesn't use the regulator framework at all.

Bartosz

