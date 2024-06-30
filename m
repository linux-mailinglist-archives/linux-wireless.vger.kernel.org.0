Return-Path: <linux-wireless+bounces-9720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825AA91D092
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00C11C20A4B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41135464A;
	Sun, 30 Jun 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="owHN3d0h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC4328DB;
	Sun, 30 Jun 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736535; cv=none; b=ZX5e1PfveI8eY9zE8MARi/cG3biXT5KQdNni7Px6fxtuLFH8MfcMN3VU0/z55EQ10xUmc5g4Rlxd69OEiCArI6YO4Sc8d1G4+AJqW/Nli2/MAzsx05vj13mIydzpKIDwex3UI0HAkoykuqJ1c6gym3R3TXBy8noyivJBfZbVKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736535; c=relaxed/simple;
	bh=UdAZcz7sF3V+x4EiHQxZboxN4EAklCWmNZbgp/Wt+iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+8T1Trrj/xcokwhyn0ahmq+HYH+G+87xNfa3kLWEGC46XRhSlAIMyDnQoFquDvg9Axi7uwTK9G7SsY9QUd6Gs6NS3Xj61UKOU0Wc5maPLVsKAUo2Lt8QNL01X8/dD47kIX6pEYI/lE+XGrRpxTC6fIHrtM9EbEz5H9ppJyo9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=owHN3d0h; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719736484; x=1720341284; i=wahrenst@gmx.net;
	bh=Vwmck4SqN/LIrhQ5ULy5n57HmEqJ1YegM2ToIs2Xv3I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=owHN3d0hbZhe6okqbBvO8MkrWT+Df8VjtPThBYkw8H+Nhb/94q92jpml3L6mvKGn
	 QLDhb85Q4QPPdWOozMCz9RAqjiAQaFwIWCXC7hyPiW0/hJuo+UOWR2lOG9LKfrqvE
	 1vsugUtVUSfrmP2sQ+rzNDXI+iuVqsWX9/+dEvxBKtgIt070I/PqZa2YJeoGtREqO
	 k00qz+DkWxw7pnZ7zVhf8UJxOgsfS8+jbRu4VXzhaHYGukAYFCHTSTi3KSJGyLQKG
	 WcJ83QrEVFCLXadIvbN+LUUzQta3cUwd585np40E8Tcgp8AqTQC8eVxt/Yzgd/ie1
	 aEDbH0q2En9mmRd1+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1sotLa1VGE-00PYEP; Sun, 30
 Jun 2024 10:34:44 +0200
Message-ID: <54132213-d81a-49b3-939e-17ff755e39c1@gmx.net>
Date: Sun, 30 Jun 2024 10:34:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
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
 <20240630073605.2164346-6-jacobe.zang@wesion.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240630073605.2164346-6-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XxGQZAfXR1hQ8gGJThtcJYjgRwwQ/OjlTnfcyny8QN9L5ROqzA1
 AuIlIzUR6+gmGdnWvJuPJ2LyVMr8jK8bNyvKuyBK/lMvWs05XCN8+zF5zmy6MKctx3sFRvZ
 BgCFiNbZzbH34BVmY2/7bEbSjA4ooRf28UGi+z6KaodkBRGkPTVDKctJfF8C5bp84zc0LbW
 vIHK6JXtJTgvRmgBGW1eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:je0KjnUnzP8=;jq3fWTpqLb01n8BfJCqn1b8LsD1
 oQKxEK1JiGVE28fIPYNHAFdkGNPxdzpWFeG4NFrHIzot52cRuy9kwWc7ycN51Vk8wY2zsuMG+
 FAFMBr5n5m6lj/yq5rSjhWB8Uku03fMP5P7Efxt8BolJmFrH3rOnVgkTcxuOn21CTthUmG8LZ
 e06tG64lsee4/4rob5t/LyceKjvnBNJfjCdzexz23J0N4QKs5mFguJgebm4gLpc+ttKk8iNkM
 4RWw9GXv3mr+RilYD8XojviSD//p/4RDJgKGeKYkWRWBAOh4Zz446/4rb8nRiHWxAo26EFjLc
 SPijpPkUF28BueX5Vd86XxdivMI6rykPTJUgmcR/NIA7FAQs2LuOGKngFL9VLERJdnqK/9wCE
 WDT7+7DKA8lTvA4GsgIdFxYH/ARBnuHRO5CG0LjSQUt5+Mpo3RnMSCsqjCIwxN8mVhwOAPCtq
 heazzf9lny+6V17dTl3Q9xlqEEBfMqzub3tkcw6LJQI2hhsSP7W1on7BCckhfNeyjV2Kymf+d
 Br3GcBcaxkTGQ6y7ZgfHc+4p9dAVSaGIusx27g3WH1DFJlVDQCZ1FOPOxBNaOJ9/9Xv9g5Cdn
 n1W8E2MRI/X56JU6X1hfwYO+loSNMhYbogDlfn64hrmFPHWikcPEukuBJZ53wEHYoOVxSUenq
 v8tdJafjQfJtdE61DL2np7G6CinAto3MzAM9M/pTBVLpcZ85FlcQQuFuhc2D7uI4qMeqSaSO9
 YrBqRl5KUayy1caFCM2oA3tWKFhpcEgqEl4mMJMHlnBNEl1fQzydal8dLSa+VjhAPaAG+RheX
 BSCWW8Fkf+Jo4PLxSLfhvgQq+aqtG+L5e12Xv5gx8YLVs=

