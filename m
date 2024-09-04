Return-Path: <linux-wireless+bounces-12499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D596C4F4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5051C250FC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96E1DA31D;
	Wed,  4 Sep 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qe9Yzk36"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B787537F8
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469763; cv=fail; b=qnyOoHCdsl8VLNL8GrQcwcqpHXYtxQE4a8wl9RDFnzxoa8L3qWW/xtKn2xRtuZI6LAgSVLPM+HYIA+NlI3H8YSFXgj5dK6wkxTmONlIN9k6Skky2Kr4iElHqErBE6I9ab9jjuiP/ET7QI/pBYGp927RFrXCxhxknXR+nhL7g1Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469763; c=relaxed/simple;
	bh=w+MkpzLcWkmFLiVata3f8NVVvpUT00kW2uoXHR3Db80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBKMLLAuSAjUdD67vq05/AYYgeJUOhPhwU3VefDT8wDnXTX1y7XxWWNMvRhotx/gc73zrnyqr9HF6BJJtrIPSI5Szej0iHTXc8ZNyzdpmvlevjklwLixVtm7eqATpXLk/bL5UAl/XOfKdYo2ZBY0VYN1GX2V6gxTARJBxAB/JpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qe9Yzk36; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPn48foY2efDJ1JzlYxu/pldRd59z3o2HRkqpesFWf+l56gnrExamaAs0TmI60uZSeeLPWntQ4JXPepBz7hdOSynLx0WbzIivCywxksCpEnmFSedK1jKWBdkCcmL/L3T+TydU6iPBGiVvmZV8zQCp9RAzQCITxPjvb87/6LzEmQakoTMUR4iEcP9rKeKXQvR4tD1URS4rh9jzleQE8hwZMP69MgVnoGrMHMkqO3J9soEBYV7EVIWA+GPENZCZcpTXW/N5L5O/mdqzLF0uWIAE0nqMHJXTBUPpktJi4obBnfPYehxCIHp/kQdZ00KcZids7bcP4aUSLfrAxBLrM8iPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+MkpzLcWkmFLiVata3f8NVVvpUT00kW2uoXHR3Db80=;
 b=F9m4cKtwV6OIqi/8O6NCE1tw/3VbLdpwbkL39AtOrUOXe4CswZhPlJI6mg+lZB6KF5DG/8xwBlvR9W1Jpwi0GnAcmFByCvJKfljS1foocha2lZ+RKg0JoDsJ9f8NmRMjZU5V0tsCKLMpgeFQA7NaiqjnAAokObNZ1YRwMLqP/WnyPO6CsN3+1QsRbdm6rzTyHYttsqCNhb6uIbRD0jkDkjFQU8jXKZk5uvOcIb7FrQgq/IF3pV1th2Y5D4ydY2aOughupAGStEGjQD76apHW2s9cha0MxZVpxUyeEF7TbB+s2I9jMsQez4DlIQA4g5nzeg+AmB0VFZbIYCg/MGsxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+MkpzLcWkmFLiVata3f8NVVvpUT00kW2uoXHR3Db80=;
 b=Qe9Yzk36EThY1d887ZMHtkpjQtqO34pW9kjPXpa8qGeR/KFEX4bJbgoT6wXOJd9yf//qYR+UAGxMVAGgYyifgnqPlXPRNvN9VLPw79nNc72dkOD2Gnnzp7upOa3Wkav0PFLt8cQycAF+RBaRuUoHP45LNqBW59isL/NGd6Bw+H80Lz3XykBk6RATEbYf0ZksL8oENZDMDI4jxuXFAQz/uBXyHmJpuvjuM4PtBgyrU5ejPBqhHQJpZpb85WRxKCtUalGIFE5sXmxguZYcFYq413HI0Y2AphmaZ0eHycO/gpjv2skrHOq9KlqHv83jFKBs4DVwJ2EQGij5DfEJg5lZHw==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 17:09:18 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:09:18 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <alexis.lothore@bootlin.com>,
	<linux-wireless@vger.kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Topic: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Index:
 AQHa8/lbON6r1hV5EkW52mJu7NaXnrI65e6AgABbhoCAARI4gIABLp2AgAAQ4ICAADPfAIAAo+4AgAJ4lICAAQsjAIAGA7oA
