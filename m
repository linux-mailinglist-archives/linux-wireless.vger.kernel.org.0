Return-Path: <linux-wireless+bounces-33104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBZuBpi5smmvPAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:03:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A69CD2722D4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A689E307B7FF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795A3C4546;
	Thu, 12 Mar 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="a9TgEhEr";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="WhUGEoi3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E852459D4;
	Thu, 12 Mar 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320439; cv=fail; b=TI+2AXwI9OTyTX3NAWVAigs+1xL0gTAZXX3cdaQfndnPtejebV8S238a5LfNbwlWthvAlTA3m1zNY9KyKR2TKLbOSlE9yrFkuuoqc0Kou2hUPliYnH2vGFi8OvLvC3z0/wRhtV/YbJZfM88wv0XDLDRQLqePLbKzcMSeVMSyFR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320439; c=relaxed/simple;
	bh=JvjrVTMgfV7QwWcvi6JEPeO4+7diux9+Pqop06wB0Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fXwTeqXEKuOzv4J3ke8vKsDtiqbingsVE7SNIHz6oqPKXbCtce8XByl4XEqfhgh53OSvaDqJXfZ9XvFf8DMK0iRE59F7VEBVVlRlZ+W+CJZh7U1+Wfcuzn0c+aTZeNZhwybroH5LqI/Ni4fM+BbzbQxMMvumgPV7FkQJFgU5l0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=a9TgEhEr; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=WhUGEoi3; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5XgPV3751703;
	Thu, 12 Mar 2026 14:00:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	6w+J6djcVBpw2+d9DZLLEa/wQcKyQJ0NCmt0oAgfogg=; b=a9TgEhEryi9UVsaf
	jVTGEAwRqyGipIIaaA6FI4lJXKPpWSStcQOeo2E2cUQwDrfAm1G7dY2oS9wU6aHR
	a15zrmbWkCtOxhve4twbWXJbB6xyxhUQpOJkiZleeLO9uclyLdcZm1Y3T8g05Qsi
	LqUAbsyAU5TTfX6IL6z3/dbqPHM2phwfpsPJ0bdK3lsd1d1oyVodMZfaoLqv86f9
	ugbZBZnWukhs9AiJwTO9JtY2HXQ06G3qaqKJenp9XPKisuCZIgl7cfowI7bs0YDN
	fIGvXKuIGYnbTImoi7K1X7tL7yyBvAHx+ScFcZjqWaLTPTaFTISS/311+Q8xtgEo
	F3KXkw==
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11020091.outbound.protection.outlook.com [52.101.69.91])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cty3ghgsy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:00:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQrJUsl6pdwWWPsanjIOpHGfHoWc8PXCj2IFHuDQpmZP+uJWYpjuNGU1L/OpYfFouQgbIvpewLaBmGKJ2P2W0PNCQQeBzjlm4FdipzsWjao65S4VB4uNSHdh5h8iGYyGUquZKkydI3BoZO2pt4UkmFic2uRKU6Qhx1GRGNse573codzc0dzZPMrqTTKa/D/lEn7aEojHVr47FwQPx2fRcwVFtXrQkj7j8LzgdbLfwbqqXbgDTRj4Y4seAd02V+WVpvXaI976qMoL93x6a6GGn3FXrFGUPUJNBiRlXzQPUb/XUFDSf2qdXStPp1J3V5O/rqPyikEUbTbTsFGcZG/jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w+J6djcVBpw2+d9DZLLEa/wQcKyQJ0NCmt0oAgfogg=;
 b=aDUvMj+U3WMDXYfow6SZgkRCJ1JQs7PscwLfJAe4Wr/FIzwXHYZtjb/p8gs49m0Y/WLcav9Titmq9xMnQA8y+NCTE54GY7yDO6eVf2GaI8CGJbPyHbu0dYtg7iilbqLF9ffIwvEVc5gZrJ+xP9IHSHAR6Elc7+p3ireaeMkxXtpGHINCTjdgiiYzu4xy4wmK1s5H/XuYa05HrJdmoFrSQggZdh5SEvXjeWG3NR6rmMMGjCKWdCr8ppLR3RHxSHBiDZnT2JC7gwBVBxtEOVbUZVjCNsxCB6LRmSeNopSDGMK6YveR9zLiXIzs0P/+90bdxA9aMuxIzM6/AXpinpL6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w+J6djcVBpw2+d9DZLLEa/wQcKyQJ0NCmt0oAgfogg=;
 b=WhUGEoi3Cn0/x6W8ThWnhSXKMEzSK9kI+YKU+kyNRQSsSSZ09gsSsYGhsTj/LZ8X6jn2e5m7P/W7z9taO9WVAUrCMkgShbxxwfilmyV6UhbUFSheu24I+rw+MeM3zCrvCkOv2aoTbzdaApnMTJ4Mvryr5zETJlp4BAxpZuBUYXI=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAWP192MB2104.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:343::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 13:00:21 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 13:00:21 +0000
