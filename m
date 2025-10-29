Return-Path: <linux-wireless+bounces-28372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590FC1C1C6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 17:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01A205A29D1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9B2EBB96;
	Wed, 29 Oct 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nk0H6668"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011024.outbound.protection.outlook.com [52.103.14.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9D21A444;
	Wed, 29 Oct 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754373; cv=fail; b=W7Zpn33iMS/lkS855yyPVQokYoNUYKt2wMeMaiyzQmT8S+sQL6VvN75MtH/HI2J9YCgpJsc7JMGLX8+xIhC72kKS0LMsuLqkyr+nbhF4Zo3PHRMrRvAkOK5AUecFtBNCtH/z5wVi0elpt4ClUKf+ebbp5jnPVppTLjKYfVzEsJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754373; c=relaxed/simple;
	bh=d2vCRKrvHVdCXpwS1JxeDHUOn3aAkeICOZjjga7bSqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjkiILuIQ9NV9pRe9sr+SMPf2lX5dsU0Ke5rh9ArRMOwFNgLvMKkGGiJPc6mNJbIrwa+wmdlTGTg8CsHxQ+QbSa6KC036bMyKcYKw6Gr9PJgvwFq0/9DddNHaW4SatFiOPcn6dXNixm1ZKvPvzaEqrZ1KJalxi8jRHxe9ETp+VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nk0H6668; arc=fail smtp.client-ip=52.103.14.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2ZCnVQcmH95lMGuMTgsMjnqOMTn+vkmGfA+csY8vpheasOO97qQ1EJj6+7NXBPCkcbFEgeZ/A1Mwi4Ay9QlI8iUJf+CpySvGid48z6VQqa54vLj53GG+bf7eaZl1b33l1qJ7U/zne1TYEL6rsYNdjwZP8FHnAOQ3B1qqOBSoarQFuWAXzC7Mh+Mv0nmIOha0E2O2YpATwmag7Nr4adEZ/aRubBZ/2f/+cimusorjtwudMmryo2vJWVXdMPykTkWsR2aldYuIQJNtu8JDAaxIt2vHujyW/MASfaMrAwgMU7e7ukwRbUy4JIZtP3vLduZDXGB7IYZ68mFrHzlW32FSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeMhBH0QGdy8lhrSJdDm9zdK6/Q4Rvr1fV0LeeyP5wo=;
 b=AmX5hpruCcb0KUb8LAtb4gUHMVkLZWZaY2JTdWf6EQCp+NihVqvDo5XYUHJthIFFXaQOO4jfzSClkn7s5W9gl0SC3L3aWpl21+v1G+4GJ3qk3cBFeE0+FOqMePRUCZJYnL2PM2C8ehgEYrKYwgyFplxaLiVdIJ6ocg9tSZcCtaXcCtf8rNSGXRxNc7JXbATzMdCMrkC4MVC+KjF6B8ozyyXxwEr75YH+MtEAUx3wGKF2n6XQMNKX4SuksAKtXESRyBxvyFBUaWob6dvBbL4YOzLCVJNu9L6l8Mc7v3Tt7kRt59i7yXL8+RGSpPydBPt6qqZ2IyPgdmZdbV9VZvYYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeMhBH0QGdy8lhrSJdDm9zdK6/Q4Rvr1fV0LeeyP5wo=;
 b=nk0H66683W5vD5xrCtqD23HME9QqiMCCUpzwStujUX4pZR489ZLWBH08m9rmRMyxX0UHPfNx8+vh7jmC9wkaRwg8KLDfgfn0PO9sv8iwmgK+GbQ7dO7Q/XcCOzluuEGEZyWkITKcPuUtrJ1GFDtcLXqcOazSi1Wevcbkmkieqsbu4/xG19KPL8xgLr9XNI+a7VMu4PwMOBAIytKkfKPUPuvGXVdL3Vr14fZJ/AzVZFxMo3s2iLZpzZo4d2eKcD56xbtdU8k85ieNRwF0b2N1NS+9msYiJRteTVgIjldqFzO4hcYItCWzGrLDpso9w2W8JAj/9IaMFnvwyE9mNTAm3g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM4PR19MB6271.namprd19.prod.outlook.com (2603:10b6:8:a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:12:48 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:12:48 +0000
Message-ID:
 <DS7PR19MB88836505C4CC48D3E62FBC0A9DFAA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 29 Oct 2025 20:12:37 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt: bindings: net: add bindings for QCN6122
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
 <20251029-ath11k-qcn6122-v1-1-58ed68eba333@outlook.com>
 <3dc712ae-b51f-4142-bbab-1eadbc27e60a@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <3dc712ae-b51f-4142-bbab-1eadbc27e60a@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: DO3P289CA0005.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <81d7ae30-7dcc-490b-b2e8-47d84740e400@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM4PR19MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 12051fd1-d796-4a4e-52ae-08de1706005d
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qU1KA69x/B2/kCnokZ6o97m1+qLAmhIg8SdK3fLSrERQ0jKuV0d5m5W7hZ4xLEjX8+/KCYAclfGa8EUafSY0I0D3A6BbQaoRy5Tn7DaMu7dA6Wpg8c4hCYVF6SlvVjWrbXR2vZcEvUH/LVJ7WubSswgJAaT338qtLriOnyJVtvECdANMNwjR3vkOCk1ZK1u8AJjZSWmxstK+4Le8AqG4TcKW2mo7qZ+mHQgZicb0CTg4DK/5IqFGZ/SQ4OPp4tMhFO6hF5uXw27RjuX54aSlGDMs6NYctHGCQj59duJbgTB/w2gT6ooGa/2heeOrVn2bFeQT2KCK15vjznBQZKzA3o2979TgvXYNqVMkD164K5wj92BLYR6PcArjBfFAqudf9pUotgMf+d7WlK08XedsipPEGRNKRZCSIUapZTlf4XJScDTcWfOJhg3hTZC8I+Cl+INaX/pw+89c5YgdwLZe1cRpMHhrDevTzv4+yzsUQxp9HdqDNm+WfJYjrIEF8/svZVRRLHqyC7R9bjcaBlqRj089FC2HFUrvMJWHvvsXFYWi4EyqF2mKEdK7TR2/tlHAhDuYhiowP+VNEhtCgrIwFAYvrsFBffdV2vWKx++f4TL2TOOdSzYLrS/aU6mFtY0oy7SFuV5nv8zibDkUx2QDviQ3RdUI48WT+E4Lh0w1NYcz/PTPh8utnsTeQk0qs9tY1jQfeWCUKKS79kZiogpvGOAKnM0zs8mIDZK+OInp1PvJqboc9H6V7bnc4ev0VYOSoI5YrfJW8mUTilASfYT3SI1DNH3orXfbJenvnSt0Ye7IanUkPBGVyNiSdihqMDDBMA4TpPxoiQxZua+iL72Aswl
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|461199028|23021999003|15080799012|5072599009|19110799012|1602099012|52005399003|40105399003|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1NndUd2T05KRWpackhyUVBHWUwyaEQ2MStjcFFwRmFWeitRL0hUTXdTTlZt?=
 =?utf-8?B?UWpoMTZiR3IrUThEU01CNGVJVGhsTWlZWGRFQnB4Qy9ueFBVTVFpZWlESUQ3?=
 =?utf-8?B?Z1lsK3NjRVlUYnhYTW9Cb3o0cjd4Zm5QV054Y29MelhjTVF0ZGtXK0M3Vk5H?=
 =?utf-8?B?WEtDVzBRMFdRL2VTOWZKell2NG0xMXlPaXJTZ2hFRDJ2TkFldmZpOEhhaVFt?=
 =?utf-8?B?MUNRZFFnSTRFQVB1QWFDVkl2WVZ4YTcrcFhWOWJoM2hGMURSSlhRK2xxZG50?=
 =?utf-8?B?UnI1N3pwa3lQUmNsSURoMGNTT2lOYzBLdVhFSHRBUVpXc09vUTlCK1I1SEZF?=
 =?utf-8?B?ZnhadjVNS3o2dURkVmZudXBMcVR1Y3QzQTVMSStwWHVvZUx1b1QvMEQ2OHZI?=
 =?utf-8?B?eVJhUDhVNWxFZGFEYkhYdTFlUlpoTTFjZzFYakJwMmRRV24wQ0hFaEJaMlRi?=
 =?utf-8?B?V3gvTG9nNmRhejgrelhmb3h4alJUb3NsaEdoZHdMYlhBUEFHSVp3Z2txTnd6?=
 =?utf-8?B?SCtsUWprR0xFMzlqYUNVVnE0OEhaU2xjU3VqYjA0LzBsdDhxbXlKZkkvUGd3?=
 =?utf-8?B?NUpEYlRRSTRuWnpxcHFhREpYRXdWY1FtNjB3MENCcjNjcmpvYVlOTWtjNGFp?=
 =?utf-8?B?OWIrWE9SVWdvMU51MGg3Nm10WHBoTlZPVGdVc2N0WXFneEtVNk5qNGIxWXB3?=
 =?utf-8?B?eGRuTW5lNGN6TjNYQVpBYVQwNUJscnppTVhydXRHbzM2WERqclVPM1NNQkxQ?=
 =?utf-8?B?aGxBRUpsL2Q5ZDFxVmpuVVhOcCtDSUxGSFhJcHBIZUJOUStFZ3BkdHVuV1FL?=
 =?utf-8?B?WUFpTG5Gd3BjWUR6TmtmUS90eXFVa2tMd2JPR2dKWGc1b0x1dFpiaEsxU1FV?=
 =?utf-8?B?VTZSUzVaNWFDUGQ2aU01WWFPNXlQV0hCMUxaMDBDMEQ5Q0E5VU11bHRCS3NQ?=
 =?utf-8?B?SHM4d01TRGYrVFZZRmZyN1M3VUVybWNIUjlPSFJaYTUwdzNHSVoyUndhN2xS?=
 =?utf-8?B?dnFhWi9CUVdIaklvbHJNQkE1aUIzYWxyUVhpLzRvTm1IT2hQRGNiZ3hwQ3Fn?=
 =?utf-8?B?Vmc4bFBJQmxkblRMRzM5Z0JKaTFMTllCS05qdjIvYW1zQ05MZkNiV01IUXBB?=
 =?utf-8?B?T2RyaWkzY1Z1SUFVSnJEMmVHK202UWRNa2FBeWFFYythRTZqdW9mUGxLOVdy?=
 =?utf-8?B?ZmZBVWttWDJMODBBUDg2Y2hyNzRZYTZsUDFEMmxLWXZ6bEl4a05IUlV5ZFR6?=
 =?utf-8?B?NDBuem5wa0RPQ0swVmNsQ3BndExjM3F3SFoyODZvZHJ0WDJoOTMyWU53WDVz?=
 =?utf-8?B?YWw3MkdLQ092aFJjUDh2QjZ5K0dYdllQaHhxWkR5bXBJbk1rejE1eUNPWjB4?=
 =?utf-8?B?cjJxK1hCNktMS1E4WDZDbHg5aW03SmFkcnlZclFId0kyZW9SaFhHamdpS1BJ?=
 =?utf-8?B?TW5YVHU5SGNUemtWcTFDSkFHV0liYUkzSUR3c0FEQVErK1JoZldNOXhaZkdh?=
 =?utf-8?B?VGcwbzYwVXpIdjl4Q2NvWlp4Qkx6VnYwd0FaM2phMWhkcUxlaVJZT1ZvTmhp?=
 =?utf-8?B?SHJZQ3F0dXppME4rcll6eDBVZTU3QTVKajNYa0Fqd2xZaDlaT3BEOGk1dzdh?=
 =?utf-8?B?QjN6Uk0zU09ZOVlPZ3UwUDlzRFdLRmt6MmM1YUhHek9pVWRaMzFZZjloRlVv?=
 =?utf-8?B?MEg1bUR4TkZZT1AyM3BlR001UEh1QXdhWHNtN2RTMWxBMUhQLzBwOWdmMzZk?=
 =?utf-8?Q?ShNq01o3+XW5TxLzZE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZKUGgxZW44V1k1dDJUbC9FSEhidS8xRlZBLzRURGIzRUJETE5lU0RaMWRV?=
 =?utf-8?B?cW8zRWdNakJJRjl2SmJlNnMyUXI3ZXdhRmxmUkMxaW9BMi9lbG9uWmpLTDNZ?=
 =?utf-8?B?THBpK01XaHBNRzY1SUhtS2Jla2RtanFnU1cybEJmM3FVVEZ5RjYzYkVEZFQr?=
 =?utf-8?B?bE54UTVtWGpGYWY0L25nSzZYQml5bm9CZjF3MzFiU3A1c002VXI4WGhWbjFl?=
 =?utf-8?B?QnFZam9WQlc0dzJNQWVITXpqc1hpKzhKTVR4V0RLUjY3MFRsdC8rUi85WUE4?=
 =?utf-8?B?YzlDTE5TTTJ2L0k2WmhDWlcxRmF2czkxMFRucFNkclJVbWtCcTFzelhDUXVD?=
 =?utf-8?B?L1YyUkZkM3RzWll5NDNCMTU5TTdFKzlCOHo0ekJIdjZETHEzZ3NVakltTTg5?=
 =?utf-8?B?eVBCbVdjb294KzJ4dFFzMUhDTG85MVVvSDhGUXJFM1hPSm5PdFN0bzFIc1JE?=
 =?utf-8?B?QXViMFlFRnlOTDRKeCtjMkYwek5HcEFFc3U1UWZpYmZ4a0M1aHJXVU9TeFdI?=
 =?utf-8?B?bE9VVDZQT1p3Y3JYc0IvajIwR1RReGZXaTcvWXd2Mm5aRE1XTjVtZ25WZy9p?=
 =?utf-8?B?WUFmTmJWR0FvQ3lqWFNGNFo0bHV2VXFhVHJaR3RxRlFzUjZ0Zy9LT0pBcVIv?=
 =?utf-8?B?WXdOa0tXTmFCdHc1eXIwK0N1Q05aUDV3NkpoT0w5cnJsczVXRlhieExqcXE1?=
 =?utf-8?B?VEFSZnRCcGRJbnpTQlFJOHd2ZlZrU3lOalQzMUx6dHF4Z1JzME9xbnkybUZP?=
 =?utf-8?B?NUttZWpobVFkckFtMUlqT3BHWmtqUmZaQStvSmhGN3Y0clAvSWpZbEJsb0Q2?=
 =?utf-8?B?Z1hrSUNtWUVBQkdXcE5UTDAzK3F0WDAvbFo5UHZhWVhZMTNRK0V6WHdZeEp5?=
 =?utf-8?B?ajRtOWtxUGNVM2RxeWRwK0lDYkdXTHNrMnk2YXRzWU1mT2tJQVhNN0ExUmgr?=
 =?utf-8?B?ekRQekJlaWRLVUpuQUt2TEd4T216RkdHVXNPRktYVSs3ZkRYOXpNQ3hXbmlx?=
 =?utf-8?B?MGpobm9ZeW1RcHczVmVYZTBVY25qazV5WXJSYjZTWFpZUi9DaHRkMjhoTXU3?=
 =?utf-8?B?K1puK0crbVRqbWVzSkVRWjdEb2RHSllRbmliQ3ZENjFydG9WcFRWRndKdmtr?=
 =?utf-8?B?emZMWThjUTYwVHM5V3hyS1lBcDEwVklDZit4NGk1TlBiZXhyRVRTMmRGR3Ni?=
 =?utf-8?B?M2tvVnZLSUVNdG5PdlI5SE9FK2FwWGIwUDV1U1V6b05uK3BUZVpnbFJKSkNZ?=
 =?utf-8?B?b3BCMmlEVXlLNTUzUUdBVVVOMVFuM3pGTnE5bjJZNkZaNEhlckRlM0dJd2FL?=
 =?utf-8?B?anUrTHpFeDlZdUNwQkozTEduOXJ0cGtVa3doeDBoc09nb2tCelBxZWhpbzBJ?=
 =?utf-8?B?a0ZpbDllWmpjb2kxKzNZS0RDSWNYeUNtanVpODYrSWczNWd2aXp5YSt2WGRa?=
 =?utf-8?B?MVJFbmtNTkVsdzgvSkpZdlY0K1JUNWlKY0pkY29FK1BySVQrUytqeUhkaDV3?=
 =?utf-8?B?NitkNEpiOHVkTjJvd3k0QlZ3WFBoR1B3djZWeXVtVEpUMFJCUTV2a2Nvc0pi?=
 =?utf-8?B?VUlHVXlhOEllZXg4Qmh6MFM2Y2Z6OTJpalh3dk1TbE9FRVk2TzVkbFRYQUVy?=
 =?utf-8?B?ZDVkTHo2QVJ3dXJRV1lhc3FBb0IrQnRNQlRiZFFGMTVubmVjMEhvd0Irb3FJ?=
 =?utf-8?Q?4I2szOYHlV1rSEkxq8Qh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12051fd1-d796-4a4e-52ae-08de1706005d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:12:48.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6271



On 10/29/25 18:32, Krzysztof Kozlowski wrote:
> On 29/10/2025 15:26, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> QCN6122 is a PCIe based solution that is attached to and enumerated
>> by the WPSS (Wireless Processor SubSystem) Q6 processor.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> The prefix is never "dt:".
> 
Will do in next version, thanks.

> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 

Will change accordingly.

>>
>> Though it is a PCIe device, since it is not attached to APSS processor
>> (Application Processor SubSystem), APSS will be unaware of such a decice
>> so it is registered to the APSS processor as a platform device(AHB).
>> Because of this hybrid nature, it is called as a hybrid bus device as
>> introduced by WCN6750. It has 5 CE and 8 DP rings.
>>
>> QCN6122 is similar to WCN6750 and follows the same codepath as for
>> WCN6750.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 57 +++++++++++++++++++++-
>>  1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index c089677702cf17f3016b054d21494d2a7706ce5d..4b0b282bb9231c8bc496fed42e0917b9d7d106d2 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -21,12 +21,13 @@ properties:
>>        - qcom,ipq6018-wifi
>>        - qcom,wcn6750-wifi
>>        - qcom,ipq5018-wifi
>> +      - qcom,qcn6122-wifi
> 
> Why people keep adding to the end... previously ipq5018 added by
> qualcom, did not even get any review.
> 
> Place it before wcn and let ipq5018 be outlier since this was broken
> already.
> 

it was exactly ipq5018 which got me thinking I should add it to the end.
Will alphabetically insert qcn6122. I could reorder the entire list as
well if you'd like (ipq6018 is also misplaced)

>>  
>>    reg:
>>      maxItems: 1
>>  
>>    interrupts:
>> -    minItems: 32
>> +    minItems: 13
>>      maxItems: 52
>>  
>>    interrupt-names:
>> @@ -87,6 +88,14 @@ properties:
>>      items:
>>        - const: wlan-smp2p-out
>>  
>> +  qcom,userpd:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [2, 3]
>> +    description: instance ID of user PD (protection domain) in multi-PD
>> +                 architectures to distinguish between multiple instances
>> +                 of the same wifi chip used by QMI in its interface with
>> +                 the firmware running on Q6.
> 
> Broken indentation. It is supposed to be two spaces. Look at this file -
> why are you doing this completely different?
> 
> Anyway, please do not come with 2nd or 3rd property for this. We already
> have such somewhere.

Would you mind pointing me to the property you're referring to? Do you
mean the QRTR ID as proposed in this RFC:
https://lore.kernel.org/linux-wireless/cover.1732506261.git.ionic@ionic.de/

if so, this wouldn't help this in this case. Although it's PCIe based,
PCI is not even enabled as the Q6 firmware itself takes care of that.

> 
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -268,6 +277,31 @@ allOf:
>>              - description: interrupt event for ring DP20
>>              - description: interrupt event for ring DP21
>>              - description: interrupt event for ring DP22
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qcn6122-wifi
>> +    then:
>> +      required:
>> +        - qcom,userpd
>> +      properties:
>> +        interrupts:
>> +          items:
>> +            - description: interrupt event for ring CE1
>> +            - description: interrupt event for ring CE2
>> +            - description: interrupt event for ring CE3
>> +            - description: interrupt event for ring CE4
>> +            - description: interrupt event for ring CE5
>> +            - description: interrupt event for ring DP1
>> +            - description: interrupt event for ring DP2
>> +            - description: interrupt event for ring DP3
>> +            - description: interrupt event for ring DP4
>> +            - description: interrupt event for ring DP5
>> +            - description: interrupt event for ring DP6
>> +            - description: interrupt event for ring DP7
>> +            - description: interrupt event for ring DP8
>>  
>>  examples:
>>    - |
>> @@ -467,3 +501,24 @@ examples:
>>              iommus = <&apps_smmu 0x1c02 0x1>;
>>          };
>>      };
>> +
>> +  - |
>> +    wifi1: wifi@b00a040 {
>> +        reg = <0x0b00a040 0x0>;
>> +        compatible = "qcom,qcn6122-wifi";
> 
> Don't add examples if they differ by one property. Drop.

Dropped in next version.
Thanks for the quick review!

> 
> BR
> 
> Best regards,
> Krzysztof


