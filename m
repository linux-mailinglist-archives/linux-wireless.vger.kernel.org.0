Return-Path: <linux-wireless+bounces-38102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EpTONY6PWqHzggAu9opvQ
	(envelope-from <linux-wireless+bounces-38102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:27:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21AF6C6A05
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:27:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=f9FsrxA8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38102-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38102-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D13E8304EA25
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3DC374E55;
	Thu, 25 Jun 2026 14:25:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013080.outbound.protection.outlook.com [52.103.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8536DA1F;
	Thu, 25 Jun 2026 14:25:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397508; cv=fail; b=Ek2JH4jCmWi43dktpJjyx+mRIbW80YeZRaYU/bSQ2UOI/wFr50PS9vohCgOnfIFmOV7YKaNVgC/LP6IQ1LkN0XXpx6x/3J0i2H+QN5126pGKcvs2EAoVRhLA6RUEexyhKlG0mig103Ay9S0MFUrWBSeL+hFaiSy4ti6sosapS00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397508; c=relaxed/simple;
	bh=QXMjPsbLeLaacEWqZ4530hUF414/zTYYbViKR2WL638=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbOYNyj+0CEqubFmP+ciV3gl5CaoNqJ+bjRN4SxPZOYFO4b2p0OMxWgZubOYtZq7hnUs2r4jf2usaVLRTeDIFR834NO2oLTgElDPK3fOXSGUWqn7PARVpxyXyI5XDgXvmmirxJ9dbNUlLmGtnhlaJ1mTiyPKHcc0tSF/I3iBLe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f9FsrxA8; arc=fail smtp.client-ip=52.103.14.80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ztx/9WQrzyr+G5Bd8QPV5r+D3VUujlwT7m1F0olZ+8cg3vDlYsC4h0tHqsjfJenU4LvWS9dPgelfglrcptA/ar/gr4MwA4VZlY7eye/i1V0m3zzij+0zC9iDqT9173fzAsWV6AflLESAbwFrRwiagvU8I/vay5ngcTQsOveoZE26gLtUbURF2ih0LsbmtmtXxdU508jNXmd0xR/cVM/yj2CY6Fx06pWl3w2vZ0dUYJaBQJe3uFDsytt+54VghwBAbXW4JyQuJ6g00oeuRoQdyQdzJu9PDaWReuMGnZ+t/TZqPC9eXiRwgBwWmdBL5S09awaO82BhHjbNwJSMgi2Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5f9VsYJwLq4AYpPqV2rvGHdoEUUyi99/rKpR3Dw37Y=;
 b=cek61uSJ93+otlWMo5I1t+ldsRLns4beCfUod7ErJ8vXZjN8TLysCRRjg+BU3/F6JRGp/8vcdHV5F3SlDqWaTLN4mrnwjyTMIM72FW/ujaUZb75YW3SGqZoIXJmcCtpm9C2cAhCLEPclQmHdL3rDiS9a0libSWFJ0kd9G9I2AJZopsGXsfUujPc7RfRO4m0mrBNkQR11X9zoyqWVYPWXyI0/gw/p8wfHfWuZ+/QjxTmmoCIVlEBNI7zdu0yYcwLB1AcUnM8i+nI8pKj5YJjIIEAnZ58eiu4DNtnnUai5Qmfa1ZuSwNOrBNu9czNHBjGPXzAkBU7QwzRETiXi+ptZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5f9VsYJwLq4AYpPqV2rvGHdoEUUyi99/rKpR3Dw37Y=;
 b=f9FsrxA8GpiEXy9hRHeSNNccVs6Iv0eoNcunMXs9Lc1P6fVnF43gIegeahd1vJ1KPPqtsLYRaR9Nd7ARgYG6kUQM/jCYn5l0RPgXAydBtLgfr6WSwSef9isEpdDJxM7Xn7eB830SvWhbxNLjES685imqGdcaHKilJNWf7bzOVgCMwaKG0JpMVqspuCZChRYqwOTFF0E/l//CbW3Q5kxevI1SFx/WGdStJ683bgjQnFxpQyYsyCSmUu0Z54WReX/3eRApdA4CBaCKQBt7UvQ36/gokKxbcRLC2jLDEL2GAfA2tawftvGGSj8okr9H/Dz+h0la8dHnDF7BA4Zh2mE5/g==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by SJ0PR19MB4622.namprd19.prod.outlook.com (2603:10b6:a03:28b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:25:03 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 14:25:02 +0000
Message-ID:
 <SN7PR19MB6736656C55BC6DA32A3E75CA9DEC2@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Thu, 25 Jun 2026 18:24:48 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
To: Philipp Zabel <p.zabel@pengutronix.de>, Jens Axboe <axboe@kernel.dk>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
 <439f76c3fcafdfb91cca426fcae17ef776776eab.camel@pengutronix.de>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <439f76c3fcafdfb91cca426fcae17ef776776eab.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::22) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <aab339ca-6b5c-472b-9737-87d41e49e8a4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|SJ0PR19MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ef7d2f-83b5-4fcb-7ca9-08ded2c58b11
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6cUe9t9Fs5HiQGsDL5YS4Qs2BZu8RFnRVvnmRZ50OLmZvuZddTIKQYBJDJ3dcbD3MjGALgl4piH4lEY7nWQfLnigh26shyJrzR0iaVV0q/zQmEsbLxBgIDkXm/L1wyOMTKpF4jB9lK/Unf5SU4v8/ESc9wgvqTMq0MrxksKbrAQTsTXwdzjINiNXm0UixeQvUY7A0jx2niOf7+HoH4MOdqXKrQhRUf3eZGFIZj35V8cuGwjSwJu0r7baLWc3mS0UrIAoio0GAN/VU/Dl1ajWzzrNzt1SxtV9F5YQB8jyK7yJOxvz/06QOulIsIMkr+NhX9MthJE4CelwFV17hOMH8VOn9lZpayf1DZvj6ZEDkaEHSOIVEJw6bsdrpc96XyCPCRtUn5/xvESko9bdjAiH75lblNu12hhw5gcY/BY63eLQsRfInl7bFo5R57kMuU1meV12GG8oalsj4uRpRFzzehxtwgE2Eb7/RtrOO774ixxsSWmPxziJ0lnvgJ59BVO8MEb8Y1S8jb+eI5NmKQnWUNUcN/7n4Cx/6N+j6/xvkUvDzcJSnGTPbIGYaONdiWM/4J0mkpUPAl8xPjs/KzfK+I7r1BNRKugDkdxx2XZP5pKs83uj5Df1tbX7FqfCk9rAF5Mx4DTZNULrTQ8pIuFIO83XkemQZQRcAMQurIZ0twiA1547/NBhk8LG4J5+eSqiceHopoO2Pw+wPKW96tBakwxBGnks+VWBDhWeLpQF8rnPq4bXYmZ4U6FWju6HWmJ7i4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|15080799012|25010399006|23021999003|37011999003|19110799012|5072599009|8060799015|41001999006|6090799003|24021099003|53005399003|40105399003|41105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjQyTmMzNVBJYW54eHdzekd0Rktoem9kYm5IanIvRHFWZjNuSllVZGp4cVFj?=
 =?utf-8?B?WTZlWDRvRXFOeXZMekNxV2VFd0F3cjBUM3MzQW9zTWUyemM2c3puZzMxTzR1?=
 =?utf-8?B?U0Y3UWZtaGNZMTkzWS9lZmgxVkdaWUpLVlBYYmdDcmltQkdVdThtR2cxbjVH?=
 =?utf-8?B?aVhZcjNrT1MwUVE4TW1Lc0RFa2pRUnVYVnpGdnFSd0hxeXFsZ3JzbDJnNUEr?=
 =?utf-8?B?Skk0SEdFWTJLMEN5OGFOcG8xWVdkVGZ2SEJ1SzA3aVAxMC9nbVN2WDU1Y0pH?=
 =?utf-8?B?TG54VmEzc3htVmdjM1F1QmhxYVJFQjJQMWVaaTVxcjAzVHA4eVowNXNCcm5Y?=
 =?utf-8?B?dWx4UFFXUzladW5GQ1Fzc2ZVbCtPTGExRmpMTHAxNnFXQk1aUFFBOXRiaUZQ?=
 =?utf-8?B?Q1QyeGV3Mmp1ajNUS0k5dUpDWm5QN2pXbDdDSG1OVGl1Sjg2cGhlODVoSFhj?=
 =?utf-8?B?NWs5ZFRlNU1XbkpzSEU1UGdFYUkzY3g0bzU1blVPUjQzaTNycmQzQ3dEckhN?=
 =?utf-8?B?Z2RGS29BdzRmWlVBS2tvdTQ2dWc0SklhditwVVFkME43bEdMUXMwNGxVWnUz?=
 =?utf-8?B?dVR0dEMwM1JNMGZjSmFuMXh2ZjUxMXBHd3ErQldPbWhwdG1VcUJ6cWtSMW4y?=
 =?utf-8?B?UndWTVJKOHdaN2FRZjcyV0ZIdHo3MFlKdmJ1eVpjc2xJdGxHbnh6UjhLbWJi?=
 =?utf-8?B?TlZYODM3eUhTOGxuNytnME9vVTVyYi9EcnBpZmZ2MUdtM1JSdkhzZngwZWV1?=
 =?utf-8?B?RUVrdGFnQTZNbXB5Q015RTdQOWtSU3IvMjRtVlQ1a1JsdVBYMzZibjl0VTBH?=
 =?utf-8?B?bStwMEUrdmRHSTJMcWFCVWxkRjF4cGF6RWNaL2kxai9LdWhWQzNrVnJLS05a?=
 =?utf-8?B?RmlMM1diTE1aYkIyWXpNSVJaMTYyZ09takFwQkdHbGFNT3hSM0h4VmNFalA5?=
 =?utf-8?B?OE9ieGtxaWxHeW5EemwrL29GQmNPYjB3NENkK1gvbG1JUE5CSTBNSE8yU0ph?=
 =?utf-8?B?S2NyLzhEcE8rVWViUU41dnYxeDlLVGNZdXNvRDVUTXlkeHVROW10RGg2eklk?=
 =?utf-8?B?MGpzcWVQcktER2UzQ2U5TFMzTWdxY0ZTb1o2KzZtN3JBSHMrL0JMaUJrTEJF?=
 =?utf-8?B?TWFlaG0valFEbTdZNGZJK2g0WFdlb2RHZFBjYU9sbXJpWlJ5RUJEdHZmVFV4?=
 =?utf-8?B?TlBYVTBVdDZTUndhRmtOVGxSWDcwRitWYnJzUmdZWHdQTlFSR3owWDdnVkl4?=
 =?utf-8?B?ck9ub0phSElodjZSMXM4TS9xVzRHTXNsYTZFYVNFVUp3RFpoUHdGWm1QSlNK?=
 =?utf-8?B?TmpnZENWWjEwa0R5a1ZHM3FoaHZudWo2czZMVU5GMXBTdXNiWjVVUzBDem1a?=
 =?utf-8?B?MDJpYXBLQlJ4V0FydUluNFBNOE9tSFAzVHZBSStYSjcwZWJjN0hjZWpwUllZ?=
 =?utf-8?B?elJMS0hacjgrZXlDQ3Q3bEcxSVQ4YmJqTkYyNGtTQjM0bVVFVEo1TU02MTNO?=
 =?utf-8?Q?BvQPYo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnVVd3c3UCt3UUVtdGp6WklMdlowTWhaaDdxdUZiZHdkbGtaSGZMejBPQmU3?=
 =?utf-8?B?UkxkemhUTHEzWnFjU2xNc3Vtcngyc2IzdHJSS0xTSzJlTW9uZm5JU2FwUTJz?=
 =?utf-8?B?dWlHZTAxcjVJbWgxNzF6WFNVKzh3S3MvT2J6RTN3RlFKem4rOFh5ZmZpK2Va?=
 =?utf-8?B?VUs2VSs4OEg3L2VVQW5iRWhlWUNXQ0FQSTMvVEdXem4ycmNpTUI1SmRURWxO?=
 =?utf-8?B?c2ZVb25UY0wreFphb0NVZDlUSm96eDduTEJtQ21vZWl6Z1dQTjd4YVdKdXNo?=
 =?utf-8?B?VkJub2xEbE1SNTlLelNvMVJUeTdRdURiYktjbmRTY2RNdWRrSzhBRWpXMDFq?=
 =?utf-8?B?NmVIODVmR0xTcEdjOUE3Y1YrVVBOcTcwY1ZuNVN2dkhPTFF3MEpHZU5BT3o0?=
 =?utf-8?B?eGx5Z05WQitDZkNkNGNsRHNRS1c4RXBZUmhiUTNnbWtXSDRSZEN0UGNWamp2?=
 =?utf-8?B?MnJqUVJKYWVONHRYK3M2OTlhYXpKcGlDNytjZXZ2VUQzdmlmOVdUVXR6NWdw?=
 =?utf-8?B?SDZ1bVhEWnVoN2gxQzRiTDFXWGxSd2V5dk9zbDkyZUJKbXgyRzFQcHA4bWIv?=
 =?utf-8?B?bHA3c0hFeGN3K0JIZFhOdjBFWTlnRHYyYXRXRzlEZmlUWEFteVBEdVl5N3lx?=
 =?utf-8?B?SjA2VThTUDMreTFqamprcTBpajZYMW9PaTM1UW9IVnF3Rm5xODQza01Yb3Ex?=
 =?utf-8?B?SEw3MXlvK2VnOVU4dlNPaWZDaXJBSXBOTVhJWXllQ3kzWXdFcVNVSjI5cG5a?=
 =?utf-8?B?VmpvbHF1ZUFRVHRCMytvdHhZUXZ3SkdqKzVhS21rYno1SEZYMjV3ZUI0Zkx2?=
 =?utf-8?B?RVRIdmcrTUdSdWlhWFJPcktxK0NLNTRPaWVHd0JnVUVzblpmSm8wSmlGdTkx?=
 =?utf-8?B?bnFkSDZqZEJaZ1M4Q0pMaDluQlBneURRODF5M2RZNDB4SDZzZk92L2pINXQ0?=
 =?utf-8?B?NXlRRzM3NDE5R2hMQTk1VXo3a0NIeXlPU0UyRXU2TkJFalh4WnpvYjlCSTJF?=
 =?utf-8?B?aUN1MC9yTW1NYVhSNENmQkRtcE85QlBCZ3NETGVmOFZiSWxoSmptc25JOGJD?=
 =?utf-8?B?L3FCQXUwWlVzbWRXT1RBdFdYcnJmWTZtODZwb0piZmRHa0YyNENqUXVoNDZM?=
 =?utf-8?B?bGx3bVpnR1l0Q1NYYVpQRmx1NENDcnV4VytyaHRIZCtiVFcyU1o1M3I5QVpI?=
 =?utf-8?B?VVpiWlB4bW1OMkVzZVc3VHFJdzlVMUV4cWk4akZNZDBBZFdCZDc1QUc5UlNC?=
 =?utf-8?B?R0hWNXAvdG1BVzFsbS9wbFZiR3lLK1FkMnVyYURIY2VaWXhsVnM1MitxcXcw?=
 =?utf-8?B?M3ZtdDFoMU5NS3RLLzc4aFdxeGZERW9nRHp1a2RZODVFaUI4eUZIdm5BcHRs?=
 =?utf-8?B?aHZwdXBJU0swRGdMU2lqWU54bTl4bElDS2Z0a0tHYllLL3IxZkxUVlZwcXhx?=
 =?utf-8?B?eStWV1RGRWJBZEs0QVE1UlpoSFVrdGYxVGdURXd1L3lCbHhHZUFtTktQQjI4?=
 =?utf-8?B?OWlPdFhISVFQVWRVcnQxVk1HejdaRGc3OTRMT0VqWFVQc0NxVVZSNmZxd1Qw?=
 =?utf-8?B?Z1VOZWY2ZE5ISVpvUkRrS1QvVXN3T08vZk5SZ3RPWXFPamduNEVvaWIySmhh?=
 =?utf-8?B?U2lRWWJFNnBSUEhVOWdsUEdnTXEyTW1abXB5K1UxeEVXQlp3YnM1eUJXOXdD?=
 =?utf-8?B?MjUvOUUrSG0rRjZBNU1tc1lKUXRNc0tMVDYzYUV1cmdJRExaTnVLdUpka0Q3?=
 =?utf-8?B?TXRtbHNCTjVCekM2MzBRTnNCTkhVY29mR1dCMVNsMzd5ZTJlQVZtTFczUEVi?=
 =?utf-8?B?YmpuSkFQRzdiYm1TMGM3OS8xUFcwZ1RHZThqVWZVV0FsQkVIdFhoNUNLdGgv?=
 =?utf-8?B?OGc4M3R6emlIN1c5dWZsVStpdlVMQWVkNXIySStLV0l2aFE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ef7d2f-83b5-4fcb-7ca9-08ded2c58b11
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:25:02.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4622
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38102-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,SN7PR19MB6736.namprd19.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A21AF6C6A05

Thanks, that was quick!

On 6/25/26 18:18, Philipp Zabel wrote:
> On Do, 2026-06-25 at 18:10 +0400, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> Add support to bring up the M0 core of the bluetooth subsystem found in
>> the IPQ5018 SoC.
>>
>> The signed firmware loaded is authenticated by TrustZone. If successful,
>> the M0 core boots the firmware and the peripheral is taken out of reset
>> using a Secure Channel Manager call to TrustZone.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  drivers/remoteproc/Kconfig            |  12 ++
>>  drivers/remoteproc/Makefile           |   1 +
>>  drivers/remoteproc/qcom_m0_btss_pil.c | 261 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 274 insertions(+)
>>
> [...]
>> diff --git a/drivers/remoteproc/qcom_m0_btss_pil.c b/drivers/remoteproc/qcom_m0_btss_pil.c
>> new file mode 100644
>> index 000000000000..7168e270e4d4
>> --- /dev/null
>> +++ b/drivers/remoteproc/qcom_m0_btss_pil.c
>> @@ -0,0 +1,261 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2026 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/elf.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/soc/qcom/mdt_loader.h>
>> +
>> +#include "qcom_common.h"
>> +
>> +#define BTSS_PAS_ID	0xc
>> +
>> +struct m0_btss {
>> +	struct device *dev;
>> +	phys_addr_t mem_phys;
>> +	phys_addr_t mem_reloc;
>> +	void __iomem *mem_region;
>> +	size_t mem_size;
>> +	struct reset_control *btss_reset;
> 
> Why is this stored here? It doesn't seem to be used.

will remove it and use devm_reset_control_get_exclusive_deasserted as
suggested below.

> 
> [...]
>> +static int m0_btss_pil_probe(struct platform_device *pdev)
>> +{
>> +	// struct reset_control *btss_reset;
> 
> It looks like this shouldn't be commented out.
> 
>> +	struct device *dev = &pdev->dev;
>> +	const char *fw_name = NULL;
>> +	struct m0_btss *desc;
>> +	struct clk *lpo_clk;
>> +	struct rproc *rproc;
>> +	int ret;
>> +
>> +	ret = of_property_read_string(dev->of_node, "firmware-name",
>> +				      &fw_name);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	rproc = devm_rproc_alloc(dev, "m0btss", &m0_btss_ops,
>> +				 fw_name, sizeof(*desc));
>> +	if (!rproc) {
>> +		dev_err(dev, "failed to allocate rproc\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	desc = rproc->priv;
>> +	desc->dev = dev;
>> +
>> +	ret = m0_btss_alloc_memory_region(desc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	lpo_clk = devm_clk_get_enabled(dev, "btss_lpo_clk");
>> +	if (IS_ERR(lpo_clk))
>> +		return dev_err_probe(dev, PTR_ERR(lpo_clk),
>> +				     "Failed to get lpo clock\n");
>> +
>> +	desc->btss_reset = devm_reset_control_get(dev, "btss_reset");
> 
> Please use devm_reset_control_get_exclusive() directly.
> 
>> +	if (IS_ERR_OR_NULL(desc->btss_reset))
>> +		return dev_err_probe(dev, PTR_ERR(desc->btss_reset),
>> +				     "unable to acquire btss_reset\n");
>> +
>> +	ret = reset_control_deassert(desc->btss_reset);
>> +	if (ret)
>> +		return dev_err_probe(rproc->dev.parent, ret,
>> +				     "Failed to deassert reset\n");
> 
> Shouldn't this be asserted on remove? Otherwise after an unbind/bind
> cycle probe will enable the clock with reset already deasserted.
> That may or may not be problematic.
> 
> Consider using devm_reset_control_get_exclusive_deasserted().
> 
> 
> regards
> Philipp

Regards,
George


