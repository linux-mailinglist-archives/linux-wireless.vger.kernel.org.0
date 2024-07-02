Return-Path: <linux-wireless+bounces-9823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A4923C4D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C4282DE5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8315B0EE;
	Tue,  2 Jul 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jw1MKw/4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42215B10A;
	Tue,  2 Jul 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919410; cv=fail; b=ktZc+uaGH9zewX5WmZ4Wk9rXJmJ0hKYuibsSD9kPEij3fkefYxRqKArMbI9ClFVVcGBby9U89VR08smShXh35kxz9ZR/XvCo8P5954DEnPp2bNz1YHH3pWdkoG5UYCyKppWFs1VEnXMcqQ1NGHddAt1/RlUH5dmHIVuW81yG55k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919410; c=relaxed/simple;
	bh=UtuZXMhCygTaQQ/5nO4rKP5d2+92bQsM+UsB/8w1l7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1pAOa6jhNjPahEFeQhCby5YNon7D7IOuYYLfhqlgmaDChtTcOkB4q5dnak9TPBQSNk74C7/sDuWl2NKjWYc+sPYf+9Uwj+pFNb6YfY+sFNFU9sCzgypSAMjcGw/O1TxoYJzVu8oU9UxegAWLgCWqgMJ59rXXNXr1Fld6P0rRho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jw1MKw/4; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESAbpwCZWTomO4q7UWF1gGXt5SgFBVCy1qh33d6JzNIx04O/HjXWrl+KYGTH091R6s7vflNDpa/3TqNQHOdvE2rXwGQ+G0BOgeSm/9woyODZMD9TQwv1kMTYUN8RAh+icbjaxXH92km9g0pjPAWgPsf1oSjUw0RUeeZq8CG6qU+6F0KXh9QmsF2G1wi2GknBST3O6gxa9TjByBJQeYe1XyyGcFJ+aMyhFvrPcfSRgnfuD1VZlKGJ2O47zSHfnwmTu91L7vMkyxKtW+0p77UkpShKjMtYMU4mttXkehy/n1fzS5njLjTuIEVQSEZizMFlkP51rVxRf/RLuxcnHr8xJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtuZXMhCygTaQQ/5nO4rKP5d2+92bQsM+UsB/8w1l7c=;
 b=AohMGC/lkJgpMNRomiI7hwdjBmteBVQUghvTDsaaC7Y3nPR/kCbFC5Jc8beJSY+4M24Z8IhKc0Son55C8fXPwa6YJX9spHX3LwHT4acUrj/+4dF8sZvWC8Qo1S6L+0hEkRsL9NKRnnCU7dUP/BUSiibmKYN46wn++3dq2FaCjzxm2YCofc9T6SQfjQfCjB735nsLwMhjNyA9i2SDz0L1sdF8bJFla9eX8GuvFdQT3Psq5UxdFXyK6fBK8V8DLWYxvq+285iuFmhR9iXszygQG7EDw9B7/dVb9nwq4cjJkL9i/CKYAttuBlAxxOzH00tTcb8f0hDZ2K6coLYDG8EWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtuZXMhCygTaQQ/5nO4rKP5d2+92bQsM+UsB/8w1l7c=;
 b=Jw1MKw/4RLFHXadZ1Jxp1ZcN8/GEOqG9BFUkqbzD1Y5c+diStZ34+ZgSE/E9PYOKHnxIEYpl0J5V0le+GJeDYm9Wd4rjMdCSBWIJVE5tYflExuBeXj/sVHsYSl/y802q0hqJm8K1hN/aHfl4UfyGOFC1eSly69ZJOMlM9uPWdrU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 11:23:23 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 11:23:23 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
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
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYIAp+uAAgACzNCCAD344wIABSOwAgADyKeA=
Date: Tue, 2 Jul 2024 11:23:23 +0000
Message-ID:
 <PA4PR04MB9638B0940ED592CB80A883BFD1DC2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com>
 <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com>
In-Reply-To:
 <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8301:EE_
