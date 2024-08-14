Return-Path: <linux-wireless+bounces-11389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528D951337
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 05:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032D9B21029
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246824B29;
	Wed, 14 Aug 2024 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FEwHIgH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B94D8A8;
	Wed, 14 Aug 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607229; cv=fail; b=llE63lF+pNppChfHDOYVf219p58abHpKROUOjxKgD1YbGWM9K8XzTIqKXJmGoXSfu+eLzKt6koNb2TQx36ZlYStqD08EmAVxlEIEa2vHCh+LugjjPihTZ/fuFp+YWbBVNH3N5Z/m2Si2pqsWZUBQGJFSzXmlX7vkpAtOcL0oQ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607229; c=relaxed/simple;
	bh=r/ZVgIpyfnybr3scODW18eTytR3FvaqUrXSIsgEj6aM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LGrPJ4Q6Hm2XO7hW77s1PjCW/N29ArqhyNI4ot4YhJX4W8ZI2RKpPUXQfD0jbnaoeD41Q7uJmz0WOEWfuV2WrjQIBPVivx+bc4QLu+xuppzqpZEVzJEG4GGYp6vyyDCxPzu+aVDqrdvTp4EM1X/OKCMAPSwynZriNEQyyXlso1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FEwHIgH9; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ4/ymuAvkZ08VEzsCjlXanHoQyvH3FHLHLMytvc1pshzhq4AeTe6hybirbm4o0aYn4x737SEx1yefivSJkWgQbDeyipaGWk12AWPxe+D1+6cf4BS9jjlrm/PUZODyP7Bn1G6ihxviJbfhDCGLL7T7sPX17HIGvyzhCLKS2EVtzN22SLRYGPOpXRfCyjeDgwVJkqvMJTd8+QDGgCCt0zPumGrb8bnfjuIf6EzT8QrZAih9HxiHym0twFzsi88MKOsOz1sI+xpPn1FllxCFFWxDzWFBpVSbZSVKZWSaK970hzn74frI4kFwbvpGOZtLYLE2r09uUSvJFMLFLhf2Gq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ9RhOqtPAEipppwE5Qk/ADq+JUf1ov4ZvzbVPEtIWA=;
 b=xf5oBOtvag+Zwl5r1sQeFNfY7XsBcEunuDxnr4viuaUjU36ke8Pa0xQDP8VxYLhjEv18c3v2wxSqcbJ7ijnb3jD0+g0YreGSdPu0F+A3lgFDO3U3+7TMIAbCooJSj7HXdu92of0ZYvvyiR6NdxYXCN58hcii+zlLk16HVvncxitrfScZvhmvZUJKZJwq0qVhEHCDnEfh5ofQ6NHmWWr+f5lL8qQDQBZRfNnRD7CamzVHG95Rbhnz62PfOmBzSK2B057tVNdEqBUpweF+RMZPrr9DW201YLUb01P9vEXGM7U5LX3bCpGHBn8i7TZqnW9QrLh9gzLbLlNY5sZ+y3Lg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ9RhOqtPAEipppwE5Qk/ADq+JUf1ov4ZvzbVPEtIWA=;
 b=FEwHIgH9os13qz7cG2xUjrLrOs0yfwHGgTq3kd+EE1TFkoKbocDLYZc+QFKml7RFzLEa3CZEBrsZ30CoWUAr6I7vecqTa98QKT4syQ7VXQVMXaLqUeczG5W6+dgk3L6WiIQIjN/OGZHlI3u/WyZMqoOd2dZzPc5GC4iWnIITuG7n3vdrq9G+FPfBd8oaoU9chIEyu/E4VtduuW5CagqWLkiW98sEddI6c5OBnVhrqZSLYF6ADjHflJ85jv04Uf2uSvBS+oyukZXZdfVrbRG4Dz3ae7PzEdYVchAaB7VRLRe8YSWGmqJ6L3dCHbMqLZlkeZ88t7fVMTD21YjMURHqaQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 03:47:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 03:47:03 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Topic: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7ImJDCQ
Date: Wed, 14 Aug 2024 03:47:03 +0000
Message-ID:
 <PA4PR04MB963858E759C8F61402B2275AD1872@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS1PR04MB9237:EE_
