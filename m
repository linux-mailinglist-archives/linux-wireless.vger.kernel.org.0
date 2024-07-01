Return-Path: <linux-wireless+bounces-9741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59891D58E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3511C20B5B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771E23A0;
	Mon,  1 Jul 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s2IKIxc6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEA10F9;
	Mon,  1 Jul 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719794826; cv=fail; b=lRftx3GkhSSyBC/nof0ArU4ZhA6j09ZGzVRxrarprj9yUWpozSCusLfvugS/mkm1KYU370Ec16ZRibmwoDcrISpkIaYZPo3GnCvecBr0kCdwC6oXUxkXLQshTNqv8olsshM0aHzgRDSAD0h/ye/NJEv0WdE4FFtT9OaSmgaiZFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719794826; c=relaxed/simple;
	bh=uWhiIYORnCdWSqpYBJIJWA0C7FOL4neeyDFQeMISJRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VzCjYWU3+D0Cw60TgQRm2ru3sS1gt2OLVib64dKoMfTbAwl7lw2RKtNAXkDfiUTS9saopAzLHiw39AJ1sdw59kEwOApFznuqha7zJOMLJlUrzccGssButCgHkdoImHpSvTdd64PPH6/AmgD1SKmvIJ8h48Vfc+8eVKJ8guBQ/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s2IKIxc6; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irw7JKDlm6pa+zK4tfterleCxEhE9XXzenqMYakKLEHoL27av4hpxqnHgwkO7Rh7Ka3vmXtj2xNCq+qo8TIlj0Wzcgpl84Tf5Ac9/kUX6JgIaC6kf0OUzlmiM1maCXEyOcSwNrF25zUTxCvP/80acZUy2vPg40HEkItvB0Ee6Aggr0vHyQaecv5aBWoWw1CRz94ArIVyXUyiN8kGh5WIa4KNAuwriPExl0hjfUOBf9SoDyQUzN3mta07DjDrDPwzO14k/nYsQ/fWXU2/DhvRD0gv3nqv3r2PYfh+4Mhvq+5FsH5l5IU0gZboXuVsRmtdWcFKirFLeKy6MgonLlD/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhQ4HR0Gx6AV1LwF80NEYg4tcYdRMxlHEpOleS1gfQ0=;
 b=XIEcr2S7/zejzI+wfSDHtDdNqU3W//0Lf3UG5ufdezVwUsfL8iurk9ZNBt7xJqDYwNm9IDSQdhiM08vPdV/pJjZFzHYSb5qCOs7VwOjUrjik4yfd6UJUkPbQgxa97/aO0MyzzwZulVNzzY+0q+Y9sB4g+EATjLKykHDfbJMjHQsUQkn3adXioLk96x/kfCoeYfl+9kBa4lBGrUysqBr0sIzaUqoRj5TSzEKnsM2Pq8gcPoABPvDDzhPebTVAgGcJRm9PkZmfpuQSE717qwThf7qnS2j54iv3G/FzSB9nZV5vpyWy9D53XDwlwkv12fLun/mZodxsUzCu/AYrq7sSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhQ4HR0Gx6AV1LwF80NEYg4tcYdRMxlHEpOleS1gfQ0=;
 b=s2IKIxc6NFWRdnZ6rAhiWx9QxyWGV6SgrYPboH5OpEs1jf3j2wCkLgQUqyaQocQH8HU9rzZzEgiSftFztDYuSwX0QePqiUWz5XFLi2NehDlc9ZJjaPqtjLXNe7A5UcCWa4f4AO4tNSa7wOFtOhPhQUPMZ6RpKJkJOE80c939SDw=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 00:47:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 00:47:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
Thread-Topic: [EXT] Re: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
Thread-Index: AQHaw6/6IZnwWyq+VkyBRkmHmcqDk7Hc4S6AgAQ2/hA=
Date: Mon, 1 Jul 2024 00:46:59 +0000
Message-ID:
 <PA4PR04MB96381CF2AE91D91B814A7E6CD1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-2-yu-hao.lin@nxp.com> <Zn5ytQtySds3Ix9g@linaro.org>