x-ms-office365-filtering-correlation-id: 130b6cd1-87c2-40d3-5ebf-08dc9a896251
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmsvRGVEQ2hwd3NxM3ZyM1hHc3N2Z0xabzg2ZzdTZmp5MWx2QU5IVEpOSzJY?=
 =?utf-8?B?TFpFMVZwSVk0bDB6MFZQdlF1U1lZbndUYWpEd0VXYnd6YWJSU3lyUjd5aGRE?=
 =?utf-8?B?QXYwNVF1Rm9IV3l6WWR4dS8rcGcveUYya1hSalpnYTBsaU9wbFIxMGVJT3pO?=
 =?utf-8?B?TTRsMmVIaWxkbk50d3UxbXFVNG5ybzlqUkNOamx0SVIvWkh1aGxUdFE5V0ZJ?=
 =?utf-8?B?Zlc3UUowTjRxZmhIRWl6U3NiR3crVGNLRHpBc2c2SEVqM2JCM3dKbFJqelJk?=
 =?utf-8?B?UVNMUEwzNlVobWRWUHppVzRHM3BxVlJ2V21ZNURrK1BFaHlxRlZqZENYOXVu?=
 =?utf-8?B?K2ZackQ2L3E0bThKNXhra01zeU1VN2tLejVHME91VXVRdW9jNTZuRExFQmg2?=
 =?utf-8?B?b0orMTJ4aHNLUWpwMDloMXFKZFRyRDZzM2JjdWJuSFBpVWpVWmNHc1BHNEx3?=
 =?utf-8?B?VlBOU0NTaG5PazBZQTlUQndiQ3FrcnlhdmZkWkFtRzFrZUpIMitkbVptaGVs?=
 =?utf-8?B?WTZwakJ3RGZNK216bVJpNy9wN0hqbHRoUlA1U25sbGVZZlFja2hnZ1BNdUlI?=
 =?utf-8?B?TFVaMFlSeXFKbU1HcXZ2Tjd1L2IxbXVSR012OXVKdzI5WjlYMUFEeDZ5RU4y?=
 =?utf-8?B?b2trTktLL2ludFZONkh5R2ZjQUs1WjhLZDFLVEpyWjJIWkJuN3dCNy9SNHJT?=
 =?utf-8?B?RGZ3NFNSZGVteUQzM0lkMkovZ0hUQ1Nqby9wV3djR2lpc0pxRmFSNUJDOXRU?=
 =?utf-8?B?QTJIdzRwUE9ybnhScm80ZjJpMVZVaHpPSEw0RXp1MmlRejFoZ3JhUHlTckQ4?=
 =?utf-8?B?NmZvaGREeEFiN2NycFVjbE01MTNveXpMR3JtSm1sVEg4WERBQ0hkeS9KSzZD?=
 =?utf-8?B?UHM1YkJzL0F0SC9raUZQMzNUQ0VZei95TGVrK01XSklKbVNza1JxQ1NqUTcv?=
 =?utf-8?B?MlBjeGZrd3ZJVTFnbEZyMUdjL1BNWmdzMTBieHlXVFZXdmdZdXZGanFOTXYz?=
 =?utf-8?B?VnQrdWV6WHVEeUFJbUhPZ2RCSGlRUXN2b2swOTVNT09HdXY5UWZEb2FOYWow?=
 =?utf-8?B?L1BhQlVxQzF5dmcxazlRaWlEVjB1VG00OU5ZRHRVZXBDVlBEMms2UHpOQWor?=
 =?utf-8?B?WW9XY0lmOFM1RWFjTEZyU0M1TFB6eVFmRXB6MmI2dDhYdHQ3azMzKzU5SklY?=
 =?utf-8?B?bXF3dTNjNDJjWE5qYUluMFoyTGNXN2dDUnJYMTE5WE9iMENXcTVwSnluZmVL?=
 =?utf-8?B?OW1QUWpsRk1CNlBlcEdpRDVMOHZ1dG4xQmo2aFJzQVZPbmlYSDlRd2ExZVNy?=
 =?utf-8?B?WWh4cUpFa2ErOVpXaWQwNmhmVW4velh2cDFoeTZwS2d6TlNFMllod3ZrWnRy?=
 =?utf-8?B?Ky9BM05YRjZYc1EwbVZCM0RmSzFlZDhBczNGc3JFblphcUp5NnlCdllDSGUw?=
 =?utf-8?B?dEx6SVNVYkUzZW0xeWgzbDJvSFlzSC9OTG9uUHNaeG9SVTllZ2ZtTFZ0YjU1?=
 =?utf-8?B?SWtOZ1VvR0lBU04vYWJLbXVoQThCZkpLOWx5U0xsd3k0czdFYklRb2M5ZXlL?=
 =?utf-8?B?d1ZwV01LMlZYNVk0Yi9rSmEveEhERVRzUTRWemhjZzMyZUhBSUt1cmxyZVFq?=
 =?utf-8?B?dUV3alhidGpKcjNPVDYrOTZ5U0dwK2IzUEZZNmI4UHloNU82L2t3UTlsbnVa?=
 =?utf-8?B?QWNlc2MvZnNnc0drZXRLWjRTWnV0UFdKdHFxcEpKT2NibEF3M1pxTGpCaTZm?=
 =?utf-8?B?V0tLNGpuQ1Z3MHhZNGlidnBqRTZ5WllMeERETzVuQkxaSlR0V08rQ2VUQldY?=
 =?utf-8?B?QTZ0cElEd1pKVFdOQ29EZklDNENtLzhjSCtVelZWTmxaS0pWWnhjWkFpQW9T?=
 =?utf-8?B?UFQ5SDZjRnBxK0NWT1BjMW9Xd3MxYVphNUVhaTZkczc0MGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWY3VnE4UEUwSFh0RGpCcVZwaXdqMEJab1prMGRMMERlL1FzT1h5MStIdndN?=
 =?utf-8?B?VE5wWDc0Z3QrWEFoVkV4Q29vNEljV0ZYakZYaGl1T0tHVUhGdVY2ZkRxT3p2?=
 =?utf-8?B?dFpCd1NXamJDNHdmRlYzSksrRTArYUt3V2k0WFE2TjZPeG5ZV0pOV0pFOUhj?=
 =?utf-8?B?SHZTRVlUbjFBWWJWTW01azh0dFZVNnFSNnFQSGxqVDNaYU9EWTE1SVhBalZE?=
 =?utf-8?B?SlNCL0M2YzIwYmZIUHZtbTh5aWNFMmQ4TmxUclUvWmlyYVFNeHU4NTd6QXNQ?=
 =?utf-8?B?eXF2UXJpeEFhR3QzOVRTU1BKVjE4S2QwV3JvWTZDQTlvMDVsOWdiV0lkWlZW?=
 =?utf-8?B?UFVlYjE2ZGU3WDNuRC9IVnk5RGEraDlPdzNaMHlXa0hiMm8xekIvdXpWaEJj?=
 =?utf-8?B?a0ZaYUpHdmI5Z2xFNW95dzZkYjlhRmFjMHlSQjBKOWxuU0tWdGViMXp6aTdF?=
 =?utf-8?B?em1tbVd0U2NqU004N0Jna0IxSS9sWnA0TU1mUjN0dkFNemlHNU9tNVQwclpP?=
 =?utf-8?B?ajNqSk03dHFRWnFJZTVSVXVXcU01UXlpZC9nTkp2QW9GOGZxaGV6S2poSmc2?=
 =?utf-8?B?MjBieVMreGtnam4vL0loSTJlcEt1aXowWjgvd3NydDZZdHBCbXFLeXJJdVhh?=
 =?utf-8?B?Q0lCT3pDempLbjRwUkExRTB2RTIrZTV3N2x2TWpRYVRmTEJ2R3R0NmZnRzBv?=
 =?utf-8?B?dldrQTNPWGtlK1ZRSGQrTUdZMSt3N3lTRHM1ZitaU0M2VkRYVGFDTnpoTWEz?=
 =?utf-8?B?MzBwVXpFMmhwQWw0VmdDRUtac3IxNTdtZ21QYVYydkdJOWd3NnpCZFpIM0RJ?=
 =?utf-8?B?TkRIUDgxVjBYdloyK1JiTWVFZXlySjBxS0Q1MVdidkZFdE9JZHdUZ29JWlJM?=
 =?utf-8?B?YXRwN2xXcnQxMzdnUExsU1BHUGdVVnlrVDNpOXFTM2E5R0lhVlIzRnF6UEdJ?=
 =?utf-8?B?cWtiTHVIREV1RUdGWWxSOERGV0NIYzUvVkd3VFcwVXBVMUlkdmRXemR2MGRL?=
 =?utf-8?B?a3BTTkRKWEV1NStadi9mRHA0UEU2YzVxdklyb0pKVm5rMlpNclRiUGdrUmF4?=
 =?utf-8?B?NUhXT1RXckJjV3BPZXJ4eGJMeWR4Z0RicHVmbUpLbENTcURhbG96RnhDWW1T?=
 =?utf-8?B?N1dIdndRSXRoMU5UekRnUVRzU1VIc09JZGQ1YkFPYjQvV0s0N1IvYi92ODdm?=
 =?utf-8?B?eUEwUXFSbDhmdTNGMTFyNUE5NUxiVWJ0QkMwWkpFb3VhUitaN0V2YlQxb0Zo?=
 =?utf-8?B?VXYyMlFFek52Yk1mSjBWdGRTSWc3RkF4N25FNVhzYlhTSkNxd1JhN3NqbXJj?=
 =?utf-8?B?RGdRdXdaOEcrUnhFQnk0REdsK3REUFdicmJSV3Zya0JOSktYb2x4UXgrR1lr?=
 =?utf-8?B?K05jc0RPbW5hbGRjSVZFL1FDc2I3MHRhWkk4dUdJN2RRV1hxdzNVSEtmakpr?=
 =?utf-8?B?TXJOZm5DcGt3aGc3VHZMV0tuRzlva2llR2hOdUNJY0hWSllHVHY4TlU3UnJq?=
 =?utf-8?B?ZG5hWnJ5blRFak9CbGJNUk9qQ0d0UFM0aDYvUnFYb2xjSC9kOEhLMkxoL3BE?=
 =?utf-8?B?NjFuM1ZUcTBKUEgxb24rUnNhZG13czZpNi9ZRXVteWRoN1FyVzFERTRqdkZH?=
 =?utf-8?B?bmJybW9PV3BwUEpxQ0lKazVhdkVnT1lGcE5ZYmUzc1RIZGRMMEcxUm1aL1lV?=
 =?utf-8?B?Nk5vYTZvbjlqY0t4bXRsK0JhMmtvV3MxVnVQTUhic3lBSmpxaEVTbUNsNUp5?=
 =?utf-8?B?VlRuQ2hzTXdObWlJZWZudjFJTFRzQXQ4SXRDaTIwQlhhbEdTVmlEZllqWVV0?=
 =?utf-8?B?UENETURrUlVCb3A5M0Z6akRaQnYvTUNSaXpVOHpEWjhPUHBSa0ZhY2VoTDBW?=
 =?utf-8?B?YnROWUdSZU5FdFBybklOYWo3V04xZGJEN05zWkdFWGhQdGl3NGR3ZCtveWV5?=
 =?utf-8?B?K2VvR0lRbEh5Wm9YbmN4aUx0QStLZUNUc3lrdWxmSnk5N09wS2x0M0I0RWJj?=
 =?utf-8?B?c05EaDM1Z2xVOUlzOHF5MFFqRVhhU3VQR3hsZlhwY09KcVFHZFkwWkc0dWEv?=
 =?utf-8?B?Nm1CdUxEU0Vtckl5Um05NGJaWEZLQTBUVTFLU3RkdVRDRG1pWTNNemJhK01X?=
 =?utf-8?Q?uUxksfstAG1MaCQQWB4OULiuK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 130b6cd1-87c2-40d3-5ebf-08dc9a896251
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 11:23:23.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcLpW/P0TWdv03YoexUzcNNSlJvtM0lxd7RhGWcyIbhUr18z8nLHsPCA9P+hIydzwVi3dyxoCEyoPnAEhDfW9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