Date: Wed, 4 Sep 2024 17:09:18 +0000
Message-ID: <d8f9380c-cd11-4c55-800e-25a181c10dc1@microchip.com>
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
 <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
 <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de>
 <2bbdc690-aec5-4a11-893e-01270c6d5b84@microchip.com>
 <302ea6b5-1625-4d4c-8866-c8c35f489fbb@denx.de>
In-Reply-To: <302ea6b5-1625-4d4c-8866-c8c35f489fbb@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CO1PR11MB5123:EE_
x-ms-office365-filtering-correlation-id: aed25cac-182d-46a1-7b82-08dccd044fe5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ME9EOEwzY3dxdUxpV3dOUXM4V1UvV1RJTy92ODlkdXVlT2tiSy8rbThKR3E5?=
 =?utf-8?B?TVlvREFzVnlldVZ2ZzdnN0VyN1kwZnlTVitidHR6R1Bta0JPZk9qeW9RYlRp?=
 =?utf-8?B?TzRZNlJwbngwOWVwS0d3ZzVBUTFXcUFSSjc5TSttbk4yNUJhVEhuOVROSFJ5?=
 =?utf-8?B?aU5DM2IwNHVOeUs2NjZIVTFsb3QzTUtaTjdEUFZZcmIzNkFjS0EwRnlwV0gx?=
 =?utf-8?B?VkR0WDlZTzNKTkVKeDA3VFlNdnpzdVBFUjJOcGV3ZmFmVTdYL3RubTJWMGU0?=
 =?utf-8?B?NFN4VytrV1lpTm1ZcUsyS2RtdE1Bbzd3UVl2TWtoc2w2K2lkK0VHb2t0bldR?=
 =?utf-8?B?Qk1peXhjRUF6ZjR5MnVlSmF6N1o0M2t2NzBDRVlCOTJ0alFyRlVKRnNybEx6?=
 =?utf-8?B?UlVHeU9xVG9va0lyRkVacnFOQ3VlTHJTajRJdWJQWWVMUUxSRFdOY05DTUhs?=
 =?utf-8?B?YlovcU9pdEJLVmZEMWQvcXhmQTJZVzRBQVQ4d0d4ajE1cFJMZ0Jrc2hsbTUw?=
 =?utf-8?B?aGl6ejBWejFlUjMrL0tzUHhQQ3BZZThzbHF5U3NBWitVNmhLaWREMFZFZHZy?=
 =?utf-8?B?U1paWUFQR2VTNnZHV25ndUFYTUQ5US9CelgybEZaZnA0RnNqNm1HMkNmNXdK?=
 =?utf-8?B?Z1R2R2Y3Rzd1Y2wyK3Z0ZmNDZCszWmhRZ1JmeFhtelo5VDRydTNyRkJVM0hO?=
 =?utf-8?B?WGhCdHlhYVU2dDhDSGI0V1NYbjFaMm5YWi9vN0FvY3E5VC95aXVzVmZHWHBq?=
 =?utf-8?B?WHNCeFpjZXhVQktZb1VPM25mRFJFWUp0NWR4aFRLWDVQQ0JyTlYyOHRKQm1n?=
 =?utf-8?B?ekoxaXRsTnVFdmVxbWpqRTZpck50K1cyM3lSZTVQQkdzcnc4RW9MZ2paY21z?=
 =?utf-8?B?eWVNWmF2Y1I0dU1GclFucVJrLzEzR3puR0NTYVFBWEJseTNzWTRXNnFGais2?=
 =?utf-8?B?RkhXaXRQVU85OFIxampzcWlIYUorcmVHNTV1V2pVYnNyZ0hJMTVGQVJ0WUFw?=
 =?utf-8?B?Nk5KSFlHakVTTWg3bWdSNTFuRkxudVpSTkExOElEUWRVNjkxc2dDajdqcmpq?=
 =?utf-8?B?UVJSTmp1N3hiWmI4RUtnNE10Wm5yNFBNWjZWRVk4Q0ZjdWNvNXBaTEErL2hS?=
 =?utf-8?B?YThpbHpYSEJVWVpNYkxYeW9hV21PeTFDSEV5OFBoTVB1TFVkNDhuNXlwQU1s?=
 =?utf-8?B?Q0dsZkxLZExLSDdHakg1ci9xSU9xSE9CMWtVcDhIbDVCbVhxSERQdTdreUcx?=
 =?utf-8?B?Wk1WUU91MFFFNHBlVFNweitmMFArWUp5eUFESUJnV0dZZWlMK0plMjc4cm5w?=
 =?utf-8?B?N1dhb3MzV1JaMUFSZnQ4a1RpcHExVmF4cnRPWkpwUnd5WFlVTVU4bE5VNDJ5?=
 =?utf-8?B?RTVSQ0NnYmt0ekN6MnJpRVVXcC9KRVNPbmtHZTU0S0JJS3FSeGlzZVp2Mnps?=
 =?utf-8?B?SjgydnVKR0ZKVzRnck1WMzd4SkJDTElQL2JKY25rV05ZSU5DUVlXQUVHd3ov?=
 =?utf-8?B?cm1FTlhCT3FPZUVSbDcxWWkxeDU1MnhYdldDeGFpVkdMWm9qOHBEdVRjMnMv?=
 =?utf-8?B?SmdkZVQ4TzB5dGhWTURQQys3emVlQzV4YWl6RW9yRUR2VndhMkErZTJwcCtx?=
 =?utf-8?B?THpIbDIvaThhdnp3MTFTL0pqLzlMbTRpajFUeHAyUkhjN1FZaGRLZnhjVHl5?=
 =?utf-8?B?ZklWU2VPc2Via2Y4WUxqdVhTWGZkMHd6dDBkbzBEVkZpeWhPSkQvdHpVREZT?=
 =?utf-8?B?M2JKUzVhV3NLTmRXczFOUVRMZjg3YzAwN0RCcEZOODZxV3gzSjdwb3ZGVFBN?=
 =?utf-8?B?dDhybFBwUFppVXBFdmg3dHY0U25YOUphRnRkZkM0MllFMWNTWTdtRXh6b0xE?=
 =?utf-8?B?cGhjZ2xPMmhUOVNReDVyS0Q5ZFpaYlIwc2x3OEowWDQ5bkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3VBNUpMdm55Z3JZbmlMUlpRb1ZhZno4OVkyY2NHdkdzbnZmZDJNOFRESTVt?=
 =?utf-8?B?VEd3bXlNeFplaVhMS3k2dTA0UVBwS3BlWGRrQ0c3Y1c0d0pwbjlZSnpYdlBP?=
 =?utf-8?B?eHNjb0ZtaU95bWZoQS9JRHRHUGZDekMxU3NPZXpMZ1JqeUJtMVFSRUVBMllj?=
 =?utf-8?B?eWhPT200ZXVlb05ZZTFWR2xaeElaK25jdmZ4bERKMXdYRjlhYmpObzlrWXBt?=
 =?utf-8?B?c1FUbVE1bXd3WjdUa3FoSXlCaExuK016Kzk3YjVhR3lFU3lhMzliN1VGRmd2?=
 =?utf-8?B?cmd3Mi83R3FPRVkwZ0xVSFBIYUtJcDBHZUQ0eHJaaE5PVU1QaUZOaGtCWUhx?=
 =?utf-8?B?Q0hnVENVc3h5V1ZJMm9udTVIM1VpcHRlOUNUa3hSU3B4Yy9SYzg4WDN6WFJ0?=
 =?utf-8?B?QmFNM2F0MDFnTHk5Z2ZjREtlRFB0ZmdOSGZJQmFsVDZ3Y3crbjBkZmRGbXBl?=
 =?utf-8?B?THdjcDFrMUxzSXVRbE5FNXlSVU9ZYWFtTGdUZmFLQ25qTFViSkpIUERzQ082?=
 =?utf-8?B?N3E3Wk5ZYjI3N0tlbHhCRVNiaEI1NG1hZTlQdDNXaXJPNkRkRC9nQ3RSdWpp?=
 =?utf-8?B?SjU5Mi9ReXZTakVWbXJMTng4TWU4am5XWmM0bm5nY3JRdk5iUlVVUWtjSmV6?=
 =?utf-8?B?NDJlL1VsNWVNOW5SeVhXbzlEQUhmN0NaNlZ4NjlsSHlVU0k5RFdKUkordml3?=
 =?utf-8?B?T1liQzF2MnVrL2ZSQ3BKSnBnK21NcEhlUVRZWEMxb1pmVHpWRDZXdDUzRURT?=
 =?utf-8?B?c0VCUC9WQ1lvaVZtNDB6VS9YdkNHNit4OW1TMGlwNmREc1NtekpOQVE2V2tF?=
 =?utf-8?B?ZVFpRDMyOC9iS1huN0c0ekR2RDU3YTU1di9uOWYreFcxUDNQYnpRSENtSXZO?=
 =?utf-8?B?KzEyT3pNMVN2dDB1RFNYRHlKMm9BczFCTE0xYXM0elZuUE51b0hXaVFjNmZa?=
 =?utf-8?B?VnFqUThMWEpVZXN3NURRK2ZCVXpjOEo5Rzk2Q01aeFQ5Z01RNTBONGhnT085?=
 =?utf-8?B?aGRDR0hzQktIejFhSjQxaVRVa3p5ZCtNWUxlNW5nNzdwQVdhZ3FKN2l5cnVn?=
 =?utf-8?B?TVJZcTV1b21QbGRWMW56bEpacnRKL2RTTk1TR3RpZ0t2Z2lQR3M3aFYwRGNu?=
 =?utf-8?B?ZXlKa3lXUm5XUXF1enBPT3FWSk9jQmJqVFNSV1pPTEtKY1YzZkhKbE9XZms1?=
 =?utf-8?B?Y29Ob0ZWTFFrKzdkSmg0cWQ5SmFLZkZOOGNsOG44VWlWZHVzVER2RGVpNjA5?=
 =?utf-8?B?aTdFOXUxbzJ2dmttUjBsL2VWR3krc3FrZ0JRSHJGbEdqRlBCQ0I4M2hDMXFa?=
 =?utf-8?B?ek0rS0IrcTJsbDVSWk1jYnpUOVhSVEUyNThJV1ZMZGE3UGw4OU1vQVhtZFpU?=
 =?utf-8?B?SlFZbi95eUJQV3QzMGdDZ1ZPbVJPZUUrcXQxWjZiU3pmUGltZVI0MXlNWVNy?=
 =?utf-8?B?N3RjKzNYcUoyQjhKakI2ZDZKUEd0T0dOazJhWkFWb1dRaERJRTBhRWdJU2M1?=
 =?utf-8?B?d1RHcnhQbUhmeWlSOWNNMUI4VkFpQy8vdXJjZFBybTVSdW1uWWtQQlpma3V2?=
 =?utf-8?B?NFVNaUltY0RueVVEbW9IZWphRmxNRU1UUk1xZUpUaVE5RGhHR1pnK2srYW9k?=
 =?utf-8?B?LzdweENsSEN2Vm1rUW1yc1ljRUY2eTR4UVBvZ1JxeUIrWi9oRjhneEJtdERF?=
 =?utf-8?B?WElxZ0VGT2FoUEpiUHZLSEs2OVhocFY5L1ZieVQrc1JaempKcFIyZnFGL0hj?=
 =?utf-8?B?MUlDY1ZxWno4UC9ndjIxeGZybnJMdDNpeFFZajg0TkU3bmlySUFOMG9XcGh6?=
 =?utf-8?B?VmE4Y0JxRm5mTU1zNmRhWkRGcU1TbHNYZEVNZk10Yk5yNmNJTlN4bExDSVZG?=
 =?utf-8?B?Q0RRMnJIeklaOUJQeUdLdUJGbDdmVzFMS0VkVGlTR1JFQ1VqVzlHLzZlWGRk?=
 =?utf-8?B?eG1YMHFhTXRWVWJ3SzRkVEh3Z1NTZWd0ZVdJOFEvVzQ0M1ZZM3ZYR1I2Sk9s?=
 =?utf-8?B?MWw5c2RySWJQVFVUbE9rOE1mamViRDZGWUtQRnZNL2FHT0lyUHZWL2IveEFT?=
 =?utf-8?B?aTArNkwwTG8zdGZ5K3pGZnRYUC9SY0tPa21XMU5IN2ZhZ2RUcndONHdMYi8w?=
 =?utf-8?Q?MkGp/zLD7QxpnNoTunZvMbxWV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D958222708644D8DAC5C5FD7931B1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed25cac-182d-46a1-7b82-08dccd044fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:09:18.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33bXMZPPnKRHHnlwxKHJAqQG18coBqkPihQ5JYAVtVpSgkwV/T9EyFNxkMu0QZtI6/NTqWcwDFgchao6zWBEt2qxEXGY6MG97o6q6dYtLZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123

