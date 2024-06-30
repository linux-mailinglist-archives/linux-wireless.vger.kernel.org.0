Return-Path: <linux-wireless+bounces-9723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3F91D0A7
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287F21F21390
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2B12C54D;
	Sun, 30 Jun 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Gqtk2aL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028039AF4;
	Sun, 30 Jun 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719737041; cv=none; b=DFMwl4E2kL9zl2Up46oyu4qi7tdRvGlsSgL4eCkMglFapVeIwmHJqxsQTZ27mhbhtGVm3RN8Drl95pUIL0Y+BU6LQShKZtRr3kSUQeihJZAZlcFphy0OjWSJX2M8q4P3MFPfT3zcfVUZpyUxfGNm1M75QkL6CZ0eazX8wlmuRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719737041; c=relaxed/simple;
	bh=LiuqvRSyYUEcIEYiEIohQUTYIE6wNbj3g07Nvpvw1dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvhcI4nIlopITygdzT8XYxGPyail5QzRS9oP5xppwyGRNFgs07qK5WS/meYe3FUo1UBef8bz1N+Z0kiMg5qx2EyO3xbyMF169Tfi5BMbG7ZLG0ZYqgJQ1YNbXTQYl0I13iwm0PLSWfcV3N8fCQauYABA288fb1oF4ph+aHr90Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Gqtk2aL4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719736988; x=1720341788; i=wahrenst@gmx.net;
	bh=DWHFm2E/o/V6Cw7bSZdgzS7ATWvaFTxO3EAYiMwnYQ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gqtk2aL46vidGporVc+8B4Wm0DTc4MDZqFfMQrhgYmocdhWOr97DwUJHWAkEnqI7
	 dnlLZ9j2DLem/JiB0Rix3qBSGEnIX+7CcHOmC2dldSynU/9qwRKljVhwB4Q7Xkw+W
	 1n2/or4A0pYXL8p5gZcvQihweDBtDZRFAbJcovJezYj+xbl8xV+f1WNOiPmoFZG1H
	 momwphcUGCZQhC8zWsYBB44RjdEY9JYV4D/shWOJVeXVPtZ9h14N/McBhc4H9HUwW
	 i6p9rWmIYpV4Voar2iGcPwHKG5D0CkhABcrBzioaCQ1wE0XfkcWvXVQTqffRMXu1a
	 N1I/c5haTudE5F0bSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1s9k6i2nbY-014cGt; Sun, 30
 Jun 2024 10:43:08 +0200
Message-ID: <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
Date: Sun, 30 Jun 2024 10:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240630073605.2164346-5-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mgMXk3DXRcduwz95csSCv+CkqV380IX24h7ngin2weAe06nSBut
 XRhB1UiQp3lf2b0NYmvfVLy2/mO9OQ7MdSCGUF1luiS5UtcOzG+EOLW42qqlwMhlb4e54Ar
 Ks90Wb/EKJM5mT9LD5u6n2d4dyNSY7FQqhw8asreSyh5xF4QdxvbIl7Zz5Z0NDVEINqzLCH
 2SlZtn7IAjSBasUem///w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mou2LmE+Pqw=;DPg1kwFi8AE287jvIuA+tl/khDX
 kuBJ9gbe+rII+gFJy8tELFBxwny1ffwYSQxDUeKCIWxVv7fO8o1kvYL9dFKhBnM4F26o2hgqC
 ngafc1iyAy51Dt5CPiFzUfhvVXOVOwLh10euaKGwfnZah7nzx6SDpfOEPgZYC03kzqxvt6QoX
 Z5uFSzARf5MExs3Ok3AXzRBBGfm3StKyeVa1D/Y2pm2MjkedX0p4U0CJWFxjQSOly5GChb/u3
 YRX/RtASHZGM/2fOG46JEwsO5hR1mpeSVsoErCprGVeyanNbrO+JhamoGOLFkseSjvavozcVm
 g3yhvrP+lp6YlfqKRAOb2ups6iQeeCIY+rSZUZWIldpBVWZgCXu81Y35kRu7iH75ji9Pw7jv4
 vWecdWERENJSTB0VP2EzumDKUWMA8r5unVHqfjikKygugc3sQHuSZFxSkIMPvuxx5p9QYYktr
 IS4lRAq1EokBMevuY6NDnns9AWp+5oMOXI6V5SYAgPcvmy0ICirTDWujoXRNFQXea+egNu5vJ
 NpSCFAQSAmLhsKL/mPDLh31XJSnZ69M6VYBO9tdQM7T2Yn+qCnc4FYHlve/ULcDS2gaZmvxN/
 NoRjgGDSwxud0ZlxL8r/VzbkR+ViB1wxnYW2h+KLKO1wx2oPkHNOH3vfTt353Z0xZjcTz0IDj
 isq9L2oZDGnq/CF8qTH+wg+UNsRjVx3WeTruimQskvC3KvVz/4zjTJ+5gjoRQImoNi9W0Ng3s
 gzu2uW8uflqzhpk38d5MT2mK3KkqFDm4HTxiEk4EcaAfwzJkuy6Q6frW97wHrGOsGXOoxfpXZ
 HlOq4pMqmz+NNykvuX2Lwl04GbG8TwYzNcgJmXi5srOxo=

Hi,

Am 30.06.24 um 09:36 schrieb Jacobe Zang:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver.
the low power clock is independent from the host interface like PCIe. So
the clock handling should move to the common code. Sorry, not i cannot
give a good suggestion, what's the best place for this.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 06698a714b523..e84f562fc91b8 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2014 Broadcom Corporation
>    */
>
> +#include <linux/clk.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/firmware.h>
> @@ -2411,6 +2412,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struc=
t pci_device_id *id)
>   	struct brcmf_pciedev *pcie_bus_dev;
>   	struct brcmf_core *core;
>   	struct brcmf_bus *bus;
> +	struct clk *clk;
>
>   	if (!id) {
>   		id =3D pci_match_id(brcmf_pcie_devid_table, pdev);
> @@ -2422,6 +2424,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *id)
>
>   	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
>
> +	clk =3D devm_clk_get_optional_enabled(&pdev->dev, "lpo");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	if (clk) {
> +		brcmf_dbg(PCIE, "enabling 32kHz clock\n", pdev->vendor, pdev->device)=
;
> +		clk_set_rate(clk, 32768);
> +	}
> +
>   	ret =3D -ENOMEM;
>   	devinfo =3D kzalloc(sizeof(*devinfo), GFP_KERNEL);
>   	if (devinfo =3D=3D NULL)


