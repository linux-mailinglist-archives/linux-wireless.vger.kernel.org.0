Return-Path: <linux-wireless+bounces-12726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99D97291D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981C72853F8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814B179204;
	Tue, 10 Sep 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EFbPi386"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604617A924;
	Tue, 10 Sep 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947825; cv=fail; b=kXMv+TchDStvDMARcnIrb2vuG/KgkHKw/PBsB/mU/s+xgWlH381U5utlqPUhEoSVC+4HaNmSD95eickUPhOhaIKkwrGa714mOzmLKCubYNZaVpcJ5WJDtzMoknP7zJqkYby5n2kzvL2RlqDfs55IzVDLu3AMjMbbPVRYL5yP0M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947825; c=relaxed/simple;
	bh=sQkTn3XLh8MtXOfEx0Zi4B3iEmkI3y7oAEeahGBu10U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GONz8yFn3YHbtn99MY4HQM4SnJxGHXmKrqtnqnUeHqzQZH69IOiRngKOKv9wdNLuZx5r7OGMOLc3hGxbwD7byQ7ZvcddUOwiIeTPTrbnM3ILrLLGIW/D2J9T10e72lodSmtbZrzMNWuivY6sjrwey/zFZsJ/Vw7vt4XNwdL3qxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EFbPi386; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtYknSzBx6lDwG7Sw69/ZHnO5Oll4W+3OFb4qUCSgdRBu0MuSv+J7VRaZc7acM4BMzOFV4wABS9/eclx71tlk1Rrv0vOQEPwzQHx5GmUyxp0ISoj0AA8BY5xVvg5rSHYvDO7ggB29r4FIhz4oW4OMt/V41CXnAQPbDrQGcC2mYmvSIL2AKxE2aDLKhM+l6BHt848ksg/t8AcIkUMGKvCYaZTkqkjJnFNJ2yHli4fzIr8XoxJuzKgShSGGxSBgsmKUvwKJHJ/mTVLzI7Hqh2E7WDmqHK7Y8dISFUWfOVFi5ayhhA3yG4iNXka8zxpLlkeF4Gn+NNOoSam+VWNvq42yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQkTn3XLh8MtXOfEx0Zi4B3iEmkI3y7oAEeahGBu10U=;
 b=IhQ+zDVSbuM0mSt0iFyeF0LceNfomNNqOGFyrT2xjEPoidcUMZ3WKs0TwTJJ+YIDraBtT+Xg6I023NaIKYNFvhyHdcy91tLkYyiy/nm1BK0td3PZeCbo/bIgOOgcZunzeNwg2wy4UvQiWrgrOf12pHt0PgFowK46Oy0PQhAovDgtYJMALDu70fhcuzTqzGJuERVGFgmx0kLOa4NCF6rCwVQm2CXJt9BFYX5jeMsiFRvEIH7RM7lBhyWNKND3u5p+++Z2jxJSrpCJB9AA11P1UEtBzmmAr59OXWkF4CRhUPHXPG6U4BX7luzG1xbwYUjfRBjw2jVzjhieOoUrXlmBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQkTn3XLh8MtXOfEx0Zi4B3iEmkI3y7oAEeahGBu10U=;
 b=EFbPi386VIMJrGOT9S5aioEGYEAE1yYYp3bteej2rjJTpaSOtSZOYedVM7ty7URx+Pp0bmveBEgd2Qtd4fZc5p2dRYyXyeMONW3RkdvPHFgp3coh48zjnVnRVJnRaudR02ZdPJl84AzOGSuspvQ0r9hzafUlFzO8GwAI5fgMMp/Tqnd++PgcjKA/Dz8CcoWTa1EpWHDy4kkP1TGV9S9MDBOSBAXYSiwfLVVQI/pHDyDn1Imd2y57ZnZ/pQnElkAtGszvq7Gzm9NduB0ExEq6btgqUolXT8PnrT9xg63m6dsUNrD1KkZ4cXNv9S4T9sXhGM0GbLNPGIAdwWyf7dTZKw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:56:59 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 05:56:58 +0000
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
Thread-Index:
 AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUCAC6fogIAAWbHQgABDcACAAAAqgA==
