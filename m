Return-Path: <linux-wireless+bounces-12199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80523963A09
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A91C20D21
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A282D94;
	Thu, 29 Aug 2024 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1lL2bTLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE561FDF
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910694; cv=fail; b=GMjV1CqQKyAQzymB9VRe0Zp9ZmJ7wP1aPGNGPBJ8WbqjnCYmC4FE6PSt1aEtWACtQ0EmWTuLSjE0ProGnTbogQUTHuKHbJd6UNFLYWbnHo3k8bQJR4W21PcoBv6YmbD41+Umgg5ogr/fk+ULFImM/cZ8MqfpuaiJ9Zp2aZBOXos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910694; c=relaxed/simple;
	bh=2smE9OB/5dq65ripbCg9IS0P7nGviNOIvBe0jFZgJrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNBYsVnNSBXlTS7EXs9iZ6JeS+ZZbAL9THCpiC0JWBk7/l/rQxs7YNdQ1E1RHZsAqLAe0gqwYo8IbzHRYHjA2tEiwNnlwR/2EQzp3ketn7iG5W4XRUTTgZPFPIC9IiTOhasUdKZLpHlI0eoHI9QOn3SEwZuC1l3GjEtY49/fYOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1lL2bTLR; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5E4hSpGcNSk9rYwzPj1qr3ZfR4/2tIce92xPxT/5TuDPhKuyoMbDg3JuIE2/ZniiV/Ui+iJ0wAXVWamzsmB6bbgtY2AfsSZUSRRBCOLw/V//CZwJPmbPee3r5ufyh1XZLvRcwe9v6sZmG70029fEQRvcA5+VuCiIONYurrnWmKziJuzBtR1j9aR929RYI4uAL7T6lcZeCyPK5eQjjrbcP7VBt9vr7KeaKI8781im2ZBjUqqerNT55c47v7QmX7PY51M/tM+A+Su0+QnqmN6BfMCkln2tTX/aU3scBEAtGC8szS6Gaw/cQEuB8b+C14VqDxkCWooIzW8nEStRLsE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2smE9OB/5dq65ripbCg9IS0P7nGviNOIvBe0jFZgJrU=;
 b=MhpBfgLnKoASpD1Xbj9k5iq1QQZY7+A1zpSGZTP3Tpfjrhgb6gucijkaYCtEIb0RuTXrwzx4RCaJK7uMZbFzU0n1xwg4OlMOG+475BM9h8r8qp3EUcUaOJBVRgzkFKvwKJJ1tensrIph4MzPGSnvSzgaE1ALOKro0XGh/mUJ1Bk6Hq264A0Ckqn/WXZAQLaCpKRnCv6oJxiC9++e8/MStUzRIAatQYTGF/SHuGQRuHDYrkCTFa1/iVylaWLQhCJS/pEhtGFPyd1n4w2ZJ2Dmhcv8T1hL1lUosI/8dbxcAaDSLZo1D3NXwWtiOGMLVTa2aP69R/J2LUV1YLtnY/X4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2smE9OB/5dq65ripbCg9IS0P7nGviNOIvBe0jFZgJrU=;
 b=1lL2bTLR3DWwW/boc7TzDF2rrHlUrkOpDgcyESlq0sfW0m6CDCMrxjt1mkrw8Dbqmz70jorurH03lWgpTUxtNBjono7IgSy4FW6sqKPKn1WTXGSumFDdUSzL2N/pio82turb4Ld/9N8mL660jgkJ26qvqAlL9H1hBy57umgEAZBE2c4L2BGBvBYDbPnG0uQAXbwGnp840OihGr24UC3Kqr8hEaFW6fjwI5/NiFznbeOWBmBvfBtjJSJp7NzbGrGUzkV8kXoBaIERU0dUwRDRFW5UuJfLXPXIyhGrxAn9iiHjgviV7v3o09A4+YRaxtkTe70cI1XfcF0AcCwWY0Uq2g==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM3PR11MB8715.namprd11.prod.outlook.com (2603:10b6:0:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Thu, 29 Aug 2024 05:51:26 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%2]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 05:51:26 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <alexis.lothore@bootlin.com>,
	<linux-wireless@vger.kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Topic: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Index:
 AQHa8/lbON6r1hV5EkW52mJu7NaXnrI65e6AgABbhoCAARI4gIABLp2AgAAQ4ICAADPfAA==
