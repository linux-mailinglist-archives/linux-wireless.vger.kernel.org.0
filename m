Return-Path: <linux-wireless+bounces-10140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5792C80C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 03:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FF8B21E76
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14BE3D7A;
	Wed, 10 Jul 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+ydiMLv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D275664;
	Wed, 10 Jul 2024 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576043; cv=fail; b=rydMAA9uUxpBaRinSOmQ5Hm1/8ZJJmlQba44De3vomu67nSRXEdkIeQi5JDX5Bcd9L3whjhX8w89iL1g6XZclPd9GRi+gyeV118kNpwEz6CW8FGE62gjwHYrpq6B+RiVMT8ZXBYO+HzdP5SnWuv13yOX+vcX91ZIQzzGqBBxpZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576043; c=relaxed/simple;
	bh=hIfOF3DKUUHh3zMqSJuhK9UJZ9O5s/I9IxRKKljNmFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuSsoudmyYS6fJ8yYDWTUUUrW5BGsIqo7WG0ddgWQo5lhiXVr0555/PZQIIyq/a6Z0pVDFgZX6q6iq3oUg6Mer5qYkRFAF8ZbnxCki1qbIRRNQiBehEJNsbUb4eQn9O1mxvLtLsL35y7XhnPqPWYRQcmk1GMSM3/xvrFjPM+oE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h+ydiMLv; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX+bqWVlvzpnkTFXZZn06WyF9p0MYbzBk8vLrtwxGUYf0vdg3AezNoSufzv3UusnnU47MtRF2hfBQoAXOk3NU2dmF5BQbUWqcCrOZTip5iTL1+pcCP5I3ajm0mvP7Oo6KpL3rKCyq5sUtwut9XxXrcyC4Yug9rHysubnohUNw2clDJoOlncwYrlDE5tf/c6stG//rfHRYXJs3hanbdI1Q4jw5Wi+yGmFiF/MToX1m7ugJS2DOk7CUl7+jOye96EWUk7HurjMW4tGG/tf/0RC2aHNoOTj8BqSTzeKbwk4cxByUtbLgvCQQa9ak0HtI7HEJ9gPXF0oY50aMW9VWj2BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy2rC/lErRkftUa/mDgR4GalRQ6MpKk0GEwf4folX+Q=;
 b=BmYk7TkBG0Ykgk5rv7kIzYGrYo8d7eY4xMnWU9/0GI8odgEIn8eNKm5qSPIibSGCRY7eys4XDzUKYaBlzTtQ075pusX/1s+yNyzx3nxh2722LQKZFzESsriLK7YP3J9tyajDpjOpPtvvhyQGj7Wz61z6t4SFtCf4cFeulcT6yQ+Ry3IcWTlSdo//W90icjF/SMv+1IG39gq44RoENMaldS9qDohVRGRvaIRZtakf4QJEVFMSZzW06tFGekiJXmTf4o0W6NKP8w3ifxAINmDxhbjmqr/CZSS2m7ZQXMER0pyZKIgMrlUvRMXT8oZPJLDew1DNJyRz2JozckBaqjMgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy2rC/lErRkftUa/mDgR4GalRQ6MpKk0GEwf4folX+Q=;
 b=h+ydiMLvlz0BTJLncWsZo8MlZ0e51KYsV4THe6vPsp5l9h8kObWyQR41o620Snr2hRPp8wlsI1UTMZEjbMbWkrcj11eaKVJ+JrH92LF3gXFJWKg3ez7+UQMFohpKSrUJttmfEjBOGg7sWCzocP77ofSkxDRsVz+7TLu5HQPLzEA=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:47:18 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:47:17 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, Rafael Beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [PATCH v11 0/2] wifi: mwifiex: add code to support host mlme
Thread-Topic: [PATCH v11 0/2] wifi: mwifiex: add code to support host mlme
Thread-Index: AQHazcJ9oDCg+GgGMkqUSOf86PFchbHvOSrA
Date: Wed, 10 Jul 2024 01:47:17 +0000
Message-ID:
 <PA4PR04MB9638BD3D09017A786FC3DAECD1A42@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
