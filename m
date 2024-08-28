Return-Path: <linux-wireless+bounces-12124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B304B962192
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425941F26347
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953F15ADB3;
	Wed, 28 Aug 2024 07:41:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E115A87B;
	Wed, 28 Aug 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830904; cv=fail; b=DM8fqy9DwsgTF1iRP9lO3H8oR6NHKmJcg7VB9q1Ito+cqKgDUdr0xvWa+RK2pNM2+2oeyoTGWlhNdnxBQ3g+E6u5mRiPA6v4jx36XHVIyI88faCERak/2Xo0xtwkFV/DLOA3oQ6h6n3+4gVgs954AitDdlwL97d5qhVmpKF8nc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830904; c=relaxed/simple;
	bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ERVQibT0DyoeD3/v1nBd8XtljWvOQpVuTnKPjWS4OX3OxpK9EZgaTsiV0tHFSriqDgjOOMXL1UCdyPL2JEAdw/xUKpzZ7yPUFL1KPPuiSKE1jv8dDJeN3m6CiyxF6Q6kXLzdiu0LgkZWbx+cdUtupMz2JDt8p5cY+0jgbCuea6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1DkfV59s19/wgqENKjri/UKVrf61qbNBDpG6fdTe+e792HjhrsG+nklNWxPiGlkJeNz5FadD28XrdU9cdulKKOShXjFyes3EzLZEv98vNV+7zm6+zuScC7KymqEgeBdoQQpjMEfD8eoS6dww7DKH7n7pee6Ni39q3TrEgzzNY0f9GPNgDIlib5yL5Sbv09MFk3wBAWyv9w8rW1FqJbfOIcfzABFCE91zgV0gyfdZDyUR5HGjDIOBHjrBsSyqtQTFl6G8/DObJaeNxi4jVIXR2lxfsePUglku1cyXx8puLDJPrPygA6Rp6KxzDT4eiP3A+ZP3GP3+PKWy/3rdrwXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIa/19ZSdmiXE/+0Ze0XxBHm6vHkH0nd5ZiJsa5DkWA=;
 b=xXVMy44APLieOZZErPljFN5K6bZdBx8xf8hsKZ1sBQjJCBbihfulfYJCSaqc6Z+IuUjXYIWpyDy4ai4OQhKAi/LvNv3I0fELFlWjrXOKYE2xQflCmz1fzUpX7y+n/cdTeq1nNsT3wb3ruTNztFRKW+KXMtWbmlA5g2DQEyDwS5CCa4S+Apyeol2JejyHuDq+OaITjk/QJGd0eHTMWxcfTGPPqzctjcuwefdLGNpZvnAHZmY6eeimijozDT3c8aIaIs4gwe1H7EF6y5KJum9afPrZXpZ3GVsXo131i+QcNuOJJJ/7+r3g7RMmyWClkSPCuZvZ9Ug3n76PHeZZB0NzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:21 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:21 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:40:52 +0800
