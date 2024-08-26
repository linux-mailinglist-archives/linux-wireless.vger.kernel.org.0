Return-Path: <linux-wireless+bounces-11951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E795EB7E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1512D1F20FC5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9F12D1EA;
	Mon, 26 Aug 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fx2lPC1b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1E4A28;
	Mon, 26 Aug 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659968; cv=fail; b=bCqj//lyWpGrNMg1pzjsrkTaQjzMQqsdZJTu370hlabA9BwjP9P3RvzR+vc3tCJ47ElxqPnASfLo4NCJoSxWbRlqKpfrZVzc8FLyYvNo7BA+8t4ZhQ7V6zHbQgX4qfoXf17jrgDpqo6ZbahJoa3yg2GsjEV5G6hThhewxkK7A54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659968; c=relaxed/simple;
	bh=cfU3BsDgGYtsXpC/NxsYKfp4eyk4XsSmBLJRAwVxfcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XS13EpNF/pdWbALaacDQOTlMxQHfndYPPQwKfFaH1F+nyDaKYb9/PDZnmEc+4g8Y+wP5XxEAKMEqljZ8ItsDcLPOX2fB+UwXWGNij/M3zm9wM118hryaqCQvn+U5M9QJ9OAWRLvCTduwyLMTEyi7KXup0vsrvjp1sUHkZsEz1QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fx2lPC1b; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NloO7Xn++zQzG1HW1l75SKkUS0jtddYeZWNBz4bXLYUgn64zmP+x3IRF1/V16ywETbMtB3qlnNaih15BsIWLrrqi5u/lbWBvzq3hfO0Vr0pGhqivqwx7VtJ7EysQ6IkVEVSYiHQVRK7F8DvAnEyswbrz0QbV8+FIJWtZTNv2EnBvFoXlNaXHZyV93e9YMRA0YdSB3vKE21RMmmnTX5ocsrSbK2LyWgVled5z1Nq3M7O6js4AVJFcRDcVYBr6M0LXucMTgPmRoYLKNMbNmbF7N+7myND0KQ09ay0vTaNIHs3r7dbP4vkVVz0/kqraN1+hGPL6pbDeD+mG0On6z/xGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfU3BsDgGYtsXpC/NxsYKfp4eyk4XsSmBLJRAwVxfcM=;
 b=MRDElWqSAT3NeqqB0YVlxOLDizNGlGACM/hWn5GxcEz+l1YwBxMPmh93RfHS85xM8lC4y5tYo7InVMTE7n1atCl4pSU2uJ7zI34ZWTzH/tOFGEpHfyD24s4bGR8qTzgCa62UdBT4WmMS8AQvR1jSarwWKk869VlssqIdsK1/3ZbxbhBsp0MAzVD6pfHUwi5qjBYC1TMwScTCQS1oP/s0JeyUi/bawsbMn+Chv9yyk/Z6XL381ms4Qn2rP08/53o00hog4XbXB0MGLA3BrvVz6y9fOBVeZ3rbzt+NQBhptnX2zKOM8+5fXgzTcrRc62/IT4LhTuhjfn90HkCn0CqXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfU3BsDgGYtsXpC/NxsYKfp4eyk4XsSmBLJRAwVxfcM=;
 b=fx2lPC1bfid0nJ2ki8sArMb44+fR+YRLHgjck2+7Al9livpCpprVroe0lljP3lMH3XKK24fxWRDGPRHAzZ7fOjuvLlo03mYHmyfOXfe3R7a9tmDj4tUjZ0QdFc4cQJC8Kib0IjilMonQTPNjnNC+qqFcJ0SPNZH5HutA7ZaPbK97VcvcT1ESo+XeNFOmBVrw9abJ9vwfTOy9nR19rgA/ieNW9XV241uXs3F1SNocXLsAQVaEKsb4FbMxz7hDokE+lrl6fz2NW1KBJ2p4AHOa66UsN2HXOe4emBibbyR9IU06I2TZZHgtww1ToEhK3I3pInhQJpBx5hG8CIC9X6OGMg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:12:43 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 08:12:43 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Sascha Hauer <s.hauer@pengutronix.de>, Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Topic: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrI5K4CAgAAD8oCAAAAlMA==
Date: Mon, 26 Aug 2024 08:12:43 +0000
Message-ID:
 <PA4PR04MB9638751DE1EE81BFDD601FC2D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB96381DEE1E9DC0A8F05C7695D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zsw4M0oYZI_JdeAu@gaggiata.pivistrello.it>