In-Reply-To: <20240704033001.603419-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: f8fce4f3-784a-4ddb-672f-08dca0823b35
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hrRf+qh1v588HKN+Woh+6zwqOmFq0sckZCS/R0tFDkI4WUrzRlYiJBf2lR8L?=
 =?us-ascii?Q?nW7MwGdFeBg87Mj0mfMgUUMet3jXOS/S4Z2SJhXvsTGIfKlniSiP6fhkeNQN?=
 =?us-ascii?Q?rLtPlr0dcc6q3GBZVwZqlv4y0tAJ4LJPAliy2RXaeEoaOV9smzUp5Dma/OXS?=
 =?us-ascii?Q?Ki4hV76O8wqa6r9feaW1mbEUit0PiqPuIS0Fwhy2DPe3zW5jThQqw8qCB8yP?=
 =?us-ascii?Q?2H55KCTR1lopvZC6iitjhrO+3E6MI5IIMMPoc4yzozpzXS2s81hx6x4C61xl?=
 =?us-ascii?Q?V4VOBHuguB0hf8tNz5qO4NaLyQxBrZ7lgSjxxTjPAlzpZdB5tagdkn9fszlC?=
 =?us-ascii?Q?ax2I0aNrXwplwwSoBms3tPxVHtpFljZkjUZDi8kqrF3bX1UfjiiY41w00mn0?=
 =?us-ascii?Q?tkZhj+BOIXyNadLPQ+YFZ0r8w98ln5nO6tsjxSU2OXKaFxk0t0JPg1fuet/E?=
 =?us-ascii?Q?lIONx7Efp+ETCbaCcvbb9p+yFLVm+TBp0pis//koM4lNkXMDLsl4QrIoOWST?=
 =?us-ascii?Q?IojooZOuoDN8c21Cl4s03mRKvM7HDyRdIJNfqpJMusoAxlTaPkPnTp4b8I1F?=
 =?us-ascii?Q?tBELsCPDBWMW3n3qaL7A4MVr3//mexnlu5rdM6BuAoG7RoQSefhUhPVDVCzG?=
 =?us-ascii?Q?vwh1pwqTdKpUr04SnpUFsJDcCsrbE4XxHSr9Q3ghlkKvC/0ipatfEQUZw8LR?=
 =?us-ascii?Q?tV23WY0kOX7CQzCnnwgGrVv8/52NuJvh83vztJviP5lRaKIto9ayDezmRc5t?=
 =?us-ascii?Q?2xGxx87YRoJfCVc9iKlUBEFhMatsO66bIAACxdIR0jjhPvh54sQj/8znb9sW?=
 =?us-ascii?Q?yeRolXU1m7LduhVTBLKCqEBJ/lQie/nON8SXIjfQvb6K9vOiJDCC2/fzoLDg?=
 =?us-ascii?Q?q5Ol+CGZDXEYV6nbQaF/BvyxLgKIUmfpGnavgO7vaX4VbAFzGhdFh+oE2wI9?=
 =?us-ascii?Q?bwDQfmYDUXcvAFBTNSvKfn8TusGp4IK7TKqz4CU12dsXLGw4JE1qQ1Rqbw1n?=
 =?us-ascii?Q?XZpJFY4fXBbstKl1a8Q+6hNrV389+LiB7qoMYShip/OiYWtU30FyMZ+aOtzK?=
 =?us-ascii?Q?8R0OgJFyUb0eXeLC9BLmc3LNgi7cGINwQ+sFn3CxZFKHefikYoZ3iGbnR0TK?=
 =?us-ascii?Q?7IhnWsloVzPzGLVk+5fDqOwGfgBxfce5lrkyX0ieCcw9hlixc9TnjN2rp1HY?=
 =?us-ascii?Q?xIgorBvqOZ3qUNbMIHrU2xOBfM9iASAV1lkHkOrzd8DOU2Ygn8dT49szd2yh?=
 =?us-ascii?Q?kOJct2ShDL1Nj/IuXYQikqloWEQpPXnyw6oavNdCKTNp7mBroaZulLRoURcm?=
 =?us-ascii?Q?ic/yxAl3K3uj8NmtPlhjeAUdEbPQPQLYxYUZoBk6MX1o+HkTCUQeslAkuUw6?=
 =?us-ascii?Q?IljhdyMZw5yDvM9ZbKRWwEIXSs2MBuq5Tu7ehxK3djwddCT/FA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o9PbQ8CQR5cfJjbNTzBlbZOZjGm0XNuCvAM2ieiG3A/lMv7WjL/TSesQ5G5o?=
 =?us-ascii?Q?NN02TQytgSpWvSPQI89NYLpXFHdG5HV33O/i5UNO380YAYi1NvW7cWwG5und?=
 =?us-ascii?Q?kfpNHr96hz7lvF67GyrEIxiOaeiqdcyrWbMJNgwlMhe250Eei39beLA9XuUb?=
 =?us-ascii?Q?tjE3B0/rhRGYfPFuNJeRNUGLq/oWpHBhopRBGxID+pitT6APqrWuHBvrARCz?=
 =?us-ascii?Q?wQosct7v0ZL5zzneh5g8flCCqNbobb9OjZbA1cS/M+gpGB4xkW/nsKMehIkp?=
 =?us-ascii?Q?9nqVCMHczhxvQCE9lv2oEwxy8p6oW3M9UVLKLI3ydEQ6Q5y/VYNMvqCrUV2n?=
 =?us-ascii?Q?L4E72mQBjk6qIAQqEUpuHRxnKNT+N9+v+7xFpZWxKis9RNwguo7HEZ6Wwnbr?=
 =?us-ascii?Q?kPacjBOi6ixfkEgDRfmJyAcwm0FXi6sYaZsLW6YZwkxgdRSHD65XC8NRuvtA?=
 =?us-ascii?Q?HNu+HkYAoNr40X1Ok2mllhnbn76ymkvD7jylE7G57UBmGXoT10DI5r0+TCnx?=
 =?us-ascii?Q?+16uRbK7+dZ+fakiAlrXYcJVaaUv1ktAj4AqoNR7BjkI/x7X/JKSBhtOIHXp?=
 =?us-ascii?Q?AdTaRS5oS1xyecsYbZ5TYLY/wLBN/d0o1cqTPW+7oczXb5nA+ExN9I/9QyYg?=
 =?us-ascii?Q?XXtybFmQvt7IRL0/OJuM4qUT/h70fyrC7QTF8lDtp8tTmNaREvohS9eEcbrd?=
 =?us-ascii?Q?81TS9PoP8+sF68T7AbZ/e8ZtEABsjuRQbAU+LjUOXCiEJiia+IiBe4R2RBvL?=
 =?us-ascii?Q?wAghSpYkteM4DjU9UAyLenUCZIYq4NrO1n8cPb4XXSnD8NICzNf/6b9r/tIr?=
 =?us-ascii?Q?FZKo/GX6XqT+Yr8xwk6h0ua08sCiZkYwSUFhEq3Ue5Vty4LkwD+pfkuHBMEl?=
 =?us-ascii?Q?lnj5+ONG5V/PjZZsJnnIwI7ZRit6bP6Z8Wf0KoBsbH+w3KEPullKdJK/LhHu?=
 =?us-ascii?Q?U7TBue6rkJ8daqhbTCZFR6n8pj/y70vw2QBrOdAjHVsNOXKWQNTy2HndhDsw?=
 =?us-ascii?Q?KL/bRHyZeZrQqezaIK5NAOqfE6dEYrRoECf/JTkQxjJb1z329qMSC0tCGNqb?=
 =?us-ascii?Q?nV1KTp/mTVWparmYRMe2hSG4rSV39kmrDH1MfKgfGwABO2IS42ga3AHeejfm?=
 =?us-ascii?Q?1o/tO2+vvJYqTi/Eyefkqsh7QHQZoit/tx+k77CFVFrOVgJNPgLIyDyjhLTs?=
 =?us-ascii?Q?mUDPDoXI3D/1NK1dCaoieJvjfkFxJ93/U70SYM9KSXvFSjwLJhVqbgrZLsE6?=
 =?us-ascii?Q?R13PrPpVzdaI/f680AiG1ONa3OFXTz+jfTBntyeN5m+QZk+mZE2jXisGdmx8?=
 =?us-ascii?Q?+wgH5CVaiJdWtKzwmASYjGrfKZe2tNrZBlIce0kimUWzdJA6pIuQ5Q4uwltB?=
 =?us-ascii?Q?v679XQ1gybIs1t5Kq8Bj5lppA2HL5bpJwOXIZORmsqmA7UFs6IEu3ywjCVPL?=
 =?us-ascii?Q?mQ73J/YvyZUKAT+HmZjlwrtAcoMIZv0IeI1ZP3mSrD4mqv09kRS7ZzbdLWXM?=
 =?us-ascii?Q?GR9xoAvM9p9Ik5GNBhTViCbP9yXlmZUcQgy4NM4QgI9EMBzCeY6dgqB+/nNB?=
 =?us-ascii?Q?Z0SxdS6W/zR+h2V7CChG5O+PPEzXiki4fPdVdBVJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fce4f3-784a-4ddb-672f-08dca0823b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 01:47:17.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYWtlGD7XFAr087oIUFDcb0HDnfcCc9feyIyRG2Z9d2uH+x1Ei01c0ii7T4BzGAtzQu4+u3s49ZI6rMQ2J9ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

