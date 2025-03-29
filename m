Return-Path: <linux-wireless+bounces-20943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0592A75598
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DA83A574D
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EB17B402;
	Sat, 29 Mar 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dirac.com header.i=@dirac.com header.b="WOVVY2QM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2130.outbound.protection.outlook.com [40.107.105.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71D3597B
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241791; cv=fail; b=t2GxGWWBtMYpMqSzlCNwY3rKmOLtnB5v213cU37Hzy7k8ihk+uJSY37JBxzGCy8rGVDSwaR6qkVQGfObsCIr6Zd/PGb6Jqm0vOFOtIJPDSgSNxzLBsBVhYJfjY2+JOBZN0M3ZgG83hJEOwuyCkPBK6t7lG8sOjvlTUPf3kLUsDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241791; c=relaxed/simple;
	bh=itcQzlf0Ar+62136dJBakyq0ClINmrU3ldai+TAWEcw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=saJad0wUjskWLlkhLLZa59qm9N/jKDJstTTuDdcSRIGutnpvPBDuyYVJCYpSCTxWHIJo8D4w/CW0lf1XM1HqsB80JdHZFGLyEOM0+IdV1wLcTOY2IsRsO+tBjZStdTSTJbPPA/NruKr5RylAYknV4zSM2HqDCSd23btQ9ZWMugs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirac.com; spf=pass smtp.mailfrom=dirac.com; dkim=pass (2048-bit key) header.d=dirac.com header.i=@dirac.com header.b=WOVVY2QM; arc=fail smtp.client-ip=40.107.105.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirac.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBifdY4M2JUeandCHmF+BtExyr4cyzTipC34lTjS78CGkEUMGDhjWZI3XMkDTl/9fwPfHmW22PLyf456QDYwkodk9k8TPRO/Eh8J1t6cLgMgXonMTWS2cw3bLDb6/cQ/u/tMRpwy3BXFZWlK2lGPH+SdA+37lOdIzZkc/9yjYKA3HUz/ji6xktgDWtvuTlMTQRpqlOifJEFkL/As9GSh20KHcLYcwqcK8d6d/qyJPydpvX0JoKAn7D3/j9jRNrlvOEXGLXQ1gdywmXCKs7kYeMEP4cyXCf2ljfpZVI3lEIPYhRxECfHkzfP2HGn8FR8acv+4pnIw3gTIFWRlebBSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itcQzlf0Ar+62136dJBakyq0ClINmrU3ldai+TAWEcw=;
 b=iMT9mMi290RR4buMA5S2uV0gGAxXiyYNVLXOg6BGzr38upSgCiBRE4jI9cxCsBZNlwi7EbMKFqE6kfum/k5tkM2cPU3DXyFytKIEkv45pBebIPFXDDuRLXhc9dxyatFcvSomT4L2MfdZypXmOzEW2ZPIALk92HttO9jjPFRvZlH+BQlHM0ibA3+rVh3LovnbGHbr2m6dGBYIhQZZr0sMIgiPcFowiGEmrFdkUu2P9vmqb4WJBkUWVFydNZFKotVgnDIJrYI/NXpHuRDIjiOFQZv0YydUVBtB/k8xdAkcOe6gvu28sfLa1XtOVQr+AqD78yqFzKZ6chcGN7Vdrx6gtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dirac.com; dmarc=pass action=none header.from=dirac.com;
 dkim=pass header.d=dirac.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dirac.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itcQzlf0Ar+62136dJBakyq0ClINmrU3ldai+TAWEcw=;
 b=WOVVY2QM9C7MzbY06OWK8CEvJMKvqAyvuGLyIMT6j+f9vau42MD0OZ4tFEn3/ato+RgcBoqPLq+3ESL9m/FwhYke4qjxLAnTxS15yOeAY6qr+N66ZKBPTI3UNIHNTVFYGZgzp06OVPJcIuKvqng4YBIdH+5C8L11mNl+T5aEleMQqtKcu9mUq29+5RCLC55A+lDcgjSmkFgX0mZKKCT9FGD0NhnVsTH8nvsPu/XKC/3OMjT39nTQ735scfvGqWkImAPUE5lPVZnMKs7rhrYWD8jKZYd+pX8v01IyAIPXD1ct94uf1J5UNcFclfeh/uNVIlqoVupJ/KYsMQsfiCykXw==
