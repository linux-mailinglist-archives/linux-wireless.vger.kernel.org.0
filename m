Return-Path: <linux-wireless+bounces-10426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9D938B7A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 10:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F413B1C20FF3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6553219F;
	Mon, 22 Jul 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YO4qLGEK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA88F66;
	Mon, 22 Jul 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638079; cv=fail; b=YMInj2TqiEa9GK3DplqvmeVjsY9aV5ihwWdTsekO0E5aPjDdoGmJg9NAX7eyUj6jzfzrKJWz8SpgcRWU5OzGWVQ7zQ3yh2hkbEG58ZWflmxsqzG9AtVlcc+AAyLM1T98LH38OdnJoq3MlP1IxkEHQOQiL+mv4GUnQnnlfDsOwyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638079; c=relaxed/simple;
	bh=po7vuXPOHjx9CV4tSmmgAmdYuq0CO2JD0BfipJ7fU8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GHXmhSDRXwgjvTJTXDKjAUMLUb3Gmx6iuV5ZWwvO07iNCSshqph/WU60L4iAXbOycVJPKLeZ8ZrvcTFPLCO72yQkQTOD0LwzD1Q3L6YDN4zA7ztNYx8S4fxgBgKrFIki7crfQQwmRTUAApZoAMOdgmWUGIT34BJ1E2mXsXI9cyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YO4qLGEK; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWlNZbpOaVY4dEAShqgv0nL69reGY7eRhUBrOy8j9PGooUkz4Of4gXUeIlhoL2EQ8EMwvBpqiKa2s4uXGE+fGeLb2gScT9YiHrhgoXBJlBqj6HQdZ5TmI1YGWpku6IqEmsdiOtR0+tXCmWH3KG8RztRcmX4pqvt4A3aUunGcG70PstRXiRbe0tVU3jHi5FlArISMn+ajgipoE3CRINpF/PDuAnogFvUpIJUd0qzbmgzNri36d+et0Lo3JP8etWWCUv+2WszNnTdprRURRMUpnmnxGo2NGOPifSA3IWqLDrBeh2WZFqRiBR9roi+StFRyAVSstQaytT0PRt/dbo3PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdKF8wdXV2Pda3nitFHs35HG3vcFmkFPfwumMBRtorA=;
 b=Pu/n9wAuSwFrKbfVk3TqAaL6/EKm073A91ybvjFkCueN3JfiIdmkwBT3ZHEmQXhKQyy4mqLBhC/vFznkB/m4iDstJkd5SbD7gg1SKNI947r2Mzvx/QIx0pbdVTRXCz6apOtGvUaRIl68GxSDBXb8YyO6ujjPJtiTmGeMHHXVaOho0Dw6wZPJ+8JAbA57/v4KpDKeVOsRbCxrcvC0SyDMAEY5YJS2fW3qs2VdNqcqzSmaGPmiMpChGpRwqxVzTNGt3UGpAouHlmEE5dKivjba9mNk9G/A5dd18Ryx3kGJ+1PCoRsG5wQbad5tJY4Dj/gdrh1rJ7++LytRMm8RkrPLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdKF8wdXV2Pda3nitFHs35HG3vcFmkFPfwumMBRtorA=;
 b=YO4qLGEKXM7cwX/1JwRD738V/h61eeZLi/ttdHc/DZ3/9Ms+aBPXIY3Japx6ElTdju+Y2mEuM2nU83GPYqZAtFb64K8R7uUYRjzBubor4f9/yuQFtBdKGNOWJw8gAf7VfHbKszUXhQTTZu0TftN3Wu6N3w50OUwyqoL1bWUwXVE=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.34; Mon, 22 Jul
 2024 08:46:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 08:46:37 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	<briannorris@chromium.org>
CC: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for
 WPA-PSK-SHA256
Thread-Topic: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for
 WPA-PSK-SHA256
Thread-Index: AQHa2WWaGXlv+rFYlECcLMI8nXT5wLH9kGCAgADZ8YCAA/ocgIAABh1w
Date: Mon, 22 Jul 2024 08:46:37 +0000
Message-ID:
 <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com> <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com> <Zp4O68Y6oss_pwMm@pengutronix.de>