x-ms-office365-filtering-correlation-id: d48bb52a-60bb-4a13-4371-08dcbc13c273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0eTdloi6WuP7KfqTjsO7OYRp5wEd79aLEZDsXdf04L8Fv2SfT1X39HvU6zix?=
 =?us-ascii?Q?IbffgOI4EADpw8IxVYiuzHuAQ+OR/aJLOuGazhtuXs/T1OhEpgAhaM///AGk?=
 =?us-ascii?Q?jlyNYWwh1RVgWKmUqFvnzrrbLaqZIcZNL11WtlCkhtOCOxXpuMT+jEs5LrEW?=
 =?us-ascii?Q?SsqSN8nTMSmXBuvyXfawrO9/k2JoFYbR23n3+IBuhX5BYg40C8GGjXC7fqVp?=
 =?us-ascii?Q?uolqCGFm2evNlmbwbAXkOoZr1ptnFMFp4GcuZP/SsLsjpcbRAWvZ4f6z8b82?=
 =?us-ascii?Q?VBxgsiKU1HWWsgQXrpZg0yY3tmqzjFdDxO8LTv7dd3IVgR/XYbGEAIOTYUgK?=
 =?us-ascii?Q?2qNtfQj5pTurhlSrM3cdluNmdDosiFdQbJRvajSbGacS00bP6yTZcfoGcJiE?=
 =?us-ascii?Q?h8hOqk9qBCurnt4bTIvEJ8n90M3HY9XVnsEG118ASXZWzl9I9YubeJpaNbuF?=
 =?us-ascii?Q?H+5eDyloyyapS3j8rRSGdop/i7Am0K/oxOWfhYDvX+AHLURI7xjZnv3ZU33e?=
 =?us-ascii?Q?08DL5a2NZXwaJeyba9JUffhpWNzBM58bUfWIB7mNb6W5usjYTeyewvtrLPq+?=
 =?us-ascii?Q?tuBTOif7F/TBYueprL1Y9RmN+Xp3bZ7m2sejkDexJs7k3KPbaT0uZMQwabl+?=
 =?us-ascii?Q?fTzfLA8ulwmg3u06HHx/RDGthm2TeDipUS64O9MkjuSsq8+CqgZqhJLL0ENM?=
 =?us-ascii?Q?zmHzDF/04fCtfHCZoRO0I5cX8IXyTUkOniRZHAKwZuS3zRqNk99sh1XN5cwq?=
 =?us-ascii?Q?1d4HVjprt88f+TibH54Cvar87KbyskgbAvwyWEHlBcPsQCrQ2fDJdymHig2b?=
 =?us-ascii?Q?60D5aH7/l+lhTSTBn9EfJah8vl8w6vEBrICyKd3JhZxmL+xHFCXtq9qe2/z3?=
 =?us-ascii?Q?jmCQ9DKwes8DQBOqtVwBQQrlwbpLbIw+jE5//Shy5CMBwz2Z/Wub+d3uOA+F?=
 =?us-ascii?Q?g6OXFaEQJwX3nfck1aIwauYutiE6AX8EvAQgHVTfUqXItdyeC6zj2+pfAcsI?=
 =?us-ascii?Q?miamwEJ711kvK7OM+7BARYIIdIR7zwUEzhZ+qiuf7I9Z/I1YgJW7edKJK/Lq?=
 =?us-ascii?Q?J1ZRhxU5fRmimzcKoFYDaTJzMQVENl/KLwU9ZtSq5ICBvhfIuLb61adZbelC?=
 =?us-ascii?Q?Y5ODTbFKJkt+BPyFvRHZ7rvWfU7zfRsHkRnYkTDttDMigeAiSuW0VuhpWUHr?=
 =?us-ascii?Q?Up9hnzHFsxvDA7Rc0mzPQf1eOhbj3bal92GvHiWQ9Dufn1op1lcaXbGQVCq5?=
 =?us-ascii?Q?YF27mW0EeXgfuMbYOmXx6UGQCdpnf5tvPTdRvmr55rjjWH4kUU+ow8l5WHTP?=
 =?us-ascii?Q?sdXjkD6kt0xXFON6RJYJzP6jbxCfxGlUzA1kzrdR2yxQ6PbtfAWsZeTEJxWF?=
 =?us-ascii?Q?gHzFXQUpfoMeWxnLQMJBTq+3fj3RqYuDfw58jvw2LH5LFpRU4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7j5H0yTwj0v8IbY/dggkdPvZpuWaQX/OOIqrz2mWqBGvQDK0oWJFSKdgvLj/?=
 =?us-ascii?Q?a6e8RqelsS7FM8WXmv6EJES/GO7X1sdABp4qnpIawJ1oHhvM35/qqGpqnDAi?=
 =?us-ascii?Q?zznP2xU++A7X/veTe5s/Woo8e5TWC+XafBY14OoFdv6X0yzKkYf9F7C0Qse5?=
 =?us-ascii?Q?QCTIZRk6xaYt01eRltU43BKoXf6UyuxrJXjc7d4aRN0DalPCMb7kCaGdZpQg?=
 =?us-ascii?Q?2HhW5fXB62RfQVXa5MMSfekzrTbKaU136CHJ3htCuIqCwmjb6fnac9uxbfH0?=
 =?us-ascii?Q?Td0HtOqwamYXMMntL+noqT1kF61ubRwjw0GEBAvHtpmfo460aB3XuRPsw+nA?=
 =?us-ascii?Q?IcVGMQtie7IY1JleSskOPICaEJAFLYq5FiGNEugFqM8Ll4068mfmUFZTBX8K?=
 =?us-ascii?Q?84mx4LTx3UlyZb4jzLr29JZrxXR8hRss8f5NtUGm3yCe+iBlht9DPsWy1wMn?=
 =?us-ascii?Q?gibOb8gjeQBksrUTzT30jYsyP8n5xZyBTiEx5pBI2NF1xNP/1rtyO3U/p31P?=
 =?us-ascii?Q?eMQ42vugNlrev9p9duuWOZHglJhj6VlHD44ZAWvVTXUh1bZml/tLQkxIqgAo?=
 =?us-ascii?Q?gpxH4TPyfOG2vLLT01wbPXwEYlMymQ8RP6w2VPNj/MDuNqptJp10CHPZQWfx?=
 =?us-ascii?Q?S9z9wbySnFJ46VUVEzmHM7LhcMZldKVRgzrzA+68Igwl+j8SVjOjDX1F+yV0?=
 =?us-ascii?Q?YAqcNa7lwNi7Zuhegsxv2vYWK1/pQlUEna0CxnXnNBOszarlu0Zd5BF9Yacd?=
 =?us-ascii?Q?bgPwsuf2oc8X6hTgOLuxNyiN3plS6tyJpz4GVk+DSvlXmQkhnoLy4sryMGz4?=
 =?us-ascii?Q?Bnou9PbMebZnTdj8rEUpM+y6hNRZfamTSLhH/y4mbsGkn/UQT76F2BSdcJk5?=
 =?us-ascii?Q?W/GMvvht9oMx6foPEAjO18KSoMJ4pYf73mfROXQqwLQhCQqNy+qtTeZx8HuE?=
 =?us-ascii?Q?OhSJUPTEiKg9r1AXvSdnCw81ND4yIA1YCaQ0V1ExHFvQWbcKT7u4Hv/zoCIM?=
 =?us-ascii?Q?+iVdmpFuwEn98eswNpACRBpHMxtX7wE7OOknQIXN2uiUZcGICKv7dheK6cZE?=
 =?us-ascii?Q?dg8ddpcncccVQDqOpwmglE5zxaO3xM1bJORIsGrOk+rWz+csbdmHc/AWgsr+?=
 =?us-ascii?Q?X3MhFs/2cpi1/ZLtFOdZeMn+dBYLZJvOY+2Y6QPQwzfvH2L0gtFlmo7ATqmW?=
 =?us-ascii?Q?3m8rr+zS/2r2U5YJbF+0SRHNNFGF+u3jc0yr2amBYgsbe3yCT0x1w66HFnYq?=
 =?us-ascii?Q?NgJrzILFw/fGWOZHvMCxY8HdoYFtTfTcTIUmMffhwYTmxhQnGDGapiwM9tpz?=
 =?us-ascii?Q?CsPQl2Crjubjqf7ob/Sfpu1KBqMDqCrr+WbkQKBKautx0zKjN+eJVm6iMFC0?=
 =?us-ascii?Q?1n5bqbwru4ni/4GMbhiW0nodxhjba6vYrsxKl9jTt9/hxi1J27vCR7netQE7?=
 =?us-ascii?Q?xBh0jHgQkqcBhno1VfQY2Acxy2E0z9Ja8imp0m8/n6MO/LMPcMfi2otw23xi?=
 =?us-ascii?Q?Wwg+6kR8+IjaQ+9WRrnfOnQis2Nld9fvE0DxNzOxDbVi0GbTtI3Zkwgqzgxs?=
 =?us-ascii?Q?dvbRZbU/szR8EPR19HhJ8bY41YB1xkzEGF8uN5kI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48bb52a-60bb-4a13-4371-08dcbc13c273
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 03:47:03.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE0gBnn83GyZs9llTSWHPcSoNgyiGLJQy4b42Fymx6KEkn1j5LzcjKk+O8FbsYDOLSZzDL51eYI08jpB+3Q3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

