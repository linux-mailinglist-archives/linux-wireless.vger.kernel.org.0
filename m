Return-Path: <linux-wireless+bounces-3765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AF859DFF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 09:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62A91C2181B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1B210F9;
	Mon, 19 Feb 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/hbB1j+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D920DFF
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330625; cv=none; b=ckK3d99wtAH2W7m1iXMglpY1IsG09OZl4aUwveXSV6GMHryoHmaXJ0GzExWsItkMp0F/1SM6DCJue0b6M0xDEWwwb7tXPvphtvuol2t4C10JEHHzjKmJduh5BvBtxW/3KCE2kS49S+Bmtx9unT225/c4BiP54Sm4goxrtit8uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330625; c=relaxed/simple;
	bh=FDQylYihIhfAW83YABlY8fp9D4XuTgaspkBtXQH1onc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gmN7ZoKOMLcOQLGTWVc2aBR/QSLIe+I+9900JppShgsg4O0OIEkQU0HNNb4/+MNS0mJi7rW+Kd2WGzytNdn97ZtTP7yHoHWB1dJiT5sNh79eMnDkrVAU+URVy2H4Hp8bEHF5B/aJuU0QXN3kemsvkfUIrh+th6PlLNXg4Igrm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C/hbB1j+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41261233e61so4913065e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 00:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330621; x=1708935421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia7U6nZrY2+hEhZYnM5su5szDLLIRcAesVPlvaU9oxw=;
        b=C/hbB1j+GZjl3puyCf4zr1Prv4NVKejkRGCp1uOER1QDegM6HDWaAH4YMvbTVoMHdu
         77x2ZOFnEnnBm8tTxX3vl4dHFjt+nb4ph4/XtujPndSUPfO5KbmGtai0h2QUMV3BCa46
         IBIWsi7gbrHTKMHGH3GijS12oNO2JwW3JNzLTIwAHTkRLszx8kV2fM/Ylg5W/rWb9EZr
         /BUT8fPYa7FSrJwfGHuj/em1GVgoP2JfZbYRlaLINaZn9nISeS8ohxAJFchusREoDWCH
         SyxARHj8tRoxFJzrKa2VQhO438RC4qn2ApiZxwVmlsJJ966TBpMqFBhrqypA6CdC9/p3
         PLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330621; x=1708935421;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ia7U6nZrY2+hEhZYnM5su5szDLLIRcAesVPlvaU9oxw=;
        b=aytw4vtBu3uJYhUHcVKoU4nQ5BnkKVDPODcery5lBnRq5lm3zdmLjGO/gMJDyc1N/n
         oe0UPq/sMND+5/vEwCvlQSaY1QrDaz4bC0Vz2/bz00uiF2hfoXpHATBog5VYvX28knCZ
         j+QYTbP+ok/6i8HltWe7UpyawdTJhZ9W+XM+qHIJjAMK01YRERmZKw9gkTsd+s1XfIPp
         1mEQrScbgrEJJmQkKj6j0PvhwmuSNs30u8cLLxrT6syzh0iES6nnfCL2cqk0jiD3TDIP
         xRRimh2Zwud25lNFVvJUGNrzsDEwcxpQnWAt0gcshEMJb/pEHgO58033Gl/L7xBeD/ws
         8nLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnu9bZ8jdbnxae+XUSvBP8fioKQpQdkzmJUVOHW9BJ7Akv+4+vIyuNVpJjE4RBPwTioSuZRMAaxdbqiY8RDoMUpx0bW9ycFSiHhkw6LR4=
X-Gm-Message-State: AOJu0Yy00StQc49Kttty/9RlmU8e+1/qdZu0GnGCey+WZZkt/chWcU4s
	XplOHxHJD+yasCeJnpPfin1LFy//H5yWm1vQ2aVFApRXqNI5ItMa471a8z89EmM=
X-Google-Smtp-Source: AGHT+IFdJzBUryVnRYG++46qoRAjOLuouV8IZRRAN9kbKefqqVPr2iDktEUgsUAowrKolxacWKTJfA==
X-Received: by 2002:a05:600c:35d0:b0:410:ce61:8609 with SMTP id r16-20020a05600c35d000b00410ce618609mr12875993wmq.11.1708330620913;
        Mon, 19 Feb 2024 00:17:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm10657274wmb.20.2024.02.19.00.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:17:00 -0800 (PST)
