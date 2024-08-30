Return-Path: <linux-wireless+bounces-12251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D212965A3B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC336B21EFF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFE16D327;
	Fri, 30 Aug 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXQGLbdy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21316C6BD;
	Fri, 30 Aug 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006344; cv=fail; b=u+ivGwC+Igj4u10mzi5WaRDqgxbrKUTgE8VJj9UmZ2OQgrS+GK0GTOPMfdRGhbKpOpSf2uACf94lopftrEW0QXMlfNAHEQ+SMrH2AiCwbabX5kl1jx4azoicJ5SLOcj2yZUEncIowgYZRyzSKdnc49zPTT8mTnuzB3jJ3mHl6Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006344; c=relaxed/simple;
	bh=mvoWwDb1AqXRxjpZQ6LdLdyUOBBz/Fd1aYF8cJtslmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3Dmy0tjr9CTA1TtiZMhaFINK3iFg2hFla/n1D5LjuLy+kXd05s7wVOnd+/RxNSmOPuxkeGovOak/t6i601B4tG1qnJnQI2Hgco/HwQpK1njb1nRRDjmZzyvjd/aRQsvPw5f3r0tXTMAoCnWMqGO5q52Nuyix6lf1JPyvNit6YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXQGLbdy; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+uZftTfiH0yiorYej+BtO2E8MA6pmrxK4N/26bM5Fs2ZJ42tGlPs5X92uVoAABBHHgYboZLkQO7iH0HmnN+n9nNXsruyl3B8Ydg7ExwRUqqsyvvSTifUdzltnD4LKylgow1I23PSYMyolrQnipPziAB4qKnQBx5b0mE8/rW75xVpuTHo9Z/1HWr1ujzxClzAzORmDfAfSkSQdQ2wBdt8EhKxXDcuCtCfk3ePw/ZjoUYseMGi6yRw6a2PKo36peXg21xJ5Dtkia8m3IIOL1osJV9zePDmGYxt11xE1RV6UowquBybzOLgUNJxN6Vti1PliPJjD+82nrzyPY75drlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvoWwDb1AqXRxjpZQ6LdLdyUOBBz/Fd1aYF8cJtslmk=;
 b=qmRP/HQTEDEMj48mmuSkFIFqWSCERoygUs9DchiRbQwe0alOvrmeNtS395mitKYGzzD3xbfdA1yD3mJ2ZYIWta4C6mEXidMvykwaGpPWOw86rBQa6RQfWTzwcuVwNjmf+Zh3BSVgfo+5gW0XCIDNRbDYNrSdyqPvjy0NNYOmBhgbWL3HqCR5+2z4yv2xxP4IkjO/ekUwlKjtZeW5IUI6En9CpsjSeyUEQqhh0/dk7IdhS7r+kw6i3MX3l/kuSxnJMpem4NoEGByfdgGbIkHjihnulPBA9m9HRPUj9cqDVHN0jO0EYnvlPF/LNxD+HDMvzV9SZciNsAnB4OQHV5o3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvoWwDb1AqXRxjpZQ6LdLdyUOBBz/Fd1aYF8cJtslmk=;
 b=YXQGLbdyoa+pB2HnoqCtjiqtgv0IHD0uHc8spTwCsopFuwXVokRtFe2ivQYIc6g5VCmbzEqafB6rndjnHroDDxh28E/r5lH5T3bckGUuPcDHIwVsjW0YIo4sEecWkLju94li5xEgTP1zMBv1S0B8GsgsgTw094jMr5TnVC425PndbqkDpURTkp1pepq0Qi8Dk373fsFz5gv/e82o7K6jmbHAEaS4jdmbTlGHD1Xe5V6QlAMDa6qFXpd6QdPDMj4SdZy0W27E3YTUEoB+ItkpVkz0+9ZmDSPkpcHlQhN+6uWJSZCmDypkzml1B6C7CYRkKVEMYLJ+W1N1WLV/NFDUqA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:25:40 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:25:39 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Index: AQHa+rOve95XNg2YF0iAcaLwH755k7I/cviAgAACnDA=
Date: Fri, 30 Aug 2024 08:25:39 +0000
Message-ID:
 <PA4PR04MB96385C38F3BB46684ABB6FE2D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
 <ZtF-pbt6-wXWe3zb@gaggiata.pivistrello.it>