In-Reply-To: <Zp4O68Y6oss_pwMm@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBBPR04MB7580:EE_
x-ms-office365-filtering-correlation-id: d50c53d2-fec1-48cd-cb05-08dcaa2acc4f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dk5M8t603fQZY0moiYG0c2zTY3aq7yArpMB+K45z4gNVa+9QCQ2rLtTIq7X+?=
 =?us-ascii?Q?W6HNmuHkJMulYyILL42oxLF3OtQqTc1dT9Fu+rD9kzyOA/8XJ1HEOlQInHFW?=
 =?us-ascii?Q?+H0s8KbytAO8sYjQLSIPaQ2lwZzlGiScNoSLxLQId/+/23+MonwEjS3bdkNz?=
 =?us-ascii?Q?CVh4EIu9fBPe2UJ5uNFQI8XSKq1JFnbalNkT5rWtEHm8OZrxjpTk2mKkjCWw?=
 =?us-ascii?Q?pH1e66shh1EXjiDgAMlxEBZp+NuJ+UAQQs0vwE7+JqBqOoJlhzSPSjzQtZn+?=
 =?us-ascii?Q?sYDvl6eGr+ydhGEqHbN1+fZTLEArFUzSPHTbCm5cRVZgVPYStJkp8+w46rGg?=
 =?us-ascii?Q?qdGG5050DRzcEJ/nAe7/06iT1yx/dOwFlMOW3xtElOMSWq3QbIQk1l6ZokW/?=
 =?us-ascii?Q?BJsTkzDuHxpRaul+OJUJT2oAMTvvUsD3kBwthVe04WvgrZKKQRIh/mpH2egp?=
 =?us-ascii?Q?DYaZvpCHGSCqL/+RaqpVgGQJ2VZEe+tta6dhOaUigpxxxXrrEy4ZM9D/ZoTC?=
 =?us-ascii?Q?z27iDGEWwlh7F5m8QGrtFa9nN3l5T/PFkhIdzXdPoXGtbdUDkbJMZBdG4eFn?=
 =?us-ascii?Q?njrW+sZsXIzlNEAK2nkUY8a+pg9Lf7cQVjKOxSVID1q+bAMaU89LjXUc7wIO?=
 =?us-ascii?Q?FclF8oRcfACdARorSYX20kiYqBEgS3oAi0g9dwtjo/q0SWHVFG/4gdlwkviZ?=
 =?us-ascii?Q?wnI05paIz5y84o4I7+Vrl8HQHD1cYNwIQOo75ZR7wQ1UlD3anenw5h53ZfuR?=
 =?us-ascii?Q?YWlsQ2xqEJwjhCRfDJNhXfvsO+ySvvKs2e2w7IMOe7D0FNEsgTuTT0A7GTM0?=
 =?us-ascii?Q?3PrAjVMPvrV7cEKSEEMw/2ZOIkJMUQqSRtnzAzF99JEMSj3+9gWC+fokPvLV?=
 =?us-ascii?Q?TchDycOmcQpvN+NFqzAosxjKEOFnaZSBo0nA8WvVHCpYMEEPBQVUXYfvGZ3L?=
 =?us-ascii?Q?ku0go3gIHMGMmAfsE221/xrlsnVAIDN9a9304KMtC70BYMPbWjzrK0qQ6nQL?=
 =?us-ascii?Q?DRZz3JiPmiPaJIyZCpCFZuVOWHjXbrHzKRGl0FXJH607rd1Jx2b5dmvoogSt?=
 =?us-ascii?Q?y+BYt4xFGrN9gmQHrzdmwfcp10a6j8UwCcnwssWxqS5GfMKtKAuMiC1oTtkc?=
 =?us-ascii?Q?zDA7KV88IwJlzR0nh4NPbViDdmis537Bfd/ANoCyfz7c1FZma/pAqG1D96HY?=
 =?us-ascii?Q?ZthZycqFd9nnZMt9M05OLOk+dnYi2cMW/p6Wt9SQAIJspaDD+jgWqYEPDXbO?=
 =?us-ascii?Q?YLE0SPiK850uacp3jZKiAS9orriUi3Fy4nIMxPlZ4gDjhEifVff2jUTyQG6y?=
 =?us-ascii?Q?28Rzs4RsEgg/r9tSJG4014R04V0jNQWCBIQ14TOMKv/MxcFSl22pYiHzmawk?=
 =?us-ascii?Q?FsW4HnWbLmhonk28MB9UY7Te1K/1T5thOjZTqvXgp6Bb+iuahQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WC36NCTfTKDgJXx9leCMSd8dBK8aOpG06muQzhVLFnhcrYwSFyrQlpfk3UI+?=
 =?us-ascii?Q?nCHXH5cMuAqXRPr3HySDI+ibLa72n4CdBMCwFmcM6Pt+Uyd8FM9Nwrrj8KWo?=
 =?us-ascii?Q?VnH4mk/5l3JPFUtAZUqrtsw73+XQw9sgs0xaB4N9qJkmcnMYD8fdpGFxeTbi?=
 =?us-ascii?Q?R1iqOGmE+QtgRr+hAAb7tj8ri35qvvbtedpu9MiRi1r9fNxOk9ZTaDovw33A?=
 =?us-ascii?Q?MLzMJiCbjwKEjj9iqA77A8WTsIz6jwm8rQMa4ZlT1PI8pxZieA+3sBy1zorb?=
 =?us-ascii?Q?3MhFYYoulxfOv3vrzXdeUt4VhGrE+GFCM9TQKXC35LhrIuo/l9jZUFpjbXkL?=
 =?us-ascii?Q?RJMO3kN2vxTiaGgJP60oLRCnRM4N2HFkGdSDA9cItaWRBFE1hySVZN8ymbqv?=
 =?us-ascii?Q?RHu8wLePvzMS+Y7S3VnvdeDKJHF0kA61EqXh2iOVgLW9hkPFVcKxyNSD23oc?=
 =?us-ascii?Q?C2a8TialJ3Jqc+mKam8JrvaHu64PV0kQ7Q8t3eUE+ajlWsXyvZk2lQYBC2dA?=
 =?us-ascii?Q?14mYpPYxQrXm6ICBLnOHwPiZRsZt1v5n18JrKpBpYbhDkT4CdIyYEthOtMQk?=
 =?us-ascii?Q?5Pd2rozPjoLvwmfmuVarKDTLxbrTPiAkVYbZNNxItXefQQvYGdTB5FD8GoIk?=
 =?us-ascii?Q?iUuW/zapTQozbIASJV8IK89k7Ttf0UZV3peBkNr37or48MTa5ZknzHvP3f+e?=
 =?us-ascii?Q?brkoVwNh7fw1MbMFikvmAIee8DHR3sOOQLG7EzDqhvHDIRCOBAemcrWEZktc?=
 =?us-ascii?Q?8mEJRjX+CTpprfacmQnyeAw9zseSuKXQQ4SPud4g+N/qaFRXhL78oOR1tTOJ?=
 =?us-ascii?Q?JuCEF+x/rFbg+hmx+opXfxVYQ0glU8JiDON/yGn39QB0Z1MFfpxANXaEVuPq?=
 =?us-ascii?Q?7GNfx9vfG7tdUEHwqb03oHH1y6NaGa378iNREOZrVqUYWBO7BmCxBwLYq3a0?=
 =?us-ascii?Q?parW+TJlS2X2iQbKTnSKLmxjfN1NFH1sV47smbWk6Bvw0b653UmJRN+Vv62A?=
 =?us-ascii?Q?0IGQnHmyhQNTMYEwyb7FzAD/3oZ79A1ga+koYGK2GxPiphX0IZzz0Eq9jFe4?=
 =?us-ascii?Q?QjOYNJkF6tVeYb1EgyTEoPKQu8zKFP9Wp9/eh4+wHRaEf7z4jimGW4HniWwo?=
 =?us-ascii?Q?k5SEZ92e0aivvCz1zN6OgZTC/29t+vXHEPx+fB0oz5B29RPe5KDsYtbT0Mm7?=
 =?us-ascii?Q?5DD9C7HS0ydw7/b3bzy8Vgof6/GFQC7AxkpbHXDu0igOcTrvgR6RzGWUhtZl?=
 =?us-ascii?Q?UY5N7DDUsFvGMOncgn9WVmrQZVokAwY/U2XMlinR1ot6YUFQUxtuR+S57vjN?=
 =?us-ascii?Q?0mnGQsDmttgHWrM8zCb8F/EXXnzzCLI2g4VSEhFME37C5jiQwD+OnNYyL3F5?=
 =?us-ascii?Q?nu8AQ8A1EB7XukYjuDgfy8mb4AybyP69ZIMZoYFcJ3WXzLhQJZwAfCJsKgfi?=
 =?us-ascii?Q?ZSgN6qRAsL6yCvAHuhUPRcJWBSQG5BNsOwZj0ejav3CjQCeB7aYvBzsAhjWn?=
 =?us-ascii?Q?EBTZhLW9+QRBMMngsnRNw72s7lNQMdPqNZaZ3mk+Qt+7zxWJQYvpzKKWjkkn?=
 =?us-ascii?Q?HDKJFZClglWa4OgmWJA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d50c53d2-fec1-48cd-cb05-08dcaa2acc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 08:46:37.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FydfrifdC9xHEAiFJZEILnrOMdUaA5TwCVgJFBOfiYd+K36ZbmyPH7SyNkZYvwWPBfDwZ4PsLHAU/BNLLcC8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580