Date: Thu, 29 Aug 2024 05:51:26 +0000
Message-ID: <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
In-Reply-To: <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DM3PR11MB8715:EE_
x-ms-office365-filtering-correlation-id: 014aca8c-2dfd-49a0-c5db-08dcc7ee9ed2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzV4bXI5YmdyVHRKaEdJcmNLbzhjcDRXVnU5cDVYTkE4aFpyTkFEMzZzUW5E?=
 =?utf-8?B?VVVDdmluK3hPV2NoZFpvaGYxa0FXWnhKdDZybEhwckR6ZkZ2cnpMQmllSEJa?=
 =?utf-8?B?b1BVblNiNExMNm1sTTRlSWpmMnZyOTc5N1Y5SFhwdGNwQXhZbERKZVNtZ1VG?=
 =?utf-8?B?b2oweHN3MkwrdEcxR29Ba01zYjJsL0c0UW84dGhQaWs5RjZDRHZJWVp1ZU5L?=
 =?utf-8?B?RU42OWU5ek5TbjVLUzIxbmFpVk94RFQ0ZmdVblN3VUFUREJaWFBIZ2lCQkNp?=
 =?utf-8?B?bU1UZkh2ay9UZ1E4RDJSVEQySUVpWVZxbTZJaE9qK2xKTHI2L0NqbDdsOTg5?=
 =?utf-8?B?MWRCYTlxNVJsKzV5VTd5czN4RDJMaHJEOWlNa0IxU1dwc1UvY1B3bkVaRmFt?=
 =?utf-8?B?emJrQUM5ZjYzak9wZm5hVTNIcTI5Qi81U2xnRzdTMEh6b1lvSkpQc1NvQzBQ?=
 =?utf-8?B?dkxkcENoSmo3ZEtHMlVjMU5KR0V3MlhoeDNSdlVZUWVxS05VVmhQa3ZOcjJN?=
 =?utf-8?B?bFBsN2ZJNDUvcW9pLzdaUzVmUzErbjVaOFpaYVc3aFJhNWxqcVVqRFFzQ1d5?=
 =?utf-8?B?cGpFazl2VTVOZlZoUFlHbG5pVW5MRjJsR0VtbVFvL0RCMk9ncHVscUhqb3dp?=
 =?utf-8?B?RHVYcWtKb2ZjTVNSeTFPc21GcVNiakRQdSs5UTJzVENMQlhEY3lRaWVOd0NH?=
 =?utf-8?B?UTlWWlB4SjBZYWVDUkp6MnhObUkyUHQ3VG5tZXpqNEppT1VrU0ZFY3E5bjhN?=
 =?utf-8?B?eDBUckU2ZXZ2aUdEbk5oQURhMnBxNE5JbGxnc3FEU0R1N21rcUc3TVJNTEcy?=
 =?utf-8?B?OXh4YSs2aGNGSFFTYW9SRTJtQTNkMmdGV1VtY0oydkovZyttQmlzYWw5ZEwx?=
 =?utf-8?B?UkZxR1hraTVvUWV3WjA1WVlMYjcvWStmOEVZTWdKTkR2VFd1dHkwSEV6Zkp5?=
 =?utf-8?B?eHNZUC91dXJzWWswcUJzdG1FQVByYWNtTGxFUnlFdmZaRURIc0FNcnVNVmd3?=
 =?utf-8?B?T2JOMGZsVXFnRVIrbkJYZW4vU2VWL0F1UzhqSGxoVHZvc0M0bDhncEVrbGRH?=
 =?utf-8?B?cjlQNkpYNVVXL0lteGpCWCtJcEhoK1p0di9xMnRBMEpTeE8rNkJvbjZUUUph?=
 =?utf-8?B?TmlCTHJ1TWhlRFFXRFVBdHI0NHJjRTJFQXJUd3ZSSkpDSVM0eWZsRkl2eDB3?=
 =?utf-8?B?OStVMlFZeGRiL2VmOHd6dzFWdWozNHdHK1l0dGlMbjlvb0dSVEg0ZW9hdmc4?=
 =?utf-8?B?ZzRhOFkrRjYxaHVoRDdaSWhzZmhITUltOWxmZVRCK0NYSFdNWkJONE0xcFZx?=
 =?utf-8?B?WVpTV3NxOUlDeGV3NE00Ukp6cGJSTVBmd0tYdjg5aVVvbHB0SDFEdUdBY3Bt?=
 =?utf-8?B?R1pORVYzR3dGa3M3VVcvbWtJbkRHckJydVdqb2xpamJaRmtTSjdnVXJLdEpE?=
 =?utf-8?B?dTZCcGcxMU1PcVpYMmZtUTRnWVVQVUZhcTB2TlAzYjNpWFpXSjJRY0RYV0lh?=
 =?utf-8?B?ODZxb2lwdS9RV29STHZDVHRBSFMzNitKcnVOUFhuT3FSaEwxK0l5TkZxOGF1?=
 =?utf-8?B?WENKajRRZW9SWG4yZlpUMUovYWRiano5R1JxbXluNS9ORnRrSGdNZE96QlU4?=
 =?utf-8?B?andjRzdPRGNXVnJHdjJ6b1pjc0k1Mlg0NVpERHU5eGVUVzBIeEl4MTZrb3ZL?=
 =?utf-8?B?a3FTNE1EUUYxUWwxejk5OVpYMmZPM2xWRmZrTVFnSVYyREF6U1E4MEQwN0tM?=
 =?utf-8?B?S05KYW11djVVWWZvZUVldk9rM0RCM214aDZnUEd6bWJxR2I5SXFoQjNQNXkx?=
 =?utf-8?B?NlVoZ0pjdnJUY2ZFUDZaQUlIcUxJRXZGSmtodFdZN09uN3BFMVlCMmdOSEJ6?=
 =?utf-8?B?YXlGT25jL29aUXdic3F1b0FweXltL3NzZUdtTXA3VjRETXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXRuOUl1Y0ZLRmRSQll2bXo5WmN4OHYrRTlEeVllOXJrWG4razVsS0lKVVU5?=
 =?utf-8?B?KzVVM3cxY0NyUkd5T2NrMDFVLy9rbG1yN1ZKT1QzcjlDa0IwR0c2cjF0OU1x?=
 =?utf-8?B?NWpNdlR6dHlDaGVyM0hFZ0lMNW9IRDBxVlM5aE9wL3lYRlVYd1c5ejZiSDhx?=
 =?utf-8?B?Tmx6YUNocmo2RlpKOGQ2M2Q2Q2RQd2Z0dFo3bXkzdDdJUUROYVl5dzI1NW5M?=
 =?utf-8?B?dDFGSm81Qk9JdHBYUnV4dk1zbktzSUwxR3BLQnFjRnVzNEp1K2RnVGVsNmZB?=
 =?utf-8?B?ckJDYmtDb0hDN0laOUlBT0tIWUF1Si80T2UyU1FLQVR0WTYzQmtGWGFRZkNZ?=
 =?utf-8?B?YzR6UzlzYmlJczZlb2VoU2V0UEc4eXE5cTVkM1NBcElmeVhlYUd4MzBwN1dZ?=
 =?utf-8?B?R0ZHTng4WlNNbVBvZ0xGNS80VHFodG5GSVVDQ21kU0JNNHR0emk1MzRXYXhN?=
 =?utf-8?B?V1M5SzBZNWhpV29sU1dPangzQk1JVVFoMERLQ2IydUs1WVNWUGR5S3pDZlRv?=
 =?utf-8?B?UDgyNGFhM3VkM2JlOXZmY2hHbmFROTJvdGVia2NvdnhPaDFLbjZjMWw0OGpz?=
 =?utf-8?B?eFhobHdack9HUXArZm1KejNoMi96cjNydkRINDhQZFdrQnk0RjZqbGZmQVIy?=
 =?utf-8?B?Zkw1MlFvS3dOeGppRXRnV1FVMUF3eTNIbXc2V2FSVVBsNldSdlRmS2taVkJR?=
 =?utf-8?B?RjdueW11b1c3NG9mMWR5a3JCZ3JGY2oxZ0ZIaVpQMm5yMVl2ZjJQQWNzYW9Y?=
 =?utf-8?B?SVNBVVUxVy9BNzZPUElTMkVodnBZT2ZscVZIdVVtZmJyTFI1SVppaWJhOWVG?=
 =?utf-8?B?YkJidnhUWlpGZCs3OXRva3hwL0tJTVBZQTI3bitJb29iZ3Q4eUZhTjFhK1c2?=
 =?utf-8?B?OERqOE5QT2x0eUI4NDNWUlZsMWRPbHJxZGhpMTFNUE0rMURXZ2M5OFp2Qk81?=
 =?utf-8?B?RW5UWEh6L0loNW1GUXFOSHg0c1pBMkNiOUlIZ1JXMno0cXk1TlNTdThKKzNM?=
 =?utf-8?B?NFlRaVpaUHNDVnZCajBnRG1tbTlBWWJER1VnRzNzK2hPemxRZXYrU1VSQUdU?=
 =?utf-8?B?aGJ6NVZmbnZjcFFWM3ptRXc1dVdpRGQzWDNjdFdjSlVNTnRZbU14K3hXOWRu?=
 =?utf-8?B?RGJEM1FsbVJkVHBCVE9XekUxY2QxYlRBL25LYmlHSnV4KzU0bkRpL0JVRFR0?=
 =?utf-8?B?NWdFemh5RGNQeEkyWGdMNmFuVlBJK3VITTU1WmNXYlhKV29kQW82Q0tOdktM?=
 =?utf-8?B?Z0xMZjd6NkN5RFBvWlZuUGZ4YWw5d2wyMWFXL1pPc25qQ2V2QnlwN1RFSGRw?=
 =?utf-8?B?K045dUtIQkJZdUNBMjd5RGtseVNMa1prSjhqTVVJMnIzVVRMeGttdGI2Q2or?=
 =?utf-8?B?a1dYTkN0eUVvQ3ROc1dMQTljbFFaK0xRSmxmbGU0YkN6bmlOTzArZ0FaNzY2?=
 =?utf-8?B?WXZoOWpJSnBRZWpjNUFTeC8wcElHYk1rRnJNOFZlZHFaZVM1ZFZtMGxWNVpo?=
 =?utf-8?B?cUJqWGJuVWRlS0tOYmoxM2xtUXU0RmtxQWtQU0VxMkpOTVpmalpqck1DN1p1?=
 =?utf-8?B?OXpZWnNuRndjOXdTTVE4aXZEaTVzZGVwalp5aHJjWjFJUFZkVDdodUVWRmZJ?=
 =?utf-8?B?YmxOWUFEak1BckQwZW1EQmRpZkN3YjJ6MXJxSE82dklqUDBIcFlUOEZkdEow?=
 =?utf-8?B?L2V2d0w4VlVaTzdWN1pQdjF0eTY2UEN3K0hqSGpwKzZKV090Q25KTDFzemdB?=
 =?utf-8?B?VUIxRjNKSUhPM2ZEcFptb0lqSm1KaFJLZU9kaDdUaVk4YVJuYzlzU2RHSnpD?=
 =?utf-8?B?ZFpDR044QkJjbnVyeDIzS2dLSXJtOHdPQjZWSUcyQ0FveEdOVnFvVkZPNW5E?=
 =?utf-8?B?T0pZRElHZm8xRHhUNjZmaEF3TVV6R0VnbU5KV3dPeGVQSnE0aUFtSU9vY0ht?=
 =?utf-8?B?bFhBSW0vMDlGTnI3NXFidjlCY2xoSHR6UzhFaWcyUHBLWTlwUGZIdS80dFNh?=
 =?utf-8?B?bnlYRDJXK0hEWXJNMWd0Q2ppVUhMVVpiRGxYTXkzMEJEdjkyNnBEWXJNdnE5?=
 =?utf-8?B?a2lqeTYxVmtCVUVGKzBKQldoNyttUGgzaVovRkdPZmMvTWdjdTM1OC94S2U3?=
 =?utf-8?Q?htaTiCw7LUZIXrOgmZP9a2BwY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FDACB9FBF3744991F58F777563E1C0@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 014aca8c-2dfd-49a0-c5db-08dcc7ee9ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 05:51:26.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQ8RaiLe4fm02TLS8SejvOKJhMjXZX/gJqbLHT+Nh3DFW16c5Sx5FSHnwqS1QzRFtfBhg11UZ1vu7gxuGXyaifX03g1vbObFZct+7dajc2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8715