In-Reply-To: <ZtF-pbt6-wXWe3zb@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7037:EE_
x-ms-office365-filtering-correlation-id: 10fc0b7a-8250-4d74-8d7a-08dcc8cd54ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2LFcgAeHIo0da28RI7/24F2UcsOrC5orAYLTx5NsVIiXXioo5coEYRnifSY/?=
 =?us-ascii?Q?JyTJcjjP71up2YKhcCjKTVq/HMfsRgj7ysAKPotZ6Zs462O+5aYR+xPSuEFO?=
 =?us-ascii?Q?lSWLKdbg95MtqpeIukO/NWNSC5bmDTWW6ov1NtuGh2Nd+2OclSeiJalmrkCb?=
 =?us-ascii?Q?hHX4s7ZQqUnKBHmT63xtyG7zxQ681i7sfju0CjNmwqzhTGesN5xJNmaT+jHm?=
 =?us-ascii?Q?EU3ryCZUnczqo0QSOc3HQvsMgnX78iQep2ilzma8YlsznkHykdy7QmvT9aCq?=
 =?us-ascii?Q?gj6oY6d/BnxxmuoEvCrjRvd2FxRHECzxizsfhQEXv2zK73AQo1BsvrKIwhnL?=
 =?us-ascii?Q?ARgD+S6S90LdiF/H/LHlGCpi6Vtz+XNgC9yIJhP+i1TDno9KMDWF8KyYKh6e?=
 =?us-ascii?Q?6it3vAEzRVlXZ5mcO792qyCd1r4U6wdGQwmKaU4cnOVNIIAjWPJ14FwAH1cl?=
 =?us-ascii?Q?092ehxUSZpvOezrFRPFnOVkQEGc8tE2juT4EBDd9bYGJECgAHYVJeCYNHGYG?=
 =?us-ascii?Q?4wlBNm3FexBtTqT+xloBODrLZo1dLkMWnp40K9+vGYdClraoJ+ovr048zv1C?=
 =?us-ascii?Q?69lK2TlMPtyTUuB+GPEBbJiuOikJCEhVa3DamNbIC7t+Fea9qlxo+O/qSzYg?=
 =?us-ascii?Q?5NaBc2Hwdy2Td1LzPo8itaup+u/LftBNqcRGk/ifM9bpbnWEYYGLBQlc0Pzd?=
 =?us-ascii?Q?59oM+2k6fvsrtK4NwovDrEPfEz2SpJisrGT5HOqSVb4V8i+UxfUwQjUa09Kq?=
 =?us-ascii?Q?iSgD9/WdW26x9yVFBBTCwWTsoyhnNEc2M62JP7CFQ3il2GK85ZDtXXSD7mrR?=
 =?us-ascii?Q?WR/Fdc7FFnaIsz3JcJeGGUl0CeCbu5YelswF3JQ9rGMzwHfGyH2fbLDP1OQ1?=
 =?us-ascii?Q?J7AvUI2zhLGhMNdLK7T84hcoHtJdCt/if5fG8+aakCZLCfQ1FI0j1aRRH+py?=
 =?us-ascii?Q?bMcCBRBfkOzBKNyWHNvCSVq2Wzh2O3ElXF42iAOKJ89i1vazMCEoP5WI21Qg?=
 =?us-ascii?Q?dWm/0uZ2wIyWvCo1dssMeCAWm5grrYCUbbi49BvKiknuJfemUX0y8am0C45g?=
 =?us-ascii?Q?52pWRKVE3P+o1J8GgUljzTsOcjZBexAiXCyoWBwOFY65BYnDTCI52ka/FktF?=
 =?us-ascii?Q?qC5M9p1Dizu1yn5zQ1a+cr2tsJquJfWhXBZktPf1Y8zsaG6dPLzYYZmon0Mq?=
 =?us-ascii?Q?6iVOhuETXA2twl1hsx8ogOSW9nyWQ7AXwK/x0HX9LbhReBCKqHDHKl14RHWP?=
 =?us-ascii?Q?aEh2YNo5OcvK756uSzbfKdvTFKYdi4Q/nEvjwoc+YyAecSkZoNCU9BX/Mcs5?=
 =?us-ascii?Q?8aOB3+CUrGZlKbOJ2fFwMzybRNHfBSXTEPcSuclooL2p+UOC3tkxXj4VNHTm?=
 =?us-ascii?Q?QdtgnJBTHNBksBkOxZEEV1Sh4PRWv4yQhqVD+kow3hk7SZqx7Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jbCGYlqNFstrIQMeo8fYrwnG2vZIyJoI2VC6eRi46aTWGU10GPEAfrMZwDs7?=
 =?us-ascii?Q?CtIdA4JIHkWEEDg3RqY1U0/GV/ts8zOfUmaMPvZbIOh1t22ybg3cdaHJcuw3?=
 =?us-ascii?Q?DuB1+qLWsUzIhBDWfGy54ggA8eiIjtrsv2KRi0Svo7hgl6yN4lnGJnXe/b7j?=
 =?us-ascii?Q?GieuWWx/VXixxmWpqDmUmhWZaaCqjhRz3NMoDle8noGK7qg0CVhf67F4hmjD?=
 =?us-ascii?Q?CYoXkhFjX884sHaglnIvQrGShPECPvDl0MFcrLHmrpuBPqtWxjZrmLmCoTYS?=
 =?us-ascii?Q?t1iCFLNb8H2xyQEmDGkyze0h4O2WfXMYCZ26dWl1Paddw3s37fdHL9emS5fr?=
 =?us-ascii?Q?W9qtW0yjBWezSu1UidCHKGKZ65mlbyB+vPgvLL0XpviUDg26KvRiILnNwKRM?=
 =?us-ascii?Q?pvdetUPptykct16hob4kZLelIIafdL8HykD5r5PnSts6gduCVBtwloiCh7YT?=
 =?us-ascii?Q?82c0FHnaAscJJbfVih5D/XmdGDhD1y9EpcZnqQ5v99XGWqdix5PoOArkoJlM?=
 =?us-ascii?Q?0g55JtT91cxq3UWMwvDiYFSEZSVIekg9/MwS2XRMi2kX4VvyvCgW3mNOEGbv?=
 =?us-ascii?Q?mBzUW3nOqh0TWXxb9K0FdrNzuR23j9nyWOrxplu838XKjRQcKVxkmFsJAu/u?=
 =?us-ascii?Q?LarLcy3MmB6KFARh7c/n+6p7kVUvcEhy/cZAYDHtcXSguJ50IPcZAYaYWcWO?=
 =?us-ascii?Q?0FfdG/FumLHCcBRVJrRzphiSCRFaGX6JJQiH4DLcjCDPKwkRNJ4MmLqoE2oI?=
 =?us-ascii?Q?5pyDIsC/szWVLe3jdIOnm4P8V7l2irr3Z6BcFE2uxYCeswSBVcBirmqdlm+e?=
 =?us-ascii?Q?GgIlOFTy8N0DxOCqnJhxQHzHb/1L4kDcxdeRQDsmrPkACVXzRu2RXSDY+LqJ?=
 =?us-ascii?Q?ivPHhJHkh6wVXU78uS4rYoIldiaqRl1QShowRvJ+0Xzw+lUbY/E66Vygcyov?=
 =?us-ascii?Q?8olrfnnA5SG2tJsimIGLa6c3Urq/CceshbJyNQNmuGTHfXhKrJ1MTeYDnWKz?=
 =?us-ascii?Q?NeTPnB5DKo1ZvX9k95s9DUE6wmvrzPDxop7RmI+Kh7uC1aL6OM3cybgV6gda?=
 =?us-ascii?Q?BCvOy6T8oxXq7h5vn15GR+EZQjA8kHpP2iEcOmKRL+rvYvjDExOrnwuZiscq?=
 =?us-ascii?Q?Vs+nWQPMaBFNqAcpzxCXXuogS5jUdQNhivH+00WLRa9dnRPzn+kqIRmpwsdT?=
 =?us-ascii?Q?TwqvSh54B7qJCXdB4SZlcYJGhoGyqPz1M9ZIF9gnTracppPX169j65AEDlJd?=
 =?us-ascii?Q?KnYZgkppCwKRoJUyBhUpK6R3lc8vbsGJA9NBqbk9s3nUeeHM60+ELW0T8Tvl?=
 =?us-ascii?Q?QDUnonS//5Gfzm96aEepvtubEZiOCmpYIzyMIUXiNWYJiZkPKiiKobK8VIzK?=
 =?us-ascii?Q?O38cjASwWyyq1K0Wm398h0cvUrvsDKWcRCpxdDDIROTKoVS9sgo2BfcShtsu?=
 =?us-ascii?Q?IbYsoK8mchRcK5mE7LIitAKvev+bJMCtYTgmFpq94XKeBSN8habToqnMVs5d?=
 =?us-ascii?Q?t+8nB1G4/yGdPlD1cUOSTbLPuOFu1e6mAHz4R1Zii10ot6eIXX6PmQz85YcX?=
 =?us-ascii?Q?dCAlYYmqFracSrxNM6Fu/JcxRGUP+8gHfF4Bv5mt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fc0b7a-8250-4d74-8d7a-08dcc8cd54ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 08:25:39.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVYYUP/y+/86x+x799NZmPaH/2EGFth98xq5aOjuBCOImtIzbht1r3WbbukhBT+swGVvIJv7o11WY9sjAe+pEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, August 30, 2024 4:11 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS m=
ode=20
>=20
> On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> > Firmware crashes when AP works on a DFS channel and radar detection
> occurs.
> > This patch fixes the issue, also add "fake_radar_detect" entry to
> > mimic radar detection for testing purpose.
>=20
> Is this issue generic or specific to some firmware version or Wi-Fi devic=
e?
>=20
> Francesco
>=20

This is generic issue. Mwifiex is too old to have the correct code to handl=
e DFS.

David

