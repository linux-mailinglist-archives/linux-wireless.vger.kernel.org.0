Return-Path: <linux-wireless+bounces-38499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6xqDdgvRmppLQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:31:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284596F544B
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:31:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=YLvyLGm9;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=JzEndoi4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38499-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38499-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 954903043589
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8B412279;
	Thu,  2 Jul 2026 09:18:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105E47884D;
	Thu,  2 Jul 2026 09:18:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983888; cv=fail; b=oDUBAO/Lz6xdWssN7XvNFk0EvxPQ4i8FIlVj+g88eSP14tC61/t+XRpmvpGVtmYOGKLMaxW4QoPy68e3UpDw+NMkOXUh32mEh7VYzqxY3pxB4ASDrbeoW/UO9RHiWAIZVpMrtjLTuW/We+oTbW2/0BpV2Wipnp960D8dWCJX/Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983888; c=relaxed/simple;
	bh=LzOwyxcOv1r27it0+owQdru1wHuv5inpXIUuZJZUQmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/b5HCEM0MH8Rqkyd0ceA+I9vwhtYd3Sz5i3+OSKD/H5WwVcgu7RdffAFiE7Q/2hSQTmMDDejXT6ASRLOT/ZR4X9bY9Goxnjz/EEYu3gdSm+cWBTJEbBX9p0SFku4LcmnYJ+hX/ziawUe2m+6AnZkvot0lh8tN4E1t7DzLIzGS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=YLvyLGm9; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=JzEndoi4; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624oASc309780;
	Thu, 2 Jul 2026 11:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	/NE2NZRr1IsnB5HktWok3cly8eDZjm27oXAaGhCcTvg=; b=YLvyLGm9jkG++DqQ
	QXsgm+3DfSGClg7emJYRfFTnw+TPjnmGM4r3abyFi7i2rLc+M/KVqLEOTCe2fIT4
	QGIJWGsIAyoGmoBBIespXKCVAO1wENTH0Iu7mKNgRf4V+l75O6EnvAAadQjuxPrM
	wT9pGgkJ7SGPePdto5VzmE9itydblhaaPWh2KXmDkKvNKHWZCrSlcXTsf25lqIh2
	z1xqzTvofhqjjfPD2wgvvT/CguMUAW5NV4FP5AHEmzBHHh0qUgR4JUUXMsMS33DE
	7RA2F8Cglzy+uNyvJYjfz2mT/ZL8JCKJJEpB+6vZfRrITxOT/LDPqgX3DTOYyZ4R
	tuHCJg==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023096.outbound.protection.outlook.com [40.107.159.96])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f56sg0x6s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 11:17:45 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suK+/5TKunBTSGZ+yQn9xiXyL3g915G7XNXxITHm2HvrH6Pcz/N5ulKsjsZaYf5BZtlcsfi9OxLaEjDhbbbCvGkzpILFn+6z3MdTHm0jLEp+/q4pmkH4mR7m3Pkt01vTyFg/4O6lMYxZCNg3T8r3b6+dyGvkqbFgTuLc4/wylxHn/5Ic/tal74IsRq1CXV+9P/1bmicFoIuKSCWBw6O0dholP1zwOnuiu3OiZQe4VpNIhUq/HLJxqs3Y5CpXEUjvMaPkiBNsf1VydJIsHQBwxZZQ/y3OH0ctCtM28pg5155n/jp8pGRONcPio4H/CZf175Ds/dmLD564WE+Glk4sIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NE2NZRr1IsnB5HktWok3cly8eDZjm27oXAaGhCcTvg=;
 b=tgN7cxKuxUdBXgn+hhJJaip/l0PS0zBq4e7/GN/sORIQLGsZyK40D/G0McquI/Yqcty0b2Qae09T6QF32rERHJYg3t8u5ISIx76W+5CYMYyMaauE1kHq7VuoGtW7hT1MQLvfPwXA7IAReLvjrdSh2M3Qw+yC2ExeV1XCu3MSVOeTvQ/cYq6C7UyFf1g5x/w7xVQAoXWuVlZP+dT+86260cVtdah7rPsEt+HXu3IrmMetv9FPnlVq7mWAvYfeKhw5YwxJXYomQkVzY/aBwfnkSzIBuCPg7+mKh7IuOjH/CZIuFMGO5nNpCkaQULHBFZ8J9SIqJLTV3OaS08r2yujdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NE2NZRr1IsnB5HktWok3cly8eDZjm27oXAaGhCcTvg=;
 b=JzEndoi4oQ/GFptN6cFgktsCXL36uzEn9aPyamKXUYKTCbm/0IBqbkNnypCxGfZ3oFiDXpW1ih9JUSuL7sucxW3HCodKGhz2jQAibJheHjzk+oEOZsrJsnTWPvyI4D8uavri/BEedQ2EpTkvGsAcetVl/G/B2m6oyeYlOhDxe9c=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AMBP192MB2881.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:17:43 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:17:42 +0000
