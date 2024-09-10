Return-Path: <linux-wireless+bounces-12734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB8972C01
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B4287760
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70F18595C;
	Tue, 10 Sep 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpEHlR+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A8183CB0;
	Tue, 10 Sep 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956406; cv=fail; b=KnyJvN+3ilLzpqFuUlqz7inzX3RMTezUEHZPYCnV9MBmDtHdCbpIgmfaRuKXvZ4R+KFzsSy12xPCJbXZep45U5FT/6EalaR+e9rvTBXTtrqDE8bu03wC1AzaYddwXPOYx7HdZvfdK2nKo9N95//lnDV7vf3dJkGphhYou027ES4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956406; c=relaxed/simple;
	bh=3Rs8nnO5yeJvesogPi+cI5GlmsW/hRQIZB7KKwWC2v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rdy0LwtjqCCir+GgGWfxJCXUts8bG5k0glhTWaWzBE8Hxc2Gmv+ST8tEtHNbcXmKxlV82BpFj1bQVuSK3wYK1IczcljlFAUS878W1DKUlgOyez8yC1ohADnRhkIEvO4giBqAyzwVyOpns8pGgHyHYsDC1dVDyIaKyfYWHtR/rb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UpEHlR+0; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdOxJ80KPVPJ+zHm/+/CzWUaJf+O2OtVjJ6APhsCJ/erfukxpxY0B9f+MP3rXbIQhVAEcDr0MYrr0iTij4hpbutFQC2DNkUn4gH8FZFDY73WM48lxsmy/KytDqj0XITMn2rkPPm/vj3Z3PEU5dZY9Vg7KtyyoJm68U6L3vlSkMuVgCiFufb/j0Ct5QfrqMISitMpSo1XvbjRUi66HcyTqG6V2XUx9eoOgDdPKs+EhtSkMvBPARtL78MlaeaDvvbVw+a57n9t0ZBKJUKg5rrOJ6xBxlJJDDFODNhiBA438SGd1Xh+vZHSpsXokMyokGbvRBUCtdrVo5D3G/kF6f0SyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7odrYRAG6hV4ex1s3wpxNS09vtLsDBRU+KbxUk76TU=;
 b=LZBs93yG64fF0DCKWwqd77nzxe06hpbIm48jqVs/uToDqdUKgQIiJinPe0iyty6aAIdmYdmEa1AlY7h+y8A+qyyOeW9+4ZzGVbAoU+3be70Q25AR5UjZ6CktBCJ/lmbBuNNR6FTiY52UgHoNpw4jOiv71DIekmo3PhMp82uI2lekaTNmLrhnTcIhX6yBZvMSzdlfizy3h0TEfQvGglOTUn4bALY2w42QaM1hZD2dfmXdxYqBO19nJT4SUZRnVTtd/BICKGhePaQkFcdlndUlbWovEXAk1F/Gph49zX5Iqn2rDSSHYb7evUFU7UiPkhUGrHHUaZ9McuMsKMeV35omog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7odrYRAG6hV4ex1s3wpxNS09vtLsDBRU+KbxUk76TU=;
 b=UpEHlR+0AzcArFDw1BSxbT12c9WE2NEeSYgsp77SsVAYLJk5ZlodbFj32F71uKfzPjAUbQskwjcszEa9YZ/4HValYjXFqaAt5sYjk8ABrVmGasjYd+20h5iqWPpi3C9l7KDd/szPaw/PmPi+Eys8UOaYn6Exzr6ZRW2QdxDlusxGREZ1+WeX1PygJLjUb/OO2vewtrCar492S40t4ieJqvTqNFAn52E3qm8KlGtCuQBOqHj6jr0mgEMUiTbzmA5PUS3cdVwBcSDrRg1NQIfl/du/8eFHJnbtH09mL3Kh4J4SYAIMQT69hI8zkG5r6t2KPrY4Kat3tdqnwkN8PpgdZg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB11018.eurprd04.prod.outlook.com (2603:10a6:150:224::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 08:19:59 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:19:59 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index: AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJP/dMAgABP2xCAAGcLgIAABVmg
Date: Tue, 10 Sep 2024 08:19:59 +0000
Message-ID:
 <PA4PR04MB963850587C41FF78F4244E3AD19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <Zt9jFpyptX_ftH-p@pengutronix.de>
 <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_8gwj6GnV_yZ1Z@pengutronix.de>
In-Reply-To: <Zt_8gwj6GnV_yZ1Z@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB11018:EE_
x-ms-office365-filtering-correlation-id: 5b1ddcb5-266b-4f74-3833-08dcd1715cb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3dgvA775U9CfTIAlsxjKc3EnMhqcIWSdJlu5ad84NCS5xuUXemQ/POL+sRfF?=
 =?us-ascii?Q?C/h56NfvBfMgVgyr4yIWJ/l4eNpkIM/AedIv3ZquRDk0LnDZX4TSVBG+D7Bw?=
 =?us-ascii?Q?z1NPS1+86ByVX49sXONHAFLenXqn65DTEY82XVs0dbVyrRRkxJnjOs3/bXWu?=
 =?us-ascii?Q?+QSQ8NQuGXtZmofA5Nioylju2m4AuIHsgV528KpuWAwdWKfbpMxMbi//bhQ+?=
 =?us-ascii?Q?J+a3q9i0KG9tlV5cFdLIM3WuqQwTOgy93bRKZAXsOKMd9EXB4fKS9Vzf5rUY?=
 =?us-ascii?Q?NuyIm50wekz1l0eZPchrF8SvkCEReioW/uNKmKBkoYxFSnEi+XdVIvyORKfJ?=
 =?us-ascii?Q?/WJIdqEXtzL7pDye+nAw3XbDLlV17+ddh4EUtQZjZmFMiGgJnVWX+21xjZAN?=
 =?us-ascii?Q?op0vgpz0qymcN036nFx4rIVYFSbxXYpxzHhCcWpB748ytovoIQ5XMDO1wSRD?=
 =?us-ascii?Q?J7ghJFV1gHgQg5W71XZRFKSGDpSb01KPKWVWpVKzXyaR9JCQesPMXl/fwDhb?=
 =?us-ascii?Q?Ym/uYYJOv4cKzKbMruwCs7yArXtUpq6MGgqYiPsTHAFRjxFsNaT0gr4pUsVK?=
 =?us-ascii?Q?ba3z+0Hpi1+CWPqe3mwbGgzGT4uzBZHmvzARoTCkNb2V5F88enEDTAf3rzIW?=
 =?us-ascii?Q?GiaJ68DdSJ3EzKmBsCYWCi1IAoZy2yUbkgZDX2aMt1l3JGo+RcKV1JCXi6YG?=
 =?us-ascii?Q?U8lU4jXX3ThLjar1X/BVEos2jo21v8gT/i3Q78msSgU+v7gTWoEFcaoKTwRg?=
 =?us-ascii?Q?rEOcaojinhtQhAtbDTI4w9kMVqG1R8PcMvIALZD9QE2UHwMkiQGjmUvQogVs?=
 =?us-ascii?Q?mIVA7LPxQf+Kr7J9V/NyMZHVLPdj8GlNqEeklK8uCyGe+6rK7y0ZDXTxPP4P?=
 =?us-ascii?Q?ZwXBIOGlGjaGu1txTOalUl8XCk+YqUmYyFU/AgWtz16k3GuSWM7s+0uiM3NN?=
 =?us-ascii?Q?6E7C0ZQulKSaOJmfYdMSWRmNdnO6OcxQ52JYZsUTiEqZpjcDOTEmlAZV3qJG?=
 =?us-ascii?Q?2XKEDLTcAWj9FGUnOMVCwGwPOd33lCXiTMjoTYi7YTLLjMhcUstVnawRU/RS?=
 =?us-ascii?Q?n72bDJF6sLjG0u7kIFK4HUxn2/QlNHSah9BIPh68a/8tJ5QHZ/E/6vSDCzAf?=
 =?us-ascii?Q?EgyqmHdhMTNUfGZzPRtyuJZ7zMCNdjZjEP7gSvVKOLIZcor45UxDsAP9Iv7B?=
 =?us-ascii?Q?eR1u9RfINwZ9bGBmMte8k8SLDtU8+2s9bOVIzfa4XOD5rrDgDXtI9fdWjMb4?=
 =?us-ascii?Q?FU5rqLW7oKjELbp7m87v+2tTUSjazPFd38TL5HM/0/2rAL2cI57cGLsfrgoe?=
 =?us-ascii?Q?y+krOwGBSJIA3h39VVcOGvMEecabfLS7QgaU1Wui5zgWKUkzZPIwegQuDVRY?=
 =?us-ascii?Q?HCE1LA2HWIWPcjYaxqnjMi/+Uf9byARVyMPHtNBOSSubAJi7CA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bORrDyye7KE5jjJWwD1TbLM3uKqmiEDCMcZJjq59uwP5tP15dDdmbTf6QCOP?=
 =?us-ascii?Q?Z4X4CNeog1Env3ncLHAkGA/AufqDoW/z/srJft+7wazqYadcQJ93Mr1zvCo8?=
 =?us-ascii?Q?SsX4XGa8ZOAHZBIi3f5ONWvwgXSy9KoNp2IZ1+llpl3Qdo6z9M1KkifAGKbF?=
 =?us-ascii?Q?uzIhvyPe0NpsJVtI+MzGxkSH4fmn2Ekmj8xRW6NqWDO5NWIXOyN7X/ssHRxR?=
 =?us-ascii?Q?8o84qjSfVGRm4TOiyuIg4DYSUqwSNc23XVCuVg3PmdY4SABzKA3/PPWA7USn?=
 =?us-ascii?Q?TG9zoYRS1eMpExpKYKya0xTvAGmzywxSzQBzFohBCHj0HNn7cQtP1CKuq9ol?=
 =?us-ascii?Q?lx+2GMuCpQQvRkBuxBZ8mTCj2vsgQKhMSgvBsXih1d4gjELYd6nEGxdYmkXI?=
 =?us-ascii?Q?Q0tsCrDSau9Q4leHGsGIZM5eBAyDM6DozPb2QVKU+zt7Z5v2wkn+NmDph8mZ?=
 =?us-ascii?Q?UOsYWMtLLTYBTFen7rfC2XhtFMSwLG+NuY1nQWAHM5kkoCORkK3sISHRjbc7?=
 =?us-ascii?Q?qISWX1sEtc+WfAZbWt22vQ39WM5TX5dj/vJFqSajoGimckF43pxtQtoN6cOA?=
 =?us-ascii?Q?w5QUvucB76wA2gcK0IgmyHKevXPXw2kXFI2m97W/RzakpbpgTjYpYVedhjt2?=
 =?us-ascii?Q?Y3fl+cPaDMaTULjO1QGyxpH+cB0Gaa5ejx7XxYbL+vjqEXsTylJvQumsFurB?=
 =?us-ascii?Q?tR6SwYkYMHd5718FXVwyyRKUkFYm2h8aj7INx+/9L8Sk1IeZOL8WXEhu22iN?=
 =?us-ascii?Q?NmUCRKYdzVxD+vDMB5/IRTLIP1DRywrmhIdo5HONoHWlpmSkTRsORJfd5PAo?=
 =?us-ascii?Q?cpihKqdUdBg4KeBlS+N+5dn6/7T/jx6yp8IgjdwMVe5ekKuEdb1jp29Nwxw8?=
 =?us-ascii?Q?imEgcTcHGOS5tTDjGL9RLmfunxccOeBP6XsR2ly6LKkXHIiqzqt00fsj5kAv?=
 =?us-ascii?Q?He53kDbz8ow7eEn/ms+nqfP3PE89ElquTM4gJIUyk1akbVewHnKRC6022bEl?=
 =?us-ascii?Q?PDV9AKgKIjptcJM65kB4NFVsPlA9i2L1KZkf2CoAf3MTL+Al9f2do4ZP2N4A?=
 =?us-ascii?Q?p2GlulR52XU9lNzP/qBfx5PNaFUirDMpCjapqs8cJgmXcRUj0VyiG/lYu0hW?=
 =?us-ascii?Q?quuIBDDhqjEg14+R+oqjwdsoUnBhY3SMlkF/j4/XbtBeoEVyNdCOmC4RxY2v?=
 =?us-ascii?Q?WS7ugIefzbepKrJliWS1DlAJ+2XfxTLsgxZyt6rFHa1JxOz1ygzvYYD+zq3/?=
 =?us-ascii?Q?YPYpsucIdQBHXISFF2+FU/NKwQ5pkUZb69VrFlRkZrB1zKI4KpJN/2J/Fm92?=
 =?us-ascii?Q?i3d+yhUqHz7j78ZOoRKefTOdrHeweulmFCZrNjV4IBkxuw8ivYjWbdVYdY1M?=
 =?us-ascii?Q?HxmArsAkWZ5VaBvu1KGgZA8zslhuFCtSOBpMfRGTmpLztQ7KpjSIF4f2YPKR?=
 =?us-ascii?Q?8+ehsBeM4rRn5WctCH/pAY+J9ELi/x8SQgRu9QLJL617d5VILupdkJ/oN00h?=
 =?us-ascii?Q?U/louM918NrxkC9wyDAczyx/zPvcvx6TI7tmu4wWSbqdxHH35/R6k5t3MlXU?=
 =?us-ascii?Q?QVbBqsUnWCoCUFmRrbc0xd3muJJGfiuyN3KSP3s1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ddcb5-266b-4f74-3833-08dcd1715cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:19:59.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkrkTOV9RtDpYgp2tAOr8yPZ+2p5994fdAEgtoBikEdDlMJca3tSp8iNuqP48ugZhry1ELN4Dx2vn2C5w/sFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11018

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 4:00 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running=
 on
> different channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Sep 10, 2024 at 01:52:02AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 10, 2024 5:05 AM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > running on different channel
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > Current firmware doesn't support AP and STA running on different
> > > > channels simultaneously.
> > > > FW crash would occur in such case.
> > > > This patch avoids the issue by disabling AP and STA to run on
> > > > different channels.
> > > >
> > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > > ---
> > > >
> > > > v2:
> > > >    - clean up code.
> > > >
> > > > ---
> > > >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
> > > >  drivers/net/wireless/marvell/mwifiex/util.c   | 44
> +++++++++++++++++++
> > > >  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
> > > >  3 files changed, 69 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > index 722ead51e912..3dbcab463445 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct
> > > > wiphy
> > > *wiphy, u32 changed)
> > > >               break;
> > > >
> > > >       case MWIFIEX_BSS_ROLE_STA:
> > > > -             if (priv->media_connected) {
> > > > -                     mwifiex_dbg(adapter, ERROR,
> > > > -                                 "cannot change wiphy params
> > > when connected");
> > > > -                     return -EINVAL;
> > > > -             }
> > > > +             if (priv->media_connected)
> > > > +                     break;
> > >
> > > This hunk seems unrelated to this patch. If this is needed then it
> > > deserves an extra patch along with an explanation why this is necessa=
ry.
> > >
> > > Sascha
> > >
> >
> > Without this hunk, AP and STA can't run on the same channel if some
> > wiphy parameters are setting.
>=20
> Ok, I now see where you are aiming at. Here's the problematic function:
>=20
> > static int
> > mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed) {
> >       ...
> >
> >       priv =3D mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
> >
> >       switch (priv->bss_role) {
> >       case MWIFIEX_BSS_ROLE_UAP:
> >               if (priv->bss_started) {
> >                       mwifiex_dbg(adapter, ERROR,
> >                                   "cannot change wiphy params
> when bss started");
> >                       return -EINVAL;
> >               }
> >
> >               ...
> >               mwifiex_send_cmd(priv,
> HostCmd_CMD_UAP_SYS_CONFIG, ...);
> >
> >               break;
> >       case MWIFIEX_BSS_ROLE_STA:
> >               if (priv->media_connected) {
> >                       mwifiex_dbg(adapter, ERROR,
> >                                   "cannot change wiphy params
> when connected");
> >                       return -EINVAL;
> >               }
> >
> >               ...
> >               mwifiex_send_cmd(priv,
> HostCmd_CMD_802_11_SNMP_MIB,
> > ...);
> >
> >               break;
> >       }
> >
> >       return 0;
> > }
>=20
> This function is for setting wiphy params like rts_threshold and others.
>=20
> mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY) returns the first priv
> which by default is in station mode. Now if you start priv0 in station mo=
de,
> then afterwards start priv1 in AP mode *and* have rts_threshold =3D xy in=
 your
> config, then you run into the "cannot change wiphy params when connected"
> case.
>=20
> I really wonder if the settings done in this function are per priv or per=
 adapter.
> Is there one rts_threshold setting in a mwifiex chip or are there multipl=
e (per
> vif/priv)?
>=20
> If it's a global setting, then why are we interested in the media_connect=
ed
> state of one specific priv? Shouldn't we check all privs?
>=20
> If it's a setting per priv, then why do we choose the same priv everytime=
 in this
> function?
>=20
> Either way, this function looks fishy and changing it should be done with=
 an
> explanation, just dropping the error message and returning success is not
> enough.
>=20
> Sascha
>=20
> --

O.K. I will add comment in patch v3.

David