Date: Tue, 10 Sep 2024 05:56:58 +0000
Message-ID:
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
In-Reply-To: <Zt_fZEJyiCyanf7X@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GV1PR04MB10426:EE_
x-ms-office365-filtering-correlation-id: 10822012-254e-43af-a903-08dcd15d6214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pN1VXm7Aeo/0fr/OZV48Dax88GgQXQFJ1kT/TGfy/7gTC9J7Oc7j4iF83TOh?=
 =?us-ascii?Q?DuPE3sHy31NfKY7bv8Fq4H7hudPgRX7gMEvImUIfhLUs1K/EQG4V0uzoJK46?=
 =?us-ascii?Q?IRMexwypJlhZsX7guGWQtRTowT0Q8MgvwH/Z1CQ3qJ/fA0FYhFpxIFsVwLHk?=
 =?us-ascii?Q?PBiITPFaqps8a+wa5J6mTTXGhPOL5xnIY9/4zxckxzb0FRVXkzSipLgUaYSL?=
 =?us-ascii?Q?8tNBYfBgLEWMkF5fh64Bylw92kvDt99hOojyfNOel1Gm41Sel99TFkRVZ5DZ?=
 =?us-ascii?Q?EuLDK6jVXoaopPXfRWA3lEb5XENjZubJzWtACU00ON/VKB775yb5u3KNblB0?=
 =?us-ascii?Q?wwzUOoKl+rxqPEWp95bkOLXKhhCEK7294Rcc8suOKDuDG9mV2VD3o27hYwpu?=
 =?us-ascii?Q?nE3QIruzkEcqEsg1jEefEHuangqt5o+sDHiY6TUBWfGWbhXDYtpLEWaIWssy?=
 =?us-ascii?Q?jDezrE4QcnWmRwTT5uiOvM69t1Z/MQuuxAeJzTlbiY4NwvfIhiwjNg+bACAH?=
 =?us-ascii?Q?majjGTyCbkcwQU9mswHo4/Q/72okKFiDgr3Nj7v2MHFQT2nBR+WBJsFEhiw7?=
 =?us-ascii?Q?WUqPzuer62+rGjQR7pInYLGx3o8E6XstkMLDZ3WHP65JkTuSSqAq6g3dbjf6?=
 =?us-ascii?Q?tLjtVK6cj0844lP2kFIpGTNREVXAwGZfihThF4bassnCiSnzj3S7PPuinqz1?=
 =?us-ascii?Q?42uErt2aFr13aVBOqoeGTm/R9WXXlssXpJzAhtuckcU+Z0YOmonEL1l0rM/q?=
 =?us-ascii?Q?QKdKSOt2OT4FzvysaPFe/IyfoQ/B5k7gUVGOYcEz05A3jFJVBz05lAE8Tq8x?=
 =?us-ascii?Q?ufWafBJFODj+37sqxMtJY/aGzHoR5cwQ5ydAC+qmHAuzh9nAWveILr2SNaSM?=
 =?us-ascii?Q?NMuKrptuKqIYckUf61QP5d5bRX7eLHm4wPeY9GyPMQISO6gt6rdNTta4KPax?=
 =?us-ascii?Q?AuS+dQEk95fqGXwP46WSuvRihUGJOFuJklkb+nWB99LKARtHKSFVkEwqQKtm?=
 =?us-ascii?Q?ObttVIzAwV0LRgVTYGrZx+K+TSfuA6jFz+sQCwgYx5kEQNt3wc7ftGjs8Aux?=
 =?us-ascii?Q?c8U0bPJkLQ1ZYJYrEuItL2pxay+a/DA3kZyIhpwElWpnQKEKQ/3fRu6UIkLc?=
 =?us-ascii?Q?2zJ/hQS9JyQDg+EB0uynjzdz7MHtpjAhDXf/S6NAxIqyRv/VfWXkL1uISvY9?=
 =?us-ascii?Q?857nWo1/YgYTkNhciuzAnRsJ4OFR31edOFp1dh+zfYoEHEfhopwUAHQF42cA?=
 =?us-ascii?Q?x0sBOLjJ5RkPn6chZ6IKFpTY9F4s41sMSA20uHqi5dSex4dj/qMQOZgJyrTi?=
 =?us-ascii?Q?RdwbnUc63Y9G63D7oZvenJCxLIUeQvCxRadzReMLYQF7JBw8r/tMzNcVGUnO?=
 =?us-ascii?Q?XYZUKCA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6DfBH+nY3LbujLhAkZjQDA4RMvnOFVpfDcZUmjJR6WLNJTfkCpE+Bx8KVBLG?=
 =?us-ascii?Q?7VKDW1HNAai9q/U8J7DI93GJVL4kkEQ4p16pyMAvEAnVZ6ol1paKMvpUDgoq?=
 =?us-ascii?Q?oKV8rGvoyoQwH6ngCWD8VVWcqVUzOLDmC5wgZFOSJ1rtEsxQpqqktRiB4RPG?=
 =?us-ascii?Q?bjs5JtXlTu2dpRz278pMjGsdoKoA4gQ/2QfKPDaM7ATllI/iq3wgoIF63+7o?=
 =?us-ascii?Q?W6chHcemdjbpDso9zeixN8lPg+c2XScUwUKMRSx0zNqhx0Lo93nAKTvpzpFl?=
 =?us-ascii?Q?X1/54++Exer5HlVtTKV+P6oRQsfmRqn9R0izzH8dbCKCr79I9j0N/NNcwyRf?=
 =?us-ascii?Q?D78XrKrBk2c10CegMeo/NuF8S2il8AblGekteYBy0UA3nTTKcV0m6XUm7xzg?=
 =?us-ascii?Q?xpCuBLKatntLeLMzhrG/2438iNPGMCYKXmogzMkJ+cigR0spjWQSmSqR+8tE?=
 =?us-ascii?Q?WACL9qPDjZTc2rwwXlNkjf2EbBGdY8dcfxAhB4esCV53nrJmcu4SfCDQNkFq?=
 =?us-ascii?Q?19RiLUwhjb0TWMtC6KkruTefLPuiWwHC5bpPmF8Cq9CsoWdLFH+Ox3PG2S2/?=
 =?us-ascii?Q?bYsYMjIkQsL//NGJqvNIQyMbsE+yLiZtwyI6bm55bVLqZctknfsadgTs91z9?=
 =?us-ascii?Q?I145TEql4sh8my9WCwoem6KK51DWPMGdBmBvzrM+7NLI7Y8i33W2QHb83pJv?=
 =?us-ascii?Q?KmUprJIvm3QNjlWSNpYg7AC8fmqXlodelGfJ34qMIaF7qQX5++aRJLXS99rN?=
 =?us-ascii?Q?svlK5uSIAMIPiVvLSGT42jIBnAxYif7j0b+ZUf/xaXHwJnQxXEkv0AZbitel?=
 =?us-ascii?Q?J0JJzH84/63H+tRkw+k827l70P6pAHvj8XF28LzINUWitVKqRlNjxYUF5rpI?=
 =?us-ascii?Q?E2dgVDF8m3NAjIMcSR2TUBPsiyV9XzO4Ce54T99c9BLciQBhVecshgGbrsuW?=
 =?us-ascii?Q?GtD+kEw6+xRTrrHrUsVvVBhFUHwB8VM8/tAJ846F64K7WcibDl/iexlg/IVo?=
 =?us-ascii?Q?21xyfNG9rHqCZFetXCjcQ1ufRQGTiUfJbOGzJOzpZOJrQAhXfiQ8qv7EZ8gO?=
 =?us-ascii?Q?n+D6YYOzY79sjbqaMR8Nr3jV5gHQ+zW5UaANJ8foacvh/bi89nJWSFntWH6A?=
 =?us-ascii?Q?jpoLkhchzkf47RaFUaVp5RqBHvD/YPYuro0CHy5KhEZlDrM1xptW3q5TScEK?=
 =?us-ascii?Q?Pz6B+Pe6TElDrwXX7JWHcyi+MjH+2IOtUvXrLHmkoC70Bb+yN0rGcpNY5+4Y?=
 =?us-ascii?Q?61/fpMQgmuCtgXPAIeGCIPcpMCEXdlvqbHDU24ySB4kgtMlMzUuy1WArPkP0?=
 =?us-ascii?Q?4CPI/gj2aL9Mnh9revbX2/I+U6n5RqXpHtf0rv55W4pDS/4pQLpF5u4+Hxqr?=
 =?us-ascii?Q?ybhEOfIGAKD9AohVSB/M9I2Iqh9g+cF5KNRCsaZ/5eAeaYY63QpLPx8+qLou?=
 =?us-ascii?Q?yKmyTprZvv6Gpu3WJxnDSvChjsvY0iWN50p5/M4DwORtyaJaeQWW9MNA5Mpa?=
 =?us-ascii?Q?zcDGrdsTmJQZv3k2VmIKdW4ny8tWSmhiP7HlB22cUwZGuANsyoKdlE7bS9PP?=
 =?us-ascii?Q?r9pvKXAFYtrdq7vvq2ohEVhrJ58r4Hf6jzEYW+ic?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10822012-254e-43af-a903-08dcd15d6214
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 05:56:58.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH/hukFfertAei6AA9nqVwf804fuK58+8S12TFhVv2zeQxpMETQSIDGPIImEIBqHXKGNKYKJm/ox4SdKsG0ycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 1:56 PM
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
> On Tue, Sep 10, 2024 at 01:55:14AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 10, 2024 4:33 AM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > running on different channel
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Sent: Monday, September 2, 2024 5:38 PM
> > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > > running on different channel
> > > > >
> > > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > > Current firmware doesn't support AP and STA running on
> > > > > > different channels simultaneously.
> > > > >
> > > > > As mentioned here:
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > >
> 2Flo%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cd0a1e3797a0d4acd7a
> > > > >
> 9c08dcd15d3ddb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 6
> > > > >
> 15445620612026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QI
> > > > >
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D5yC
> > > > > jjIqxpV%2BJxlPdrCH0gRTQ%2FCQZKr%2FDc0S1cjkaIA8%3D&reserved=3D0
> > > > >
> > >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C7712df39ac37414fd
> > > a7
> > > > >
> > >
> e08dcd10eac35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > > 15108
> > > > >
> > >
> 157502805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > 2luMz
> > > > >
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DURNJPJE17iRY
> > > Tu4i
> > > > > rx7eQAC97tE5OE6a4kUfjUwuaVU%3D&reserved=3D0
> > > > >
> > >
> el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=3D05%7C02%
> > > > >
> > >
> 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > > > >
> > >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > > > >
> > >
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > > > >
> > >
> aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnMZO565xCUO%2BwxD4tIfi
> > > > > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=3D0
> > > > >
> > > > > AP and STA can indeed have different channels when DRCS is
> > > > > enabled, so I think you have to check this in your patch.
> > > > >
> > > > > Maybe the same question here again: Wouldn't it make sense to
> > > > > enable DRCS by default?
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > I will look into DRCS support later after current tasks on hand.
> > > > This patch is a quick fix to avoid firmware crash in the specific s=
cenario.
> > >
> > > With DRCS support enabled AP and STA actually can run on different
> > > channels with the current code. You are breaking this scenario with t=
his
> patch.
> > >
> > > Sascha
> > >
> >
> > DRCS will be checked in the future.
>=20
> By future you mean v3 of this patch?
>=20
> Sascha
>=20

No schedule now.

David