Date: Thu, 12 Mar 2026 14:00:15 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: handling of HE and EHT capabilities
Message-ID: <abK42BnlaPi9J9YC@FUE-ALEWI-WINX>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
 <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
 <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
 <40b4b959b2ea5afd55381e6ae2d0c1908456734c.camel@sipsolutions.net>
 <e8960517faf04ed4f1bf331e23a95c477113309f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8960517faf04ed4f1bf331e23a95c477113309f.camel@sipsolutions.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0001DBCF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b5) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAWP192MB2104:EE_
X-MS-Office365-Filtering-Correlation-Id: cec3cb6d-a1ca-4bfc-8a09-08de80375187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4MfXFJzuzfGcv/W5ioTQ9Ly3+pkFIWjJdJNxyRwS9OMkfsbVs3dejHRDNIetiUItd8TT6c4g3ORwVabF1My7pyMfJ4DhgsPyajLxr3bieWESEySHm9+To6dcNibLZ+qR3KeUaPQBroQ4QFtTTuVxHt5CJewxpRhT48velvuloTawAm/7DUcjp451L5DLkD7rXFjzBzLaVOR39/pYBI/folCHspjL0g47TIfaNIc2QhvT9AgQNNnBU5oPgul9WwQ5Wf1K9Vj7F1f3q0uMVFLnXIRI6zXmcVfJinHpjprnUIEJHGkPlIEyUSTXwWIWXGiaQFbAfcnQEmKPZkvSnCyiI2eujjdfmR+TY8d1DFwOI7sxXNH4s6QTkHF6v3LdgDZBBJkzfU4JHa+wVRrAn9Ui4orfqka7Ivv1tNZTill0I/dNRIhsn6qYmVpHZuUE9c0YiFaddMC5BD6WnXgXBMcSGOobGz0KFV1HORzrZmCPnXJMenWWSCXhVJEPq0ueQiLRwNxGf8y0mbCQApOgUKyKq2873V2ut1B1OgdJL2KL8i8rwJFERe73WWc+Oo02S4yLGuR8HTrFIbq3UyvCb+AmkXlR/0yDVaU3QGGa4yWPvh/gkwm17TL1QW9tEXq1HU/TNEiZ/dijfWQFMaxvRs+CCdY8pTJmuPuiIuoaVoitmc4QwDv8ByYicU4+LJHNIAFVTqdB/0Z8FCNg5lEP0piC0TQBrU+OvnzcHcfbvQqwkE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllwT2g2eFVrQjBQMEpQN3JWRzZKdTlkZEtsZ1hiOWE1RVVsdDhNWjhDb3Zx?=
 =?utf-8?B?NWhvMUhXV3VYTjR0bklRTENvN3hQMmdxTUNqZ0Z0NFY1MzVwTUxEM3JEbkl6?=
 =?utf-8?B?TDMrMWR6T2oySE0wVU9taXZJaWNIMzJ5dmYvN3ZXQm5HMnVsRlN0Umd0eGox?=
 =?utf-8?B?Umc2dzUvdEIvVDB2NnlkZkN6REozOVlXWWFsbHcrSEdyZVpIY3E2cFlQeXMy?=
 =?utf-8?B?T0MrcjJSMXhpRHFSMmtXUnRDQVQyVUtoMWt0M2NaTkZMek5Kb3hDaWJJMFBF?=
 =?utf-8?B?T0RsdlA0M2dXeW11cDVRTmpwdmtWMmVGNTJVbXRPYWRpNlBpdU8zbjh5QnZx?=
 =?utf-8?B?czFJVVZrc0ZwcW5WWlFGTXVFeXEvUEFXTjQyQmx4WmJ0NnFLWnZzRWVadTNp?=
 =?utf-8?B?cFBwZFlIRTdQVitOVTFJR2N1cVpLVXo0My9uTXJaQzU3M0ZET3FXTlNzN29B?=
 =?utf-8?B?TVFXT0h6cVh3S3FpcHNEdUZsRE40TGV6RDVlWmNRK29rbGliSGhwUXlYSUFY?=
 =?utf-8?B?ZGpHZXlqSmliM2lrMEo3eXBKcnJEZE8xZ2VocHNoVENUekdEV1gySytGNkEz?=
 =?utf-8?B?UitHeXcvdHMzSXVVdHdUVWxGQlZUVHpCSHdaYStOZ2xkbENQenNrdkhZWDJl?=
 =?utf-8?B?dHliNEFsdzE4bVlFeituTURJYnZOeTdCRmVxdkNZZVB6UWMvejJQL1g3OU0x?=
 =?utf-8?B?ZHY4Y2NQSGl1YUQvV0ZtOWdoRkpjY1hUOThUaHdZK2wxTnI1YVBRUEJqTEN3?=
 =?utf-8?B?b0NqcnJUcitqbXJDeU0zdmc1V3MzUHYzbjNscEtyUW0zMTEzMGZ1R2dSRERD?=
 =?utf-8?B?YU5aNmNKSkpTZHV2OGw3eW8zdEoyN0RjODIxUHV4M1JDN3UrN2NPTGZmOHZM?=
 =?utf-8?B?Wi9SUTFrSC83SFJPSlVMNHFNTzdaeUtuUTBuQURhdjR6UkM2ZkJVNEhmZzRU?=
 =?utf-8?B?ZFh3OUpRclBmbFFYRWhOWWlHd09qaVZpd1h0VkVteFhsNFVra2taTVg4T3FE?=
 =?utf-8?B?b0dORjJiNkhTRllWOHZuL2g5V1dlRVFkWWFWRlNTNE1oUG81d01xN1FueHFa?=
 =?utf-8?B?SUpuVnRHbEE1VjBrSFZodVNERHlDRGRZN3NVcytUQmVwRG1kSzlQSisxSXlk?=
 =?utf-8?B?aTJFMHpuUUtPWkhrVGZmM1NmdDQvUS94SWUwMlMrSmtlYjNLWDNFV0J4WTR4?=
 =?utf-8?B?eVVOWDF4bkZUV2hKdERHeWpGQTF4aHpOQk5QQTB1cEV5R0YrNHFWY0NqRk41?=
 =?utf-8?B?VTdWVVRmQVJjM0xrQlY3RncxQVZ4b0RwZlNWa1RSMGdsK0tUVm9ETjB1dVov?=
 =?utf-8?B?NHgrZDFxSUs2NFZBNCtkb0l0OE9tOEdrUkJOMnZubjhWYmx6OWlsUUFqcFZL?=
 =?utf-8?B?Yy9GQkNJN3FoTlhtMW84RHJFUUhGOHppWTFJNGdaZ3NmTUZ5enRPRUdVODBV?=
 =?utf-8?B?VGlqOVNjSjhjemlnbGFsc0RvOXhGS2tlSWhZUm9LeGJOVVV6N25yaFcrWldp?=
 =?utf-8?B?NWpvRml2dW5aVDdUS3p4eCt2MnQ0K1BucXlTd1hrc1ZUNnlSbzlGM0VGdDMr?=
 =?utf-8?B?b2VhUmlHd05qNVNlTWNlcUprSEF1dnk2UDJvakZFbnN5TWF1a3pHdzNzMTRK?=
 =?utf-8?B?c3V0d2ZUYnU1T3NYZng0QkY5Y3hRMjN3eXBvaDFhb3RycUY0YTd0TmRvRmw1?=
 =?utf-8?B?VkNmRWk4bmlUZUF2czFNL0ZHRXJrRnFhVXVZZnAzTzNiSUt5d2tOQ2t0c2Jp?=
 =?utf-8?B?QmJkVnoyQ1NKU0orVXdyTVM3RkFGM2tJMUYzcmwweFZOZEhmN29MTTYyanRC?=
 =?utf-8?B?YnZianV0a2dMZG4xWi9LNXdFR1JuZjhEcG80NEFydmVieXVqcGhiRWQyZ2NX?=
 =?utf-8?B?bHhNYlZ5U2RKSUwxSy9Jb09NQ04zb3VTOTk0MG9nbCsrckNnTE95TlliSXdY?=
 =?utf-8?B?cHYvcGdvSHVuMkJDcENHb3p5SWsyYS9nNko3eHhmYU83MDQvRXBBdGNTRU5n?=
 =?utf-8?B?cVVwT0pWc084OExvNElDVDBGcTduYThFdi85UFIwWWc3VFhUeE5tTVYrMEg1?=
 =?utf-8?B?QkIydzZKTzNLTGtYNjgvR0luWk9nWjk2NVorRFVVdjFSR1NVSm9TWVhLZ3Ja?=
 =?utf-8?B?ZWlVaWRPS29mclBNTVNZeHBTY1RwUnRTOUhTcnVxK2w1L3pFYTFXVmlZQmlj?=
 =?utf-8?B?NnpmNXhMY2VhV0FPU2pjaHp1Ti80NUxWVUQrZkNJbHF6OHh6Ky9XWWRqc1Vl?=
 =?utf-8?B?TUVlRjVvMWEwY05GL0toQ3FCOFd5QTJSTTlaekhsb0J3Z0N3TktPcldnRkNr?=
 =?utf-8?B?OGE0aktpaWJPb3JMcHdURVpLYVozLzZJeWs2b0ViNUJhQzdWVEhXQT09?=
