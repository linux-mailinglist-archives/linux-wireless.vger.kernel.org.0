Return-Path: <linux-wireless+bounces-31739-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNUDMnSGjGmfqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31739-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:39:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EC124D78
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E8F730011AC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24AC253932;
	Wed, 11 Feb 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZPY9pAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F7283C93;
	Wed, 11 Feb 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817134; cv=fail; b=LNCiuYhSCZ3FZCFRpRxVbL9igd6w2TqpwKfZp2DXJAybT6goLw1ziznfXdWsgYDoZXAhtSk4naev0UkSAFvx3h1MR+SfFRbxEmas/NO11/XhUamw1PKW0Vmjq5k0E/rvsHQ5K1H/9qJg+T7OpQDnA5TeYUPDSeUyr2aq6kJyTG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817134; c=relaxed/simple;
	bh=nOgUVmcSR6HwRFuTR6/aMZsytzhiFc5Rjsc2jsX51PM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hWzr2sxPx75Nu+NWmtXYaH7WZoVF7qc94YJ1WVRhK92pibU1WeEGfyq6jdlkLTbG2ywE5Y08HITdCTrPL2+SuzJATke1UshR9r49/l0VIXsLhkLgx3g0pVnQIF4MldKuBG+D1jVRiHQktNoMMH/AefbPcMI3CRu+Ai4EfEkuuRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZPY9pAy; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naSRo6dLnAqbmtHdHAf+hOW3qFbdj5TtIadbv1BSclq8A/C7fdcZbgbT7tbOW33G84xHIW51qHvosFK+p2fXr3wGW8FSI+cemEdl2UM4RpGKBCvgesaKvyNrlj2OUGmoMhwinvkV+bXrbKsGNOM14GRf0XQswLtjq5ExWnOEWdPWfGFMIrZITJ8VkVW0vTxqb92XGIIvN6o1XAwPn1Dg8p9WVTtzD34gbF+vsIEID/14Nqm1IHBxyYabdYbNNSTdSKU2hoJCmLDscwT0GgY+zswaX0xrrV92esTJHZ+4IlAGb6+V4Dr3oDv2PTCBhHZOdCv77c6xKbp2aQAvgCdO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRZnVgczyM47gu9knwoaikL8gs0LnT0rTDiMvZgmGC8=;
 b=NxSNh1oDnCSpgrPtSmIPZwwyFNISk05KtwLfkxlG01XG7sNww596TeJDiZsv40HFX0qiEvZrJMz8kFHLF5jJK3RaL3zLBZ+C4mYn3rc9x/Ti9l3O04bu2S3HU2aDNG6tB/ZJ/qjdHvG/MCKOpxQ7fcqT/cUEpZBvv0VBLJg5QVaivGGSXYF5yzBAj67wpoVgb+eyfScrHJrBJ8OnD+XuPC8maOjSqeP/pzaL5n1kEiACwan0l7bqBmlOleVaTcAmKMRgJHUMQVPeMRwjO0zba2s8Aftx+wRa9MTD8Ad98LMThdE2IYO1AuCv/ERmuBEcXv3A8NNd7pVgLUmzHBSVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRZnVgczyM47gu9knwoaikL8gs0LnT0rTDiMvZgmGC8=;
 b=mZPY9pAy3/ImvwJ9AL+XQtzjJ/Hfeb+T6w8jQ8KR6TNoSF8+jWUif9TTLicL3vtCt2MGLFnKx4npb/xPcINHoounIFD3molF+nzVJann5VdCscJ8yrL+6d3XPIQM8wXbgc3TdbcCHr+ncjc78o1j+lkcohw3UqgwIaJbAF1/1JPCfQUg6nRDt5PnMptWrIovwGWcAcN5ahVS5Hu1i0N0+HDuq74717iRsYk8WY+76Va0MSGmpsGJ92DYzZEPxMYb9Z5YLRLIxx3HHZVKTjFLA6ji0v1ZmJg4Rnhx6Na3apG2I0StM+l788vXBhjFvQ/cCx7wsuo6Wh1iTOSn7f684w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:38:51 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 13:38:50 +0000
