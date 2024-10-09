Return-Path: <linux-wireless+bounces-13754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADD995FB8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF391281C2E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C23174EF0;
	Wed,  9 Oct 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRbs/U5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788918EAB;
	Wed,  9 Oct 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455067; cv=fail; b=YfLm3G+ilz/gSqMMYbPPZHg89J3hjcMAIKHK3L+YtPUFZzhOqmygZZG7GpOt15cnm0wMS7IdiDtWuylmFSpXyBaq1UmNYO4gKBo6DQXZT2o2qoEAkgWZcP0lVpjLDo+XiJ7tzfqzuzlnO7FR8jgKTkkdJrQaGr99TKSWUm3S0Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455067; c=relaxed/simple;
	bh=jRcVdy/rTrHoGUv57ir4sNmSrnIb3I4f9c0DViGq5Ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYBW9L3Z3Xq41aRhjDvVrZNnyKUyJLMyRDh2JhqpXTF3JooRNFUXR590SyjhQPWUj1H+MYBD+VomQDEYeIcy3vkJLtF44Nc4RoA3D25dUJTJSLhMiCBEHsn+eRdxM6MlpBUcFhea1AAE0vaFuBrOOcugsNtCHU+8drIlQn/MB/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QRbs/U5y; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGWgCsKA80IQJSH2VPKjI83vmUPZNoMNq24m4wb1ckTnRR+zX5bVzO4+SAIqSV/2cDG4vQ/VutskklcTXS8hjRFtgpJceqWNMrU4tfAguifZV7nZetW9R8ueokei0IqFFeXqMKedtGHHBVq0SG/UvVa6ovLzqK0AwMDGC1A7kvGKCamcJaH+Onvm97jkR8oH/9hQJ0daCkeqACgVBJUiH6P/W7AFkTa7E4UUzbAmoh9lM+HAF5W++sjVGLHSULVp2d78YzOdjkIjhOGn31XWx9hOVUNWk00jPAbj61NId85u1i/dsx6l7nEYBy0Gyrw4guosueJrFCp1tsNGUHMcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJtNU0NsPLWViiAyyKk1KDSEKlUvbDLEYHmx8oKuuUI=;
 b=D9ARZQs5Ju9vmU+LwH+xnGjiU+1EKoxBTO3glTMfE90eCB0mTp2AlgI/hjEC/cskGjgmgBq0QbW3RASJaS2Oc9LEvM5oLbza4HMugitYgfeSv49yP7RGyPdXxp6P8T4rORU9Em5Q28ygtTrWJg3TtTbEhl9xjlIonYbIqBHJBtfdKZEVx0ra4PSNLsm8LyEENR4ydF198XU8yCyDuOVF1+kZi9xnd4XUqLDPjU16SKTMcIs/bRpPYpjMscF/jFjBon2h8u3L6PiIsVuHgqh6q6zed/6UDrDT4OAnQczwvXQ+w3v6KPT9GhYMGAD1AAXyWtlz+7a+b+mHUyFCkrrc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJtNU0NsPLWViiAyyKk1KDSEKlUvbDLEYHmx8oKuuUI=;
 b=QRbs/U5yKoSoqz5MpRYukQGuykNiqNm2+jO10ugQS2rTGLrV76SQ16+b2g053s2GCZMhC2jt8p3zq+A5pwnYoTk+fGen9eEKUnemaknBnY1n8CxI8bBvQblj59Y9zw6dMZ24EBc8us2ed0PhF5nLi14OPcq5czQab7OVzLnB/+5iDVEdLD3nSNsT4p53VZOvanoWLootRuD9BswupT8yphnxyEbpn5D8Ky8AyLjlQC9HcQGqstjGEWkz16vF24hmvFhIet1NAPMIE+pWSlmqOhymUtzZOuP+yOQLWOeBOeKXuKObEjs47piY8vBhdlHE6Kb6Hey/Wi1SHNdGTTLGEA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 06:24:23 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:24:23 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [PATCH] wifi: nxpwifi: add debugfs file to mimic radar detection
Thread-Topic: [PATCH] wifi: nxpwifi: add debugfs file to mimic radar detection
Thread-Index: AQHbGhHbSh1YThQ6HUK0E3dVLSoJ6bJ984Zw
Date: Wed, 9 Oct 2024 06:24:23 +0000
Message-ID:
 <PA4PR04MB9638896E46E752E1C4898F98D17F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20241009060935.9074-1-yu-hao.lin@nxp.com>
