Return-Path: <linux-wireless+bounces-7292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC058BE709
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1DA1C23C4F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F65165FB8;
	Tue,  7 May 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axians.rs header.i=@axians.rs header.b="hcdupqH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D916132B
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094577; cv=fail; b=GvTahuJFkt9wvOwHj9/Qov0MWUtTUkIpIYkPQ0wf2lYU64JYczQUM3wB0nyOE9TWoNHTaqLoI62CJ7KRgrNWx0au6rwiQUiYuLsENX/9NGDORr4rkyFimA38tJyC05bMjOIjXTsJgsg3FQmbL30SDWmejbzgpvmChC6YwNVWoyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094577; c=relaxed/simple;
	bh=VJlsJqLxEsNQFLB8OPehpLUQwZgHaiAMUcxBtY3SrNQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WbeXSnL9+5+4e2qLWmbVnwQJ+1JA46DYH01PCEdPTDLhRm6dSiZK/FIXPodShHmdIpgcoOHkZ0JZpifaAiXJne0NzKyKxkaAphE0X5XNsso2ImsonHSgDrLWR45XfVEl3bP/bvcOs8xddACRh6BqVnv7ot/TxKre+eh7Gffl5Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=axians.rs; spf=pass smtp.mailfrom=axians.rs; dkim=pass (2048-bit key) header.d=axians.rs header.i=@axians.rs header.b=hcdupqH9; arc=fail smtp.client-ip=40.107.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=axians.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axians.rs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yif6Xg7WzC85a2REYGWfVnEDHwLelVEOe2GljY9xc6hHDJK0weG3ZPnLBc7r8GeAwyMsdq0LEfH3IqAQryJ32aCBn0OPAdb5ZdOlwhuP29caZYyFzi/rlty78F4GPTOWawVgmmfUYCH5pA3H+FamtHfMfzOc1EvU0zyXIrmtOeUebzELXth92iQVCVGsDuqSEsMvvLOukFBi1XEo0sDBFpfrwOO1qQCji4xK7AOT0K+nEm2jbnT2fGWvl5A9txFOWRRBzgZ1w9fDrlj29bABa/+1AvXW/NbGxujLcz8QuvTcB6iIC2A+wTmMLF6GE2OtPVKBmI9CmBYqu+/dXgbA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJlsJqLxEsNQFLB8OPehpLUQwZgHaiAMUcxBtY3SrNQ=;
 b=JzUo+POP6iQqsR+Jq68LKbU+3aCCiXPQ7G6tye7oyg4HYZvvupvzwSS6ZdViM3o5oroN1P50qYaoyRX4rLOYqzqyQlr2IwjJYj2I6kLQ50bpU/mKsAT46PokS6ATiM8WStJGE+5p0j0HSoOdPkYiuEQaAbqfBzzM/68yM/2FjIt21MNXqW0Wb5iplam3JQ7dKAoC1emEHe95v+DpT4TGFlWXaTKKfmXcl0BAVM1cSjtvXcfe5ctBrjapaWtVRDps0ZMnzFvXS/Kqyc8Dqi4uJuDXcyKX+cg7mhmwvaheauCOxR22y3und5+usAfFvi6U2u3cqur9E56sTLuNSfQsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axians.rs; dmarc=pass action=none header.from=axians.rs;
 dkim=pass header.d=axians.rs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axians.rs;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJlsJqLxEsNQFLB8OPehpLUQwZgHaiAMUcxBtY3SrNQ=;
 b=hcdupqH9pCDZWaVD/ccGa28c6f9PeGHuqS9sB1k5fETKTXNp+8KMkxiBfm7XlRKDYVYwvXppneWFpyBM5VNTJoyjZ8DLhrPG2CxyWwJVfVgHWO7By4KfqysACnoehuWQsmcf2viTpf9AmZUXodC+skMG0Gr8vWikvJt5SfbvwkIZLGIT7wmCUT+58l5TKcSG44w2EgWOtTEqsMwoyH19kaCklwHVjEm+AJTkz++e/2Af7zD+YNsyE4asxfBOOfJdcHfoU0BStkES5yZwfMv4I7/mYaANz1TbsiYJD555hcsGWDUJbZkAt+6vfbM25ssKcXWxS0k/WnPbfXiaxSxLqg==
