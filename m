Return-Path: <linux-wireless+bounces-8616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64A8FE7F5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4772838D0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFE19597D;
	Thu,  6 Jun 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZPew/BYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9E195FDB
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680962; cv=none; b=DcbOuiylmYAH0JkACGCOahajAfjyD1pjAMlJcjsFinH2kvDoOWOhZ1lFkdHTH5paJvlR/YrwQyQ8dyUAnYyF4kdKaI5pvwwrxqz3R1B4hAzRYuGtCJDI7nWOsRFOJt7U6VVa+Dovu01X4323IcUYQ/vNXo8agug++8yVFRZwAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680962; c=relaxed/simple;
	bh=Dn+68IYvXFRM/ZJNZhnDd4YDu9/8K+l2gjrIK8I9Atw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2DdP3TUyUja6L7lsFjyI9Fodg4PC5KumR5eV3RuDQfbm/6GkCuk47LUW8K59QmNVmayLIbx2eiq8Kkx3hVp31QiDYyxz+aBaL7Ujdb3NztEHbcHr+kklFCrGvYeR5j6KimBb+oQxiOc0e958cdyaQg/eyL8JCo2Us79kE0AmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZPew/BYw; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eab0bc74caso8417431fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2024 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717680959; x=1718285759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcE4lbv2vNyPF1qxio9ZhgpB3UHvF6AORt7V6CDt54g=;
        b=ZPew/BYwIKEy0uQJtRGU5tOLUXyRlErHL96FWn6X8IqfA5LiltkPUv5gsc2WKBMwg4
         Q/MDVNkMkvwPBr+PvTRA5ayfnA1PgwF1o1WRHSDjxxqjDjL13o0zsETXfL05QKrbNA3f
         /WHZyYbwSd2laAe96gYtl77a36Q4HJ2Qwe87hkrZ+s8cIuOfPZljE1ZvrxZHLEw+2K9G
         urGmDGyTde7eMN1TfK5eyL4w4h3vHy92Kg8/unhJ/13G1wdbGjM9Ku0urSYqCDeWTwhN
         W+JR4Juf/JLrM1tLq8WRvVu0ItVD0EvOa8nJN4TKsHqxOqNHDpgOtBWseR7ohsLW/Cne
         P7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680959; x=1718285759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcE4lbv2vNyPF1qxio9ZhgpB3UHvF6AORt7V6CDt54g=;
        b=sdP7mdUyVHnD3a2QE698v+dbAsxqYtNPXOc+WqQAgH0KJHCGpDmgQ+3mTmoGl5QJp1
         6WABuDahXdwMVBYrj9YpCiqIYfFT+FiZ59Ar/Hkkl1DuUXkDtAbGXZhpt6HLuKB0mUhS
         SMNVhtoerCCDeQDWjVTSzQ9+P+m7xHbEpgD/9QzxaTRoCxoKP4JZTov9Jj5M5wA5Bn39
         L8GDGF6dSV85HSGZbZwwlhuQ5q1u/rFJdWQ+J5zK6M0cBQ//JxB//7UezkLxN8Ha969v
         TXLF92l16wG8d8MayjJf3sFdMPd/UgihnuKrhZ1w2M48nhqzEt0qdi6iy2fR2K69LUXp
         9JgA==
X-Forwarded-Encrypted: i=1; AJvYcCWHddA0qSB7sQzLOjQr4dkH1LYrzzagXPTC1WNExfWyf7puXYIiHKJ7zw9Sn93D1nM/5Mq6hDpKnqT1KEz7kviR9wuW4gT8eugxFyBoE+0=
X-Gm-Message-State: AOJu0YySnFavllPed0GoVOCLCoHo6D4LnRECfaVJTrcnDghXelVsxgWy
	Oqm8bKjQGjydLa5UOyPg6GrUeY0pEwvwOb69S7WWD4TiAKkFI5TWH69jBIzoUmUnKHTeppMXBHG
	wUMrGSp32tVw6niGGDJDL3CuLKaKWhEYtd0EPzw==
X-Google-Smtp-Source: AGHT+IFBM66nYsYkj5n/LotNPGso9ssGRfTDwE6YFuYv71IJpcC35zwc+EVz+BTh4BzurMJ5gBpZ2OPmZZ2xaKfaFt0=
X-Received: by 2002:a2e:9e99:0:b0:2ea:c518:7c6f with SMTP id
 38308e7fff4ca-2eacff98b6bmr8848171fa.1.1717680959188; Thu, 06 Jun 2024
 06:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org>
In-Reply-To: <87h6e6qjuh.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Jun 2024 15:35:47 +0200
Message-ID: <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:30=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> > power inputs from the PMU that it consumes.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> [...]
>
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: pci17cb,1101
> > +    then:
> > +      required:
> > +        - vddrfacmn-supply
> > +        - vddaon-supply
> > +        - vddwlcx-supply
> > +        - vddwlmx-supply
> > +        - vddrfa0p8-supply
> > +        - vddrfa1p2-supply
> > +        - vddrfa1p7-supply
> > +        - vddpcie0p9-supply
> > +        - vddpcie1p8-supply
>
> Not sure if we discussed this before, but based on this I understand
> that there can't be an DT entry for device pci17cb,1101 without all the
> supply properties? But there are QCA6390 devices with PCI id 17cb:1101
> which do not need these supplies and already work. For example, my Dell
> XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 board
> to their PCI slot and some of them might want to use DT, for example
> setting qcom,ath11k-calibration-variant.
>
> This is not a blocker for me, just making sure that we are not breaking
> any existing setups.
>

If they are already powered up without the need for the PCI pwrctl
driver to do it, then they will work alright. Bindings don't affect
functionality. But if you have a QCA6390 then you have its PMU too and
the bindings model the real-world hardware.

IOW: your laptop should be alright but the supplies are really there
which warrants adding them to the bindings.

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

