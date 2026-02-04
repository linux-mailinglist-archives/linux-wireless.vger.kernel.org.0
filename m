Return-Path: <linux-wireless+bounces-31549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG7sASyLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:08:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F02EB6C5
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58CA301A721
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB92F83A2;
	Wed,  4 Feb 2026 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/IJq/du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F027A465;
	Wed,  4 Feb 2026 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228314; cv=fail; b=N84T31i0SsGW11jwSEB02ZxpOtxhA97pNoahuKf00z/PZcWd6STZbVuFUwhBtpYnEYcpLA01+y/CKPlfSBhLtHsu0uiK8Lb8phLPs2N37ulsIKyDAZGFQaJgh+70bU8QFjVIjyfdCFovOg96GVJaU8gwuCICHZqVuaBFioXzX7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228314; c=relaxed/simple;
	bh=sezK8yBN2IdXBv6Qk5nuSwBKRg4wIxJQuHnfExfqZrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iBWHUyaej40GxKJ+CDHEkzpVcRkYpM8iJjd7fdXHsEQl4RegZe04NVEp9di9T7HAm+uQgw05BwKUYUw2K2OBPzDQS27aKyXGL6IlZD2VwNzDnbd1N5T78F6CPCl/ggtTbhBChr1nJIaIc94D3uCt/YpykuBOh5mps79KYwnCSiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/IJq/du; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOmQOiwSnq2kTQLHsKugebfy/pi6sUvdCRKqqnpmABtCCXa6aGPQtnvkganRl5HJRCJU4pjttr6ZVNX6SrnlwOMOqsloYgZ8sgbYFvuSB3s78JCsHhaxf3GKcVzIcV0iQfQp+mcphb2bs2eIMLM1Do78tOLs6Ba3EsLAOkW8P7Ci8oQQY7nILJf8us6FY1ElICaGaEzoeI+PNy4tOyM/bl2H70ABSSrnBsZbYFxDNUqEfSpVqXD5UGGVzpBO62YZ9e0Xyr+o20k45nRuY97y/XA9DuBuG/yV6CXwUjVw2HAg47mPyndCUkuI5SMMUe1KvTCDvXkhGPL/m+9A9IRuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PynyloyeaTLR4nw5fczKNECHOXUMNgP+fF8a3C4zofA=;
 b=HO0OlO9wTSEEWOfwf3m5IF/H9qDSZtxaAD+9/YnZ5KNdemUaH9VPEpGhfDeqK2dFSF1m5cM1j04RmScmY3He9UmlHD8pgKWonjGOxMzb9mHEXSlknveizlVsPAD+gKZ7iNWoohB+8a2tBBP3tUJQTGgv5WwOKBE0Ix4zzBx6cz76+4C2btX+F5FHpr1gkSwOrHMv0xZtYcrjtH5mTH9kocpRm6C4Qdpm5oEUh+7MlwHZb9WFyAyMJ3Sra0LM+ypGMmuQmuv4wGcPxUrtL5Zqq7LjHD5ivtOi/nwGOhu38D8e9TlFPKi5Y/r6e0MdcFnIa1xvi7vBTtUkiET0hb03Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PynyloyeaTLR4nw5fczKNECHOXUMNgP+fF8a3C4zofA=;
 b=W/IJq/duFCy7yiAV6jilDWxMHFFhaF+yFC0FbDFykkorTmYEgGR+Frt3WqkfAzMIm/sXFqCajacxwkacY5G3AcSJpy+2znnZmBiqcKY9p8urTTGo6CkV9JrTNssF4f9frbY6lCHX9Zlb01VA9C1E6XX58Xqj/6IENxyvRvSijTWFHphNDMUQirx2DBLh2ta6ut2QkKHCquM5sxAI1R6yamY9oubiwSuriSL1O6eTVxKyb+P+ynN0HPD8gg01MUJ6xskCp8nZJif4/LGDKZlt2I9bKiIsbuXEzUgPKHTkSHRhQKkRALeIAMN/vy2FfkvEPEgeatR9Bi/FvGRovSQU2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB12314.eurprd04.prod.outlook.com (2603:10a6:150:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 18:05:10 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:10 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 00/21] wifi: nxpwifi: create nxpwifi to support