Received: from AS8SPRMB0006.eurprd02.prod.outlook.com (2603:10a6:20b:440::21)
 by DU0PR02MB8167.eurprd02.prod.outlook.com (2603:10a6:10:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sat, 29 Mar
 2025 09:49:46 +0000
Received: from AS8SPRMB0006.eurprd02.prod.outlook.com
 ([fe80::7141:fd99:7825:f67e]) by AS8SPRMB0006.eurprd02.prod.outlook.com
 ([fe80::7141:fd99:7825:f67e%5]) with mapi id 15.20.8534.043; Sat, 29 Mar 2025
 09:49:46 +0000
From: Robert Bielik <Robert.Bielik@dirac.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Beacon frame missing TSF timestamp (local looped back)
Thread-Topic: Beacon frame missing TSF timestamp (local looped back)
Thread-Index: Adugjpi4DzyOix0wT5ePV5sdaX5sGQ==
Date: Sat, 29 Mar 2025 09:49:46 +0000
Message-ID:
 <AS8SPRMB000636F570809E9698B9CF2DFAA32@AS8SPRMB0006.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dirac.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8SPRMB0006:EE_|DU0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: 4b99fc73-16c6-4e96-5581-08dd6ea709e1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTRNTWVJckg4aThuR1hZSUdzbnFFQXpHNm1udnltaGdjMXNWNGJ4cG45Qm5T?=
 =?utf-8?B?cUt5VFE2MVlpdEx2eWtkY1FhQnJ6ZHdYVTdrdzE4YWtheVhpSFc2YWdTZXBX?=
 =?utf-8?B?WGlDYU5zaktvNHFhSXU1TjRFaXVKWURaVWErQVNxOXZCM3BXVUhSQUJjTCtt?=
 =?utf-8?B?RmlWbUdqbFBCL0E4ZjdwTWgvVFVUTzVHeU9NK0ZuL0hMUno3RWNmbDlTVGc1?=
 =?utf-8?B?MERUaXdjYkx4SmhjdUZTUlI3dG5OOGFzb0g5RTVEckFxTzdxa2hSdDRFdTdm?=
 =?utf-8?B?dm92QUVMRlppbG1WNWFQdlJ2UzhmaWU5VUpyYkN5cU5UUDJibytUZVFMbWc1?=
 =?utf-8?B?a2g2cHYyS2w4NFdTb2ZJczk1NDdHK2FDS2YyV0wwb1A0SU4rbTFtbUJhb2ho?=
 =?utf-8?B?QlZxMDBsMWp3dHh3NWp5VEd0U0xZaUtlUDFSeFdwdnZBdmVsVjZ5UVE4L1Vs?=
 =?utf-8?B?QjYrc09jYVIxemlnRXRQQlN5YTRUQUxrL3V6cG5zV0tZTnAraGRYdjB3Z0da?=
 =?utf-8?B?NVRWeStONFM4Qm9mZkVkZTBVR3pmNGp4ZlhjMk11Zms4c29vYWc3SkV5R1dv?=
 =?utf-8?B?b0lCQVhNdm1nR0JhY3pLV1BVUE45ODJ1dFZsRU9kRU43Y2x2M09yRVJsZVBK?=
 =?utf-8?B?elJZNVdlUVVPbUgvWlBpd1N4b0c4MWJlSWxSL3hUbnJycXVJQjgyblRKNmFp?=
 =?utf-8?B?clR1cGVLZVpacHlVUEUvVUxocXhNWEQ0Z2J2N0hiSHRhOFN3aHFzODhNSFRF?=
 =?utf-8?B?ajVtckJLKzJwbjJ3Q0UvWXUvUG9kVWJHNE9aY0VKeVNtcG9YaWM2cXdXcGxG?=
 =?utf-8?B?RDhyR28zMnZUanpLUGx4djRVcG15VDJ3cG1MZVJsd3Zmd0xXUVNqWnBVdmJK?=
 =?utf-8?B?SHdLVDBhcVo3SU1GMFRaYWZybnNLN3A5cDljVjNaQ3Qwdy9YeU9TTmtnd25x?=
 =?utf-8?B?NUtBUmhrcGJKVmhwTVFadm55aEJZUzhkR0xCejloWjJhaHFsa0tXSDB3TW9P?=
 =?utf-8?B?UzFkMWNmOEJmbHVKL256V0gzbVdzcENxYkZKUXhSVkJTWTVvNUJKdFllMTNZ?=
 =?utf-8?B?cnFCdDUxN0JwN3czV0Y5QnlCcEdQcHNuRFFSL3VpZkV0VzcybE1kREdnRU9q?=
 =?utf-8?B?aGJCemdoZUhDSEZQZFFGbU5kaTVPNFBFamlmYkpNUjFoZk1LUmNLWkxicExR?=
 =?utf-8?B?WWhORW84STVpTndxeHJ4aXcxazVQOTVTTGNoazIwNFJwcHRsa2hhM1Q1bEkz?=
 =?utf-8?B?Rm85U1RlS2VRQk4xdHBlUi9xaG9ueHdIOVRoSEhqM1FydTcyQkJlQ1lvSS9Y?=
 =?utf-8?B?Z0dMZTFDdURaZDI3MTFvOXlOYUh2V3dWWEs2eDJ6N3d2WHJ4K2hmblNLOGEz?=
 =?utf-8?B?S250Wll2TEVFNXFrSGJhZUF3T0wwWGdDcmptOEJiand1R21wZXZ0SjJMR1VE?=
 =?utf-8?B?Q2U4Ti95cDd0TDI5ODRpZmU2VWg0MFJPSnB5STdHOENXbHVKMjlLam1OVnpC?=
 =?utf-8?B?UUJjWkViaHplc1NQWWRreDd2SGpUNnZZK3BJTzRab1VNYWlVcnpZR2ZzNzVo?=
 =?utf-8?B?MVNmaDJ1amxLM3QxaWpOb3Fnby9pcWdIMlVWRDladjFHOHpKR2FOOUc4WmJh?=
 =?utf-8?B?UWhXZVpWVzM5VlF0YmR1b3dpYjZqTEF2VHhLTWJ3czZBbW1VczEwZ0tRS1Ny?=
 =?utf-8?B?WVhybCtxTW1od0ZYQUNEeXlWS0dhYVlxS09jM1AvQnc3cFJvZEdZRUpiVkg2?=
 =?utf-8?B?L1JIc0xFMjJKR0UyNEJBVmgwSDc2TGs3anluWW02aU0velNpbk54T1JjY2hN?=
 =?utf-8?B?NWNyOTFJbzhLRlhUaG01MzhmMDJkSFhldmo1emRNNU5wbml0RERuU2RGQitL?=
 =?utf-8?B?VUdlR0c5QWFVMDJBaTl3amFxUDVyU2QyMWd1dFczSDJSTGpiZGJjY21MaEhp?=
 =?utf-8?Q?0WxcyeW2MVFEyN+1rpio5pXWFPZ9Fbdj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8SPRMB0006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXhqKzlVZ0tZU0h1bDZpOHpNeDVZNjhzdkE0cDZSenljL0l5UzVWaGtRZW5S?=
 =?utf-8?B?TXdybjl3Tldqdm4rdE9nTGgyZzE4Y3pWQ3p3UmlqcDFXZDRSMldyT1ZtT0Js?=
 =?utf-8?B?dmpUbWJxVWJjY0s1NXJlNDFTMlpLRzZkMkxQV1NNZERhTWJUMkFiWHQ3Sm1n?=
 =?utf-8?B?Wk5Za21ISXQ1dENERitMZzROSUVJTkhsZ0tZTy9DR1pGOUtWRzBhZ0VCU2RL?=
 =?utf-8?B?QTVhMVJpVE9CdUt1bldIR2g5RzZoQTdwZTAySkk5aU1qZ2drREZDWjR1aExN?=
 =?utf-8?B?Z0FTSzVudzUxdURpR0F1aGF4T2xETWs4SURJTjBkZGx2WDJEVzhqdmtZcU1W?=
 =?utf-8?B?M0pLKzUrSWk5VW5BQlk1emJ2OWJCS2l3UE45SmxaL1BUVWxMZ1dxNG9FcUV5?=
 =?utf-8?B?b0JaaVRaWjNkL0l5a0JKL2FROXJTZVBKQUhpRzE5ZXdtNjh0ZkozNjRZT3Js?=
 =?utf-8?B?SWs2dS9uZWNQSlVsM0kzajZVWXRUbFdqS0QvQVhzQ0t1T3dOSkRJdy9wdTZi?=
 =?utf-8?B?RExGcS91NFdEcm1MRkdHYm00K3JRZW16Q2FvMnY5cmZmaS8rTXZSNEJXUVho?=
 =?utf-8?B?SjRLUFdNKzhiZTB1TnRFYXlINGNWN0NhU0ExRGM3RlFaTVIyc1dDYWNoR2l3?=
 =?utf-8?B?cmdGamtvRHNRQVV3U3RNTTVudnRjVGlQTE5iYkdSZW9Rc29JNjAralcrVWZR?=
 =?utf-8?B?NDljeEVLYk1WbWtpcHNBU01PUlJPU2lLcU5ZNTdHS3BlcHJraktSKzZ5NTY3?=
 =?utf-8?B?WTZiUGJhOFZFY2F1cU1uekFZTnozWWdaSUU4a0ZST1A4dURHWjFWNUUvN2NK?=
 =?utf-8?B?Wjk4cDVsMmJyZ2tRdk82NVNjVjlBRjlVN0NiMjFhYmpScm1BVlo3SDNxbWI5?=
 =?utf-8?B?L1ViWjhqcXVoa0xTS2p3U3kzUjU3SjJNUGxqZWIwekRIUHlHV1Njc3pId2Zy?=
 =?utf-8?B?WHd1L0lzQW9zdVhSUWxodGhreDF3QlVYUzBJNUtOSThOLy84Wmw2aVBLN3lI?=
 =?utf-8?B?WUlDUWlRMEcraW5GenBtMnh6Z3pmMzRkOENDWlFuUzMwL0xlanpCa2J4MmVr?=
 =?utf-8?B?dUtYdDdiK2pFODIrd012NXNxS2pGQmh1NzNkZ2tyMEZ4MTBHVXJDR2NsTkdl?=
 =?utf-8?B?Mnk0UzNETDkwZmRJbEFZVmgzMGl4MTI2bmhic3hsNTh3NHA3RFBCWEcwaHBs?=
 =?utf-8?B?NjRYVDhUV3ZzVXJucXExNDRabkJmdG5obkpmTGFEQTQ3emkwUk83U3phbHhT?=
 =?utf-8?B?T2ZjRmQxUUl0Mm5RU2RMKzM5dFhIUEhmSlJIc1V0M0Q1VFVndUkxbDZEdzZK?=
 =?utf-8?B?ZUxpNmZSUlpqd0xxNnM0WkJBeGtLQVBqQnJTY1RsMDl4OTZKSVJtMEZSVmFr?=
 =?utf-8?B?THFqMjdPSWFweXJXMzRuanNQbmYreEo0bXJlRE9YTk81aG56ZWdQbUYySXMz?=
 =?utf-8?B?VmZTYVZXU1VwTElCVC8wSGVHOHF6UEdiNUY5L0lNMStxYjJYdzEzTWFsbE1s?=
 =?utf-8?B?YjRIbDg1ZVF0NjJKL2hPMzh1S3JzNVozODdiSDA0eEJNTXlXY3M1cHM1WVE4?=
 =?utf-8?B?endQMVl3L2hBK2RWRlhNaXEya1c4WlV4RDdFY1lBQklsRlpERmZ3YStVc05s?=
 =?utf-8?B?cm9yMEZBU2RZSTdIbjBVb2ZFY0pjNzhTb2k1UEFhaTN5NmtFVDRMdktYZWNy?=
 =?utf-8?B?Zk5uRDBRTjljNXAvZko1Y1k0SytjbkFRcVY4YnFzdzNJa3Y5YjRFV2MvK3dI?=
 =?utf-8?B?enRnU1FTKzhlTTZNOG9sak5qc2dkcnZNK0FxT0E4aW5MOGFXenJXbW44NmJY?=
 =?utf-8?B?bWlsQ3dwUzFGVjBITGpBMVh6d0RVeUFsdGtONHhMT2RHemJVS0UvTklQYWRh?=
 =?utf-8?B?OU1Sa29yb1dHRHNMQytXS2d3MzZMU05UdmpmbkcwZFdCMEFOL3dHSUtUeUpo?=
 =?utf-8?B?bzMvSGhlN2l2N1N2dmVvSXQwN3Vnc3NRV0dMbS9tZENaem1hSzhEVXhhYWRp?=
 =?utf-8?B?RE1rbVBHS0FWVFJCSUwxM0FsS2tMell2MUxQQkRhWUZEaTY1ZFU0ZmpZZEhY?=
 =?utf-8?B?RTU1MHZCRkVrOS9yaC9hRjdpVmowVVFZNkV1MERuVko4Yk81bEQ4dm1walpV?=
 =?utf-8?Q?XWk4RWK03y+STAwjWZU5SQw48?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dirac.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8SPRMB0006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b99fc73-16c6-4e96-5581-08dd6ea709e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 09:49:46.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 266f25c5-75d4-4d97-8f44-8d816a1f6a35
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lz3fXDOWubUOdCY1zUv6z0xKFAuu6lFIa+XiYs4g9JwU91cXjW1EWvH6csy2Wc42EaVwZaiDLLcF88qlbL/8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8167

SGkgYWxsLA0KDQpJJ20gZGV2ZWxvcGluZyBhIG11bHRpIGNsaWVudCBzYW1wbGUgc3luY2VkIGxv
dyBsYXRlbmN5IGF1ZGlvIHN0cmVhbWluZyBzb2x1dGlvbiwgYW5kIG9uIHRoZSBzZXJ2ZXIgc2lk
ZSBJJ20gdXNpbmcgYSBSUGk1IHdpdGggNi42LjUxIGtlcm5lbCBhbmQgYSBRdWFsY29tbSBBdGhl
cm9zIEFSOTI3MSBiYXNlZCBVU0IgV0xBTiBjYXJkICh1c2luZyB0aGUgYXRoOWtfaHRjIGRyaXZl
ciB3aXRoIDEuNC4wIGZpcm13YXJlKSwgYW5kIG9uIHRoZSBjbGllbnQgc2lkZSBFc3ByZXNzaWYg
RVNQMzItUzNzLiBUaGUgV0xBTiBjYXJkIGlzIHNldHVwIGFzIGFuIEFQLCBzZW5kaW5nIG91dCBi
ZWFjb24gZnJhbWVzLg0KDQpPbiB0aGUgY2xpZW50IHNpZGUgSSBjYW4gcmVsaWFibHkgcmVjZWl2
ZSB0aGUgYmVhY29uIGZyYW1lcyBhbmQgZGVkdWNlIGEgRVNQMzIgdnMgVFNGIGNsb2NrIGRyaWZ0
Lg0KDQpPbiB0aGUgc2VydmVyIHNpZGUgaG93ZXZlciwgdXNpbmcgcmF3IHNvY2tldHMgKGFuZCBh
IG1vbml0b3IgdHlwZSBpbnRlcmZhY2UsIG9uIHRoZSBBUjkyNzEgY2FyZCksIEkgY2FuIHJlY2Vp
dmUgdGhlIGJlYWNvbiBmcmFtZSwgYnV0IHRoZSB0aW1lc3RhbXAgdmFsdWUgaXMgYWx3YXlzIHpl
cm8sIHN1Z2dlc3RpbmcgdGhhdCB0aGUgZnJhbWUgaXMgbG9vcGVkIGJhY2sgcHJpb3IgdG8gdGhl
IGRyaXZlciBhY3R1YWxseSBkb2luZyB0aGUgVFNGIHRpbWVzdGFtcC4gVGhpcyBpcyBhbHNvIGNv
bmZpcm1lZCBieSB1c2luZyB0c2hhcmsgKHN1ZG8gdHNoYXJrIC1pIHdsYW4xbSAtZiAidHlwZSAw
IHN1YnR5cGUgMHg4MCIgLXgpOg0KDQowMDAwICAwMCAwMCAwZCAwMCAwNCA4MCAwMiAwMCA0OCAw
MCAwMCAwMCAwMSA4MCAwMCAwMCAgIC4uLi4uLi4uSC4uLi4uLi4NCjAwMTAgIDAwIGZmIGZmIGZm
IGZmIGZmIGZmIDMwIDE0IDRhIDAwIDI3IDRiIDMwIDE0IDRhICAgLi4uLi4uLjAuSi4nSzAuSg0K
MDAyMCAgMDAgMjcgNGIgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgNjQgMDAgMDEgICAu
J0suLi4uLi4uLi4uZC4uDQoNClF1ZXN0aW9uOiBJcyBpdCBwb3NzaWJsZSB0byBtb2RpZnkgdGhl
IGxpbnV4IGRyaXZlciAob3IgZmlybXdhcmUpIHRvIGdldCB0aGUgdGltZXN0YW1wZWQgZnJhbWU/
IE9yIGFueSBvdGhlciB3YXkgdG8gZ2V0IHRoZSBUU0Y/IEknbSBvcGVuIHRvIGFsbCBzdWdnZXN0
aW9ucyA6RA0KDQpUSUENCi9Sb2JlcnQNCg0KVGhlIGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwg
KGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQv
b3IgcHJvcHJpZXRhcnkgbWF0ZXJpYWwuIEFueSByZXZpZXcsIHJldHJhbnNtaXNzaW9uIG9yIHVz
ZSBvZiB0aGlzIGluZm9ybWF0aW9uIGJ5IHBlcnNvbnMgb3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0
aGUgaW50ZW5kZWQsIGF1dGhvcml6ZWQgcmVjaXBpZW50IGlzIHByb2hpYml0ZWQuIElmIHlvdSBy
ZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5k
IGRlbGV0ZSB0aGUgbWF0ZXJpYWwuIEZvciBpbmZvcm1hdGlvbiByZWdhcmRpbmcgaG93IERpcmFj
IGhhbmRsZXMgcGVyc29uYWwgZGF0YSwgcGxlYXNlIHZpc2l0IGh0dHBzOi8vd3d3LmRpcmFjLmNv
bS9wcml2YWN5LXBvbGljeS4NCg==

