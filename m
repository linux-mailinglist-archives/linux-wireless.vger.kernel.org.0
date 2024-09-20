Return-Path: <linux-wireless+bounces-13045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91497D293
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C8D2834C0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC713A3F7;
	Fri, 20 Sep 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IrnII+mU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFF13B58C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820533; cv=none; b=DH81RKonPYz0/2qUf3rpRsntW0k/hRgwCWd8RO+0yVlqZhaKb3M6HpwzzV0mFM6LPaHE8PrdpflaB9vampz8etOj+YfiP+rROHEyKXXI942xHhnqDKtJDur5z1NB+iLgoPlu34z+fC04jQYCfAjtEjAl+RUYxQoTdjQsp/3K4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820533; c=relaxed/simple;
	bh=u5UZEnOqWdfuUHeVikUajZsnt0hZaQFAsjQx2M6D3WU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUT7kV7QYDolImmX7VFHMSYwGflL1gfjFwe7/ec7LCJWKy3BqqRgjioVNtshIlbjqKXlZbkR6R4PbBdQmEHYdMiCVZKdl0aPmjyk0LVmzUeba/9FU3AZduE5X4URMM5F0qwJLc4s+Q381gatLgRMlFMRabcFkhZ/aFXEdaqfjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IrnII+mU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso14102211fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726820529; x=1727425329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRbjQAo5tiCbLgDd42XDT9pptGlsd4CX0PrR8LcCUGw=;
        b=IrnII+mU7PSQaoNzQuKpc9YtK/rvsoZd0Esb9YXuC6p3vnbdVG1V9XL0oihAHHWAPo
         acu6Plwiid1gXlCRXFlRhBB1hWsCmdAk/G+6W8DPIcy6oVmi5LgfHJ6QhxW4qBfzc2zq
         L+yKbxTF3grQ6aHhE0JU54txhI7UJNjKFPLwmZME8/cfMVNVeUSIEKOeYrGixZXslCNI
         GfROr4skg/kfO8vxN/BepjPPVa9UzTp7jjBhbINtpDmjVNczEwOKWxwO1ZolctTpp7J0
         wzDnE+2IX6pj2g/VcdFFRjxMMvEV4tXYgoGmd0EOq/lTIGRJirFEPRxoUBnpKoLedmVa
         CXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820529; x=1727425329;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRbjQAo5tiCbLgDd42XDT9pptGlsd4CX0PrR8LcCUGw=;
        b=RkCgsL/8a7El5Hv81jPg04NrB3DxrEH2aHfqg0WuXC2e4gRIkLxyjfQ9+3+MHUxhGQ
         tcSt91qMzblK5BzKeaEAhCK38/5T1+JFgYdY5Jkrb2QhgxfyRE25BtrKmIQkmoA+l+nT
         4MdGyk/rjTbYhZ7MSV559S8GvuXsk8+Sox+zG26rOKNxnbTspKA+BZpky1GyofLbZK2h
         qv5C9t6gZHhiZ8CtTY0O+AAUnjjTKQrH/svfp1GwK3/T2f/XQjgt7wm8Yi6DlSGLezOx
         jUg+uYZWwkTFH0A4VYv2D8MK5IfLOMU+oYQqoOJoJCGTie1588K7X8D3xrbSsOKbUAnr
         V0lw==
X-Forwarded-Encrypted: i=1; AJvYcCWRg931GzHol/gwXiTuQEbndVKEDUsQ3ELyLj0QQhjTWJbj2L7ale5tj+OwkpkNm9UlsQoL8JGQuG2Lt9XtZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5W39bQQt0Xrx8QL1dhCwLacUhW5XqXTF1SciD0LgUk5a414gv
	CrX4XTQODMrQeEuM/XAQyKPKtJJxWayAgna7jDU5INEmdR9vvXynl0niGEsw05QULDpPsnVorVf
	rlePv/eknLlAo/Dru4wOUC3eZ6ycN2OHCBacjKA==