From: jeff.chen_1@nxp.com
Date: Wed, 11 Feb 2026 21:37:40 +0800
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v9 00/21] wifi: nxpwifi: create nxpwifi to support
Message-ID: <aYyGJIupDvBZM8LK@nxpwireless-Inspiron-14-Plus-7440>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
 <3eaf27a486a80012b0be116e847f2e93f162aa1e.camel@sipsolutions.net>
 <aYQ8EbSbln3bN9n+@nxpwireless-Inspiron-14-Plus-7440>
 <b1d9bc37-6078-4240-8b06-cfdc435eadd0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d9bc37-6078-4240-8b06-cfdc435eadd0@kernel.org>
eFrom: Jeff Chen <jeff.chen_1@nxp.com>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3f730a-f9db-4a51-e94c-08de6972e40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZVam1FSGhNcTlzYThKekhldC9ldWNQdHFTOCtNa0p1MVdKVXE0SFkwWlhQ?=
 =?utf-8?B?Y0EyNkZ0SE5Ya2FjQzl5MVlIa3V4MVI5cFk5dVlZM1J3WjJyVlNTSnpNdytZ?=
 =?utf-8?B?WDVXbGw3KzRsVXRBTS9FTDlYa2lhRkZiSTJOTnNOaFp6RFVJQTh1dFk4aVI3?=
 =?utf-8?B?QU1KV2loNFNqeG9SZGFQcHZ3MWZ4SmJ5R3FMVVhJN0tUN1o5ZHVUdXNZMURP?=
 =?utf-8?B?cENidThpYXlwMkFoSmNSbWcydCtxLzZ5RytieHNTcjdGaWl5K0J5dDFPdUI2?=
 =?utf-8?B?c1pHQ0s3MGdYcG1ubDFrNDdHcVVOOE5OUGVYaXowelBrVDdsUHZqaGw4WHpR?=
 =?utf-8?B?Y2lkY2VWd2F1c0pxTlFXckdkbjRqNXhaMUlMSzB5U2g0QnloN3JyeU1wKzli?=
 =?utf-8?B?cEpSZk13aEp3eCs2K213Tzh6RVpIejJBVU9jUnZJdGJSNUQrNk9NRUlCUC8v?=
 =?utf-8?B?d3ZNc0E3NG9JaCs2YThidUtOMjBXYW1KUmdobXFvYnM3T3R1bFRLTkE5WlFs?=
 =?utf-8?B?R24rb2xGS04wNUkzcm1OVGNMTnF3a2lMYXRRNC8xQkNrK0xnL1NHRWtPUlQ4?=
 =?utf-8?B?R2tpTlFJc0tTUkVHSWlEc3lONWl6YmFrUXYrd0wyaXYwRDltUWVlV3A4Mndk?=
 =?utf-8?B?eVhmVjZ4ZFZRWHlMRldvNFBQRmZnTWY2SWwyYWdrUlBqSFp6eVJ6K2d4RE5z?=
 =?utf-8?B?TzI5WmMxaFBCZ1ZKWHQxbjdqWDZEckhWaEdJVDBFdkpFUVVKSHA5cEgvd0NW?=
 =?utf-8?B?TmJRVTNsU29hQ1FObzJFWHpUV2tIZDdLbWlmZDNUVXlOYzFCOUN1T3VIcEVV?=
 =?utf-8?B?SUdPOVQ3d3pzNW5HemxmVzFHUEtVM2pTRHhyY1JMbFRSOWNzSkZqTENEamIr?=
 =?utf-8?B?UHNFOWxDM0xJWk04bzRDZUZmNG80eC9EOEVKZFBvS3FDWDlxSWJRRHk1U2RM?=
 =?utf-8?B?ajJENjZFUTM0VUUrQldrRWNWQUVxaG56VUdTQ25NOHVJUDg1MWNyS3VXNmU1?=
 =?utf-8?B?MHRYYzA4ak9QSlFIVnhyRk5lZ0xUWG5mTHZlYnROaC92SXZsN1J6cy95VnJD?=
 =?utf-8?B?aTBaaGpydjdmY0toZUJrY2FmSGhwaWJPaE5RckptWGpicXhTL0s5bTFRUmxW?=
 =?utf-8?B?b2lDdkczR29YVnRNWHdpcG5IcndkNVpVUmd3UDVBT2FHUlRhbGZRL09nbXpG?=
 =?utf-8?B?RFRrV3JTbHE3bjNDUVZmK0d1QmtqUlVsWEpjaTNrRVZoeWJFZS9KYURCMHVS?=
 =?utf-8?B?WkJRb1BybHlzR3FUUkFEZFhCeWdmb2d5akxqQUc3eFNyaG1RenFFNVNacnMw?=
 =?utf-8?B?NFZXMkQrUHRwZk9nUjhOYkovUWFLK290V1VTOUQwZ1pBbkFvY0FHWkhqaEZk?=
 =?utf-8?B?Uy9SMjRvdVoyU2tLY05wdkNiYjVXbUpydEpqdm10Rlp3R2VNTHVxQ1ZmZENS?=
 =?utf-8?B?ZzZWa0ZhVTZFbTVIZ1gwaVV5NTNXYlBZTzR1aWdvUENhdENPZTdiYk5BaGlD?=
 =?utf-8?B?TW5Dc0E1elNLM01mTDM4bWNjc2R6TVpET3VEaU5zVGxrVDQ3RXB6YnErOXlk?=
 =?utf-8?B?TmdjQno2WCtERXRncnk4a1dHcnpBdWRTbG1SczAwWThDUFlOR0d4UTJwdzRE?=
 =?utf-8?B?UWdsa29tcGVVQlVzZGlCMnlNTTVDRUxJSG9QejE3em5Ha3pDbEUyS0h4azJx?=
 =?utf-8?B?bUVta28zb0NwdVB1MWhTTWJtQ1ZPUDBtaHFOdnlKUGhwN2tLalpkei80MzlP?=
 =?utf-8?B?aHI3Z0FBa2JJalRjamlBaEFYTEZkQjRxcVREc1EvYmlkd0F0b3F0WGJKNGd2?=
 =?utf-8?B?WjZkNmZvdFNBODFZT0l1d0F0d0xvOFRPNkNXemliSXN0NU9MZlJOWWw4QkEv?=
 =?utf-8?B?N3RIZm1vdEVyRzBsZGNuVkFrY0RjblhsTVJQcEJtQk5pQXRNcmlrK2RhRjhC?=
 =?utf-8?B?Y2dwTlJGSDVsSVRKT1FxRXYzZDMzOTY0VnQ5ZzRGQUtPNk40M0ROdDg4bkpM?=
 =?utf-8?B?TDJjelpWdGFiMk9zUUZob3RabWNQYmZMblZ6L2paNGdUM1Z6WlhVWndwaXlK?=
 =?utf-8?B?Yzh5NFAzZnlVbnE0azBCcCt6NkV0enhSMkRwYW0xNWYwZkVmMmtOcTBHaVNC?=
 =?utf-8?B?UGJaMlN5Wm02RnZjTDRsY3Bybis5RS9oSVZyMk1XSm40S01kMGZ4WkJQRXBM?=
 =?utf-8?B?dVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0tvVzRRSDI5THBqeTF2aG13ajNWNmRTNFNkNEtFajBVcDZaajV4UExxSXNz?=
 =?utf-8?B?MnhwVnZkQlFUWEZIVGJIbVJBWWd3ZXpoa1ZDZ0RwOGtqcHdXSXpGaEhXamNG?=
 =?utf-8?B?VW4xSUxxZUdEL3dad0grYzRJQnRaN2Y4dlpndkpOTzBvWTFaaDF2WkJaS2F2?=
 =?utf-8?B?Mmlxd1pFWHdUdXRZRk4wM2w2UWFaUUNPa0V1dlVyOWJ0SC8zemhCdDN0aVhJ?=
 =?utf-8?B?WWpBMHZlKzJyY1hCLytHbjBNOWU3NVBxM2ZGeGkyMGNUaU5LdndjUStwaTBY?=
 =?utf-8?B?L1lwanBPRG53VXYraHdYNWk4TTU0YUxQWC9UMHJwWmZReWN1K0oydi9WdnV4?=
 =?utf-8?B?MlpUaEoxOE1DYk1BTFhJWFRBTnE3eHVkVkJOOW9wV0h2U3VJQ0I5Nm8xdXZK?=
 =?utf-8?B?UVpmR3lrZEZZWGl5aytzRW8xU3ZQZThNK3NNMVAwOFBIOGdnOGNwR1I1Nldj?=
 =?utf-8?B?dmEyMjc1YldPcHdIY1ZWcDk1TUhkZS8rODljR0hTbDJyUC80QVcxNjBidW1T?=
 =?utf-8?B?aCtWNjdwazZkOUJBVjhsdGZpQTlHcXBnWkwwcitaTnR6Ty91eHZWVHJkd25K?=
 =?utf-8?B?Mmh5WDFaTDEwQThhemV4ditIcnZUOVlVelVTUzk5a2k2blYzTzZURFFBSWps?=
 =?utf-8?B?dnB0anI5MWFXRXlVT1R5NWYrMUhEd09xOVZuS1pmamVBbnowRldtMzdRYkVr?=
 =?utf-8?B?TzNQZC80dW1UTlppTGg2MWJyMmdJVUY5c3Z2VFBJQlI3WUdISnFaMHFkb2M4?=
 =?utf-8?B?TkpRWmkvM3BMZkpkTS9HWmNQNFE3d1d6dHlIcmtmMzlhd2V6dEdxUnJZNjdt?=
 =?utf-8?B?ejllNGZLNlJuREdkazN5dkc2TmxyUFU3U0Q2RFRYYnBVQ1F5M2pyRldzM1hE?=
 =?utf-8?B?U3dyWVNaWSt2UEJZdWQ0MkNHVVdGZUF0dko1dkU1RSs4TjVzTmszU2hOZG1l?=
 =?utf-8?B?aExHdTFuVDJoRXg2ei9ldnNpRmV6ZVI0cTNacjFlZE1EYm14WnZFMHVwQU1m?=
 =?utf-8?B?T1g4NUkxZFU0dUlJQ0hiQ29DR25rRDNFcTZuenprWVMxNFRoeXVZWWY4ZUE0?=
 =?utf-8?B?bnBndnpxRVJsN29EUE00TEFOcjg3RUpJcHd1U3JRTnBycWkyYU1JajRNZ2RR?=
 =?utf-8?B?T0ttWlcyQ0p6WFZ4ZFpBVmt0Q2lOWWFLM2cyZW1mYldwK0syaFc4UTJTWWxn?=
 =?utf-8?B?UEdYQnI5dTBUMU9SbFliSXNib3NwckMzTkdEbXUzNU5sRVN3dkI1Y2xpSGgw?=
 =?utf-8?B?RlZ3WlppRGVIamxmSjgwbGdwQnBHVkVnZXordVJOdHdTa29ZdEtKcGEyWGNn?=
 =?utf-8?B?ZlJ1N2lTNWNOckpBRUZ0L2xZMDB5VzR2M3ZiWUZXRWZUeWxTdTh4VTB4L0Zw?=
 =?utf-8?B?M3VxR3R5aDBVYXZGQ0w2bC8yTjl2TVpZNktCeEhtcDQzT2FNZFBHTkVSUFQ5?=
 =?utf-8?B?c1NIdTZaZGZWNmt0N0daSU1mbVBnekRwMHR2Z0tsa0N1RVhEdjFRVXZzdE5V?=
 =?utf-8?B?YXJPcktLUEpCSlpZZHJscHIwSFFjLzY2eEdpVFhzZ25lVjdIdWdVMHVQNlBP?=
 =?utf-8?B?ajN5RWFvN2RoMG4wT1prOGg2L09CT2RiVFJYZ3lqVS9SK1QxYXZQTlFLYlBT?=
 =?utf-8?B?bzdnM2xnck0zVjhnUjNBMmw3bFJQSUlEOEN5T0w3amFKTzRSWUVWejN4cTh5?=
 =?utf-8?B?ZmpqMEZUUUw5aWRMVXNpaENndE9RZFRhVVBVU3l4VTFLK2JKR1NDRlRBY3NK?=
 =?utf-8?B?aUkxdDZkbEpXbE12WGJRaGhJZzV3dndsa09hbUVIK1Z1dkcvOXVGWVFYNFZk?=
 =?utf-8?B?dTE3MTBCSmR1RzFjcHBuTGowYjNTMUR0b3lUMVFxdi9lYkdPTnkyaDZHb1JI?=
 =?utf-8?B?d09CdkJzL0lYYjhpSDMzYmZORnl5MjczU0F0ZEdldFgvR0NrTk9QazRiVWxI?=
 =?utf-8?B?amJmZVhrN3FxdEV5eUN3WUhaQTZzbDByc3NWYy9wTjlqTHBxMUY4ZlpkK3pY?=
 =?utf-8?B?ajV5UTBGRnYzeDlmbnEyQjROY3lIU3VpeXJmbS9vb01uSzlIYXUzYklHdWNP?=
 =?utf-8?B?N0M3azd4TUJFSjIxY2dnajdHamdpMzJEcnhmK0JEMzJqcE9aTjFkeWFLVE93?=
 =?utf-8?B?RHUzZGFpcyswR0E4OGNJcTBFUFM5eDc3RFc5M2pmV213L0twc0Y0ek41TGZG?=
 =?utf-8?B?bStWMFlKZ3h2aEw3Y2d1bFpjeUR0L3VyTHRqK1Rvclh5NGh5NDRFd0c5NkM4?=
 =?utf-8?B?M1VFdmlvSnI2NW9meGdNbHRxeE0wZ0YvemNFYkoycUlrdWJPWWRtaGEzL2Jk?=
 =?utf-8?B?UnBVS0czNzErb0JJZGVvVVgzU0UvMU5oVHI4eC9jTy85R0hmMFhnQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3f730a-f9db-4a51-e94c-08de6972e40d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:38:50.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0JkELp+pUqaELEFvZhVvvJZonpr9fkzDFM0FEvWws+rFUuMttgxw2Pqw1t0PX4gJLRsm8Dlk+P8ylWrO8GMxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31739-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 078EC124D78
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:42:27 AM +0100, Krzysztof Kozlowski wrote:
> Huh, what? No, since when? Read docs in the kernel, it's complete
> misinterpretation of kernel development model.
> 
> Reach to other people in NXP to guide you through basic submission
> guidelines, so you won't be upstreaming 10 year old poor code (like last
> version) or doing such trivial mistakes. They would tell you what you
> have to do.
> 
> 
> > and optional OF handling, but SDIO bring-up does not depend on any DT
> > properties — enumeration is via SDIO VID/PID and the driver works without a
> 
> That's not true. Look at your code - you have OF calls.
> 
> 
> > binding.
> > 
> > The plan is to submit the binding YAML (and any DT properties we actually need,
> > e.g. OOB wake IRQ/regulators) as a separate patchset to the DT maintainers so
> 
> This is not how it works. We won't be reviewing DT submission separate
> from wireless subsystem / maintainers.
> 
> 
> Best regards,
> Krzysztof
>

Understood — thanks for pointing this out. My interpretation of the DT
submission workflow was incorrect. Keeping OF code while dropping the
binding is not acceptable, regardless of intent.

I will remove all remaining DT/OF usage in the next revision so the driver
is fully independent of DT. If DT support becomes necessary later, I will
submit both the bindings and the driver-side DT code together in a single
series, following the expected process.

Please let me know if this is the correct direction for the next revision.

thanks and regards,
jeff