SGkgQnJpYW4sDQoNCj4gRnJvbTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5v
cmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMiwgMjAyNCA0OjQ3IEFNDQo+IFRvOiBEYXZpZCBM
aW4gPHl1LWhhby5saW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsg
ZnJhbmNlc2NvQGRvbGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54
cC5jb20+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMCAxLzJdIHdpZmk6IG13aWZp
ZXg6IGFkZCBob3N0IG1sbWUgZm9yIGNsaWVudA0KPiBtb2RlDQo+IA0KPiANCj4gSGkgRGF2aWQs
DQo+IA0KPiBPbiBTdW4sIEp1biAzMCwgMjAyNCBhdCA2OjEy4oCvUE0gRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPg0KPiA+ID4gU2VudDog
RnJpZGF5LCBKdW5lIDIxLCAyMDI0IDEyOjM2IFBNDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBCcmlh
biBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gU2VudDogRnJpZGF5
LCBKdW5lIDIxLCAyMDI0IDE6NTMgQU0NCj4gPiA+ID4NCj4gPiA+ID4gT24gU2F0LCBNYXkgMjUs
IDIwMjQgYXQgMTI6NTA6NTlBTSArMDAwMCwgRGF2aWQgTGluIHdyb3RlOg0KPiA+ID4gPiA+IFRo
YXQgaXMgdGhlIHJlYXNvbiB0aGF0IEkgc3VnZ2VzdCB0aGF0IHdlIHB1dCBjb21tZW50cyBhbmQg
VE9ETw0KPiA+ID4gPiA+IHRvIHRoZQ0KPiA+ID4gPiBjb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBP
SywgSSBzdXBwb3NlIHRoYXQgd29ya3MgZm9yIG1lLg0KPiANCj4gXl5eDQo+IEkgZG9uJ3QgaGF2
ZSBhbnl0aGluZyB0byBhZGQgdG8gdGhpcy4gVGhpcyBtZWFucyAiZ28gYWhlYWQgd2l0aCB0aGUg
cXVvdGVkDQo+IHN1Z2dlc3Rpb24uIg0KPiANCj4gSWYgeW91IGZhY3RvciBpbiB0aGUgbGF0ZXN0
IGNvbW1lbnRzICh3aGljaCwgSSB0aGluayBpcyBvbmx5IHRoZSBhYm92ZSBhdCB0aGUNCj4gbW9t
ZW50KSB0aGVuIHYxMSBsaWtlbHkgd2lsbCBiZSBnb29kIHRvIG1lcmdlIGZyb20gbXkgcGVyc3Bl
Y3RpdmUuDQo+IA0KPiA+ID4gSSBzdWdnZXN0IHRoYXQgd2UganVzdCBwdXQgeW91ciBjb21tZW50
cyBhbmQgcHJlcGFyZSBwYXRjaCB2MTEuDQo+ID4NCj4gPiBJIHRoaW5rIFdQQTMgaXMgbW9yZSBy
b2J1c3QgYW5kIHVwZGF0ZWQgc2VjdXJpdHkgbWV0aG9kLiBQbGVhc2UgaGVscCB0byBsZXQNCj4g
dGhpcyBwYXRjaCBiZSBhY2NlcHRlZC4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCBlbHNl
IHNob3VsZCBiZSBkb25lIHRvIGxldCB0aGlzIHBhdGNoIGJlIEFDS2VkDQo+ID4gYnkgeW91LiBB
bm90aGVyIGlzIGFscmVhZHkgQUNLZWQgYnkgeW91IHdpdGggbWlub3IgbW9kaWZpY2F0aW9uLg0K
PiANCj4gU2VlIGFib3ZlLg0KPiANCj4gQnJpYW4NCg0KSSB3YW50IHRvIGNvbmZpcm0gd2l0aCB5
b3U6DQpGb3IgcGF0Y2ggdjExOg0KDQpbMS8yXTogQ2FycnkgeW91ciAiQWNrZWQtYnkiIHRhZyB3
aXRoIGZvbGxvd2luZyBjb21tZW50IHB1dCB0byB0aGUgY29kZQ0KdXNlZCB0byBob29rIHByb2Jl
X2NsaWVudCgpLg0KDQoiaG9zdGFwZCBsb29rcyBmb3IgTkw4MDIxMV9DTURfUFJPQkVfQ0xJRU5U
IHN1cHBvcnQ7IG90aGVyd2lzZSwgaXQNCnJlcXVpcmVzIG1vbml0b3ItbW9kZSBzdXBwb3J0ICh3
aGljaCBtd2lmaWV4IGRvZXNuJ3Qgc3VwcG9ydCkuIFByb3ZpZGUNCmZha2UgcHJvYmVfY2xpZW50
IHN1cHBvcnQgdG8gd29yayBhcm91bmQgdGhpcy4iDQoNClsyLzJdOiBDYXJyeSB5b3VyICJBY2tl
ZC1ieSIgdGFnIHdpdGggdGhlIG1vZGlmaWNhdGlvbiBvZiBtd2lmaWV4X21nbXRfc3R5cGVzLg0K
DQpUaGFua3MsDQpEYXZpZA0K

