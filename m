Return-Path: <linux-wireless+bounces-12366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91349969594
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04840B22EF9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAC1D6DBD;
	Tue,  3 Sep 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XjoX7vfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2333171C9;
	Tue,  3 Sep 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348707; cv=fail; b=eDRAg6CvHb4g61ZhsoURQxmA7V3Fq2ngghaft5WkeKqUGI7gI2uQNZKAdxqbYGjj8EvG3LVXdC0A0AdNqOWcOl5SJlre6Cao/ah1GbeWY5dSvMu6IrotUrbjgG6FO5v7h47zpr9/UQxKgEr0pPNphOkPX50V2d1mHyL5DF5cgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348707; c=relaxed/simple;
	bh=mSym4AEGRxLpR0+BiZnjfkMYKG8WYJ+LTS5GWD28ixc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NyLRoZmejbJNSIA2zZFassFaUajVRLSxcnC225gRv7/sPdu4S1JpFMl7g5yYU8wL55V6c9ovNj4XYE3gKAxZqkJCoSQoNPqcU1OX0R6l/do0FqTNv2bQDI3AzbnEiHsAqKSKE21v8BPLWmr+q2R38pBkMecq/f8AXSbIYad2syk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XjoX7vfg; arc=fail smtp.client-ip=52.101.67.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfqRD+qHk8/ctPZhhRHcM4fHN6PP53D7f/3HsT7N6qhPeT38CPPRzawK18fMhpjq/kaIvhbniBvRmkmR8hjG2mGyCqg83HD+Bb/jkFN7w4Ieamho92a8Tm1fOV4IqQyDtpY+TK4IyDmddcDsRwQ5nfqoM6zNCgtPETIyhLNe908DYD4sn7kMqC9u343Cgs54hA9pZwv/e8zYSCEzz1ckoDwVBBxJN7Fmu11GVL4lO6xFCCqvmOGmWvpQvDRlezfmU1zf10yoq0+GQqpIqWulBlUZwc+m3x9/c4rUinNtoA8TjfGLpD5C0hvlMaMRVHc4fP8G4X4giqroKNpZlIJB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSym4AEGRxLpR0+BiZnjfkMYKG8WYJ+LTS5GWD28ixc=;
 b=smr1WSTvsePthF48jbjOVtuyYF35RULY59OfDh2iTgh4FaieFZ6wXTS5qC7sqJWYnxhNY8VZmC6h8z6v2UuC9a3gBi529WgEd5Euv2HnRQEXcTevuRTClSojyTJa0bWxn2babm9rEvWLjIeXGzubpV+htqxbP+Rga4Dp7I8o0+Svu9ZoGXcP2BjtllpHJVewPwm/XRNWvWCW16TlXV2Fuxb0g16MSWghMJQjlFB3bvyNQLDccN8dLG/9Bd+dnCszDF/TLowpy+25/rWYCSjyOB0wcrvofdTl7K8egF5k+MVxfceq3P548oNhj1k6A/zixiVwVW/CkuCd3U8+cDfF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSym4AEGRxLpR0+BiZnjfkMYKG8WYJ+LTS5GWD28ixc=;
 b=XjoX7vfg/CIPDimuW20UqH4vlSqxu2QgvL9qMiePVdH5qA1+d9EMXFhpzyYmwUHfOWZbCU3BUQrklvGim/xmpjg+c4hxYdHp3GjsmqFamv+M7T+TBTWKpLvzaVm/ivB90gbZsIIUf1d0GhiHzh284cXXFsLIWuQOmjej0xieqoyhbVcuO2DeyQG9umZtZCkCoAb4214u5jzwfVHXKu9jlZqGpbkyH/dkSkPxl/6bIz+cO1mvHo/fIzEEdzzxpozDGbyimdQrMcE+rl6C9Y+1owVfHOo74JYDEFX8iGZbg52jjCZJnCC159g5tk6/B+Jx1a2hHZ179myKgAn6O3OXRw==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by GVXPR04MB9951.eurprd04.prod.outlook.com (2603:10a6:150:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 07:31:34 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 07:31:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, Kalle
 Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] [PATCH] wifi: mwifiex: Ensure all STA and AP use the same
 channel