X-Google-Smtp-Source: AGHT+IFm0zWqedV49xnMK6e6g1fUxzAO4Bw9XOqBWqSyqcT4SimXa5HqQvffKU2Tm6zoS6jYevpiv7/STJpuqEJ9slU=
X-Received: by 2002:a2e:a58b:0:b0:2f3:aac3:c2a5 with SMTP id
 38308e7fff4ca-2f7cb36458amr7593931fa.17.1726820529151; Fri, 20 Sep 2024
 01:22:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Sep 2024 03:22:08 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <87a5g2bz6j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
 <87msk49j8m.fsf@kernel.org> <ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org> <87a5g2bz6j.fsf@kernel.org>
Date: Fri, 20 Sep 2024 03:22:07 -0500
Message-ID: <CAMRc=MeLick_+Czy5MhkX=SxVvR4WCmUZ8CQ5hQBVTe2fscCPg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sep 2024 08:45:56 +0200, Kalle Valo <kvalo@kernel.org> said:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
>
>> On 19/09/2024 09:48, Kalle Valo wrote:
>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>
>>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> ---
>>>>> v1 -> v2:
>>>>> - update the example
>>>>
>>>> I don't understand why this patch is no being picked up. The code
>>>> correct represents the piece of hardware. The supplies should be
>>>> required, because this one particular device - the one described in this
>>>> binding - cannot work without them.
>>>
>>> I have already explained the situation. With supplies changed to
>>> optional I'm happy take the patch.
>>
>> You did not provide any relevant argument to this case. Your concerns
>> described quite different case and are no applicable to DT based platforms.
>
> Ok, I'll try to explain my concerns one more time. I'll try to be
> thorough so will be a longer mail.
>
> In ath11k we have board files, it's basically board/product specific
> calibration data which is combined with the calibration data from chip's
> OTP. Choosing the correct board file is essential as otherwise the
> performance can be bad or the device doesn't work at all.
>
> The board files are stored in board-2.bin file in /lib/firmware. ath11k
> chooses the correct board file based on the information provided by the
> ath11k firmware and then transfers the board file to firmware. From
> board-2.bin the correct board file is search based on strings like this:
>
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255,variant=HO_BNM
>
> But the firmware does not always provide unique enough information for
> choosing the correct board file and that's why we added the variant
> property (the second example above). This variant property gives us the
> means to name the board files uniquely and not have any conflicts. In
> x86 systems we retrieve it from SMBIOS and in DT systems using
> qcom,ath11k-calibration-variant property.
>

No issues here.

> If WCN6855 supplies are marked as required, it means that we cannot use
> qcom,ath11k-calibration-variant DT property anymore with WCN6855 M.2
> boards. So if we have devices which don't provide unique information
> then for those devices it's impossible to automatically to choose the
> correct board file.
>

What you're really trying to say is: we cannot use the following snippet of
DTS anymore:

	&pcie4_port0 {
		wifi@0 {
			compatible = "pci17cb,1103";
			reg = <0x10000 0x0 0x0 0x0 0x0>;

			qcom,ath11k-calibration-variant = "LE_X13S";
		};
	};

First: it's not true. We are not allowed to break existing device-tree sources
and a change to the schema has no power to do so anyway. You will however no
longer be able to upstream just this as it will not pass make dtbs_check
anymore.

Second: this bit is incomplete even if the WCN6855 package is on a detachable
M.2 card. When a DT property is defined as optional in schema, it doesn't
mean: "the driver will work fine without it". It means: "the *hardware* does
not actually need it to function". That's a huge difference. DTS is not a
configuration file for your convenience.

> So based on this, to me the correct solution here is to make the
> supplies optional so that qcom,ath11k-calibration-variant DT property
> can continue to be used with WCN6855 M.2 boards.
>

No, this is the convenient solution. The *correct* solution is to say how the
ath11k inside the WCN6855 package is really supplied. The dt-bindings should
define the correct representation, not the convenient one.

Let me give you an analogy: we don't really need to have always-on, fixed
regulators in DTS. The drivers don't really need them. We do it for
completeness of the HW description.

Bartosz