Hi Kalle,=20

I found Nxpwifi patch v2 is put in "Deferred" state quickly.=20
Patch v2 is mainly to address the comments from Johannes and it actually to=
ok quite some efforts.=20
We understand there are areas to improve and we are committed to continue e=
nhance/maintain the driver.

Could you let me know your plan for reviewing Nxpwifi? Is there anything we=
 can do to move this forward?

Thanks,
David

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Friday, August 9, 2024 5:45 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions=
.net;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; David Lin <yu-hao.lin@nxp.com>
> Subject: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
>=20
> This series adds support for IW61x which is a new family of 2.4/5 GHz
> dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4 tri-ra=
dio
> single chip by NXP. These devices support 20/40/80MHz single spatial stre=
am
> in both STA and AP mode. Communication to the IW61x is done via SDIO
> interface
>=20
> This driver is a derivative of existing Mwifiex [1] and based on similar
> full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation=
 kits
> in both AP and STA mode.
>=20
> All code passes sparse and checkpatch
>=20
> Data sheet (require registration):
> https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> 4-plus-802-15-4-tri-radio-solution:IW612
>=20
> Known gaps to be addressed in the following patches,
>   - Enable 11ax capabilities. This initial patch support up to 11ac.
>   - Support DFS channel. This initial patch doesn't support DFS channel i=
n
>     both AP/STA mode.
>=20
> This patch is presented as a request for comment with the intention of be=
ing
> made into a patch after initial feedbacks are addressed
>=20
> [1] We had considered adding IW61x to mwifiex driver, however due to
>     FW architecture, host command interface and supported features are
>     significantly different, we have to create the new nxpwifi driver.
>     Subsequent NXP chipsets will be added and sustained in this new drive=
r.
>=20
> [2] Some features, as of now, WPA2/WPA3 personal/enterprise are offloaded
>     to host wpa_supplicant/hostapd.
>=20
> v2:
>   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
>   - Remove header file semaphore.h.
>   - Use static value for cookie instead of run time random number.
>   - Use ERR_PTR(), IS_ERR() and PTR_ERR().
>   - Use Kernel defined return error code.
>   - Remove unnecessary private ie definitions.
>   - Remove mutex async_mutex and related code.
>   - Consolidate multiple workqueue into one.
>   - Add the support for PSK SHA256.
>   - Use tasklet for Rx handler.
>   - Remove unused functions.
>   - Remove compile warning.
>=20
> David Lin (43):
>   wifi: nxpwifi: add 11ac.c
>   wifi: nxpwifi: add 11ac.h
>   wifi: nxpwifi: add 11h.c
>   wifi: nxpwifi: add 11n_aggr.c
>   wifi: nxpwifi: add 11n_aggr.h
>   wifi: nxpwifi: add 11n.c
>   wifi: nxpwifi: add 11n.h
>   wifi: nxpwifi: add 11n_rxreorder.c
>   wifi: nxpwifi: add 11n_rxreorder.h
>   wifi: nxpwifi: add cfg80211.c
>   wifi: nxpwifi: add cfg80211.h
>   wifi: nxpwifi: add cfg.h
>   wifi: nxpwifi: add cfp.c
>   wifi: nxpwifi: add cmdevt.c
>   wifi: nxpwifi: add cmdevt.h
>   wifi: nxpwifi: add debugfs.c
>   wifi: nxpwifi: add decl.h
>   wifi: nxpwifi: add ethtool.c
>   wifi: nxpwifi: add fw.h
>   wifi: nxpwifi: add ie.c
>   wifi: nxpwifi: add init.c
>   wifi: nxpwifi: add join.c
>   wifi: nxpwifi: add main.c
>   wifi: nxpwifi: add main.h
>   wifi: nxpwifi: add scan.c
>   wifi: nxpwifi: add sdio.c
>   wifi: nxpwifi: add sdio.h
>   wifi: nxpwifi: add sta_cfg.c
>   wifi: nxpwifi: add sta_cmd.c
>   wifi: nxpwifi: add sta_event.c
>   wifi: nxpwifi: add sta_rx.c
>   wifi: nxpwifi: add sta_tx.c
>   wifi: nxpwifi: add txrx.c
>   wifi: nxpwifi: add uap_cmd.c
>   wifi: nxpwifi: add uap_event.c
>   wifi: nxpwifi: add uap_txrx.c
>   wifi: nxpwifi: add util.c
>   wifi: nxpwifi: add util.h
>   wifi: nxpwifi: add wmm.c
>   wifi: nxpwifi: add wmm.h
>   wifi: nxpwifi: add nxp sdio vendor id and iw61x device id
>   wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
>   wifi: nxpwifi: add nxpwifi related information to MAINTAINERS
>=20
>  MAINTAINERS                                   |    7 +
>  drivers/net/wireless/Kconfig                  |    1 +
>  drivers/net/wireless/Makefile                 |    1 +
>  drivers/net/wireless/nxp/Kconfig              |   17 +
>  drivers/net/wireless/nxp/Makefile             |    3 +
>  drivers/net/wireless/nxp/nxpwifi/11ac.c       |  366 ++
>  drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
>  drivers/net/wireless/nxp/nxpwifi/11h.c        |  433 ++
>  drivers/net/wireless/nxp/nxpwifi/11n.c        |  851 ++++
>  drivers/net/wireless/nxp/nxpwifi/11n.h        |  163 +
>  drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  276 ++
>  drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
>  .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  917 ++++
>  .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   72 +
>  drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
>  drivers/net/wireless/nxp/nxpwifi/Makefile     |   38 +
>  drivers/net/wireless/nxp/nxpwifi/cfg.h        |  445 ++
>  drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3773 +++++++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
>  drivers/net/wireless/nxp/nxpwifi/cfp.c        |  484 +++
>  drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1285 ++++++
>  drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   92 +
>  drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1041 +++++
>  drivers/net/wireless/nxp/nxpwifi/decl.h       |  294 ++
>  drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
>  drivers/net/wireless/nxp/nxpwifi/fw.h         | 2249 ++++++++++
>  drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 +++
>  drivers/net/wireless/nxp/nxpwifi/init.c       |  694 +++
>  drivers/net/wireless/nxp/nxpwifi/join.c       |  915 ++++
>  drivers/net/wireless/nxp/nxpwifi/main.c       | 1666 ++++++++
>  drivers/net/wireless/nxp/nxpwifi/main.h       | 1478 +++++++
>  drivers/net/wireless/nxp/nxpwifi/scan.c       | 2806 ++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2648 ++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
>  drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1307 ++++++
>  drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3233 ++++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  864 ++++
>  drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  244 ++
>  drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  209 +
>  drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
>  drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1169 +++++
>  drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  491 +++
>  drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  499 +++
>  drivers/net/wireless/nxp/nxpwifi/util.c       |  946 +++++
>  drivers/net/wireless/nxp/nxpwifi/util.h       |  108 +
>  drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
>  drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
>  include/linux/mmc/sdio_ids.h                  |    3 +
>  48 files changed, 34897 insertions(+)
>  create mode 100644 drivers/net/wireless/nxp/Kconfig  create mode 100644
> drivers/net/wireless/nxp/Makefile  create mode 100644
> drivers/net/wireless/nxp/nxpwifi/11ac.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/decl.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h
>=20
>=20
> base-commit: 555ba98448f8916bff87067853a7e931949e6b57
> --
> 2.34.1


