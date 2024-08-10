Return-Path: <linux-wireless+bounces-11254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C194DC2B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BE41F21771
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68214D70E;
	Sat, 10 Aug 2024 10:08:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A11E86E;
	Sat, 10 Aug 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723284517; cv=fail; b=DT0UYEu9uDNI9aSo6i9aRwqBAyONBh4XE15oklQ2x1uv/QjaaLHBG/N88Q4hYpN4rPRaQtZ1ZLJ92c9T3yHzU2fh03j4RP6l9oHubuCVVfGCl2TJD/aD7GMQXwQhMFKuY682JJCFZbV4TH35fRKtvp+zJReIf86Wslk+yC8bpWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723284517; c=relaxed/simple;
	bh=SlnebxKQnbabn0+I2J5UQN/TbXOdArukuexAhFIcyq4=;
	h=Message-ID:Date:From:To:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5ieiT0ZuJmp5pCQFhHcX4dUxDZUn1cRTSdcyygcavGBG/o8acGPOqG2y1w9XpiA63Vc708z3CR+2Wimu/UO+MksxbLJvN6PUo+H5RfmvuOeT1KOBzMsO9Ls1sDQupahxoVPk7L4gjRlDgsazDMR3Ki8x0rYu3GRYH9TVr93HYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAZyCvC5gsyDn2UQIrS/oQnHd249f3cUFBU2nSco9ms+4agkcAv/n+As6cAesK7OPrrHUPjX+tUD6gwYlQQhn9mAFTMl8gk3+A1yww5JbeLicn1bGe5Ft/0MbzEItNFLtSa7QfJQ9hhZo93IRmGoUEYTcLn1j/bmkJY9mkoMHf9GwkO5xEfDfJ9BE4fMcGFfWgf5UNqAlf6dz4Nsgyk8lBmmOdDBNYEVQk26jgLeD36UJshMk9Ly1DA7W8CVHRPi/Pzj+vjGLtohktGoXWxX3AqyEr36hlBJVDabxFb0kEBi4WpMuyVQUAODJYjNDA7pG0wpfiGfxinHy3rFhaeXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXf+ztt4XyZKMzvAvrsZMSyqy8BX9/rnGmq0YXwWxMA=;
 b=gDcNcvz7+hcp5Px9aphbW+oKfEV1k18En+GQrmjHOi3mlOVQ1R13xtA2INNv38ZbmXgIqRzTnc9FGIYdKgbnqh7ClBhfd+7MTA6fnSyWrtc1C0u5tgq1hBsYaSSl/IqTLnbY9dXZVd+YZJ56GtfkTBDzwSRuuxNmpu8CsmEK9oRlaolrn3Mv287MckwiP3kkTLvv3oIABnkNgfFNoWFrgyhB3TcVPJhTxHj/9UIr+JgaFjksnMgrIH+6aQSHnj9e90E2HF9RF0U/2WlQKiHamapHvMdOF5qqk5l9eawX9yCXqFUbJY+TpfW81Tq0hlnAi0R+TUB3i0UaXnGQaS6tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SI6PR03MB8708.apcprd03.prod.outlook.com (2603:1096:4:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Sat, 10 Aug
 2024 10:08:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 10:08:29 +0000
Message-ID: <d9a182e4-c620-476d-8eb2-752dfd1ba4f8@wesion.com>
Date: Sat, 10 Aug 2024 18:08:21 +0800
User-Agent: Mozilla Thunderbird
From: jacobe.zang@wesion.com
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "efectn@protonmail.com" <efectn@protonmail.com>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arend@broadcom.com" <arend@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
 <megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "nick@khadas.com" <nick@khadas.com>
Subject: Re: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
 <20240810035141.439024-5-jacobe.zang@wesion.com>
 <BY3PR18MB47072A9CC7E1EEB4BD1FC063A0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47072A9CC7E1EEB4BD1FC063A0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SI6PR03MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cef6b90-e4a7-4473-7fb8-08dcb92461e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG9lNlFoMUtvZ0UzSDRORVd6MWRTWU42ME5YeG9kWXpvdjhRWHZ3OWU1dEQz?=
 =?utf-8?B?RWdMeDFkYVlPazQvQW42dmRtT2pSdzVnOGVlblVYMkkySFIxQWhSOXRvT05N?=
 =?utf-8?B?c29XM3YvSjJGQjByWUFSOFZUWk5NMU84cHNMQTlSVVljODQwWis5cVdlSWxn?=
 =?utf-8?B?MTZ2aUtrUHZpWDVJZytHOUh4WGovdVN3U0gyeEZvdC9qSTd3a0ZTQUFCeDVI?=
 =?utf-8?B?d0pUN2ZrZ2g5VlF0Tm9wWHVMUml5b21KRHR6bnROeEc4dlFuaUN5eE1icmY3?=
 =?utf-8?B?UU00SzNZU285bjRER0szV2prTVA0WHMrUXJNN1A5V0hpdnJNUklIaTlmenhW?=
 =?utf-8?B?VWRZZzdkTmtTU3JNd1JrbGV2c3hIbGRlYjZvWHNMQ1RxMVdlY29PWGxxdlFN?=
 =?utf-8?B?SUdJUjJLY3Q4L2VPWDBPam9IZE9LeHRwL1Vtb1FZQXI3ZnJldTFwV3U2Vk5l?=
 =?utf-8?B?K1lDQnNKajRCV3g5TC9FS2dURHhmL3p4TWNoRlBKZitqT1FpSkRKNlRzY2Ew?=
 =?utf-8?B?cjhLWWRLa1RZZWlpZTRWVnhySW5pczVRdVlyREoyQWFkS1dvQ1pHbHRCdldR?=
 =?utf-8?B?NkRNbktIcWV3Ny9ZL2Y4ZmY3QzN6a0I1M3F0Vks1UklOUE9JK3dYcDdXMnMy?=
 =?utf-8?B?MFh2Yk9NeUxIcTEzYzZZd3NPUDJNbGJYb0JZQkNodmRZOGhjQWtBc1RXM2dF?=
 =?utf-8?B?N2RSRkRuMS91cTVUVkNJbjZtTk9aeU45SU9wZ1Y1VkRrc2VNK1Z3TU1qT1Nv?=
 =?utf-8?B?TDlrZXRCdzhZOFI1b09UTlNTOHZTYWRMRTZIMzM5UHdQRnBTbXVxOUhKc1d0?=
 =?utf-8?B?MWZ0UCs1MG93ZU5qZXNqa3hSb3NvUlBZNmVCQm9zK05XcFVuVlk3Vm45OFlM?=
 =?utf-8?B?U1Z2eXkyM1ZKbHRzbDllVW4rbWUrQXpPOGs1anlCY2lqNFdVS2srMWk0MCt3?=
 =?utf-8?B?VHNlbmpBSEMvTnhmaUxVNzlMYXFjdFVpeDZFTHV3cmlBUmxYcGlKVllXQnpH?=
 =?utf-8?B?dmw3N0g5dWswWHVzZnY4SlBFZW9mYWMwL3dTUkFIOWZ1N2JVQ2lKdHMrcTVi?=
 =?utf-8?B?QThWcXNQTU1LUkNpOEJYQ1ZDRmw4NjNHYmt0WGM2M0x4TlZPTWtCdzZXTm5z?=
 =?utf-8?B?YTY3citiek8wYlpySTRSSlQyYTV1ZjFUTGdYNWpxUU84WGQ4SCt2NzE4OEZO?=
 =?utf-8?B?YVBKSklLSHlySy80T1d4TkJlY0M2enk1TTBHR2FqWmJGWWIyZVdnaHZEUUlx?=
 =?utf-8?B?Q3lYRVRlOHpIcXRCSlE0Vjg0a1BKNFFJVDR0NWQ5VzBBanF2eWlHMEhRNlUv?=
 =?utf-8?B?NVV6T2o5c3dXdnR2Wm1GTEpXOHArNHZHMjhUbit1VFYzQkRjUFVKbk81a05W?=
 =?utf-8?B?Vjc2MDFHS29ZYUx6YWNwY2w2K3orVExreGkzbmZkdHU0RnQ2QnNicG5Ca28z?=
 =?utf-8?B?WE9tb096WnlsbDloZHpiajZzRVNTYk5XSExRS3hOZ1duQVBEMmZ4NkF6NTlU?=
 =?utf-8?B?THVLWWk1RS83WGJMZG1Pbm9xeFlkaFhzMm85ZVl0ZW5mS2s4Y294MzZBYm8y?=
 =?utf-8?B?RTgyVk4vMERrdXNtV1lQZTJKNi9Jd0JORGRiWjJ1MUdBRU9CSzg3aTFWV3Bk?=
 =?utf-8?B?eWZhR0Z6VGh5eXBPdjJUczQ0ZTErN1FUcGZnckFJZlEzd2loR1RFMEpLeGgy?=
 =?utf-8?B?ZUJOTlJaVkxDQStBMnJmQ2NHWGRyMkUzKzlPZTZoMVVmd2xsOTFDd2IzQ0dI?=
 =?utf-8?B?bkM3ZnZwRFFReCttYjhHSUdLTDBON1lsM21oUnRGV0VWLzBFYXRVdE1IVndZ?=
 =?utf-8?Q?qvtMxUF05DSOlS5YZIn+BYDBF8lA2Z+wis/2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxOSjB5K2RhSmxaeGpqcUFUY0VYaWVJVjlxUVcrRm01Z081c2Eza1FnK0hr?=
 =?utf-8?B?RXdLNHh3WUMyNEhQcnQ1bEF1YTIrRit6TDZlVGZ4aUtWWTFobmdpd0p0UlNI?=
 =?utf-8?B?WmpvUEVLTFFMSXhBckZtUW9rRi9ObGdEaVN1V0JWVDR1TVFUZlBwMWlNU3A0?=
 =?utf-8?B?cHpnbXIvQUgrYlNHTG5rNU8yWjZYSkI1REJ2YitqdjAvVDBOR0srSFIvREo5?=
 =?utf-8?B?SFRUZ3JybGVIUWMwdmdNNEl5UERsN3lRUHFUUVdDMGh4VzVZdk4yS253eVBm?=
 =?utf-8?B?MDc5Vk1ZdS82ajdpZTE2V3pmUG1FL0ROZFRjeTFlUStGNmZqamtkVzBJZGVt?=
 =?utf-8?B?ZWZSSjBCYVZYSE91aUJlNDhnUWhHbXdJUFUvSUdQTkVxMk9OT1hJYkcrdjRV?=
 =?utf-8?B?a1dST2ZPYzROVkRGNlo3WTZxYjJkUi8wTlUvTGhTTi9zU3ZOa3JVT3o3NlAw?=
 =?utf-8?B?U3d4WXR0YXNYKzJ5MVJPZmRVeXRIblk1R201T2pwNkNpRlJkN3k0K1NYZGlK?=
 =?utf-8?B?dHEvY1NSUEFXUktiTmpiV1hzbGlpS0hMMXROT0lPVWdoRjg0V3dFM1VOQUFJ?=
 =?utf-8?B?N3BNelovRmlicHNscnNQUTBrcVQ5SGxDd3ppU0dncWRxMHRpN0luUVFkS0tF?=
 =?utf-8?B?dU9aUlIxQmlhSmVucEZwZDlhS3JOSHZjRE1hU1FId0hpRFRkbFMwbDNzSVFT?=
 =?utf-8?B?ZGp4WXJSUHdsMjJna2JxZktpNXBhVW5vWkJtYjRJYmdpOE1sRzRKYjAxcFZl?=
 =?utf-8?B?OWR3eWJ6WGNjRFRDY0dvQkI1d3p2SE1ab3RnbUwxMHl2QVp2dGt5czV2LzlD?=
 =?utf-8?B?K3NRd1RaN3QyeWIyc0JTQzF2WmFyWHl6OHBwMTlCb09CWUFxcXZmZmh2WURH?=
 =?utf-8?B?a3ZaRUxiU0ZWR1hLb0ErclUzZGtJY0NUbm5jZVl2YmlhYnEwZnBURGw4b1hB?=
 =?utf-8?B?amxobVJNT0RQWUlyWEYxSmZuR0hBQ29HdmdWMThnckFNVDc2bFM0eFBSR2c4?=
 =?utf-8?B?OFNsT2ZDQnNNcitiVmZleU1EQkwyMHBQSkZONHNFblJTNWpxYXJ3a3N3Q0ZQ?=
 =?utf-8?B?ZTlGVU1iZjZpOElLYmNhUjVXbTdtTjFGL3I3dXIwNEM4dGd3L3pLZFdUUmV6?=
 =?utf-8?B?SWdJUGhtZkJTNVVKQU1YTG9KbUJ5SFF6QzJHa2lvcGVpaklyUXZXR3IzdHN6?=
 =?utf-8?B?UDJKNEFyTUx5enZNd3ArYXZyNThObm9aNjFHT3pDaW1HU0Zpc240OGxaQ21M?=
 =?utf-8?B?ZUpmTnJxa2RxUWRueG13blVkcjhLL1NXaG5ON1RsRDAwZnRYTUNucmcvNnBs?=
 =?utf-8?B?R0wzTDVRNUMzczdRb2xwU2FlRktOcC9LbUxHWG0yVTFscS9aU2VYT3c1YWg2?=
 =?utf-8?B?dVplNi9yTkVnd0xKaEhsaUJKTWVKRE4wRHV1dTVnY053aDlMN0x3V3FMVzFq?=
 =?utf-8?B?WWhmZnJsWnp2SDNicU93SkN6VzZIMHFlMmdOeWJmam1xam1rMFhBMzJaczVP?=
 =?utf-8?B?YzZJNWVuUUNPczJIeEtvL3NJdWRQVmQ1SjZkbjhKd2RycnBZbVdma0tKcms1?=
 =?utf-8?B?bjAvUU1ScTdUOGk4djFUTnhWZFlNa0M2TDZvdTI5SzQ3K0J3L0oyazNkbnJU?=
 =?utf-8?B?MDF5dG94emhlRW9Ec1d0NDVudmNpUTIyblJXMldzdzlobVZKNTlFR1JjZXdx?=
 =?utf-8?B?NTRsWlNSSzY5bEE3TUFKUjdTRk1wK00vWUhsVG1wQWhzNXo3MmNkayt2Wmdv?=
 =?utf-8?B?UTY0RW0wV0FLVFRVdC9acWpSNlhPcnlXeGVpYUNWVUJoZVBKWVNYN2N5TjE1?=
 =?utf-8?B?LzZPTDNWU21PNWl2YVNRbDUwMlpld0s5RUZjMmkyZ0NoM3NJQlM4TTNWRnRn?=
 =?utf-8?B?bC9iSFY2cHFmUkxlazZhYkNxZlRIM1pzWnFDNUtpZnJqOGRiYWo5OTI3cmp1?=
 =?utf-8?B?b2thOXRkOG5aTjhlYVBOS05MM3JwREZIODZPYWRWNzQvaXBsYzZjRUtLZ3Zn?=
 =?utf-8?B?SURhN1NtY3V0MkR3b25wS0VZWFdpRyt2MS92bmNYa1NPd1V5b1lZUm9vY0Rv?=
 =?utf-8?B?N0hsL3YxK29GVjV2K3h6YjNDT3BHdGI0djhzdTZCOVF4c2p4ZUh2V3p2d1VO?=
 =?utf-8?Q?DrssXKw7Gdr1TMocdlBJ88JBr?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cef6b90-e4a7-4473-7fb8-08dcb92461e2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 10:08:29.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DctH8cX/51Qq0My4TlQJvHP6GHjRavR//Ia0KlOTvqFou8VPLz5voSwKZ69vNSGq2e14fK+U0PNQm2bQUkTm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8708



On 2024/8/10 17:44, Sai Krishna Gajula <saikrishnag@marvell.com> wrote:
> 
> > -----Original Message-----
> > From: Jacobe Zang <jacobe.zang@wesion.com>
> > Sent: Saturday, August 10, 2024 9:22 AM
> > To: robh@kernel.org; krzk+dt@kernel.org; heiko@sntech.de;
> > kvalo@kernel.org; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; conor+dt@kernel.org;
> > arend.vanspriel@broadcom.com
> > Cc: efectn@protonmail.com; dsimic@manjaro.org; jagan@edgeble.ai;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> > arend@broadcom.com; linux-wireless@vger.kernel.org;
> > netdev@vger.kernel.org; megi@xff.cz; duoming@zju.edu.cn;
> > bhelgaas@google.com; minipli@grsecurity.net; brcm80211@lists.linux.dev;
> > brcm80211-dev-list.pdl@broadcom.com; nick@khadas.com; Jacobe Zang
> > <jacobe.zang@wesion.com>
> > Subject:  [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock
> > enable support
> >
> > WiFi modules often require 32kHz clock to function. Add support to enable
> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the top of
> > brcmf_of_probe. Change function prototypes from void to int and add
> > appropriate errno's for return
> > WiFi modules often require 32kHz clock to function. Add support to enable
> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the top of
> > brcmf_of_probe. Change function prototypes from void to int and add
> > appropriate errno's for return values that will be send to bus when error
> > occurred.
> >
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > ---
> >   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
> >   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
> >   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
> > .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
> >   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
> >   .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 ++++++---
> >   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >   7 files changed, 63 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > index 13391c2d82aae..b2ede4e579c5c 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > @@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
> > *sdiodev)
> >
> >   	/* try to attach to the target device */
> >   	sdiodev->bus = brcmf_sdio_probe(sdiodev);
> > -	if (!sdiodev->bus) {
> > -		ret = -ENODEV;
> > +	if (IS_ERR(sdiodev->bus)) {
> > +		ret = PTR_ERR(sdiodev->bus);
> >   		goto out;
> >   	}
> >   	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > index b24faae35873d..58d50918dd177 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > @@ -561,7 +561,8 @@ struct brcmf_mp_device
> > *brcmf_get_module_param(struct device *dev,
> >   	if (!found) {
> >   		/* No platform data for this device, try OF and DMI data */
> >   		brcmf_dmi_probe(settings, chip, chiprev);
> > -		brcmf_of_probe(dev, bus_type, settings);
> > +		if (brcmf_of_probe(dev, bus_type, settings) == -
> > EPROBE_DEFER)
> > +			return ERR_PTR(-EPROBE_DEFER);
> >   		brcmf_acpi_probe(dev, bus_type, settings);
> >   	}
> >   	return settings;
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > index e406e11481a62..f19dc7355e0e8 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/of.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/of_net.h>
> > +#include <linux/clk.h>
> >
> >   #include <defs.h>
> >   #include "debug.h"
> > @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device
> > *dev,
> >   	return 0;
> >   }
> >
> > -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> > -		    struct brcmf_mp_device *settings)
> > +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> > +		   struct brcmf_mp_device *settings)
> >   {
> >   	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
> >   	struct device_node *root, *np = dev->of_node;
> > +	struct clk *clk;
> >   	const char *prop;
> 
> Small nit, please check if reverse x-mas tree order need to be follow here.
> 
> >   	int irq;
> >   	int err;
> >   	u32 irqf;

It can be seen from this line that there should be no need to follow the reverse x-mas tree order. Because it is a struct variable, so place with other struct ones.

> >   	u32 val;
> >
> > +	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> > +		return 0;
> > +
> >   	/* Apple ARM64 platforms have their own idea of board type, passed
> > in
> >   	 * via the device tree. They also have an antenna SKU parameter
> >   	 */
> > @@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum
> > brcmf_bus_type bus_type,
> >   		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> >   		if (!board_type) {
> >   			of_node_put(root);
> > -			return;
> > +			return 0;
> >   		}
> >   		strreplace(board_type, '/', '-');
> >   		settings->board_type = board_type;
> > @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
> > brcmf_bus_type bus_type,
> >   		of_node_put(root);
> >   	}
> >
> > -	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> > -		return;
> > -
> >   	err = brcmf_of_get_country_codes(dev, settings);
> >   	if (err)
> >   		brcmf_err("failed to get OF country code map (err=%d)\n",
> > err);
> >
> >   	of_get_mac_address(np, settings->mac);
> >
> > -	if (bus_type != BRCMF_BUSTYPE_SDIO)
> > -		return;
> > +	if (bus_type == BRCMF_BUSTYPE_SDIO) {
> > +		if (of_property_read_u32(np, "brcm,drive-strength", &val) ==
> > 0)
> > +			sdio->drive_strength = val;
> >
> > -	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
> > -		sdio->drive_strength = val;
> > +		/* make sure there are interrupts defined in the node */
> > +		if (!of_property_present(np, "interrupts"))
> > +			return 0;
> >
> > -	/* make sure there are interrupts defined in the node */
> > -	if (!of_property_present(np, "interrupts"))
> > -		return;
> > +		irq = irq_of_parse_and_map(np, 0);
> > +		if (!irq) {
> > +			brcmf_err("interrupt could not be mapped\n");
> > +			return 0;
> > +		}
> > +		irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
> > +
> > +		sdio->oob_irq_supported = true;
> > +		sdio->oob_irq_nr = irq;
> > +		sdio->oob_irq_flags = irqf;
> > +	}
> >
> > -	irq = irq_of_parse_and_map(np, 0);
> > -	if (!irq) {
> > -		brcmf_err("interrupt could not be mapped\n");
> > -		return;
> > +	clk = devm_clk_get_optional_enabled(dev, "lpo");
> > +	if (!IS_ERR_OR_NULL(clk)) {
> > +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> > +		return clk_set_rate(clk, 32768);
> > +	} else {
> > +		return PTR_ERR_OR_ZERO(clk);
> >   	}
> > -	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
> >
> > -	sdio->oob_irq_supported = true;
> > -	sdio->oob_irq_nr = irq;
> > -	sdio->oob_irq_flags = irqf;
> > +	return 0;
> 
> ....
> ....
> 
> >   /* Detach and free everything */
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> > index 9a105e6debe1f..f7db46ae44906 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> > @@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct
> > brcmf_usbdev_info *devinfo,
> >   		ret = -ENOMEM;
> >   		goto fail;
> >   	}
> > +	ret = PTR_ERR_OR_ZERO(devinfo->settings);
> > +	if (ret < 0)
> > +		goto fail;
> >
> >   	if (!brcmf_usb_dlneeded(devinfo)) {
> >   		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
> > --
> > 2.34.1
> >
> Reviewed-by:  Sai Krishna <saikrishnag@marvell.com>
> 

--
Best Regards
Jacobe

