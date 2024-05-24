Return-Path: <linux-wireless+bounces-8042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15528CE3B1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5161C2129B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2E84E19;
	Fri, 24 May 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UDuSk15o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD742067;
	Fri, 24 May 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543968; cv=fail; b=hsK0DxotT/kcW3MXp1w268R6N2jcQxkEQ5xiHwfeYObHmt4QahEW0q3OvV138hLtdVxeCFf24C1tztLWRqTb/g4vPfGPClKXm2qLM+4Pw8gFvkGtDrERy/p6x9MYW2UYhW/TmO6Hz1qjv5mH4z4lgkv8qwjRssNU2huPFHfACwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543968; c=relaxed/simple;
	bh=RDs7H3rbrQnIGMofi87btZA4zDs+Z5gLalpAzOR5e7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhfx8kHSyzil0+mxGfij/NTm98UmJY2t9r4ebeF70uCsVjtzZKQwNJ0JIS6Ngr0qNMTn1EWJLfKFe9DCBrNdl3XGl2mpHqrb2sgP7l0dNaOwA7Mre+OnY3axe4yjkjPTVq67vsYGEFybhFXAOM/dThH9wjJ3oK9iBp9XiY+lICs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UDuSk15o; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8m54QUD7peYI7dXxv477M4Wgsiy0T5BqOIyts8WeGlf0iMA2GNZ8llNp3v3s1hMkb3cy7YIqqNNaZwzZYQeACrXnrq4gULSARxI9ovkoQBAC7+mM1aftKsURstCdkWP667Bn0UJRfqYQUVSR54BHRaJIcbF8vMKehCt6QYQlNWZDG3DAs7AzbfEjJeH4Sj40fDSd31nPmn3yBVk4brqw3K7Bq6wbfKtZv4mofhKp7yclnf+hI2Cft8sa3chg1pcI1O5D0+VfpScuPzU/HeBPn3wE/lppHI3a6ppJNcpyhl18/V1/I3VzNG1hebyenqgMAJuWKinTyq8Fd4LBrbPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VPZi7Z7JstSE/MxOYzxNIVSLmDs92uwzaV9FfdICJ4=;
 b=WmhnHj7MqawNBhj9UpXtiSX51KtJkjC1WMvG2bYDyVAgmJHV/AsXMCGS5la6yRZLHy14/pCNLqWEixwG19Bml6biBElQuOR5P6SAyd5laiBCFGJ/U+BjH+Lw7BD6dSL7KragfYwLL419Q/UAkSyk250/vYEjluvlN/WcOj/++jyMI+E0RSsKEfdiYnegE09Ss0KHQDOZU2qgu4WmFh99NBwkJ5yJ3rgiyU+mLl0W7JfxDIxuwY72WC0zv4T+sV56+7A4llnOA6mQOKIc+gpF4A6Ls3zNjTHC+vvCBNvdmn4zFOub2WwhJ7RSq/0kL9+7cYk1EklmN+8G9W8SBxGjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VPZi7Z7JstSE/MxOYzxNIVSLmDs92uwzaV9FfdICJ4=;
 b=UDuSk15obF7rodTYBUf1DuumhiBJX54DgETTxDHv/pCUHAVA0BFBm2QpzO3CJ3bmdSSjQ2s74ceFK6FDZHczN+MfXfj65ubEK2UJTCIJ5s+GKyzQEgR6IBb+xDVLcoYuPecjNeiUanbrLGytusyckUc4Qg9juquTe7vd1TJHMZI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 09:46:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:46:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index: AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FA=