SGkgTWFyZWssDQoNCk9uIDgvMjgvMjQgMTk6NDUsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDgvMjkvMjQgMzo0NSBB
TSwgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpLA0KPiANCj4gSGksDQo+
IA0KPj4+Pj4gVGhpcyBjaGFuZ2UgYnJlYWtzIHN1c3BlbmQvcmVzdW1lIG9uIG15IHdpbGMxMDAw
IHNldHVwIChzYW1hNWQyIHdsc29tIGV2ayArDQo+Pj4+PiB3aWxjMTAwMCBzZCk6DQo+Pj4+Pg0K
Pj4+Pj4gIyBlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUNCj4+Pj4+IFBNOiBzdXNwZW5kIGVu
dHJ5IChkZWVwKQ0KPj4+Pj4gRmlsZXN5c3RlbXMgc3luYzogMC4wNTUgc2Vjb25kcw0KPj4+Pj4g
RnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMNCj4+Pj4+IEZyZWV6aW5nIHVzZXIgc3BhY2Ug
cHJvY2Vzc2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAxOCBzZWNvbmRzKQ0KPj4+Pj4gT09NIGtp
bGxlciBkaXNhYmxlZC4NCj4+Pj4+IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MN
Cj4+Pj4+IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFw
c2VkIDAuMDA2IHNlY29uZHMpDQo+Pj4+PiB3aWxjMTAwMF9zZGlvIG1tYzA6MDAwMToxOiBzZGlv
IHN1c3BlbmQNCj4+Pj4+IHdpbGMxMDAwX3NkaW8gbW1jMDowMDAxOjE6IFBNOiBkcG1fcnVuX2Nh
bGxiYWNrKCk6IHBtX2dlbmVyaWNfc3VzcGVuZA0KPj4+Pj4gcmV0dXJucyAtMjINCj4+Pj4+IHdp
bGMxMDAwX3NkaW8gbW1jMDowMDAxOjE6IFBNOiBmYWlsZWQgdG8gc3VzcGVuZCBhc3luYzogZXJy
b3IgLTIyDQo+Pj4+PiBQTTogU29tZSBkZXZpY2VzIGZhaWxlZCB0byBzdXNwZW5kLCBvciBlYXJs
eSB3YWtlIGV2ZW50IGRldGVjdGVkDQo+Pj4+PiBPT00ga2lsbGVyIGVuYWJsZWQuDQo+Pj4+PiBS
ZXN0YXJ0aW5nIHRhc2tzIC4uLiBkb25lLg0KPj4+Pj4gcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9u
IHN5c3RlbSByZXN1bXB0aW9uDQo+Pj4+PiBQTTogc3VzcGVuZCBleGl0DQo+Pj4+PiBzaDogd3Jp
dGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQNCj4+Pj4+DQo+Pj4+PiBCdXQgSSBoYXZlIHRvIGRp
ZyBtb3JlIHRvIHJlYWxseSB1bmRlcnN0YW5kIHRoZSByb290IGNhdXNlLg0KPj4+Pg0KPj4+PiBE
b2VzIHlvdXIgTU1DIGNvbnRyb2xsZXIgc3RydWN0IG1tY19ob3N0IHNldCAucG1fY2FwcyB8PSBN
TUNfUE1fS0VFUF9QT1dFUiA/DQo+Pj4+IE1heWJlIHRoYXQncyB0aGUgcHJvYmxlbSwgdGhhdCB0
aGUgY29udHJvbGxlciBkb2VzIG5vdCBzZXQgdGhlc2UgUE0gY2FwcyA/DQo+Pj4NCj4+PiBJdCBs
b29rcyBsaWtlIHlvdSBhcmUgcmlnaHQsIG15IHNkbW1jIGNvbnRyb2xsZXIgd2FzIG1pc3Npbmcg
c29tZQ0KPj4+IGtlZXAtcG93ZXItaW4tc3VzcGVuZCBmbGFnIGluIG15IGRldmljZSB0cmVlLCBw
cmV2ZW50aW5nIHlvdXIgY2hhbmdlIHRvDQo+Pj4gd29yayBvbg0KPj4+IG15IHBsYXRmb3JtLiBT
byBpdCBiZWhhdmVzIGNvcnJlY3RseSBmb3IgbWUgd2l0aCBib3RoIHdpbGMxMDAwL3dpbGMzMDAw
LA0KPj4+IHRoYW5rcy4NCj4+Pg0KPj4+IExvb2tzIG9rIGZvciBtZSwgYnV0IG90aGVycyBtYXkg
aGF2ZSBhIG1vcmUgaW5mb3JtZWQgb3BpbmlvbiB0aGFuIG1lIGFib3V0IHRoZQ0KPj4+IGltcGFj
dCBvZiB0aGlzIGNoYW5nZS4NCj4+Pg0KPj4NCj4+IFdoZW4gdGhlIGhvc3Qgc3VzcGVuZCBpcyB0
cmlnZ2VyZWQsIHRoZSBXSUxDIHBvd2VyIGNvbnN1bXB0aW9uIHNob3VsZCBiZQ0KPj4gcmVkdWNl
ZCBzaW5jZSBpdCBpcyBjb250cm9sbGVkIHZpYSBjaGlwX2FsbG93X3NsZWVwKCkgc2VxdWVuY2Ug
d2hpY2ggaXMNCj4+IGlycmVzcGVjdGl2ZSBvZiBNTUNfUE1fS0VFUF9QT1dFUiBmbGFnIHN0YXRl
IG9mIHRoZSBob3N0LiBTbyBJJ20gbm90IHN1cmUgd2h5DQo+PiB0aGVyZSB3YXMgbm8gZGlmZmVy
ZW5jZSBvYnNlcnZlZCBpbiBNYXJlaydzIHNldHVwLg0KPiANCj4gSSB0aGluayB5b3UgbWlzdW5k
ZXJzdG9vZCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24sIHRoZXJlIGlzIG5vIG1lYXN1cmFibGUNCj4g
cG93ZXIgY29uc3VtcHRpb24gZGlmZmVyZW5jZSB3aXRoL3dpdGhvdXQgdGhpcyBwYXRjaC4gVGhl
IGNoaXAgZG9lcw0KPiBlaXRoZXIgZ2V0IHBvd2VyZWQgb2ZmICh3aXRob3V0IHRoaXMgcGF0Y2gp
IG9yIGVudGVyIHNvbWUgc29ydCBvZiBsb3cNCj4gcG93ZXIgc3RhdGUgKHdpdGggdGhpcyBwYXRj
aCksIHdoaWNoIEkgY2FuIHNlZSBvbiB0aGUgZHJvcCBpbiBwb3dlcg0KPiBjb25zdW1wdGlvbiBk
dXJpbmcgc3VzcGVuZC9yZXN1bWUuDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uDQoN
Cj4gDQo+IFRoaXMgcGF0Y2ggYXNzdXJlcyB0aGUgY2hpcCBkb2VzIG5vdCBnZXQgcG93ZXItY3lj
bGVkIGR1cmluZw0KPiBzdXNwZW5kL3Jlc3VtZSBjeWNsZSwgd2hpY2ggbWFrZXMgaXQgbG9zZSBz
dGF0ZSAoYW5kIGZpcm13YXJlKSwgc28gdGhlDQo+IGNoaXAgaXMgdW51c2FibGUgYWZ0ZXIgcmVz
dW1lIHdpdGhvdXQgdGhpcyBwYXRjaC4NCj4gDQoNCkR1cmluZyBob3N0IHN1c3BlbmQsIHRoZSBm
aXJtd2FyZSBkb2Vzbid0IGdldCBwb3dlci1jeWNsZWQgYW5kIGFsc28gZG9lc24ndA0KZm9yd2Fy
ZCB0aGUgZnJhbWVzIHRvIHRoZSBob3N0Lg0KDQoxLiBXaXRob3V0IHRoaXMgcGF0Y2gsIGlzIHRo
ZSBzdGF0aW9uIGdldHRpbmcgZGlzY29ubmVjdGVkIGZyb20gdGhlIEFQIGR1cmluZw0KdGhlIHN1
c3BlbmQgc3RhdGU/IERvZXMgYSByZXNjYW4gYW5kIHJlY29ubmVjdCBoZWxwIHRvIHJlc3VtZSB0
aGUgY29ubmVjdGlvbg0Kd2l0aCB0aGUgQVA/DQoNCjIuIFdpdGggdGhpcyBwYXRjaCwgZG9lcyB0
aGUgcGluZyB0byB0aGUgc3RhdGlvbiB3b3JrIGR1cmluZyB0aGUgc3VzcGVuZCBzdGF0ZT8NCg0K
QUZBSVIsIGR1cmluZyBob3N0IHN1c3BlbmQsIHRoZSBmaXJtd2FyZSBjb250aW51ZXMgdG8gcnVu
IHdpdGhvdXQgcGFzc2luZw0KZnJhbWVzIHRvIHRoZSBob3N0IHVubGVzcyAnd293bGFuJyBpcyBl
bmFibGVkLg0KDQpUaGVyZSBpcyBhbm90aGVyIHNjZW5hcmlvLiBMZXQncyBhc3N1bWUgYSBob3N0
IHRoYXQgd2FudHMgdG8gZ28gdG8gc3VzcGVuZA0KKHBvd2VyIHNhdmUgbW9kZSkgd2l0aG91dCBj
YXJpbmcgYWJvdXQgdGhlIFdpRmkgc3RhdHVzLCBpLmUuLCBpdCBpcyBva2F5IHRvDQpyZWNvbm5l
Y3Qgd2l0aCB0aGUgQVAgaWYgcmVxdWlyZWQgKGFueXdheSwgdGhlIEFQIG1heSBkaXNjb25uZWN0
IHRoZSBzdGF0aW9uDQpiYXNlZCBvbiBpbmFjdGl2aXR5IHRpbWVvdXQpIG9yIGhhdmUgdG8gcmUt
dHJpZ2dlciB0aGUgREhDUCByZXF1ZXN0IGFnYWluLiBCdXQNCndpdGggdGhpcyBjaGFuZ2UsIHRo
ZSBkcml2ZXIgd291bGQgYmxvY2sgdGhlIGhvc3QgZnJvbSBlbnRlcmluZyBzdXNwZW5kIG1vZGUu
DQoNCkhvdyBhYm91dCBhZGRpbmcgYW4gJ2lmJyBjaGVjayBmb3IgaG9zdCBwbV9jYXBzIGJlZm9y
ZSBjYWxsaW5nDQpzZGlvX3NldF9ob3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9LRUVQX1BPV0VS
KT8gSW4gdGhhdCBjYXNlLCBpdCB3aWxsIG9ubHkNCnJlcXVlc3Qgd2hlbiBjb25maWd1cmVkIGJ5
IHRoZSBob3N0IHBsYXRmb3JtLg0KDQoNCj4+IEl0IG1heSBiZSB0aGF0IHdoZW4gdGhlDQo+PiBw
b3dlciBjb25zdW1wdGlvbiB3YXMgbWVhc3VyZWQsdGhlIFdJTEMgc3VzcGVuZCBzdGF0ZSBpcyBu
b3QgZW5hYmxlZCBiZWNhdXNlDQo+PiBvZiBNTUMgY29udHJvbGxlciBwbV9jYXBzIGluIHRoZSB0
ZXN0IHNldHVwLg0KPj4NCj4+IEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGhhdmUgYSBnZW5lcmlj
IHBhdGNoIGZvciBhbnkgaG9zdCB3aGljaCBoYXMNCj4+IE1NQ19QTV9LRUVQX1BPV0VSIGNhcGFi
aWxpdGllcyBkZWZpbmVkIG9yIG5vdC4gV2l0aCBwcm9wb3NlZCBwYXRjaCwgZHJpdmVyDQo+PiB3
aWxsIG5vdCBhbGxvdyB0aGUgaG9zdCB0byBnbyBpbnRvIHRoZSBzdXNwZW5kIHN0YXRlIHdoZW4g
TU1DX1BNX0tFRVBfUE9XRVIgaXMNCj4+IG5vdCBzZXQgaW4gUE0gY2Fwcy4gSSB0aGluaywgc2Rp
b19zZXRfaG9zdF9wbV9mbGFncygpIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBpZg0KPj4gTU1DX1BN
X0tFRVBfUE9XRVIgaXMgZGVmaW5lZCBpbiB0aGUgaG9zdC4NCj4gDQo+IFRvIHJldGFpbiBmaXJt
d2FyZSBpbiB0aGUgY2hpcCwgdGhlIGNoaXAgbXVzdCBub3QgYmUgcG93ZXJlZCBvZmYgZHVyaW5n
DQo+IHN1c3BlbmQvcmVzdW1lLCB3aGljaCBpcyB3aGF0IHRoaXMgcGF0Y2ggYXNzdXJlcy4gV2l0
aG91dCB0aGlzIHBhdGNoLA0KPiB0aGUgY29udHJvbGxlciBtYXkgcG93ZXIgb2ZmIHRoZSBzbG90
IGR1cmluZyBzdXNwZW5kL3Jlc3VtZSBhbmQgdGhlIFdJTEMNCj4gd2lsbCBsb3NlIGZpcm13YXJl
IGFuZCBiZSB1bnVzYWJsZSBhZnRlciByZXN1bWUuDQo+IA0KPj4gQWN0dWFsbHksIFdJTEMgY2Fu
IHN1cHBvcnQgc3VzcGVuZCBtb2RlIHdpdGggb3Igd2l0aG91dCB0aGlzIGhvc3QNCj4+IGNhcGFi
aWxpdGllcy4gRm9yIFNESU8sIHRoZSBob3N0IGNhbiBiZSB3YWtlLXVwIHVzaW5nIHRoZSBleHRl
cm5hbCBJUlEgR1BJTw0KPj4gKHVzZXMgb3V0LW9mLWJhbmQsIGluc3RlYWQgb2YgaW4tYmFuZCBp
bnRlcnJ1cHQpIG9uIFdJTEMuDQo+Pg0KPj4gVG8gdGVzdCB3YWtlLW9uLXdsYW4od293bGFuKSBp
biBzdXNwZW5kIG1vZGUsIHRoZSBJUlEgcGluIGZyb20gV0lMQyBzaG91bGQgYmUNCj4+IGNvbm5l
Y3RlZCB3aXRoIHRoZSBob3N0IHRoYXQgd2lsbCBoZWxwIHRvIGludGVycnVwdC93YWtlIHRoZSBo
b3N0IHdoZW4gYW55DQo+PiBXaUZpIHBhY2tldCBhcnJpdmVzLiBXaXRob3V0ICd3b3dsYW4nIGVu
YWJsZWQgaW4gc3VzcGVuZCBtb2RlLCB0aGUgaG9zdCBzaG91bGQNCj4+IGJlIGFsbG93ZWQgdG8g
Z28gaW50byBzdXNwZW5kIG1vZGUgYnV0IGl0IGNhbid0IGJlIHdha2UtdXAgYnkgV2lGaSBwYWNr
ZXRzLg0KPj4gQWxsIHRoZSBwYWNrZXRzIHdpbGwgYmUgZHJvcHBlZCBpbiB0aGUgZmlybXdhcmUg
aW4gc3VzcGVuZCBzdGF0ZS4NCj4+DQo+PiBXSUxDIHN1cHBvcnRzIG9ubHkgQU5ZIG9wdGlvbiBm
b3Igd293bGFuLiBTbywgYWZ0ZXIgY29ubmVjdGluZyB0aGUgSVJRIGxpbmUNCj4+IHdpdGggaG9z
dCwgdGhlIGJlbG93IGNvbW1hbmRzIGNhbiBiZSB1c2VkIHRvIHRlc3QgIndvd2xhbiIgaW4gc3Vz
cGVuZCBzdGF0ZS4NCj4+DQo+Pg0KPj4gI8KgIGl3IHBoeSA8cGh5bmFtZT4gd293bGFuIGVuYWJs
ZSBhbnkNCj4+ICPCoCBlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUNCj4gDQo+IElmIHRoZSBX
SUxDIGlzIHBvd2VyZWQgb2ZmIGJlY2F1c2UgdGhlIHNsb3QgaXMgcG93ZXJlZCBvZmYsIFdJTEMg
Y2Fubm90DQo+IHJlc3VtZSBhbnl0aGluZy4NCg0KSSB0aGluaywgdGhlIHdpbGMgZmlybXdhcmUg
c2hvdWxkIHJlc3VtZSBidXQgdGhlIGNvbm5lY3Rpb24gd2l0aCBBUCBtYXkgZ2V0DQpjbG9zZWQu
IEFkZGl0aW9uYWwgY29tbWFuZHMgdG8gc2NhbiBhbmQgcmVjb25uZWN0IHdpdGggQVAgbWF5IGJl
IHJlcXVpcmVkIHRoYXQNCnNob3VsZCB3b3JrIHdpdGhvdXQgZG93bmxvYWRpbmcgdGhlIGZpcm13
YXJlIHRvIHdpbGMgY2hpcCBhZ2Fpbi4NCg0KDQpSZWdhcmQsDQpBamF5DQo=

