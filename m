Return-Path: <linux-wireless+bounces-31575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOGiC2w9hGkC1wMAu9opvQ
	(envelope-from <linux-wireless+bounces-31575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 07:49:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A233BEF182
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1324F3005586
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D41B532F;
	Thu,  5 Feb 2026 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gA1JKZEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61B42AA9;
	Thu,  5 Feb 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274152; cv=fail; b=E9n1+NpPP0sqZfxJTS6UPRzdYvfEVOjEd/LyTMfkzp6QJUjLrtZGb5Hmc/CCseBD0oTiW9tFcYJB48yaJYhwTYRqN1bWV3sQVbaO77fKSfNMgj08h6BmCB462R+ZQf+1m7ReX7kK8/KjiRiyo/W5czwQQxOwwl4kmF9a+GfWj2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274152; c=relaxed/simple;
	bh=N5gEpPVckGMhXaCWV+iHYQBhK5EZezNhZoJZwqUw98M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GcmNnk3bwCE1VymX+FmxMSBUKeeDmMi8GKObetdyNK0cxuQzcYAmowQMvZ2JCEY5jxX2zGXQOegTA6Cy9eJFqum+QWLIPb8Ganw6sKQ4x6fgPiSgcy0ayVYwYtneklhnnMSG6A9B2g+cAu8t7GxqY21/9bijfnG5TppxdhPDIXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gA1JKZEt; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak6tt/805/s3BDuntvw2DTfOQqVrts2GpGv5FnD07nidXRh1fzeAU2Q55FLwukIHxQGmftM1/pgn8cd6PmpcoJZjiAFslwGh8GOpEd+yjH+IVgs25f18ywScj6mZJOFqqqEShMZwN9rZzBQYYi/g8t+yIT62K5QR/rN0Imecj6tmOh19QAg+S4B4eiDL5GEjA4mM2tfbMlfVOkpDmVPsoUR45wF1hfDo/jNv2OsHIK7Gi69Twv5vHR8VLt3A+KheTLTAjlkcTf6yzjSVdnGhfydc5RzA7VgmU7CJiP72PUSj0VfhkjGIOcR4GMPyNhIcjnz8RO9xfQ2dASwm6P9xXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6067XduGDXs/bmyZQb5br3GR1CO+QqUk9yr7P484MrQ=;
 b=RM1tcgCQxKDOffxGsWjqqRQXwgWmBq7XYH6ec/WcdB0FMocxbXst4kgbLjhMbKEqTFyJehinIeF5uuY9Pt+r+OdZFXJq8TOewwYErsgfyOfENXb+koZbhiitOxyBbGgt1L47DbU4vMDWXN7FYFDmtAs8jI4umb7Kjj9M4vgrQhA2AsTNlGP/j9U+BrsNsOurMl5Hrm3pMxeKtXcVaS6YS34v437Mg6tsFFwQK37E/XJ7fwsX7QRWnNdJ6hgioPqUHX9FB7FNhDUCncuom7UPnTlghWwu2unngHFNPpQeprpZO2zAZ+0i55w5dI5m2FsHwci4c4lYfkN+KbYs8OTe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6067XduGDXs/bmyZQb5br3GR1CO+QqUk9yr7P484MrQ=;
 b=gA1JKZEtnoAS/m49YfKso2Ax6ynOVe46SiYmO+I0ok7iLQLzXD5oEWGtwXbbusMsEt76OXG3aXU6Nq3T/bmL+TVTmej/aufj9VGx8inPVZBYspdiASgn9z4/AM9gmICnzPnaOz4qdy26avLP/Npr4VB/EK31Bd7hmk9ytbVoE/RZTUyVxmvFUoO4P2sEYfCJaIfnX5E8amXvx51M1aSZCjvApUp+iJkof7hrpHd0/RWRKb+kOnugxTkMmUeOSPut6qUUFAQYtwFjTRAAi6Hno0kyXmbTSOVJoGgK+YDnjaeUxtSYTYDZYV4wnv0k7j7e9kT5FJ3ApdqNLfK6rqI5lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:49:05 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 06:49:04 +0000
Date: Thu, 5 Feb 2026 14:48:03 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v9 00/21] wifi: nxpwifi: create nxpwifi to support
Message-ID: <aYQ8EbSbln3bN9n+@nxpwireless-Inspiron-14-Plus-7440>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
 <3eaf27a486a80012b0be116e847f2e93f162aa1e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eaf27a486a80012b0be116e847f2e93f162aa1e.camel@sipsolutions.net>
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AM8PR04MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d5b227-c90d-41cc-108a-08de6482a71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak5CTm52QmVLMTk4MmpTMTg3NkhOQUorS1MvOVJ6RTVwVTR0Y1B0SDFJbys1?=
 =?utf-8?B?c3ZTMEg5Rk1GVFZkdjRwTDg5a3lJYkR5TVlMWnVxRkRmSkRvV3VPWWFhTjE2?=
 =?utf-8?B?b0lNRGNWUnhiM2tyUld2VTQxN21lT1Ird2phVlg1cnhNVWZpbHFWd0RNcFdH?=
 =?utf-8?B?S0xML3hLNUJSbGloUEZCazhQVmxVVUp4NnVGMEgyU0dER0VPb0xhb1hneldP?=
 =?utf-8?B?WkQ1YUY5RDBKMDhQbWRaUExzSUJDRXROVzl6TjYrM1ZYLzZJelp0bVlvYXlI?=
 =?utf-8?B?UWZGM0l3bXlhY3Z5S2tScFJMYk53SDV5VFJIWmNuN3p1UW8rb2JHTVhyaTRt?=
 =?utf-8?B?akNHeTRmSWdyT21KeFBsNlJtTWs1d3VJSTZIdDU4bmRkNHBEL2R3Z0lzZEEr?=
 =?utf-8?B?Ui9OZ0Z4VWYxSHJZR0I4M2xickhnWDB2dU50Si9iSnU3dnJ1QW5ZNlNVNVY4?=
 =?utf-8?B?d0kxM2l4UGJlQVlVV25aZU1XVC9aRjJsY1d1R2VIL282bFN3a3R5dVFmWUhh?=
 =?utf-8?B?RVltZkpOOTRMWnR6QjA3d3VoajVEWUdYWDdjWDBvVENaMjF5Q0lIWitLcGdQ?=
 =?utf-8?B?YUpUbmF6WHM1aWtkV2crK1laOHR4cXFmekJySk5VNjI1SmE5YkdxVHI0ZHVu?=
 =?utf-8?B?WlFCZTQzcitldnZSZFcxUU56YlFGdWo0eTdDVEJ1ZU1qMVAyUCtaMUlTYk45?=
 =?utf-8?B?c284eE90enREM2k5WG9SNzhGT3RBUjdzVVZobGhUbTRNU2tQODdlMFNrZEt3?=
 =?utf-8?B?Q3o3eFFSR3VqeUR6S2ZhYUZuV0E3QTZGdExOOVpsZE5GUGcwU25udXhWN0h5?=
 =?utf-8?B?WmpJQklHT3lUZ0dTUzlFeExRTWY4aktML1pkVEZjbWNCK21qS204UVludVI2?=
 =?utf-8?B?SkNiWUFQTThBSnBnRHM2MndEa2hrOFFVVWJWQ0xGQUFlWU9KUEVOaGtNMlZz?=
 =?utf-8?B?N1ZEZmkraERvTlBLUDRmZEJ0K1F2aGcxaE95d0JHR1ByL0NzMEdrTExWUCt3?=
 =?utf-8?B?VG9zdzVuMTVPVHhmSUhBNGZPQnExV0J2SHM1aW1KWVZQY2J2MTVrcW9lbDhS?=
 =?utf-8?B?elk3WnFndGhjNXk4TDJrSXNUU3diL3JNdk1yR0tURlRlZ09OajdSSTdJL2tE?=
 =?utf-8?B?eTRZaEdEL2FOVStnbU9kOXNYK3FiTW01YkpmbTFOZHdTQ3RmNG5ENVN1eFVP?=
 =?utf-8?B?QjBwL0lIWWExMHNBRTNsWG12b3RUSTM4a1VWWXFsdkNmd2h2S2Y1d1Q2RndQ?=
 =?utf-8?B?TjltdVBxbVdyUDBzNzdwU2dicXJiL3F2V2ZlMG8xb2Q0Uy9BalQxV1RwanNU?=
 =?utf-8?B?QWw3TVk4UDVVNExyUGwxR24zRzBjUnJuR2ZwM0lLRVd0WFhrNVM0QUFYcTI0?=
 =?utf-8?B?WFVmZ2trZjhOK1hiaUhwbnhiN24reC9SeERMWFpYeG92RmNheTROckYwaWpT?=
 =?utf-8?B?Q2ZhYmUyYit2anFJNXJVb1lkN2NZQ1RMN0szN3paTGp5SXFRT0N1V3JrMHJC?=
 =?utf-8?B?L0dnSTdZb2cyTm5rd0docS9FYWwzUjRQdmZKZU5zKzh1L3ZiNzhRdml4aHRC?=
 =?utf-8?B?cXlvVHNuNHZsQmRTejdSbkNWTlNuZGZmT3crdlZKVGNpVnp3LzY0bUNQMExD?=
 =?utf-8?B?bVJPempGMUx0QnNZLzBuNDZrMldlMVprUnQ5SU5ZTTI5QlhGd3pYS0poSEhM?=
 =?utf-8?B?K0NXa3pNUzZlTUJESkkwRm5sc0EySWVudWJWa2Y4aS9FUmEwelB0N0QrVWNj?=
 =?utf-8?B?ZitWRDd1ZlJLN3JkUWZWQTZCRk43U3JvT045bGpzNkdCb0V3QXpIYURVTTQr?=
 =?utf-8?B?eGxYeFp6R1J2V0QwRHpKY1lpMmVmaXNjNXRvckNPRHd4OEhJUjRLNmxST2ZQ?=
 =?utf-8?B?OXdoWDRESXFqZlhPdmxCWE9WZEwxV1ZtTkVKQXJaY3ZHRVFFaDZvZytYbFVW?=
 =?utf-8?B?Y25LV0x0N2pSZ0o2TXJ1Vmc4MHJDZW9ucFVldFUvVjBPT1VGSmRKbWFURThP?=
 =?utf-8?B?Q29xUmMxT0liTDdRWkdqKzVMSDM2SWpLTnNKeklCckZObmdRZS9FRndPa2hp?=
 =?utf-8?B?Skp5aEw2SkxYSlBaNmZMNytoWnBuY0ZnNWFSZk9VRG5JM1N4eHFaalhneFIr?=
 =?utf-8?B?YXpxOFQ3OXRjWlNzdEx5dmI2WXNjRlZTdGYzdG5VUm8vQUxLTWlRejN3OEFr?=
 =?utf-8?Q?RmIpCa4So/Ij6NWYHLUyv40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T04xTWxDbVNndDRiRlgwc2I1RXVra3UvMkhXQ1NBTUVVSEFiMmtORHF1MndC?=
 =?utf-8?B?TkNnOGFVZGF5ZWI4dTltUVRqTWw5S25RRkE5a2YrTFJ4Vjh4amVSanFtMEkv?=
 =?utf-8?B?TlltNko4eEJPTGptbVdoQUdUSk1ZMklZbEVPSzNkVklXdDhJRlcwSXlYeTJD?=
 =?utf-8?B?WXBVVTlTN3ZQaDBqQUREalZ4S0E5dVBWZ3JTenQ2K0RmVTc2MU9ucFIzNnVJ?=
 =?utf-8?B?a3I5empSRGVHVmtwT2IwRmRMaXdnZmFma1dYclM3T3FveHNPSzhHc2xQRzdQ?=
 =?utf-8?B?bXhRLzl0VHg3Q2diSUdRQzFTVmI2M2l5MWtqcVFiTmdPb0N3Y0lVakd4VS9a?=
 =?utf-8?B?M241aVJGelNBQnFvMEpwczdaWkFYMXVJV2VVU1BYRVNleDF1ZittRXdYTFVl?=
 =?utf-8?B?R09GQlZyQ3dDNDNxdzE0b0l5S2F3NXppeWtiNGhETTZOU2poUkhSU08xeDVX?=
 =?utf-8?B?OU53QllMTDR2OEJhQ2ZDaVFpZlJXeHNPOEsyNVBWdUFFRmdqS1NjY21vTGw2?=
 =?utf-8?B?YTB5bTlhVWs1Qk05SGZFMGk3Um5HMHYvNlhZc05QVjd4RW14SUdGNm5TaEZn?=
 =?utf-8?B?bWV2WDY3TUJWbHRrbGxCbDNXYjUxU1NJZk90T205azhXNFppWTQ0ZzBDNGt1?=
 =?utf-8?B?ODNuOUYzMGE0L0Y3UXpvRCtxbWFRL3JEU1l4TmJKQVVzempzSFQ0eVlvelNQ?=
 =?utf-8?B?UGIyWllMdWduSUJhT3ZpdndYdVVqbk9tL0hDWHJzRm1ZcEVBS0FMZzUyTGVZ?=
 =?utf-8?B?UW9WOUREektBOUE5anFTOTZUcUd3aHdibnFsVFg0K2g4VnF6MVJOellUMHVB?=
 =?utf-8?B?Q28wVmFBMk53K0grS05vempLeUdGWHBHcUNBNkVMOU5qUHZTZ0x1OTRaN3J5?=
 =?utf-8?B?Z3NFa1FPZjA5WHcrbVRiMDZVNEtVME95Y2NpaUQrN0pweXk2ZGxudE9rNUdj?=
 =?utf-8?B?Z0VUT3RWVzZSd0ZMOXQyb0l2RlJHK20vcWhRaHJoZldKMDNKaXpGMThGTzhx?=
 =?utf-8?B?Y2dMVXNGSDFEdm1zcW1PbE13SStUUHFCdXh4a1NxTmRFRlFQWTN1Tlh0c3V3?=
 =?utf-8?B?RCt5a0dSMlhzd3djTWFlR0VhK1lLTHVBcktDVktRQXp1Y3c3NkYrWEdZVU5B?=
 =?utf-8?B?ajBVR25aMFdGYjluOTFKblQvejJLaldxdDg5aWxxeDV4YUh1TytLcEk1VlVT?=
 =?utf-8?B?SXJpU0FxZVhUMnFkWVM2ZkhwdGhKS21yMXdtRUp3SWh0dTlxQXpscjdqM3dO?=
 =?utf-8?B?VzZGR3NrdVQvalZWT1FLUjZQSUtSMld5ZHdyem5UY01GU1FNZkpwNktPRnhv?=
 =?utf-8?B?Z1d1bGFocGdrMTdZcjVvMnI1S1BOaWhJc3krVldlaFMyZlRLK0lmV2p4T2kv?=
 =?utf-8?B?djZXZUZTa3VqUWhyR1hldUkwcWRNNHNNYnlCWjJGV0NFN0I5YVNTVkpBWTNO?=
 =?utf-8?B?ak1qWTlTZ2RUNzM2UElmbkFmMWtjWWdxRnorNExQdDVrNUEvUlMzTWxwMUMx?=
 =?utf-8?B?azVwYXNxT3NiKzVEQmNGalViWVhqejFubkNuL3VqUHJEYW1UZnpkbURaL2xu?=
 =?utf-8?B?a0ZNaVA4bUpuVnhMY1NJMFM5c2MwWXYranlhSnlLTW0wbWFNUmRTL0RRQVlx?=
 =?utf-8?B?dEZSQmtNaktlaTV4S0cyYkNuenc3d1hpVURaYXh5eVgzVGVLL3pPUTZZMGIw?=
 =?utf-8?B?M1JxeHUrRGFXdkZKYUxSOTc4R1ZpQUl1K3JUTTJWc0d6SnZMbnZ1MlprejBJ?=
 =?utf-8?B?QUN0QXA1YlYxTC9UUlNza2hOc1U0OHA3d0RDMGdZeEZ0K2JnaG5qT1pxWUlJ?=
 =?utf-8?B?djI5ZlNWWXE5STdDSWNOSU9QSWtBeE9pTUl4QTlNQUhQWFJlRlZ2Q3VKb2Rq?=
 =?utf-8?B?NGtDWmFhY3FhUHpDQ3JJSnhVd01MYUt1cXJpNStoWVdFenlhaCttMWRRRDBr?=
 =?utf-8?B?ME9hUnZaTk5QZnpZNmZoU0ZaVjBUazU0T1FyVmppZFFjUG15VExQWDZtM3Av?=
 =?utf-8?B?Q3drajFjclg2S1JkdUlNemtJWUZXOWIwaGp4UndmVHBxSklhbGpXSnBORWE0?=
 =?utf-8?B?R2pMeVRKaFAzamFYRytia2kyQ3dFZDA4WXhkSnYyclpNVzI0eVR5bnJzL0Rt?=
 =?utf-8?B?SVY1d3ZDNEVnQzBBYkVINlVqVE1zdUsxR3ZRRzdtdU1PWWVlTXRWb0J0cWNi?=
 =?utf-8?B?L2h4QVZmMytDd3VmWmorY2RuajFXc2drcjNtK1MyR0NIZFBDamFJencrTTA2?=
 =?utf-8?B?cXJNcUpqb3ZIL1R5YnRJaktTQWdHTkFpN25wZmN2aXljZlBSelRSZlV4UHNj?=
 =?utf-8?B?M1hER0Z6a0d3cHBSNlpoa3lMK2l3VnZyakM2ZlFqUUtCNUFCY2tGUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d5b227-c90d-41cc-108a-08de6482a71e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:49:04.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkjw1Kaix7sMhVjRtdKxtQ1Cbh7ohV5cR7umZqHLyRaxXusj3adrzEFrtHt5Ibh3cLgi+dc6TtNVm/0AXTLdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31575-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim]