In-Reply-To: <20241009060935.9074-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7933:EE_
x-ms-office365-filtering-correlation-id: e5244da9-fa60-4193-15d9-08dce82b0453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fDLWLBffV2acpcDuxodNmbS94hxTesggzm8tTvO2dML8W/R++I9xNbExVW3b?=
 =?us-ascii?Q?HIVuolgExYylkacHE8BKUc2yk97xl0oqvY4yPaeM5T92gVX+qGivoruroUYf?=
 =?us-ascii?Q?Px0cv+95RlDQEorsREM+aOc9bh0XfRSDcKQyVpSsgUjFJXZWDmgl15rUPKk/?=
 =?us-ascii?Q?26H60CkMwrNj22kzvS7kze08S7ZG8DghlBDYE9FpxdWIDM+bOopJw3d8vX0S?=
 =?us-ascii?Q?AZQ6/OW0SxqjU7XzwQSfZpvtjdgkb55lvqOd29DNgB1ZXJcvNyRMkJ+UFfJu?=
 =?us-ascii?Q?DUBNaCCVsdy6AusUnMfwN1rBtZwEXLiWFKI39uCQ8CFLK2da3uy2T21dSx2I?=
 =?us-ascii?Q?yGaVM6DVyEHMkAYyL9VKpdsCeJUnQDqUnTPUAr6T5LCXReLCwknld5glFNQg?=
 =?us-ascii?Q?2hJ4sjQv2oDha2E+s4wK1AtGmStZf9nfQ63cEyboI7PUy7s6ijy6vgR4aKjN?=
 =?us-ascii?Q?TrKAqYGOBZove38VmvHYbKVlmNI3pM/cvdgdrkpCBfUP2ubQlDVvqHidm/eX?=
 =?us-ascii?Q?tFv8f8AL2HxxKfySbLUx4lMO198gEdt0rUDZiU2ULxBj+RUmnH+GScbcBlG9?=
 =?us-ascii?Q?vBglxa1nvozgSwB1C7i8IaUmABvToOCW9O97c67829R+KSGCq9+KB0u68QsN?=
 =?us-ascii?Q?GXGcvFIrnUy6ERHD5u5GDliIKy4wHRrsEG4Xc/FGhe9EyRLqtDffiz79kY2C?=
 =?us-ascii?Q?anLAUeCyCsQ7KDgwQ9x7v0vkxUXsiYP3rC+2g7IVRkp5XUw8TcUy46eYvSnZ?=
 =?us-ascii?Q?gKn3cnDcAM/kgdJxmx1Sfz03ayE7IUr0dU5cbj8jfqEm81J/wF31r3zBBRQS?=
 =?us-ascii?Q?wDXnjVFzQa2sVvOnyY1EKOCND/yd/+VMjOBfEDdIo/E3A9BK/QqbGxFrnq2U?=
 =?us-ascii?Q?IR/ZZb21sFHsjxtO7i4pAsJRU8V3XroD3AO/mlgQKBQlNq48tvdfxMY/iv1V?=
 =?us-ascii?Q?Cz5qr55RiHNJGQTblJCv/nGgykZxZYMyJTPCreWvVO7ZjIKVw3SFTaCJpZGv?=
 =?us-ascii?Q?5p/txjX0JiXeT3DEhBopV07VGvSjlIXA/ZYZtU+XmT5IZQV/B6JzqI8RiQUM?=
 =?us-ascii?Q?fV7XNGWcvjkI543VUovJgUe5xsszFYkFnc/rO19NsL28YB5S+vUkN/cFsV9T?=
 =?us-ascii?Q?anOqqO9N0iltRTQVTirV5CnSnVt5WlNOb8AHhKvvY1luAFTNBo9t9Y3ibcrz?=
 =?us-ascii?Q?gROIZMsYMwl4CrXKhXoqP2ncEaCScNj7ywg2fpOz+fFrJUvhEnGWW3SKiBp5?=
 =?us-ascii?Q?L92Matm3KHXyjIu5c311XXfDQUG7VyyCrPg5uqlWi18Xf3o+Q9freZImkqhP?=
 =?us-ascii?Q?QVmvI6896dcpiHZcA+w1ZyMxvdwTHO1XR1gsPE5HEBCwZg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eScq2mUIyqFCsaYwAdJZfl1EYHCis0Y91Ou+IimJA6ffWNDQcRSbXaCmrvjT?=
 =?us-ascii?Q?zvs/eu39nwF5i9nuQbY/IFYdMSYKy4f5zIYqbdECNGbJc3ndS4PeUqd1hKCq?=
 =?us-ascii?Q?rTcZeBQBRiz0G/gsjcN0kox1sr7r38Plx/3GiPEoaIcVXOJm0PGLyZAKeGfx?=
 =?us-ascii?Q?jnslZqI1G/MNWSRcFPkAntV3+FPyeJlZJdj1mr6qRBwYwV83kYduI75LNAFb?=
 =?us-ascii?Q?rCCbMazCq+4jPdqcVVACyAqNLI8cmxaWPFz5h7MS3qlkcsoa604hyfypq16X?=
 =?us-ascii?Q?7ABOeJyLZqyYitbN0eF3eYqZMnObzlVGDBay3C3YSK6ntK6hUVW5ExTz3wPB?=
 =?us-ascii?Q?78vUm/XXj8dvhhuR+oZ55i7LqgZ+fdaNu20QbStTWaQZzQDor4KZr7/LplN6?=
 =?us-ascii?Q?cPY0rPpBbqn2yRrydUqaD6j6NcRp2zi7KdXABsR/z9bUgkIg2qJ8Zr/piTSn?=
 =?us-ascii?Q?CWT4b0+pKT7gsvIrAjBWekRddG5rC4GbgLNAE0UQ2EyMv3AQaPkCPYxI6hI0?=
 =?us-ascii?Q?Yz439gV+FrXVlcZ1y3MfvYZ0UHN4IFH4zfOZ7YGz1BAhWYOm+Nvyi1pwLz2O?=
 =?us-ascii?Q?IjbgmA7j2JPPVqiH6nTrulRuA0Ek2yh31ILeMUfpB//VbO234xXZ+heC5Irl?=
 =?us-ascii?Q?KztJMGgPcALfx2aJKk5HDWu3xwAkAfZ7sVkgXLh0J7hH0ghm2Onzd9fsY+N6?=
 =?us-ascii?Q?Xtf34zobJrO/BqUUysvGJjc9KiGP7DzoAFHoJ4GFpzcmP9DF9+/a+2STabMs?=
 =?us-ascii?Q?jWA9Cd+uO+MQgr180AdXUD9zEISyH70pOfeJa2CGlyezmXBSrwqiqJNSytne?=
 =?us-ascii?Q?Q//QOPRGn17CeS0aNnbtUPD/J+Llbaf2FVrBnRZTvbiGbMpZEaIzDllSurSS?=
 =?us-ascii?Q?lvvWfHGFsyyLfhQaEr4VmBleIYqhh8DcAs6rJcasP2mxGjKXZTFSJ+R1gntG?=
 =?us-ascii?Q?PY1ZSMIfUgakq99ZlyrDQrpehCXMgtu5n6fsMX9rYyFll4vc2ImLPSkqSQTH?=
 =?us-ascii?Q?x4PV0+j/ZwlHzdqdYB62qeDwcBH4D/lJoFfuZqh9jsRYg7HlyoXa8M90Y1r1?=
 =?us-ascii?Q?mvJ19yksHnsGbrg0EpQ197C+RQaRSA9jGJV7P3Bn2JlySzgyTQFasakwZ8h0?=
 =?us-ascii?Q?VZea1PoZHxvVryR0/S7rCEWaR8QmncJjOV+sZjqrS9OBUO3dQdl/8QOy0q54?=
 =?us-ascii?Q?EneQPB7sZocWqS+GZWOiIkDNqZ+EnnCShRZRzXwa3lUfBn7w5RKAZOFX4U3u?=
 =?us-ascii?Q?sD2I/Xs6/4V1cq8nfwhpO6CV/xcCKxfQinqr3vAc892yp+S9tfRkyybJG05u?=
 =?us-ascii?Q?JWE/ZNyS4PShOEnUxG6fW+TofZreJBEhTSkC1wMxpp5RkA3jfWmhzg4jdNdG?=
 =?us-ascii?Q?FR4Mx4Q4czbgYDnUx6ewp7WyqIS1EcvtIMkRd3w8/gj8dqnHzE7Q67q96VjO?=
 =?us-ascii?Q?7ktNO+TpCXdYxv/u4NxOnWVWVaCHeIDFPb5bvpT+odHQgPw1QBteoLn+PwGt?=
 =?us-ascii?Q?vkXebEn35oJnixZpghJX46Ye8CbhKuopUB72oSzea+TMuirVJUlvtnpu5g73?=
 =?us-ascii?Q?Az3UXOoDnkHo0XYw4+Jzfx2vLf46XS3D42blicVw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5244da9-fa60-4193-15d9-08dce82b0453
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 06:24:23.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KDMKdJZ/gdYRmloUMxtLlnhypZUwmg7T81/swFaQpG7xdwEmP25+nWrNbsACc9m8LEoyjBUL2WVgQgbGZ3w4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Sorry. It should be "wifi: mwifiex: ...". I will submit correct one later.

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Wednesday, October 9, 2024 2:10 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de; David Lin
> <yu-hao.lin@nxp.com>
> Subject: [PATCH] wifi: nxpwifi: add debugfs file to mimic radar detection
>=20
> Debugfs file "fake_radar_detect" is created to mimic radar detection. Ech=
o 1
> to this file will generate radar event to cfg80211, which can be used to =
test AP
> DFS mode without real radar detection from firmware.
>=20
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>  .../net/wireless/marvell/mwifiex/debugfs.c    | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c
> b/drivers/net/wireless/marvell/mwifiex/debugfs.c
> index 9deaf59dcb62..cf9604661aed 100644
> --- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
> +++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
> @@ -909,6 +909,47 @@ mwifiex_reset_write(struct file *file,
>  	return count;
>  }
>=20
> +static ssize_t
> +mwifiex_fake_radar_detect_write(struct file *file,
> +				const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct mwifiex_private *priv =3D file->private_data;
> +	struct mwifiex_adapter *adapter =3D priv->adapter;
> +	bool result;
> +	int rc;
> +
> +	rc =3D kstrtobool_from_user(ubuf, count, &result);
> +	if (rc)
> +		return rc;
> +
> +	if (!result)
> +		return -EINVAL;
> +
> +	if (priv->wdev.links[0].cac_started) {
> +		mwifiex_dbg(adapter, MSG,
> +			    "Generate fake radar detected during CAC\n");
> +		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> +			mwifiex_dbg(adapter, ERROR,
> +				    "Failed to stop CAC in FW\n");
> +		cancel_delayed_work_sync(&priv->dfs_cac_work);
> +		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
> +				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
> +		cfg80211_radar_event(adapter->wiphy, &priv->dfs_chandef,
> +				     GFP_KERNEL);
> +	} else {
> +		if (priv->bss_chandef.chan->dfs_cac_ms) {
> +			mwifiex_dbg(adapter, MSG,
> +				    "Generate fake radar detected\n");
> +			cfg80211_radar_event(adapter->wiphy,
> +					     &priv->dfs_chandef,
> +					     GFP_KERNEL);
> +		}
> +	}
> +
> +	return count;
> +}
> +
>  #define MWIFIEX_DFS_ADD_FILE(name) do
> {                                 \
>  	debugfs_create_file(#name, 0644, priv->dfs_dev_dir, priv,       \
>  			    &mwifiex_dfs_##name##_fops);                \
> @@ -945,6 +986,7 @@ MWIFIEX_DFS_FILE_OPS(histogram);
> MWIFIEX_DFS_FILE_OPS(debug_mask);
> MWIFIEX_DFS_FILE_OPS(timeshare_coex);
>  MWIFIEX_DFS_FILE_WRITE_OPS(reset);
> +MWIFIEX_DFS_FILE_WRITE_OPS(fake_radar_detect);
>  MWIFIEX_DFS_FILE_OPS(verext);
>=20
>  /*
> @@ -971,6 +1013,7 @@ mwifiex_dev_debugfs_init(struct mwifiex_private
> *priv)
>  	MWIFIEX_DFS_ADD_FILE(debug_mask);
>  	MWIFIEX_DFS_ADD_FILE(timeshare_coex);
>  	MWIFIEX_DFS_ADD_FILE(reset);
> +	MWIFIEX_DFS_ADD_FILE(fake_radar_detect);
>  	MWIFIEX_DFS_ADD_FILE(verext);
>  }
>=20
>=20
> base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
> prerequisite-patch-id: ababe4f5cc6f52d23552f4ada6efb26655f247e3
> --
> 2.34.1


