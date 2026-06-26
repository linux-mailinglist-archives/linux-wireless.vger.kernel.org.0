Return-Path: <linux-wireless+bounces-38162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EIwnKVRaPmqYEQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:54:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95C6CC342
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:54:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=XlpttCi1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38162-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38162-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE9E309963F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF13EFFC5;
	Fri, 26 Jun 2026 10:52:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9E3E9F9E;
	Fri, 26 Jun 2026 10:52:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471131; cv=fail; b=WqWxGQKIIbkunhqxVMG7nkEyBEFkVk3yyNumF3liN3wUTVLhUX507yIjXitfv5xt4IPjK2nYLJFxteXsY6hlNT9Yw4+A5r2165a/xOXX1HMXAYRNCG/XbGnLGAoFLc1zJseh1unuG8McY1IYuFg1hSiF+2X+9GYELfyDVrQpXHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471131; c=relaxed/simple;
	bh=KagVugtUndy7S3lvkPmOWcaymXcIiqNi++QsLgxU+Aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgQMCTozXuL2ZM1Iq9KhF/X4unl01zTW5beFaQYbS3+5x6WFixKwoyRNeeQs+XLye8BSq0nF8lERabJ0K0UobJCLFlxTP0Z6sGfHXLxKazEuot2blhg+YhdQgKVYmmyvvQnl5r/i0BKLlZKDFcFLKnBX8uOS3+FX3aS6SRnG/Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XlpttCi1; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USkHDJjxy2243wCXrt5SvhpkB/66kshCzORX/Win7Rt0oE+fqqW3gDjV4k/w6xVGjOgLXNg9C5uC44EwoH10+i9Ye9KatBBjBeRiurIPBBcPvVQPg0/F+itwZwEbMhPyxeNUXNxHg7Wrhy+KZeGRzGChv+6ElwaYes8v+jIZF2lK2y5J5IGk7OXHQcdwJtV7nXyP8pR/PK4TWlrrgZfsFv6WyZx4KKXhK4oteYgxtrjU8dVK8rYwoZWyoS/eulrgj+K5piPLuj/J2IlPkGJ239ZTt4C96wS+xGW++cZMcVofqSLmpTMTzwwD6dQ1Yob9IlkZm687HpSFtrvKFtwrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BuMP6ELx+wz9x92Xm5WHQxzm2LblYETwVD3EpkrZMw=;
 b=vFTURp6zlv5GxwwHXRcWktoMQijEE89oKn84JXrgc/o/JlF8HuyyU4JVcZs0MaBpgx5qTFl/58nTyPhHBB0RVuZ4xlY8UYGjNK3gCdMfgHj8Ouy0Lo9bqZ+bDSyGti8x2XtxqftH5Ubf1ikPU/D7kYCxaaubs0NVfCCTChKZVHLQpZ4ANq2jTqbYmFnuf+PTSM35IMjRO7aXU6YsTFgxuw9y2G2K8KZxnmJF3UjOi0V73H3uv4N/AibhBiPTCi8vvCfN9s4F1bybm5AcZESBxqV5qNH7Eg8haI120HcS7RGAtYenf5cqcolIRQOnz7Nj7kjfnpAhw59tC9XGWfeGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BuMP6ELx+wz9x92Xm5WHQxzm2LblYETwVD3EpkrZMw=;
 b=XlpttCi1liq/Tegka4fQQ2RmJ1/sdRzL1EpsuJFmHQU2rbF8JcAsvBOJuruJPgk/eNH+7PhnI/cBJTUgmopF2YnHXzhzU1WbkaMB+Hn/wc0Ii7ux4I/7KhH18VRJpik5EaR+QEYqXnNsWM92Im3Uog2YN4EvobfUy0s4Uojk6XB1JSLFLH0Tx8QelrfDzLnY2/qjNFX1+XjHMJ37L84CJEOQb7Cckt6V3icaj+dp1RAYCT+FE2uEH+0LwgEwLCfgiLanCbtnH7fT8smGZSL7V6Nvmaz/n2SUkhYLMD7b7wpI37g3gEMLby4QkYzHUPqEVXz4ohJlwItjsqN4XAubyQ==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by MN2PR19MB3952.namprd19.prod.outlook.com (2603:10b6:208:1f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 10:52:07 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 10:52:06 +0000
Message-ID:
 <SN7PR19MB67364ADE8CDD7C31297AE18D9DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Fri, 26 Jun 2026 14:51:53 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: document M0 Bluetooth
 Subsystem secure PIL
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-1-d999be0e04f7@outlook.com>
 <20260626-tiny-warm-jerboa-3ba57a@quoll>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20260626-tiny-warm-jerboa-3ba57a@quoll>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MR2P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::21) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <33aeaa11-1709-4917-accf-01628e3ea82c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|MN2PR19MB3952:EE_