X-Exchange-RoutingPolicyChecked:
	U7EyT1CSzEYKiyWWpUzhJMrUf9d4AgcDvnHKkoljo3jUlxq0Rt1LIY/Wcr/I6czrYVaKZs6oNv5RQeLU4TMsa6QB2smpdKR8a58o/moC+j/loHOL4RtNC9ZubPSNf3mlj6XbjLJ0q7IVOl78etLVta3jvfwaeLW76ZNkyxMCT/413i8wg8mQq+6jILQ/wC7+BeRVO3H5pGzGuLjrdd7Mg+unCMfgEOGHIX3++jSodlybbhrj0X5yEAK2jwBxgyssNN5BBsdCWWopu/A1aPmpY+oNZ/1nYBCCiAGJSOFCre2yFiZAfukQtfnllKr8NfmATZVo12FFEmamHo7A4xbhrw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1+qgZ3S3FOE9afDcBITTghuPdgEGjIX7YO7BS1AlKj0mr3PUcn97DIhblixM7kaBrli6bHakLCkoPXpKn3CWUCeEvSC1TB99IFm/w7hPQb+e8Ai8vUttNdcHXUwtrNpvsbgg0yhceGruguisuwEEeKEVfHh9CJheAJoDzOvdl0fGa6swP60V6lewgYvZNDt7RnzTG/zJejsv1EoFRmWHA9jMn6B5R4XYfIE8ycFh4U/NIF5bsKcqGQUA0GUPVrJZKkV4KA0d/X7rHUCbZPJ9KIdrailuR6TgBxrxT8tNJ5WcMdkanO3P///sffUWAk1LsIRpL+wjnFqT/3i/1pYX2QfYMk/ZcPdWEg5/h+uHxjczd4Nrq4QaxKSzn7xB16aqWSlNiOOCx3u2qjs2IgvhXomfyLJJaP7n8OJT92nhtn0aJ5JVbP1BcH+RLjyOIpmtH6+eH+P6D0lTqVkrvZoxHWcGN0ruYODb8XCuCAqytK42qvkhhM8+Cqo+/mduLwXQ1ANOuGPHeWg4YYr80jyWJKDr6gwyrA1QOZcxhNAMFSJjOR0gbWqUk2yoIRb1AfjHe0nWq6c4dPRG3qp1lH1vJfq6q/JtOH+COvh+bQnBx62cdScF21du6cDt0BxilS5
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec3cb6d-a1ca-4bfc-8a09-08de80375187
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 13:00:21.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axl5vx2DACpERK2M2usWSjNJjd4IPGZQMhntPbVCvhvTVJa61EeA6citPkSgIt8mxckbrw0oU71/b0oyY6lhsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2104
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: PAWP192MB2104.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: TjUvJ08f8FhvqnqeivS5z4R2aPUqLw_3
X-Proofpoint-ORIG-GUID: TjUvJ08f8FhvqnqeivS5z4R2aPUqLw_3
X-Authority-Analysis: v=2.4 cv=MIhtWcZl c=1 sm=1 tr=0 ts=69b2b8e9 cx=c_pps
 a=aCSaCga/D6ZaJx/7+0lQYw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=td9N8bAwm-SjQ8GX2McA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEwMyBTYWx0ZWRfX/BYj0uG0OtVo
 SpWfbeeKm5SznXsY0JfXvGISxLPgfkMZY6z316kywN0ELBk9tIyiYpy98RGHFnD5ciK3MP/8JKN
 4Fgh0E9I9IOHQC2HHECGBAQ3unHyDRjPsll3/k2hdOY2wGtA3BWSE+IsCHE1fuKTi1je3KK69iA
 DoZvH4NDs/ilZG8DijTILgrhU1jysZ0wUcy0oBhC+opNabDdqWg3UX2eJtVyYjjMKmN8+Rk2BX+
 uHkMAgE7RN7yVeczmn+s+DYxhtO03UWeeCbzTH4yWGLPwzbHoac0VCBtiV/5KnBoIHvo+SUaPLN
 p6ZuZL5uVbF/IulFeWj3gIkMup81jaMHqP8zq2hdK2CD8mcqGPfDxcGftr8LcBH+PRTg/f/tdFe
 BRUeFuQk7N9w8zdRZvPpejQKZ6xGS8IR9axDLwJQ9BKLjgO/ttplB71t8GVRqLFrFOn981AB7A5
 eGrfbeVv+gwJSyH632w==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33104-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A69CD2722D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 01:10:21PM +0100, Johannes Berg wrote:
