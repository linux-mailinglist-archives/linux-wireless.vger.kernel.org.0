Return-Path: <linux-wireless+bounces-9722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1491D09B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3591C20A4D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463112C478;
	Sun, 30 Jun 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="leQyA7z9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1613B2BB;
	Sun, 30 Jun 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736673; cv=none; b=cyCNn+PbhrnLDVPvWapoyMMDuiqYTlYPgexJf/3RfH0xVZgZbd6n/MSL87HY+OzVhbeA9IdP+VhRIUWDQpgG55nJhcQIjovBlRRDZz58LXB71wv4iRf8XkZBjB0pXFIoIQw+oZqwbV4+DivHPgTPyPnWdf3xvZdA89mieLQv/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736673; c=relaxed/simple;
	bh=m7SPGv3WP6LQSC9lHJmB/zEMbv+ujKxdEygp4TG85cY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X7mX0TVr5AmNJmWL7bAsOaVi0+IEO8aC7doxr9gdEieCKqiPUpksWG3MchhP3vP8M0sx2RnNcP6EQOVu3SmBJIkAXRdKOe0eqqB2UoRKht7SpwnAQIVjzZySugZfeB6LVujXwDL1wMapo5OBCA7n2766/A/Qd/Jj4YoreI3o2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=leQyA7z9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719736628; x=1720341428; i=wahrenst@gmx.net;
	bh=m7SPGv3WP6LQSC9lHJmB/zEMbv+ujKxdEygp4TG85cY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=leQyA7z9W87JGINBHNPdn8wHsvS7b51WwGVc437na+ilFIpt7fKrPl6ngCqcNMYL
	 WVjSC8T8MCS6G88yDRcBO9JHMulM5uGRAVDtdn0qXCEO800+TLQbUIfX6snFompKN
	 e3SPoEpBAEC7lb1XCsDbcO/EBf8r/vWMJJ+B+K4daYFMfSCug6PovMQk/WLPjpSMz
	 i0MlVoFFtutQxnetrr2u+9kiLALXEJBQwOVRRlbkRatnl5n16nhqdK6HZ5jlRqICD
	 AehB3nttbp9ywVqvTqKmNeWLB0eATnId9lciTWpjkkM2xwioGZQqtkRixJW/4ywMR
	 Z+0Ckz9xtt562b33OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1se4fB1rED-00F7fR; Sun, 30
 Jun 2024 10:37:08 +0200
Message-ID: <6170552a-b6f4-4609-8ebf-084d1e483aff@gmx.net>
Date: Sun, 30 Jun 2024 10:37:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
From: Stefan Wahren <wahrenst@gmx.net>
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
 <54132213-d81a-49b3-939e-17ff755e39c1@gmx.net>
Content-Language: en-US
In-Reply-To: <54132213-d81a-49b3-939e-17ff755e39c1@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oX71Ut7Ci3BssJi9OnTutdlaP7ZlPNk/0PHWHyMCH/0YZ4T5TQc
 iLG8n7o3yCmivo6Y4wkZqKpTOsdaYElpqL2/gG6al6XuMbRkd8W91u531w6HhFuEXCpfBY0
 Nk8eeGY/hJxxr7A/zvCj3DfFShVVr22X/y+jMCa5DlSyA3Xu9WGRZ4NNKrZWgk5I3liqOC6
 Gb2OlYY9n2FvrN5+eJREg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ePwModwulY=;dkb3w1s+c+OHICUOJPpIDYYjP6H
 DGmXnaE2dZeno3diDlyFZw39rd3Wzqwpi3XE2B46bbumLDauhNYXpqmdS6z4A3/dEx8IaGkhM
 iIEvBA6TnCL17r8qqtUUgjqmnMPZlgUErtepkVrQ8WAwyUlms4/CZFiEEnuGXmAjWnLSVsO8F
 T73ljIYax0E0eZzMxF3sxHowt77QuKFhN1X6++jkZVOuwgH0Zep3gMs5utcTeX2oQkp+HvUUx
 +JQ5vMNSwxJHUY29eHDlLT0UAsZ71TsJtxti0iX1tIo+1A2b5wWgefSF2kvzGqeflTq+R7Qhp
 ZUkDz+oW318xCqmfO/NKlsp8scMU4nilr/YYDVB4UwTWQoqbWpxqy7zc+qUBYubv1FU/0EcO3
 JpTTIsxOPkVxMez71eqB5SLvnvttWUM8i9Dy5EJym0kdQhyvoguEtzSwp+hdw1ylh/IDZkxjd
 bVVKqAKsMsix+fJ69ohDLcazP9qZmbaeaV7WSfn/KYbMrYe23XvJv/FmEcFI6xVVtiyjFLg3M
 Qi+eBPUtNmaF/xGI6/EvZeb2eZSW+fklPilBmSsNI7Ay5bMAn1SoZdjTZOz7pN/UF5GqZZokg
 tUi3Zeg3U6SuQk71n/JHPA6Lytu9askvRIqjAtQnlTUQu4Gcl7/SYvtWW264xJQ3U8E7yt9Vf
 SL6ohg2tYe2jWuHZV5BAo0dYJzRv6kaVC+pUbvBSHR7E4GtCviA4J0T3yhhZFUvdPqiKOlBqN
 HE/WzDbBsKNyQ/gu/QkysKgORaIpM93HZrQc7XoPgbCYFFJABNklvrI8jBN8vfErnhiqb0nz/
 tJ+QlBrct5pjL1jzaMdkxXBZEP1HkvnIu3yOvnDUYGVlA=


Am 30.06.24 um 10:34 schrieb Stefan Wahren:
> Am 30.06.24 um 09:36 schrieb Jacobe Zang:
>> diff --git
>> a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> index 44684bf1b9acc..c1e22c589d85e 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> @@ -52,6 +52,7 @@
>> =C2=A0 #define BRCM_CC_43664_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 43664
>> =C2=A0 #define BRCM_CC_43666_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 43666
>> =C2=A0 #define BRCM_CC_4371_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x4371
>> +#define BRCM_CC_43752_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 43752
> I think this should be converted to hexadecimal to be consistent.
Sorry, please ignore this comment
>> =C2=A0 #define BRCM_CC_4377_CHIP_ID 0x4377
>> =C2=A0 #define BRCM_CC_4378_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x4378
>> =C2=A0 #define BRCM_CC_4387_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x4387
>> @@ -94,6 +95,7 @@
>> =C2=A0 #define BRCM_PCIE_4366_5G_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x43c5
>> =C2=A0 #define BRCM_PCIE_4371_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x440d
>> =C2=A0 #define BRCM_PCIE_43596_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x4415
>> +#define BRCM_PCIE_43752_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x449d
>> =C2=A0 #define BRCM_PCIE_4377_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x4488
>> =C2=A0 #define BRCM_PCIE_4378_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x4425
>> =C2=A0 #define BRCM_PCIE_4387_DEVICE_ID=C2=A0=C2=A0=C2=A0 0x4433
>