Thread-Topic: [EXT] [PATCH] wifi: mwifiex: Ensure all STA and AP use the same
 channel
Thread-Index: AQHa+qnYHrrDRYExSEOP0OMKvuP91LJFsKuA
Date: Tue, 3 Sep 2024 07:31:34 +0000
Message-ID:
 <DU0PR04MB9636AF11600D2ABF286FA6EDD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
In-Reply-To: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|GVXPR04MB9951:EE_
x-ms-office365-filtering-correlation-id: 59a73911-4961-4b72-014a-08dccbea7011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NldNaFVnckxOQkpJMXJaRnlWeTg3aHVHc2J2ZjREU0xIVEczNHhyYlprZXcx?=
 =?utf-8?B?NXJIbThKTjRBemY2VTI1WmJ1Wk5LQXZ6cTNMalQ1dVVuU2JMZktQc1pxd3BP?=
 =?utf-8?B?N0V2d2kxRmhvcXVGWkpMN1Zra1ZBYXJrSklWYkJYNDVKSXFHN0E0ZW5qeFZO?=
 =?utf-8?B?L1JBMTA3Nk54MnJwUUFlZnozNnRaUDZKQzNGOE9lak4yOEFTY2tiMHBQOWR6?=
 =?utf-8?B?RWZjSkJwdUMvSkdjTHFuQjF4TloxdStnTE1iUkhHOGRmZU94V3U3azQvUjcr?=
 =?utf-8?B?OWtqOFdpMzRvVlk0cWJUN2Z3bTROVHVyYkJBTWVJRzhHcUljUTlpckdGZG1U?=
 =?utf-8?B?SHppOFRUcVQrNCtOeWpBWGdBdUhQOHNUZ2FnSXFPK2lEdHIwdWl6S1ZYYTVW?=
 =?utf-8?B?ekwwS3J3UC81ZkdXbzhvNnI0K1BHaWRBTnRvTzcrT0lKOFJsSC8xQVpGdDIz?=
 =?utf-8?B?R2NWbExnV004L2w0blpRSzMrcTdaeVZmc3JmTlJKdGtlOWJqeG1yNFRkUTRp?=
 =?utf-8?B?cS9XL0taV3lZd2J0K1k1V0NCR05sYU42bWFrTHFKaWJKNDBMdTZZWVhDdVVo?=
 =?utf-8?B?bnZlMTNrMEUzRGg4U0xiS0tBZmp0dEd4c003UTVaZlBqQjRtWGROVUZrNUtD?=
 =?utf-8?B?WFkrTVEwZXJhd3lpdFVSak9sMktka0ZkWVgvY29RWXBJZ1pabm5sajBGVDhB?=
 =?utf-8?B?VkphZ3hLNlV1cTJ4RS9pTExtWVVkd3Btbk4rcUk1QU93Yks4RDZQTytyajNP?=
 =?utf-8?B?YS9jK3dXdkxqdnhSVyt3ektxVXpVRnR5Wm90ckxCMFVLQ0l1ck1ZRTZjcFJX?=
 =?utf-8?B?ZENzcW5SUzlFNzE4REs3NXZzdFZkS3RWcW10Z1E4S0N3QVBnWlNsOTVsNEZv?=
 =?utf-8?B?SHpJNlU0V1l6cnVkYlZPckV4ZEg4Z3E2cUhoSHJaMG56bzhhZ0RUMks1cUwz?=
 =?utf-8?B?clArc21oZjJaN0YxY05MRG1ES3EvRDlKeEJGTzFSLzlhOStxR2hISGdmemZF?=
 =?utf-8?B?Q1pUUzlNY0RDQm9TbHhzSWNZdU1RS2VaWUZlMXZkK1RBUG9ybXYvVW5sYkM1?=
 =?utf-8?B?OFV5V3p4Q0pZSW1rRU1tdGVkV00zS2E0NEVkb3Z2d04yeWUvTGVidW53bXpt?=
 =?utf-8?B?VmpoS0txVllOYmhUeCtTZWR4UGk3WjdaVGlDeS9qdWR4TmFnT0d2VnpNNTJj?=
 =?utf-8?B?WlU1dkQ3WHNrZCs3N3ZVMVBtTmdmbnR0QTlNdXRPLzd0aU1PZElHT3VEbUh3?=
 =?utf-8?B?OG1hcUlielhpOFpWNGkwQ3VxUC9NSjV0UW9Ib1JMalU1SEluZ0FUNGNKVVZB?=
 =?utf-8?B?dHdjZUxoVjBERTFYdUpDUEtveWROVkRwQUZuVkdLbUFrajNSUzB2Yk9hNWZE?=
 =?utf-8?B?OWUvUXlwN3dCVW5kUk1qRTBYMHRPWVcyZGNpRTV4TWY5cGdTb28rSWswd1dR?=
 =?utf-8?B?YTVEODgyV0RXcFUyWU9qNDBZMXd3bWRKRlpUQk1VRkl4a2dBV0NQZ2lGam4w?=
 =?utf-8?B?MmdUQjk1YTNhYUNkWng2YklaRlZUUURPZmlXazcyQWNNOERkSkh1QUxWQXhJ?=
 =?utf-8?B?cnZUUjEwWWk1MElYTXRMVnlNYnZEbkNEckZHNkVMMmtaSDA3RHh3ejBFNVFt?=
 =?utf-8?B?TWl6V1VBVUp5V1ErMWhMam9JcnFWaUFCVEgydWhpYjdmNlU3UU50dUdXLzZh?=
 =?utf-8?B?SHBMV1FiWmtRRFFxMzlkMzdOc0lMamNLVW53S3VEYVJRSUcxeHBuZVdzVzFL?=
 =?utf-8?B?bEhjSEcrWHh5RStKQTRHSWNwL3g3SnhBNitub3VLSUNrT29nbElQRGpKblFz?=
 =?utf-8?B?a1VvaWpTYWV6WGlGbktqMTRpNlVzbXQ2R2Y1SDJabW1vZlNFeWorekgyVEwx?=
 =?utf-8?B?Qk8vaGtXd3ZFUE9PcWc3c1JwQWxFN1dRbkNHZjV3cEY2eVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVNaS1FKb3hmNjlwTGJWN3EyT3pOMk1qeTdodE84aThoUmhPdDRPUXh2N0xB?=
 =?utf-8?B?T3laNkVlNnVaZ0dYaUowbWhNYzZuT3Y2SWdZNW8wVTdNZFEwSmpobzByTnBU?=
 =?utf-8?B?dkMyeDNLYW42NCtUQWhZNG1Gd1JtUUpDWThqa2daVTFyYWlIUmxPYU9LeWJF?=
 =?utf-8?B?UVpKVDBtVmplZzFaOWg3bm5meVNjTXlKUUN5WFpscFMzWGl2Sk1CRFBMZDF4?=
 =?utf-8?B?dnR4YjJYMTlwT1RGZWQ2WjlNTERtVXlSd2VJM1IyZlJJMzN3MWtWZkNtSGxx?=
 =?utf-8?B?OUNQaTZiWjFxcmhBWW4yMkJPMm9jVFBHZ3EwVUJTV29QRGlhcU90OUFKQW1S?=
 =?utf-8?B?YStYK3loelhsM0JHUjNBU05PTU9HZ3NWUGFBNW9lVDEyK2FUeVNLL1ByZHN6?=
 =?utf-8?B?NEJlOEVXWWl1S1lBQ1lKSjJEY1dWT3g4UWMrMGZnbmxZbWx0Z0lMUWZDYnJR?=
 =?utf-8?B?NVZzK3BSclRud3ZxSDlqMC9XOFBWcHA0eFNHYTUxT0Rxc1pRL3FMcEtTUlJE?=
 =?utf-8?B?Z0FOZ2JDeml5ZTJ0ZkZHZWhEaldxa3JGRzBmUVphaDIzZXJ0bHNmODdJVzdE?=
 =?utf-8?B?RHpxa1JocFRiL3o2RFBwR3gwVDg2YU1KdDBoVUFjWnJHMmkvSDdadENpUGM5?=
 =?utf-8?B?ci80WndnS0llR1phWXV2alc0RUxyOS9CbVR4VHQzMThMUzJBR3daYlJKRHpE?=
 =?utf-8?B?SS91azFObFB2UzhDL3V2WGFFTW9nUGhVR2Jvc21wTUlYZG5sZThySUtyVWwx?=
 =?utf-8?B?ZkhKbjRJRkdyY1FDaEo3Mk8zOTkrZWtZdEU5VzJPYTdybmZIbkl4UG9NK0Q2?=
 =?utf-8?B?STNoNnhyRk1XZTg1L2FIN2hSb1YxZzNhMFNDUk1tTmVPRENWVEg0S3BaY3pm?=
 =?utf-8?B?TXVMU1EyR0RIN2ErZ1FGOEdQSXlBQXpBNXAxVzZBNzRoMVlZUTQwNVdDZmV5?=
 =?utf-8?B?cGsxRWY1alJZa3NxbUZxSngwSEVhbm9seVo2OEIzV2lOUnB3RVVSZ256amF2?=
 =?utf-8?B?dVp1ckZudmZHQURZM1ZEcEFWemJzZGZiQ2pOL2I3MUgzOTBsTS9lUXRXa3gw?=
 =?utf-8?B?WlAxZ29uMHo5M3JXaVovMmRCS002ZFl6WVV0SWtvdk9JNjYwUWpUcExMeENr?=
 =?utf-8?B?Y1VCcTdST3pKWG96R0NFbUF1RC9QWE5oaGVjVjZxOEk0MWUyZ3NDeVpJNDlW?=
 =?utf-8?B?TkQ4QWhSSEZFZGV0S2MvSTgvRWd2R0RTQU54Ukl6Uit4dWxvQlp4Wi9nLzU1?=
 =?utf-8?B?K24vb3p0VCtoUksvWWZLbVJKdVFRbzNOZGNnUEtnUmFrWGwvUnNkSVZTaUlk?=
 =?utf-8?B?NXNsTlJnM2NlSjVDcnhQeTVBT1ZxbjZzdGlWKzJhbDRlRzNwbEFvT3RLc2wr?=
 =?utf-8?B?b0VjZTd2c05hQ2J2aW9TTmRwR2drY3RGcWVDaWU4eVJ2cVVNVXBXTGlvOEx2?=
 =?utf-8?B?aHlQZnIxSEE0Y3hZQUhPQmtXVjRtMjdGWlIrSFNEQWZLenRZblNhVXM5ODNR?=
 =?utf-8?B?NDJpYUExVkNsaUM1Umt6S0FUZ0hHdGVEVEZkOXFDZitzdGxKaGRYNVJ3a2pM?=
 =?utf-8?B?Yno3aHlxL1dhZkkzRlR1MDVYRGo4R0U5SWVaS1JFSVhxQlRuVVQ4RGJzdGs0?=
 =?utf-8?B?cW4yUFBjeFRBVnorMys1TjV1M2xQM0dUV1JtVndTZTBpT2dWZDY2Mk9VWEZZ?=
 =?utf-8?B?OUliandYZTJURWtUdURVWENadGpFZVlYSWp4a1Fvc1VURnVITFpCQXplRTB3?=
 =?utf-8?B?SDE4bzdyZTlvVWszV3ZiQ1Nsa0VUUUhtVHlzT2xBUHZIamNVZ2trdXNMbjlV?=
 =?utf-8?B?VU5CVVl4ZHZqSTdrRThSekw1ZFc2Q21yazhXYkY5NnUyaFJWZ3JWbUtaZ1Y5?=
 =?utf-8?B?Q2JjeTJ5VHdyanNkMWNZbHRCeG1lcnJvVDN3TWd2Z2oxa2VSQVE0aXF0T3lT?=
 =?utf-8?B?L1VmQTJlVzRVb0lYYTVZZmFsd2hFT3BUUmJGV01ZbWJsSTRLZ2hUbTVMZHNs?=
 =?utf-8?B?aXJUTWNWQjZhc1MzbTIwQlBqci8wb3cvMGdkRkFudGpnUVVqak5sR1IrT0lS?=
 =?utf-8?B?RENTY1BLd3NsN3JTVUFsQjNkYjJZaWZZQnFiMGtsck1wWURVUHU5d00xZi9X?=
 =?utf-8?Q?jJdQdbHZqHVjMGphadeWE6zfQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a73911-4961-4b72-014a-08dccbea7011
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:31:34.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/rjnMPxdVeo17XS13ZrOp1Z3+B0shl3jkI0bdBeWmsX5iOraWovSozRcgdf47oZ+oi30mqSrO34yMAdikNErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9951

