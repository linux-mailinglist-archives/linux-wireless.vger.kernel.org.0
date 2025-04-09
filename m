Return-Path: <linux-wireless+bounces-21298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BAA81B6C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 05:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32449887681
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442086328;
	Wed,  9 Apr 2025 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="F5ffIH8m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A44524F;
	Wed,  9 Apr 2025 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744168626; cv=fail; b=MOXvryG1LvClF1u17vnfH/OnulVkSO4OcUKuH5AqeK3620uUIOWY7gxKW08D6Qze8SedYgVhlrAKa5x4+FZOfEIe1N1JRY9X+weHFEX9CmJFNk3DmfU9ETDEtyReriPx9hpYgul3KM8jJIqbhIJxx/IhLfFV44o/tn9vYxTp6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744168626; c=relaxed/simple;
	bh=aweJqozb+me3X6SKC3D6ZsFGeFZiRtRXBQnPBiyZB2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4D6VEGJEd4ISImDGNHdHyd/ykrueKOG4Ydkw2NzVUr1dZ0p1Mc8hVBSA0oBqTsRcyiLLroFc9Wt1f2OQpZOXntISdp7p7Mxps3bkicd1Tp2JYCReGWUrDWtnYsQCmyWtKKREOi/e3j49n3NiR60ocoXpEiIU+6XSVgVS5AeekM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=F5ffIH8m; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKx2GAYyXLNN2XzP8A0MCr+K06u23FswoKvLqW5lmP9uAwvcyPGm2cl1/pizBbk0ZRXd6VDpGOb9fvaCj5nGK2Idiv8St8tZwD6ww/xlRUg+trN1o0Nehb+CktC/rUYpCV3KhWSdBMlWnvLOqeTHbCVM5cBMLGAtG4ydaISuWdxcSZelm3usucXYD89Fqc8Pmik0pIPHomkmIDR4mw5rvbB6IkrOMK+9sFwVsQwUdyQAma8r8uv+vspr8n0PZ60Y76BYxJ3DQpbrhUEcvgEqf/kGd4KUaatdUoczx9+yYN+z9alFhrV+qrnPNeMedf9fpfdPScu8JPJE6Xcm57PGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aweJqozb+me3X6SKC3D6ZsFGeFZiRtRXBQnPBiyZB2k=;
 b=LtY/vQIPwBz6V8M+ks0pzL/eI+rwQJYf51V9H8YsyDL6hzaDBLrQnkSDCJFlFvmXKI2OHwH/2f+uhXvTJuHoxVc5CUUUIL/K/oc8PxN+E9YFUbaeTXzXRSCV0EsrJjaVm2sTyPYq/lrucLvcxRSyIoRl0v0oUDaKnW/rY1S7Z4XcaLReXFqDi0nKacF5z2TpscEdQSOnSN6u7iUaAPPkNfrFncZEbCqDX3KVIfrSGRY+BzpxQj8pnByiMmwyUc5oyYYVxVpUY2evS6ms7LXL8Xc+Q+JLBgJVZbgLq5DcGI6KDvH4okKnbuI7A94lo5nzyg35/Gq+MEIF5TajgzRIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aweJqozb+me3X6SKC3D6ZsFGeFZiRtRXBQnPBiyZB2k=;
 b=F5ffIH8mgVz5ZfRd1ScAGAl0cOSA/rnoNNlvd486wsfi4GS+UXyxrmO53vP+YLwCv4Imzth76FgAjthTFFHmJ9LA+G8XoSqmPY79w1mkYxrFrUjL63jNHXpbG496nAcIznxCpTBmuapPpD60krTwUH8NBuVyHe9qkcl42eNQSIvdyra3SWvwAhrupF7Xh0DrN/bJRKkHfiVeGe/W0FYb7EWoA8mW8YMMFRupG7Nd3Pjh9Jc6oDfnEHvCvnxq1mJdtXjGw4zUQy/ccQcvrXuUHuJExvS8CBP1psTxISIE7WEis2mfogGKN546wgELLzQlOZYFXoJNCS988FWoCxqt3Q==
