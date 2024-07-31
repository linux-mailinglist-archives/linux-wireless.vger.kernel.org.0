Return-Path: <linux-wireless+bounces-10715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506A94271A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7ABD1C2138E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DA183CA7;
	Wed, 31 Jul 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fe/GF8iL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22065170858
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408093; cv=none; b=WY8r7D4HPvE8kRraVqc/ecEZZxLCT4AHmXWyTbRdn/tJVpXv6yduCqOpcJyYELs2RswB7MWI8rb9lwA8xhOCp50qG6QFPrmJONb81HtPi6OUduy3PNuk0DjXk9Dium3hRLhs7A3MjPf60R31vDhbNC2eneac0NZfjwnMOi6vf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408093; c=relaxed/simple;
	bh=xAM5KuCUk7fhZ0Bjto448CcHX5hPz++gECDIEyxNyJ8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j3gLv5zgsuShAWhzN8tzdmandUQVR/1PZmQ2qU9b2urVNDR4M1hlkUI99tfB87Uc+NJ3ABE4gCyCZtRHhymuAuxK0oHO9fXNmbGC/s/C/u0wHJTdsaLiCz8ishOT8z2eJ0l1EG36MHvZBtYO0Gw2UYx9znV3vQoq2pFqj1M7UYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fe/GF8iL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1e31bc183so170006085a.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722408090; x=1723012890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzcsKxSamtz5qYylBq+mulofl7DNdl/8yBGrG+evBvI=;
        b=Fe/GF8iLsPMNu/gtWyxDLrOrBhgj8eKUJW+JtQ2NPfIsWqHNmcoScqOH36SAlZeZTO
         T8Ky4GrvXo3TJOjiNoCyPK9tXwzSFGBUGoJkcGailaK8afqea+y9dwJGWs/bE+mNtgIW
         AeJhYEG/UzZOWiFYsLXozy1chmtWWXOLEqOxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722408090; x=1723012890;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzcsKxSamtz5qYylBq+mulofl7DNdl/8yBGrG+evBvI=;
        b=En/0/Pb/vgEuB8h/IGzoiy+5CyiB8YFjJJLKuy4TSW0JC+pGcM2bq9LVIKa65l+TZP
         i0WFNqigFqMAC0jQUD+cGRegxztEVu3srAxkjHPf8cGzAFXynEKMK4HCMhtkb7VbgQ39
         vkejY1gUkDlQO+pcB8m1u79K2AaNOmnKWHGVLj9FAugnN5B4vUobO5ssXc/roT/y4uEO
         aqPzrkIMjjKAFTRYxgst/dmh8Me9QPtoXABAP88t/CoQ3L/pKAFrQz2Y1C0IF5hoaIh8
         vjiaqX/uIlZgXCTRZbI3E5RaFQkk4tvV2LYRgSKZOchnCEjZagF3JFca2HhmW4a7Kl0s
         tB6A==
X-Forwarded-Encrypted: i=1; AJvYcCVdXhK5rxKPAG087nqniOQTwURbvs8W1X076zU+jLM8EKMDrjrnWME4GOc666uE9T9/XEWlsObVSbMBmpvm8a6WoCLWnEhGqobSz51RsbY=
X-Gm-Message-State: AOJu0YzMmZ9RVtoMV6xS7v9JuSGSsVxSMurWZgOUTzFKri8CFC/aRTof
	ba2kCanefY2qrKxy8t6YMkmN+F1zZ8BGZVwIq321KzQj6gTpqV+lsdknJNQwDQ==
X-Google-Smtp-Source: AGHT+IHVSnCSNUiDXZ50W1IsLXQBwnHUTc3D4diJbcUDSRlur70rvvyzQTE+g2F4ctDA9qBB1UnD+w==
X-Received: by 2002:a05:620a:4494:b0:7a2:e53:3f67 with SMTP id af79cd13be357-7a20e534344mr1952685a.19.1722408090009;
        Tue, 30 Jul 2024 23:41:30 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ed33bsm710259685a.58.2024.07.30.23.41.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 23:41:29 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Wed, 31 Jul 2024 08:41:24 +0200
Message-ID: <1910785a220.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240731061132.703368-4-jacobe.zang@wesion.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-4-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v6 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 31, 2024 8:11:58 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
> pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
> device under the Bridge1.
>
> Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts 
> b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> index dbddfc3bb4641..b80a552dad883 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> @@ -283,6 +283,22 @@ &pcie2x1l2 {
>  reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>  vpcie3v3-supply = <&vcc3v3_pcie_wl>;
>  status = "okay";
> +
> + pcie@0,0 {
> + reg = <0x400000 0 0 0 0>;
> + #address-cells = <3>;
> + #size-cells = <2>;
> + ranges;
> + device_type = "pci";
> + bus-range = <0x40 0x4f>;
> +
> + wifi: wifi@0,0 {
> + compatible = "pci14e4,449d";

Probably need to add "brcm,bcm4329-fmac" as well here.

Regards,
Arend