PiBGcm9tOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IEZy
aWRheSwgQXVndXN0IDMwLCAyMDI0IDI6NTcgUE0NCj4gVG86IEJyaWFuIE5vcnJpcyA8YnJpYW5u
b3JyaXNAY2hyb21pdW0ub3JnPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjb0Bkb2xj
aW5pLml0PjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FzY2hh
IEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbRVhUXSBbUEFUQ0hdIHdpZmk6IG13aWZpZXg6IEVuc3VyZSBhbGwgU1RB
IGFuZCBBUCB1c2UgdGhlIHNhbWUNCj4gY2hhbm5lbA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9y
DQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2Fn
ZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBUaGUg
bXdpZmlleCBjaGlwcyBzdXBwb3J0IHNpbXVsdGFuZW91cyBBY2Nlc3Nwb2ludCBhbmQgc3RhdGlv
biBtb2RlLCBidXQgdGhpcw0KPiBvbmx5IHdvcmtzIHdoZW4gYWxsIGFyZSB1c2luZyB0aGUgc2Ft
ZSBjaGFubmVsLiBUaGUgZG93bnN0cmVhbSBkcml2ZXIgdXNlcw0KPiBFQ1NBIHdoaWNoIG1ha2Vz
IHRoZSBBY2Nlc3Nwb2ludCBhdXRvbWF0aWNhbGx5IHN3aXRjaCB0byB0aGUgY2hhbm5lbCB0aGUN
Cj4gc3RhdGlvbiBpcyBnb2luZyB0byB1c2UuICBVbnRpbCB0aGlzIGlzIGltcGxlbWVudGVkIGlu
IHRoZSBtd2lmaWV4IGRyaXZlciBhdA0KPiBsZWFzdCBjYXRjaCB0aGlzIHNpdHVhdGlvbiBhbmQg
YmFpbCBvdXQgd2l0aCBhbiBlcnJvci4NCj4gVXNlcnNwYWNlIGRvZXNuJ3QgaGF2ZSBhIG1lYW5p
bmdmdWwgd2F5IHRvIGZpZ3VyZSBvdXQgd2hhdCB3ZW50IHdyb25nLCBzbw0KPiBwcmludCBhbiBl
cnJvciBtZXNzYWdlIHRvIGdpdmUgdGhlIHVzZXIgYSBjbHVlLg0KPiANCj4gV2l0aG91dCB0aGlz
IHBhdGNoIHRoZSBkcml2ZXIgd291bGQgdGltZW91dCBvbiB0aGUNCj4gSG9zdENtZF9DTURfODAy
XzExX0FTU09DSUFURSBjb21tYW5kIHdoZW4gY3JlYXRpbmcgYSBzdGF0aW9uIHdpdGggYQ0KPiBj
aGFubmVsIGRpZmZlcmVudCBmcm9tIHRoZSBvbmUgdGhhdCBhbiBleGlzdGluZyBhY2Nlc3Nwb2lu
dCB1c2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1
dHJvbml4LmRlPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9jZmc4MDIxMS5jICB8IDUyDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lm
aWV4L21haW4uaCAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9t
d2lmaWV4L3N0YV9pb2N0bC5jIHwgIDMgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwv
bXdpZmlleC9jZmc4MDIxMS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lm
aWV4L2NmZzgwMjExLmMNCj4gaW5kZXggNTY5N2EwMmU2YjhkMy4uMGQzYmY2MjRjZDNkZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2NmZzgwMjEx
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2NmZzgwMjEx
LmMNCj4gQEAgLTIwNTQsNiArMjA1NCw1NSBAQCBzdGF0aWMgaW50IG13aWZpZXhfY2ZnODAyMTFf
c3RvcF9hcChzdHJ1Y3Qgd2lwaHkNCj4gKndpcGh5LCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0K
PiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gK2Jvb2wgbXdpZmlleF9jaGFubmVsX2Nv
bmZsaWN0KHN0cnVjdCBtd2lmaWV4X3ByaXZhdGUgKnByaXYsIHN0cnVjdA0KPiAraWVlZTgwMjEx
X2NoYW5uZWwgKmNoKSB7DQo+ICsgICAgICAgc3RydWN0IG13aWZpZXhfYWRhcHRlciAqYWRhcHRl
ciA9IHByaXYtPmFkYXB0ZXI7DQo+ICsgICAgICAgc3RydWN0IG13aWZpZXhfY3VycmVudF9ic3Nf
cGFyYW1zICpic3NfcGFyYW1zOw0KPiArICAgICAgIHU4IGJhbmQ7DQo+ICsgICAgICAgaW50IGZy
ZXEsIGk7DQo+ICsNCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRhcHRlci0+cHJpdl9udW07
IGkrKykgew0KPiArICAgICAgICAgICAgICAgc3RydWN0IG13aWZpZXhfcHJpdmF0ZSAqcCA9IGFk
YXB0ZXItPnByaXZbaV07DQo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5u
ZWwgKnVzZWQgPSBOVUxMOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAocCA9PSBwcml2KQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgc3dpdGNoIChHRVRfQlNTX1JPTEUocCkpIHsNCj4gKyAgICAgICAgICAgICAgIGNhc2UgTVdJ
RklFWF9CU1NfUk9MRV9VQVA6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghbmV0aWZf
Y2Fycmllcl9vayhwLT5uZXRkZXYpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghY2ZnODAyMTFfY2hh
bmRlZl92YWxpZCgmcC0+YnNzX2NoYW5kZWYpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHVzZWQgPSBwLT5i
c3NfY2hhbmRlZi5jaGFuOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiArICAgICAgICAgICAgICAgY2FzZSBNV0lGSUVYX0JTU19ST0xFX1NUQToNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCFwLT5tZWRpYV9jb25uZWN0ZWQpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
YnNzX3BhcmFtcyA9ICZwLT5jdXJyX2Jzc19wYXJhbXM7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGJhbmQgPQ0KPiBtd2lmaWV4X2JhbmRfdG9fcmFkaW9fdHlwZShic3NfcGFyYW1zLT5iYW5k
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZnJlcSA9DQo+IGllZWU4MDIxMV9jaGFubmVs
X3RvX2ZyZXF1ZW5jeShic3NfcGFyYW1zLT5ic3NfZGVzY3JpcHRvci5jaGFubmVsLA0KPiArDQo+
IGJhbmQpOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHVzZWQgPQ0KPiBpZWVlODAy
MTFfZ2V0X2NoYW5uZWwocHJpdi0+d2Rldi53aXBoeSwNCj4gKyBmcmVxKTsNCj4gKw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgICAgICAgICAgaWYgKHVzZWQgJiYgIWllZWU4MDIxMV9jaGFubmVsX2VxdWFsKHVzZWQs
IGNoKSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBtd2lmaWV4X2RiZyhwcml2LT5hZGFw
dGVyLCBNU0csDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhbGwgQVAg
YW5kIFNUQSBtdXN0IG9wZXJhdGUgb24NCj4gc2FtZSBjaGFubmVsXG4iKTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAg
ICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+ICAvKiBjZmc4
MDIxMSBvcGVyYXRpb24gaGFuZGxlciBmb3Igc3RhcnRfYXAuDQo+ICAgKiBGdW5jdGlvbiBzZXRz
IGJlYWNvbiBwZXJpb2QsIERUSU0gcGVyaW9kLCBTU0lEIGFuZCBzZWN1cml0eSBpbnRvDQo+ICAg
KiBBUCBjb25maWcgc3RydWN0dXJlLg0KPiBAQCAtMjA2OSw2ICsyMTE4LDkgQEAgc3RhdGljIGlu
dCBtd2lmaWV4X2NmZzgwMjExX3N0YXJ0X2FwKHN0cnVjdCB3aXBoeQ0KPiAqd2lwaHksDQo+ICAg
ICAgICAgaWYgKEdFVF9CU1NfUk9MRShwcml2KSAhPSBNV0lGSUVYX0JTU19ST0xFX1VBUCkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gDQo+ICsgICAgICAgaWYgKCFtd2lmaWV4X2No
YW5uZWxfY29uZmxpY3QocHJpdiwgcGFyYW1zLT5jaGFuZGVmLmNoYW4pKQ0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gKw0KPiAgICAgICAgIGJzc19jZmcgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgbXdpZmlleF91YXBfYnNzX3BhcmFtKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICAg
ICAgICAgaWYgKCFic3NfY2ZnKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvbWFpbi5o
DQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uaA0KPiBpbmRl
eCA1Mjk4NjNlZGQ3YTI1Li5iNjhkYmY4ODQxNTZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvbWFpbi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21hcnZlbGwvbXdpZmlleC9tYWluLmgNCj4gQEAgLTE2OTcsNiArMTY5Nyw3IEBAIGlu
dCBtd2lmaWV4X3NldF9tYWNfYWRkcmVzcyhzdHJ1Y3QNCj4gbXdpZmlleF9wcml2YXRlICpwcml2
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXh0ZXJuYWwsIHU4ICpuZXdfbWFj
KTsgIHZvaWQNCj4gbXdpZmlleF9kZXZkdW1wX3Rtb19mdW5jKHVuc2lnbmVkIGxvbmcgZnVuY3Rp
b25fY29udGV4dCk7DQo+ICtib29sIG13aWZpZXhfY2hhbm5lbF9jb25mbGljdChzdHJ1Y3QgbXdp
ZmlleF9wcml2YXRlICpwcml2LCBzdHJ1Y3QNCj4gK2llZWU4MDIxMV9jaGFubmVsICpjaCk7DQo+
IA0KPiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiAgdm9pZCBtd2lmaWV4X2RlYnVnZnNfaW5p
dCh2b2lkKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdp
ZmlleC9zdGFfaW9jdGwuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmll
eC9zdGFfaW9jdGwuYw0KPiBpbmRleCBkM2NiYTY4OTVmOGNlLi45Nzk0ODE2ZDhhMGM2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvc3RhX2lvY3Rs
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L3N0YV9pb2N0
bC5jDQo+IEBAIC0yOTEsNiArMjkxLDkgQEAgaW50IG13aWZpZXhfYnNzX3N0YXJ0KHN0cnVjdCBt
d2lmaWV4X3ByaXZhdGUgKnByaXYsDQo+IHN0cnVjdCBjZmc4MDIxMV9ic3MgKmJzcywNCj4gICAg
ICAgICAgICAgICAgIGlmICghYnNzX2Rlc2MpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtMTsNCj4gDQo+ICsgICAgICAgICAgICAgICBpZiAoIW13aWZpZXhfY2hhbm5lbF9jb25m
bGljdChwcml2LCBic3MtPmNoYW5uZWwpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVCVVNZOw0KPiArDQo+ICAgICAgICAgICAgICAgICBpZiAobXdpZmlleF9iYW5kX3RvX3Jh
ZGlvX3R5cGUoYnNzX2Rlc2MtPmJzc19iYW5kKSA9PQ0KPiANCj4gSG9zdENtZF9TQ0FOX1JBRElP
X1RZUEVfQkcpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29uZmlnX2JhbmRzID0gQkFO
RF9CIHwgQkFORF9HIHwgQkFORF9HTjsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNjdhNzIw
NDNhYTJlNmY2MGY3YmJlN2JmYTU5OGJhMTY4ZjE2ZDA0Zg0KPiBjaGFuZ2UtaWQ6IDIwMjQwODMw
LW13aWZpZXgtY2hlY2stY2hhbm5lbC1mNDExYTE1NmJiZTANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gLS0NCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KDQpQbGVhc2Ug
dXNlIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9w
YXRjaC8yMDI0MDkwMjA4NDMxMS4yNjA3LTEteXUtaGFvLmxpbkBueHAuY29tLyB0byByZXBsYWNl
IHRoaXMgcGF0Y2guDQoNClRoaXMgcGF0Y2ggY2FuJ3QgbGV0IEFQIGFuZCBTVEEgcnVubmluZyBv
biB0aGUgc2FtZSBjaGFubmVsIGlmIHNvbWUgd2lwaHkgcGFyYW1ldGVycyBhcmUgc2V0Lg0KDQpE
YXZpZCANCg0K