Date: Thu,  5 Feb 2026 02:03:37 +0800
Message-Id: <20260204180358.632281-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB12314:EE_
X-MS-Office365-Filtering-Correlation-Id: f5224b5f-b70f-4c25-b828-08de6417efa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlOQ2V4dGVxM09wNzAreUZPU09TVHBXdWF6RmRSdytHaTF1SWlwWWdtR3dR?=
 =?utf-8?B?L2M3alZ4aW4yRmo2NFlkK0dQMlpRZTFaT3M5M2w0VEVNK3VoWmZkMW1od1NQ?=
 =?utf-8?B?akgvUkErNWNUakJ4M0RvY1liRW1NaEFXY3BEV0orU2dJYm90SGhUVS84aEZ1?=
 =?utf-8?B?SHFwRUFZTmN0TDE5NHhocHBvRjJOVGEySlBrakh5UEdpNVh2anlxMXV6dlJV?=
 =?utf-8?B?Vk8vcW9wV2k1WlpYZDVoekY1bkRrMjZPR3NQUTVTMmF6RnZvSUtWcXRRa1lD?=
 =?utf-8?B?eWNFaUtIN2ZPZTlOZ0lFQ1Bsc0s4Y1BsWWg4R3dKWFFhOWo1WUQrSSszNVlr?=
 =?utf-8?B?WFlKMGplL2t2Zys2VkhwTldEM240cHBIVTdvU0M2WURVSUpBSGFyR3BaNkN5?=
 =?utf-8?B?RkRYTENzNGJBeis3a0o0NnRxQUI1TUhFSUFnOExyeFhhbHFsZ3EraWc5T1Y5?=
 =?utf-8?B?eGpKcnlZaDAzUGVoaXhhd1FsT2swU1VmekpNQzFBZitiTEFwYzYvS1hZakNG?=
 =?utf-8?B?UVp3Z0QrWDF6OUZCcnVNeG5RWWcyUXA1NDRiUkZrc205ZE9rMHhUcjg5TjJr?=
 =?utf-8?B?YnRkSVJyRE5wNVpURHdYMUFaTC9RQW9RczN5cnIremVHOGlyUUV4TFgyS1BI?=
 =?utf-8?B?bVh4YkF5dUZPUC9QWnl6QXh5b21jWnpZNmxFODI2Tmprd1F4ZUlpcERtYStC?=
 =?utf-8?B?bHBSZGVJVmxQNmxUcThBWXBZbTh6ZTkrMHZoR0ZvejluK09EWkZja0xubGpC?=
 =?utf-8?B?Q1BzV0U4Mlh4b3VaUUxQeVlHREpLS0RCbDdOcGNqTmZqVFMvT1lVbnFBbzJz?=
 =?utf-8?B?L1hWTTF3UWNFOWJPcjRuWlhFa3ZYOUtVNnd0L1BjYndoWldNa21ObjJxMi9G?=
 =?utf-8?B?Y2JORkprZXBkbFcrdTlSRjNzL1JqN09md3g3N2tYVytHQWUwZmVyQ0Nmc1NZ?=
 =?utf-8?B?ME9tOGR3aGxOQ21aanZIdDNWa1gzWkNwVlN0TCtNMnlvaUdIMUpQS1pUdE53?=
 =?utf-8?B?a2NDYzRQcDZsMmJHdDR3L1JZS1Roc25kYUZObmFtY3VOSE9FR0dYTFp1T0Ns?=
 =?utf-8?B?VmMvVE9XNDd6WTRmQmt4eWYyVGRxTklWbG9MYURSMmg1V0cvWXBaWmNOZHor?=
 =?utf-8?B?RWpKdkJoZFlnNDMzaFJnbGREQVBsZXd5WFlrWTBHMEcrSEVjeC85dnp1YWJv?=
 =?utf-8?B?OTVPZkRvb1I1V28zT3pJVWhHVnQ1MWZQQlpSYVQvZHRBazhHU1FkSFBRRjJC?=
 =?utf-8?B?dzBLa0RJMTVwdnUrK0VIdStZTzJtNGhnVWlsNjJKdWlxbU43WWV0SDVMV3FL?=
 =?utf-8?B?ZnByZS9vNFJjOU15aXBHbkRBbEhiNVRBZzZLSVNEUUdNK3pwUE5DMGxCRExp?=
 =?utf-8?B?U0JPQVNNMlN3YkpNUjAxZVJPWFMvSlUrTEtyRmNuOGtoTXV1QXlFT2xSYTNK?=
 =?utf-8?B?UDAvQ0FzU1hobVhQQjFQemF2TnpSS1QrRlF3cmZMSFZHaCtTdjBZZmZ3WGJh?=
 =?utf-8?B?alEvdjhxZEZMQzlSY2dtbmVSeVRhQjBWMXVYcTJjbVRkREZGcWtSU0UzTUQ4?=
 =?utf-8?B?VkwxN3hLcmppSTkxaHVwU2dPRjk4amxzWE9hS1BJVUJaVldxZW5oWWMzT0dp?=
 =?utf-8?B?S0lIYTlDVzd3TzFhSm0wNXZNazNqdWNFSEtlcy81c2hlNmJySE85ZVRJbW1a?=
 =?utf-8?B?RU11UTE1ekJZeU9UVm9jZi9JU1o5c2l6UU56R3hwdW5MekdHZW1wRy9IenpD?=
 =?utf-8?B?MFU4VW9SQ3dSZUh2VXlrazVYelBsQnF2MmZWSnJPSmJFOCs5SU81dExFaVZk?=
 =?utf-8?B?dW1icDQ4Q1llajhWK0NWZ0M3UlVEQmtaV1RBTmwyaEhwV0RjRkRUWElzNm1K?=
 =?utf-8?B?dE1WemNwWUg4eVBMaEJCc0hDYmdtbjBISkJ0aTNtaFJnZkxFY3dQU1dOU1px?=
 =?utf-8?B?emlHd1hLQ0U1M1hwKzU5RC9UU3plak9tVW5IOHorMWJaaFdDWE51M3IvR0pE?=
 =?utf-8?B?eW8yUUJXaTZXMHRITHdXSnIxVWQ1cmZMVHBCajQ4NDZvWEhiWTlGenBEdXFa?=
 =?utf-8?B?T2xETWtVa2RkdGtyaW9sdUdSZVFNQlMxMGdtV2hnamY1dFFJNU1mNm05Q2dn?=
 =?utf-8?B?Q25wMHVpdmIxMC9nMFA3WjlwbTJwSnphajErTGExc3VsTkNrVk1reVdzdFpq?=
 =?utf-8?Q?Tx2/49t4E/07j87/V8wRt40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFjbzVVQVJZNytVb3ZxZkdXR0lXQm1JR0RCYmZkYkd1by96MmF0VEpXdWhm?=
 =?utf-8?B?d0psTjdPYVVWVVVQZ0Y5U1BhWFJUS3RQV3RuNElKWEVWRDBQOG9KekNKWHl1?=
 =?utf-8?B?TTNNYWpTRnJDNzExVmxLZkhKTUxSNHE3V00xc0pESFBGcVdBdWxxRXB4VXJt?=
 =?utf-8?B?WEQyTlVQaWYzc05FTmJoUWlXblJCZzJKSy9oLzFjZlljOExQbkJ6OHpMWWNl?=
 =?utf-8?B?M3BTTTlUZHBobzR2NzJMdmcxZ2Z5UFVqM1lXbU54UzJhZmVmLzJDQVRCUXM1?=
 =?utf-8?B?N2Z5TGxpT2swdER3bEFjdDBLTWNwRVhXRE80bXE4Wi85MFBadlBuSUpORUZ4?=
 =?utf-8?B?MkRxWDhMS0JoS2tkeng3cHVwY1JhTkxXaFFRTVNTTk5reGZ6MzhLek5ER092?=
 =?utf-8?B?VVFYM0VlM1RJSlhCNXhzRlRIOWplYld1VGs2ekZ6eDhaYXpyVmVOdmZGUlow?=
 =?utf-8?B?d3FqeW1wYXpaKzNnWkwyZDQ0SHdIVmFySEQ4LzVYM0d6RXhXSEpWc3g2dDFK?=
 =?utf-8?B?SDJuR1FKd0xoOENPcDFVSlQzUG1WUXdOV3ppZExzaERNN3RKRjBEeFNIUWZ2?=
 =?utf-8?B?NzYwQW5OaFI3RGl4VmxhSXNRZnRMV1phdFBQL0ZQRWpiUjRkR0dpbllJdG00?=
 =?utf-8?B?Qk53cWVyL2hmcnVHVXdaNHFFcFJ3K2toZ2RycTNUK0kvbS8wMnlsMTdJZXZs?=
 =?utf-8?B?aDJjL29aYzJkSStIdGt6ZXZlZ2luMEFCTjJveWY4VHExNGlGQ256LzhJUHZV?=
 =?utf-8?B?TFVxWHZZR3R1Y2prbEg2cWg2c055ZzArUlF5dU93N1BvcERMSHVjTGEzeWJH?=
 =?utf-8?B?bjY0R1JUaWhxK3ZVRDBLdmltaC9wV2Rsc0pQNm1GZU5TU1RWTTV6V2RxMmtm?=
 =?utf-8?B?b3VidTFGMkR1REdOM1dBSWtqM0xWc2lKSG1kMVBJZjhzam9VcHBnbndGalMv?=
 =?utf-8?B?VC8rYk5Hcmw1WGcrbTdmRlcyZ1I1NlRwVEkrVGlrMVc4K1B2NmtWdlRHRHJu?=
 =?utf-8?B?YmdDT0dBR2R6RE9RSHpNNFg0ZGxrakpaeGNjeGowUHlJaThRV2wyTGdaVmpI?=
 =?utf-8?B?aFdjRmtGMlpnV3NlMGE5Zk5YZTFxVks3eGNPU2NRTEdyaE41YUxndUprUG00?=
 =?utf-8?B?NGp5UjVzbUt5dm9CWjhhMEpvZVNPQ2p6a0NBaVdqUjJYRG1ERnJSUU1XTUQ3?=
 =?utf-8?B?eGMwYU5TanZMVHczZ1BrTy9POVdGMUlVdVJIYUdzci9iekpSaU1VWmliMzB0?=
 =?utf-8?B?ZS9zdDRKdWpROTBBdTFnSWJpWXg5NGllcnBoY3VySHF1NG9LTFEyZFk5T3hm?=
 =?utf-8?B?RzVsaVYwVnJTcDcxT2YzZGJpeGI4WjkrYlBLNHNwNzRyOHVzeUlYN3czbGpj?=
 =?utf-8?B?TzVFNFFxVVd3NkpkSUErNUt3Ymp1MHk5WmpvbXZLeC9hbEJZQ2xZdm9Obzhx?=
 =?utf-8?B?MkZZeXFOT1ZhalJJTkJMZ05JNzBTaUxVcW5KcEQ3NVNXUldlZmdNNWNtcWhw?=
 =?utf-8?B?OHhRMFl0VEQvRk9pQ0VWMXlweGhHWTQ3aU9PTG91dG1najhrWmN1MXRxYWVk?=
 =?utf-8?B?YUw3YnZFRHpwbnNrRlpTWlJwa0VqbWVlb0U0MnFjYkt2VEZkeVpldWc1WjBy?=
 =?utf-8?B?QmZtaWE2SytoLzYvMXNIS1paWEZ0elF5SkFWaTJXb3dMclFma29xRCt1MjNO?=
 =?utf-8?B?emFNSTFROVZkV2c0UDRKNTlVcUl2U2k1TjZXQUZ0c2E0ZUJVVEtTbXM1NlpY?=
 =?utf-8?B?dXlnYkdTVjNob1IrK0o3TFVEVDNFZ2ZoVlltNU5mbzRvOGp1eGtoOWJ6OFFQ?=
 =?utf-8?B?NDkzdXJQL2NwQWhvdFlrT2paNUlFa1NlUzRMVVNTdWQvMmVGWURMeVg2blFH?=
 =?utf-8?B?M3llWnI5dzI5Ni9hTmZyWHI3MzRubzE5ejNWeE90aG5wdlVtdUR4SHQwOXNi?=
 =?utf-8?B?T01zUEJkb21oOEFaKzg1dXV3MDJSRXc0WVVzZHpKdGZOVHREcVk2cmROVG9v?=
 =?utf-8?B?N0pQOTN2NnZBZGJMc1ZBTTQ5ekNjT29Mc3ViMjNlWWdZd1dRNThVR2RvcEhQ?=
 =?utf-8?B?b2lXS01udmNDMW1JcGd2UkFVWG4vMEVyY2xlT3Zmc2U4YW8rZDYwZXBscVl0?=
 =?utf-8?B?UEx4THo2SDRsWTlxU0VZa1A1Q0ZXdFB4ZXNwSVhtaFJ5UjNGWEZybWc4RU9M?=
 =?utf-8?B?MFg4MXBkNGhYSjY2MlZVRmFSTWxUMHBFbnRGMmJRTUZzbVdna09nVVpheXZH?=
 =?utf-8?B?dkJ5dS9UaVhNN2QwTWV1ZVlTalA3RGlaRWJwWEJCZi95dGxHS2Y5TG9aTlYw?=
 =?utf-8?B?WTFuSmZDZmhKMk5mMEx3aUVONVpZTXhPOUgzTkY1OVFKOERXU0ZUdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5224b5f-b70f-4c25-b828-08de6417efa8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:10.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYfeKdeG+zztxrSrpOa5zZDE/mcfNOJDe5FPyq9rPRIKhd0zNWJiG4LOaZ5R2QDAvvzNqGePh9460T7ve7D5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-31549-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 51F02EB6C5