Hi Brian and Sascha,

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, July 22, 2024 3:49 PM
> To: Brian Norris <briannorris@chromium.org>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.or=
g>;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Francesco
> Dolcini <francesco.dolcini@toradex.com>; David Lin <yu-hao.lin@nxp.com>
> Subject: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for
> WPA-PSK-SHA256
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Jul 19, 2024 at 12:05:01PM -0700, Brian Norris wrote:
> > [ +CC David, in case he has thoughts ]
> >
> > On Fri, Jul 19, 2024 at 08:04:59AM +0200, Sascha Hauer wrote:
> > > On Thu, Jul 18, 2024 at 03:55:18PM -0700, Brian Norris wrote:
> > > > On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> > > > > This adds support for the WPA-PSK AKM suite with SHA256 as
> > > > > hashing method (WPA-PSK-SHA256). Tested with a wpa_supplicant
> > > > > provided AP using key_mgmt=3DWPA-PSK-SHA256.
> > > > >
> > > > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > ---
> > > > >  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
> > > > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
> > > > >  2 files changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > > b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > > index 3adc447b715f6..1c76754b616ff 100644
> > > > > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > > @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> > > > >  #define KEY_MGMT_NONE               0x04
> > > > >  #define KEY_MGMT_PSK                0x02
> > > > >  #define KEY_MGMT_EAP                0x01
> > > > > +#define KEY_MGMT_PSK_SHA256         0x100
> > > > >  #define CIPHER_TKIP                 0x04
> > > > >  #define CIPHER_AES_CCMP             0x08
> > > > >  #define VALID_CIPHER_BITMAP         0x0c
> > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > index 7f822660fd955..c055fdc7114ba 100644
> > > > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct
> mwifiex_private *priv,
> > > > >                 case WLAN_AKM_SUITE_PSK:
> > > > >                         bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
> > > > >                         break;
> > > > > +               case WLAN_AKM_SUITE_PSK_SHA256:
> > > > > +                       bss_config->key_mgmt =3D
> KEY_MGMT_PSK_SHA256;
> > > > > +                       break;
> > > >
> > > > I feel like this relates to previous questions you've had [1], and
> > > > while I think the answer at the time made sense to me (basically,
> > > > EAP and PSK are mutually exclusive), it makes less sense to me
> > > > here that PSK-SHA256 is mutually exclusive with PSK. And in
> > > > particular, IIUC, this means that the ordering in a
> > > > wpa_supplicant.conf line like
> > > >
> > > >   key_mgmt=3DWPA-PSK WPA-PSK-SHA256
> > > >
> > > > matters -- only the latter will actually be in use.
> > > >
> > > > Is that intended? Is this really a single-value field, and not a
> > > > multiple-option bitfield?
> > >
> > > It seems that when only the KEY_MGMT_PSK_SHA256 is set, then
> > > KEY_MGMT_PSK also works. Likewise, when only KEY_MGMT_SAE is set,
> > > then also KEY_MGMT_PSK_SHA256 and KEY_MGMT_PSK work.
> > > I gave it a test and also was surprised to see that we only have to
> > > set the "most advanced" bit which then includes the "less advanced"
> > > features automatically.
> >
> > Huh, that's interesting. So these KEY_MGMT* flags don't really mean
> > what they say. It might be nice to have some additional commentary in
> > the driver in that case.
> >
> > > I could change setting the key_mgmt bits to |=3D as it feels more
> > > natural and raises less eyebrows, but in my testing it didn't make a
> difference.
>=20
> Thinking about this again we really do need to use '|=3D' and not '=3D'
> to make the result independent of the ordering of the AKM suites array en=
tries.
>=20

