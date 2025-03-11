Return-Path: <linux-wireless+bounces-20151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE0A5BB29
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3291894335
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E2229B18;
	Tue, 11 Mar 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mcGwe8mj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011036.outbound.protection.outlook.com [52.103.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0122758F;
	Tue, 11 Mar 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683105; cv=fail; b=sOc5OGgE1pnpwWZkAxbbAgJ0NWHhGxYgAmsJp8aDT1NL2uLhV/4u2LYi2AGh3cBzyt5E21FmsttvFzkp9PFOrLpT5sptUzGzrIP1+POwZ89caM5nxZUEPr0gLMHya1K72hUzZTvcKfhWKzMDruoztUtagm0kLCvjcc42NGRy8nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683105; c=relaxed/simple;
	bh=ciyvdoIDGb0yC4aCgNX6fv13nnY8fykfK3fptKa5CV4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAs8w55JtNTfwFhaqckrGiLZy58OkX5dIBmZHWHlPYSkX/v3CWDflaSv7ZPxNdqz4JDOOEOww4Dq+kOjgdL3jpYnzlIUVBXtb3ufu4DGEg39x3JvIjK3YIRGPalZofZoShlHDVNbsGFRvyaVhFozEF6/fqW8/Xl4bFXo2R0//Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mcGwe8mj; arc=fail smtp.client-ip=52.103.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x87NXcqMD/Dn36YG2OB/nY/Ivy6eYEJgLcalyvfQKv+8ZdPsnrk17sDnhATXONXKlbvTqwDq+yo1XmrFWaxE9X/0EqKx6k4KmIaz/L4I/VOi8mtNFP/dOQjwA6hEaq0TWMzqyYSF56YsBMksLelNLk1exsvdFpuO3PA0UywLjaWcqbeoX4zdzJ5iefd95JTWWBx9v2pXQZBUFJKsiY4WcCZBR3VUGfA/yEKU0B+vtT+xCccwJLu4PO9JyxVaypMp1dma/XdENPyp8ZTxKB8GyU8TLtoeZOj0uyUHgctooNAONVze4eMVRfAKQTHJJUdNT67AI/qi533IPiiIhuaq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciyvdoIDGb0yC4aCgNX6fv13nnY8fykfK3fptKa5CV4=;
 b=sSFurrWDkOIWAS2pKDDfPw6nIY33xyHW0YykE0Fqx0Xf6T6VMbjMJ8a54Y8evams4mefYb89fuTmZqYS50zFyGwSb5bPaFWglZetJwKCXb0bMByYLputHuP7oSy1/WsNJFu8TX2ny9I7CZkE0y+iku5gjmh7nufOh4G/akINCtvw03lKwj70lo1dp+6hcYpNwedPhI7REENrTatBI/b1O025Va4j/OqtbsjKeumN/WgW4MP2MuyLCjF6o12miEXs/LFJDcyufavQ6SM/SP22sWti4S6GMd6vpysPwuWqAAu2v4Dr/PHjxUS2IEE3E5Uwk0oTaEkvyTlk10//giAaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciyvdoIDGb0yC4aCgNX6fv13nnY8fykfK3fptKa5CV4=;
 b=mcGwe8mj7RSZUE9+0C8mrjBAqBztp+dNMkeYEtjRx/RHK5nGpyF2DpAiGFaIclhKsPkp09tmv6NeL+koub0j5T4hE5BNw2EdnrOgpCXr6zYympDF+lVPwn0/xZpW8Pp7MtNl3OowANANMaiNp1VCxFrMYOquK8kdJDRwBbkqmBuwIiiDW+XkdCfsf6qB2t/Zz0DJw+pkRNSYRvctj5CvkbMUeMFTMpPmXlZ2lntlHKIwxyOaYR1CqDSbKF7k90hF+W5x9H29vxitSVwtwCf0lIx+ckpGjUhDVZ5RP+GF0CUkEY/uA6yqrxi/Smz2mb/bYCrzLTpNwawLjDonUunqOw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYYPR01MB6874.jpnprd01.prod.outlook.com (2603:1096:400:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:51:37 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 08:51:37 +0000
Message-ID:
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Tue, 11 Mar 2025 16:51:28 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, johannes@sipsolutions.net, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ping-Ke Shih <pkshih@realtek.com>
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1atGiSEe97W1t0JoGB7ygLs4"
X-ClientProxiedBy: TYAPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:404:28::20) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <5e0a63e8-939a-4e1b-b913-3778965ec806@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYYPR01MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b69ac45-4cef-4805-cd2e-08dd6079eec9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|15080799006|6092099012|12121999004|461199028|7092599003|19110799003|5072599009|26115399003|14041999003|41001999003|19111999003|1602099012|20055399003|13041999003|4302099013|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGFzRllNK2JPYnV6TktLcGowaGJLUlNGdTU0cG9BZVZFKzJzWXlucWYzODI2?=
 =?utf-8?B?Y0diSVFpWmZpRmQ4SjBMTzI2S0x3QURnUE1PUVRhTjVOcFVDakhkM0dhNG0w?=
 =?utf-8?B?cFJDeWYxY3NDb1FzanZNL2ozNHF0bjJrMjFaZzZHSEJ6UEJpaFRXU2ZUanBG?=
 =?utf-8?B?cUlrVkNmMExkK0xmc1MrRUQvNWtBWFYwMStKQVYvaWxzeWM4NHVNR2t1dXBY?=
 =?utf-8?B?L3IyWlVyWlI4U05MOXE3OXNLdExwUzFFQloxQ2pqV1FOYUtDTWxXSVhYaGpr?=
 =?utf-8?B?ZjFOUmlIRDFIMDdBYUFuVzczOTZzZEgzM3JmcGo4cXV0aTRWenY1cGgvc01Z?=
 =?utf-8?B?aXg4S0d1ZDR4amZNS1I5TE85Q3ZLdXRmQ3hrZ2VueXJiOGJRM1VPVWhydnBP?=
 =?utf-8?B?ejhyeUc5eWhOdkowYjNJRFZkai9DNjl6S0ZvZGpJRTBnMjdxek9BOHlkRmV6?=
 =?utf-8?B?dVprclhnMXBRVnFOUnNOdENxT3psNmNZUlFhRWFJd0JUZU8rQTVlTHBFU3Rl?=
 =?utf-8?B?VzJKL1VNRk5SRFBOWjBmV2JRMUR0QTR3aDdmOEtRamowakdlME5JWDFxWFBT?=
 =?utf-8?B?OVRJWEpPbXdwcUZEakVGVjBkaEw4U0swQUQ4YjYvL0t2TjludFlmMXdGUlBi?=
 =?utf-8?B?T2FpVkljbThyd3dOTml1N3ljU0RQTHc5MkZVTThRL1d3ZjVaK0ZKZUhpRTVj?=
 =?utf-8?B?bG5aazEyM3RHMGdsVG1ocTB2ejFueDYrSFJJTllVUjY2dWZtZzVuT1psbCtr?=
 =?utf-8?B?WmJHb0ZaZ01JaXdQNEU2NGx1V2VSTEErMlUrVStxZmVwNm9aZGhRSE5ka1V5?=
 =?utf-8?B?TWVtWXhmOGRGZlo5a01uMVpLUlA3TTAvVDZVaUJsc3d4TmFVU3JHdFp6RlpQ?=
 =?utf-8?B?TkR5OXNuTFR1RGhOcGo2MlNocFdiSFRoNDVBTGtFVURLd045bEs1dFFOL1pz?=
 =?utf-8?B?OVYrVERqRXNTTVdNWkJxMCtsYmx5bU1rMlBVVEwyd2tCaDhzbG9lc2p3b1JO?=
 =?utf-8?B?dnZhY29Eb0tMNUlNTUZ0NUpmNWd4bEZpSmdiZ0g5TTFyVnFpaDRsOFFkQjV5?=
 =?utf-8?B?bmR4dExBMDR0WU9IR0NrMFVIalpSK2ZwZHlJNnUydjVEWm9NMW9HaHoyYkts?=
 =?utf-8?B?QkhmK3hjaXFFQ1gxWUJsMGFqeE90OTFUSFZuYy8wWTBuRWFCTFdaQ2R1QURy?=
 =?utf-8?B?eURRbUNKU1VaR2VJRXBObDNZbVIySVZ5eWhCRksvNUxuZFJVS2FNK3JOa1Ew?=
 =?utf-8?B?UzZWeUxwdmpxdi9RMW1pc0ZpT3gyeHpSZzRNcENTSnJpVXVLbU8vV2x1Tml6?=
 =?utf-8?B?RU5xcnU4SDJmQzR6NUpHMTJsZy90TytNdk9aWVI0U3Fta1dneVlNWE9qVE5u?=
 =?utf-8?B?NnJ1aHNpbDRLTm9iZGZPQmZRUytvK0lMTk1MU2IybENwQ29za3F6QVNIbzRw?=
 =?utf-8?B?THYvUWN6SC9qbVBlNUNIZkRLbGNQekZEVlRuQ1Y1WGM4c0xaZXBibldabDNx?=
 =?utf-8?B?eVRTZjFaejU1cklLem1HUzRheC8zWUo3bmVsem1XRDdGZXpWWnRIQkFhSFNu?=
 =?utf-8?B?UVJsUy93U2tqS2YrUzMyQmhUWTVDcFIzSWM2T3ZNZkpvRHJYcVk0VlRlSGEx?=
 =?utf-8?B?dnZ4aFJ6U2tuZEI3M0I0WldXdEcvUG5qb3RLMnBMTkw2WWMremRpdktpeEYx?=
 =?utf-8?B?amxvNkR6VG9pUFYrK2hic3kzOGhkdkRjdEsybU5PeDJkMHVqN1dMQ21RNEEv?=
 =?utf-8?B?Rml0bGtUR3RMRmlPMGIwcTNQVDB0WnMzWkIyQm1maTJIMG1ST0t5bEl3Zkl1?=
 =?utf-8?B?bERsNVM1c01xVjlla2NhemovS05mR0tOMThUS3hMVGxnWVNyaDVxclBYN1Ez?=
 =?utf-8?B?di9NdzhCREF2OEJVcC9DVjJJMGo1dzFUK250WGJsL0dTSS8vZXgwRFFwcWxK?=
 =?utf-8?Q?pvuygO+EDVa59Ia3nd708PpVEYD3ip3F?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVkS2F0M3gyUGJzYm45WnZJaDQyeGNCTHVPK3E4KzRnYitOMit2WXhRSTAv?=
 =?utf-8?B?OUtGdGo3ZmJ3MDViS3JYSHlKK2xFTDhUelJZaGp4YUVMaEtJYWtBUUVvV0g1?=
 =?utf-8?B?SzFIbVNsRUxqK1YzMXZmWkdwQU5Caks5T2MrQ2IybWxNSEFmSFFsZi9IUmdO?=
 =?utf-8?B?aDFlb21VWHpNQXlKeldCUGszazdGQlMraVFtT2RGUkNoV0VuUXA3VElNWFpy?=
 =?utf-8?B?SDdISzBGZTFIMTNFMjZBcXRmZVBlOFQxK2ZZd1FmV1d5a2JncWlVUmhEa3NY?=
 =?utf-8?B?QlhNSXB6MmhtTG56LzNWTHlBSVZmeTVqYndadmVJSmlybEJxZk9DN0ltR09H?=
 =?utf-8?B?eGZ3UmJ2V01Xak5WcHV2RXdoRndvRG54a092QWhNekJyQ2hLQ21XK2F5WHds?=
 =?utf-8?B?N3k4Zkd1SXRZMEs4YXpzR2ZtbWo0VTF2VHlucTlIRHorMkptYXpGMjlCNGE5?=
 =?utf-8?B?SlhVTW9YNGlEZTM2TExxbTVVTTFSbEozM29MTDJJT2wyVHFaOENoVzJCeFpP?=
 =?utf-8?B?dGJYUjVPSXhUWFRmbTdScVRNR0RzWVEzVTJOaDFPR3lrZ0VCY2dwZUlkSDY4?=
 =?utf-8?B?aENhWHRmaG1ndERSMVRGVWQ5U2I3UGhjcVY5N3BvV0ZsS2diNHVMcnovTFhU?=
 =?utf-8?B?VzBwa2Jzb2k4cFBsVDVQeUlxSVU1d040MGwwbHp3RHlTRnhuenZzYlVTMzJa?=
 =?utf-8?B?cDNCYzQyN1d1b01jMzdhZ2xpbU0zLy9qWTlIaU5YTVNEb0huaE9jVGptTC9X?=
 =?utf-8?B?MVhXN3U0Z0UwNWplRG5FSk9rdTVRcVRQcnFDbkFpdENTNCtMMVdDZ1pTVno4?=
 =?utf-8?B?dFgycWJ0LzJvM1BlZVVUOWRSZVBieGp5NTJXTUhud1VxUGsvdEV6ZnZyYi9w?=
 =?utf-8?B?RkMzZGk0cEp5cXNjeUNFSTRtNkV1VEZyOHEvdExuVWR0Qm5ucG9TY1prNWRB?=
 =?utf-8?B?cWRWV0I1T3NUTmtWSVd2elFyN2g5VEswMGprbTRvV2liMkMyMG9mcXlPQzZU?=
 =?utf-8?B?Y3pDY01IQzQvd05kYTBZV0NoNXdDNHplZVcwSWM2S3lyd2xqYXNNZno3andq?=
 =?utf-8?B?azdMWEg1YW5NT21JVUxPUHJQN2d2eFpXVUJUZjV4MEJ0Uk9Cb3BQMnMxd2Y1?=
 =?utf-8?B?S1ZBZUlBYVQ5RGk5YktqMVJmVlFlektQemJTVnpPNTc0cFliNlB2azhiamJN?=
 =?utf-8?B?TzkwaEZ0RTM2Nk9Lc1JoUC9RaWpGeTZrZ05MVXZVZFZCZ09TSm5JVENOQzVi?=
 =?utf-8?B?ZnNuYnh1bFZGVmdVd1dEUEtVVXdOQjJxbGk2RXM5aVVIOUcyRXJuMVlDVjFZ?=
 =?utf-8?B?bmp2RlRBWCt1V1FUTWRpVk5xemhqdU12dU8yT252UG1yS1hwbStxRU1xanFV?=
 =?utf-8?B?VGNiUXFsSUhaTEhlSkRaQzd0cTJlNXN2bTNNdTFhVEorbWVkZEZQcTdWQVJt?=
 =?utf-8?B?WW1qWjVHZGlGak9HOXIvMjRSSXJrMm9GQ1VWQ3J5YmNuNHY3a29mYWQ1d1lD?=
 =?utf-8?B?RG9xWDBuNHdUL0dCam13V2xrSGpYY3BjRW9heUxUbGplcE11RE5GWkZYczlX?=
 =?utf-8?B?WU5zZTJNN1ZkMzZUU25Cb1FCSnYwVGpGT2gvTzBIMDBkUDRyVnZHMHdzeXpB?=
 =?utf-8?B?VmlnVmppZE1yc0cvbG9GNFcxbG93RWtwOWt3dy9ucDA3OHBrZDBCbHdDV1BI?=
 =?utf-8?B?djVzdDAzdCt6VU9OeWhXcjRoNSs2cXRRTi8xeExncTB0OUxsR0hhTjVkNitJ?=
 =?utf-8?Q?C2i16x8CpM92AePs5w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b69ac45-4cef-4805-cd2e-08dd6079eec9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:51:37.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6874

--------------1atGiSEe97W1t0JoGB7ygLs4
Content-Type: multipart/mixed; boundary="------------WWNJFZvNpMgXLCdlQtpeiS0a";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: wiagn233@outlook.com, johannes@sipsolutions.net, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Message-ID: <5e0a63e8-939a-4e1b-b913-3778965ec806@outlook.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>

--------------WWNJFZvNpMgXLCdlQtpeiS0a
Content-Type: multipart/mixed; boundary="------------3WUfqu6k0a7zQZ9P1bT1fvJP"

--------------3WUfqu6k0a7zQZ9P1bT1fvJP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2hpaCwNCg0KQ2FuIHlvdSBhbHNvIGdpdmUgdGhpcyBwYXRjaCBhIHJldmlldz8gU2Vl
bXMgSSBhbHNvIG5lZWQgdG8gY29udmVydCB0bw0KcmV2ZXJzZSBYbWFzIHRyZWUgb3JkZXIg
Zm9yIHRoaXMgcGF0Y2gsIHdpbGwgZG8gaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJl
Z2FyZHMsDQpTaGVuZ3l1DQoNCuWcqCAyMDI1LzIvMjIgMTk6MzgsIFNoZW5neXUgUXUg5YaZ
6YGTOg0KPiBUaGUgdG9rZW4gaWQgaW4gUnhETUFEIG1heSBiZSBpbmNvcnJlY3Qgd2hlbiBp
dCBpcyBub3QgdGhlIGxhc3QgZnJhbWUNCj4gZHVlIHRvIFdFRCBIVyBidWcuIExvb2t1cCBj
b3JyZWN0IHRva2VuIGlkIGJ5IHBoeXNpY2FsIGFkZHJlc3MgaW4gc2RwMC4NCj4gDQo+IERv
d25zdHJlYW0gcGF0Y2ggbGluazogaHR0cHM6Ly9naXQwMS5tZWRpYXRlay5jb20vcGx1Z2lu
cy9naXRpbGVzL29wZW53cnQvZmVlZHMvbXRrLW9wZW53cnQtZmVlZHMvKy83MzczNDAzMjJh
YjIyYjEzOGZkMjAwZTAyMGQ2MWZmZGJlM2UzNmE5L2F1dG9idWlsZC9hdXRvYnVpbGRfNS40
X21hYzgwMjExX3JlbGVhc2UvbXQ3OTg4X3dpZmk3X21hYzgwMjExX21sby9wYWNrYWdlL2tl
cm5lbC9tdDc2L3BhdGNoZXMvMDA2Mi1tdGstd2lmaS1tdDc2LW10NzkxNS13ZWQtZmluZC1y
eC10b2tlbi1ieS1waHlzaWNhbC1hLnBhdGNoDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRl
ciBDaGl1IDxjaHVpLWhhby5jaGl1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
U2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMgfCAyNSArKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvZG1hLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2Rt
YS5jDQo+IGluZGV4IDg0NGFmMTZlZTU1MS4uNWJmNjMwMTQyNjNjIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4gQEAgLTQ0NCw5ICs0
NDQsMzIgQEAgbXQ3Nl9kbWFfZ2V0X2J1ZihzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0
IG10NzZfcXVldWUgKnEsIGludCBpZHgsDQo+ICAgCW10NzZfZG1hX3Nob3VsZF9kcm9wX2J1
Zihkcm9wLCBjdHJsLCBidWYxLCBkZXNjX2luZm8pOw0KPiAgIA0KPiAgIAlpZiAobXQ3Nl9x
dWV1ZV9pc193ZWRfcngocSkpIHsNCj4gKwkJdTMyIGlkLCBmaW5kID0gMDsNCj4gICAJCXUz
MiB0b2tlbiA9IEZJRUxEX0dFVChNVF9ETUFfQ1RMX1RPS0VOLCBidWYxKTsNCj4gLQkJc3Ry
dWN0IG10NzZfdHh3aV9jYWNoZSAqdCA9IG10NzZfcnhfdG9rZW5fcmVsZWFzZShkZXYsIHRv
a2VuKTsNCj4gKwkJc3RydWN0IG10NzZfdHh3aV9jYWNoZSAqdDsNCj4gKw0KPiArCQlpZiAo
Km1vcmUpIHsNCj4gKwkJCXNwaW5fbG9ja19iaCgmZGV2LT5yeF90b2tlbl9sb2NrKTsNCj4g
Kw0KPiArCQkJaWRyX2Zvcl9lYWNoX2VudHJ5KCZkZXYtPnJ4X3Rva2VuLCB0LCBpZCkgew0K
PiArCQkJCWlmICh0LT5kbWFfYWRkciA9PSBsZTMyX3RvX2NwdShkZXNjLT5idWYwKSkgew0K
PiArCQkJCQlmaW5kID0gMTsNCj4gKwkJCQkJdG9rZW4gPSBpZDsNCj4gKw0KPiArCQkJCQkv
KiBXcml0ZSBjb3JyZWN0IGlkIGJhY2sgdG8gRE1BKi8NCj4gKwkJCQkJdTMycF9yZXBsYWNl
X2JpdHMoJmJ1ZjEsIGlkLA0KPiArCQkJCQkJCSAgTVRfRE1BX0NUTF9UT0tFTik7DQo+ICsJ
CQkJCVdSSVRFX09OQ0UoZGVzYy0+YnVmMSwgY3B1X3RvX2xlMzIoYnVmMSkpOw0KPiArCQkJ
CQlicmVhazsNCj4gKwkJCQl9DQo+ICsJCQl9DQo+ICsNCj4gKwkJCXNwaW5fdW5sb2NrX2Jo
KCZkZXYtPnJ4X3Rva2VuX2xvY2spOw0KPiArCQkJaWYgKCFmaW5kKQ0KPiArCQkJCXJldHVy
biBOVUxMOw0KPiArCQl9DQo+ICAgDQo+ICsJCXQgPSBtdDc2X3J4X3Rva2VuX3JlbGVhc2Uo
ZGV2LCB0b2tlbik7DQo+ICAgCQlpZiAoIXQpDQo+ICAgCQkJcmV0dXJuIE5VTEw7DQo+ICAg
DQoNCg==
--------------3WUfqu6k0a7zQZ9P1bT1fvJP
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------3WUfqu6k0a7zQZ9P1bT1fvJP--

--------------WWNJFZvNpMgXLCdlQtpeiS0a--

--------------1atGiSEe97W1t0JoGB7ygLs4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfP+ZAFAwAAAAAACgkQX75KBAfJsRnK
ABAAjuvxVrSBQMa0I3sC0l5X45+9WQMQNy3Hp0Ip58FK/epdBI2Xjij/9a+quLzBqbVtvbM7swLj
hPGX3V9oLSBLhrRNBdk/9T3DIEVoemHTlEMDNzjhExxKKcclMUDKi7RDhHx/Mhm292TzXFabZQWd
YokqnfbVWb6YFAXHbIqDQf7I5p9SNQmU5+Nn0kHke0QWwW962eSVTwl1/Qhu52unAfZWtVznA9fX
QcrFtVtEQ8UBW8WMCkZ+Mz1qhF5hzUEGTjPhmh08nOtaMSpYrH7dy6Aml7VuKgFQpnSG+Lvzj7xW
03dEzlIZ5cg9ax+Rx81gH6g/8EqthQz5eQQGOJLavn/Vis4B9zKK3PhVMhNAhwyXQOfmCJtdFS/b
QBgnpTQD5DwEOjjcHgS1Twmhg1UGZHF0Zd3QcX3FEugeAyIUiLArPaQt7flO3tntaQRt6busoKTY
WfsOXmty51pL7SwYZyHfD2Kp9VC6gp+eJSumMihG7ZRNtHtyAZYHItLmKsxaRrI5WfK4TsH/a6AA
WPa9UT0kBPU/AZkeJ/XFzO7LClqoJShMRsZPvhbSqXk8YFCv3OVoz6ZM+CQjdTUDOgYoESYGLMI5
O6WgdC6hLmfohG3WHhkyCiOh4P01KRBIzy9XezjcbI5G450BOVviijKxxDA+uFdRShbhdVT94gxg
gHc=
=5A1i
-----END PGP SIGNATURE-----

--------------1atGiSEe97W1t0JoGB7ygLs4--

