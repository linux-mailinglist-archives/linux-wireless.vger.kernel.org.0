Return-Path: <linux-wireless+bounces-9037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B690A25C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4922AB2147A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDD161310;
	Mon, 17 Jun 2024 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ftz6hUx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2056.outbound.protection.outlook.com [40.107.7.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8A16DED1
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590408; cv=fail; b=pOpO8kFf84VcolD+06fXbAz6AL0oygPJtl+UrU8Df7a3d7e1HyTaBZ4Dnt6evCcdgrYyl2slfa8wOJ0VjVBEFRWHsQR8JljrrbU0XyM26hm918TI2WFTd37lgATpoLKfEl0r++vpcpqyAwbf/rq2P2r0N3N3UAIaJFpf7/WADPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590408; c=relaxed/simple;
	bh=ysPm+S3GzYW/lif6rAcI8lMXZdpMPzDxSrJU8urH9dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rk50LEjDNRLTGhH15nRFZ5TjpjRzMVIw0y5VqdGf5u7XsROubhdNiYk6BhZPo73nrIpPrAg0UjcGllJk2XS4Ff++CFkno/bbgRXVJNZydEetFq+cDf6zzOTrsLxOMHA0Do0ssbOYNik/YDt0/pfWopR8P9tr0ffGXgeWiRsBgQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ftz6hUx/; arc=fail smtp.client-ip=40.107.7.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0Oa4tvl43vn1q28tY6cmFgbNzgLj82QzWi3h8d+XshWwFpZ5D4Pp6+qgtT84FZloTSEBIbcLW9EpEIzRT54sUuC7nq42GPh1FvYUq9xJq7SqyAA5+ekXM46WFXkZEUgColb1F3VNIGRAjc2ziP+vA3VEGWpISiAVkzZ3ZuvjOKYMVJl9Dh3zLUivULFLG3IZ5knqtylpAtLVYjS0neKKMwxPb27L/NrcSgVcI39s/1pzBW2Pdk28yFuaj2r/bkTD1FaNjxOUmQ0X1BHT5GRndgWTfMlJHDx2G8Zwp0xG3jpMVQzf50+HxWwh5W4T7Pf33ax4VJQ73RSwCTJHtNLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysPm+S3GzYW/lif6rAcI8lMXZdpMPzDxSrJU8urH9dQ=;
 b=idN/cO6HRotCJzI5MCyhTC8pXqSlfM5h+Ws8DIA8x7C9yODhkv5Yt2fMqQOs/YMoaZxIDgGzCdxdajGc/dElUUmkrzcavvwkSDlK2yqCrL75Y2V+Io2jMSg9WbcQYSPLSvoPRdeqqP9icNgiUqvTqRBgTQ9k8B+CAg3DNi4/V0mnG6ULtovd7n6575uQDudgQCTIExKU7RojEUpUn+1PxgSO5YG98FV9X+ucAhCEHKv4ZUdYh1PbNo+GNsGhkCziVOkLHRUZqp8841ofMuCJRfcrghhg4mlpT4bDOaEpzRWnVcSwORBMeF9KfZZay7kII2J4hbJ6vWFgwcy5Uhl6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysPm+S3GzYW/lif6rAcI8lMXZdpMPzDxSrJU8urH9dQ=;
 b=ftz6hUx/F5Ju78SI/T4+KNPkfZCk9HvLHKlLVHpNR/42aLkyBKKYAMbVsr8Ld8z8hd1e4mbQ6cwH9pbK+OSrHg3ROySdvblyhwIEAYoDjQkSLLCapawG5R1HAYOG6L0oA9iat564QmKgu9XEZdSZg0YRqv1WjtRfF0rfm5et45I=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8985.eurprd04.prod.outlook.com (2603:10a6:20b:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:13:22 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:13:22 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Andreas Kemnade <andreas@kemnade.info>, Neeraj Sanjay Kale
	<neeraj.sanjaykale@nxp.com>, =?iso-8859-2?Q?Tam=E1s_Sz=FBcs?=
	<tszucs@protonmail.ch>, "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
 firmware git
Thread-Topic: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
 firmware git
Thread-Index: AQHat1bOPSOUO29ybEOlfcnXcu6hCbG5UJGAgAE2jYCACObh4IAATECAgAeOVTA=
Date: Mon, 17 Jun 2024 02:13:22 +0000
Message-ID:
 <PA4PR04MB96381A69AD86ED9C9E4AD9CDD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240605160013.6bea8d4d@aktux>
 <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
 <20240605174709.5043af8f@akair> <20240606101839.GA76158@francesco-nb>
 <PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZmlEny2W0nArOf1T@gaggiata.pivistrello.it>
In-Reply-To: <ZmlEny2W0nArOf1T@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8985:EE_
x-ms-office365-filtering-correlation-id: 22a7d6c3-1b12-47e1-f47d-08dc8e731026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?2+a7yFWQLDbJi0hsJzYi1eq53L5G3JpDjU46tUc1trXcvIy9CZiqjSkjOi?=
 =?iso-8859-2?Q?cYbXBxW7luKZV510D7hoT/PmHs6ez8lJFkuWO/AYSuWQZTZvubgFFwvAbY?=
 =?iso-8859-2?Q?5mW+lK7CEasKuDOXRYQfnYkPsK93EJOxSnQ8Kl5HlUpJ1FCqmcE7kcUNOR?=
 =?iso-8859-2?Q?mV20RH0bCpIN6289FEwLPIqEUZsUOXzGo5GenEjwzWimqcsURBhlw9bSC+?=
 =?iso-8859-2?Q?Dn3v0pnYr6BAYnHBM7qe6By6CSB9sFtq48aQaJ4ztFiFYM2fgAbvP9huJW?=
 =?iso-8859-2?Q?CD9tfh4424LXZtAXJhYH3ikkDyBq42qBl8EFlIKoicWulxsiI+txbjf9nv?=
 =?iso-8859-2?Q?048iijQBKT3lwlpNCkeacJCN9ITwKRTyZ1XrQ9Ngix4X6HEaL6UgZuiar5?=
 =?iso-8859-2?Q?VLlvnZ6ILOXv+8Bd83CVG655DiwYSo8jb3QptIqJzfNaIomA+oB5t/5K1B?=
 =?iso-8859-2?Q?PJlENLWTRtO+8L3g3TDhjeuVof0rXwUCaLlCSsvUc+tQXZepb7Irw0vSou?=
 =?iso-8859-2?Q?iC8pfS6uH/dV4Cup+MVSKMMrwcey4aK7gPSEStl4MFT+hoFoyn74hcuSgd?=
 =?iso-8859-2?Q?ppVUtPK22dWkYdAbMCMTq6q4JoVlYIKy55it7liETEZhf883HWqAY46BBY?=
 =?iso-8859-2?Q?dIuDPQBIOgiEdK2DdHWBoJ7GPl4lLukywKy2jKrVTtSbawTslf5YScp+2k?=
 =?iso-8859-2?Q?xXkdEu3zGx9PW/SQYOeMaY/xM+Rs1ivZeVuoKB0v89/kSIyFlI7SOKc5aM?=
 =?iso-8859-2?Q?ksPfLv4T6KU2/EjYT8K1SajuTWK7vQ5IPE+/K7LTWrqCXAfWulIZ4FfHQh?=
 =?iso-8859-2?Q?trwYWY8z9FYd89tzEepVrB3dJsSwQwWf0HtCkmvNR88fa6Te/eQMXHYmX/?=
 =?iso-8859-2?Q?/h2so43UOojfC6K2uq2IrXv3RJffOvzT8y1ppy8bcUmqXXhnVW6WSK0J42?=
 =?iso-8859-2?Q?ZMR3WSJUC6yf3GXkJPc69gDmi/38avaj8u7usTj5vyBFvzl9GKyCZs2dos?=
 =?iso-8859-2?Q?+RH1zF3qGjSTFtFG/4EWsbjOZMtIP7+h4z7yZJH1S6CY/Gx+mcOpsqe3CV?=
 =?iso-8859-2?Q?9HHmf3nk+jLcVh96h1vdRYu17b9R/8H2Zavy6fYFuD+OAq2v0yUQSvj9VX?=
 =?iso-8859-2?Q?q7e3/iIMslOnraqL2v2GgOlmWS8qcPhNVQYjP05A/j5skeLmGWfSRcTvII?=
 =?iso-8859-2?Q?ftPT2CQ9LmbANduoU7gfPNr6L2pXE199uMFIDo8n7qzdnlRUX57/rg+FM6?=
 =?iso-8859-2?Q?hsG7sxog1UkAcqn1G4Nz+c9JK9ItPiTH5itUEE+ZofZ1yOTENUEXpSmxjR?=
 =?iso-8859-2?Q?Dq/qrt0CajKMCuWalavizZNCO53EQJF1wfIr0tv7PmiKfUnA1aaV5UCCEU?=
 =?iso-8859-2?Q?A3/+j6Rv8r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?jvGG4MfqvU9G30nL7JdPIYTJrV17QRFmgIFM2/GxNzZfZLf2k+enkV6kem?=
 =?iso-8859-2?Q?YFWpKdLVjLAu+vnYajOiMdaXKVbS6wQUIvvr8WOG02ImP5Kgj0qji+8Pqz?=
 =?iso-8859-2?Q?GaaxrWbJNvOm5+Ea20/COxNWrIRwQ9zmQP/ROgUbdkW12dO5n25ipB1rfv?=
 =?iso-8859-2?Q?mdd/FXInR6umkMYNAT4cp5ncIGBgVzPFa5yB+pRfJGFHJKYuJzdpNTldbQ?=
 =?iso-8859-2?Q?eP52yZ4K6tpV0ubLBs0uIi7fZXDjBl42eyFm3jqLqEHRuWSzPFGg67eUxw?=
 =?iso-8859-2?Q?hgOqE9yXXD2/Mx6cMS7n4z30ku7FdFzLY1v0IFVgrnI5QDx4GFOGBNlrED?=
 =?iso-8859-2?Q?OfKrK4CTyHTF8zMT8FRiZQXjLVElei8Taz8CdbHk/g9ZFv7mYxDhMYADnW?=
 =?iso-8859-2?Q?1jTyx6ZMiyW8Al6MzL1R3o3nEdCi4Wh71+amtqx+vkMYUQFj+Fjq2SX8qJ?=
 =?iso-8859-2?Q?3R1LVPu2DcrS3dKSKjvn3tq2mnUGcdXv036Pf3I2F670diMmnsBE6Q0Thg?=
 =?iso-8859-2?Q?ovNdVCv4pkG3TDpXukgOiZ6EDdNmVDAw8C3pcuOtiw5yZ1HQ6VG+FaHP0X?=
 =?iso-8859-2?Q?MlLxn24xCrmbzALa1ymnJCY2CbaXcYBXoV7krKV5yhk1unXVlJiFoztpT2?=
 =?iso-8859-2?Q?+ZDo4mKOdLRrTlFSz43ScbqyR5SoMp0+K7VxltXA3zAzs6J8UkiMyjqz25?=
 =?iso-8859-2?Q?/mqEvaX/yRLaF6kcWYb9wD3GI0cC5W4fDgtrhtTuQyjbkT2qjb9Llct1pz?=
 =?iso-8859-2?Q?teyN9bS88+ICakMuJu8p2BM36soVp5r1cdO8I53DZU9kebSEQPhghh2GLs?=
 =?iso-8859-2?Q?Z8xsgsS+pggEaeubZp4WdDy1KoIAsN/acG5frZWcYopKdSTq2RHy7gCFaI?=
 =?iso-8859-2?Q?VZ3pX/uxAJGFCFrrVsYhsPVrxo7d5+n99FNkdlNNerYGG0AVbHjXXvYFN/?=
 =?iso-8859-2?Q?6kUCDZfY373tuKdh9MFzJO2p/ZoBvhur6gPLRdBHi67CXrRIF6iewXs4GY?=
 =?iso-8859-2?Q?OmBrv6dOcf7ZlSYN4cd0vZl58v0ZgBDr0K6yKpT16Ru6JaaKxn7X4nsjb7?=
 =?iso-8859-2?Q?sxrcEW+OVmWwmahRnzy0VoGsba2fo+atqOWd/kLXWcogPg3anSZQzjiuBn?=
 =?iso-8859-2?Q?J6SUjj765weB0u2arSiOR19rx2m1rhk0HLja0IphLRN0VefSaeat3ZHSLB?=
 =?iso-8859-2?Q?20m6D+VyGsQ9yJ7TymieNF2+qtscjYH0ZJ7+G82uEFwRvFsXGWz1Y8DUqV?=
 =?iso-8859-2?Q?HIwPIJ3B9d5hlH9mVBxuuhj3wUhaZ3i/wiMRv7XDawaxNgeEbsMDReqKW6?=
 =?iso-8859-2?Q?yPJegJFhQw7QQ7vbaGlvOH7LjzNVXDpIETABdmVepJ3UlS8l69l8YuIuXl?=
 =?iso-8859-2?Q?qOMYszZtgFewzfHi9LzN2whVMtk7P7ZbOxWM/wQ5vOEg+PwEE+FxfwFczP?=
 =?iso-8859-2?Q?w8mJWeMBAF5ZukQBAIGLQQsvf+dotZU+JsViNRZjpzi+z1PBdeIxjRbRNk?=
 =?iso-8859-2?Q?MptK9kyVEWlOVVepegleS/kPiuemNP5C6VHMcO6HAaSEQSlvE5RYmaI987?=
 =?iso-8859-2?Q?//CsD9FTGsUwu5vjQ2q1swdM4eTMFQDE8M00LcqYV07QU3QdKyJvgrUBuH?=
 =?iso-8859-2?Q?EM1u0aQ/fiCBdvcLQkMLSQMyc1EdEWSb0l?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a7d6c3-1b12-47e1-f47d-08dc8e731026
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 02:13:22.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTFHrojiysYcFa0nkoOmSR3mJnLXg1P+68LcSQYGWd9oUS1bk8LvqRyhybugboBL8Qgo7VCE11r+LAaN3XDt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8985

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, June 12, 2024 2:48 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Andreas Kemnade
> <andreas@kemnade.info>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>;
> Tam=E1s Sz=FBcs <tszucs@protonmail.ch>; linux-firmware@kernel.org;
> briannorris@chromium.org; linux-wireless@vger.kernel.org; lukas@wunner.de
> Subject: Re: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in=
 the
> firmware git
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hello David,
>
> On Wed, Jun 12, 2024 at 02:17:46AM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it> On Wed, Jun 05, 2024
> > > at 05:47:09PM +0200, Andreas Kemnade wrote:
> > > > But that is all legalese and I am not a lawyer... Best is of
> > > > course something officially added from NXP. No idea if it can be
> > > > done otherwise. How to make NXP add something?
> > >
> > > Would it be possible for you to get these firmware files added to
> > > the official linux-firmware git repo?
> > >
> > > I am not using sd8987 myself, from what I read in the thread
> > > probably some file name would need to be corrected (I would say in th=
e
> mwifiex driver).
> >
> > I am not responsible for firmware release.
> > You can get updated firmware from
> https://github.co/
> m%2Fnxp-imx%2Fimx-firmware%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> m%7C10acf638ebf04b0979ed08dc8aab99d5%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638537716818815780%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3DZrU82HbKZ%2Ff87IG2tgInfq7kbyCuV8PcksxvTWiM
> HtQ%3D&reserved=3D0.
> Yes, I am aware of both, and most of the people in this thread is aware o=
f the
> second.
>
> I was wondering if you could facilitate within NXP having these firmware =
files
> added to the linux firmware git repository, where they should be for vari=
ous
> reasons. To whom should I write such a request? Can you help in any way?
>
> Francesco

I reported this issue just like Neeraj did.

David