Date: Thu, 2 Jul 2026 11:17:39 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF0002395A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::347) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AMBP192MB2881:EE_
X-MS-Office365-Filtering-Correlation-Id: 01461a15-eeb8-4a88-7afe-08ded81ac57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nc9fai+lkg5wAC9nOTSlMfSagYNhBwuW97sVKNSocqsYQwFmRiOyMZmllkkzIOxDakK0tz2zxoylxLpeULl0iZUjT3gf+vfxMwGQWexQzx69mPJsyzq2O05PVydPqRjUOkYomYXsTYlmZbTBrjjQynvawKx1TGT8lv5EOE8uI7l8DKe38Nx3aKAts34P7INT7ggDZsORhQV8ygjtFITuh1p7GjMzpHcaZKoC2bBoKtsXGDeb8OwVpQwD5QVt9xIo5Ni8x8NxVbki6T8shlDnNrXe0ltWnQ1B/JqkHV53Df0OXRAPR9IvxEF0keYSJceAw66Q/ZJz4bulHDzh6T30myEUtkdmFdeqdZOal5jwRfLjNqYsASFJDOJkMUpx205jmvX1jblTaHCVGEFEepVNi25V16bJkSbvYakRNdHJ4DIgDwcZMC3QXliIva6wXjY4DPfHd5H4PKd7EQbTc1lonCi5CZ+NYDxuu0zjHwHLUJiBkZMVmPr1H8DnFGsgTn2vukicxPVFEZbXIsTxotJ4ixcPAFjdpTIzZg+ketFx/yoK4X1TCGqQhC7ux3n4ajqVWKh3tSpm7FzTQ4xDShmUPn+sfbaW+6u62sDVE5hrzx4tGzC8+rcnbRDf9AWfF7LYKMZGWP1ldC5hxBsdgQY/ERKabpoSvGVdfM5QHfFrUmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VitieGJad2svRDZhaTNXa0twSUw1c0VXOXJEOTBQU2ZkaFM5Q0NyTnBNbDJh?=
 =?utf-8?B?MXp2VXRWbWdDYWZHY3MzQ2kyZlk0cllNTVFwZ2N6REZHNzhOQ20yNE1HTWxk?=
 =?utf-8?B?UTk2RFJwQ3ZheEhtQU0rSmVVQkRicFllVldaYkZ4RlF4NExXN1J0d3ZHN3pY?=
 =?utf-8?B?NU52M2tPK2E5QnlHV2xma1hMeHM5T1VkcGpzaUJBcEdoYmp2MEVqSE5sVFNE?=
 =?utf-8?B?VFE3TC9uVG5WdmV6ZjlaeGZKOGVPcFN6K1FDZTc0M0RPblFtTGJLY2Z1dU1T?=
 =?utf-8?B?WHVRaGM1OVJvTlVmdlhOcW05Szg3WVBFV3dKcFRnQzJCU1hYRXpZblAxd0lS?=
 =?utf-8?B?dXVZdjJaVXFicjUrTkI5dU1Oem9DWksvVmpYcnJ5U2V4RmRLK081djVublp4?=
 =?utf-8?B?eS9lRWdmY3BIMGd1SHhzWHA3aSthVnZ2RWdSb3ZYWGdKa3QzMlRBNWFGTzBk?=
 =?utf-8?B?RVFXQVhVQkV2Yk5zNXNGcE5zWjhNVHd2aFN1YnpkOVFIeTF1OXltbStuNXUv?=
 =?utf-8?B?Ui9pVFBTTEVrUjc2dU9KM2RrRlJoUmlrSGZYNE1iQnMrbkc0LzRHQm1heDI5?=
 =?utf-8?B?OTNzbXBMZmplR1IzV1BmakRwdEdRTHEyUkVZWGFqS0FPeVVHRCsrSXBRbmZ0?=
 =?utf-8?B?MlZEcU84U0JmL1BlRWd5UDZTc3NzRW5KeEljNDYwSytDdVpmOEVZeEliSm9Y?=
 =?utf-8?B?Uy9lUWpYUG5Ud2RrK3NwYXl5UFBhVWxHRXUvT1IyNzFaRk5SaWgyMElXL29C?=
 =?utf-8?B?cFVhcFNORUlTV3NNeUozNmc2WnlaVm8vSDBVR3RxLzZsVWJiUEFjK2ZmK1N5?=
 =?utf-8?B?dlQ0REZKV0xNSGJrR3Q0V3pPVXFXODUvdVVVVnNPTFVTdHRxY2w5UHpBd3hS?=
 =?utf-8?B?RmhoNGdnLzBWT0x4S0xia0x4akxHMEtsOEZJaU5lYzJXMzQ3dWthem0wK0Fz?=
 =?utf-8?B?b1pmMTkvSGZuRkNJOExOVUtpLzA3NkFFUnA4aFJ0L0lXOUZmclVLNHorRHh6?=
 =?utf-8?B?VFIwK2VWTDA5dENtdGVWRHp0TllBcldYVjcvR3NWeUVGV0lRVGV0VWEyNDVi?=
 =?utf-8?B?a2lmSFVUZnYrdFNVbld5cXNIN2ZCTHhyWXI4MG1qSHRjNGFxTm8wR2g2MkxZ?=
 =?utf-8?B?NzNHV21uRGVSQU45QjNsTjdlamlad041cnRFT1ZCTnllVmcxRkdlR1BQa053?=
 =?utf-8?B?bFdZYlBobVAxZ1B2b0theWNURGtoWkhDM2dLR0c0R1Z1RzI0MkFSb0pvVldy?=
 =?utf-8?B?K1RpYVViWFBZcmlvZHhiR3NrTWIxR295QUNwaERYMDRWZHRzc3l6RjhSRm96?=
 =?utf-8?B?a0I3UXdMY3BFWnBjemNNVzJ6eFJOUFpDVXBCQmIweFBIdWpVVDg0VDBmZzVl?=
 =?utf-8?B?b0x4czczNTR2QmhKZnFuSGUzeEZXais2VkZuRXlRcHZyMGZ6WjNKNU4wdENl?=
 =?utf-8?B?MWRxVVQvSXVhekQ2bGU1MGp3SHNkcEdiYk1jZFBtZ09KMmFPMy92RW5vQnBE?=
 =?utf-8?B?UEdTaStJUDRVYUdLeEdMNXZ4V1JjZU8xTWt5ZjZEUGpPaVdUNjV0dGloRHNm?=
 =?utf-8?B?c3VYNmthVFRsWkVjRTFaMElYdGhpMGFmTDUyNHhuWkhHblRMbmhubUxJT0Fq?=
 =?utf-8?B?NmFlUXhhczNBSy8vWmhlNms1bG9kYmNabFQ1MUpLa3N3UlV0d2hPUEFlL3RT?=
 =?utf-8?B?dlo2K1YxRVZUeS9WSWdyN2NGbUcrYU9td2VINVhXb2RBbVp6cWFDQ0V0czBn?=
 =?utf-8?B?Z2xSUGxhZWorekhvdEdHcUhqOEdZWFh3NjVrUHRlUWlQYkNuQ0prbkthYkh5?=
 =?utf-8?B?bTVDbGZWbFU3a091NkpBTWxqbnlLdmVNbml2YWdBVXdCbzJLMlZMTElCZFhF?=
 =?utf-8?B?YlVWdGxtV1o0NU43Q002cUtVNkdUaWpCWFQ3UWVpdzdHN1F6djNFV1pTTnE4?=
 =?utf-8?B?QXhxWVlSQ1dTTUFUNTlqUjBZUXZtSzlaWWVoNi9pdFRjZ05XeXg0SW5oNFRs?=
 =?utf-8?B?eWtMRFZ4MDhZc0JyYU1VV1QvVVhEcmFIazdpOTZCMjM5TVFVbUlIdVpLVThv?=
 =?utf-8?B?dVp6MjRkeTk2ZG1vMnNvbGpFaitJeWJ0UXJFMG1TVUNicEtkeGtOaGU5ODJn?=
 =?utf-8?B?dk5pS1BKR1ZKN3pxNWZKbkJCWEtBM2NhQXE4eVBSc1BlL2V4ZFpTYzVmdE1i?=
 =?utf-8?B?bEtNcGduMmdUeUFBWEFpQWxCdm0xYmFoSHEwUG4wSllaZm9nVUNzQ2h2bjQ0?=
 =?utf-8?B?eTBXOEJLY0wxZXJQblBKU2huSWZQUHF5ZXJJaEFZREV0ZkR5cjY3RUI1bVo1?=
 =?utf-8?B?ekMxdUVVdCttWGo5RjI2ZlA3eEswRTQzVFpUU2loaEp0ZzVZM1hyUT09?=
