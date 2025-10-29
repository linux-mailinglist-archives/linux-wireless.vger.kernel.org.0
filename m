Return-Path: <linux-wireless+bounces-28374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF85C1C8D1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7C4E79B6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B93546F4;
	Wed, 29 Oct 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q0HzdNia"
X-Original-To: linux-wireless@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAC351FC1;
	Wed, 29 Oct 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759689; cv=fail; b=BLT9e/eoRa9reXNArkRckcPNgQJltcK3p6stqM+JRl6cE5Uaw+5J5aPXYWtsJGYXLZy7SNYMn+AKhbsybDu3dXzARM6F8Vwo7tJRMMKfTag5yWJRx3NzBLfdVandJfLfTsAPsUIdXd/vb3r0g4ia0DAATxmePXLNbygPhSslFxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759689; c=relaxed/simple;
	bh=DteqLciVd9siDNMecTs/XB+6/k/KpV88DkT1sIW4+pA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7fno2wLk5i3hAaYGY1JB03zxCpkRFrp9kmNc0qylKQkXGVxBaievOvNMXqtVBy/CwBQUU8a6b7jhbuT998VjMylnCivQXBVMczD20+sZdzm0oKz0D6IOwXjm/SF+XL8Oht5IUf3oKeNJg1fzSjBnerOam1Wic6kU2K+JX8gNQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q0HzdNia; arc=fail smtp.client-ip=52.103.11.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmI2rxZciqkElxC+fCFOSqk6ZPe6bO2D8o6kvZA8Rd8W3mqUGf0i0o/KjQ7pu19AcWU3283hBLMd8X6EYEfEOFQO9tahb5LOlBFf8Ng7ur0fhKKl4B6MuQQFgWisgTfX0oUH7O/HGH4GEMG2iUcjagZegj7p0YxkarfIc21GBhjhtq58iKdRTXiE/wWY31FfMEoZhMsb4ifHdlVgSJ56o50yMMmokChedQ9sGMpkdE/blmpNdVcYe0oy33mUWrcumPn0CGWcXd57+/cYt7Wp42yfUUhhIItpJF8G2KhVZLcXF5skeVBRmOLQbT6vvgWtbSkmBQU2/kWzyjvTyU3pgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Tm2efnxxnQzoL+56KNFAzc6Jp5lRujeZJq36TELet0=;
 b=VzVx4MsWm5gNQ2z42whQqbUMNLik6OAFxECEa3NhqJP8UOb8oC+f3+hXsh6Pgjs8exiLEmUk3uVAWT8YCO3NATzZl/eMgCDwIpMVyICwqqjKobn6cVq7+Iow4Mu7Pxh+swAjYtC8d/B81/0JjaN3f23a+46ZUeU/fx7T4nh6aFY5IjlJXvL2+uppN5NuuSEr3MDhYlvXlIQzQGp4B3UiNmUsVzoCcLbtUbMqYSISQWxqBQ9fvJm0EwSgrbNswzJYlfj0t61yhqSsdC1s1hyxDWck5L52gYRmg7uiXQ1p50eZhXUlU9JC26M5OIq9K7BEmIYbHIWudwqHxK+miSpF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tm2efnxxnQzoL+56KNFAzc6Jp5lRujeZJq36TELet0=;
 b=q0HzdNiatDxpg5n6xct4nYqUSsXTqXzVzx9l8khQUzyIejYhW/XvQwvfmiE13w/OvVnOIGQf9yiwZCZm+ZmkEebMLhoof76jCIKGoaMbkQNK+TPg9pbMC52EYL5vpo5vKaSISxpzum1f9W4xchvspExkK0YEEJB+7o2lUBZOKv6BscWVpSQjDx3QNSs5DLhXITW8TrGr9VQ3v4t2GxAd8AQmznolHOIkAozDi60qJafzzAe4QBaYok9tvpr0z9apqqKTQxT0J1an/vYBSTISGGl+oYoo4vm86TjVgvFvGLlPpQxKr6aNDcQvmuoV8QKhrukgHOhyHD519ul8eWoBNw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH8PR19MB7165.namprd19.prod.outlook.com (2603:10b6:510:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 17:41:23 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 17:41:22 +0000
Message-ID:
 <DS7PR19MB88834F5A352F93EE909AB42F9DFAA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 29 Oct 2025 21:41:14 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: ath11k: add multipd support for QCN6122
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
 <20251029-ath11k-qcn6122-v1-5-58ed68eba333@outlook.com>
 <5137cd11-004c-43ed-8bbb-646beb105844@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <5137cd11-004c-43ed-8bbb-646beb105844@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO3P289CA0023.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <32a3ba0f-d9dd-49f5-a9d3-3e3916de0f3e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH8PR19MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b811af-8dc1-43de-93be-08de17125ffd
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYBk0OqXWkGcw9KFcS+e1k4icv+gtFELIJ4ZxYEjZ5dCz32cLIIlt6pb9Z7MMQCi8E1jc83seq/I1nXKGtjTifUt9tgXN3CSPYfong1fduBot2sOGhw4sZ8Uj7xQjqQjStn+tJW/D0X+9SRvK0xSvf9u6ef5NscXKj8w4KaY1oaM22vlTE1zuCbM8d/qSHl24BjqFf85nLIGuHjku+YAhjDjjRkMe2HAsXo803UQ3Q+2EtoCjUc5m3E47oBp6pHjsY+ZozMiAvonsCB3TGMbduuL/gvXBW1kC7DogHokW5sVgT5zkpRZO94jNN7j6kP28oaV70SLEtLE+eM6NiAkTSFsD4NEkhydicDMXp9NObl512o+2JDLIhCtbuuM11/f1K/ptPKfxRtZYcU2hF1NBCgOXEzahIy6CRA3f3XXaTZlWeI1DKK+N6auXNF41oixTTWpmpWZTDjlgbPfFY8KekCuEEKmLtn18kl3B/UbmxCy40C7apEWaDaB0kovcFAT8aSjFdRFruWSFgMSaN0aETRn1IiZ3IKDKS0QrQqRRlbutddG+6X5Bo3oKN7nVql00oJxyj9cbkXW2lEYmIiPdDLYlXqNboz8O1IZvQEMuaJIdmLj/YOTyc/XPNrR5Y0NuLIn5i8eZk3+ef3Ad/JtS3C1jiFRz1rc3rbAec+3c58k+CGOaWW59TrnHDMaw53+je1SSIzY90DQGRbb65Ob0LPvGXIZ6JKIgbbOltwXM8MoSCB+4U0yvClVLQI2nhYeElPTf6ooGRv7ypeDkg3If6RWGadVVAgUg3mG0BzHc7asSpG0hMnFtvE38BeVwhOAvRWIrjr8SqNvYQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|15080799012|23021999003|461199028|5072599009|6090799003|41001999006|3412199025|440099028|4302099013|10035399007|40105399003|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVlINm02Mno0V3JNWEFQbmVUalhpcWRzaVlqZm52Z3B6Z2w3VjNiTjNGNnJ0?=
 =?utf-8?B?LzZwS0xteDh6SXA0VW5DbnBuV24zWTVZVklNS1BGZE5RTkdtaWNQemMrSXVi?=
 =?utf-8?B?K3dEYy9ybVFJZnpOL21jRVhFdFlRakxjRXN6S2RJVGJ4aHpEQTd0QStVUCt4?=
 =?utf-8?B?dk4rMXlxeGFQVmJUT2RVLzFQdUpvYkR3SmFtT3U1OXNKcW0xNU9uQVdsRi9K?=
 =?utf-8?B?Y2lUeW9pZzh3ek9jRGZmSnA5c1FtT2VoTGNkQktTb0VCZTBrUDlKaGtyQ1Vv?=
 =?utf-8?B?VTdYWEZqUWh0V2Z5ZmZwZWo5NlpyM016Z2xzekhrNS9wd2cvd2srMDRVWCtL?=
 =?utf-8?B?QUlGWnBDSXJDRHliMGlpSHBraWwyWktTd24weDQxekFRVmVSckkyOU5JOFNz?=
 =?utf-8?B?cGo4TW9WLzhMdGhHOVVJSjh0N3VuaFdkeS9zY01LVTMwUnNCeUcvY0NIOEgv?=
 =?utf-8?B?c3QwRW1Ta1Z6NDJaNWlOcUd3ZkYyTHhWUll1RU1mMUtiQThINklzQ2xJRW9M?=
 =?utf-8?B?SWlnWVMvYS9XRnZjRnRiVm9McEJYYTZDaUJFR3JHdCtYNVE2bkFkMnArWW1B?=
 =?utf-8?B?QS96Wk14aFdXMzB4WWhlbUlweWpFRlBNemgxNW1TbFI5TEdzMVFmdlg3cnAw?=
 =?utf-8?B?SUlCQndEQzhPbkxmVkJaSXhid1pRcmtwQitkQllXTmI4bGNJTWxuZmN1ckFE?=
 =?utf-8?B?cUk2Q0pMYmNvckR4d0VoYlloKzVQbkZ6ZWhud0s2RWg3TVB4SEFDWTNWMzhP?=
 =?utf-8?B?SlhRMHBMUFp1Yk9kWUhwZlNpaGtpR2o4OE1haGVLZUhZRGUwUDFFOWhrRkRP?=
 =?utf-8?B?UDZueTVBSWdNV2cwVWRVMkRmV0xqL3RucGxPaERNZW9OS3grS2R5ZElUMlZC?=
 =?utf-8?B?cWZJelFaczdJdnUvNjZkRzJxOGE2Myt2STRVVFZ5ek5kNFl6amtGT2FyemEx?=
 =?utf-8?B?OTc4R1R0a2RSOFpQTUltVmVmYVVCTmZvVnFUWUFIejFIVXhoL1FzdDZJTC9w?=
 =?utf-8?B?emxYTTYwZXZnWk5EQ2VDdlZ6K1lpMmxkb0RxbktBNUlVTGtKUUI0dExCQUJK?=
 =?utf-8?B?UWdQMC9Xcjl1NUFvN1dJUVprWWYrblVoRTJ5MnpYRUdDczBIai9DbUloamg5?=
 =?utf-8?B?OVFFNWcxeW5CaHJlMTBkVXlSMThrNko5UC80SkxUdHdSUkpKTVhMQVZJZ1VY?=
 =?utf-8?B?dVNsQ3JUemh1UTVHQmF0Zmw1U1lhVUNINmtzZlBzVC9EaXBQZC9oNEtRQkxG?=
 =?utf-8?B?eE1NSHB0a2o0emtxQ0kyTm5Oa0E3WTdBc0JMb2hSaDZrcUtwU2tUbzJzMFFq?=
 =?utf-8?B?NFYrcnJxV2N4NHhVMWJHWWdOUkk0Q3gvSjE3bkxRUkQ4alRMaUYrWWRKdVU3?=
 =?utf-8?B?RTFxODFiOUJXUXRyWFFVZ3hNNVg0U0N0NDk3Rm5KWTRjY1EyWThad0tBZjEw?=
 =?utf-8?B?WG0xTmFRb1hjRzRwZUozSWFETDZ0d1Z5Z0NLVE9LTVk2MlRHVVMxTk5XM3Iy?=
 =?utf-8?B?Q0Y2Z1VEMTgxM1V0QUx6VlQ0VUs5a3dqREhRVml3OE9QdDJQd3IxUy8vY0t3?=
 =?utf-8?B?b2VZNGpQaDkvTE1VZHFYKzVhdEt5QXZRc1Y1Sy9VbHVUOTIzejlkR0FsRTlw?=
 =?utf-8?B?TEhYeG42NHFRWUt3ZWJhY0FMWnRMd0xYSVkzUkFQWjRGaHYvUGlmZml2SHZ5?=
 =?utf-8?B?UGtNazZDbnNsQUtTdDlrZnp1UXBUT2owa1dFVVU2STJvVWdMMlRyRmI2Ynh4?=
 =?utf-8?Q?u09LmRcT1BKssYBphQqGBtMm/2Ahn/x1Mi8kxjQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pVaERzendza0QxRG1vendwRGZ0S2kvTmVHSlRtNDZyc0YvSjZ2Q1JTb2hN?=
 =?utf-8?B?c0kxTE1NdW11V3FkN2V0bzJac0tKRDdrNXRiZlBnaHVZMjgxZ2VjeEhSK0Fl?=
 =?utf-8?B?enFCci8zUFV6OVp6bDF1ZGJrOExkZHVpakZkdFphMjNRdWxiQVNZZlA1ekNp?=
 =?utf-8?B?ZS82NWhRdS80bTdxZjU4UUN3QW1VRnFjUlpBeE9XRmltUnE3VUd1SHluL1N4?=
 =?utf-8?B?ZElHMHJEOVRqWlN5TkJOM3ZuUjMxZnhnakppQWgwRk5DUVdON3duTk1qWUl4?=
 =?utf-8?B?SXd6Y1BEMW9mUlpmZlgyeWtidnRTeHo1aXFVeW9qQldMUjE3dVlsWXBlMFM4?=
 =?utf-8?B?UStyT0ROcXJ0dTM0citBSkVFMXJEU3BrakZKaDRBcXNNeDFDUDgxU3Q0dUc5?=
 =?utf-8?B?akpRREV4Y0pPTzJLS0Q3UkxlUGZFdjhDVVlSZGRhTTQzWGgyWTBHck5HYzFs?=
 =?utf-8?B?YnBkQUs0UW9qZ3JaMVlZQm01OVcyeE5uWkI5ekJCbmhoRXcreTB6VmJYeEZI?=
 =?utf-8?B?S294RXJZOU92WmwyY1VGV2NtcmMraTh2NHJpQjVlYmRXNU5ld3ZMTXBFZmJY?=
 =?utf-8?B?NnlFcDBpRnJrSWZzNHZlTUVvdzJMaEhnMXcwb2xNMXppSC9RRVdBMkV5bEFZ?=
 =?utf-8?B?NmJnTVdIdW4wMzlDdVJJUEwxdzVxRTZBOWIzZk51Q3BxWm1vbzNWWS80bVNX?=
 =?utf-8?B?VnBHRXJZTzNBWVlORmZKaVpuK0Y0NjlzMFowMFFhU0E3ODc4U240K3ZYYlBw?=
 =?utf-8?B?THZiOTNYLzFvMjl0eitRNWZvcXRVcys4cXF2elJENGIxVUI4aHFnUkFteGhJ?=
 =?utf-8?B?d3IzUFhteHdQR29ZOFEzMHY1SGw4WXNGVi81dytYaDNXTUgrc0M5S2szdUZG?=
 =?utf-8?B?d1QvY21HL01BSVVMQ1lVaWZ6ck9GbEZLditOajBWMklrdkwzNzQxWHExYkMv?=
 =?utf-8?B?WGd2OUF1Z1E5SGRKR3NLeTFlVWRObGRYUGlIdkoyNXV3RC80endrbDBCbTZT?=
 =?utf-8?B?VWkwR01FNEwxN0lQUWFzU3JITjNjQXRIaVpWMHgvTVI0K3pIdmtvUFJwcXBz?=
 =?utf-8?B?d0xLUk45ejMvOGhjRHZSUTFhR3NXUmMvenBmVGpFbEtza0hJUkZLRUdFdE5D?=
 =?utf-8?B?eStQUm1jamo4WXRPV0N1dHdicEFwdWVZeHdUVTdtdjVTNFVYOFBFa2tlY3oy?=
 =?utf-8?B?S2k2dWxSemMvb2Y4bzMrMmRybllKekU2cVVnOEtjMFBLVWIvaHhLRVE2MnlV?=
 =?utf-8?B?TktOQVpCcWFaQjFld21GTURjMms5dk9YM3dpWmhJaUFBZzlSU0xWMGFWRmFS?=
 =?utf-8?B?M0kxNU9Vdmg0VHYrTmsvUnJjdGdSQmJOV3d3YWg0ZzQ0S1pYLzZxa2dFcGJM?=
 =?utf-8?B?YjY5cUVhcGF3V2Q2Z3hNRzlIN3lEK0tZOU5VaVBlcmVRSW9DWFV2QVd5aWhX?=
 =?utf-8?B?QVpBT1VwdVZXLytLVnpVRHk5QkR1WTV0VG5XT1NHWmNCalhpNFVBUlN1QWdC?=
 =?utf-8?B?dG1xYWtzdi9lSDdmdFJkbGdQYWZadmFKbGdGV1Z5cHQxQUFLK2pIWGJheDAw?=
 =?utf-8?B?ZXZYOGVubW5sUWJyOVlDM0tQaE5uL3R6STV6NVRIRlI5Q01xdEJBdUk1T2N6?=
 =?utf-8?B?SUxsd2U0eVoxRnY4OXNzV0FhMGxzNVFDeFN1ak9Fbm5wdHV2UWRnUmZpdWZ5?=
 =?utf-8?Q?HQ8nlHS3sXEWgxZGpK6t?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b811af-8dc1-43de-93be-08de17125ffd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:41:22.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7165



On 10/29/25 18:43, Krzysztof Kozlowski wrote:
> On 29/10/2025 15:26, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> IPQ5018/QCN6122 platforms use multi PD (protection domains) to avoid
>> having one instance of the running Q6 firmware crashing resulting in
>> crashing the others.
>>
>> The IPQ5018 platform can have up to two QCN6122 wifi chips.
>> To differentiate the two, the PD instance number (1 or 2) is added to
>> the QMI service instance ID, which the QCN6122 firmware also expects.
>> IPQ5018 internal wifi is always the first PD while QCN6122 cards must be
>> second or third.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>> See below patch for more info:
>> https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/
> 
> I don't see any common part with that. Your bindings are completely
> different and while PD was justified there, there is no such
> justification here. Neither in the bindings.

Will adjust the description in the bindings and add more details. Mind
you that I don't have access to the proprietary designs / data sheets,
so it will be based on my understanding:

The firmware running on the Q6 remote processor takes WCSS - wifi
functionality - out of reset and brings them up. Each wifi radio on the
IPQ5018/QCN6122 platform runs on a separate process (referred to as
protection domain) which avoids one that crashed crashing the others.
The firmware and kernel driver communicate over QMI leveraging the user
PD IDs as instance IDs to distinguish between multiple QCN6122 wifi chips.

With that, would the additional property in the bindings be considered /
accepted? Else, any guidance would be appreciated.

> 
>> ---
>>  drivers/net/wireless/ath/ath11k/ahb.c  | 31 +++++++++++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath11k/core.h |  4 ++++
>>  drivers/net/wireless/ath/ath11k/pci.c  |  1 +
>>  3 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>> index 7b267dd62e964b2c4d6c3bbe016abd1ad0297219..820a383e88caf125892176e421b0121fed7e7055 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -429,6 +429,7 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
>>  	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
>>  	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
>>  	ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
>> +	ab->qmi.service_ins_id += ab->userpd_id;
>>  }
>>  
>>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
>> @@ -1101,6 +1102,28 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
>>  	return ret;
>>  }
>>  
>> +static int ath11k_get_userpd_id(struct device *dev, int *userpd)
>> +{
>> +	int ret, userpd_id;
>> +
>> +	ret = of_property_read_u32(dev->of_node, "qcom,userpd", &userpd_id);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (userpd_id) {
>> +	case 2:
>> +		*userpd = ATH11K_QCN6122_USERPD_2;
>> +		break;
>> +	case 3:
>> +		*userpd = ATH11K_QCN6122_USERPD_3;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
>>  {
>>  	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
>> @@ -1142,6 +1165,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>>  	const struct ath11k_hif_ops *hif_ops;
>>  	const struct ath11k_pci_ops *pci_ops;
>>  	enum ath11k_hw_rev hw_rev;
>> +	int userpd_id = 0;
>>  	int ret;
>>  
>>  	hw_rev = (uintptr_t)device_get_match_data(&pdev->dev);
>> @@ -1160,6 +1184,12 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>>  	case ATH11K_HW_QCN6122_HW10:
>>  		hif_ops = &ath11k_ahb_hif_ops_qcn6122;
>>  		pci_ops = &ath11k_ahb_pci_ops_wcn6750;
>> +		ret = ath11k_get_userpd_id(&pdev->dev, &userpd_id);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "failed to get userpd: %d\n", ret);
>> +			return ret;
>> +		}
>> +		dev_info(&pdev->dev, "multi-pd architecture - userpd: %d\n", userpd_id);
> 
> This does not look like useful printk message. Drivers should be silent
> on success:
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79
> 
>>  		break;
>>  	default:
> 
> Best regards,
> Krzysztof
> 