Subject: [PATCH v12 5/5] wifi: brcmfmac: add flag for random seed during
 firmware download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v12-5-9064ac7acf1d@wesion.com>
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=6614;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
 b=14FbAN54TnGf0PTz7mST9t7L8IHhkUGrkrZMbAXiInJpzfj78gXEN4LqayO7q91ZlFbhqZtOb
 crq+Mr4tmsTDXKcVAOsx/4dEFAJWJAGDKR/ajx2syfBkfjqvqUP5J59
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: b72da464-45be-4d40-5573-08dcc734cf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25SVUNEcFlIRW1RNkRyZFRtTWpJK0cwWkhldldKRVRnTitSL1dNb3kwNXJz?=
 =?utf-8?B?SXl1ZThRZDF5L00wQWJheGxGdmY4NmN2UWNqVGFtM2cxbmxBZlNnZXlGRnN6?=
 =?utf-8?B?MXpDb1JWY1ltSktrejNZTTk4RHp0Q2w0NlVhNWIrREMxU04xVTV1NVh6ak94?=
 =?utf-8?B?N0R0WHRmazJJNm9DQktJcEpVbjkxT3Z3ZHBXVUJPcUxBeFVpb3FMbEcrVmk4?=
 =?utf-8?B?SS9Bb2VnZUtPd3VYeld4K3Y4NTliTUtIU2c4eGI5N1FPczNlT0NSZzNKQ2dE?=
 =?utf-8?B?SEhmYVRqTDVBRWl0WFBjVmdBV1Z2Tk1DVUtPY1dQYnBnVHJrNWx3WGJiYkdH?=
 =?utf-8?B?YzdyVEFYQXZKUmdCMG52dWt5UFR3ZTdnQkt5QU9lYkZsckpXMkRLQ1U3WXA3?=
 =?utf-8?B?TXJwa29wOW1OMjBaWjZ5a2N4WER5dUlkZlRPbzZ3czY4NEZaVGpwS00yVGp0?=
 =?utf-8?B?N3lzaDNmRXlmU05wZDNIR05yM1Y0b2hnREk4UkVsbVhkVmpUM1AyaVFRaERZ?=
 =?utf-8?B?dFY2R040cjkyUXJJaThmTEM2ZkxzQURuSTZMR3lLcVB6OVA2eWhsVkNsejI0?=
 =?utf-8?B?MlErQnRxT0FSMVNZTnVsbEFHOWVrSnNPR1FYSWVnRHpsMzdOemdhbWZ5S2lX?=
 =?utf-8?B?alZHWkUrcXN1d01IenJ0eVFmQ3lZRFIxUm9icWVFWkNjRHRGQXU3cjlTK2ZR?=
 =?utf-8?B?Qy80MlFuYkFFZHRZRjJ3RGFKWEJGdjhwVktpY1Z1cjk0cDJzMVlXbFV4TE9v?=
 =?utf-8?B?Y2FpbHZ3d1l1OUJGK2Iway9KbVBYckE0aVZuSVdTT09qUit1cHlzTkNuWjg5?=
 =?utf-8?B?NkYyUkRib0JHSTM4ZGpMalBHVEhKKzg1YjJpWVAxWU93U2JaM240Zlg0R3Vv?=
 =?utf-8?B?U3REY2djcGFSMzZJT2UzU1FnQ3FHbWpjWERsVTdqQ3JJVDc5NGFyKzRTZUNK?=
 =?utf-8?B?eGF5dldkcEd4RWpTblA0Z3V5L01FOCtyaHp3dXorcDVaakMwTmRzeHlIN3E3?=
 =?utf-8?B?b0k4MDRHZVZZdTg0M3EyWVFNZ09pY3hXeTNNek9Jb3dHSitSWXJUbW1icHRm?=
 =?utf-8?B?TUhVVklNVlF4bDlRU21iQzdOUDdXR2FkWFJJMXIzVmpNSXdrWlNmUWJmbHRv?=
 =?utf-8?B?TmtSQW5LMEo5UW01UGp3ZTcwVS9EblJOMkZ5QWhscGVKZHprMlhEdG15UWkr?=
 =?utf-8?B?dFEvVHNpVlp0NnJ6QUlJTHpOcTBGMXlMYmJaVlRxeCs5RVZjR1FqeEFPNjNq?=
 =?utf-8?B?RVo3dzhGMmFUbGNoclloajdaeVN2bEhid3pxOHpXZ0xjWnY0NnFJWEpkZ1E0?=
 =?utf-8?B?ZlNpcjFvUEEzbmR4dUkwVFhQSFlHanRIOUtFNHJuSWJVYlVaejdKVmJOSE9B?=
 =?utf-8?B?U2ZJMisrQ0dHMThBT2FtVUp4bjlRUmpNaE85d3U1L09GdGNyOGIwZWRtMjRq?=
 =?utf-8?B?cFFybUx4MHpVdHQ5UWJxRzdnbE40SHRKTnVReHJ3R2NvOUtVOG5hL0lhOWlF?=
 =?utf-8?B?UjVPVE9jbE9OTjhFaG1INW8vYWNWMVg1MjFjckp4Q3JFcVR1SDc4b0pYemQ3?=
 =?utf-8?B?bkk2QmRTdEd2VUYwZUhkTUdCU1FZNDJEa2xubVRpc0Y3VGh3dnZyVklWVURs?=
 =?utf-8?B?MUpsMElpYWx1YmxSaU9tcE9mMWFvMmpaMHJPUUxTbkhHeFZKQTZkMndHZGFQ?=
 =?utf-8?B?U01MUFlGaTkvQ0s0TERKdm1aMko5eCsxNFhUYUJ5amZpcjJ4MlNLYzFlTWlw?=
 =?utf-8?B?bTd1UnNKc3dveS9HUDNEbW56WFcyVkVoWEQzSFYyMms4MjE0U1Yzc3Y1WDhK?=
 =?utf-8?B?NXRqaEloZ21wbEMxVng5dEgyT0RXUmhEN2l0VXlvWUVYSmFCY3ZGQjJhVnNC?=
 =?utf-8?B?R1B5OEJOS2xzSFdDSklSdU1BS2FwUDM0UnEvb1A5SFMxNEh5NTBZTzhINVhQ?=
 =?utf-8?Q?IUd7SdcCmIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjlWTVlKa0hRaTNZVU9IWmwrTVFNS3QwTjJxZVRPaFUzQUdVWXNPZ0VBTDRV?=
 =?utf-8?B?VTlXYjlsc3Q0b2hCVWJzRHpwTzk4Zk9JR0E5Q1BsanNmZ3d5SURCUUxsTy9O?=
 =?utf-8?B?QllycmRzcGIvQ2Q3cmlVOUpNZ3pYME15OVhwM2w1aHFtbHlheEZJc3J3Qmwz?=
 =?utf-8?B?TFBTL0ZKeUVpUmltT0U0SnNtZ3BCRklTK2hkSGV3bFAzNHNwaFBwd29nelNV?=
 =?utf-8?B?QkVkNVJLN3NzclFzUFZJZGpsNlBuK24yTjhycVUxNTdUeUNpN2RDYlJkOUt3?=
 =?utf-8?B?S1B6ZnZRQlZnbDAvL1o5cXhSSWlHMzN4RDYzcUk4NTVKb2hMS0pjSk5hMUhC?=
 =?utf-8?B?d0lMWXVlYVBPdlRvM3BUQTBkaUlacFBLaFZlNnVjM1ZRbXhHM2RpVG82a20z?=
 =?utf-8?B?MGNFcHVHQkNGMWdDdlc5RGloNGZQNTZ4aGtpK2tOQmhCVGxtZ21NNE0zZGpU?=
 =?utf-8?B?UklzYnlkMUg3ckhhQWFYSU10T3lvb1BTeUhmeHRWYUhycGU4SVVaN0kxaUFV?=
 =?utf-8?B?bFg0d21FcEFUTGlFb0NaSDBnZVJERjAzUGtDRFV2WStSNkYxOUErVUR4Zmdj?=
 =?utf-8?B?WFF2YWxGaURsWGd5V2Y3S0RPTVVQSmZqNnh0eStIandycFRmdHpTY2YwMHN4?=
 =?utf-8?B?RFRwTElac2dSQ0xzNzNCcG5mbkdGNU9PUlNQYTVkbGlzVllvd25DZG42cjRt?=
 =?utf-8?B?WEJCbGNuMExYcDFuZGpkL1VKVVMwRDExWEdUWVNxOXcwMllOWVBkRENEbUF1?=
 =?utf-8?B?MjVLbVhaai9hejhJdzc5ZStPaENGN09pUFpwUldWRjdUanR6RGlOcU1PaWVJ?=
 =?utf-8?B?aG55eGZMVnM3TXVzV1VYNnpobUNuZWtLckNQQmIyUnh2ZTYva09xeDFrWHdE?=
 =?utf-8?B?ZkJGdEx6Nmx0NVVkOEFxbHVVaXdiNWxjbG9ZVmpkMTNkOFZSdlRYeFg5LzFy?=
 =?utf-8?B?YkNxZFpSMDhkZWZaUFBNK2p3Ym96aU5McDNxSCtxN2lRYXlrZElDbXYyS1pN?=
 =?utf-8?B?ZG05RHhldmdWelRhSk9qM3ErZlVqKzhMUzl5clN1RVRCa1Jidk1ZN2R1NUxz?=
 =?utf-8?B?SXJSMWdtaksrcVFpUzBDNnltNVJWZmcxNHBmVHJnMjZ3bXIybTM2LzIrN3I0?=
 =?utf-8?B?T3pibklRdnFib2xVbUV3bjVTV2xPcVRpTVNUYWN6ekNjNWR6c1hsWVRwRUNz?=
 =?utf-8?B?M3R0TS84cDVkQjhUeURiaG1KT0dlaHl5cmhrelpEV3dIREc2TTlNazJpWWxH?=
 =?utf-8?B?aHhPamd5bVRLa0hubXJPVWFHZzZId2hySklqZUxYMmkzRjRYYWlQK1dTdTcr?=
 =?utf-8?B?VzNlYmNGTkNuUkYzSEZsdkpvSms4RW10VXBlUVI0cDVPKzlWMlI2cWxWTU5F?=
 =?utf-8?B?blVoMEhJdy9GR0NBNzFjN2pBVXBobXNVTVBqUWdNZnlwTGg3R25LNDlGUGtF?=
 =?utf-8?B?dGthdUh2WG9WUjBGL0hpTDJiWkRqZHoyYmx1UDdQejA1ZkFacU5wUHFHT0Zn?=
 =?utf-8?B?UmYyYmF5cXh3WXIzZGZ0SnErckFxKzVVdDhZUmNYTlBwQ3hsL1ZlNk8rZUVO?=
 =?utf-8?B?SVRYeDd2Sy83UlNURmpsVG5hckZMTE54dGRoQktoQm1sV1N1Q2RKK1ByaXBV?=
 =?utf-8?B?bHVUeDlQcjUyOHQ4THBqeWNMQ1RoTmhMTDVVRTY0V085c2pZTmdGN0Y0ZDVY?=
 =?utf-8?B?aFliM2l6NmtIbDlFNTVmcE15NmZISlREb3VveDB3TldOTXU2YWpSbkFkeGVB?=
 =?utf-8?B?eWpncU5iV2kvaVI5ZGM0Y2JGcG10SlFySGgzVituQXlDSXlJbFc3b0xMaWho?=
 =?utf-8?B?M0I5Y3ZmSnZKZVZBYVZ6QTN3SERIYW00SmtwU3M4cXVCOWY3cHZuTFZZbFlM?=
 =?utf-8?B?aEU3alNVSXZOeXFuZUEwc29hM05XRmh0Q05XNXBGRTQ5Tm9kaXFrUmxXbzBC?=
 =?utf-8?B?ZmUwWmFNbXhTeWo5SUpUTWxSTlZrTGQ2dzZkaWFhMWppb3EvVGdNUjJ6WGZW?=
 =?utf-8?B?L0pGejVPQTIxZng2Rno5dVdTVWg5R0NQM1dEazB4MG5hcm45UFRuMExabklV?=
 =?utf-8?B?ZHpkWUhEeTI3N0k0VnN0SFgyaDJiRTluei9DU3RRaEhmRlAyTDZwRUJaSEtM?=
 =?utf-8?Q?lmCaIbZ7Ekb/N4LSAmWFHtk0p?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72da464-45be-4d40-5573-08dcc734cf7e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:21.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyFIYzjCXi+SUuIiF3p42etcXmXQJxYiDzninIBErSiR+GWuu/AwJbSx88jH0PXgfMuWJIDToKrfuc5mtBHj+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 190e8990618c5..c0fdaa4dceda4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433

-- 
2.34.1