Am 30.06.24 um 09:36 schrieb Jacobe Zang:
> This module features BCM43752A2 chipset. The firmware requires
> randomness seeding, so enabled it.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> Link: https://megous.com/git/linux/commit/?h=3Dap6275p-6.10&id=3D1a99573=
bc8ed412e60e1969c0b29d53a0e5782e0
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 5 ++++-
>   .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 2 ++
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index e84f562fc91b8..f427d664cf3a5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>   BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>   BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
>   BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>
>   /* firmware config files */
>   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -105,6 +106,7 @@ static const struct brcmf_firmware_mapping brcmf_pci=
e_fwnames[] =3D {
>   	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>   	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>   	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>   	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision=
 ID 4 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision=
 ID 3 */
>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision=
 ID 5 */
> @@ -1721,7 +1723,7 @@ static int brcmf_pcie_download_fw_nvram(struct brc=
mf_pciedev_info *devinfo,
>   		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
>   		brcmf_fw_nvram_free(nvram);
>
> -		if (devinfo->otp.valid) {
> +		if (devinfo->otp.valid || devinfo->ci->chip =3D=3D BRCM_CC_43752_CHIP=
_ID) {
As a reviewer, i would expect an explanation in the commit message or in
the code for this quirk.
>   			size_t rand_len =3D BRCMF_RANDOM_SEED_LENGTH;
>   			struct brcmf_random_seed_footer footer =3D {
>   				.length =3D cpu_to_le32(rand_len),
> @@ -2710,6 +2712,7 @@ static const struct pci_device_id brcmf_pcie_devid=
_table[] =3D {
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids=
.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 44684bf1b9acc..c1e22c589d85e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -52,6 +52,7 @@
>   #define BRCM_CC_43664_CHIP_ID		43664
>   #define BRCM_CC_43666_CHIP_ID		43666
>   #define BRCM_CC_4371_CHIP_ID		0x4371
> +#define BRCM_CC_43752_CHIP_ID		43752
I think this should be converted to hexadecimal to be consistent.
>   #define BRCM_CC_4377_CHIP_ID		0x4377
>   #define BRCM_CC_4378_CHIP_ID		0x4378
>   #define BRCM_CC_4387_CHIP_ID		0x4387
> @@ -94,6 +95,7 @@
>   #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>   #define BRCM_PCIE_4371_DEVICE_ID	0x440d
>   #define BRCM_PCIE_43596_DEVICE_ID	0x4415
> +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
>   #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>   #define BRCM_PCIE_4378_DEVICE_ID	0x4425
>   #define BRCM_PCIE_4387_DEVICE_ID	0x4433