Message-ID: <6860e1cb-4364-44a4-bfe5-21d112ee6777@linaro.org>
Date: Mon, 19 Feb 2024 09:16:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
Content-Language: en-US, fr
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/02/2024 21:31, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> First, I'd like to apologize for the somewhat chaotic previous iterations
> of this series and improper versioning which was rightfully pointed out
> to me. I figured that the scope changed so much that it didn't make sense
> to consider previous submissions part of the same series as the original
> RFC but others thought otherwise so this one becomes v5 and I'll keep the
> versioning going forward.
> 
> This is the summary of the work so far:
> 
> v1: Original RFC:
> 
> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
> 
> v2: First real patch series (should have been PATCH v2) adding what I
>      referred to back then as PCI power sequencing:
> 
> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
> 
> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>      modules inside the QCA6391 package (was largely separate from the
>      series but probably should have been called PATCH or RFC v3):
> 
> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
> 
> v4: Second attempt at the full series with changed scope (introduction of
>      the pwrseq subsystem, should have been RFC v4)
> 
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
> 
> ===
> 
> With that out of the way, I'd like to get down to explaining the two
> problems I'm trying to solve.
> 
> Problem statement #1: Dynamic bus chicken-and-egg problem.
> 
> Certain on-board PCI devices need to be powered up before they are can be
> detected but their PCI drivers won't get bound until the device is
> powered-up so enabling the relevant resources in the PCI device driver
> itself is impossible.
> 
> Problem statement #2: Sharing inter-dependent resources between devices.
> 
> Certain devices that use separate drivers (often on different busses)
> share resources (regulators, clocks, etc.). Typically these resources
> are reference-counted but in some cases there are additional interactions
> between them to consider, for example specific power-up sequence timings.
> 
> ===
> 
> The reason for tackling both of these problems in a single series is the
> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
> both need to be addressed in order to enable WLAN and Bluetooth support
> upstream.
> 
> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
> takes inputs from the host and exposes LDO outputs consumed by the BT and
> WLAN modules which can be powered-up and down independently. However
> a delay of 100ms must be respected between enabling the BT- and
> WLAN-enable GPIOs[*].
> 
> ===
> 
> This series is logically split into several sections. I'll go
> patch-by-patch and explain each step.
> 
> Patch 1/18:
> 
> This is a commit taken from the list by Jonathan Cameron that adds
> a __free() helper for OF nodes. Not strictly related to the series but
> until said commit ends in next, I need to carry it with this series.
> 
> Patch 2/18:
> 
> This enables the ath12k PCI module in arm64 defconfig as Qualcomm sm8650
> and sm8550 reference platforms use it in the WCN7850 module.
> 
> Patches 3/18-6/18:
> 
> These contain all relevant DT bindings changes. We add new documents for
> the QCA6390 PMU and ATH12K devices as well as extend the bindings for the
> Qualcomm Bluetooth and ATH11K modules with regulators used by them in
> QCA6390.
> 
> Patches 7/18-9/18:
> 
> These contain changes to device-tree sources for the three platforms we
> work with in this series. As the WCN7850 module doesn't require any
> specific timings introducing dependencies between the Bluetooth and WLAN
> modules, while the QCA6390 does, we take two different approaches to how
> me model them in DT.
> 
> For WCN7850 we hide the existence of the PMU as modeling it is simply not
> necessary. The BT and WLAN devices on the device-tree are represented as
> consuming the inputs (relevant to the functionality of each) of the PMU
> directly.
> 
> For QCA6390 on RB5 we add the PMU node as a platform device. It consumes
> regulators and GPIOs from the host and exposed regulators consumer in turn
> by the BT and WLAN modules. This represents the internal structure of the
> package.
> 
> Patches 10/18-14/18:
> 
> These contain the bulk of the PCI changes for this series. We introduce
> a simple framework for powering up PCI devices before detecting them on
> the bus and the first user of this library in the form of the WCN7850 PCI
> power control driver.
> 
> The general approach is as follows: PCI devices that need special
> treatment before they can be powered up, scanned and bound to their PCI
> drivers must be described on the device-tree as child nodes of the PCI
> port node. These devices will be instantiated on the platform bus. They
> will in fact be generic platform devices with the compatible of the form
> used for PCI devices already upstream ("pci<vendor ID>,<device ID">). We
> add a new directory under drivers/pci/pwrctl/ that contains PCI pwrctl
> drivers. These drivers are platform drivers that will now be matched
> against the devices instantiated from port children just like any other
> platform pairs.
> 
> Both the power control platform device *AND* the associated PCI device
> reuse the same OF node and have access to the same properties. The goal
> of the platform driver is to request and bring up any required resources
> and let the pwrctl framework know that it's now OK to rescan the bus and
> detect the devices. When the device is bound, we are notified about it
> by the PCI bus notifier event and can establish a device link between the
> power control device and the PCI device so that any future extension for
> power-management will already be able to work with the correct hierachy.
> 
> The reusing of the OF node is the reason for the small changes to the PCI
> OF core: as the bootloader can possibly leave the relevant regulators on
> before booting linux, the PCI device can be detected before its platform
> abstraction is probed. In this case, we find that device first and mark
> its OF node as reused. The pwrctl framework handles the opposite case
> (when the PCI device is detected only after the platform driver
> successfully enabled it).
> 
> Patches 15/18-16/18:
> 
> These add a relatively simple power sequencing subsystem and the first
> driver using it: the pwrseq module for the QCA6390 PMU.
> 
> For the record: Bjorn suggested a different solution: a regulator driver
> that would - based on which regulators are enabled by a consumer - enable
> relevant resources (drive the enable GPIOs) while respecting the
> HW-specific delays. This would however require significant and yet
> unprecised changed to the regulator subsystem as well as be an abuse of
> the regulator provider API akin to using the reset framework for power
> sequencing as proposed before.
> 
> Instead I'm proposing to add a subsystem that allows different devices to
> use a shared power sequence split into consumer-specific as well as
> common "units".
> 
> A power sequence provider driver registers a set of units with pwrseq
> core. Each unit can be enabled and disabled and contains an optional list
> of other units which must be enabled before it itself can be. A unit
> represents a discreet chunk of the power sequence.
> 
> It also registers a list of targets: a target is an abstraction wrapping
> a unit which allows consumers to tell pwrseq which unit they want to
> reach. Real-life example is the driver we're adding here: there's a set
> of common regulators, two PCIe-specific ones and two enable GPIOs: one
> for Bluetooth and one for WLAN.
> 
> The Bluetooth driver requests a descriptor to the power sequencer and
> names the target it wants to reach:
> 
>      pwrseq = devm_pwrseq_get(dev, "bluetooth");
> 
> The pwrseq core then knows that when the driver calls:
> 
>      pwrseq_power_on(pwrseq);
> 
> It must enable the "bluetooth-enable" unit but it depends on the
> "regulators-common" unit so this one is enabled first. The provider
> driver is also in charge of assuring an appropriate delay between
> enabling the BT and WLAN enable GPIOs. The WLAN-specific resources are
> handled by the "wlan-enable" unit and so are not enabled until the WLAN
> driver requests the "wlan" target to be powered on.
> 
> Another thing worth discussing is the way we associate the consumer with
> the relevant power sequencer. DT maintainers have expressed a discontent
> with the existing mmc pwrseq bindings and have NAKed an earlier
> initiative to introduce global pwrseq bindings to the kernel[1].
> 
> In this approach, we model the existing regulators and GPIOs in DT but
> the pwrseq subsystem requires each provider to provide a .match()
> callback. Whenever a consumer requests a power sequencer handle, we
> iterate over the list of pwrseq drivers and call .match() for each. It's
> up to the driver to verify in a platform-specific way whether it deals
> with its consumer and let the core pwrseq code know.
> 
> The advantage of this over reusing the regulator or reset subsystem is
> that it's more generalized and can handle resources of all kinds as well
> as deal with any kind of power-on sequences: for instance, Qualcomm has
> a PCI switch they want a driver for but this switch requires enabling
> some resources first (PCI pwrctl) and then configuring the device over
> I2C (which can be handled by the pwrseq provider).
> 
> Patch 17/18:
> 
> This patch makes the Qualcomm Bluetooth driver get and use the power
> sequencer for QCA6390.
> 
> Patch 18/18:
> 
> While tiny, this patch is possibly the highlight of the entire series.
> It uses the two abstraction layers we introduced before to create an
> elegant power sequencing PCI power control driver and supports the ath11k
> module on QCA6390.
> 
> With this series we can now enable BT and WLAN on several new Qualcomm
> boards upstream.
> 
> I tested the series on RB5 while Neil tested it on sm8650-qrd and
> sm8550-qrd.
> 
> Best Regards,
> Bartosz Golaszewski
> 
> It's hard to list the changes between versions here as the scope changed
> significantly between each iteration and some versions were not even full
> series but rather RFCs for parts of the solution. For this reason, I'll
> only start listing changes starting from v6.
> 
> [*] This is what the docs say. In practice it seems that this delay can be
> ignored. However the subsequent model - QCA6490 - *does* require users to
> respect it, so the problem remains valid.
> 
> [1] https://lore.kernel.org/netdev/20210829131305.534417-1-dmitry.baryshkov@linaro.org/
> 
> Bartosz Golaszewski (15):
>    arm64: defconfig: enable ath12k as a module
>    dt-bindings: regulator: describe the PMU module of the QCA6390 package
>    dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
>    dt-bindings: new: wireless: qcom,ath11k: describe the ath11k on
>      QCA6390
>    dt-bindings: new: wireless: describe the ath12k PCI module
>    arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
>    PCI: hold the rescan mutex when scanning for the first time
>    PCI/pwrctl: reuse the OF node for power controlled devices
>    PCI/pwrctl: create platform devices for child OF nodes of the port
>      node
>    PCI/pwrctl: add PCI power control core code
>    PCI/pwrctl: add a power control driver for WCN7850
>    power: sequencing: implement the pwrseq core
>    power: pwrseq: add a driver for the QCA6390 PMU module
>    Bluetooth: qca: use the power sequencer for QCA6390
>    PCI/pwrctl: add a PCI power control driver for power sequenced devices
> 
> Jonathan Cameron (1):
>    of: Add cleanup.h based auto release via __free(device_node) markings.
> 
> Neil Armstrong (2):
>    arm64: dts: qcom: sm8550-qrd: add the Wifi node
>    arm64: dts: qcom: sm8650-qrd: add the Wifi node
> 
>   .../net/bluetooth/qualcomm-bluetooth.yaml     |   17 +
>   .../net/wireless/qcom,ath11k-pci.yaml         |   28 +
>   .../net/wireless/qcom,ath12k-pci.yaml         |  103 ++
>   .../bindings/regulator/qcom,qca6390-pmu.yaml  |  166 +++
>   MAINTAINERS                                   |    8 +
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  123 +-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   10 +
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |   37 +
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   10 +
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |   29 +
>   arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +
>   arch/arm64/configs/defconfig                  |    1 +
>   drivers/bluetooth/hci_qca.c                   |   31 +
>   drivers/pci/Kconfig                           |    1 +
>   drivers/pci/Makefile                          |    1 +
>   drivers/pci/bus.c                             |    9 +-
>   drivers/pci/of.c                              |   14 +-
>   drivers/pci/probe.c                           |    2 +
>   drivers/pci/pwrctl/Kconfig                    |   25 +
>   drivers/pci/pwrctl/Makefile                   |    7 +
>   drivers/pci/pwrctl/core.c                     |  136 +++
>   drivers/pci/pwrctl/pci-pwrctl-pwrseq.c        |   84 ++
>   drivers/pci/pwrctl/pci-pwrctl-wcn7850.c       |  202 ++++
>   drivers/pci/remove.c                          |    2 +
>   drivers/power/Kconfig                         |    1 +
>   drivers/power/Makefile                        |    1 +
>   drivers/power/sequencing/Kconfig              |   28 +
>   drivers/power/sequencing/Makefile             |    6 +
>   drivers/power/sequencing/core.c               | 1065 +++++++++++++++++
>   drivers/power/sequencing/pwrseq-qca6390.c     |  353 ++++++
>   include/linux/of.h                            |    2 +
>   include/linux/pci-pwrctl.h                    |   51 +
>   include/linux/pwrseq/consumer.h               |   56 +
>   include/linux/pwrseq/provider.h               |   75 ++
>   34 files changed, 2678 insertions(+), 16 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
>   create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
>   create mode 100644 drivers/pci/pwrctl/Kconfig
>   create mode 100644 drivers/pci/pwrctl/Makefile
>   create mode 100644 drivers/pci/pwrctl/core.c
>   create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
>   create mode 100644 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
>   create mode 100644 drivers/power/sequencing/Kconfig
>   create mode 100644 drivers/power/sequencing/Makefile
>   create mode 100644 drivers/power/sequencing/core.c
>   create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
>   create mode 100644 include/linux/pci-pwrctl.h
>   create mode 100644 include/linux/pwrseq/consumer.h
>   create mode 100644 include/linux/pwrseq/provider.h
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

Thanks,
Neil