> Wait ...
> 
> > > I don’t see this in the function. For example, the MAC capabilities are a
> > > `u16 *` in CPU endianness, which is simply memcpy’d from the parsed
> > > `NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC`. Later, they are treated as `u16 *`,
> > > as shown in the following code:
> > > 
> > >     printf("%s\t\tHE MAC Capabilities (0x", pre);
> > >     for (i = 0; i < 3; i++)
> > >         printf("%04x", mac_cap[i]);
> > >     printf("):\n");
> 
> That's incorrect for sure. But iw code now actually reads
> 
>         printf("%s\t\tHE MAC Capabilities (0x", pre);
>         for (i = 0; i < 3; i++)
>                 printf("%04x", le16toh(mac_cap[i]));
>         printf("):\n");
> 
> 
> which is correct. HE PHY capabilities are printed as
> 
>         printf("%s\t\tHE PHY Capabilities: (0x", pre);
>         for (i = 0; i < 11; i++)
>                 printf("%02x", ((__u8 *)phy_cap)[i + 1]);
> 
> in my version of the code, and it seems to me the +1 is incorrect either
> way?
> 
> >         printf("%s\t\tEHT MAC Capabilities (0x", pre);
> >         for (i = 0; i < 2; i++)
> >                 printf("%02x", mac_cap[i]);
> 
> This was also correct, not incorrect as I stated, since mac_cap is u8 *,
> and EHT PHY capabilities are cast to u8 * first.
> 
> Maybe your iw is just really old?

Sorry, my fault. I'm using `OpenWrt v24.10.5` with `iw` version 6.9. The
latest master has the `le16toh` implemented. With my `ath12k` fix the PHY
capabilities and the respecitve descriptions are fine now. But I still
cannot get MAC capabilities correct. I'll analyze it further.


Best regards
Alexander wilhelm