X-Rspamd-Queue-Id: A233BEF182
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:09:25 PM +0100, Johannes Berg wrote:
> > 
> >     Devicetree bindings note
> >     ------------------------
> > 
> >     The previous version included a devicetree binding document for
> >     `nxp,iw61x.yaml`. Since Device Tree support for this device is optional
> >     and not required for current SDIO-based bring-up, the binding has been
> >     dropped from this series. A proper schema will be submitted separately
> >     once DT usage becomes relevant, so that binding review can be handled
> >     in the correct subsystem and without blocking this driver introduction.
> 
> You should probably have dropped _all_ the DT/OF *code* as well,
> otherwise what's the point of dropping the binding review when you still
> bake the binding into the code, no?
> 
> johannes
> 

Hi Johannes,

Thanks for the question. To clarify what changed in v9:

I dropped only the DT binding YAML from this wireless-only series because
bindings are reviewed by the Devicetree subsystem. The driver keeps minimal
and optional OF handling, but SDIO bring-up does not depend on any DT
properties — enumeration is via SDIO VID/PID and the driver works without a
binding.

The plan is to submit the binding YAML (and any DT properties we actually need,
e.g. OOB wake IRQ/regulators) as a separate patchset to the DT maintainers so
review happens in the right subsystem without blocking the wireless review.

jeff