X-Exchange-RoutingPolicyChecked:
	QmyIszKaqdloxVgHmki8ai+/q7glzGf5ncGIAmPy27Vi2r+QYQGmcKqVXBeQqtxoe2i1TSlHxTeODg6T8GV8ynIar1in7WFwovlm2h5puac5+NIgK3JUpHeCWa5Aonuv8nh/C0Lry6VUj89qZaEtLaockWTg8HKTBqDbxkUKNw2MDitU121HxdJaG4s2I2K0aYNHfT09GwS9eN67MdF5m/AThKjqvXo57dP8Y+Byt05wAStd6bHY7IiJhqhwQb/7RgPUgLmqVSVqT2tmTbBgI6juBjEh5L8Dn9SiREvlvrd+dHDEBTNAKpIkeh7oz3ChaC146A2f4xpRNnK8ZMuRbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tvliC6AZSB2XH1z1ziL2H9aLgX0JLYXGRESAwrbDcR74G8IPjNOt1attJ1scqauVsB2U1vgcQP8X0MlSSO/hfpVU4p54oT7j6CtIZnP7zkjbva2h4XqNrh2+ibymn7HWFpWcU7GUIR91ChaqYbzPHytAT4aC5owls6oN8svTfhVlo0TyqW7UWpdTQxkMCREeeMHWWJhdUkNcFDr5Y7y7wVEirYawCcsT5nAUcycyb2OoqymrsV55/O0E1Jy4fr1YsSqIk6gYg4KSjO48C81TOfSP1aVmCz4eV8eqX2GXZ4VW+Wl7bsuiOkXOJNMzJqlfhfpZiY9/MEmYZHltBKwiezcJC75J8I5TlMi6gXIpSxJjr0A5rc5GvovMLC1dxbHB15ZdA+S52WbBnnhmCUBrKQO2jyPYYeq2RX61pW3jXW+GEKfksrSm6VIJpoSKDgit3AfnQhq/tyx+Jjycv33XHTaHlSUyBfkuI8DllnYDX6LbC5nJvI3x19ko6Gl1HlDXfISNtDy1tN4SX+tXNNdq2U58ReYAyzZ9ZYLUj2fnkFMOyaPZFt8yiPOGnjT6IUtPeFDJ019ZqohaCehMcAliKA1YnnqehWmbnOJmK3NmTTj2tfVHFwCeFufCvy8t/NY/
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01461a15-eeb8-4a88-7afe-08ded81ac57d
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:17:42.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HwRO47s7mhAR7VRhUsIE4A/4jREJfBPVe6yRPe7MNNsKnPc7rEzAZ/xZl6hQz1v+lItWrJJ06s6J2Y6x87jmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP192MB2881
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AMBP192MB2881.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: 8pb1Ij-ugTD5_qsIZTPTNbr4Y-B1yato
X-Authority-Analysis: v=2.4 cv=OJoXGyaB c=1 sm=1 tr=0 ts=6a462cb9 cx=c_pps
 a=lQ+oGCPpp/jyPwbjV3NidA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=pL2rqk-GtCS1VpCQ2V0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfX4/8B19ksjYuf
 Lu67849v2gJ11QkVa3gFAKANhVc0almgDhyaUnvqranVedPbizflxu5fycdB0EgTdiPZsGuREF1
 24O1ysmlrYH1Vn0FZ85T7/i+RE33Snd7syHD+ozGIG1dfKTI1uPA0hsUwQ92ZUqihEKv7oThIdI
 beVmB9uJePI5Hq3vnfQj03hIOq7IdE8+UKpLXVxl3ZQxGFQ2QGfbT1+8Tp7lGHu1/72gyKmbgm2
 5cTZCCZ+CSp+JwUGXPDXfbPgECQvoQs2U3i2uVCablq8HZ295j3BXr4k1wnJ6hUzjWy12IofThw
 X8++uOE0+ctym3uGSsv0tXbF19okB6TDCOwXGwrIULtWL2iiDGS7UoqdayLE32ptxr5G2pTQIex
 KNg+UgdXYv56yyZaz7oY7X1q7GL2T21eKe3xsehoT2HqN0XZG1G2Cc/MdRWsZz8mbFZ7ltj7qmN
 FDW2LvddANgWPJsiQnw==
X-Proofpoint-GUID: 8pb1Ij-ugTD5_qsIZTPTNbr4Y-B1yato
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfX1GPbPRTzu9L+
 DF5iudP9BoMjIGBxrRnuZelNHgOMJ1/gj0s9iVr1OmJK+WOJ4xb2YbrgOUDgTFHBntVkC3xYzlS
 NRkLFPw/Q07+Xl8+kCWPwQFeRrO8dPo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38499-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,westermo.com:dkim,westermo.com:from_mime,beijerelectronicsab.onmicrosoft.com:dkim,FUE-ALEWI-WINX:mid];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 284596F544B

On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
> > 
> > 
> > On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> > > The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> > > CPU-native data types into an u8 array. On a big-endian architecture, this
> > > later results in a null‑pointer dereference. Convert the data to
> > 
> > Alex, did you find a time to investigate the root cause of the null pointer?

Hi Baochen,

I am now running kernel v6.18.26, and it looks like the null-pointer issue is
gone. I only see the following log messages:

    ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
    ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
    ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
    ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0

Should I rebase the patch onto the latest `ath/master` branch and update the
commit description accordingly?


Best regards
Alexander Wilhelm

