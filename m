Return-Path: <linux-wireless+bounces-12249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88D9659FB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A41C213C5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7431534E6;
	Fri, 30 Aug 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlEoe/ld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88913D53E;
	Fri, 30 Aug 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005962; cv=fail; b=YMc1dE2jCaXsEboLcwhcW/93h0krVuwJZRNu/6K+u1j9znlLTtZaG/JwuEg1AuhFbCL+LtEG1gVBq8Z6ISHmUhNCF1aZruD/sg9Iuuhn5VA1KCh04IXThMQ526zuFhxfqV/QB/3mkaq/5S8BvR9NGIbwmA9FNjyijF8Uox+/AvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005962; c=relaxed/simple;
	bh=r1AP+ylF2vaPbGM8hCHo/bukaEAOE78OEb+HpSs2d3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqBJKvDG0E4WAoTry0Z06zVYkePeMWhSkgc6byEp4StILaGzhKTSoOcrayXqwYk2bnQX5xC+lgUEQJjx/3gN47PvDRuRfjqzrqKPCRD7jCeYEWTsdHEIb5bC7BnsT7weQhUMRTpTReBliJMkCyW3HUPt+HbCaHn61ZVGPxIjk0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hlEoe/ld; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh2ViLraOx4yO0RjmzwSqcU268LirgdGjeja9yX/T3D4aJk6aGa6j1epk6axKW6fAXrtaoqZdN0/pc2qCxUKrN2o8zJAwICXYHfhDisWvrQ6F98XWov4RgUNMTYriXmBkmmfcZZfsmLSSnpmVFnW/pZEXYYDf9fMjfr5a+/EN1Kd9PQgEPl6uLPZ/NJq9WnMPiPwloG28BLG1s5vaOLXdGA2gW+/NfOqYMvnoAqxqKDYU5ZwoU9z6z9vPg63vQn8jTIG3ang1Epf3ax3C+OUbh4m3DrOqfcJAinFfeVHTu+3HlEYsNwmG3eHEqR3/AYo0xoRjFADxHcxkkEog5/tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1AP+ylF2vaPbGM8hCHo/bukaEAOE78OEb+HpSs2d3U=;
 b=Kv3CvPZMSQY/JsF3veTL/BXiZnHoUfyeMN4BPMT7HREZwb5OrKTJK5dlDHtfVXsRCT3LYgTw6Uc7uKk6VR+07uKhatHTo4HwsaMwMuLSDNkj0YaKKyg3+yaUWlrnj6AlU7OvEgZH9yWovdZHaCbHV/EynO4vvrfF8ciciwbxzdUoOfacZJM71OVONtekUIp19HQBXsrirMHSZ8KzHLqA9yuUcId+NcyUX7ovBzUDSC6WWGidGXWpHgE+/tCU8lDiDNKf5j4xHMd5iOODOFefUFjACnhbBgHOaW079U3J49iR3cQ5/2Zner7SeMvLb4EILCdJyFcIm4oG38E2vDjJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1AP+ylF2vaPbGM8hCHo/bukaEAOE78OEb+HpSs2d3U=;
 b=hlEoe/ldWBG79go0oWlNVktubA9ZxonEDIyKtZhrpmBdRV80ERjNS79nMTsnFFqR4T2t0fDUxK4peOcrjqPYOtj4EkXWq8XXvfW49gVqKn4Nfas9a+4dMt9vJ3dqu9Pg3h91054g0FyP9cY1EuyWGjz0wU/kkkUScPiNHDTlB7DpCQupOwA3vcNhylroz+y+NCCcRPmEUC/F7XeP4I0DP+vNJQ/p/CLtG+jqpMnHpnihfRPUV/RC7dxyuxusSYHQenr+yufpzzTFR2XdfL4mYeKxtBoTd3BstBxxs8mAI2sysz8ijbHB4mwrIHnFwWudrsJysGjZi7a8KWvIGz2UHQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10806.eurprd04.prod.outlook.com (2603:10a6:800:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 08:19:16 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:19:16 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index: AQHa+omwahEWj+NlxUWyYlP8eaJEgLI/cxQAgAAAVwA=
Date: Fri, 30 Aug 2024 08:19:16 +0000
Message-ID:
 <PA4PR04MB9638654E77A08452B75FF684D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
 <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
In-Reply-To: <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI0PR04MB10806:EE_
x-ms-office365-filtering-correlation-id: d1f3d02c-5cc3-4719-13ac-08dcc8cc7054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DF8WSnIB0T1K/6quTu7MRSP90qnQFRA07/fRupS4A66tzMOq+VKwJGCnwQ/N?=
 =?us-ascii?Q?IHOdKr4Vt51STopXAIxHkU4KyzqF1ybXfieyh50O7F4Cjishc9rAfEtYiIhw?=
 =?us-ascii?Q?/PzpSWw7xYODbVwkS3oS3PquHSFyue3jgWwFBBG891w6Nj/7YW89Y8ooIWPW?=
 =?us-ascii?Q?ydfbDtP2JEMjqOo51qct3VlXjK7GkudSVH1YjjRhs+5V6JKaExOY8YLePsxf?=
 =?us-ascii?Q?EEY50dcFQOwOwBsKLsNS4kMiUPRRImJvZxApWc0S5qtMopLLvkoks2XvrI/9?=
 =?us-ascii?Q?2vL3n86YyA7qdK7+9Rj/CKuf3T1hGcwQRx0dffahTeF6+WoatwQPKs7OnT/k?=
 =?us-ascii?Q?4LtZkdM/zUPZufQzpVDUOHsWV0nTsW0CvBnk77Lsy+pR4z/cI4seJIHUZigo?=
 =?us-ascii?Q?/5wKhwfgwsswABLglGsjy4gKg280/GEEOdxT6okeWtrjypVY3HicmD59h2Yw?=
 =?us-ascii?Q?3wAqdf6ORmCLDJKhR4Gjhi60tnUCBxlYmYbfQpoIrALLOf8CNk+W6TJdaIVf?=
 =?us-ascii?Q?Fc+rbA5mjKXT6wbkFvR72J5c1IoJ1TVkB0413jBe79QBALPs6t9QSpSnyWCw?=
 =?us-ascii?Q?jAI1fCkuDW/htm3eGGAy4MyKWbPolRGByxzCw00LtDoiBWmCa1dr46+ljFvt?=
 =?us-ascii?Q?HFIFxIRjQKk1cCXYDPNFwSbH5mXcV4M0y1UdxixcAppJFrKL/c6yioWWSHO3?=
 =?us-ascii?Q?1Xdsaw0c+I8lv3NSbBmK2W1Ph8K605phVPCFm1n3chDfI7pBWrF/dNKXLqfc?=
 =?us-ascii?Q?zCcvd3W6tD2X2bFfosEKGpOE5QkQw9kMQ7umpdDeOTiu32r+rmD3M7qIUjgI?=
 =?us-ascii?Q?ZZQmHYZbcRxARKSTqyl5FJE/UTLLby7oIIzpf1BqaosetmEeEBwdedj7P4B7?=
 =?us-ascii?Q?SqqGp9VKBmpAZAK2Kpg7Y+hTzlTMRdHcWqfgB2KgwJl+4jAILE0qIA2RaGJU?=
 =?us-ascii?Q?N2C/hvn43wlLRaNGWGOEYx+5Shbu9IFAJrHvX0xgamXPDRBssypJlM7OizuL?=
 =?us-ascii?Q?kFrkP1m2qP1LrmpU8+6Byw00W3+fT6Dhxkicav3uGowEOZqMv5HtOIb4C4uX?=
 =?us-ascii?Q?p/m6Z2QtNAEVz2TPtKndLss3gV5Fya3pbrstQQ59hPJv/JPNGwElfPxSqXEL?=
 =?us-ascii?Q?J24dLgIu33io635i3JvnU26bYvBmxT1aKWZMjV7H+zSe7QUYqlJ8XuxKBOKt?=
 =?us-ascii?Q?XGQtZga+A4QkqLlrPpPxXHaFPEGBjZ8LLzCU2/+9g6GT+dCu8fP2ColMoyTv?=
 =?us-ascii?Q?BPfRhYuhz6URqWhzlnCt8HPPItpq+j25UiYsqxxldjAZTc/e+0+GoiKvaifs?=
 =?us-ascii?Q?p6cF5xNzQyZsyvE1hMGwHsVWpG7WlD/BDSmX9mgs+3weOCTWlMlX5ZNzpLU+?=
 =?us-ascii?Q?KCmczm8colXoauHjRovjisqiDcayFwSsIsHFpl5Kg9Av5e1wWg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wWQTulmoEFLaDF0+dHdXZQaTprXyCC5pWLkbTlDPABxXofLwu3TYwLnIWqxB?=
 =?us-ascii?Q?+QStgqeJLDsgi1XxtRO07OJTyEQU3mPpIEcjS9Yt2u48KLbeP5BblSQZK4BV?=
 =?us-ascii?Q?gqRExsSsq2W+AgLMDSDWlKEf2auj/vPKruhqg52WBHNv9syJda74XpV/v0J5?=
 =?us-ascii?Q?9gDu3f2dP8/TbEBH2G46fY6PiKGkhFEwvp14LVRKunGSULyVtYUtwO8ofq9f?=
 =?us-ascii?Q?jBQYHrvFlOZSUaT5ED9fQ1vW1BpzPPJbfZRzydkWjnhHYJRKF6tIbikNprXE?=
 =?us-ascii?Q?x/ckPzmpTglD/ek5ii1Dx26TGCoVGa9MeD8ER72QlzyJp7tkNynF1uT/NQKz?=
 =?us-ascii?Q?4GDRIkOCctuwZMFko2j1tAWjjLgH2jc0wvlmqJq72fbdTtteKGUINkGHMZ8k?=
 =?us-ascii?Q?aUcKIQZf1tIOQ8W+Orot4eaz5yDG1+E27Tz56z+14bhFZ4o3i/ypShCIdpq0?=
 =?us-ascii?Q?WJ/WsYq3Jz+6/I8Lgi7QDKvcyXUvl7JOyNYvYohvKmq5m6nToECtGvnM6cK7?=
 =?us-ascii?Q?jFlMOEhtiMdCkfBCycafd9IIuHUZJyOFjzeCcALPHSD7zIIvSF94xTC1afUJ?=
 =?us-ascii?Q?s57RmDcEXVzxcAtdEF3Iz0UJQ0ATxfU0ZU1qzqnCWwSZ350SLAUH249TIGcg?=
 =?us-ascii?Q?ltR2eB1n8TVs4arCpBiKufWBsOkgNzm9n5VLRbqXy43IXn8GvSZMuS5oysut?=
 =?us-ascii?Q?zp47VcFmyoJl7toG1Mox5jBqhad7pQCuyuLx6ZxQisN1Msfq6Ue7sbdF1fk7?=
 =?us-ascii?Q?ZlmHbIcH6/RrJk84gHE0WgctKvfaW0L4hFqetjdY2B3kXOpj7UVXxpIfxjqj?=
 =?us-ascii?Q?Wx8wHbJMSiryjMKHuWYcfhDFckcmo/UPc2fjeV5+Q+rGuHduIztjXFOG2tB7?=
 =?us-ascii?Q?AYw8sLEa9meIcfvHovFqVyv4ywRwYWuZImQx4WiigKxB31RZslR7hE2+e9fa?=
 =?us-ascii?Q?D4aPUN7LqG0Zwd/vEmdS1RB5B7sxWHCgNEhdbiGeVvWPYpjEiN6MQiDSXDIk?=
 =?us-ascii?Q?QgL88fg8OouewxlKsmacZuk+eieyY+Bf2dRZylhyabNxCLHQxySD8ZEoqooC?=
 =?us-ascii?Q?zDBZhWM8niRfgU2PvTkxNgKqqnbNDMFIwRhHRbYJfPfVkNbmmknqko/M6AoA?=
 =?us-ascii?Q?gCMDEoREndvlG+M34hx7xv4jkRvQue1zcl5QkJqVITbyc6wMsnWmlPKr9yOC?=
 =?us-ascii?Q?O9FzxO2bhGoTiIXQNR5kT7xfCH+J+jJGgi2MDkEKnPfy1OP/QxwJDLqlKD3J?=
 =?us-ascii?Q?3oRynch/Rdw3wILHE5pmhAdzxCzwOIiAJ7MC1QhWIWX1paPrUwt+ewXJNFzL?=
 =?us-ascii?Q?2AiOTX16A/O6O8A9+QQQwEiOXiwilarPAli1Ug3ulcRAfREfh5uY9Zb7h+Jd?=
 =?us-ascii?Q?O2ztROeZ960ipkWvAL4UCE9IinrdnX+yx07HOrHMYz7GZKoxPfCoRo+Pfhtf?=
 =?us-ascii?Q?ZpJdt2PSv96dHNX/zQT9Th+KHBs/ackYJVQXHSDAwsUYLvxxgkbvMOk6k4Pa?=
 =?us-ascii?Q?rGss5sMUrgMW6NM7op8Xe7Zza8pq3Ua42YFPDDFS4kNJin6aTxqmV330mAWX?=
 =?us-ascii?Q?GJNBqRA3uBrAFkQk3ZISdyFNNDrV64uQqIaFnCwu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f3d02c-5cc3-4719-13ac-08dcc8cc7054
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 08:19:16.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPNouB/EfQWnqKSll5N88XOCOZLPWks9LfVtUwZ34wNt4wPqQGUn13AeI9VqEKOBSl878QGAkw0//GQKatAWGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10806

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, August 30, 2024 4:11 PM
> To: David Lin <yu-hao.lin@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on dif=
ferent
> channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> +Sascha, that just sent a patch to handle the same issue.
>=20
> On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> > Current firmware doesn't support AP and STA running on different
> > channels simultaneously.
> > FW crash would occur in such case.
> > This patch avoids the issue by disabling AP and STA to run on
> > different channels.
>=20
> Is this a generic issue of specific of some firmware version? Asking sinc=
e the
> driver as you know is supporting multiple Wi-Fi device.
>=20
> Francesco

Yes. Firmware only allows AP and STA run on the same channel.
Because Mwifiex does not support other ways to make sure this condition.
The code to check the channel setting of AP and STA should be used to avoid
this situation.

David


