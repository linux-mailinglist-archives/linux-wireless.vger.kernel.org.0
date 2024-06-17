Return-Path: <linux-wireless+bounces-9051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D290A797
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2106B287CCD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFFA18FDB7;
	Mon, 17 Jun 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F57eT1xi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DC18FDC5;
	Mon, 17 Jun 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610249; cv=fail; b=pu6NzlKsJd5xaYTMYEEAxlwQdQvIq9H5hRL5R2amlYe3RvK2nAU+040xZvkbwlYHPwS3DehTcXR8oqGfU231QGTLx/mp4C3Qq05RZB5ncBcTu06qLahFhMM6H7rMrvYEZzCfEV5NXLCdFOSnFIRt0rrTkD4Rsi2A8O5uf6B82Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610249; c=relaxed/simple;
	bh=m2XkFKSo3gjhWbMsThFUQzRjn1gils9K/+LdhciwvaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cR68wv9C1FEt17QiJpvod3ujvE/qhZVghkPZDhC4zJpHnFYqS2KqciZHnyfUz7/YX0MApnop/6ThgwihDi73C6HnnNGw+BVup0lpsdNpNE+8W6HZlm66Nek3G5m77K3PT9G2M8I6F0xYWyF3h64V4nOHuujUGymX4RxdUVclE3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F57eT1xi; arc=fail smtp.client-ip=40.107.105.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBmQdr8B8XC/8OVIBnpdUiSFVnQPpj3xhUjg5RLOv/js0I1hNAXju+U756RrQ3Fk+3+1TTwGrX9A/+NAHom0bvfeB6NbrU+QuqeOjoRSHfFGfyTimpPjJJoOWic91yeH7xv7A0dfvA3Ut0lBAnygL3VqusmmreVbvrPSZbxvItSENIo2Xve+x/tGM+BlE8Mpd4ZAq1Nio+BLpqjSwQAz3w+ipx+bRB2wzyZUzw109RbkRgFhZYuXJYeYpmBzyyFmMdhWo9i/IreRnZMMrRwX13Bd7mUQHe9pgbHgdDZ3OUf1KZDMOJdo8Vqn3EGdtMU2MXN/WyA8extKfL2xVhomzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQBHJcm4+b8Z4X9OFFyKO3Nw3GG8gmhGvjlJA3jXsAI=;
 b=Fkq6vA4SpzbpMgAq3Zd3AJ+UQirGkl2fOK+uOkRmGX/E5DNaXGjkoX4xH78V8SzelaAcrSxZS2sqyA5RDsyq5UMokUlyyyIO/R/mx4CI7wy6VNo2y1Txd9JHPce8DR6/RtOViePPvw5YYTysogjAxwJq5/UivOF5yQRVSJ8gNJpDSq5mJ9tV2l67qe6lr0c3Slvir44fPgrR0Bwi7Pg+wLu+yneRjO0A3iVw6PQ3kIoHaKkHIh+sVbAJ24xbKL8guhWL4SgDIGU3vqG8v6n7eLigY9ntIY+e22scqV1ov4dCiexy5cOx9H72+fFnDctZDGi+Bwt6zpL15WP6KKqsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQBHJcm4+b8Z4X9OFFyKO3Nw3GG8gmhGvjlJA3jXsAI=;
 b=F57eT1xihWzRenNfxHyBCc7tLKzPOR6XwU2wOyZOya89bqo4I3nXMFI/7K05gezk25Y6N55oQj1CRabcxrrAMLEUqJoQbdM4qa4eplcLga5Q+9bCUJdgxHCvgqrZkKOd6lW+msRLWntbV4gcBlE6IByQtN8O0MunGbDbDG3S5Xs=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI2PR04MB10834.eurprd04.prod.outlook.com (2603:10a6:800:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Mon, 17 Jun
 2024 07:44:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:44:03 +0000
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
Thread-Index:
 AQHakVah/NlfkBV8NUyUKYHJ747D+LHEcWiAgAJqJoCAAErBgIAEbxxggABHZICAABPk8A==
Date: Mon, 17 Jun 2024 07:44:03 +0000
Message-ID:
 <PA4PR04MB9638B7F0F4E49F79057C15FBD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
 <Zmmeg15YQtiChZ70@pengutronix.de>
 <PA4PR04MB9638C0A141C53CC2F5898DA1D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zmvjw3aG9j8kW0Ld@pengutronix.de>
 <PA4PR04MB9638EE40501500C0B58BACC5D1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zm_X2ULdvDIHFWAl@pengutronix.de>
In-Reply-To: <Zm_X2ULdvDIHFWAl@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI2PR04MB10834:EE_
x-ms-office365-filtering-correlation-id: 50c53dc3-8a97-4333-2a46-08dc8ea1425a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9aVV4RtlylW10Pp5RG3ifyr7hw+AxXP3NjREGtOqvSXh7OA+oVaiP9CY2C6W?=
 =?us-ascii?Q?+9IrAlOmjT3Ln1GgALcDlj8zighz0JMZ811aphXSJ94yEgbMQu05M717el3I?=
 =?us-ascii?Q?0f2Qb6j0GbWsTWWG5AHjjfeGY5X3fuGZSkpK165xuhE3h5B/PhfhkQCVb1cd?=
 =?us-ascii?Q?PuuZfenyd9K8F8YK8A9SPf/NIugNpLbkugwK0cp5rR/cZTfAG/DFMGNSHjVn?=
 =?us-ascii?Q?wHluzqHN4DYpPI/yS24k2+gc+anYsCD4ArmtgPvvI23wk3ofyDG+/8Sv11mK?=
 =?us-ascii?Q?JicbvOLcFGkReQUeYJ/sI6SHVM+uEAF4mftZ6UdBcpm1m3awX53OWrYnO0o3?=
 =?us-ascii?Q?Q7OzP029Z0CTLAasnRjXrFj2iP5yp4JfKYwUo9JniE7Nw3b+V9UjBiQPdGiX?=
 =?us-ascii?Q?x4KcvPyvO4LEJmOBpgynUahDkBpsdAjEMBORWJqZF2ubzMalgozJHSI/jwTn?=
 =?us-ascii?Q?Us0FZiSQGtVgvh5+PhKhu96+8TIuO/fkoKi/UXlMP/FsdMznXhhANYKDA4y9?=
 =?us-ascii?Q?3ATrJ8JsBjVfRpG90hBR9akNonlrTXFmuYBcySXEU0NQsSG1ztKtnLq8OEPk?=
 =?us-ascii?Q?6XbVETBHwhFGT1NSBBf3w5meDZGjD+WJtEJe8uzSDcW8OtxA5Yk+zlJyQuj1?=
 =?us-ascii?Q?gNAw9eUy7Qz8XajARLF2uuBWYsibKdoOgm4HwYLTDU49wrfjUycXXYlI83/w?=
 =?us-ascii?Q?iJD7avp22S4hnwZsk94eHdwuvXu2NkNrhxU2Z97/JfP1Yia5sDv0ESI7bHny?=
 =?us-ascii?Q?IkqxK7ZeS62xlfAyNWjQ67UVE5tqAWXQTGXB5xB/xcKG5yZQ2AMiOfmkwYep?=
 =?us-ascii?Q?23WG0rRZZw/ZyQBq1fO3cdB2tNckjxmZeZxEEXTysTpnod38CHTkIgKctD5B?=
 =?us-ascii?Q?WdlPoo6/tVu5db75eR60X6IFFgEpecntHKzpUNP0+UXsn3pcsS8jl7zPw9ds?=
 =?us-ascii?Q?i+BwDwRAg9qfj69sOuX1MjMQaKtwUC4zXjvMqApLPskdptKZplPMpo1C9ZE7?=
 =?us-ascii?Q?GZf/Syc6Ai/WFc6r7j8iycOu7+kWKUsEXf91RszE95kawmlmJK5B+OnUjlG+?=
 =?us-ascii?Q?zKt/Kh7dwcsF+4aqE+g6LdAPZEdimouIdZmmVGpcalAvpxJPiCmltSf8mMc0?=
 =?us-ascii?Q?BpChjRLB090nt5G+h6+oof8xdP8KV1h+MTko80yJoUfELWBJsNFG6lwtLZMH?=
 =?us-ascii?Q?wjDrHHXIfvOiS64+JPYZvJ8dZhSDaiMU2KTRnJQqXuAFm/PRf1KC04ddQQWm?=
 =?us-ascii?Q?YsVNeSfspsmOncSpkCRbQNw/NazqxlVAyZ8wj3GaRKiy+tK9fXF515TO5F6j?=
 =?us-ascii?Q?/nzbNejU2vvYRtA/jutuPmxw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3QgtKA3W9I0IbFX2Iy9wR7wxQMET+D26tfLetT522qJQyKfSK5jeXUjtQdaV?=
 =?us-ascii?Q?d/9SQJEcjR6IInhee2pewlOlVXW8Vg+L9AsfPjyRHZT8E3SFvK2RmH8bZPHG?=
 =?us-ascii?Q?K7GMjl+1YtKnVz/11JAAwn3Irf5fSih8Dsm9RFEw9U4kluiqWuJ/0nImHUDv?=
 =?us-ascii?Q?vslIDLb26jA6ucvNtkR88NrPPR3Pdpen5g5U/R3iywZqZKOE1gFMyMQvzB0M?=
 =?us-ascii?Q?B0rJ7lx9KUJ/NxLzW6A8VsoyFy1iA/l/2EtHjzyGreXr5QsN6fiGPJ3RHFH6?=
 =?us-ascii?Q?iHFQz8OJdcVxKO33sZ6X9WAYwMYoEYc8b/iInuxZYdeFlOVKRYPge8dot2DH?=
 =?us-ascii?Q?QpW3ankz5eUOg3fcY2KMCM+OpzaIJxgIXNyEhbT4vPE0Qf/CPCi0ZxNwk5bF?=
 =?us-ascii?Q?yMR07rBsUvaPVUDqx72Socr81eTPD09zigUsyZMUNk+1zEVAu3/9P5s7iJXj?=
 =?us-ascii?Q?BPh7oOsJyyyugc+Ho9qMiLzLS+AdxePKE1VeCqrB6nBD6Cs6Pc8gl0U0JhQL?=
 =?us-ascii?Q?BE2G+L+0wCIifEz5hwpMqx/xG12qvDFISXjcv1pWw9I7O1VTMeLQebbuhzMI?=
 =?us-ascii?Q?P5xcqYhXRRF2JsozXzKoIQ9QpBFUyhcni+b6GrPX8Ys1Xt64VPPQbxK31Z45?=
 =?us-ascii?Q?Z1uxNjyjtm8KpDxx1QdPqgg8fO1RQZV9tMXssCkY1IInikldhS6KVSw2lsq7?=
 =?us-ascii?Q?MVoEquzhZY+Nrh7BxUhMPSOxRntyx1tqBrbb35EBJuDRWrEfTFccVKcSr0dy?=
 =?us-ascii?Q?eEXAZ1WET/1haNlCss340JRfldE92p4rnYsGyxpOTq86XCYKBfp/iTDuS7Er?=
 =?us-ascii?Q?9JXS96i415WW6MV++kgWSFhCsEqQNAkVbQpS7ngslAYKuv2Clp5XZcPvtVvL?=
 =?us-ascii?Q?c3g7+2ZjXTeWQL1KxDt5dR0Oa8FU2DYSowL1oBOfIicg9X561c1PG5Y7BzVs?=
 =?us-ascii?Q?ENFqO9couU4VuWW5ek5o0ObCid67BppKpDk73cZA4kMn364fGRbVzbrVTrZ/?=
 =?us-ascii?Q?Ss0b9iTczw7o2s/wBxu2WvSpo6REF5ahL8cVc4xdxF32lzyEc60agApTxLL/?=
 =?us-ascii?Q?sDlBB0CHwF5hOG3fDNG9U2+guo0EWKAuPXeoYMV176uVsWK3cWUz6Kb7a5Ex?=
 =?us-ascii?Q?pSUKsrW6Pn7hLY4SskkW7NNHROhlexg+9CJFeViaarpS3Zx5Y5SBoMCCn5ZH?=
 =?us-ascii?Q?Q9QPIqF1KJUVOmewgJBjJYDcx7SV4Q7/vw40h+IMLNwg5x4gCoV2JBl6IXdE?=
 =?us-ascii?Q?8afH04VieUqwhgnE+pG8AEm9gF/1XPkvYIty4+k+d8KOXYt3eDq4TAvPvQgw?=
 =?us-ascii?Q?sxLJ9Xwh0i2jRStJ7cQsTTNmpc/9BT8LLdGkhTr9MmX4NseByDOiZ+cfRAgM?=
 =?us-ascii?Q?MTogv13haD82+g5VDXr9nqf/Rh6bvJ0HfYrjmxy91ya3+sAa39WUcFLbllaz?=
 =?us-ascii?Q?+ENOzJW3sQxDWLeRUkaFYmA2u/RyQtIBWO6QLhpNv1qScCmjR97STTFicUrw?=
 =?us-ascii?Q?WG+A2nlOK/iPrEa3FUd6Huydcq0JqUxup8zNm4qA2yMqdoll84IkMPGKTs32?=
 =?us-ascii?Q?C4fQ5aqd1mXrFdrNJLcJKv7fjh2V7mBGySeBtVWJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c53dc3-8a97-4333-2a46-08dc8ea1425a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:44:03.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LG9U/Q3sAaSPz7Zi2WnZTBxuoR0XTwM3AUhYlMHngrGG4MEUDID+sfcqd8Y2VNoFjn6RMhT29V5BZPeWh2bGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10834

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, June 17, 2024 2:30 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: Re: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for A=
P
> mode
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Mon, Jun 17, 2024 at 02:15:41AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Friday, June 14, 2024 2:32 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> > > <francesco.dolcini@toradex.com>
> > > Subject: Re: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme
> > > for AP mode
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Fri, Jun 14, 2024 at 02:06:45AM +0000, David Lin wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Sent: Wednesday, June 12, 2024 9:12 PM
> > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> > > > > <francesco.dolcini@toradex.com>
> > > > > Subject: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme
> > > > > for AP mode
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > Hi David,
> > > > >
> > > > > On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> > > > > > Add host based MLME to enable WPA3 functionalities in AP mode.
> > > > > > This feature required a firmware with the corresponding V2 Key
> > > > > > API support. The feature (WPA3) is currently enabled and
> > > > > > verified only on IW416. Also, verified no regression with
> > > > > > change when host MLME is disabled.
> > > > > >
> > > > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > > > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > > ---
> > > > > >
> > > > >
> > > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > > index 491e36611909..073c665183b3 100644
> > > > > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > > > @@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct
> > > > > mwifiex_private *priv,
> > > > > >                               bss_config->key_mgmt =3D
> > > > > KEY_MGMT_PSK;
> > > > > >                       }
> > > > > >                       break;
> > > > > > +             case WLAN_AKM_SUITE_SAE:
> > > > > > +                     bss_config->protocol =3D PROTOCOL_WPA2;
> > > > > > +                     bss_config->key_mgmt =3D
> KEY_MGMT_SAE;
> > > > > > +                     break;
> > > > >
> > > > > Shouldn't this be |=3D PROTOCOL_WPA2 and |=3D KEY_MGMT_SAE?
> > > > > Clearing the other flags when SAE is enabled looks wrong to me.
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > These fields are used for the configuration of FW, this is the corr=
ect
> setting.
> > >
> > > This is done in a loop iterating over the different AKM suites, with
> > > your patch this looks like this:
> > >
> > >         for (i =3D 0; i < params->crypto.n_akm_suites; i++) {
> > >                 switch (params->crypto.akm_suites[i]) {
> > >                 case WLAN_AKM_SUITE_8021X:
> > >                         if (params->crypto.wpa_versions &
> > >                             NL80211_WPA_VERSION_1) {
> > >                                 bss_config->protocol =3D
> PROTOCOL_WPA;
> > >                                 bss_config->key_mgmt =3D
> KEY_MGMT_EAP;
> > >                         }
> > >                         if (params->crypto.wpa_versions &
> > >                             NL80211_WPA_VERSION_2) {
> > >                                 bss_config->protocol |=3D
> > > PROTOCOL_WPA2;
> > >                                 bss_config->key_mgmt =3D
> KEY_MGMT_EAP;
> > >                         }
> > >                         break;
> > >                 case WLAN_AKM_SUITE_PSK:
> > >                         if (params->crypto.wpa_versions &
> > >                             NL80211_WPA_VERSION_1) {
> > >                                 bss_config->protocol =3D
> PROTOCOL_WPA;
> > >                                 bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
> > >                         }
> > >                         if (params->crypto.wpa_versions &
> > >                             NL80211_WPA_VERSION_2) {
> > >                                 bss_config->protocol |=3D
> > > PROTOCOL_WPA2;
> > >                                 bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
> > >                         }
> > >                         break;
> > >                 case WLAN_AKM_SUITE_SAE:
> > >                         bss_config->protocol =3D PROTOCOL_WPA2;
> > >                         bss_config->key_mgmt =3D KEY_MGMT_SAE;
> > >                         break;
> > >
> > >                 default:
> > >                         break;
> > >                 }
> > >         }
> > >
> > > It looks wrong to overwrite bss_config->protocol and
> > > bss_config->key_mgmt in each iteration of this loop. If that would
> > > be correct, you wouldn't need a loop at all, but could instead config=
ure
> based on the last AKM suite entry.
> > >
> > > In my understanding the bits in bss_config->key_mgmt should be ored
> > > together depending on the possible AKM suites which is also what the
> > > downstream driver does.
> > >
> >
> > For the configuration of FW, ored only happens for the same AKM suite.
>
> Sorry, I don't understand this. Could you elaborate what you mean here?
>
> Sascha
>
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> http://www.pen/
> gutronix.de%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cc852ce81dd734
> 2c25e0408dc8e96ebb2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638542026048434949%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&
> sdata=3D6Y%2FM9gFWYhf0UfClFTBwwsuMwrasEimaHKzJ2y2bHjQ%3D&reserved
> =3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |

Firmware can only support one of WLAN_AKM_SUITE_8021X, WLAN_AKM_SUITE_PSK, =
or WLAN_AKM_SUITE_SAE.
For WLAN_AKM_SUITE_8021X and WLAN_AKM_SUITE_PSK, the protocol can be WPA, W=
PA2 or both.

David