Received: from AS8PR07MB7478.eurprd07.prod.outlook.com (2603:10a6:20b:2ad::20)
 by DU0PR07MB9163.eurprd07.prod.outlook.com (2603:10a6:10:405::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 03:16:59 +0000
Received: from AS8PR07MB7478.eurprd07.prod.outlook.com
 ([fe80::6bac:2863:7f96:b6b0]) by AS8PR07MB7478.eurprd07.prod.outlook.com
 ([fe80::6bac:2863:7f96:b6b0%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:16:59 +0000
From: "Zhen Xin (NSB)" <zhen.xin@nokia-sbell.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ping-Ke Shih
	<pkshih@realtek.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] RE: [RFC -v1] wifi: rtw88: sdio: Tx status for
 management frames
Thread-Topic: [External] RE: [RFC -v1] wifi: rtw88: sdio: Tx status for
 management frames
Thread-Index: AQHbqDZ3DH0j9KNZJkKbpQKTucmNorOZug4AgADxOoA=
Date: Wed, 9 Apr 2025 03:16:59 +0000
Message-ID: <157c2b7e-f71d-46c3-a6a6-9eb470ea7cef@nokia-sbell.com>
References: <b7651a17-afeb-4abd-ae23-29a85a2f6412@nokia-sbell.com>
 <cc66d83c-fb1e-4982-ae68-d5ebd78bbbce@gmail.com>
In-Reply-To: <cc66d83c-fb1e-4982-ae68-d5ebd78bbbce@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7478:EE_|DU0PR07MB9163:EE_
x-ms-office365-filtering-correlation-id: a1483f58-da8c-4843-268f-08dd7714fdc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmpla3MwdDB5c0t4RDQ0dldPUlkrenMvQzdyYjN4OTVja1Y1Z1paYUIrbyt0?=
 =?utf-8?B?bkgzQnJhUkJCWUFHWTFOKyt4UElZUHMwcnN1N1pyTklySzI3ZXViUHlmU1dq?=
 =?utf-8?B?YzhEOXJlRXdUcUNDYTJRK2JyQnVNU3BldnJLdUFQb1I4dGN1SzlZQkJxU0FX?=
 =?utf-8?B?djJTWFFVZXJ1bk1oYnBmSEJtUXJlZjQ1YjVFSXRWcXV5Ykc0NEFKZXpQOXI2?=
 =?utf-8?B?c2lYRnFBaHdUN2Y4cGJCZGJoWXIrWThtSkp4eU9uRWM4bkJSZS9wRlI2MmMr?=
 =?utf-8?B?UDNVYmNRdTZRdjR2NDlHZUhHeXR0cTRhM2hhYnpUK2c3Q3A5WSt0NmxmRG4r?=
 =?utf-8?B?QzViamlOZnlrNXdUMjFNREVlYStjVjlyd1YrSFFLL3RteXZySzVtRXVraVo2?=
 =?utf-8?B?ODNxVUQ4cmlxVmR4NUoySUtVclhkT0xQYW9aa2RHaDAvaWxjei9uSU5pV0Ey?=
 =?utf-8?B?ZC9LM2t1VkdhVHp3YzBGdytZOHFsSUJka2RoLzBMTCtDbHdPd0Q0OS9LWGFD?=
 =?utf-8?B?VGFOa0hsVmxOdmFBdkFaY0JXVlBaSjNKNnBLWEozVXJmbFBzczVNRDUyT1F1?=
 =?utf-8?B?YWt2Rzl6TkpwODFsVm9UdThOSno0akRyd21rajNROXN3ZGgxUFZtQ2VoaHJm?=
 =?utf-8?B?aUt6TTFYeWVoSTJhb1Q5cWpOQ0p0OXEwaFhRS29nMUcyQlAyL0c3VXNUSjJI?=
 =?utf-8?B?empHTkw1R2l1K3dPOHhTdGhjY0hNcTA0RnQvZDJnSTZDb0lFV1BzNllES09T?=
 =?utf-8?B?TzZ0ZXdxeVFqdHNCTmZLRDJSckdaN1RxQldIWThHSlpOcXhZSU00ZkdlVWw4?=
 =?utf-8?B?Wkx2NkVHYzBQSEhnNG85cDhDNGd0MFFNM2IyQ2xCN1hCTXVDT0Z6aGR2YUtO?=
 =?utf-8?B?WE9mVHJNc2Rod2xOQUpGOC84b3FhTEV2VStxWk4rQWF2TENRWmpsejJmVFdY?=
 =?utf-8?B?UE5Mclo4MW5NMjEvbkExbWJlNHh1MFhOTHVTRVMveFFLQ0tRUHdFL09LeTJj?=
 =?utf-8?B?SFJQSUJXYTRGMFYrL0lIeTF0dk5aak9aMWw2ZXRHK1Z3aGtVVGZoemFjeEZK?=
 =?utf-8?B?RUxReS9GelNld0pkQ244Qy91Szl1K3JCamwyWlpEN0NnM2VKNHJjVHlJbTlW?=
 =?utf-8?B?Qm82dHh0MGxjS1NXbmhOaDhQRCtOWWN6T1pSY0hxYXk1MExOUzMyb1VCS0JT?=
 =?utf-8?B?U1BTeWdoak84TWxqYVZXdkl5SEJNdnZsMFpZa2JwNVFQWnZXTEIybGlJVHBl?=
 =?utf-8?B?RUE5NmN4em52Y0UzeENLcGlGcTN3ODVGN0dUUDJ5SCttaHgydXRCN3I0aXI1?=
 =?utf-8?B?ZW9rNzFRS2tDQ0Y2SGFsRzlXYmNXcUYyV3ZvSytYYWU2dlhyVjVHTVY5K2tR?=
 =?utf-8?B?RTJGQStLdHdzaUhTc2UyaTQ3Q3R3UEsxOHdIWDRXQUJYS0lqSkhFSzU5QWx6?=
 =?utf-8?B?YzJNNmVGaWc4NTZ5a1luSW4ydlUwZzRLQ3prbnd1ZVAvbmZqQ2E0WC9jcEQw?=
 =?utf-8?B?di9mVTVuZHl5OXM5NXZoQXZoSFZNWHU1U0lwUGZQUTAvclRiWEhreGNMVGIw?=
 =?utf-8?B?L1lNbGxCWUYrZytGcWhOVjVNOHY2cmUyakxkeG9VK013azUxK2ZROU5KU0Jj?=
 =?utf-8?B?ajhXUXFWb0hWM1BzQUVlNkRDb21veWZMcDBENS8wa3NhTHE1MWdXWXhwWHh4?=
 =?utf-8?B?TUJ3SzZqYldUS2x2azdCZUFkYkVUR2dES2VQZkVKTVRrVUFDQWxrcTFVSVNU?=
 =?utf-8?B?bDNtK2hpbTg0b3FUaHNhZnNMdmh2ZmV0RldpSEdUV3QyN2UwMnlOb1d0SzJF?=
 =?utf-8?B?NHdkS3Rvb0U1c2U3c3JDUXFteVY0M1pNRk5lVEJ6blB4L3dBTDNiS3ZaZ1Z0?=
 =?utf-8?B?Smc1b3g5aTA5WXMxWWxzeXVJVUhWNHN5cGlrbEkxdTNMNm5hQlozYWpqK2NH?=
 =?utf-8?B?ejBlRDFZSzNlNVorcVo3OTJ5SlFZYy9oaGc3U0RIMFpCcHpoNVlWUmRhN1VO?=
 =?utf-8?Q?h3KUzlmUGd38PTgI8+qKEGUfz6PzUw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7478.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkhRQzU2YTYvUmRhZXhRazkyeDJNTjlueC9xbCtoVHFKYXRCT1QwK3p0OStH?=
 =?utf-8?B?SmtpcHVET29IMm5rTFJXMGgzc2pSNG1iVXpmWHRWdGNWbnhiRTB6eHE3UGF4?=
 =?utf-8?B?OTNKVmRNdmZGZ1JoRGp2blZTWSs2WHVuM09OSnY4SzZ0TGJISzQ3Y3hka2xE?=
 =?utf-8?B?L0kxZW1jSmtaRHBnQ2Nva3pkdk5laXBnT0JwSm43VVg0RS95MEx4YVVETTNv?=
 =?utf-8?B?Yi8xSG93NVBIclRiRGd4akJ0NzB3c01ZN05neVJReU1TWGR6WUg1SVR5b3Ru?=
 =?utf-8?B?eTBFWk1kZ0orQUJJWlpuZWFBN1dzZlhUT3cyMmRmbVRJLy9ZZ3B4L250VUgv?=
 =?utf-8?B?U1FjZUxIMmFxQXlXU0FzaU1uMThKa1lERGc3WXJpTlh1dWs1ejJESjVHNFU5?=
 =?utf-8?B?TWRaMDVMdFBvUGJxaGUycEltYU9qN3BjY1ZmQUI4WEppL0VLRm1Ndk0wSFpO?=
 =?utf-8?B?c0JDb0Q0RFR6NHNTQ3BLRDQrUm9UcDFKMGhYK3dRelNQNWtyNGJTb2MwUEpy?=
 =?utf-8?B?eGRyaFprbkM4M3lMbytVTUllcWM5TFZyMUhLanFwZjJBYjhuS0ZURW8yd2Ni?=
 =?utf-8?B?NkNVdFZRclkvbllUdlNLTXllRTlCdU9DRUFuQVNGYmNib0ZlcG80TlVDNENa?=
 =?utf-8?B?NlNsR1ZrMkxhbFkxaUlWcTlGZnFJVWlSNmZBN2xlWW9pOVhkdUsvcnFTOXNs?=
 =?utf-8?B?T1FvN1F4V2tjdll0cnNqV1pSdjE0U2hBeVhGVzBtMVlzUEt6cDRNbUtRdEpT?=
 =?utf-8?B?MWI1SWlQOEU3L3VwRVFuTlNjVXVFMVhJbmRyS1dsRFB0dVA1ZVBEcEJ3ZWJ6?=
 =?utf-8?B?OWZpR0ZIWVJ5WFgxNklTY1N2MFBoYzhLREFhQ0FuMFl4VUJVT3B5TFpNTlZZ?=
 =?utf-8?B?TkJ3NGlnVW5SWmVrQVUwYVVPVC9pMG5VWVJqVGpBU0o5Zk1SZ0YvT0VKRHJC?=
 =?utf-8?B?emNFYk9xWGxQSGtxQ3BWWmZHVWRzRGRhVkkwMnpGV0lYbjNsU3g1L1g0UTE1?=
 =?utf-8?B?R1dUR294bDJtZFBNUVVtM0UwcmJaSlpDWkI0M0EvUE9QeTFLSFNMc3gvMU0y?=
 =?utf-8?B?dzJ0bG9KcXVYQ3VPelljY0l3YXMxRlJrdU44YVh6Z1dZTTBMUlRLbnBsSVVT?=
 =?utf-8?B?ZTU1OUVPYXlsM0ZBNEhVdmpZSWl3NzVaWkxQWE1ROVpPNUlkMmZrYXRINHpz?=
 =?utf-8?B?U0lTdVNUQnVTL3NuL1NWYVRGNStyekJhSkkrWmVMdDZYeEZiMGdPS01qbXZ3?=
 =?utf-8?B?OXhLamRUaE5CZmdTeVU4V0ZSSUtQWXowaUpYYXFTSElWKzNlM0tzd201Njh0?=
 =?utf-8?B?OHovU2lXaFFZeHlYbU1XeWdVbk4vMnhvTUlrT3ppTFBCc0UxSHJKS3o0VUVM?=
 =?utf-8?B?cTE3ZUZaOFpXS3k4N0dDd0l2cXE4aTZjYlJDcEpwSlFmU2x1NjZlbWlkcDJP?=
 =?utf-8?B?amQ5VXIra0VrZmNHbXcxcVp5MkdlVGJwU3Z0bEhBSEZaNmVMZ2RyYSt1S05Y?=
 =?utf-8?B?bnBDSks3L1RlNzl0YmN6WEhBZ3AzcTlBb2d0STVXY2tqN1JzTGVxRzZwMitQ?=
 =?utf-8?B?UktRRDRsempKcW9rbytNNi9NSjM0ankvcnZkTkFRR0xpT0NkNVVWcDlKVzIy?=
 =?utf-8?B?cXlSWEdQcnVBTllpbXFvNWx3TnY0YUJpWHVTTzl1ZTZFM1NaZGcrcmhrZjk1?=
 =?utf-8?B?clQ3NEhRbDI1dXdTS1ZRSis5M2R4MXB6dDlLeGVzVUF3ZmZCMzcxSDk1dHpJ?=
 =?utf-8?B?T2xIdDVMOThlSVhXZGxvQ3VsT2h1NEUwMmR4L29NOHE4UnlpMXV0eklub1pV?=
 =?utf-8?B?ZlpRK2dUS0ZHY1YrQzZnYmRxcjRrZDhzeHdGbEVCM2IwKzZodG9ubnM5WjVQ?=
 =?utf-8?B?SXF2MURSY3p1cFh5cUt6RlBOV3Q3WFlxUWc1amU5eHRaRE9FUmV5T00vTm9S?=
 =?utf-8?B?SVM5cXZYd3JiZk0yRmNkeEJ1OGpsK1UrNi9pczA4c3ExUy9XeG1oQzJ0OEVV?=
 =?utf-8?B?Yi9rVUFNWDNOL0NaYW96dzQ1Y1cxN1RKYVNZSk5zaHBEQWhkOElTNHkwUkQr?=
 =?utf-8?B?bmx5VzRoSStDNWI3cDBLcG9DRG1EdVRWcllBT28yOWpSYnNtWEVTSkhPbXZl?=
 =?utf-8?B?NXFoQkQ3b08ramUxRHFwa29DK2hsU0VjSEkvUjloRFY1MnR1VFhKcWc2UHN5?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B5FF08C38F291428D88F2376F95E9D0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7478.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1483f58-da8c-4843-268f-08dd7714fdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 03:16:59.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJYHiGSOJFISI2RpLE9rM5RQ6Q5lSxCWd2gY3sWGaba3kVhjVKJeUynbQvhvJ94hyUWikeYT8tQfoBrvcSCU9nAf4Z4QhmSagugQCwzD544=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9163

T24gNC84LzIwMjUgODo1MyBQTSwgQml0dGVyYmx1ZSBTbWl0aCB3cm90ZToNCj4gQ2F1dGlvbjog
VGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNs
aWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSBodHRwOi8vbm9rLml0L25z
YiBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4NCj4gT24gMDgvMDQvMjAyNSAwNjoyOSwg
WmhlbiBYSU4gd3JvdGU6DQo+PiBPbiAxLzEvMTk3MCA4OjAwIEFNLCBQaW5nLUtlIFNoaWggd3Jv
dGU6DQo+Pj4gTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVt
YWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gQEAgLTExOTUsNyArMTE5NSw3IEBAIHN0YXRpYyB2b2lk
IHJ0d19zZGlvX2luZGljYXRlX3R4X3N0YXR1cyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0KPj4+
Pj4+ICDCoMKgwqDCoMKgwqDCoMKgIHNrYl9wdWxsKHNrYiwgcnR3ZGV2LT5jaGlwLT50eF9wa3Rf
ZGVzY19zeik7DQo+Pj4+Pj4NCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoCAvKiBlbnF1ZXVlIHRv
IHdhaXQgZm9yIHR4IHJlcG9ydCAqLw0KPj4+Pj4+IC3CoMKgwqDCoMKgwqAgaWYgKGluZm8tPmZs
YWdzICYgSUVFRTgwMjExX1RYX0NUTF9SRVFfVFhfU1RBVFVTKSB7DQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoCBpZiAoaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMgJiYg
cXVldWUNCj4+Pj4+PiArIDw9IFJUV19UWF9RVUVVRV9WTykgew0KPj4+Pj4gSXMgdGhpcyBiZWNh
dXNlIHlvdSBoYXZlIHNlZW4gImZhaWxlZCB0byBnZXQgdHggcmVwb3J0Ij8NCj4+Pj4+IEhhdmUg
eW91IHRyaWVkIHRvIGluY3JlYXNpbmcgUlRXX1RYX1BST0JFX1RJTUVPVVQ/DQo+Pj4+Pg0KPj4+
Pj4gSWYgaXQgc3RpbGwgY2FuJ3QgZ2V0IFRYIHJlcG9ydCwgd2UgbWlnaHQgdGFrZSB0aGlzIHdv
cmthcm91bmQgd2l0aA0KPj4+Pj4gY29tbWVudHMgdG8gbWVudGlvbiB3aHkgd2UgbmVlZCBpdC4g
T3IgYSBsb2NhbCB2YXJpYWJsZSB3aXRoIHByb3Blcg0KPj4+Pj4gbmFtaW5nIHRvIHBvaW50IG91
dCB0aGlzLCBsaWtlDQo+Pj4+Pg0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBxdWV1ZV9o
YXNfbm9fdHhfcmVwb3J0ID0gcXVldWUgPiBSVFdfVFhfUVVFVUVfVk87DQo+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+IEJ5IHRoZSB3YXksIFVTQiBiZWhhdmlvciBpcyB2ZXJ5IGxpa2UgdG8gU0RJTywgYnV0
IFRYIHJlcG9ydCBzZWVtcyB0byB3b3JrIHdlbGwuDQo+Pj4+IE9uIG15IFJUTDg4MjJDUyBJIGNh
biBjb25maXJtIHlvdXIgdGhvdWdodDoNCj4+Pj4gSSBkb24ndCBub3RpY2UgYW55IGV4dHJhICJm
YWlsZWQgdG8gZ2V0IHR4IHJlcG9ydCIgbWVzc2FnZXMgcmVnYXJkbGVzcw0KPj4+PiBvZiB3aGV0
aGVyIEkgaGF2ZSAiJiYgcXVldWUgPD0gUlRXX1RYX1FVRVVFX1ZPIiBvciBub3QuDQo+Pj4+DQo+
Pj4gVGhpcyB3b3JrYXJvdW5kIG1pZ2h0IG5lZWQgYW4gY2hpcCBhdHRyaWJ1dGUgdG8gZW5hYmxl
IHRoZW4uDQo+Pj4gTm90IHN1cmUgaWYgcGVvcGxlIGluIHRoZSBHaXRIdWIgdGhyZWFkIGhhdmUg
ZXhwZXJpbWVudHMgb24gYWxsIHN1cHBvcnRlZCBTRElPIFdpRmkgY2hpcHMuDQo+PiBPbiBteSBS
VEw4NzIzRFMsIHdpdGhvdXQgY29uZGl0aW9uIiYmIHF1ZXVlIDw9IFJUV19UWF9RVUVVRV9WTyIs
IHRoZXJlIGFyZSBtZXNzYWdlcyBpbiB0aGUgY29uc29sZToNCj4+DQo+PiBbIDIzLjI5ODQyNV0g
cnR3Xzg3MjNkcyBtbWMyOjAwMDE6MTogZmFpbGVkIHRvIGdldCB0eCByZXBvcnQgZnJvbSBmaXJt
d2FyZQ0KPj4NCj4+IEV2ZXIgYWZ0ZXIgSSBkb3VibGVkIHRoZSBSVFdfVFhfUFJPQkVfVElNRU9V
VCAoNTAwICogMiksIHRoZXJlIG1lc3NhZ2VzIHdlcmUgc3RpbGwgdGhlcmUsIGFuZCBBUCBtb2Rl
IGRpZG4ndCB3b3JrOg0KPj4NCj4+IHJvb3RAT3BlbldydDp+IyBpdyBkZXYgcGh5MC1hcDAgc3Rh
dGlvbiBkdW1wIFN0YXRpb24gMDQ6ZWE6NTY6MmY6NmY6MDcgKG9uIHBoeTAtYXAwKSBpbmFjdGl2
ZSB0aW1lOiA0ODAgbXMgLi4uIGF1dGhvcml6ZWQ6IG5vIGF1dGhlbnRpY2F0ZWQ6IHllcyBhc3Nv
Y2lhdGVkOiB5ZXMNCj4+DQo+PiBTZWVtcyB0eCBzdGF0dXMgcmVwb3J0IGRpZG4ndCByZWFjaCBo
b3N0YXBkLg0KPj4NCj4+DQo+IFRoYXQncyBiZWNhdXNlIG1hbmFnZW1lbnQgZnJhbWVzIGFyZSBn
b2luZyB0byB0aGUgaGlnaCBxdWV1ZSBpbnN0ZWFkDQo+IG9mIHRoZSBtYW5hZ2VtZW50IHF1ZXVl
Og0KPg0KPiBzdGF0aWMgdTggcnR3X3NkaW9fZ2V0X3R4X3FzZWwoc3RydWN0IHJ0d19kZXYgKnJ0
d2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gCQkJICAgICAgIHU4IHF1ZXVlKQ0KPiB7DQo+
IAlzd2l0Y2ggKHF1ZXVlKSB7DQo+IAljYXNlIFJUV19UWF9RVUVVRV9CQ046DQo+IAkJcmV0dXJu
IFRYX0RFU0NfUVNFTF9CRUFDT047DQo+IAljYXNlIFJUV19UWF9RVUVVRV9IMkM6DQo+IAkJcmV0
dXJuIFRYX0RFU0NfUVNFTF9IMkM7DQo+IAljYXNlIFJUV19UWF9RVUVVRV9NR01UOg0KPiAJCWlm
IChydHdfY2hpcF93Y3B1XzExbihydHdkZXYpKQ0KPiAJCQlyZXR1cm4gVFhfREVTQ19RU0VMX0hJ
R0g7DQo+IAkJZWxzZQ0KPiAJCQlyZXR1cm4gVFhfREVTQ19RU0VMX01HTVQ7DQo+DQo+IEFuZCB0
aGUgY2hpcCBpcyBub3QgY29uZmlndXJlZCB0byBwcm92aWRlIFRYIHJlcG9ydHMgZm9yIHRoZSBo
aWdoDQo+IHF1ZXVlLg0KPg0KPiBBbGwgdGhlIGNoaXBzIHNob3VsZCBiZSB1c2luZyB0aGUgbWFu
YWdlbWVudCBxdWV1ZSBmb3IgbWFuYWdlbWVudA0KPiBmcmFtZXMuIFdoYXQgaGFwcGVucyBpZiB5
b3UgY2hhbmdlIGl0IGxpa2UgdGhpcz8NCj4NCj4gCWNhc2UgUlRXX1RYX1FVRVVFX01HTVQ6DQo+
IAkJcmV0dXJuIFRYX0RFU0NfUVNFTF9NR01UOw0KPg0KVGhhdCB3b3JrcywgdGhhbmsgeW91IHZl
cnkgbXVjaCEgSSB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2guDQo=

