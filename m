Return-Path: <linux-wireless+bounces-8990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800290815F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 04:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E11C21946
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 02:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFD42042;
	Fri, 14 Jun 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PE4cJs0M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494E1EA6E;
	Fri, 14 Jun 2024 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330811; cv=fail; b=h+vsIZZBvUfbMDIx6Xey9XgUZHaLgEg8SzkNJgz4dXuo148F1Si1GtkGBL/fnMSRKQ5l3bM87BE35JE8wczJoXcVyoYyICTBaQrXseSxqTH1MrOQiEWzMV5bkMe0iMcQXszWgDDy+T/1lgVYvGHNawcrNwZgaOteBEypgUf1uTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330811; c=relaxed/simple;
	bh=aUI+tYCNwFSZoH9WRMNHz9SWHzFDjupaN/CbBPpp6ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPTiLwtV4sYtH8F7YfEWESxPWabSQLjlalgBeDV6l7UuKycZA8J7sjtFhm+eAYtlM9JVMW6ivK3CfLUpABi2MXN+VyCmpB8MEigxca432hHqPUVbktlpHiOAiHDh/rSio/LRD/sQgxFcgYYg9H/FlRB49F1+NCrogzyKNgj66SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PE4cJs0M; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIco2zc2Qq53+jC1mAuzRVNc35E9pibfhtXGMdaO+7x8OjDfmQT4qxcJilitrqMBU8Uv/BEl++z7FMlFly9DsEMo8U9lrbudwcwcnkJmIMrDHLc4SLpkh7ou05Wsqot4RgFZKvx6hJGdHZHTbg91a+2Xw8o714w9hVj8Xj9T6+79KLQS2w8UMXPvWwjQsVnBQqFv53VNOOKU7YnaxEIYDofWsWuXr0yhnb7hii7+Rv2SIKqg5M+AcINgsM3DScvFQi9Dm+6QXyRxl/SENso41NGM14cssWGRGegkFJnm2q5ZtDvGr2iqQxR6UkWmfnY0xVkUs/VCZzHuGTk6TGWeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6jHCXxbZPYeNXcRqTfCBkWy6fhdjffP2QOINSUwDhs=;
 b=TLWDbgFUNnouMoNX4Mdioe4DX0WKC2rOJ49rTxqB8reCZV+9yZYiSYm7YNmScePZGSpMPtj9P8L1Mayw/AsP9UFrlfwiDzFJA+I8j/QZNvve3fk1h1YthBbIFCqXkauAmCVwOm2W6zOW0CuzaWkZTpmZAjBkQ6EzFIUd0QekKv9mWSLimXynQ7tbyF6EBvQ+uGBnjW3tYqPbnbxH/7embU5F8ERBJyJ6N2yzQE0VmlGf7jnqVKFwfhS9LstOUPinYal9AVX/eQgCy948lfkVdT9kvYlAefbfRGf/LguBJmSRK/RGXYOYzcWf3DtcN6Fi80v5tWScf8HeD9uZfMaqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6jHCXxbZPYeNXcRqTfCBkWy6fhdjffP2QOINSUwDhs=;
 b=PE4cJs0MqKoLfTTeqDH2n60ZywWEqwzs7JT1HdAEh1XWPO0gjV3M04txOxEKun3TO745Z/aq7CcOgrUMmGc51f0WwyVSRALQjZdjRP5y+s71bxdvv7hoMyNXhSf7rUFZaxkrb/Keo+oMDxeDy4sSjPRYFLP1ebuSFWFR8nV/ztQ=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7596.eurprd04.prod.outlook.com (2603:10a6:10:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 02:06:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:06:45 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Topic: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHakVah/NlfkBV8NUyUKYHJ747D+LHEcWiAgAJqJoA=
Date: Fri, 14 Jun 2024 02:06:45 +0000
Message-ID:
 <PA4PR04MB9638C0A141C53CC2F5898DA1D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
 <Zmmeg15YQtiChZ70@pengutronix.de>
In-Reply-To: <Zmmeg15YQtiChZ70@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBBPR04MB7596:EE_
x-ms-office365-filtering-correlation-id: 14df51b1-9650-4d5a-ea21-08dc8c16a48a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|366011|1800799019|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4RbHAYn0EQBBSqZbt1gvDtoW3p93wtNpfNVTFXC5NfaKBaLgtEsI+i4AKGsc?=
 =?us-ascii?Q?rzRvfP6DVqUBZuXUrj1oFkjcL0ZUObkUf5hM7mK1dLVSjM79PplyfE+uRNi8?=
 =?us-ascii?Q?RGGVXlqhzPOGukq4WfBGvLqs4cv8nTYXSOq8FUEnuCHNvdGCZkSn4dGHcHjX?=
 =?us-ascii?Q?SBtr1bVQKMSLPSOUYwOapXuti53LUN13pkhbRzJOPOcB3BljfzlBBMPtfLg7?=
 =?us-ascii?Q?u3jYTONA9Q6yJ29lThjk5tpCjHfiLvwnjI4SS0ZbkLAueglSHKNN5nqVmlmX?=
 =?us-ascii?Q?D8tZybF4pnGJVZ9T9ysVZ4XmabZyAv9/CL6DTRrbV/JQ8Tj9mqgTtFneGHsY?=
 =?us-ascii?Q?UMrt/jVxcF06g4QDd3gZL2AnALoC5fKrsv7eCArylrjIzgs2HLrJtEV/Ivnm?=
 =?us-ascii?Q?AG0TOopJNl3x6Mq17SSBgmYwypSMATJ8xRhg14io7PwpXJoJGlM4ZgNZUYkR?=
 =?us-ascii?Q?8GowlSMLzNCVEPUnOhKuL5D3wg++bzfsE5yH+eAeQRyaYN9cdKmzzG+pYI/B?=
 =?us-ascii?Q?tuV+z2Uhjv5DRyZllvS3e/4jQfU0wRn8zTpWAiycrXL8F45zZRzA2WMGmwb0?=
 =?us-ascii?Q?MmVwPmQtP8c2XatQ+gAcDo9XuF7/1WMVWf+2n1xNJTjzcO3q9P12nUy/t9vM?=
 =?us-ascii?Q?SL/xF1/vYeZI/5d+p0Jif3zy2vdBFEFyCVYHtGYq/NxfToX3NrQcFr/9AQwb?=
 =?us-ascii?Q?JuXSD6wBekgnO50+9SbL3XRpAp8/ZnItiEC+IK2x1KRhh8DntKNCDEBLNp2N?=
 =?us-ascii?Q?RfMZ6S6F4ZWJYh6kyAOqVdwDZdaqScqKUM7R1AD9uGQx6h0gkv2aUq/KfjQQ?=
 =?us-ascii?Q?M5iC6BV3KhlJFBaBs286NwuPm/r/bbW92hQmDOM6gnbAYQEiWX8Su1vF6uB3?=
 =?us-ascii?Q?bK/UgwHhbs8fPaR1xEK3MN2ROT+hxMX2+Wi9yL+XOZ2uBsFD1vTrT1LTjoTC?=
 =?us-ascii?Q?DBB+yocUCIlbeZp5D8py3NEQXwG01o60VTqkBOnIq4xVESOmmgMvCB7Sht05?=
 =?us-ascii?Q?P7NuS5RLJDlgDK7RW7xiDmRfmbJ1/PyIgI8xui38viy+lyPcjQs9ID9D0rFK?=
 =?us-ascii?Q?3/7yMhaLX3J4Yk2riQ0BV5rZr0x3PLV4Q0p8yvdzwDPmx3T4BlNtW8GaOWd5?=
 =?us-ascii?Q?OBhoPGW2xLLyR37ubwfpVPbov7KnM74LZKoU1GA9mBctZ6qrJCy2GvNZXWVb?=
 =?us-ascii?Q?qtydyoDRDhf4BE/VvV9rQ71nd3js1ZLaNdGAY5gjt8urSDAAWBcWPqjI/Uar?=
 =?us-ascii?Q?aByltk9+QeYW+/TcRCtVqEiaIHi2072l1623fY1rk+Em6nEOoPhHKpmtO7IC?=
 =?us-ascii?Q?UKgbkNsSfO/MPtGco9q+oB8qYSYZKVsicLG2GgXsZZeDj9YI1HbO3c7ooETl?=
 =?us-ascii?Q?LGXvjoA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(366011)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ssk7rpWxtlbDNsf8uGSYSglMdclKKXXTNQNz8uZbcJlHoMtNh/IawpO7yUZT?=
 =?us-ascii?Q?h5MiIUM0hPfGzqtIuqa5zcIdTlP/jg4AWt1+925IypQhvdOPvuo14yFE3sLf?=
 =?us-ascii?Q?4LZDmaHFuQr+fHQAu92gmU7jmF4Hw9VvFcRAlBKOZ/PY0+/9ooLDOlm4qYRG?=
 =?us-ascii?Q?ooZU39Ky+AQ/NIFzww+psroK1Ev8EOewyGGG8PJQLdiKSbfsaItDq/lBOH3N?=
 =?us-ascii?Q?sAuYJGNJY3Zl8oMw72nvTwn43gCALQuUGGNjEWoeXBWR0ma2eDaFjqO/AqNC?=
 =?us-ascii?Q?XuIcEA70OO1a46ouFsdHpGDbo2H9hC2e2Av5Irpce5x4VtGBQuBVqRlMDVWs?=
 =?us-ascii?Q?/e+iRdbRnCl3gyWuNRsv2zukhRxfm/GRVeFN3llmCMIVJwBxT/efNKirDU2w?=
 =?us-ascii?Q?bPKWyJuIVXIFdQv5EkYddlelM6XtKMc5c+FlKPPC/iP7eUeTTHw8X8OgryA7?=
 =?us-ascii?Q?jKs8viZ8tOdx8hRsQ2JvinGIuKuF/r765qhqEKQRtOqrMdhXXsF5iJEZ2vp8?=
 =?us-ascii?Q?Wg2NduMnxh79vWhIuYVmuiBJLzS52QpQ/ZYHz+1qMeBNycPkbB1Yx5l5UErT?=
 =?us-ascii?Q?3vJTKHI8iBlsrALcrEbbqjmfuqsYb1+6BP6homS7txZV098MgwxLAZbc4nB7?=
 =?us-ascii?Q?CIEn0Jjl04xhaEidjTDM0bT2AMIL5xooxOt8MDgjAPTCQaILKx84kvpVMeJ6?=
 =?us-ascii?Q?64V4dcHxsDo/0437Z0X1rySXqMkHe60dBPbAJgkRVxqfI9vTO2GF+avJ9TDX?=
 =?us-ascii?Q?+K4N8uB3gPzovJ3IHb47ntUZiwNjs7k+QE8INSDwo8MUtL1pU2jG2ZO0swAL?=
 =?us-ascii?Q?Qf6mJBGKBVi4Ogi9Bi+q61YyS2uGzCUT37Sq8yB5QYZ1AZkxe6ppYJM+a6XC?=
 =?us-ascii?Q?Gob0vChngGtf6RZrZ/9Xo161Bwoj21RtLJVD9YjrRt964UHLTBXBak4gVbTI?=
 =?us-ascii?Q?sh5vOd7p9UVua5Le6s1x94XviRNKjYLi5nMajoplou90kBElURAhnfLTTYYs?=
 =?us-ascii?Q?BTSbjNNXcjJP6Qgew5KmDkZxQaS+24U2CKbbcbiD14SJ9q80SzuaSduysnEK?=
 =?us-ascii?Q?fZZL1sDCJfg7oO5UboMdigMo7CNQnyyKiv00UQR6ZKPV+aKkSQU0K3+imTIr?=
 =?us-ascii?Q?APSafuCmL8u8QCy+bfC09AfOuTFpa8GlmHK4c0lxsDyVS3aKkZMlkTpeJcCo?=
 =?us-ascii?Q?YyCZQwcxCx2Dt99ndRW0lqm14gFd2KwQZGp2vHPzhJ4YtsW80Vq3WPgUi7Xn?=
 =?us-ascii?Q?OQxOueHRA+qOqQNblHjBrPO2V6R0667Tx0FVsn+I7khbHoAcgP4iocO84fK/?=
 =?us-ascii?Q?yTTYj1BkTiWYl1xtZZLlHLvoKw1Tu2D49csbe5Njzjw7KyFoV4zPIv7UzR9u?=
 =?us-ascii?Q?vPc4r3AthXyS0SWj8ylJpw045s9WQgSCXL9cZwD3tJaLEvrn6uyszyyuzR1B?=
 =?us-ascii?Q?eKQ2RgoaOx+CuVjL4G0MigLV1nYbEcNc0wq02Uk40NzUpJR2g2AnicARxnce?=
 =?us-ascii?Q?CqNwxPzS31EKvftpAQwDig2PViJQ42LtOpZXCZgknOiVEAFLuPJIf54eOQug?=
 =?us-ascii?Q?h258lmvEW51l8sGrTmDPTHJTI/wIuAXn3YZBIPYg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14df51b1-9650-4d5a-ea21-08dc8c16a48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:06:45.7087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOHFzJAuM4Defp7/kHrFoFsBuIoPCA9HIDUuIrUFjQLd6X97cH0e1HiuuI70lD74b5fSgJO7MTqKuSMJjjLZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7596

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Wednesday, June 12, 2024 9:12 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mo=
de
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi David,
>=20
> On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in AP mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >
>=20
> > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > index 491e36611909..073c665183b3 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > @@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct
> mwifiex_private *priv,
> >                               bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
> >                       }
> >                       break;
> > +             case WLAN_AKM_SUITE_SAE:
> > +                     bss_config->protocol =3D PROTOCOL_WPA2;
> > +                     bss_config->key_mgmt =3D KEY_MGMT_SAE;
> > +                     break;
>=20
> Shouldn't this be |=3D PROTOCOL_WPA2 and |=3D KEY_MGMT_SAE?
> Clearing the other flags when SAE is enabled looks wrong to me.
>=20
> Sascha
>=20

These fields are used for the configuration of FW, this is the correct sett=
ing.

David