Hi Kalle,

I found the state of this patch series had been changed to "Deferred".

Since this patch series had been reviewed for a long period of time and
reviewed, tested, and acked by members from community. I wonder what
else should I do to let it be merged to mainline Linux kernel?

David

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Thursday, July 4, 2024 11:30 AM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; David Lin <yu-hao.lin@nxp.com>; Rafael Beims
> <rafael.beims@toradex.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [PATCH v11 0/2] wifi: mwifiex: add code to support host mlme
>=20
> With host mlme:
> Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD Without host
> mlme:
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD
>=20
> This series add host based MLME support to the mwifiex driver, this enabl=
es
> WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it was
> internally validated by NXP QA team. Other NXP Wi-Fi chips supported in
> current mwifiex are not affected by this change.
>=20
> v11:
>    - add proper and useful comment for mwifiex_cfg80211_probe_client().
>    - modify 'mwifiex_mgmt_stypes' to allow multi-adapters with different
>      setting of host_mlme_enbaled.
>=20
> v10:
>    - Use eth_broadcast_addr() to set the broadcast address.
>    - Add comment for constant used for the length of FW special 4 address
>      management header.
>    - Check host_mlme_enabled to decide if creating host_mlme_workqueue
>      or not.
>    - Use cpu_to_le16 instead of casting via (__force __le16).
>    - Change the abbreviation "disasso" to "disassoc" of the printout mess=
age.
>=20
> v9:
>    - Remove redundent code.
>    - Remove unnecessary goto target.
>=20
> v8:
>    - Separate 6/12 from patch v7.
>      As it's a bug fix not part of host MLME feature.
>    - Rearrnage MLME feature into 2 patches:
>      a. Add host based MLME support for STA mode.
>      b. Add host based MLME support for AP mode.
>=20
> v7:
>    - Fix regression: Downlink throughput degraded by 70% in AP mode.
>    - Fix issue: On STAUT, kernel Oops occurs when there is no association
>      response from AP.
>    - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
>      STA can't connect to AP anymore.
>    - Fix regression: STA can't connect to AP when host_mlme is disabled
>      (impact all chips).
>    - Address reviewer comments.
>=20
> v6:
>    - Correct mailing sequence.
>=20
> v5:
>    - Add host base MLME support to enable WPA3 functionalities for both
>      STA and AP mode.
>    - This feature (WPA3) required a firmware with corresponding Key API V=
2
>      support.
>    - QA validation and regression have been covered for IW416.
>    - This feature (WPA3) is currently enabled and verified only for IW416=
.
>    - Changelogs since patch V4:
>      a. Add WPA3 support for AP mode.
>      b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
>         when group rekey occurs.
>      c. Bug fix: STAUT doesn't send WMM IE in association request when
>         associate to a WMM-AP.
>=20
> v4:
>    - Refine code segment per review comment.
>    - Add API to check firmware encryption key command version when
>      host_mlme is enabled.
>=20
> v3:
>    - Cleanup commit message.
>=20
> v2:
>    - Fix checkpatch error (pwe[1] -> pwe[0]).
>    - Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
>      Default only enable for IW416.
>    - Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.
>=20
> David Lin (2):
>   wifi: mwifiex: add host mlme for client mode
>   wifi: mwifiex: add host mlme for AP mode
>=20
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 404 +++++++++++++++++-
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  23 +
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
>  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
>  drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
>  drivers/net/wireless/marvell/mwifiex/main.c   |  62 +++
>  drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
>  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>  .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
>  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
>  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
>  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>  .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
>  18 files changed, 992 insertions(+), 17 deletions(-)
>=20
>=20
> base-commit: 347bf38330c2971230d8206eb8b37ed36b54982d
> --
> 2.34.1


