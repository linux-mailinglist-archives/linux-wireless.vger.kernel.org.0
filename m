Return-Path: <linux-wireless+bounces-8061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CD8CEEA4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 13:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B637D281ACE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C831A83;
	Sat, 25 May 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYthAKIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D81208CA;
	Sat, 25 May 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716636268; cv=fail; b=XydsFMAdYqYO0LgcIH5TOa4CGcw+Y7bMKIVSDH9iwIAOy4ABrgVbpSx5N3fjshBuy4w0wTu8VXa0L0qSD+54aioJsgsW6/no/GoazhB54ScfV2K1Jh7s/wb77sDPAQ+QJYDxyxKXBcMCPX71DtddxVeykRBcH5BSjKfe/GnB9/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716636268; c=relaxed/simple;
	bh=YAZIhPlWGguGg81LwDLdw7aFoMM5nno2hR+pyosLqdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv7n+1hrxnenSSe6spkFsU0qo1Em+2VqnB+tonyFH4Sq9xe5/xPDTv9i7iL++gmp/UhHZa3Vhjb4AEUzwNEbZ+v1WOyJ3UbW4dGmo/sZkCCfGfIGxwfm0bONzGmLCmKWX+X9lK65mhcAQaqMDQkqlSCxmFfXzcFPQwTAj7qLO1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYthAKIT; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaFEOKfakr7IRfFA6QMEIS90LV9zfcSFTR7hZIB0ZrTbe4UpASmXiBzJ9LhmDvWyyWS08IELwk23aPYbdSoAh/YYQBxxnQazNg/E41+2gJVqOrEfFuGLCnWLEndkSrcwy8V1m3QFlwIDsof9G1UhzHTV3srPw6EWogRsoeH3y4A8RROIu3ATdDLqiO08GyNmpW1vVMQxdH3ElVyn1wSgL16g7Uf/5cwdNSQJ9jbsXnBSn15Gnv/h6qDQ4MefhcFmvUdwnp9O402iuMTUYn8IBjBa9kvc/4Xns/QOfXDMvqVrtz/QcaAZoHC4g1Q+p2+1WgQ4MJHzuow8OoBmdEBcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAZIhPlWGguGg81LwDLdw7aFoMM5nno2hR+pyosLqdM=;
 b=njdMitfjmiBK99B+Y2T1hcKCc0xLHFuHQ6J6WRBJo6wTmGzM/ZfXJC7kwGrBrnZhSpiWHTori7ekEBzSWd8NiWXuZbGA9p1qJ4ngZIURTjJU3Z+yCcn2yfvzWGvq9z21a1Dp0gIrWlhyOAKql6yqgQlZNPH4xsTa+GSootJ6tHuFitLHWZzRlro/ZKkfTmlSbuFgszT60nP39qPoqUoU2rV4csK6D1fvL3IX5F2WBovih5oTu1TlqohEIk7tCt5b0mDaoBdwTWVOIt24fIVzbBkLTWcAKgfvHKSwSCJbqtxkDtAbHo1vJA5DGJGbo6Jm56D1JHmbL7p4uQgvWTO+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAZIhPlWGguGg81LwDLdw7aFoMM5nno2hR+pyosLqdM=;
 b=DYthAKIT2pKhu+Pakw2VdUlPgRVDVnDBuL2Hun5i8cIC5H3EnIF2ujqzcyQfV/aNJN3W5dr0ffeSW561TLF1cVdRyzl57U5oJ/gC/E7OcP4U7pYpvAwNMqG+gE8zRj+2VKnXHbIGv0upd4HAJgv7Rwh6/bZQ8nFqAMK7PkCPvqg=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8933.eurprd04.prod.outlook.com (2603:10a6:10:2e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 25 May
 2024 11:24:23 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7611.016; Sat, 25 May 2024
 11:24:23 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index:
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYIAAsVAA
Date: Sat, 25 May 2024 11:24:22 +0000
Message-ID:
 <PA4PR04MB963812F8835270C237DBCC55D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8933:EE_
x-ms-office365-filtering-correlation-id: c78a2892-edbd-4a07-82ea-08dc7cad3a5a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1pkYkpYN0FwbUJrOHlpSTQ1U3g4aHBrdjBKU3d3NU52NE5rN2dOWE9MOVJL?=
 =?utf-8?B?dlZZVEh0ejF0Um9xNW9CcHdnakQ5YzhBRVl2Ym4yZzluMGMyKzgwRnNpRVV0?=
 =?utf-8?B?Z2ZKd2JqR0NlR2xUY1IxTE5NdWlla3k3akZ0V0VQWVhqanNsWGM1M3JnKzhB?=
 =?utf-8?B?QmJ6VFUrOVA3NE9EU21HWWJkb2Jncm5aR2V1MkJRWE1pdTJCUHhiRVlKRHIv?=
 =?utf-8?B?cFdlOGw1WGNQNGt6SWNJSWVBekNpQW05eEt1RmtMSEFNTGVXVldXekxpdTRN?=
 =?utf-8?B?UXZTUmFvbUpqdVBJL3dqc1hKRWRUNWo3dUY2ZE5xRHVCSkxhdGxNcXJmQmxa?=
 =?utf-8?B?bS90MllDZFRYUWlPZzlIK3NubHpPTzNxeHVKZE9XbThKaVZHMm56WnRaVWY0?=
 =?utf-8?B?WkdoUHpqUWo3U3VPUjF4MS9KVzFJVGxhUDRRWmVneVpUczYrQU9qb3NORzFU?=
 =?utf-8?B?RklhTWI2RGNOWW02bjRBQlVpL3JiNUt5ZmlhWVRReU1heTVEcFRsalVsWnha?=
 =?utf-8?B?NFU0YkJ0ZkFtSjFIUzJRL3VYc3ROZ2Z6aXhIQmVwUUZSUkdtOXNRK29Vemho?=
 =?utf-8?B?NDd4TUdGaUFGR21Ma2lMbjE5Z05vMWpoc3R0RXY3ZWtVeDRpK0pCQnB4aUJs?=
 =?utf-8?B?S3RlTjVtdjJhajhKbldBa0lnMjdTTXRYbEpTcWxWbm92c21PKzV0L1B3T2R0?=
 =?utf-8?B?N0pndGJMQWlBc0hXb1daL1k3TGRZVm5JTWw3ZkFJNjd6Q1hycmlUd3hPZzhP?=
 =?utf-8?B?TVpGTjRRZlpmd1cwYUV3YjEyMjRVV3dOSDZPRVlFd3d6dFhOTUUxcW1SVm50?=
 =?utf-8?B?dWxMbFRvbHdxS2djRXZXU0gwalhzc0xQcVNPdXJXUUhSRFM0cDZHZGIrZFRP?=
 =?utf-8?B?cXRiMHB0VHdxZDJ1VmhjNnhSU2h5bXV1V2hIRm1vdEdNK25aWGpaQVdKTkFy?=
 =?utf-8?B?TGlwQnJZWjJUYTYzaUxMRlZvODFUNVFMZE0xRzBvaXFFRG5FckNPRi9ZeXVY?=
 =?utf-8?B?aVpRMHJLVFlkL1lhWXR2RzV3WCszV2Rja3ZzSURGMWxPYS9XUmQzSmlUVzhQ?=
 =?utf-8?B?SE8vZ1JoZE9OVDMwYThkSGtrVnBLZWhaSnVFc0tVL2h4aDV5amRVR0d1R0lG?=
 =?utf-8?B?M0RSQnU5c2lWcjE1SVJTeXNNcENPM2tTSG9VbkZ6N3FDZmw1WHI0Ynpjbm1K?=
 =?utf-8?B?dUVzaXBKWUp5c0E1RGVUMi9SMlRiYUdiYkl3THRDeVJCSkhlNnRtQjN2cVNj?=
 =?utf-8?B?T3FrWVNNNlZvRXpHbERUZGV0aVNXa1pQQUJsZkZlM3ZqbWk1aytseEZlamdj?=
 =?utf-8?B?TDJXdlN5a3hMbmxRR2pBQTN2b1c4NkdDS3ROeFVQZEZoSDdGUlY4MGxvSDZx?=
 =?utf-8?B?Y0RhaUdjV3hWNkU4dTJLTnRST1NJSG1xM1k5Wm1YeEZVQVJkeFFORk9uTkJo?=
 =?utf-8?B?VmVhbFIvdnY4ellTeWR2d0RLeSszM1lDdWFSUk1lSG53cGNUeDZZbkhXYm5R?=
 =?utf-8?B?TmZBOXZLQnpjdGU5NzZrc3lESmsySHY0Vkp3U1VvbU1UcmZQVU1UOXVreU1o?=
 =?utf-8?B?eWZPai9acTM5TFlheUJkR0dBRTNZVXE0dHlTS2tXL2lIcG03cjUxK2E0YWZQ?=
 =?utf-8?B?RUJ2RFhaVFdMVmV3K0RCVDZvdkZjbklFM0svWjhYaGFDM082bGJqUEJLSFor?=
 =?utf-8?B?dllkUzk5a0NsS0RaYm81T0pqRE5FbVJ4aWs1V1dqNVRMbHg2NHc1aXdiTDdr?=
 =?utf-8?B?U094OXJsb1kvMzQ0dlF6RFFoUnJaMGNuaDVOZDlJdkxzY3lwYmNZRyt3TmJ5?=
 =?utf-8?B?WDVMTzlUdFNWVEFoWGZ4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2FLaE1mTlUwZzBqRE5oaUY0MUFUclhLUDNETHloempSSHEydTlQZHJacjM0?=
 =?utf-8?B?dTZ6RkdPclhMZ2F1a0kvc00xSjEwUi9ZT2ZjejJTSDVFNFN0S0tzbnZNYTla?=
 =?utf-8?B?aVhmL1VEOGlLS1dHUVh3NHZRUG0rUVBWNDd6SDJFbUJPcHVpdzhTOWh0Ym9q?=
 =?utf-8?B?UWVTYUZzUnBRTmNNVmxTSjdTNFFndDNhZ0pPMkVPcnlyQ0JtTWhLZzRwY01Y?=
 =?utf-8?B?Q2V1dXY1VHRYZ3JEdGRVdWV2RFdDcHJTb3JvV3MrYXhJSkZQa0hBK05KelpB?=
 =?utf-8?B?V053UVdRZzZXRlhPRGpKQjJ0M21PZ1p4bVpSZzM3R0p6WFpjUHIzQmNXVXdL?=
 =?utf-8?B?UUVxRWFGeSt0eHRYdnJHOUlrRUtyTVhsN0xCSjlWeWFTL2hZdzhVdUZvWWJM?=
 =?utf-8?B?TlVxYjg0ZVJaZ1ZBSGlnYXFWUGY0eGhtRzEyaXZCMjhsa1YyZDZxWmF4U1Fq?=
 =?utf-8?B?SnFPVU5kZmhSTUEvSytpOUx0L1JwMDJ4MDc5UEtRbnNhUjdaem1FMzBQOTVy?=
 =?utf-8?B?NW1TbkRHdHE2TklPTUR2Q1ZpOXZpQUk4d1NqRWZucmsvbEFZQUFES21rOWhN?=
 =?utf-8?B?cm9EdFdJR2VQb3BnRzFwUGtoVVBEWjQ2OWdEaGwwNVNrZzBwNVkxbXJNVWw3?=
 =?utf-8?B?VzhZZHZVemk5Wm9ESlRucG5MZEd3MXN4M3JlOVJDNFhYL2YrUGlaY0l6RDFx?=
 =?utf-8?B?WEZLN1RrVi9KWUUxR2hmZlp5ZURRck1pVDZHdlIyQVlxNmpBS2RWZG5xMURC?=
 =?utf-8?B?QVZhWmtpaXhQNSszWGJWWmVWUjltajg2dzNzdlJnTzRsSE5EUmRhdkpvMk9z?=
 =?utf-8?B?U0xoNzlEbXVlbUlNWHZVMFRxcWcrM3ZEK0JkdEFKODh1SktORlNSK201Q3M5?=
 =?utf-8?B?NkwrcmFzVFlPOGNsWE5zRmc5SXJxaHlia09meGNtMTlIREI3YVFIaitEamlo?=
 =?utf-8?B?cHZjME1ydCtsbFNHc3MwUU5ocmQ2cklOQXBxNXB5Vjg1NlhVWWlrRjM4WHhJ?=
 =?utf-8?B?SjNHT2JwYXg2aGpWTDN2S2wzVGhINFY5U2NQazhkYU5wWExxU0o5ZlpkMlNm?=
 =?utf-8?B?ZTJ6dmpvdTdrbjczeEdYeFloL09wZ1gramplNElXNUhucFNpcWVwZTlXZndj?=
 =?utf-8?B?eFdOMWNYbFA4ZjZ3RGJNZ1k5ZG5idjlMRnZWcEUvNkVSYlp2VTcyeTJFK3dn?=
 =?utf-8?B?aWI3TVh0ZGRIUmptRTdhTWNZbkJ0eTdjY3JxcVZyRnpPd3hrREdWTzFBbG9F?=
 =?utf-8?B?VkdlYm5tRzREZDh3YVBsQWIzNlZha3hVUmNPN09scmJtbDRJdzN2cU84SmpT?=
 =?utf-8?B?dnRVRkxwRUtTaFB1T3BvVzhGMGpPOE9DNDM1ZTY0Vys1M2N5R01XS0tmR3l5?=
 =?utf-8?B?VG42bDRtZlNwOWdwRFpicGlYK2hZazRYd1dRSFF3VkRleXhuSnQzNmhPQ2JC?=
 =?utf-8?B?NFNZbzY0ek4rR1RMZUxaMlRGMkxCQ3ZvY0dtWE9lZGd1RmVIMzVSb0xpK2RK?=
 =?utf-8?B?US96clZhSFZRc2pnNWFONjlxT1prN3hFTGFTSStvV09DQWRCMVdib1lHbito?=
 =?utf-8?B?cnpNTXBjMDZ1M2J6Z3cvWVA0UksrN2hKRlFaWlZpdExnTC9PWFMyY2dlUGN6?=
 =?utf-8?B?M2xuQTZ1U1A1eEZLQkJ3OWRSMzdFMkNRYWFFRzVoUUlSeXd5VU11cEZ4KzY5?=
 =?utf-8?B?RTB6R1c2QlMrRDJ5Qlp3QzJyL3JWWjN0bzRTZHhmak9nTXVYQ1l5akJkRGVL?=
 =?utf-8?B?UVFUeGFlek85RmVBRnRIdDljNVBlc1pGZ1laN05qdGtZckdKQWhVMUtGNEhl?=
 =?utf-8?B?THNyRzhDSmlEZWlLZjVzRWRFUWNsek41Q2UyZG5SRkpuVno4UUt1TDRSYWJ0?=
 =?utf-8?B?eDU0Qk1KWnJ3Q1hIYWUxWHZwa3Q3NWVOQ2M0Q1VZN3phYkJWSVZxeHdCVXF1?=
 =?utf-8?B?eHNMNURtV21NMGpGemI2RjRMc1Jrd1hORURzNkd6SlJ5ZnNkRGFyRVpuTnhR?=
 =?utf-8?B?cVZWWTVGRnQvaUhPN1hBQnNNVlFVc1hwY3NqeFpMcE5wSUUwOUJ0UXZHYVNx?=
 =?utf-8?B?aHBPdVhqVmIvdmh5VFA0RFJkbkh3SHpLbXh6ZXUvNHdvdG1tMHRTUURMeWFY?=
 =?utf-8?Q?qBKq3Ht2Uf8gGHtASQ4TrL+eq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78a2892-edbd-4a07-82ea-08dc7cad3a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2024 11:24:22.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhPXcjhDGXA4IqVNlCSjm5yjpHvJTbTOMeyMPmiWGBCGVM4GCRaGAG0g+V7lkuF5F3ezAK5Ts+X63vdHjE6mvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8933

PiBGcm9tOiBEYXZpZCBMaW4gPHl1LWhhby5saW5AbnhwLmNvbT4NCj4gU2VudDogU2F0dXJkYXks
IE1heSAyNSwgMjAyNCA4OjUxIEFNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNo
cm9taXVtLm9yZz4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNlc2NvQGRv
bGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+OyBGcmFu
Y2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBbRVhUXSBSZTogW1BBVENIIHYxMCAxLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBob3N0
IG1sbWUgZm9yIGNsaWVudA0KPiBtb2RlDQo+IA0KPiBIaSBCcmlhbiwNCj4gDQo+ID4gRnJvbTog
QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+ID4gU2VudDogU2F0dXJk
YXksIE1heSAyNSwgMjAyNCA2OjU1IEFNDQo+ID4gVG86IERhdmlkIExpbiA8eXUtaGFvLmxpbkBu
eHAuY29tPg0KPiA+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNlc2NvQGRv
bGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47IEZy
YW5jZXNjbyBEb2xjaW5pDQo+ID4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiA+
IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMCAxLzJdIHdpZmk6IG13aWZpZXg6IGFk
ZCBob3N0IG1sbWUNCj4gPiBmb3IgY2xpZW50IG1vZGUNCj4gPg0KPiA+IENhdXRpb246IFRoaXMg
aXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZw0KPiA+
IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUg
bWVzc2FnZSB1c2luZw0KPiA+IHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiA+DQo+
ID4NCj4gPiBPbiBGcmksIE1heSAyNCwgMjAyNCBhdCAzOjAx4oCvUE0gRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gSSB0aGluayBpdCBuZWVkcyB0aW1lIHRvIHN1
cHBvcnQgcHJvYmUgY2xpZW50LiBDYW4gd2UgcHV0IHlvdXINCj4gPiA+IHN1Z2dlc3RlZCBjb21t
ZW50cyB0byB0aGUgY29kZSB1c2VkIHRvIGhvb2sgcHJvYmVfY2xpZW50KCkgYW5kIGFkZA0KPiA+
ID4NCj4gPiA+ICJUT0RPOiBzdXBwb3J0IHByb2JlIGNsaWVudCIgdG8gbXdpZmlleF9jZmc4MDIx
MV9wcm9iZV9jbGllbnQoKS4NCj4gPg0KPiA+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0aGF0IHlvdSBw
bGFuIHRvIGFjdHVhbGx5IGltcGxlbWVudCBwcm9wZXINCj4gPiBwcm9iZV9jbGllbnQgc3VwcG9y
dD8gRGlkIHlvdSBhbHJlYWR5IGRvIHdoYXQgSSBzdWdnZXN0ZWQsIGFuZA0KPiA+IHVuZGVyc3Rh
bmQgd2h5IGhvc3RhcGQgbmVlZHMgcHJvYmVfY2xpZW50IHN1cHBvcnQ/IFRoaXMgc2VlbXMgdG8g
YmUgYQ0KPiA+IGNvbW1vbiBwYXR0ZXJuIC0tIHRoYXQgcmV2aWV3ZXJzIGFyZSBhc2tpbmcgZm9y
IHlvdSB0byBkbyB5b3VyDQo+ID4gcmVzZWFyY2gsIGFuZCBpdCB0YWtlcyBzZXZlcmFsIHJlcXVl
c3RzIGJlZm9yZSB5b3UgYWN0dWFsbHkgZG8gaXQuDQo+ID4NCj4gPiBOb3cgdGhhdCBJJ3ZlIHRy
aWVkIHRvIGRvIHRoYXQgcmVzZWFyY2ggZm9yIHlvdSAuLi4gaXQgbG9va3MgbGlrZQ0KPiA+IGhv
c3RhcGQgdXNlcyBwcm9iZV9jbGllbnQgdG8gYXVnbWVudCBUWCBNR01UIGFja3MsIGFzIGEgcHJv
eHkgZm9yDQo+ID4gc3RhdGlvbiBwcmVzZW5jZSAvIGluYWN0aXZpdHkuIElmIGEgc3RhdGlvbiBp
cyBpbmFjdGl2ZSBhbmQNCj4gPiBub24tcmVzcG9uc2l2ZSwgd2UgZGlzY29ubmVjdCBpdCBldmVu
dHVhbGx5LiBTbyB0aGF0IGxvb2tzIHRvIG1lIGxpa2UNCj4gPiBwcm9iZV9jbGllbnQgc3VwcG9y
dCBzaG91bGQgYWN0dWFsbHkgYmUgb3B0aW9uYWwsIGlmIHlvdXIgZHJpdmVyDQo+ID4gcmVwb3J0
cyBUWCBzdGF0dXM/IEFuZCBpbiB0aGF0IGNhc2UsIEknZCBzdGlsbCByZWNvbW1lbmQgeW91IHRy
eSB0byBmaXgNCj4gaG9zdGFwZC4NCj4gPg0KPiA+IEJ1dCBpZiB5b3UncmUgcmVhbGx5IHBsYW5u
aW5nIHRvIGltcGxlbWVudCBwcm9wZXIgcHJvYmVfY2xpZW50DQo+ID4gc3VwcG9ydCwgdGhlbiBJ
IHN1cHBvc2UgdGhlIFRPRE8gYXBwcm9hY2ggaXMgYWxzbyBPSy4NCj4gPg0KPiA+IEknZCBhbHNv
IHJlcXVlc3QgdGhhdCB5b3UgcGxlYXNlIGFjdHVhbGx5IGRvIHlvdXIgcmVzZWFyY2ggd2hlbg0K
PiA+IHJldmlld2VycyBhc2sgcXVlc3Rpb25zLiBJJ20gZnJhbmtseSBub3Qgc3VyZSB3aHkgSSdt
IHNwZW5kaW5nIG15IHRpbWUNCj4gPiBvbiB0aGUgYWJvdmUgcmVzZWFyY2gsIHdoZW4gdGhlIG9u
dXMgc2hvdWxkIGJlIG9uIHRoZSBzdWJtaXR0ZXIgdG8NCj4gPiBleHBsYWluIHdoeSB0aGV5J3Jl
IGRvaW5nIHdoYXQgdGhleSdyZSBkb2luZy4NCj4gPg0KPiA+IEJyaWFuDQo+IA0KPiBZZXMuIEkg
a25vdyB3aGVuIGFnaW5nIHRpbWUgb2Ygc3RhdGlvbiBpcyBvdXQsIGhvc3RhcGQgd2lsbCB1c2Ug
cHJvYmVfY2xpZW50DQo+IHRvIGNoZWNrIGlmIHN0YXRpb24gaXMgc3RpbGwgdGhlcmUgYmVmb3Jl
IHJlYWxseSBkaXNjb25uZWN0IGl0Lg0KPiANCj4gV2l0aG91dCB0aGlzIGZlYXR1cmUsIGl0IHdv
bid0IHJlYWxseSBhZmZlY3QgbWF5b3IgZnVuY3Rpb24gb2YgaG9zdGFwZC4NCj4gDQo+IFRoYXQg
aXMgdGhlIHJlYXNvbiB0aGF0IEkgc3VnZ2VzdCB0aGF0IHdlIHB1dCBjb21tZW50cyBhbmQgVE9E
TyB0byB0aGUNCj4gY29kZS4NCj4gDQo+IERhdmlkDQoNCklmIHlvdSBhZ3JlZSB0aGF0IHRoaXMg
ZXh0cmEgY2hlY2sgY2FuIGJlIG9wdGlvbmFsLCBtYXliZSBJIGNhbiBqdXN0IHB1dCB5b3VyIHN1
Z2dlc3RlZCBjb21tZW50cyB0byB0aGUgY29kZS4NCg0KRGF2aWQNCg==

