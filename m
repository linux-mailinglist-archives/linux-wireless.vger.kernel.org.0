Return-Path: <linux-wireless+bounces-11932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14095E741
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AA41C20858
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 03:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B71F5FE;
	Mon, 26 Aug 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QfMkhgqq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00704BE6F;
	Mon, 26 Aug 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642314; cv=fail; b=i3DQjNhUBcSUOPZg+JchkrcZhQKOQnewEndyJPTj8rI8NrUrzOWX5xpHeVUirJh8ajmuR/1kL8YFG2WzHHloGC590Bl8aHLnEoJiOYTaiMi7F3J0+Efg+X9HFp/8m/evGFd+IMrDN0M9wsWCB2I3pfz0JhtFaMCV/Qi6EYZPB1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642314; c=relaxed/simple;
	bh=amFjZFUU6KI2rcEZNd2Eq3fNoQYGN6/UGYUBTFFxJ1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdum+PpKlcZt3/dF/pJXKHE8/sGvxUKpljRxkhbEDcY1K46M2pYrV/gO7K5dVJcI2ed503Gug/i2vcXBL6k49oAQ/f70yhuUXZjIw769hpAQXpoTAe62W2Q2eMxUhZP6y9fb1oSUdK9EVr+IwZDD3UCzch0LtkVrqUFupa7VVhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QfMkhgqq; arc=fail smtp.client-ip=40.107.117.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USZR/QLw5VqsYhdwsmnNNGP9m5AgraB57VuXT8IYX+WkqHv0wB38L/HtpEUPNh30ND8m4Em/Y8L31f8QOx7/9jhv+h56nVqcGO9nDB4CcWgh31muO7D1FwvTSKJs3GsdVj4RqWcVglzA9UH09HecBbXvQCsDlmvOdOTZ/UxrfcLPa15gSYcdPGrJfdH9PYvYNCywbluWirVPn0ejcdzCAd8I31MapdDmZtqMTMTqAhL0y1Nq0pZBlTJPFVyNm4A9XYFqAdhq+MeLH3ND3nsmF/m5yKhvMr5NhZRANFUGEA90dsA41NUQ7sXP8SfX+lP9ZnohFL0pIhmwMm/UMbL0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amFjZFUU6KI2rcEZNd2Eq3fNoQYGN6/UGYUBTFFxJ1g=;
 b=qBm7yUT96xHgXo+6C83TCzVXAYZOJ5lGQVyp2RqN9Ug17madXqaKlUaMjSIBGolPuNcR0+80pQCvDYFnr2GzyzralnZplYxJw4rYzq3jGvCO5tPZaILOYh0fWm9xBy4eFhld+/x68TdBNQGZuZceILxhWMi0q4s1r8StXSpAqAZFCApL63O/f9n1x5HrDHgon+rlPawHNJ+tbhvnZMOtueJRCSxgIlDxaYt7b2a/ksUVzyDNNbtu44aWPA7r+cjXmQ3IIjVQdm+jgMAXwgYsfcevZTXfBKuZRvoAddKuu9cPVtgs9eTKaZ37kYNV4LP1Y5hM5HkbssgTxN9g+3aZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amFjZFUU6KI2rcEZNd2Eq3fNoQYGN6/UGYUBTFFxJ1g=;
 b=QfMkhgqqXQ7RfbS3/RHiCjaMDIqW1C0+RQ5qr1hchSLPDenLYfKDJuigl+gb8DTKgWBM4LIuKw070byC0/YESeTQA2U9z0z2R3y+oyY+45I94waZgQGndoC3tAgB8XW9dX76HZvTl2b33UHWGCJtjcgD9MKqi8CNvkFkL9k4X7hDuXQT4MZZdxHhLL6IGoeSZXFiAGlEcIWp4QBSsyzlO6eHM1hIe5XQ5DJJpK5P81tOSjnKUKpuoPmrGchrJy0gCUjHU/jA+zjDegc9BWCwyN3kwOIbpeoIQy99ntx9QyuUsCtcuKxxJeuN4ml2s3UhTdfgI8xzOZQjGtPB2MvLjQ==
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by TYZPR06MB5321.apcprd06.prod.outlook.com
 (2603:1096:400:1f3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 03:18:29 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:18:28 +0000
From: =?utf-8?B?6ZmI546J5Yeh?= <chenyufan@vivo.com>
To: Brian Norris <briannorris@chromium.org>, =?utf-8?B?6ZmI546J5Yeh?=
	<chenyufan@vivo.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Thread-Topic: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Thread-Index: AQHa9SqYZncsAF2R3kSaGF+n1/k8QrI1EdYAgAPREIA=
Date: Mon, 26 Aug 2024 03:18:28 +0000
Message-ID: <c2ae3b1b-d654-47f3-8520-888bdaea873c@vivo.com>
References: <20240823070320.430753-1-chenyufan@vivo.com>
 <ZsjAZJjBvjGLkG7f@google.com>
In-Reply-To: <ZsjAZJjBvjGLkG7f@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5487:EE_|TYZPR06MB5321:EE_
x-ms-office365-filtering-correlation-id: d4eb9e83-5459-4bf6-41b6-08dcc57dc11c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2hGa1p5aCtLaFhIVnVJa3UveGxDNFBEZkpCb1ZlY09OQWhpZWdPWWw3RXRx?=
 =?utf-8?B?VnBKQ2V5aTRrc3AydVFlaGpua282LzJYRElnd1dlZVJRZFJQS2xRWE1Fc1Fw?=
 =?utf-8?B?M1p6dUxYam5PMDhCKytjZWxOTmxmY21QNVV0Smw5dVRvbThzUnlHSUQ2VDNS?=
 =?utf-8?B?aGtJSCttZndGWC9qTjg3eEdWSDRiSVRGaHR0V1VjamhKeXc5OERpbFVNUzFn?=
 =?utf-8?B?cWJzY0p3aERrRzBDeTZEWVBLOWdpV2FsekticDlCTWN3SnMrYjdSMlZLUHJw?=
 =?utf-8?B?aXlvb3N6T0dTUXN4bTVRQXlDN2lSbENLQXFXbHdKUG5maFAzNEZPMjgrVVhs?=
 =?utf-8?B?R0VrWHAyZi8xSDBsd0pVNUp4anJtUUQ1MHlJcG1WQmtBL3dDZnNMa280M0RS?=
 =?utf-8?B?bDhhN3lvbmk1Z0ZGOGlTSUg3SHZER29FQnR2ZSthV1JqZGRYb1NscVBXVHBy?=
 =?utf-8?B?b0hsWng4UXdka1BOdVhqa1pnUmhldWRsREd4L0dOcHE1dTluTU9uaDN1bVRH?=
 =?utf-8?B?T3hzcXBKN2EwbjluM2w1NFNBN2NMdjFiUkVtc2VQOFNvSEVFczVzNjV0UUgx?=
 =?utf-8?B?elI2emRheDFHR25JaFRRc3VucmpLbWQ0UWF3dXE1NHI4L1h4dXhsaloxcUFE?=
 =?utf-8?B?ajYrRVJkQkkzYXE0ODhReUErVzRpdlhJaWxTMVNnU3Njald4Qkk1b2V4bDlX?=
 =?utf-8?B?T0N1aUI4ZVA3eWZZZFRvTjk3WWxoWFdWVER6U2piNTFmdTVlKzdYNGdhZDFK?=
 =?utf-8?B?Sm9MaDd1Y2x3TFV1cHBYVGJJc3RYVDgyaDBBRWpHZlJVM1krazVPSEtBZERI?=
 =?utf-8?B?V1ZxT0FsRXZINUFveUFSbjc0T1JxbTZGc0x2RTFRRVY0bHIzdmsxVjZaMFNC?=
 =?utf-8?B?QzZEZ1ZKOUhRZWIySUYrdVZIZUpDbVhMRy8xanBNWmtGNGNHWmlVMDJMUURM?=
 =?utf-8?B?MEVIRUJ1VDVuZnBWdkdJbTlCSXhSS2JoeUZXS1RhSnZmUTczRnJseE5TeTEw?=
 =?utf-8?B?ekhOVUVNUnpBRkpzTWFSOHpLNFJMQzZrdDhvM2V3YlA2dGlDdDRBRnNxR3Rz?=
 =?utf-8?B?WW13dmh1NEF2OTJTQW1jOWprek9uK0xFWDBTUjJqWXd4VmJJcWRYK0c5NWJy?=
 =?utf-8?B?NkVzeXZ3NVFzSEQ2YzdxZ2NKTG9ZQk1GWXcrMXhlYkRNc2hOdVJLV1lrMXQv?=
 =?utf-8?B?djQ4eUVwT1B4VDNVcVQwbUVzYXhJcTdjMUtHSlpmdnV0czJscmZrYTJWVCtU?=
 =?utf-8?B?WjVhRVM5b0FEMG9WanpKT1piMW9USGh5WUJBY3Ntc2VpaC9WclFJT0x4TzNS?=
 =?utf-8?B?ZHo5ZjRxc0ZNQ3M5VnFlTU1ZUmNENDZ2RjhndGZzTFJnL2dHWDd4NnBWYTkv?=
 =?utf-8?B?ZmVBc21KN2Y2dlBZWDNnQ0h0bW1RYVhYV0dBRXN0RkduNHRpWmFnRDVjWVdQ?=
 =?utf-8?B?MnhjNTh1cklNTG9kcGtDZlVnbWpSZldUNHUyK2lQMHJiWnFjSmxOL29mNnhz?=
 =?utf-8?B?bUVGYnRzTGRxR3lZQWFISzV5M00vTDBxUXNLSFRQR3FESXkwS1FBazF2N2dh?=
 =?utf-8?B?U0dSbVoxb1NpV2pvckJRa0xXMFpRNDEzRytBTGhWRlZ6RXpvNk5mcUN1OFQ0?=
 =?utf-8?B?WFFRVGVFaXo5UnFNeWJQOVc2WmtNdUV6cW81WGJPN1MvNXhHazRldE51RFNU?=
 =?utf-8?B?dDhYbmFaZTRHdDdWTVlTTFFLNm5FTXJPZGhscVJjQURZaDh2UWs2cHlyc056?=
 =?utf-8?B?MllkYU9qTzB6NE03R0c3a2wrZjVqT2wzRGkyWElVeHJrSUxNemhhVlNMZ1Z2?=
 =?utf-8?B?YWh1YjJUVE9Wb2hwVTJ3VDZsUndMZ1hpNEwrL21DZzl6bm0xeWpKTHJwOW9Z?=
 =?utf-8?B?VzFBejcxT0FXMHVQOW4xSGtqU1RWZUwwVGg1TUlpRURJbEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1RWSGZ0UGFDYzVLcVFEYWcvVTIyV3lWdmxFOTJsbSt2M0MvdjBOTkNOT3FR?=
 =?utf-8?B?YnN5YVZYbTFHRVZ0ZWxwMkVweGZBYjUzdURWenhhS1JaV0xQRi90RkpOWGJV?=
 =?utf-8?B?eXQzaUhHVGlmb3d2K2RBS2pXOFYwYjFVRU1OcTJZdzRqOEtFV0Y4V1VxZjNV?=
 =?utf-8?B?RjNvZFNmSjFrdjJmcFlSSmNvdmdvbDN1am5FVWpzQ2ZLaGxYMmlTbURvaGdW?=
 =?utf-8?B?Y05TSEtWM1paWVVHNUIzUWo3LzZUTENTTTZsd1VIRllTc0M4ZUZwOG9wNjli?=
 =?utf-8?B?dXRIUzdyTFlmTEJXUWl3K0FWbHhRMXVJNzhmcE9PWGdSYlNlVWsrd2pCRTk1?=
 =?utf-8?B?QzFrTVozakZLdVlqVmtmOGlYRVBkcHVrVEN2Y0VoNk5OaTQ1NHpwOTY3STJr?=
 =?utf-8?B?b3UzSjc4ZEJ1QWVzekIzV2d2U0ZYSjViR1ZBeXNRUWdwN0xEN3NudDQvcGxm?=
 =?utf-8?B?U1VId2paQnV6YlFwY2FQcjkveUhZMzBqTlBDdDFwbDRmbmxJZm42WHhiVFpl?=
 =?utf-8?B?ODJPWnN1VXIxTmVzcHNOMUtMbUV3a0QxRWs3NGhFWE5tRmRXalpodE91bWRW?=
 =?utf-8?B?RnBXVEtoVkFrL0ovdkRqSVlnTnd4bkhaYjJOMVFRV3NxbjViSlhIYXdiU2hk?=
 =?utf-8?B?R1BrYTIxSU1VcmIxZXp6aGFwRGVYQ1ZUVEFIbUhVTXBRcEszK3VFanI0QmQw?=
 =?utf-8?B?ZmxLMC9NOGc0NUUzSVR0a2VTb3VocnJJRkR1MmVSMDFvWlM2RENWZWJsN0VL?=
 =?utf-8?B?RGFrbHFKbTlzZ0tFVy81MEtaSWs0VEZWL3dmSnNhSVM0OG52RU9PL2dZNXF6?=
 =?utf-8?B?elpMd25rVUpUcnRvbkxSakJlQSs1RTRzU0orVUlSUU1adEZoTks1WVVOWnZG?=
 =?utf-8?B?bnc1TXlsdFcyYUltZDlGa0hLOUNNaXgzOGpSQVcxODBTY282NVBZQ1BwUFhh?=
 =?utf-8?B?Mmc0YUFDKzZ4REZka1BENUwxVnYySlk5TDczMW9jbWhhYzB1VkJxS0d2N0tB?=
 =?utf-8?B?NjhFRXkwWmVQY1Bjd0pNN0ZWOXN6SVBiK2s0ZGlnS3IzVXQxcG42VjBuTFBS?=
 =?utf-8?B?OWJZTnJHMlNYWGZPM3g5VjZ4Qk4yNW1BU3ZvWWgxMEt0TGN4enM4UWQxVjND?=
 =?utf-8?B?Q1FaS3VGUXIyT28xUTBIdWVDYkhSYUk1bGx1Q21VeUZsbFAvaE9TTlhaNHZv?=
 =?utf-8?B?WWtKOTFncTdMOEVaV2RhcXk0WEZTNEprQzJxTlFCVys1bjBmblVtNm1Hc3Rq?=
 =?utf-8?B?QUhpM3ZpTDh3ZUNaak5FeHo4OXBieGpmbnFWM2tpMnF0TFR0UlpCWSszaEQ3?=
 =?utf-8?B?cGdEMTE5SDhlYVMzSUJzQlFwV2FSaW94bmZiOTRqWGlHVm5sNnV0UTZGZnFz?=
 =?utf-8?B?M1lYcjFrckR1NXg2bTVmKzk1ejNma05EUW1qeTBLdFVvZmZrR0w5VmpWWURi?=
 =?utf-8?B?aUV5cFdRdTRDMWNldzhBOUc0V1orY204VE5ucnZobWxadW9aVDZsNlZGVjlh?=
 =?utf-8?B?RS9JelBNOXdNdU1KTmtkMUFnN3NSOUJvQTBxSjdMQ2ZZQWVvWVJlV3d5aTFs?=
 =?utf-8?B?empxeFIybnJWUXR2czBab0xnY2ZKYVZ1UjBMeHZsRWdERGd4SlZtSDFMVlVE?=
 =?utf-8?B?Z1hMTlVzenFSYW1EUkFlZ0tiUDRZL0RGdnZFNlRDSkt5ekZVTlVkNkh0dGti?=
 =?utf-8?B?NVpZbUdsSzZYWjJuYmRoUlNlaEhFeE9KY2MyTEZPb3MyVjUwQ2lVTTF3eTRr?=
 =?utf-8?B?cURhZnZxWVg2bm8zV1BISTdwVHV4cmo2ZW51a05ZKzEzNnlnZmZRQVZGUCt3?=
 =?utf-8?B?d3lhampsRFRnMzNvdjhrQjNaSFM4RTIvUjFNdVcrVE1qRGVVSDB5Z2dxUFha?=
 =?utf-8?B?UFlUWUQvZ2VzTzdXdklQUHc0R0dWT29YcTZQaE9NelBhSW9lZkZlRFdHenIy?=
 =?utf-8?B?YzVDSDZzZ3J2Y091b2hrbmQxcW9MUEl3V3BaMHpORExsN1g5T0RicFo0NFE2?=
 =?utf-8?B?NUNERWJkSjd2bC8rdHl2Q0V5RUJ6R2xpZE1zSWtMSjluTVFNWU1WNk9vcTZW?=
 =?utf-8?B?bEVaNXdid3lmeTJya3lUcjlnZ3BoeXlrL2txcnlIdUIzNTJONVJXb1FpRVBn?=
 =?utf-8?Q?zluc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D45540B9F1B22E4786B688FF663567FB@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eb9e83-5459-4bf6-41b6-08dcc57dc11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 03:18:28.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyPC8bxf7awKJGe2TCp+GxhW4Qo/48aOwsoEkhSTZmAMfyqRQqq2brU7ArEbR6afVAtzzEBI4hEmz2NN8LON4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5321

5ZyoIDIwMjQvOC8yNCAxOjAxLCBCcmlhbiBOb3JyaXMg5YaZ6YGTOg0KPiBPbiBGcmksIEF1ZyAy
MywgMjAyNCBhdCAwMzowMzoxOVBNICswODAwLCBDaGVuIFl1ZmFuIHdyb3RlOg0KPj4gVXNlIHRp
bWVfYWZ0ZXIgbWFjcm8gaW5zdGVhZCBvZiB1c2luZw0KPj4gamlmZmllcyBkaXJlY3RseSB0byBo
YW5kbGUgd3JhcGFyb3VuZC4NCj4+IFRoZSBtb2RpZmljYXRpb25zIG1hZGUgY29tcGFyZWQgdG8g
dGhlIHByZXZpb3VzIHZlcnNpb24gYXJlIGFzIGZvbGxvd3M6DQo+PiAxLiBjaGFuZ2UgdGhlIHR5
cGUgb2YgbXdpZmlleF9hdXRvX3RkbHNfcGVlcjo6cnNzaV9qaWZmaWVzIHRvDQo+PiB1bnNpZ25l
ZCBsb25nLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gWXVmYW4gPGNoZW55dWZhbkB2aXZv
LmNvbT4NCj4gQ2hhbmdlbG9nIHF1ZXN0aW9ucyBhc2lkZSwgdGhpcyBsb29rcyBmaW5lIHRvIG1l
Og0KPg0KPiBBY2tlZC1ieTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+
DQoNClRoYW5rcywgSSB3aWxsIHBheSBhdHRlbnRpb24gdG8gdGhpcyBxdWVzdGlvbiBuZXh0IHRp
bWUuDQoNCi1DaGVuDQoNCg0K