Received: from DB6PR05MB3480.eurprd05.prod.outlook.com (2603:10a6:6:1a::21) by
 PAXPR05MB8753.eurprd05.prod.outlook.com (2603:10a6:102:200::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:09:32 +0000
Received: from DB6PR05MB3480.eurprd05.prod.outlook.com
 ([fe80::8515:4b19:d54a:5d8]) by DB6PR05MB3480.eurprd05.prod.outlook.com
 ([fe80::8515:4b19:d54a:5d8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:09:32 +0000
From: BUKSHA Kirill <kirill.buksha@axians.rs>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Heiko Thiery <heiko.thiery@kontron.com>, Ajay Kathat
	<ajay.kathat@microchip.com>
Subject: wilc1000: error when transferring large files
Thread-Topic: wilc1000: error when transferring large files
Thread-Index: AQHaoJCQi11hvhFXTEOvMHxNDRR8Ew==
Date: Tue, 7 May 2024 15:09:32 +0000
Message-ID: <3b0aa2d8-4e3e-4e50-8c04-f3a2637bb18d@axians.rs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axians.rs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR05MB3480:EE_|PAXPR05MB8753:EE_
x-ms-office365-filtering-correlation-id: 40deebbc-8556-4ed8-02e2-08dc6ea7b305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFRpTGkzZnZMNlBMenYrdzNxUTE0clRrQzlodlRmRStFQ1RSSmdzVWgzK0ZD?=
 =?utf-8?B?ZDRDb1oya0ZHeFNDK1NENGJ2QlF1empOajg3QnZtQnBtTHdTSmtSUnJhWjNr?=
 =?utf-8?B?WldMRHpYb2Q5QksyN3dOM1U5L2F0OUh2VWJvd0srODhpeTJwdnd0N0NINWJB?=
 =?utf-8?B?Qm5KczRPdVNNOGsrMWpuUzVpdkJSbCtma2FXdllESHY3aHRKV1V0ZDBRcnZM?=
 =?utf-8?B?aVFRR005aDFkUHVtUHVnSnozb0NFNmdQVjJwY1BteklZc2lpd3VIVXJMczh5?=
 =?utf-8?B?VlRRV3RsSERrc3ZEMDVrbmtUS0hTY3dhamx5SkFlRnYweUZkVitnYVhUc1pV?=
 =?utf-8?B?bWdSK09BWGFFcHNPNmRhL1oxMG5OMVNqMkFtbkdpdDJIaExyd2F6VjFRRisv?=
 =?utf-8?B?cnhDZ1IrdlY2ME0xSjdYWDVkbUg4amJKSDR5U0IvRHdZVUNXV2dKMG5SU0Jr?=
 =?utf-8?B?TEFPWkJXTm0vTWlYTUhUVFBnekRjdDdSNHcrSyt0VUxjeER0ZzVpMGZZTFdi?=
 =?utf-8?B?cmJ1aU1OdHMyL0RqTGN6TGFZdkNkeHcrNTV1UktOQzdDNmhKSEJ2eGs5dXdV?=
 =?utf-8?B?VTRrUFdlRU1OczRNUnl4bytHWjZhZjBaT3RFb01ZelFWTG9OVzNkQ0FwNlpa?=
 =?utf-8?B?UG5nUGlOODJhZ3BBMVQyV1hTSWdkRTlpQWVrSFlIclMzWDlJNEI3ZExmT1kz?=
 =?utf-8?B?VEpGanpWQmV0bVFNbTRsU3Jqc0pNOEttUnE3UC9YbzJEa2pYM05ZVktDU1c3?=
 =?utf-8?B?cU1uNk1zMFZsM0lIc0hhL1NJdXFuUnAyaDlqZFFYaklhR3BydWdTdjllTmJ6?=
 =?utf-8?B?V0xBMzkrdFJnY2hDbXkyYzB1bnRmVFlPUUpuTmZIUjNPR1BEWFFldmUrbXpp?=
 =?utf-8?B?Tk9LZXMyd01uVDhGS01wMzl5UzNHZEpwSnlHclFKVlJMc0hWcDV4am9TVnpP?=
 =?utf-8?B?Vmd2ZHdXTFl2OWplK3FGYWFGb3R5bEwyYVhiUGRaRmR6OWJvRGRQQlNzY3Fx?=
 =?utf-8?B?alNubWZCYTJxQmRRUC9vRzZoZjVkVVNRSEphem1Cd0VQQ256S0crb0Y2Ylo4?=
 =?utf-8?B?RWdiKy9WWDFoRFdtSEdEaCs4US9tUTVFU3UwQy8yRDFYT0lwVkJGczBZNFRx?=
 =?utf-8?B?N1lvOXZ3b0hSV3pvbks1S2NaRVdlWklrbUYzUWNLdmxnb3RjWFJhVWliNERW?=
 =?utf-8?B?TDlXdWorY2VMWkV6N0pnVXN1dHBETytrRGI2UjlmakQyMTVSUTBuTzlkY0lR?=
 =?utf-8?B?RnpGV0xDQkhMSi83ZGQ3UmlXbnFYT2VpSVJPYnQ2TTI0a1hRaHYxRlNuZDBV?=
 =?utf-8?B?RlJ3YmZuQzF2dUV6dEJYWWJHMm1vMnA5aFlkUkpHNUpYNm9mVG44VjA1NVpo?=
 =?utf-8?B?MGV1SDJDNTdSVmFMNEdicHBUWXBYZHJpWkUrTThxaVpjNmg3eFZDdTNXWm5i?=
 =?utf-8?B?OWlUTWEybEt4Z3hqK1JQdHBiTlRIZ2xzYzFTZHZTTVRyMktjamJ0ZDdXR25X?=
 =?utf-8?B?NkdiTzdSVDFtSTUrYkhRbnQ1SCtvbmxrT1JPUTdDcGtHMEFLSmdicXZNWW9K?=
 =?utf-8?B?OCtGSXlFeWhkQkYyakxVVDMyRS9MdWVGbnhVK0pNTHhRTU9zalJRUjYrVXpO?=
 =?utf-8?B?N0FxaStmdlBrK2l0SXlOdWg3TG5Ha1YyOGdpWFNvWWxtSTN1cFc1K2V2L29q?=
 =?utf-8?B?UXNHdGk1ekxBeFMzeDRZdXp4c3BmRm81S2YrT1ZLT2pRcW5Qb1lGaEhQWXp2?=
 =?utf-8?B?OWd0QVRsN0gxbkdpa09SU3M0TUo1TFhWa3phQmVybWZaU3M4UldoMUl2MmtV?=
 =?utf-8?B?ZnZuVkhnbUxKbG1NbVhjQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR05MB3480.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnV3M1FwdEp4bWEwbzZWQ2RFZnQ5SDIvVFNGVzVuNG02cFVwcUxYRzhKNE9o?=
 =?utf-8?B?d2ZNd0tpMWllZVZSTW42N2RVeFcrV2FhN3cxUldId0tKVkpVMUVwTm40d1JR?=
 =?utf-8?B?M3RMNmtXbnJNUzh6MGlQNG45em1scTBhVjU5SVpIUDFIV1Q2R1J4N2FwSUZz?=
 =?utf-8?B?Nmp3L2tyYUJCd3JYZWFkMUhzeWNVckRQNjdFem5GaFBLRkRpTi92ZVM2c0JR?=
 =?utf-8?B?dlJiOEVCYUtPdHk5SVhnOVBHTUxCR3lHaTZRYkk0dWd4SDdUTFBqbHdtdi9j?=
 =?utf-8?B?VmV6emQ3U3Z5T0tIN2w2clBIQVhvb3ltKy9nMmNIM2dxS2VYRStpRk9lNGxh?=
 =?utf-8?B?TmpoYVFHZnU0ZzVDTHhuVWNZMysrS3l0VzNhUmN0K3R4K2wwY3hqNnRFRmJ5?=
 =?utf-8?B?eWxjc3ZhMTJ3RVJoSGFrdkFWM2VtL1gxSDBCdkVFN0hoTHRrK2lRaVZFTWJy?=
 =?utf-8?B?TXpkVzVPTzZrejRvRTdMQTRMeUtsR3IrTHZiN1pRcUdZRU44QitnQ01oMExu?=
 =?utf-8?B?NGJQUlYxbHg0SW5XYTBDNjFhLy8xeVl4RGFoUEVtVGE2K1NIdjFYOStDQStP?=
 =?utf-8?B?eEVLMHhHRzVxOVFqRUJwYU1XV29FejllUkY1aDcwUUtydDhEOW0vYThIVm1Y?=
 =?utf-8?B?Z0dPemg0cTZJUnQxQWtBWERVRHM2NUhsbmZvWEtKVTJod1RQaUhrSzlTWTU2?=
 =?utf-8?B?aVNjNDg0bEZHOTdjK2ZBN2dheG01cU1zYnFQQWRtQVZadiszOG1QaTMyNU4x?=
 =?utf-8?B?cTU4TEtERXZIVW9VWFcwMjBhNHJoa3NJMXVBV3ptRFZ1YkxqS0s4bmhEckZv?=
 =?utf-8?B?b1paa1lRRVZNMkNtckZiNW1mK0FOUVlnQXFsM2hsM0dsdHRvVC9PcnlHNHZO?=
 =?utf-8?B?cVVKVkQvMTgwVDh3T1FQQm1HOGR3VE8vcnp1cjIxVG1HdnlYWjFPMlJxZVp3?=
 =?utf-8?B?amZaV0VwRFJDdkJhaVJIRkl4blBjVG45eS9QTGp5T2wweW42dWptNHU0S3Ru?=
 =?utf-8?B?cVc4Zmp3TWhTd0lDRmk4ck05cndsN0g3UzFpSkRaazdiS3p1WnRqSSt3ZlZu?=
 =?utf-8?B?TWZ5N0RrU1pqSXkvSHhjcVVIYUFBNWRZUGxLekU1NEZiZEpPSUp2TUdDdFFD?=
 =?utf-8?B?OW1IbXdXc1NhLzlYSWJ3QzVVTVBjZU1WU213L2Z4WTJzbzNTTzd6a3VrMWda?=
 =?utf-8?B?MVZ6RnZqSTJKUTcvc3F1VGcweHk4cEhDSTBKVU9GUEhZTFU2VUZSVzVhRm5W?=
 =?utf-8?B?RzRZYVhXc0RzdXF4VSthSkFyVGxISXArVUdWSDhQNEw0a245YkZNNC9obFZZ?=
 =?utf-8?B?SDVRSGtvdHVNSHd1NUI3dWVNZmY5eWFxWXAwYStDekJLS1hVb3R4L3YrWVhH?=
 =?utf-8?B?QTdyMnlaNzNVM1YyUVVmUmQ4R0gxU1Roa2d4ZGY2OWNMcU83Z0UvWGpsZG9k?=
 =?utf-8?B?ZFhEZ0hwVG1McDVBNm1WazVIL2xQS3p4OWVDa2JhdGlaYzd3NEFzem1kOEI5?=
 =?utf-8?B?OWt3emttcHhjcVhvZ1A3WjlYUU9XSENlenVzY2g2VW5wOGl6Qjc5QVJFMWVy?=
 =?utf-8?B?QkVmTm5BRXdlcko4S3gyelRwbmlHREI2bTZGQTNSY0MybG5mcnJEaTFtS0d4?=
 =?utf-8?B?VFBFVGtFUWFoU2t2QW9DOGdDcG9rT0hCT2tPWmZMYkt2Nkx4QVQyRnJhZFRa?=
 =?utf-8?B?S0wwRjkrTUw0ZHd2dFNNd1p2MXhjQmFONFFIaUhWNjhMUlhRMUVIY21MRytt?=
 =?utf-8?B?OERVN0xUb3BRL2hHTzdNbUhrbG1Ocm9JU1BzcnNrQjQvMi9GY2hYNUw0RWwr?=
 =?utf-8?B?Y3BjMTBGQlZVM2FkVjlFT1hEcWl0NjR4cjBkNnJERlBxTEQwNXVDM09Yb09m?=
 =?utf-8?B?RkU3WEI5ZDZKNHNtNHBtdlhCTkdSNHc0VU1nOUJ4OUh4Qk5oMjgreUhtUHJz?=
 =?utf-8?B?LzJKQldIWHF6Q0RaeUwreFNOdkxYaE1xbTkrR1kxNXg4aG4relBzVmo4WDJt?=
 =?utf-8?B?SDBxMjBvV2dRa1FxaG9VS3FjZG9OSXdjdlVWZVVRS1U0YVB5ZEY1dUZwYmxa?=
 =?utf-8?B?WlVabHAydVVqTy9mbmxGZUNTZ05CaVY0VGJja1BwT09EL1VFZUtsVnhycndQ?=
 =?utf-8?B?TXhRRHRScXBmQ3BNeFhFejBzd0Zyd2FMZXk5NFYwTzJwTzMzUnI2YmJCM0Ni?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D726204A7196D84489CC50CBE9ED065F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axians.rs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR05MB3480.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40deebbc-8556-4ed8-02e2-08dc6ea7b305
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 15:09:32.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cae7d061-08f3-40dd-80c3-3c0b8889224a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tq6TyIPeaMW5yiqIdb08wTCQz0IDN/YLUt/8G57445LqzQVpixj22s/jvHuF9Ro7JtbITHlcTRF0WdxdyLhcyegXyPoBJ692KRTlM7yqkcnlTWstA1uv1GFXIUYve/r9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8753

SGVsbG8sDQoNCkknbSBwYXJ0IG9mIGEgdGVhbSB3b3JraW5nIG9uIGEgQlNQIGZvciBhIGJvYXJk
IHdpdGggYSBXSUxDMTAwMCBtb2R1bGUgZnJvbSBNaWNyb2NoaXAgKGNvbm5lY3RlZCB2aWEgU0RJ
TyBpbnRlcmZhY2UpLiBDdXJyZW50bHkgd2UgYXJlIGhhdmluZyBpc3N1ZXMgd2hlbiB0cmFuc2Zl
cnJpbmcgbGFyZ2UgZmlsZXMgb3ZlciBhIFdpRmkgY29ubmVjdGlvbi4gSGVyZSBpcyBvdXIgc3Rl
cHMgdG8gcmVwcm9kdWNlOg0KDQojIGdlbmVyYXRpbmcgZmlsZSB0byB0cmFuc2Zlcg0KZGQgaWY9
L2Rldi9yYW5kb20gb2Y9Li90ZXN0XzMwMG1iX2ZpbGUgYnM9MU0gY291bnQ9MzAwDQoNCiMgdHJh
bnNmZXJyaW5nIGEgZmlsZSBmcm9tIGEgbGludXggbGFwdG9wIHRvIHRoZSB0ZXN0IGJvYXJkDQpz
Y3AgdGVzdF8zMDBtYl9maWxlIHVzZXJAMTkyLjE2OC4xLjI1On4vDQoNCkR1cmluZyB0cmFuc21p
c3Npb24sIHRoZSBjb25uZWN0aW9uIHNwZWVkIGRyb3BzIHRvIGFsbW9zdCB6ZXJvIGFuZCByZXR1
cm5zIHRvIHVzdWFsIHZhbHVlcyBhZnRlciBhIHdoaWxlLiBBdCB0aGUgbW9tZW50IG9mIHRoZSBk
cm9wLCB3ZSBzZWUgdGhlIGZvbGxvd2luZyBtZXNzYWdlcyBpbiB0aGUga2VybmVsIGxvZzoNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpbwqAgMTM4LjAxNjIyOV0gTk9I
WiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcs
IGhhbmRsZXIgIzA4ISEhDQpbwqAgMTQwLjAwMTY4Ml0gTk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5v
bi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAg
MTQwLjAwOTcxOV0gTk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3
b3JrIGlzIHBlbmRpbmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAgMTQyLjAwMzYzNl0gTk9IWiB0aWNr
LXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcsIGhhbmRs
ZXIgIzA4ISEhDQpbwqAgMTQyLjAxMTY3MF0gTk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1Ug
bG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAgMTQ0LjAw
NjY3Nl0gTk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlz
IHBlbmRpbmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAgMTQ0LjAxNDcwOV0gTk9IWiB0aWNrLXN0b3Ag
ZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRpbmcsIGhhbmRsZXIgIzA4
ISEhDQpbwqAgMTQ2LjAwNzA0OV0gTk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwg
c29mdGlycSB3b3JrIGlzIHBlbmRpbmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAgMTQ2LjAxNTA4Ml0g
Tk9IWiB0aWNrLXN0b3AgZXJyb3I6IE5vbi1SQ1UgbG9jYWwgc29mdGlycSB3b3JrIGlzIHBlbmRp
bmcsIGhhbmRsZXIgIzA4ISEhDQpbwqAgMTU2LjEyMzg5MF0gbW1jMDogVGltZW91dCB3YWl0aW5n
IGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuDQpbwqAgMTU2LjEyOTMxOF0gbW1jMDogc2RoY2k6ID09
PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQpbwqAgMTU2LjEzNTc2
NF0gbW1jMDogc2RoY2k6IFN5cyBhZGRyOsKgIDB4NGNlZjE0MDAgfCBWZXJzaW9uOsKgIDB4MDAw
MDAwMDINClvCoCAxNTYuMTQyMjExXSBtbWMwOiBzZGhjaTogQmxrIHNpemU6wqAgMHgwMDAwMDE3
MCB8IEJsayBjbnQ6wqAgMHgwMDAwMDAwMQ0KW8KgIDE1Ni4xNDg2NTVdIG1tYzA6IHNkaGNpOiBB
cmd1bWVudDrCoCAweDE0MDAwMTcwIHwgVHJuIG1vZGU6IDB4MDAwMDAwMTMNClvCoCAxNTYuMTU1
MTAyXSBtbWMwOiBzZGhjaTogUHJlc2VudDrCoMKgIDB4MDFkODhhMGEgfCBIb3N0IGN0bDogMHgw
MDAwMDAxMw0KW8KgIDE1Ni4xNjE1NDddIG1tYzA6IHNkaGNpOiBQb3dlcjrCoMKgwqDCoCAweDAw
MDAwMDAyIHwgQmxrIGdhcDrCoCAweDAwMDAwMDgwDQpbwqAgMTU2LjE2Nzk5Ml0gbW1jMDogc2Ro
Y2k6IFdha2UtdXA6wqDCoCAweDAwMDAwMDA4IHwgQ2xvY2s6wqDCoMKgIDB4MDAwMDAwM2YNClvC
oCAxNTYuMTc0NDM4XSBtbWMwOiBzZGhjaTogVGltZW91dDrCoMKgIDB4MDAwMDAwOGYgfCBJbnQg
c3RhdDogMHgwMDAwMDAwMA0KW8KgIDE1Ni4xODA4ODNdIG1tYzA6IHNkaGNpOiBJbnQgZW5hYjrC
oCAweDEwN2YxMDBiIHwgU2lnIGVuYWI6IDB4MTA3ZjEwMGINClvCoCAxNTYuMTg3MzMwXSBtbWMw
OiBzZGhjaTogQUNtZCBzdGF0OiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAwMDA1MDINClvC
oCAxNTYuMTkzNzc2XSBtbWMwOiBzZGhjaTogQ2FwczrCoMKgwqDCoMKgIDB4MDdlYjAwMDAgfCBD
YXBzXzE6wqDCoCAweDAwMDBiNDA3DQpbwqAgMTU2LjIwMDIyM10gbW1jMDogc2RoY2k6IENtZDrC
oMKgwqDCoMKgwqAgMHgwMDAwMzUzYSB8IE1heCBjdXJyOiAweDAwZmZmZmZmDQpbwqAgMTU2LjIw
NjY2OV0gbW1jMDogc2RoY2k6IFJlc3BbMF06wqDCoCAweDAwMDAxMDAwIHwgUmVzcFsxXTrCoCAw
eDAwMDAwMDAwDQpbwqAgMTU2LjIxMzExM10gbW1jMDogc2RoY2k6IFJlc3BbMl06wqDCoCAweDAw
MDAwMDAwIHwgUmVzcFszXTrCoCAweDAwMDAwMDAwDQpbwqAgMTU2LjIxOTU1N10gbW1jMDogc2Ro
Y2k6IEhvc3QgY3RsMjogMHgwMDAwMDAwMA0KW8KgIDE1Ni4yMjQwMDVdIG1tYzA6IHNkaGNpOiBB
RE1BIEVycjrCoCAweDAwMDAwMDA3IHwgQURNQSBQdHI6IDB4NDA4ODEyMDANClvCoCAxNTYuMjMw
NDUwXSBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6ID09PT09PT09PSBFU0RIQyBJTVggREVCVUcgU1RB
VFVTIERVTVAgPT09PT09PT09DQpbwqAgMTU2LjIzODAyNF0gbW1jMDogc2RoY2ktZXNkaGMtaW14
OiBjbWQgZGVidWcgc3RhdHVzOsKgIDB4MzEwMA0KW8KgIDE1Ni4yNDM2ODddIG1tYzA6IHNkaGNp
LWVzZGhjLWlteDogZGF0YSBkZWJ1ZyBzdGF0dXM6wqAgMHgzMjAwDQpbwqAgMTU2LjI0OTQzOF0g
bW1jMDogc2RoY2ktZXNkaGMtaW14OiB0cmFucyBkZWJ1ZyBzdGF0dXM6wqAgMHgzMzAwDQpbwqAg
MTU2LjI1NTI3Nl0gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBkbWEgZGVidWcgc3RhdHVzOsKgIDB4
MzQwMA0KW8KgIDE1Ni4yNjA5MzhdIG1tYzA6IHNkaGNpLWVzZGhjLWlteDogYWRtYSBkZWJ1ZyBz
dGF0dXM6wqAgMHgzNWI0DQpbwqAgMTU2LjI2NjY5MF0gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBm
aWZvIGRlYnVnIHN0YXR1czrCoCAweDM2MTANClvCoCAxNTYuMjcyNDM5XSBtbWMwOiBzZGhjaS1l
c2RoYy1pbXg6IGFzeW5jIGZpZm8gZGVidWcgc3RhdHVzOsKgIDB4Mzc1MQ0KW8KgIDE1Ni4yNzg3
MTBdIG1tYzA6IHNkaGNpOiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KW8KgIDE1Ni4yODczNTJdIHdpbGMxMDAwX3NkaW8gbW1jMDowMDAxOjE6IHdpbGNfc2Rp
b19jbWQ1My4uZmFpbGVkLCBlcnIoLTExMCkNClvCoCAxNTYuMjk0MTc3XSB3aWxjMTAwMF9zZGlv
IG1tYzA6MDAwMToxOiBGYWlsZWQgY21kNTMgWzBdLCBieXRlcyByZWFkLi4uDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KV2UgYXJlIHVzaW5nIGtlcm5lbCA1LjE1IGFu
ZCB0aGUgcHJvYmxlbSByZXByb2R1Y2VzIGFmdGVyIGEgNS0xNSBzZWNvbmRzIG9mIGVhY2ggZmls
ZSB0cmFuc2Zlci4gRm9yIGEgdGVzdGluZyBwdXJwb3NlcyB3ZSBjb21waWxlZCB2Ni45LXJjNSBh
bmQgd2l0aCBhIG5ld2VyIGtlcm5lbCB0aGUgaXNzdWUgb25seSBvY2N1cnMgZnJvbSB0aW1lIHRv
IHRpbWUuIEFib3V0IDMgb3V0IG9mIDEwIHRyYW5zZmVycyBzaG93IHRoZSBzYW1lIGVycm9ycyBp
biB0aGUga2VybmVsIGxvZy4NCg0KSW4gYWRkaXRpb246DQotIFdlIGRvIG5vdCB0aGluayB0aGlz
IGlzc3VlIGlzIHJlbGF0ZWQgdG8gdGhlIEZXIHVzZWQgaW4gdGhlIFdJTEMxMDAwLiBXZSB0ZXN0
ZWQgZGlmZmVyZW50IHZlcnNpb25zIChpbmNsdWRpbmcgdGhlIGxhdGVzdCBmcm9tIHRoZSBvZmZp
Y2lhbCBGVyByZXBvc2l0b3J5KSBhbmQgYWxsIHNob3dlZCB0aGUgc2FtZSByZXN1bHRzOw0KLSBX
ZSB0cmllZCB0dXJuaW5nIG9mZiBQb3dlciBTYXZpbmcgbW9kZSwgYnV0IGl0IGRvZXNuJ3QgY2hh
bmdlIGFueXRoaW5nLsKgwqDCoMKgwqDCoCDCoA0KDQpBcmUgeW91IGF3YXJlIG9mIHRoaXMgaXNz
dWU/IERvIHlvdSBoYXZlIGlkZWFzL3RpcHMgaG93IHRvIGRlYnVnL3NvbHZlIHRoaXMgaXNzdWU/
DQoNCkJlc3QgcmVnYXJkcywNCktpcmlsbA0K