Date: Fri, 24 May 2024 09:46:00 +0000
Message-ID:
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
In-Reply-To: <Zk6TklTIbxZxIWyb@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8597:EE_
x-ms-office365-filtering-correlation-id: 387c7a38-a729-4f67-6496-08dc7bd651ce
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VaMVds4dwC6MBQMgKhcVFucXzhJiPyEDYRxSi3Zxb9yYbWZ0lTux1C87JS6W?=
 =?us-ascii?Q?/VGEwymslIuARWJ24ts5RAue3YrGq/8GbHocno5GXUFsMpNs5+XB+QAdkdGz?=
 =?us-ascii?Q?SLZRHSAtYiYpJ92YAKRVWs0T1DoHQ0znWz0Z0K3Jlb/eSoEvmGVZYwE7soHj?=
 =?us-ascii?Q?9yulAkoq+rBusYiQLfbliPvlK6T00JtFlmnp15/xlI9ZetGE/yQqbtJk/dnb?=
 =?us-ascii?Q?9iR+9/kPAwTaZl4MrwZmQxnVTK0trX1folG0jfIf0GF1zCMLB2l/fo7AJeYl?=
 =?us-ascii?Q?WuB44TlujIhV9/rC9KYrQeCjHxI70+F2+chlARAB9+sff8Sy/AhQUkJ8b8iS?=
 =?us-ascii?Q?eO+GInBvEY3A3yfk5R6k9Z/j70+o13eg7pfLEU4xPDz7zFXMSNv2TZ1z8ZH5?=
 =?us-ascii?Q?4Tay0tho/1vHPE6iP/2kvU4ssGVtMp8MWQ1B8oSY89N90zUwzIDiHQ1CElYa?=
 =?us-ascii?Q?EOj8ni/80ttkvAY57WTdlbO5Bv0fWumh/zv/nU0XtSNQv6U8ZNogeqC8fnEA?=
 =?us-ascii?Q?ffeSTT83eWGoamjEenUeL9gKC3PVdUHpNzrwBdD+rFUPrbjLd54em+bUQxJX?=
 =?us-ascii?Q?NDKSWb8pzwbXNYU1twXAx0mPR95DFWee6iX1K7Ve+ygJZBEm19HVKqpgGG22?=
 =?us-ascii?Q?RsQL9IZHuhIHdd+RT0E1rXOkQI8oOJVwpFfY0+KE1up2mWfwd3KmqFuEZB88?=
 =?us-ascii?Q?B/E/bKeBmJmWuUnkpBkChhDNDfBp47bztK16lxao3SCSznRx9GEJ+fy9MMr5?=
 =?us-ascii?Q?J8ycwisUUZlGfBPiw56RBrQV3QJWcUhFIoZXgg9qoSWAYFtw3gaoz3krbio4?=
 =?us-ascii?Q?/1ZmsbZUhlaoHZPKXOruVbIx87NTywB/cG0ERsojIdBQRkDfyzIrQlBng2L0?=
 =?us-ascii?Q?ar9j9m+dTIgxBI0XJwDbdyJ0VhJsWsazS1vyl9lHektdPE2VVdU89akVf3xL?=
 =?us-ascii?Q?VK5rxsLpX7eCg+VrhvfVQF/Vds8N/sJwqL/18mY62eXpXAVaxeNZGSmKy6jz?=
 =?us-ascii?Q?ESIKNwiH8mqy5hT6dUFe/sQOVohVvtSq2enHAt8D9RqicVfqhpXtkcC8GDYI?=
 =?us-ascii?Q?Cw9PDolvobJeZigNWSBzYvhiZ0zPt2RnCbQhVYxtb/mhJ68hz2pY4LOg5pu+?=
 =?us-ascii?Q?LaeMEVMpgEUzQbct91qUev0OOOsZtoTSglJhjrGE/F0c8+zvCRmPSiZ1M1UL?=
 =?us-ascii?Q?dQ5lA7RSFc4l8Rn+DPgwNc90p6tDblBGzhDW+K0QC2zbbijwlIVSKKn+Da+A?=
 =?us-ascii?Q?NTV6TO5o/57JHBzxdVKBWsEBCVd+oBw7210RBv3sYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8nj3fNGArDw9hqhlgN7IwIpKB+KN/l9dfRD1KVlVhe4bOusoGT83PjsHW3hf?=
 =?us-ascii?Q?KAx1RPqTcpWGv0SMyW+NSq40TMYua9HVnfMZspx1FpcnYPSmxRaTvebvAMRi?=
 =?us-ascii?Q?fsl993hlA7q8WWnOTyZFZFS8FBFXD3Pvx7/xpcUUr49CESuHY+iMvl9h4RnS?=
 =?us-ascii?Q?p6f/mzCYiWbx4YHnZ8N/VgbHy61U7atQLD0345ugycCTre9OOVH6ybQIUEOA?=
 =?us-ascii?Q?SUlLj8EYomNnl3nuGPvEah2hs8LkFRJSlzpO8YKG9lzlHLHX3TY3Z28lFnEp?=
 =?us-ascii?Q?8CCc3MsDF4fwp7nGYNTxU7EKFN0E5o4/ni4ga5FW9MhMQWya7fqFL0YWjQjJ?=
 =?us-ascii?Q?14b06E3Ukf5+YRiDHH5Q0QB6fLJ7iDf1H6C8xOgLKUnVTSgRozMbCDRfLrUZ?=
 =?us-ascii?Q?tIhmliWPVdFngCdWkmsNnBVx6ZnoWtGPzpKyulcLdGpyhQhb2qVnTRkysgfA?=
 =?us-ascii?Q?cleuDELyM7D/yWydzc+S6VNOc6ZMWpg8wLa5si9Wknu1mJyGaVMSD/GxfJHZ?=
 =?us-ascii?Q?Xg46ixHQRM1hSUE0rGpjLu2qnehkBrGZsbfEwGrDxYMnineRYamF6Iq+H95w?=
 =?us-ascii?Q?84SecN1hzAXxzgDJZZ2ap4uqxEySc/eRAb4W/ZbaeZ2joRimUCAphz7Le91v?=
 =?us-ascii?Q?7m3TvAHrQbH4y1yGkhyNWUBEZ23lXE9/u83WHL9eG31qcSphHen5jn13tqA3?=
 =?us-ascii?Q?EkznhPY1MeO3Xt39SLFfg4lovQc0Y0c4z+G1XD/1+V9ixobRfjBz+hilLpF5?=
 =?us-ascii?Q?MNsEEOKXg4p6KL+FAs04HDnXMw07UM0aM+cM8HI2yEQrxSxkDz9KGZ4h2knj?=
 =?us-ascii?Q?BEurCrfyVMPQAi8G5f2lxa1wmkmcoOeNWoCilaMOboQZRssYKJ3+MIDU+tlv?=
 =?us-ascii?Q?crgC+f3nYPid/DEGI96Q1syilUNnmonbDtiFeHfYorxFCFloX2/t+7s0bess?=
 =?us-ascii?Q?wpe5mNFmswAqU0uZeiQR4M0/q0YKA5lsuj7yyuSrnyfeBKBD1JPwoFJ1FQRh?=
 =?us-ascii?Q?7khwzyD/9IlsCiBiWAV6AnYicyosKVt14Q2PTSlLbmaRnTf8oL1VTi4H5ZMw?=
 =?us-ascii?Q?UoIQTLd5VLrQaGCwS9oFfzWHQsRMvtZ2PXib3b8rT24q1lLguFJOwvhU7aty?=
 =?us-ascii?Q?xhrOudXCcc8nEFcx7pnxzHBfHoU0cPkX0fg1cotB9+JSyEPuWUWHDW5Z33rQ?=
 =?us-ascii?Q?yJYHlJMClO07yL+OBYH7v9gTL9upjTZtOkohJ1Q1TfK5LhZJ/mhP+sBka4V+?=
 =?us-ascii?Q?Qd0pfch/hqbeuQ86ZG73qPQDiqPWPIwaZ4xabeuXMEyoArMMLvKKa3uArRyf?=
 =?us-ascii?Q?33nZ9zBE0IsR8YX/nDw8ELj7fUOM8Kvo4k2NFDwXyxCuRYSumT7nRgaZ34RA?=
 =?us-ascii?Q?S1W8wgnk/1mXX2uDWyVoVnih8drNR3SPSC2Gr51R6cvD6c3D55H3IbC8VfSs?=
 =?us-ascii?Q?msngB5RdEeJ7O06fxyxr7WnmW6AchlgUkdzjTidAK2dlsETaCpTWwqq/by7A?=
 =?us-ascii?Q?FcuHXpzsPCeDtTQHQlbzniwNpR9OwPzxMzu4WoERrKMmhSCz8Hdur14dZQkn?=
 =?us-ascii?Q?L3tgy6FWmhUq7QxMfMhHhyYb1id9c56u9tpR6X9U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 387c7a38-a729-4f67-6496-08dc7bd651ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 09:46:00.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFX7qDoJ/W/fDHAw93z8irJlwZdDIAhC1ezLsis+pyt418lkY/zLT4mbauAd3KeXyvdzX+3P4Vw87/Vx+z21Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597