X-MS-Office365-Filtering-Correlation-Id: f8506947-790b-488f-0185-08ded370f64e
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYAYx1xXrBLUWTP0Nof2HmseWKh8PsWsWubJd2LRBi+zjmjNP71+iv9GvB3M+rVTox9nUFQULmpvHPMJEAn/kDGGydDhNNFfgUf+8T5311YW3cin5jl4wBz6BpiH3rS8vYFGxdot9prgLfFcYdDjeKPY2HkYA8qJ+lzPJoFcAO9ass9N9RWfyGY65bWK3Ctd6zcVwx7VRuO8D3M0+Et88lc5ze3VsybwYH34WipoZAPRQx12NYbot1daws8QVOQ5LewG94//lu+HxdGrtOzDXHZNGnrW7xjNQZhfvgo3ge374pvhQg5Q6vpo03nW0D6iod6pSToJwIdRCpJEFlMfnvF6WlVEcoor2Jn1dQ+JbwTF8wpjzoIL47X35R6Gj40YLdO/02Hq7AiT+Pc2L4gr86MwxtiMUXHoxVxPdw4OswxQ/xSk0jybWVIVKK3wUPJuh858kfSx8CS+Nndyu06ZJjKCsPtXcotqMUSNokM/wRrxU778HU7L4T4wPklL9bzu1UIqOr6SbpHmFA+2l7mcFXXjckHHrniHCph14mUrIxUJ31kwc4YEAowCF0HCLCDGkF+9AWGDxlwnVGg+3KtXd+7POqD8YP94J2TzUkUAzp6ixeLScUiSX/UxiTDwLDJd4lxVdosdRxsSyOaKzPshlsQHgFT8FrbCKIOrUS7FwdJOsxdbBEX29azO3rSjfvM2E9NnDupEtpS+8Rtb39p9HiqxdLHWKNYeGPfVK9LH3/NeMWPcDeGJgcbAxX5PvMYvdUZtmZZ1l3vLXmkWnaM0xu1k6qeCfMQNuuyohPO20Woh0eTcW9m+/QcPdRX4ciGqASOSCBwrmgEONw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|51005399006|6090799003|5072599009|37011999003|24021099003|25010399006|19110799012|8060799015|41001999006|10035399007|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkNXOGRlRUI3a2FCOGhrTlQ0VC81clFacm00SmlxU1pad3g2WnlMdzFRWjZ6?=
 =?utf-8?B?T2kvV2pzc1ZSYkNVZjQ2L3kwVDBUUU5kZC9XcUN4U0lMdHZyUDVJb1JBUTBv?=
 =?utf-8?B?dFpqUExESFhNa1dNUVMweWE3anFpY3QwcTUwS3EyNkhmdEo4ak5xcW1ybzVI?=
 =?utf-8?B?TGw5M2kzSk8wMHZEaXlRbXpydVc4R1hsZWYzWHhzbzhHZnBiT2dsRko0ZWRu?=
 =?utf-8?B?SjVlcURFUW5FeExUakx3QWRaQ1dyNXZTdzBrY2lQeE4yS0s2dVgrQWdYN2l6?=
 =?utf-8?B?aGthN2VLdk1kZ1ZIZS9Wd0dob2Jqc0Y3UE4xN1N2bmo1K1IwcnVpMFJGNjRl?=
 =?utf-8?B?N1lPVUcyS01yYmtRYzVEeU52L2QybWZBbFZrdFJBVktKczVmWE1rK0hIQ0Fw?=
 =?utf-8?B?UEplcHhEK3pFTXVnMUZyRUk4a25qMzk3L0hMNldDbWNmRzNZQm85bU40OHc3?=
 =?utf-8?B?RDJ6aE1yV0VQZ1BMdUlXMTdVbGp1cVJLc2Q5MzEzNklRQVVtV0hicWZPaU0z?=
 =?utf-8?B?VzEwVlVsdEJCY0RBLzBmYVM2K2I1ZEVBSzZ1dHlPMHYxOGVQUzVEdE5RTTJX?=
 =?utf-8?B?a2E1U3B1OHU5NGs1YmQveWJ4NWpRMzZhN2xkLzU3WlVORml2WXVOTGIxV1hm?=
 =?utf-8?B?V0Z1emVEajNObkUxTElucGgreDliY0dRNGRESCtncHhMa0R5UC94d1REaWRP?=
 =?utf-8?B?aTVBUlNFVFhWRHd2VURwVkp4UHM0cGoxNTI2T3lRNWx4Z1RHQUp3R05pRWpP?=
 =?utf-8?B?cWR4ZXdCUERFR29ndFZDc2NVZzJvQjduR3BGOUxYYXVtZjExMU0wNnVNd0p4?=
 =?utf-8?B?T3NvbVF3UHkvSURncXdLZ1hYU0ZUeGkwMjZnTWcyRnhPbXFnRzNWaHBScFls?=
 =?utf-8?B?K1lmTitGZys1RU5RZFlUai96N2RDWUN5WnJpeWhKb3JjdU1Vcll4V1c0MDU2?=
 =?utf-8?B?SmJFWUZyaGpzRytoUDNnSHNHR2gvdUh5QVY2SEx0dk9kWjA3VGZsQm9ZR2xV?=
 =?utf-8?B?M21zb0lvam93ajF3aERKcnN2YVZpdThLQ1lzSzBYaERhb2F0RFJLTTU2S0tn?=
 =?utf-8?B?cXRyWTlVczlsQUhyUFFWWmpHU1U3WklrOWRHeWtVSStLcmU2R2ZnSWE5WTgr?=
 =?utf-8?B?ampCUkN5L3VtN2ZWY3FqOGZFc3VoVGhITVViZkJJWjhqZDBIR29MVjRKbHVL?=
 =?utf-8?B?SWVxTGVFeHlKVnd1WUU3NENQcVJ6aEdMOUlzYkdJYm0xV3JMd1NNTkJZR1FP?=
 =?utf-8?B?ODBFUWE2eFlzdkp4Mlp2QmtMOUQwdTJpaTFoNm1OMVkvQ2RCaUpHTnRUNWVZ?=
 =?utf-8?B?ZkhzRmxMWm56TFlya3J5aCtheXFSQmg1MFErbzdiWGlFY2tLbGMwb2tMR0J5?=
 =?utf-8?B?RTVnOXVzNncrc0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVk2QnlWNkpFMG5YdGlwWVNtMFZtUy9NNWttWXBDZGZNTkV1TmxpRURselBp?=
 =?utf-8?B?bU9YNXBmVlhZancxTWc0ZjBQWERXUkk1UklveEFkN3RFK3NyOVRDQyt3V1Zt?=
 =?utf-8?B?djRlTENvZ01jdFRxekFHYXI5NHQ1RGxaajJldkVzR2pJUDZSTUFEZGsxd0ha?=
 =?utf-8?B?ZHpaOUt2UmJGWG5xa3h6WGR4WEgzZFp1ZlRtc0RMbUVkVG1DaXFLY2ZaWUdx?=
 =?utf-8?B?eVRGTGRDMDdyazFkblpSYnF1SW80NnMvUmxEeXhIck96VGlQTU1vVzBKeE1Q?=
 =?utf-8?B?ZEZhUDJMYzlUVjZLaEdBU3R2b2ZwN2QwcitjREZqWWhETXo5SUhxYnNGNDdQ?=
 =?utf-8?B?ZG93NjNndXNXRWlRUkM4cmxPMG5nNndCcjlFU2dzQmJzOXpEV2xFZURvTlNk?=
 =?utf-8?B?TG5od285OWl6MjRWYW4vSGJaY1F3ZkpEWXliQkJsVFNtUGpiQVB2bHBMYzFQ?=
 =?utf-8?B?NW1yT2hPb1hia0t5VFJCNkh6UzV1VzN4b3U2dHBJY2FoNk5xaytTaE9iMlFs?=
 =?utf-8?B?dHdrMXVGSGg4UW03TEVIU2Nhak9Edmdkcjh5YVRnWi9zNFJ0UXMxTlc2Q2RT?=
 =?utf-8?B?WHExN2RPK0NnNXdOMGwxazhZbURPZXV1eVZKN2pzd2M1MUdpQzBMQTB3K05Y?=
 =?utf-8?B?ZGNHRVVMYWFER2h1U1JLOEZBN2F4ako4Z0NrMDh0bTA0VXBpTWQ2ZC9FYWhx?=
 =?utf-8?B?V3VtcHdxQWEyN3luYk5INkpoMnQyYVR3SWNST3hWTFpUdzVPMnoxbWRCRjZF?=
 =?utf-8?B?YzhaL3ZHZVBqNGU4UmdKWDl6L3VldzJOcEkrN2g1UXlYazFTWmF0QUxXbG56?=
 =?utf-8?B?VVI1b1Uza1BTL1JlNHk2UnhUdzNmaUw2Q3IxQ2wwend2QWdWbmxyWGNVRTF6?=
 =?utf-8?B?SWxUa2F2Ny9yRXNOakhUMnRSeVFLYkpZQ1hERVFUS1dOZSswSzIzbGlSWm4y?=
 =?utf-8?B?SDBSaDRBZnVZQm1HUmQxblVSRi9IUnJSOWZsajdYZEdFL3dQMitBOUhYQzkx?=
 =?utf-8?B?cEdwL2VhOXBabWY2dFpibkI2d1NwNHhrZEJjMG9haHhtcGltc0VtdGFWYzdC?=
 =?utf-8?B?bTRFbzBiKzZDcnpXWEZqYVlmaDBBRWYwRjNUbXVLTkJ4cGpRa3NJa0dxZ1VC?=
 =?utf-8?B?dUV1V3ZyekRKUXdQSXZiemx6bWREWUVaVmlnSUVnbWV6bWVxVkhuOTJJSG9N?=
 =?utf-8?B?eU1LaThHZjhBUmZ5VzJ5eDlWWFRHNUlwbDFQOFhBR1NYWGxzaENPTnhFM1Jk?=
 =?utf-8?B?QmRRRW9Ya0VPY08wWEpUOCs3WFh4L1ZoU2JVUk03ZWZZSHhrMkdORVMrR0Mz?=
 =?utf-8?B?OWp3YnNaUGtlSEdyL09wd1VldUltY0dYOXJkdlZoemFXd1RTQzhYZXpNZzdh?=
 =?utf-8?B?c1kzRFpkVFZ6RXIySFFLSlBhZXFhUWtTNjJYeXhMZndubnRMUXpWTEFyeFE1?=
 =?utf-8?B?L1BZVG1ZSkpTREhtYWlyazExdEtwSmQ5akxKZEU3L3pGMDA5cTJlbUFnMURu?=
 =?utf-8?B?RU5KVVdHd1RybTFSd0syb2lJWlJzQUhKOFhFTGRjdFVhZjIxZnlOdEx5TDBK?=
 =?utf-8?B?dkJjY1BIa20rNDlZQ1NVSVVpQ3AzV2dsZ1ozSWJWMmc5aEx4aEJFTFM3amtJ?=
 =?utf-8?B?bFR3Rkc0SWMyYmVKZWQySkdlUUhQZ0FpdVVWZ2x2Z1RKZWVScnd2MmJtU09K?=
 =?utf-8?B?MU1VOXFXTEFIRytkbk44NmxDeFg1TjdycWVWTm9VN2c1WjZpUUhUVGRlU0Fn?=
 =?utf-8?B?bUdGVkRienBCNjNuaE4xTmJNMEVFVDJ4dW5TNlAySVljcUZHTkF4RUo0K2RD?=
 =?utf-8?B?b3VESWExVU1PRHhZYStkWHNvS2cvWEtFU2NRRzFSYm51bkdoZWQzTDBtY0xs?=
 =?utf-8?B?VFVaT3diRUxRWnFNMzRNZi96elVZVTBlU3d2b0ZhUEhCRnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8506947-790b-488f-0185-08ded370f64e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:52:06.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3952
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38162-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,SN7PR19MB6736.namprd19.prod.outlook.com:mid,devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB95C6CC342

