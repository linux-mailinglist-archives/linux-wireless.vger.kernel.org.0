Return-Path: <linux-wireless+bounces-13753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18522995FB4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F467B20C0D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845091DA5F;
	Wed,  9 Oct 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U6hELmOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013006.outbound.protection.outlook.com [52.101.67.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4B28EF;
	Wed,  9 Oct 2024 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455045; cv=fail; b=FHrfVs9qJd992gbAcMnbkNUqZHEEEiN1Yk7DyAgZ5Gv/TahECng8GTu95tv8ly8HymGx+11805RAiMQpU1hTS7PZlTdtdAy/jwInlgn270m2b7c7v887dPq3Oboldl1JMBs2pN3vbjYdp0dNNmKgfZ+vjQAcaYh8yRo0YJ0GYY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455045; c=relaxed/simple;
	bh=cQMCWh3aXK00v45s62MYPpBea+SbvtDry5PwzTclNEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DApJLtZ6Mc8lTX2Z7aORjQ7ijF634uxGcza/c911qKxH7JTz4uyl1QMnHCmTMhicBRE87mKGzvuEoHTsTeIKNfc87GIZJGnXVDcB2KBNa4K3f3aw2blg+xlIIFY0z6/riPIUvbsqRm2d+U+EowaTLDJdp9PNCRaS7rjcummUniA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U6hELmOq; arc=fail smtp.client-ip=52.101.67.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXRF0xsAPjv1NSpfeVkoBOEfVsRfmSPuPQiY42wD3mruD94hKUDncaWPZjl4Tvw1zDr6wFiKw9jQpIHyJss9qdcVVtOOZtPJFH24/B7tAZiJZBazntD8g7+PThoLyApCK8NxjPAxSBCez8GwGPKnZijZ/GuW7AouOQ0gIDUbxD4D5ru4+t6EDC40ehKYLvktV+G8fwdVu9QoQkUqTTHLMzK/zMPoGxxE6D8qGbbEWjMmiEuQmf6pS8zJHAzhKehavcRU1j+h88qjCpAFET+kxe0VnFcDQnd34dDMFUCubaHmgJOdCCbZHvwqz5ET77/8kLq6MvWCqpqFFCRVTCebBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLAOrk6yUuZ7q+6C+vGGteP2JIAqh87ubLWpj1eYlxs=;
 b=byR8KR5tbsF+nBeZohyhjg+HdFyyhbIAVCTTzWRqo1tEMWsGkRZBov0pqXSY/Ft46Dsr5vNh7P22wBN8PCmVvH2dsx++vHxJQfD1LZ3VHnLXFq0bG1YRRjurVe1z77O1kVoMWkkUgCI/kbAjx1LAHgBwx94ntLi8oRzCsB3CB8Wt/xVenswgeYS0dwjW+eUBS0N8oV3mJCHJlZri/jKmvVZTzadPA3WR9JHcDzsgAbeqJ2+vd62LH08S3nVknTDxNRdHGGfGh5lnRQbTvmR05v6x5QSOEV+iqV77go5bcIJSPP2JpAmaNv6SfSjZfP7iI46UeLh+EfbgGqXpbfwLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLAOrk6yUuZ7q+6C+vGGteP2JIAqh87ubLWpj1eYlxs=;
 b=U6hELmOqM5IsOx9aKUVEZK9qGWwGMRhMauCd30nRZKDS/813IcbTPRRQVtuyhS/N8PtJ2alPJ1Stu3p/L5iHBKoZizUD4u2w6ryH99gn/j0HSH4A7OJePWRHXrUULcQhtWLOQeY4EYJ4TZaylgL1ZYOBh7ecvUxrNAmpKoLO095HnAiIGaaei+fCXcWl5vd65t6RkMtxc7KIywWk36Ohg5d2b3t0iC5KIrkOXevOCTv9ww3gHX3JJ1PZHqVGi9Ob32G9CerH3offZYriKmiGQ1DeNYYPy8g0SytXbndkv3plrb/Q7XISl96nJaZsGot5WodScRBfvzsHW74eLhZiLw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 06:23:59 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:23:59 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [PATCH v2] wifi: nxpwifi: fix firmware crash for AP DFS mode
Thread-Topic: [PATCH v2] wifi: nxpwifi: fix firmware crash for AP DFS mode
Thread-Index: AQHbGhF98jRMMSpd8kCv5UiFhaX2V7J98zCA
Date: Wed, 9 Oct 2024 06:23:59 +0000
Message-ID:
 <PA4PR04MB96380325F7E5640BD4ED903BD17F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20241009060658.8998-1-yu-hao.lin@nxp.com>
In-Reply-To: <20241009060658.8998-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7933:EE_
x-ms-office365-filtering-correlation-id: 7a23b72d-fe7d-4c7b-7cff-08dce82af62e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X+tVv+q/u/xDPlPmKI7xauJdj9wrhlN1x8haCf6oRWNYi+wKuxXcxuSxkcLy?=
 =?us-ascii?Q?IkHRbZxO24UPHYbzGanF2L8Hd0SUg980p60vHdoSdndqSO/sOMVGsojnTewd?=
 =?us-ascii?Q?sGgNbD1Rfg7l6aU6L7obFIilFYVMd44iuF5EkEzHc9zJrmAFmkwAstik3oZF?=
 =?us-ascii?Q?w935hQFpx+tJEUubNE4X8bIm1xMtT5Y9TqGZ4NFElEoPkEAaewReO1/xx3F9?=
 =?us-ascii?Q?3D7QhoBogjMSR+x4XSz2LDAQ/1Vieu7yUoIBR8Ey/F9xwD8gN06D1WpC0hW7?=
 =?us-ascii?Q?54ayDzeujazZrwoxU+BfL2tDr9ByzHD4iBO219Ii4Wj+PZnbPS+J/AEmpiSU?=
 =?us-ascii?Q?dFM0mz/3SAQGQchsCu690aNPd/BcVbiuZgD6sXTS4P8cwA5kwgQlM5q1SZX1?=
 =?us-ascii?Q?PJL33EjVoeCzOH/xQcu6XP+eMyNVhvriBhaJYqqfJaM+MyrMm47IzqdM6QPj?=
 =?us-ascii?Q?7Yz3OmLLTlwdAZhfdGiA8oPykBEqtgOA1Uo/3bgO43vG/lbpM8NEmOyDf3pO?=
 =?us-ascii?Q?y6J0AzQGlOcs6MGt08wbZP8ts4dX+viDuf7SVye5dRzwLdScUrE3tvMvHvq4?=
 =?us-ascii?Q?mlO774VxJ7ltyZ+XSO2t5F5AQtX6kO/sOp7Hbwr6kYDo1CjlXLFfE3YvU2fn?=
 =?us-ascii?Q?vY9r7uO95AmWgtrSOyMPTmHqPjs4wUd7jReK3yMwt1qO0coYLSdYcZP2yY8U?=
 =?us-ascii?Q?IK5g/MeXSB8AWXRQAaBodLMI6zrCCE8DDFS0KS3ZfqQ2fjm/8cWxf8jtTvOr?=
 =?us-ascii?Q?FNQOFn94WPEfcaXznsvhtOtcfctmP60aYFlMIXxZQ1vjYk8tRVI2jwqfjr0O?=
 =?us-ascii?Q?kzThdfZgIyE38sS+RiVlvhAvzvwFneHxNcbeT8njTi2kjSDsg86mHYCrwYv7?=
 =?us-ascii?Q?gWn6MJYbJ6k1P/a+KvS2FWDPwVVhaQ1GC08VBq9jTsoPGOSPPLidzVXF4WJh?=
 =?us-ascii?Q?1gRB1LlOpRZhN6aBzin5T+DlaewF4ZItL2ish0kfj2qpLj1hU4rbEpn1UhPW?=
 =?us-ascii?Q?OAZPo3tb4pUaPPtMMTXLT0JQ9LYdEeHLtt00W+B449P8n3YGMPNwKJdSUGj7?=
 =?us-ascii?Q?FGmnHWtdACCwYuGGZWoPOD+jJjv26ZGMNr+EPvvRuFumq2tj2WEk8nZMMBYy?=
 =?us-ascii?Q?7UG1CV2yXrn0OP6VcHcBVIAeLmz3SNwy1uLWlf+pOYniOoA9gygIMjU0JHVz?=
 =?us-ascii?Q?SEQ4SAa0C7lIH0Cmn01i4iWQ1rfEX4vkhjNRQ7p0LD45hQVACt7rU0T+OhkF?=
 =?us-ascii?Q?Vd+/elbkTwcH0i0LMqaN4RqO70VCJkIELZLN1Bj3CsLY6qLzkdy2iRZvJNin?=
 =?us-ascii?Q?JR0gYQWkOxTeZ2hAc/OyT+GNalC+boSImn1XAL+iGbPPjw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7P1Zz7K1gBPq4wlYXXdlcGS8f4JXenNx/dn6YKLJVGX4FhSHCjzEqjlVZ/iU?=
 =?us-ascii?Q?6gDJRTSO9r/xDWQ9Je4DmoLpZ1fYB+NKjswL7i3oy463JQ4PgXSm51MMUue2?=
 =?us-ascii?Q?tfX4QaU8DkczIJp1vf5XKfQ4CwniewlaOwVlW9U0UJpuq6fP1vAg+P7bmxX0?=
 =?us-ascii?Q?C7XBWJOBKbB/OPD/WWuHy9X9aKZljZU/B8xfGLZzV4tq7HQRggixGLxp3u++?=
 =?us-ascii?Q?TtunFDFwVnBmxPsPY40Ppdiu4EacZ8+rEddqYRQRLc5A3zImWh4i4t6k4lFl?=
 =?us-ascii?Q?R+vONJGbe/v8shqzESyQh4G2Zy6m5zfWzVrjD0PleFVzIg+A32d9qFbx1lzz?=
 =?us-ascii?Q?IhyoMEBXV+FNmNq+LKy69ACm0qFtZEAW+OOB2yUvTVn5qzMbMH7C3n+LqBmu?=
 =?us-ascii?Q?5+MA+xLlRxDs7LyXrJTdLTyA3gH91Uqyzg3/E4IcoLMdIebmh+I/SwEqtXci?=
 =?us-ascii?Q?z2CzF80Nn8pyphg3V0+6NouhNgjCchAioOaW/0kMC5pEZJXYDBxjmNo0XUbi?=
 =?us-ascii?Q?SP64OxuZMS2+gYQo+T2D6Xc6aNhsitaISL09kjXqDVotVbQkQNBJ8dWFojva?=
 =?us-ascii?Q?pb9axzJrUjRRYNBBgK3hx2r+FdfzsE6PztKYpwmLCSoo1MJQnrl8QgRBDYF/?=
 =?us-ascii?Q?egLELNKH0Ce87IjYfJRvoYeQyucT7XcUNftasyzDj/hCD8VVn6s/IboAjU9z?=
 =?us-ascii?Q?JEDB39VoTTIWZwZU69EISkXiDQ4uRE2V75ZPTACIG3z3qqjJKf6NGJmxNVC1?=
 =?us-ascii?Q?iChwx4eLA7blDu0KNgzFM4JyW/ZwyzXPBPnIjANHTeCftaSj/HvL4ZauMxpZ?=
 =?us-ascii?Q?hBDB6U1vV5aZ8nKTexdKlqi38Tw6O/j3RGTy/C2bXb/o1XFoorz+KwscC113?=
 =?us-ascii?Q?AUiS2Y9Wvwx1xueafudezUPhfhy2IV7PnonoCZaNn6Viie4M4Cvxe+I1hdc/?=
 =?us-ascii?Q?ohQYB76gcf/GVLQCbVqB4NGZNPkp1Q91Ix3lhIaEw3a6FOAApU3OYoH+yC3t?=
 =?us-ascii?Q?Ptwus98yVcfWWvHspddCzhGvHpK7Fxj4znxRZz8Chl7nubbRpu8T14F2rFg/?=
 =?us-ascii?Q?+YtMwuFIveMVNbpx60wa2rL2cQn7atM7LCHHUx1C0aIBzahg1l25st5fwpvW?=
 =?us-ascii?Q?t9Xvo2VcaLwnNelu9YWh4eJ9oEFVfTuguUdhtMj9ID143bV2tuV+1q3ttwAz?=
 =?us-ascii?Q?vVk04U2Ben1ZOeM1FKkJR5YMsxUvxpx6qSCagUkDHNMUemai+KTyjUST+jCb?=
 =?us-ascii?Q?/z9He4IUW3gLI7gLsz4kbAtWpSGPcoCbPjPncFAK2aSim5DiyjS6xxJJ3eAD?=
 =?us-ascii?Q?bZ2CanLNa4Sjm+RQdSzUWG8uX5SUVTFFE+aufnSceGalisglsxlysyAEDla5?=
 =?us-ascii?Q?mnkBmPb0qng+RI8WdLFp1aIatO8+18Y8GCLRKLKWJbeuDGPmxKZWja5lQe/q?=
 =?us-ascii?Q?tTeg3YR5OdrMi25LGq3S2Mu3P+bi7HqnDffX5nmqcfc33xjMr1OBVilZ4OGd?=
 =?us-ascii?Q?ikw/cxO29oNIwf59APm/zaRNSDmO+AJrLi0a3SptiVXKiDFAf98W0oFJRDL+?=
 =?us-ascii?Q?jx51RVk0k/vDQsf/5BmJ05TTylcM9NBtFl+kbpae?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a23b72d-fe7d-4c7b-7cff-08dce82af62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 06:23:59.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PG1qjhPK0nsUVEa714YSLuF7rQ/fn18RFMGdYTVULzkGQEs1W0mujigyZXZ5FoH0pPzyq8Yc+Pvd8pm9fV8ciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Sorry. It should be "wifi: mwifiex: ...". I will submit correct one later.
> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Wednesday, October 9, 2024 2:07 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de; David Lin
> <yu-hao.lin@nxp.com>
> Subject: [PATCH v2] wifi: nxpwifi: fix firmware crash for AP DFS mode
>=20
> When AP mode is running on DFS channel and radar detection happened
> during or after CAC, firmware will crash due to the code of mwifiex is to=
o old
> to handle DFS process. This patch fixes above issue and had been tested w=
ith
> IW416.
>=20
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>=20
> v2:
>    - remove clean up for adapter (from priv->adapter to adapter).
>    - remove useless check of netif_carrier_ok().
>    - just return directly for mwifiex_cfg80211_change_beacon().
>    - remove debugfs file "fake_radar_detect".
>=20
> ---
>  drivers/net/wireless/marvell/mwifiex/11h.c    | 49 ++++++++++++++++---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 49 +++++++------------
>  .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
>  drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
>  5 files changed, 66 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c
> b/drivers/net/wireless/marvell/mwifiex/11h.c
> index 032b93a41d99..3d8f6c610bca 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
> @@ -7,7 +7,7 @@
>=20
>  #include "main.h"
>  #include "fw.h"
> -
> +#include "cfg80211.h"
>=20
>  void mwifiex_init_11h_params(struct mwifiex_private *priv)  { @@ -221,8
> +221,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private
> *priv,
>  				cancel_delayed_work_sync(&priv->dfs_cac_work);
>  				cfg80211_cac_event(priv->netdev,
>  						   &priv->dfs_chandef,
> -						   NL80211_RADAR_DETECTED,
> +						   NL80211_RADAR_CAC_ABORTED,
>  						   GFP_KERNEL, 0);
> +				cfg80211_radar_event(priv->adapter->wiphy,
> +						     &priv->dfs_chandef,
> +						     GFP_KERNEL);
>  			}
>  			break;
>  		default:
> @@ -245,9 +248,16 @@ int mwifiex_11h_handle_radar_detected(struct
> mwifiex_private *priv,
>=20
>  	mwifiex_dbg(priv->adapter, MSG,
>  		    "radar detected; indicating kernel\n");
> -	if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> -		mwifiex_dbg(priv->adapter, ERROR,
> -			    "Failed to stop CAC in FW\n");
> +
> +	if (priv->wdev.links[0].cac_started) {
> +		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> +			mwifiex_dbg(priv->adapter, ERROR,
> +				    "Failed to stop CAC in FW\n");
> +		cancel_delayed_work_sync(&priv->dfs_cac_work);
> +		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
> +				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
> +	}
> +
>  	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
>  			     GFP_KERNEL);
>  	mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n", @@ -268,8
> +278,12 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct
> *work)
>  	struct mwifiex_uap_bss_param *bss_cfg;
>  	struct delayed_work *delayed_work =3D to_delayed_work(work);
>  	struct mwifiex_private *priv =3D
> -			container_of(delayed_work, struct mwifiex_private,
> -				     dfs_chan_sw_work);
> +		container_of(delayed_work, struct mwifiex_private,
> +			     dfs_chan_sw_work);
> +
> +	if (mwifiex_del_mgmt_ies(priv))
> +		mwifiex_dbg(priv->adapter, ERROR,
> +			    "Failed to delete mgmt IEs!\n");
>=20
>  	bss_cfg =3D &priv->bss_cfg;
>  	if (!bss_cfg->beacon_period) {
> @@ -278,6 +292,21 @@ void mwifiex_dfs_chan_sw_work_queue(struct
> work_struct *work)
>  		return;
>  	}
>=20
> +	if (mwifiex_send_cmd(priv, HostCmd_CMD_UAP_BSS_STOP,
> +			     HostCmd_ACT_GEN_SET, 0, NULL, true)) {
> +		mwifiex_dbg(priv->adapter, ERROR,
> +			    "channel switch: Failed to stop the BSS\n");
> +		return;
> +	}
> +
> +	if (mwifiex_cfg80211_change_beacon_data(priv->adapter->wiphy,
> +						priv->netdev,
> +						&priv->beacon_after)) {
> +		mwifiex_dbg(priv->adapter, ERROR,
> +			    "channel switch: Failed to set beacon\n");
> +		return;
> +	}
> +
>  	mwifiex_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
>=20
>  	if (mwifiex_config_start_uap(priv, bss_cfg)) { @@ -291,4 +320,10 @@
> void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>  	wiphy_lock(priv->wdev.wiphy);
>  	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
>  	wiphy_unlock(priv->wdev.wiphy);
> +
> +	if (priv->uap_stop_tx) {
> +		netif_carrier_on(priv->netdev);
> +		mwifiex_wake_up_net_dev_queue(priv->netdev, priv->adapter);
> +		priv->uap_stop_tx =3D false;
> +	}
>  }
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index fca3eea7ee84..40f51e62b2e7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -1858,16 +1858,12 @@ static int
> mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
>  	return 0;
>  }
>=20
> -/* cfg80211 operation handler for change_beacon.
> - * Function retrieves and sets modified management IEs to FW.
> - */
> -static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
> -					  struct net_device *dev,
> -					  struct cfg80211_ap_update *params)
> +int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
> +					struct net_device *dev,
> +					struct cfg80211_beacon_data *data)
>  {
>  	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
>  	struct mwifiex_adapter *adapter =3D priv->adapter;
> -	struct cfg80211_beacon_data *data =3D &params->beacon;
>=20
>  	mwifiex_cancel_scan(adapter);
>=20
> @@ -1877,12 +1873,6 @@ static int mwifiex_cfg80211_change_beacon(struct
> wiphy *wiphy,
>  		return -EINVAL;
>  	}
>=20
> -	if (!priv->bss_started) {
> -		mwifiex_dbg(priv->adapter, ERROR,
> -			    "%s: bss not started\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	if (mwifiex_set_mgmt_ies(priv, data)) {
>  		mwifiex_dbg(priv->adapter, ERROR,
>  			    "%s: setting mgmt ies failed\n", __func__); @@ -1892,6
> +1882,16 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy
> *wiphy,
>  	return 0;
>  }
>=20
> +/* cfg80211 operation handler for change_beacon.
> + * Function retrieves and sets modified management IEs to FW.
> + */
> +static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
> +					  struct net_device *dev,
> +					  struct cfg80211_ap_update *params) {
> +	return mwifiex_cfg80211_change_beacon_data(wiphy, dev,
> +&params->beacon); }
> +
>  /* cfg80211 operation handler for del_station.
>   * Function deauthenticates station which value is provided in mac
> parameter.
>   * If mac is NULL/broadcast, all stations in associated station list are=
 @@
> -4027,10 +4027,8 @@ static int  mwifiex_cfg80211_channel_switch(struct
> wiphy *wiphy, struct net_device *dev,
>  				struct cfg80211_csa_settings *params)  {
> -	struct ieee_types_header *chsw_ie;
> -	struct ieee80211_channel_sw_ie *channel_sw;
> -	int chsw_msec;
>  	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
> +	int chsw_msec;
>=20
>  	if (priv->adapter->scan_processing) {
>  		mwifiex_dbg(priv->adapter, ERROR,
> @@ -4045,20 +4043,10 @@ mwifiex_cfg80211_channel_switch(struct wiphy
> *wiphy, struct net_device *dev,
>  				       &priv->dfs_chandef))
>  		return -EINVAL;
>=20
> -	chsw_ie =3D (void *)cfg80211_find_ie(WLAN_EID_CHANNEL_SWITCH,
> -					   params->beacon_csa.tail,
> -					   params->beacon_csa.tail_len);
> -	if (!chsw_ie) {
> -		mwifiex_dbg(priv->adapter, ERROR,
> -			    "Could not parse channel switch announcement IE\n");
> -		return -EINVAL;
> -	}
> -
> -	channel_sw =3D (void *)(chsw_ie + 1);
> -	if (channel_sw->mode) {
> -		if (netif_carrier_ok(priv->netdev))
> -			netif_carrier_off(priv->netdev);
> +	if (params->block_tx) {
> +		netif_carrier_off(priv->netdev);
>  		mwifiex_stop_net_dev_queue(priv->netdev, priv->adapter);
> +		priv->uap_stop_tx =3D true;
>  	}
>=20
>  	if (mwifiex_del_mgmt_ies(priv))
> @@ -4075,7 +4063,7 @@ mwifiex_cfg80211_channel_switch(struct wiphy
> *wiphy, struct net_device *dev,
>  	memcpy(&priv->beacon_after, &params->beacon_after,
>  	       sizeof(priv->beacon_after));
>=20
> -	chsw_msec =3D max(channel_sw->count * priv->bss_cfg.beacon_period,
> 100);
> +	chsw_msec =3D max(params->count * priv->bss_cfg.beacon_period, 100);
>  	queue_delayed_work(priv->dfs_chan_sw_workqueue,
> &priv->dfs_chan_sw_work,
>  			   msecs_to_jiffies(chsw_msec));
>  	return 0;
> @@ -4814,6 +4802,7 @@ int mwifiex_register_cfg80211(struct
> mwifiex_adapter *adapter)
>  			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
>  			WIPHY_FLAG_NETNS_OK |
>  			WIPHY_FLAG_PS_ON_BY_DEFAULT;
> +	wiphy->max_num_csa_counters =3D MWIFIEX_MAX_CSA_COUNTERS;
>=20
>  	if (adapter->host_mlme_enabled)
>  		wiphy->flags |=3D WIPHY_FLAG_REPORTS_OBSS; diff --git
> a/drivers/net/wireless/marvell/mwifiex/cfg80211.h
> b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
> index 50f7001f5ef0..0a12437f89f2 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.h
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
> @@ -13,5 +13,7 @@
>  #include "main.h"
>=20
>  int mwifiex_register_cfg80211(struct mwifiex_adapter *);
> -
> +int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
> +					struct net_device *dev,
> +					struct cfg80211_beacon_data *data);
>  #endif
> diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h
> b/drivers/net/wireless/marvell/mwifiex/decl.h
> index 84603f1e7f6e..9ece61743b9c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/decl.h
> +++ b/drivers/net/wireless/marvell/mwifiex/decl.h
> @@ -19,6 +19,7 @@
>=20
>  #define MWIFIEX_BSS_COEX_COUNT	     2
>  #define MWIFIEX_MAX_BSS_NUM         (3)
> +#define MWIFIEX_MAX_CSA_COUNTERS     5
>=20
>  #define MWIFIEX_DMA_ALIGN_SZ	    64
>  #define MWIFIEX_RX_HEADROOM	    64
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h
> b/drivers/net/wireless/marvell/mwifiex/main.h
> index 566adce3413c..58e8a3daba4a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -678,6 +678,7 @@ struct mwifiex_private {
>  	struct delayed_work dfs_cac_work;
>  	struct workqueue_struct *dfs_chan_sw_workqueue;
>  	struct delayed_work dfs_chan_sw_work;
> +	bool uap_stop_tx;
>  	struct cfg80211_beacon_data beacon_after;
>  	struct mwifiex_11h_intf_state state_11h;
>  	struct mwifiex_ds_mem_rw mem_rw;
>=20
> base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
> --
> 2.34.1