Yes, for our private driver. It uses '|=3D" and can work for firmware of IW=
416 and IW61x.
For nxpwifi, it will follow mwifiex first and will be updated to use "|=3D"=
 later.

> >
> > That would make sense to me, but I think that's in conflict with what
> > David Lin said here:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2FPA4PR04MB9638B7F0F4E49F79057C15FBD1CD2%40PA
> 4PR04MB
> >
> 9638.eurprd04.prod.outlook.com%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> m%
> >
> 7C0bdf1446db20472a267008dcaa22c655%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%
> >
> 7C0%7C0%7C638572313533588836%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwM
> >
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sd
> ata=3Dp
> > oKXdL5f%2Bwp7uXaPqvl38IF9OS5XtRfir3xIyEoAV0E%3D&reserved=3D0
> >
> > "Firmware can only support one of WLAN_AKM_SUITE_8021X,
> > WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."
>=20
> I don't really know how this sentence was meant. It clearly works when bo=
th
> WLAN_AKM_SUITE_PSK and WLAN_AKM_SUITE_SAE are advertised. Of course
> in the only one of both is selected by the station.
>=20

Mwifiex supports a lot of legacy devices, I don't know if modifications of =
the coding
for the data of TLV_TYPE_UAP_AKMP will affect existed devices or not. Maybe=
 you
can follow the patch for host mlme to add a flag like ''host_mlme_enabled''=
 to enable
this kind of change for specific device.

David