In-Reply-To: <Zn5ytQtySds3Ix9g@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU0PR04MB9441:EE_
x-ms-office365-filtering-correlation-id: d7b8b700-576d-461d-43bd-08dc9967510c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WIU0mCWsvKHaSegL8onLTD0cWA/ittJ+r1opvfht7di/5yxjnv6S+MYKuPPs?=
 =?us-ascii?Q?b/26DhoNs7URC0ujrZe0vdGM+PzKH7LFAUb4mMhMWX2A7btvLo3hzVq5Mhj3?=
 =?us-ascii?Q?eSVMWcGjMgVEfoZxFVP9kX4k12HPBwlNuuY0a82kCV5Wd83Es/Ki/jAFcskp?=
 =?us-ascii?Q?eaO5hzn75kOn5lb8jrhs2P5U3f/ILKGaeRStVNv5ZtlIRNEl6jz/5vcKP2X2?=
 =?us-ascii?Q?mg/WECGgPCDwVcv1uBvhk07D2D7IPZ0LiGO7v0zOTERvM7tCzA0h35CSkKlg?=
 =?us-ascii?Q?7So5rw9g8W7PI+SjVkN6SuikzleZ3BFCXdKGkj5vCZPNmCNTn0jbWjkkf1Qn?=
 =?us-ascii?Q?sN1V5uZUBLy2q7/O0VALe+8wmLuzwKxrpu/d50B5l/dKzbnFcT94iKBl+KXy?=
 =?us-ascii?Q?bTfIU0liPzx+uFhnlbCSTIqTd1W0HXS0heYILZiq9xKrviHsNUSsIZ+oITs/?=
 =?us-ascii?Q?JWTwTYh9rtpBe3gg737GXm9DX38x6ak+jEQ1gWq3dCoyf5qVk0StNjN/pSww?=
 =?us-ascii?Q?C0KgqdP/o/59oj7XvpVMFsRG/sj4YWt0GTMaUIcCd1HpP6VqWJzoh/FxJZkw?=
 =?us-ascii?Q?+ymx9Z9WZNRCOoswgqt7JfFiGy2ohXpITBzWXkjh7ngsgq5uV5co3OyLzLrG?=
 =?us-ascii?Q?Ra51faOIioWlpWhqx35ceHPo0l0W4ZutnKf8CMEWgFnQHZAStcYtQUqiD+Vm?=
 =?us-ascii?Q?2/BkiMZRcN2uEEnz2lQ9Di3WpWx1AuIAVeXIyudAMEQi3s17iYGV5NnlxQJ/?=
 =?us-ascii?Q?jHTSVAy3r8KKsKoI3iGipPLEJKKoh72V61DNf93qbS4H1DuPgM7IjZTPTFeZ?=
 =?us-ascii?Q?dxBQjMpo8VdvvJVh13TrkBqWVXRpXssUL5unh5DtthFO5h5FByMdmOcJcjHr?=
 =?us-ascii?Q?sd3VOW8IjUpVoogWTbbP6gvmTDr8j2clMR/Fvafbf4OwFpjGOmK6Ef2/PlxW?=
 =?us-ascii?Q?haRZEQ5La0B8F6fPaf3Mur02UQ69LHcQE/dgvdOZrTgkDBp7Jh9xSgzslPAV?=
 =?us-ascii?Q?wzXQiIB/UxaWvepeQWlG0qFdNjOen/ccj40NwC38scK1oJ07/UqL5yFPcktI?=
 =?us-ascii?Q?i9xxwszU5tkPQKYR7ThldQqlGizmEtrpTDNt/wBydInyM19HY7M1HP7bLi54?=
 =?us-ascii?Q?DaocNO4gLXOwEZKcrUJDv7fJalgX8lmxAdmhnPIEUv7xMStJt+kPNJOb1JPJ?=
 =?us-ascii?Q?vp+PcbCHeblJ63S3BRwpYexhT3g3UNacv7iEgU3YXfyuh/hhiCGMepzXM0bd?=
 =?us-ascii?Q?N/7cVlwwScizNwiK8bwievLTmFc+dIv+SG+fhWr5vJb1DLNgHM+bhXjgoKcT?=
 =?us-ascii?Q?SJorR8bxntU5kiDskYEEMdt6BcyCgLSe6y2fTMQqjbpzmINPuZJkeNXobMKf?=
 =?us-ascii?Q?jBD6SbUeX0x757cHCa6vd1yDusasxlHW96T1wc9YI9y7l+UfdQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8wlIOlAtWJt5SOUxnxCIrThKGw9TC9fTSzmxK2fQjbcaCm2qlejwZq/5p24y?=
 =?us-ascii?Q?I0+zupmooZSdBQIej+/X6nSeYZNAes4NqT5hCRU7P7BVzy0T3JbB00uGL1AC?=
 =?us-ascii?Q?en8A4/DkdQpGF2dwr5QAJCrDPCUKSKtTYKb+acZ5zohYqMs1R+AgCdMV4v1x?=
 =?us-ascii?Q?YD7VqN5z+ifcD4JG9P44O27X6Kjz8KH7JNaUPa7GkB/S5qM2HRTQ02V4uzgQ?=
 =?us-ascii?Q?bIiHaE/IBR81sklWpCs78v5KWdjwv7wSf3WNmVkXgnwEZ5LbE05t1g0m+JGC?=
 =?us-ascii?Q?wB2JCsuLRv3PjjdYJzEva5yykwPs9guqPxVrZmP15ArPBaQ+RAO4ws1tSgcu?=
 =?us-ascii?Q?xyxBzpBHnwk3E/klJz6aYZT+4h2pRdlVWsDUzTSJZhNFkGOrPP6q5FGAjeqU?=
 =?us-ascii?Q?Ub5av+84I7rWuWLVHbwOZNhr9qP96jdFfZrUaWd1wgfO52RtrhMSIQ1MGRAT?=
 =?us-ascii?Q?/EWAM671dIW5aYl5lNKyK+5slQw9Ae4Yq1WAIHD9ba1md7iS170S5V1+MQLR?=
 =?us-ascii?Q?c4iCJlJhFGOUfOUEgDiiOYXL2mbVpNyCM6///W+bGKcVOVwAh14eRjjhktb8?=
 =?us-ascii?Q?/oyXSLmAQenJGV8KyFfm0fSLDl4MTSWG3Y7U6jcr5/Ftxyt3rOWLQmKiqfGy?=
 =?us-ascii?Q?1ZJqTXuYipQ/tBa+WVFWl3hT7or2O8a//YKt/dtQX81KkCcOFvWs1sm2SSfI?=
 =?us-ascii?Q?/Ss+OKm8+PEs10LxyKVXgQbTdZhxEuJ+orcXvPSLb34XpJS70YadN0bFg74T?=
 =?us-ascii?Q?BeUPCHSQk1+fcIjSs5YD5VzjWvcCoNj/RJG4u8zxFQIVYt9bSYE8zZmfNq2G?=
 =?us-ascii?Q?yX5TEQxi8r9ksULdlp78UrxKU8YWdK9RB9Fj1Rt09FeDyJ2ELytM7DzCMXsr?=
 =?us-ascii?Q?HsFDnjS45WHbdkSEJ1th+sQh5YltEwS6EPm3c9oj13accvaJTi+Tgw2Hr2Pg?=
 =?us-ascii?Q?Q/I1wc9V/kRvX5uoLNJJlBxLHx63C6FmIKrMb4TX2ukrpHiXmG/bqorNoGml?=
 =?us-ascii?Q?/uycrzjS3OoKkmvTCPDNcjOlzn6mt8Z6RujeUvhBhyxwdlHi+u0ocnekyNeC?=
 =?us-ascii?Q?4oBTOq6mRspMVNeMK2latscVs2vEnuXFwY3LQwCzmXMaMEk90mud6xJMvlk1?=
 =?us-ascii?Q?/m5p1N8J/7WDQ99B1R9/vs8wQMcli/7bLF0cCvFARoENasbgpbO3tasTbDDd?=
 =?us-ascii?Q?BmMyTSuqWdXzypxZVUR9S97iBZKqpWKsDURwvX3ZEKuLBWUrrn+sBoSr6/Ny?=
 =?us-ascii?Q?co+El9Hi5lcjZkqhD7YOSPohxgI65MdZzaPJKJdnObMCuosP2EOF7A75MQqE?=
 =?us-ascii?Q?H+gN5/tAxsVRM/piM6AA3kXxPvFDHSMQGGptWppWVQrPgvLX+Il1+jNK8sjf?=
 =?us-ascii?Q?91MFZfy1K02PCyUGJBVHf7oR5+oDuTl2U9Rzheq9NmR6CIA3kaEiij3Smsq5?=
 =?us-ascii?Q?RfhTSoUtblGOCaBv6MU+tBbR95Cn+ooTZkbx9QdjeaTJr6vV1x6L0XQkwgrl?=
 =?us-ascii?Q?QJz85dNOO19LCSF5UgzSWPXhPYSOu1xfiP5uKSuAD44sl6fp/N3SGzBNVnW+?=
 =?us-ascii?Q?rqvXqe4nsHg7UsVxR/hW6cDjebwYmEXy6TrqMbVj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b8b700-576d-461d-43bd-08dc9967510c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 00:46:59.9728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRtQQL1xquX2NidBFOJP6SWVDOjRBWA3MetcHMgYcp5PP7gaVkto6LaUgyalso2EGgOzaYmB7oaOd3PF8hp0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441

Hi Abel,

> From: Abel Vesa <abel.vesa@linaro.org>
> Sent: Friday, June 28, 2024 4:22 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 24-06-21 15:51:26, David Lin wrote:
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
>=20
> Hi David,
>=20
> Please read the ./Documentation/process/submitting-patches.rst
>=20
> Just a hint. There is no commit message.
>=20
> > ---
> >  drivers/net/wireless/nxp/nxpwifi/11ac.c | 366
> ++++++++++++++++++++++++
> >  1 file changed, 366 insertions(+)
> >  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
> >
> > diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c
> b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> > new file mode 100644
> > index 000000000000..3e14ee602cdc
> > --- /dev/null
> > +++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> > @@ -0,0 +1,366 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NXP Wireless LAN device driver: 802.11ac
> > + *
> > + * Copyright 2011-2024 NXP
> > + */
>=20
> [...]

Thanks for your information. For new driver, it should be submitted one fil=
e per patch first.
Once if accepted, it will become one single patch. That is the reason, I wo=
n't give commit
message for the patch of a single file.

David