Hi Brian,

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, May 23, 2024 8:54 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for clien=
t
> mode
>
> On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> > +static int
> > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > +                           struct net_device *dev, const u8 *peer,
> > +                           u64 *cookie) {
> > +     return -EOPNOTSUPP;
> > +}
> > +
>
> > +             mwifiex_cfg80211_ops.probe_client =3D
> > +                     mwifiex_cfg80211_probe_client;
>
> For the record, I feel like this question was not adequately handled from=
 v8.
> That thread is:
>
> https://lore.kern/
> el.org%2Fall%2FCA%2BASDXM1PEMRyxRpBryJ7G6e7yzG8Ku%2Bg2_qpHN3g5d
> jFpAWkw%40mail.gmail.com%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%
> 7C0b65f7e4a5fc46c8bdbc08dc7ac2c9ff%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638520224227876720%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C0%7C%7C%7C&sdata=3DMpqW1U4yTgDcM0g20DRSAxEnHkNNkd2hwsZrVAxg8p
> w%3D&reserved=3D0
> Re: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mode
>
> Brian

The difference with and without hooking probe_client() is that "poll_comman=
d_supported" of hostapd will be set or not.
If "poll_command_supported" is not set (won't hook probe_client), it will l=
et hostapd to set "use_monitor" and client can't
connect to AP.

Maybe I can put following comments:

Hook probe_client to avoid hostapd to set "poll_command_supported" as 0 and=
 set "use_monitor" to 1.

David