T24gOC8zMS8yNCAxNDoxOCwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
DQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gOC8zMS8yNCA3OjIyIEFNLCBBamF5LkthdGhh
dEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGkgTWFyZWssDQo+IA0KPiBIaSwNCj4gDQo+Pj4+
IDIuIFdpdGggdGhpcyBwYXRjaCwgZG9lcyB0aGUgcGluZyB0byB0aGUgc3RhdGlvbiB3b3JrIGR1
cmluZyB0aGUgc3VzcGVuZA0KPj4+PiBzdGF0ZT8NCj4+Pg0KPj4+IEkgaGF2ZW4ndCB0ZXN0ZWQg
dGhpcywgYnV0IHRoYXQncyB1bmxpa2VseSBiZWNhdXNlIHRoZSBob3N0IGlzDQo+Pj4gc3VzcGVu
ZGVkLiBTdGlsbCwgdGhhdCdzIG5vdCByZWFsbHkgdGhlIHBvaW50IGhlcmUsIHRoZSBwb2ludCBp
cyB0aGF0DQo+Pj4gdGhlIHdob2xlIFdJTEMgZ2V0cyBwb3dlcmVkIG9mZiBkdXJpbmcgc3VzcGVu
ZC9yZXN1bWUgd2l0aG91dCB0aGlzDQo+Pj4gcGF0Y2guIEF0IGxlYXN0IG9uIFNUTTMyTVAxNXh4
IGl0IGlzLCBtYXliZSBvbiB0aGUgQXRtZWwgY29udHJvbGxlciBpdA0KPj4+IGlzIG5vdCwgYnV0
IHdlIGNhbm5vdCBkZXBlbmQgb24gdGhhdC4NCj4+DQo+PiBJbmRlZWQsIHlvdSBhcmUgcmlnaHQu
IEl0IHNlZW1zLCB0aGUgdGVzdCByZXN1bHRzIGhhdmUgZGVwZW5kZW5jeSBvbiB0aGUgaG9zdA0K
Pj4gY29udHJvbGxlciBwb3dlciBtYW5hZ2VtZW50IGJlaGF2aW9yLiBJbiBteSBzZXR1cCwgdGhl
IGNhcmQga2VlcCB0aGUgcG93ZXIsDQo+PiB3aGVuIHRoZSBob3N0IGlzIHN1c3BlbmRlZC4NCj4g
DQo+IFJpZ2h0LCBjdXJyZW50bHkgdGhlIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBjb250cm9sbGVy
IGJlaGF2aW9yIGFuZCBpdA0KPiB3b3JrcyBieSBhY2NpZGVudCB3aXRoIHRoZSBhdG1lbCBjb250
cm9sbGVyLiBUaGlzIHBhdGNoIGZpeGVzIHRoYXQgYW5kDQo+IGFzc3VyZXMgdGhpcyB3aWxsIHdv
cmsgb24gb3RoZXIgY29udHJvbGxlcnMgdG9vLg0KPiANCj4+Pj4gQUZBSVIsIGR1cmluZyBob3N0
IHN1c3BlbmQsIHRoZSBmaXJtd2FyZSBjb250aW51ZXMgdG8gcnVuIHdpdGhvdXQgcGFzc2luZw0K
Pj4+PiBmcmFtZXMgdG8gdGhlIGhvc3QgdW5sZXNzICd3b3dsYW4nIGlzIGVuYWJsZWQuDQo+Pj4+
DQo+Pj4+IFRoZXJlIGlzIGFub3RoZXIgc2NlbmFyaW8uIExldCdzIGFzc3VtZSBhIGhvc3QgdGhh
dCB3YW50cyB0byBnbyB0byBzdXNwZW5kDQo+Pj4+IChwb3dlciBzYXZlIG1vZGUpIHdpdGhvdXQg
Y2FyaW5nIGFib3V0IHRoZSBXaUZpIHN0YXR1cywgaS5lLiwgaXQgaXMgb2theSB0bw0KPj4+PiBy
ZWNvbm5lY3Qgd2l0aCB0aGUgQVAgaWYgcmVxdWlyZWQgKGFueXdheSwgdGhlIEFQIG1heSBkaXNj
b25uZWN0IHRoZSBzdGF0aW9uDQo+Pj4+IGJhc2VkIG9uIGluYWN0aXZpdHkgdGltZW91dCkgb3Ig
aGF2ZSB0byByZS10cmlnZ2VyIHRoZSBESENQIHJlcXVlc3QgYWdhaW4uDQo+Pj4+IEJ1dA0KPj4+
PiB3aXRoIHRoaXMgY2hhbmdlLCB0aGUgZHJpdmVyIHdvdWxkIGJsb2NrIHRoZSBob3N0IGZyb20g
ZW50ZXJpbmcgc3VzcGVuZCBtb2RlLg0KPj4+Pg0KPj4+PiBIb3cgYWJvdXQgYWRkaW5nIGFuICdp
ZicgY2hlY2sgZm9yIGhvc3QgcG1fY2FwcyBiZWZvcmUgY2FsbGluZw0KPj4+PiBzZGlvX3NldF9o
b3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9LRUVQX1BPV0VSKT8gSW4gdGhhdCBjYXNlLCBpdCB3
aWxsIG9ubHkNCj4+Pj4gcmVxdWVzdCB3aGVuIGNvbmZpZ3VyZWQgYnkgdGhlIGhvc3QgcGxhdGZv
cm0uDQo+Pj4NCj4+PiBTaW5jZSB0aGlzIGRyaXZlciBkb2VzIG5vdCByZWxvYWQgdGhlIGZpcm13
YXJlIGludG8gdGhlIGNhcmQgb24gcmVzdW1lLA0KPj4+IHRoZSBjYXJkIGhhcyB0byBiZSBrZXB0
IHBvd2VyZWQgb24gZHVyaW5nIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLiBUaGUgY2FyZA0KPj4+IGNh
biBOT1QgYmUgcG93ZXJlZCBvZmYgZHVyaW5nIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLCBvdGhlcndp
c2UgdGhlDQo+Pj4gZmlybXdhcmUgaXMgbG9zdC4NCj4+Pg0KPj4+IFdpdGhvdXQgdGhpcyBmbGFn
LCB0aGUgY2FyZCBtYXkgYmUgcG93ZXJlZCBvZmYgZHVyaW5nIHN1c3BlbmQvcmVzdW1lDQo+Pj4g
Y3ljbGUuIEl0IHBvc3NpYmx5IGRvZXMgbm90IGhhcHBlbiBvbiB0aGUgQXRtZWwgY29udHJvbGxl
ciwgYnV0IGl0IGRvZXMNCj4+PiBvbiB0aGUgU1RNMzJNUDE1eHggQVJNIE1NQ0kgb25lLg0KPj4+
DQo+PiB5ZXMsIGluIHRoZSBBdG1lbCBjb250cm9sbGVyLCBpdCBpcyBub3QgbmVjZXNzYXJ5IHRv
IHJlLXByb2dyYW0gdGhlIGZpcm13YXJlDQo+PiBvbiByZXN1bWUuDQo+IA0KPiBJdCBpcyBpZiB0
aGUgc2xvdCBnZXRzIHBvd2VyZWQgb2ZmIGFjcm9zcyBzdXNwZW5kL3Jlc3VtZSAuIEl0IGNvdWxk
IGJlDQo+IHRoYXQgdGhpcyBkb2VzIG5vdCBoYXBwZW4gb24gdGhlIGhhcmR3YXJlIHlvdSB1c2Ug
Zm9yIHRlc3RpbmcsIGJ1dCB0aGUNCj4gZHJpdmVyIGNhbm5vdCBkZXBlbmQgb24gdGhhdC4NCj4g
DQo+IFsuLi5dDQo+IA0KPj4+PiBJIHRoaW5rLCB0aGUgd2lsYyBmaXJtd2FyZSBzaG91bGQgcmVz
dW1lIGJ1dCB0aGUgY29ubmVjdGlvbiB3aXRoIEFQIG1heSBnZXQNCj4+Pj4gY2xvc2VkLiBBZGRp
dGlvbmFsIGNvbW1hbmRzIHRvIHNjYW4gYW5kIHJlY29ubmVjdCB3aXRoIEFQIG1heSBiZSByZXF1
aXJlZA0KPj4+PiB0aGF0DQo+Pj4+IHNob3VsZCB3b3JrIHdpdGhvdXQgZG93bmxvYWRpbmcgdGhl
IGZpcm13YXJlIHRvIHdpbGMgY2hpcCBhZ2Fpbi4NCj4+Pg0KPj4+IEN1cnJlbnRseSwgdGhlIHNs
b3QgbWF5IGdldCBwb3dlcmVkIG9mZiBhbmQgdGhlbiB0aGVyZSBpcyBubyBmaXJtd2FyZS4NCj4+
DQo+PiBDdXJyZW50bHksIGRyaXZlciBkb2Vzbid0IHN1cHBvcnQgcmUtcHJvZ3JhbW1pbmcgb2Yg
dGhlIGNoaXAgd2hlbiB0aGUgaG9zdA0KPj4gcmVzdW1lcy4NCj4gDQo+IFRoZXJlZm9yZSwgdGhl
IHNsb3QgTVVTVCBzdGF5IHBvd2VyZWQgb24gYWNyb3NzIHN1c3BlbmQvcmVzdW1lLg0KDQo+PiBI
YXZpbmcgdGhhdCBzdXBwb3J0IHdvdWxkIGFsbG93IGJvdGggdHlwZXMgb2YgaG9zdHMgdG8gc3Vz
cGVuZC9yZXN1bWUuDQo+PiBBZGRlZCBjaGFuZ2VzIHRvIGRvd25sb2FkIHRoZSBmaXJtd2FyZSBh
c3luY2hyb25vdXNseSBvbiByZXN1bWUgYW5kIGl0IGlzDQo+PiBpbmNsdWRlZCBpbiB0aGUgYXR0
YWNoZWQgcGF0Y2guIEl0IGlzIGJhc2VkIG9uIHRoZSBsYXRlc3QgJ2Zvci1uZXh0JyBicmFuY2gu
IEkNCj4+IHdhcyBub3QgYWJsZSB0byB0ZXN0IGl0IGZvciB0aGUgc3VzcGVuZCBzY2VuYXJpbyB3
aXRob3V0IHBvd2VyaW5nIHRoZSBjYXJkLiBJZg0KPj4gcG9zc2libGUsIGNvdWxkIHlvdSBwbGVh
c2UgdHJ5IHRoaXMgcGF0Y2ggaW4geW91ciBzZXR1cC4NCj4+DQo+PiBJbmNhc2UsIHRoZXJlIGlz
IG5vIGltcHJvdmVtZW50IHdpdGggdGhlIGF0dGFjaGVkIHBhdGNoIHRoZW4gSU1PLCB5b3VyIHBh
dGNoDQo+PiBsb29rcyBzYWZlIHRvIGtlZXAgdGhlIE1NQ19QTV9LRUVQX1BPV0VSIHN0YXRlIHNp
bmNlIGhvc3QgcmVzdW1lIG1heSBub3Qgd29yaw0KPj4gd2l0aG91dCB0aGUgY2FyZCBwb3dlcmVk
LW9uIGFueXdheS4NCj4gDQo+IEkgdGhpbmsgdGhlIGF0dGFjaGVkIHBhdGNoIGlzIGEgbmV3IGZl
YXR1cmUsIHRoaXMgcGF0Y2ggaXMgYSBmaXggZm9yDQo+IGV4aXN0aW5nIGJ1Zy4gUGxlYXNlIHN1
Ym1pdCB0aGUgYXR0YWNoZWQgcGF0Y2ggcHJvcGVybHksIHNvIGl0IGNhbiBnZXQNCj4gcHJvcGVy
IHJldmlldyBvbiB0aGUgTUwuDQoNCkkgYmVsaWV2ZSB5b3VyIHBhdGNoIGFkZHJlc3NlcyB0aGUg
aG9zdCBzdXNwZW5kL3Jlc3VtZSBzY2VuYXJpbyB1bnRpbCB0aGUNCmRyaXZlciBpbmNsdWRlcyBz
dXBwb3J0IHRvIHJlLWRvd25sb2FkIHRoZSBmaXJtd2FyZS4NCg0KQmVmb3JlIHN1Ym1pdHRpbmcg
dGhlIG5ldyBwYXRjaCB0byBNTCBmb3IgcmUtZG93bmxvYWQgb24gcmVzdW1lLCBJIG11c3QgdGVz
dA0KaXQgd2l0aCB0aGUgZXhhY3Qgc2V0dXAgdG8gY29uZmlybSBpZiBpdCByZWFsbHkgcmVzb2x2
ZXMgdGhlIGlzc3VlLiBJIHRlc3RlZA0KdGhlIHBhdGNoIGJ5IGZvcmNpbmcgdGhlIHJlLWRvd25s
b2FkIGluIHJlc3VtZSwgYnV0IGl0IHdhcyBub3QgYW4gZXhhY3QNCnNjZW5hcmlvIGJlY2F1c2Ug
dGhlIHdpbGMgY2hpcCB3YXMgbm90IGVudGlyZWx5IHBvd2VyZWQgZG93biBkdXJpbmcgaG9zdA0K
c3VzcGVuZCBpbiBteSBzZXR1cC4gSSB3aWxsIGNoZWNrIGlmIGEgc2ltaWxhciBzZXR1cCBjYW4g
YmUgYXJyYW5nZWQgdG8gdGVzdA0KdGhpcyBzY2VuYXJpbyBiZWZvcmUgc3VibWl0dGluZyBpdCB0
byBNTC4NCg0KUmVnYXJkcywNCkFqYXkNCg0K