Hi Krzysztof,

On 6/26/26 14:47, Krzysztof Kozlowski wrote:
> On Thu, Jun 25, 2026 at 06:10:05PM +0400, George Moussalem wrote:
>> Document the M0 Bluetooth Subsystem remote processor core found in the
>> Qualcomm IPQ5018 SoC. Firmware loaded is authenticated via TrustZone.
>> The firmware running on the M0 core provides bluetooth functionality.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  .../bindings/remoteproc/qcom,m0-btss-pil.yaml      | 72 ++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,m0-btss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,m0-btss-pil.yaml
>> new file mode 100644
>> index 000000000000..397bb6815d71
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,m0-btss-pil.yaml
> 
> Use compatible as filename.

understood, will update in v2.

> 
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,m0-btss-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm M0 BTSS Peripheral Image Loader
>> +
>> +maintainers:
>> +  - George Moussalem <george.moussalem@outlook.com>
>> +
>> +description:
>> +  Qualcomm M0 BTSS Peripheral Secure Image Loader loads firmware and powers up
>> +  the M0 BTSS remote processor core on the Qualcomm IPQ5018 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-btss-pil
>> +
>> +  firmware-name:
>> +    maxItems: 1
>> +    description: Firmware name for the M0 Bluetooth Subsystem core
> 
> You can drop description, pretty obvious.

will drop

> 
>> +
>> +  clocks:
>> +    items:
>> +      - description: M0 BTSS low power oscillator clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: btss_lpo_clk
> 
> Just "lpo"

will update

> 
>> +
>> +  memory-region:
>> +    items:
>> +      - description: M0 BTSS reserved memory carveout
>> +
>> +  resets:
>> +    items:
>> +      - description: M0 BTSS reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: btss_reset
> 
> Drop names. Using block name as input name is not really useful.

Will drop

> 
> No supplies? no address space? How do you actually trigger remoteproc
> startup?

No supplied and no address space. The core is booted by a
qcom_scm_auth_and_reset call to TrustZone which authenticated the
firmware, takes it out of reset and boots it.

> 
>> +
>> +required:
>> +  - compatible
>> +  - firmware-name
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - memory-region
>> +
>> +additionalProperties: false
> 
> Best regards,
> Krzysztof
> 