X-Rspamd-Action: no action


This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
IW611/IW612 chip family. These chips are tri-radio single-chip solutions
with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
Communication with the external host is via SDIO interface. The driver is
tested on i.MX8M Mini EVK in both STA and AP mode.

This driver is not based on mac80211. It derives from mwifiex, but due to
significant differences in firmware architecture, host command interface,
and supported features, it was not feasible to extend mwifiex without risk
of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
will also be supported under `nxpwifi`.

The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
handled in host via wpa_supplicant/hostapd.

v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
fixes and improvements. See below for full changelog.

Data sheet is available at:
https://www.nxp.com/docs/en/data-sheet/IW612.pdf

Firmware binaries can be obtained from:
https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwImage_IW612_SD/

Change history:

v9:

    SDIO updates (addressing v8 review feedback)
    --------------------------------------------

     - Dropped mandatory Device Tree matching in SDIO probe. DT parsing is now
       optional and no longer affects probe success. All unused OF match logic
       was removed.
     - Removed pr_debug() and all probe()/remove() entry/exit prints. SDIO now
       stays silent on success, consistent with kernel expectations.
     - Removed legacy assignment of MMC_QUIRK_BLKSZ_FOR_BYTE_MODE.
     - Dropped deprecated `.owner = THIS_MODULE` from struct sdio_driver.
     - Reworked SDIO comments to follow current kernel style guidelines and
       removed verbose “This function …” comment blocks.
     - Modernized firmware-ready polling using read_poll_timeout().
     - Rate-limited intermittent ISR error messages.
     - Replaced sprintf/mdelay/memmove with scnprintf/msleep/memcpy.
     - Added missing return value checks to sdio_enable_func() and
       sdio_set_block_size().
     - Removed the dependency on include/linux/mmc/sdio_ids.h.  
       This ID table belongs to MMC/SDIO subsystem and is handled separately;
       nxpwifi no longer requires this header and the update will be submitted
       as an MMC patch.

    Devicetree bindings note
    ------------------------

    The previous version included a devicetree binding document for
    `nxp,iw61x.yaml`. Since Device Tree support for this device is optional
    and not required for current SDIO-based bring-up, the binding has been
    dropped from this series. A proper schema will be submitted separately
    once DT usage becomes relevant, so that binding review can be handled
    in the correct subsystem and without blocking this driver introduction.


    Initialization path cleanups (aligned with upstream mwifiex)
    ------------------------------------------------------------

    This series ports three upstream mwifiex cleanups which remove obsolete
    asynchronous initialization scaffolding:

     - Based-on: c2095eb63319 ("wifi: mwifiex: remove mwifiex_sta_init_cmd() last
       argument")
       Dropped the unused “init” argument from the STA init command helper.
     - Based-on: f996f434aa78 ("wifi: mwifiex: drop asynchronous init waiting code")
       Removed all asynchronous-init waiting logic (init_wait_q, last_init_cmd,
       INIT_DONE transitional state). Initialization now completes strictly when
       the last synchronous command returns.
     - Based-on: 659d609bdda5 ("wifi: mwifiex: remove unnecessary queue empty check")
       Removed the redundant “command queue empty” check after init; retained
       only a WARN_ON() for future regression detection.


    General cleanups
    ----------------

     - Numerous comment style fixes across SDIO, HE, VHT/HT, and main files.
     - Reduced verbosity across the driver to align with upstream expectations.
     - Small structural cleanups and dead-code removals.

v8:
  - Standardized multi-line comment style across nxpwifi driver files to Linux kernel
    convention.
    /*
     * ...
     */
    No functional changes.
  - Fixed workqueue cleanup and error path ordering in nxpwifi_add_card(): ensure
    proper termination before resource free to avoid race conditions.
  - Corrected spelling mistakes in source code and comments for better readability
    (e.g., Dimentions -> Dimensions, interfacces -> interfaces).
  - Added Device Tree binding schema for NXP IW61x SDIO devices (nxp,iw61x.yaml),
    including properties for compatible, reg, interrupts, wakeup pin, and optional
    calibration data.

v7:
   - Addressed review feedback from v6
     - Removed unused variable `ext_rate_info` in `nxpwifi_rxpdinfo_to_radiotapinfo()
     - Radiotap handling fixes:
       - Converted fields to `__le16`/`__le64`
       - Applied `cpu_to_le16()`/`cpu_to_le64()` for endian correctness
       - Replaced `jiffies` with `ktime_get_ns()/1000` for timestamp
       - Validated channel frequency conversion and removed redundant code
   - General cleanup of endian conversions and Sparse warnings
     - Improved HE capability setup via `_ieee80211_set_sband_iftype_data()`
     - TWT configuration fixes:
       - Updated structs to `__le16`/`__le32`
       - Corrected debugfs write helpers for endian conversions
       - Removed redundant conversions in `nxpwifi_cmd_twt_cfg()`
     - Scan handling fixes:
       - Changed OUI variables to `__be32`
       - Used `le16_to_cpu()` for `ext_cap->header.len`
       - Moved element pointer declaration outside `switch`
     - HW spec parsing fix:
       - Added `le32_to_cpu()` before `GET_MPDU_DENSITY()`
     - Cfg80211 handling fix:
       - Moved `legacy_rates[]` definition outside `switch` block

v6:
   - Removed custom locking (main_locked, main_proc_lock, more_task_flag)
   - Refactored main process to rely solely on workqueue
   - SDIO interrupt now only queues main_work; avoids direct call to nxpwifi_main_process()
   - Introduced atomic iface_changing flag to block main process during interface transitions
   - Split monolithic main process logic into helper functions for better readability
   - Improved exit logic to avoid lost-kick scenarios and ensure all pending tasks are processed
   - Replaced rcu_read_lock()/unlock() pairs with guard(rcu)() for modern kernel style
   - Code cleanups based on review feedback

v5:
   - Fixed build errors introduced in v4.

v5:
   - Fixed build errors introduced in v4.

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver version string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex:
     wifi: mwifiex: replace open-coded module_sdio_driver()
     wifi: mwifiex: Fix interface type change
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
     wifi: mwifiex: increase max_num_akm_suites
     wifi: mwifiex: duplicate static structs used in driver instances
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant
     wifi: mwifiex: Fix uninitialized variable in
                    mwifiex_cfg80211_authenticate()
     wifi: mwifiex: remove unnecessary checks for valid priv
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext()
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

Jeff Chen (21):
  wifi: nxpwifi: Add 802.11n support for client and AP modes
  wifi: nxpwifi: add initial support for 802.11ac
  wifi: nxpwifi: add initial support for 802.11ax
  wifi: nxpwifi: add support for 802.11h (DFS and TPC)
  wifi: nxpwifi: add support for WMM
  wifi: nxpwifi: add scan support
  wifi: nxpwifi: add join and association support
  wifi: nxpwifi: add channel/frequency/power (cfp) support
  wifi: nxpwifi: add configuration support
  wifi: nxpwifi: implement cfg80211 ops for STA and AP modes
  wifi: nxpwifi: add firmware command and TLV definitions
  wifi: nxpwifi: introduce command and event handling infrastructure
  wifi: nxpwifi: add data path support for STA and AP modes
  wifi: nxpwifi: add debugfs support for diagnostics and testing
  wifi: nxpwifi: add ethtool support for Wake-on-LAN
  wifi: nxpwifi: add utility and IE handling support
  wifi: nxpwifi: add driver initialization and shutdown support
  wifi: nxpwifi: add core driver implementation
  wifi: nxpwifi: add initial SDIO bus driver support
  wifi: nxpwifi: add Kconfig and Makefile for kernel integration
  wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver

 MAINTAINERS                                   |    7 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  280 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  594 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   73 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  338 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  837 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  158 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  251 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  826 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  993 +++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3960 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  458 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1149 +++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1094 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2373 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  480 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  607 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  788 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1721 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1800 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2765 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2326 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1177 +++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3444 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  862 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  242 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  190 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  352 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1198 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  488 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  478 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1523 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  128 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1308 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   77 +
 48 files changed, 36068 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

-- 
2.34.1