In-Reply-To: <Zsw4M0oYZI_JdeAu@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB7108:EE_
x-ms-office365-filtering-correlation-id: e1c6fc3a-fc43-4f33-6f66-08dcc5a6dc76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GMEIpsMo6pRtahMOW/StOnh7aEh4vCfAHbprJGCV5e3yIdhfomNwvfRse7ye?=
 =?us-ascii?Q?YGCceqmegW4sr2b8n+rbKUVUkimbM5+auOFf2ecZwXQZHzM2zcKpKoE53pTT?=
 =?us-ascii?Q?uFxiQKvqlR0dy8ZqByTN1yLfdC1J9qM6Juke7F1b5x9nWU6zJCAPI/fiC+lq?=
 =?us-ascii?Q?WFLvgg9pxKkw1jqIdCySzY5XftB/NPV1stip58rTiDTEa30UMDgq8aVe+qXb?=
 =?us-ascii?Q?S2YHQf2pyOTexyd1nxik13UHVnRaOw12yB+xgGR39RMIcbxu43Fzp60Z778n?=
 =?us-ascii?Q?QiiLBUgSwkExpRnS8k25HXNc6VzMZr2yp4Kifrt8bCBKUPyR7rmAku1fMggm?=
 =?us-ascii?Q?HGJEniUPzxWXty0B90k/ZnLjQhxtUtVQPaeoc87RoZDJABgfCEVr9p+8FcGA?=
 =?us-ascii?Q?wId85WaAHKDCe3z7hJAkQgWy+gqXrYRFlp4zoZnQO9qIAVFDcO4GSzD2Xa5Q?=
 =?us-ascii?Q?DURxxoPhIzX4Qvumcoa6d2lInkg2atXdYeG+rHyjn8wR6O+CUzSxfpVg6GvO?=
 =?us-ascii?Q?/d3/U2KL2Zkyp9ciQVg5gR/WjSPNuenXualJk7mF+VmpsBpBefAbFzGa2FqD?=
 =?us-ascii?Q?CvpHp8DAnB7DhJ2tvQ3AKwWIzK9Uf3/Rti3GsxTo5ArrZIOqju0IIe24t2tu?=
 =?us-ascii?Q?1tVPps7KTypwuhLvMkTgk9HmDExPeCcU1/XeqWRgfSJo29a7BtDpEYxnFm1T?=
 =?us-ascii?Q?dVcWaQs26i2N9MRw2yg22kA5LUdKS91frlBXvT5ih9y/tyLiDIOfyUW5fnkp?=
 =?us-ascii?Q?20TAqoGLpsaMm2+KbuXwhitQ8QjxwGcu8szD3LRRPCzVmiEJJRjgYLHwuxB4?=
 =?us-ascii?Q?k2EJbXtDhlabnNCQ0NS9dEm1uL78giY3LPOuT05cP25MNDzDEaghaSIg8mMr?=
 =?us-ascii?Q?qDLL26KLAX+Z2w2dsPOxkP+o7HjoVdcWHucPz/KTJi1FieNnNUOLxVc0tKeu?=
 =?us-ascii?Q?xpm7JiGiO6MqGi/AXkzIYaYiqLbTONa9sl1Ei/S0jMzESWUkFWcvZLQyDSam?=
 =?us-ascii?Q?AkiYgWRV1dbSyV0mSW1pIy9Dcp6T7OhO+lnKEASgJRuQ04DY0PhJA/BJ7ig7?=
 =?us-ascii?Q?He60SgB3ZwxdHONBsS8nSQm8QzaQn24d6QuSWkrxtiur237ZxP9aI8DYL8YH?=
 =?us-ascii?Q?jneBc6vJJi80I3k1HxipkqokIVa8EHCv10OBtE1f3igVJGmrvlCvlMxGN3NO?=
 =?us-ascii?Q?PeHKrzwd2T4umJLSHKR6PxJlv9o5iAOR2yDlB9d8iOQhqQtWTmfhP8C4Lmtx?=
 =?us-ascii?Q?q+XUzOxhszVehZ5TfLpS22KlZr8cpynstH5yaPayxhc2o2wtvdn8JXY4dQP5?=
 =?us-ascii?Q?St5D2gsHOzxoUYesJ9vGU05PEGwyZOHN1r43e3hR0SeFIHBzeTZ1oTgpvT/f?=
 =?us-ascii?Q?AGHkJVf6sSLcZTfjY1Ksw/O42JPnKU1xkjtMmzSNpc5v0iVWjA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0DbtTxnSaFApyWQMukhgANDC/9xcK20whF4LsW3nKASW0dan5+O91cRssTCv?=
 =?us-ascii?Q?5Fqnmz+nlSH0M7b8lIiuYEkCAdKNIWToR/uvwhVFzaDGIMygi0W81PnCnUc8?=
 =?us-ascii?Q?rKL0LkwJQO3AZEN7hnHJKCGnDO5MJD3DnAJNR1R7p/nmahtVLl9benOpG5dt?=
 =?us-ascii?Q?gnGeOyohnCKjXCgVvjx8nfrb5BBaBMM8OcGmUVKh84sM9rfBFt6jYVW1PcYZ?=
 =?us-ascii?Q?+YWXPef2w728gAb5rDjD4u6U7ojExDw6K2IOXaXs2nnrCHPsVvVKiRzp6gg9?=
 =?us-ascii?Q?66WwX7JDqOCuevQMt5TyhjvkqY17OmRVIAR6Ky77nGYDNOs848L3ugFhUvSW?=
 =?us-ascii?Q?+uiXA/DYtP8JSrQQ1oIuTrXn382XOo9Wf9/pzc2MAZjvELPjm+oA9wEGZ69y?=
 =?us-ascii?Q?V8M1E+avcvqyB8bL4InmOMubeNrnH1Y/7a3C3grWSYbSo7sm+H/RCg2Mj4as?=
 =?us-ascii?Q?d5ywYqatF0TH/PcAbLXfxHikAff1gD9BUOgVmJXwBPz6qcvWQGx89tWy7gPO?=
 =?us-ascii?Q?h5fxc6xpIgT8mMofI6uypez665yBrSmbngGalbJYiHSnkZ+wgGaReY2/UdtQ?=
 =?us-ascii?Q?kllzFBEOh3AKxvjBBfJauA8M5sM+PGoMGA5i82IxvB8v7iwXgq/WSUvaYJMC?=
 =?us-ascii?Q?VkyfiP9gzsbCaEwUjYgSrA7bl+JY5929eQO1e/1ZV28ItgTETfFnlkLRvUl3?=
 =?us-ascii?Q?NE9GDta7Dpd8syAgoEkwheKIVq2Dz0NNHHT6qV4khxGRxiuzIbl/IPmL6h1D?=
 =?us-ascii?Q?OfF/ydaubC3t27BQIwf4fe743VolIvlzxGie6eDq+H3k7YoEEqTS4M9yr2ER?=
 =?us-ascii?Q?HE9JX0RQyLkqNYZ9IJODPSagUDP/qcOfBsFPYWaaD07Rj4tzwcL5d6YRrMxW?=
 =?us-ascii?Q?xdq+sBTYQOHeLFIQzUmwkS9CUgG/vli8SvP6Cq7e/uqCT7TgUcKDwInEdLln?=
 =?us-ascii?Q?aMa2UwVXfXSrRGnDO8/BI+f2J96A4JKquNVII1WoOatpna2KT9UuUyYpqBFP?=
 =?us-ascii?Q?uHIUhAhBBUqcflasvIyy25kfPYQFFiGNlvJKH2xj4DfIy4I4NZAiqXD9yv2P?=
 =?us-ascii?Q?ufN4lsR8jz8PgzX1axFflz5Z2E+OFt490Bha1znVO+93XraE09go3IuN0gk+?=
 =?us-ascii?Q?k44qSenan8ho3KWKEzV9gDcpnjCcbB8ySXcc8vE4eWZCMBem08O/F7EuDRQp?=
 =?us-ascii?Q?7p68tXu6OQti2aUPdPhLre2dHoR23nhb7KDRuVQhvYv6z27uuDOzAyUDTsJL?=
 =?us-ascii?Q?HqZ014uxDkE9ujcasG+n9wRc79uoAmYsaNZRdiDFBGafPEW1TvnneeV+Iu3B?=
 =?us-ascii?Q?RN+NRQa/32Ogh7ZNqW7pq8e+MNw+tTfJud5QUPE0fH2+5Iu15fjHyL0kpQi4?=
 =?us-ascii?Q?FGqFGjYruTHkHEvSYapeYk+P7By4vKleax7wCO/oTSZqbpw9Le1VJj3oKpBI?=
 =?us-ascii?Q?Omh2E+5RrNl+BvT4fszTFcXptTsCzL6z2tA4CfpT6CuBIIAQwqFINOVqZYSQ?=
 =?us-ascii?Q?v+XBesTCIcaBez9WORK1Gr05Dgn6EoY6UVxzCpX6SmLdSrprWuFPmeLlLUm4?=
 =?us-ascii?Q?o3Hl6oS36eFw+/azjzD2Wyp1QedE3CyPvOI3MIGe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c6fc3a-fc43-4f33-6f66-08dcc5a6dc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 08:12:43.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzoB8nZNrNyi6Z/6MFYqCxF1Tw2264iBjWEmzh13c294sa3xgCVrXTGiFN19fVSv27D+n+iM44eHcaqdxfN/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, August 26, 2024 4:09 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>; Francesco Dolcini
> <francesco@dolcini.it>; Calvin Owens <calvin@wbinvd.org>; Brian Norris
> <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Aug 26, 2024 at 07:57:39AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, August 26, 2024 3:27 PM
> > > To: Francesco Dolcini <francesco@dolcini.it>
> > > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David Lin
> > > <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha Hauer
> > > <s.hauer@pengutronix.de>
> > > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > >
> > > This series adds support for the iw61x chips to the mwifiex driver.
> > > There are a few things to address, hence the RFC status. See the
> > > commit messages for details. The series is based on wireless-next/mai=
n.
> ...
> > Did you test STA or AP mode on DFS channel?
>=20
> From what I know even IW416 is not working correctly on DFS channels.
>=20
> Francesco

Yes. AP DFS mode has issue when radar detection happened. Patch to fix this=
 issue will
be submitted later.

However, if AP DFS mode without radar detection, it can work. But if VDLL p=
orting is not correct,
command timeout will happen when AP DFS mode is running.

Another way is try to use client mode to connect to external AP running on =
DFS channel.

David


