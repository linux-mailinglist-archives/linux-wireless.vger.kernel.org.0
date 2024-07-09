Return-Path: <linux-wireless+bounces-10094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38092AE26
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 04:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2201F227F0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C23A1BF;
	Tue,  9 Jul 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbhFCXff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0592C1AC;
	Tue,  9 Jul 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491967; cv=fail; b=VTcBUlO/428Lbf1Yv1QttjdeiyR9zNcduOs7WQz+yqPiLoO9K7q2Mvqjm5Ua7oty2rI+wehJjxKy46VKsGLABma8z9CRd8JzPNrPckfWjeBxPaCcXdRCc0qrfTcZ9pDXErqNetZYYe4UGbamBxwwBLAZ0gZq4GuBg4AD856LzYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491967; c=relaxed/simple;
	bh=u5qIpLzOUMzYg0heJ8aALdNBTWlymkfvfaTNuu4ghso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XY3gU/XBQbCgGr8SnywG7CeTyxHECmPaN+Qdb9ozJer8fQZ5HYX5B6LVbdbiSHcH7roJvcNDx5H5a1f/jW8ojwc16zdVGdXS96wdi5VwXcPm3u+RImJNM1WzN76tO2/8X8edz8s4Y5i/sveRdYNw6zX4+AXtzAPkT4f2V+57rmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IbhFCXff; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK+OmeuzgFYjbiaVLjDLoaSyQIBZM04xi5nR/GkM/XGLl1+ocQKgQF+uIZPXC9I5Pm5cJQSYBqJpyuys0vLS+xGAr5t+jniI69WZ9mPouY+Iualf2MEjtshZ5eC2W94zytAxl22OAtTuE4hMMgFE7NRdIZhZ8CN+mTncYhSwwUEJrwQk1ulKZKZA9IGCAK4ALBjfgyIqmsjOJWzBiTJUXchGJ0c4UwrdYhuXccUHmCUi6dEN7Y6qCJWWRfHUYQaXsTfAYu2M+MFr+XfwcD7CXA/Cj6OyhI5zd+Ef0wCXs3ph1nWR1eHj/dxSq0SACohZ/X+zO8iSrUDuW/P9f5QE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3URxQ6Hm0as1UKm8B8Jijpuk6pRMcGC0GAyzpM1H7I=;
 b=Co/eE43t6JiUKpKXlldGmr116q9sAYtDeIvTe2ySYKR4sDQLZnjJ03/WLyeR58mH7YNrUtPJOUXtHz2gFmY+FyARNC9EHm/1g4Pd71hwcrekakt6f405YRG6N4jPNT5c6Qom32PcZykgcSAVMAWATMCYRg3HH7wYxPCsJLmRZehsAnTbI0tc3h1vPehn5PphdaSvlnN/oTRKpSgwzy5hKvasa2avQwiofpftctCeNMdMxN0MA6QVh5mjnN3r3FV5zhU7J7EII9raigxvN6B+4wjjg5KZZeQ1sNAQ3R9IJhJfNn/GB3rBidSOQsZRQyuy3Or1CibXLq1bpvLyHzdYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3URxQ6Hm0as1UKm8B8Jijpuk6pRMcGC0GAyzpM1H7I=;
 b=IbhFCXffMHxByMBz78WPfjyn7OgwnqEF0JerVHmsmqR3igcwLPd4wM6Jh0KNypZVZ09ntI7dmh11JRh05tcXfUYYQQnrBK6r2Mqpkl+VYoe+OhDDCEPIHOL/9N1xPK3KwBxGTFHEuD6JmKE0KzyV4+kGam6oA9wIkxhnZlK5RC0=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9232.eurprd04.prod.outlook.com (2603:10a6:102:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 02:26:02 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:26:02 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v11 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Topic: [EXT] Re: [PATCH v11 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHazcKJeQZ0w1psMEaSibqAnOP3HrHtPf4AgABztOA=
Date: Tue, 9 Jul 2024 02:26:02 +0000
Message-ID:
 <PA4PR04MB9638356DED14B0491B82486CD1DB2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
 <20240704033001.603419-3-yu-hao.lin@nxp.com> <Zow9cOyMvgiddkKw@google.com>
In-Reply-To: <Zow9cOyMvgiddkKw@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9232:EE_
x-ms-office365-filtering-correlation-id: c7bc242e-d9e4-4733-deaa-08dc9fbe7a25
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hpYRpjwBuETzNFwleoXCBULzeddhjdsDhhKBdOOYzG8VoPBDMlUb2CoXRWPP?=
 =?us-ascii?Q?4rBAMJyodrbAiHqSiMhtyX/lX0/QPKNLuJq6Z+BucFMNEldDf07TJI74tDRw?=
 =?us-ascii?Q?kZTkxXb6paPftNIj0s5yriOSirAREtz4LVbzyS3/fFqb8AwcRV1H2T/uCFB3?=
 =?us-ascii?Q?tyg9rhAV2AUFCiwjdX1hOXVS8iIfNGfaFWY2CoZ+7amkxcQqmJ11p+neLPjE?=
 =?us-ascii?Q?+iEh/jmydUsM+zjW4u2d0V3UlvnhNxHnyuvi59RquyHwClZaJ4nty98dNxTj?=
 =?us-ascii?Q?+2e0zD7B9/Bs/xblKcqoKhBTszPCvp6IlO6z+xL3yU4M8T6Q8VBlYmbqR10o?=
 =?us-ascii?Q?Lh0SxY5rVCBPcwznxsaYdeQeFj0en3H+tVCcEOxJn4tyUzAbHigiISj0bcIo?=
 =?us-ascii?Q?FKPjWtaqa3CRKPxfbrUsgCfzVOrIf0fN4+i5YpP4Uj0uD249tn+O9+oG/noJ?=
 =?us-ascii?Q?4+cOb/LSdkvVGOMFgAE9K8HrENMcFHUDHOG2zdIIUIWq8u3/Vvo62x/eLY/M?=
 =?us-ascii?Q?Rw4+B5NaY8kA/T3ZhS+iJus494Vd0JRqnukjW9gPIzgO5ud82ITHZ+GE54OE?=
 =?us-ascii?Q?OfGueUrKRSRBGfbYmqoFy4rAAgwJ5k1fx031bqo0K/mLETf++XTXfFqDBAHp?=
 =?us-ascii?Q?IJaTARSvHd/RYMWhaFsDRPk61dh+JIdGNWMtgA0n5NmGt9RDbpLqeSBmBXZz?=
 =?us-ascii?Q?DGV/Xr7wT5jekSfQsbidcq5ZszHcH4nQ2SIzDH3AoSnCGkEW+6cSzrvsXffE?=
 =?us-ascii?Q?OQ+G/gkib4jrZiow3l4+tKhVtVR4xZGVEE/gMpa28CMZIJ66k8c1oXvSzbuD?=
 =?us-ascii?Q?AIuIN13FPbzwAghA3VjDOnY+8irFbZcQ0sCHQd9z8ftitijjoLHbTSDAgni/?=
 =?us-ascii?Q?5fHdr6ZnndeuSP3x3ecG/uKLhaBIYVt75i1tiBAwQzTL+TbEx+6ch/Sx69Vo?=
 =?us-ascii?Q?vFkhdq50wxDtxRgr89gTMrbx3pPnvMFsSVmddWm6fde8g9MewBmbfICFOlIp?=
 =?us-ascii?Q?BWZB4KUQZU2WUwMMW/b0B8Fqzht1Rv03BGJPIpodFIClIc8C1Ovv20xjnhc4?=
 =?us-ascii?Q?ycr1hEebfmiNvSTbNuyhLuUvTS8NeAB2tnvx7j/hHDDxD9YyIyP6SvbcH2Uh?=
 =?us-ascii?Q?GWxapsfCd97reCCqovbFaIuhhUDYOUnjr83MWjZgEU0HIGl/QRYC1XPqPN5m?=
 =?us-ascii?Q?/qti2+JKDens6fxyLZnRB7i13yBgVo8IZQ8kqGFXuKZfjy5OJEld2AUVt7PP?=
 =?us-ascii?Q?vogks76QKTW56QEFa16n+HTi4Sm5FtGoGvDKnoVVOCEq1z3HYQfBiDnT3OrI?=
 =?us-ascii?Q?BbTn7f7fEOWmKwaXKWdnZ/OZu2J8LnCRUUDxl3VTN3EgRFhD5G3E/Zud1Gyu?=
 =?us-ascii?Q?m6ylNx71bZKrgbycs/LTAamwEBuCp/NRcqkpnoV6WksKWzZGfQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?duT1VM0hscVNtO4aA1GUwQS03N/ySwdPFmseLqReMwRrFUEwXb80LqggUKSR?=
 =?us-ascii?Q?3wwFRAcsM+Ms04mj8pl2/Ewti1ZB23cif3QCWG6PrU65xCGEHpOudmEwrZPJ?=
 =?us-ascii?Q?fl5sIm9AEpW8ReETS/k+Af+H+2/76UfVHw1Qqw2OeFkQcCA2NGZ/F/nYRdy2?=
 =?us-ascii?Q?rgL5wxkzonL+rNFNtdaZ2VXNmOajeU2tp6KCNWe/09dxXp/dZ0lXNvdkc2Yc?=
 =?us-ascii?Q?xuK6g/uH8z/PRMUDcO9ZAC1ZuV2+uWPv7C0cGIUYyeMJvFFYYEgoaMv0s1BC?=
 =?us-ascii?Q?IJgJXRdo2/c9buFSZSU5WGpTcmCz4q+IYoPWUfG262VeDfPF+1uZ0JAFH4/q?=
 =?us-ascii?Q?J0yJXH+ng6LPrCiuTDA7+TuiHRxXx9Af2//i0x1EHk1QJ9+ekYvA4+WNmrL1?=
 =?us-ascii?Q?CwtMM1goQlAB8oEJd71WpSUxpt9VeCh4ACIqhITxwwrJ91fgIWxiNzHVil8Y?=
 =?us-ascii?Q?3ob2v89poi/WY2S5P1ppgZRmHKzHk4wfay8iaVvsiwFLF1QA+4l2wU8kWrmn?=
 =?us-ascii?Q?IZsjkUnNgpD64bM/sVb9Sz2nKstcF9/0rv2rfEuLahfSIKuEYzqY8GMk3l26?=
 =?us-ascii?Q?9KwzBR8r1xcwhTDMeiRy8Mk3CoTqSfofq6dGiKk9FKEsIITAYojZ6h3jZfsO?=
 =?us-ascii?Q?BxvdqaojWFrtOSp3EEf0YwaaHCD2+/JUMtTONTJ2/ONiI4b5t5oX1Hfxypon?=
 =?us-ascii?Q?znvlUj0cBltbyZf/KIMy0XlvFij5cP7GCIhtvZuWrsiu+Z6dsky1BfpBJdZG?=
 =?us-ascii?Q?EOWYh1Xwr2EnPipZQC9KlqWd4QiXkl35MqBQOAugud6GoJ9TbTMTOcE4HGUo?=
 =?us-ascii?Q?vEqJkb6cCg8xRIc+RyS9C0oSf6UJ2VWVm/zuH2aKJBDq+BXFoJaO+lTZz+QX?=
 =?us-ascii?Q?caHbuJZNbkNMshV5ApxYIIJgrZwlQzbVchSQLWnQlJg7w8PF+qAX0EeEx4Oa?=
 =?us-ascii?Q?UGXlU4NotxUCQ+8fY4EgsRO8WFETpIpp4kVrHea8LFrq20MXiQqDbEckRnXI?=
 =?us-ascii?Q?Tq0tFiXo6os+NxVdtYlSJmZBze6bnN1KuqUk364yQ0EpHs6IFakKRTMGq0UI?=
 =?us-ascii?Q?hF044oQOhNSXRdSsj30UVCkqvmeQPSEG38Hkr/sx9Rq8o/ppk0smvLwwrU+7?=
 =?us-ascii?Q?bs4uT2JYyfsOa8MIbB0zsrbvlnUfhfVBMw2kpsH155ZRQIXo3bT+zPNSGEp1?=
 =?us-ascii?Q?IgfGc2sMkop0/Q3bOuYgxIphaxWnFSvmwld01WbexFEUPvTYIhmlEgLPWUDk?=
 =?us-ascii?Q?x3P78GuvVDpIQ+AARmGWLVdA/+FrKyGdxDYHvVAH7kkmjeoef4JKMFgN5DLg?=
 =?us-ascii?Q?uQIZZuxZjdNx9Hx8R1GTHYEPAKJtJViFDu+VUoZauWxwF7u6VjBcEVV9TCXQ?=
 =?us-ascii?Q?nupSq7Y1i8E0jYDcaOgcdznVR1T5KmBbtVz2akP6hwGfNVbXs76vlJHNnJdM?=
 =?us-ascii?Q?pBUpm9/f4ASfJlUgaGXt1bUTQP7QP/p5sX3XXrh+wXcNNIaAKkYcw75I+qjB?=
 =?us-ascii?Q?Ehn9TlzJ6Dw0dK7gqPLJcovCfRPWkTHzXqWm0a48WZrJN8oRdpv8SB9gf1TS?=
 =?us-ascii?Q?EdhM/x00P36VnxfYFKV5Gdp/vhG4vLUI55OTgmb3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bc242e-d9e4-4733-deaa-08dc9fbe7a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 02:26:02.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQJVMU5rbkNaD0CwDrFICfqNtjYF6cyQXj5NGWCXCbQ4buygxZ8DEg8dLsRyGVGWkuMA3q7aemP+pLda5ZEhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9232

Hi Brian,

> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Tuesday, July 9, 2024 3:27 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v11 2/2] wifi: mwifiex: add host mlme for AP mo=
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
> On Thu, Jul 04, 2024 at 11:30:01AM +0800, David Lin wrote:
> > Add host based MLME to enable WPA3 functionalities in AP mode.
> > This feature required a firmware with the corresponding V2 Key API
> > support. The feature (WPA3) is currently enabled and verified only on
> > IW416. Also, verified no regression with change when host MLME is
> > disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Acked-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > v11:
> >    - modify 'mwifiex_mgmt_stypes' to allow multi-adapters with differen=
t
> >      setting of host_mlme_enbaled.
> ...
> > -     wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
> > +     if (adapter->host_mlme_enabled) {
> > +             memcpy(adapter->mwifiex_mgmt_stypes,
> > +                    mwifiex_mgmt_stypes,
> > +                    NUM_NL80211_IFTYPES *
> > +                    sizeof(struct ieee80211_txrx_stypes));
> > +
> > +             adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx =3D
> 0xffff;
> > +             adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =3D
> > +                     BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_DISASSOC >> 4) |
> > +                     BIT(IEEE80211_STYPE_AUTH >> 4) |
> > +                     BIT(IEEE80211_STYPE_DEAUTH >> 4) |
> > +                     BIT(IEEE80211_STYPE_ACTION >> 4);
> > +             wiphy->mgmt_stypes =3D adapter->mwifiex_mgmt_stypes;
> > +     } else {
> > +             wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
> > +     }
> >       wiphy->max_remain_on_channel_duration =3D 5000;
> >       wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
> >                                BIT(NL80211_IFTYPE_P2P_CLIENT) |
> ...
> > --- a/drivers/net/wireless/marvell/mwifiex/main.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> > @@ -1008,6 +1008,7 @@ struct mwifiex_adapter {
> >
> >       bool ext_scan;
> >       bool host_mlme_enabled;
> > +     struct ieee80211_txrx_stypes
> > + mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES];
>=20
> This wasn't exactly what I had in mind by a "second copy" of
> mwifiex_mgmt_stypes -- that you add a new array to mwifiex_adapter that i=
s
> only sometimes used. I meant something more like a const
> 'mwifiex_mgmt_stypes_mlme`, with the appropriate constant values. But I
> suppose this works too, if a bit awkward, and saves a bit of code/data
> duplication.
>=20
> So, the 'Acked-by' still seems appropriate.
>=20
> Thanks for the patience on this series.
>=20
> Brian

Thanks for you to keep "ACKed-by" tag and the efforts of you to continue to=
 maintain mwifiex.

Hopefully this series can be merged to mainline Linux kernel soon. So user =
of mwifiex can use more
robust and updated security method - WPA3.

Thanks,
David

