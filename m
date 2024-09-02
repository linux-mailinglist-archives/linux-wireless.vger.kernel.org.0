Return-Path: <linux-wireless+bounces-12308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D50967F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC071F2270F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B427DA7D;
	Mon,  2 Sep 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjdwWZXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F03C30;
	Mon,  2 Sep 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258646; cv=fail; b=VxRgsoMi0q5uBsU/LGBXGEkvf53098dUQDSyffWvf9BGPNNx8ok8edelfwWGmTCprKgyanyi8G8hU81pITPdzB/U/+5uAdjJ4q/bBteQnR4Vrxe++BHjAppANfzt09P4hyuhZPkcU5sFzcVicSp6NERqkWLPQ5XXf69MkuPOy4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258646; c=relaxed/simple;
	bh=6wlrDm1CY29XFi9mgKSHp/L+vG+pz7L9O9RKW24Sqvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEM3IcLVF9COkO/uinemfO2Ap9vg/Y1y69dOd+pr19B562RULR0tc4+MdPjrM4RCeZlX7P2vIv9P03c+PwELYa+QGSlnO2WJZ/pQ9EVlZH5hxIv/r41R6K4nCrK3IGi7fwmaFezm6/28hbd4Gf5gmKnG/jpMzmEbmCqgk1/x64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZjdwWZXb; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAqtOVKPicWjiyo601Cv9hBAGqBiHj7CBzIirWPhRb8BIAFMjnkxZr8nx59NMz8o1IYIJB5VGg5acNLacMvFwRy4VLxk54JK0RwfxOnNFm1N3ME6QPLoGooTCQ1OpwFB7Hisz9YXgSbQE+XsU5g8/1bNUiXYMnthYrw6zAGphBc61QLnzEy1OB+J5NjoONAJjKpkETiFomRWiDmne9ouh5qnLLFLfkXT5IvhorUduqPEPYa3PLDjE342cQc1qTFTvvhJtnmMGUlrgR2SqrkXm8AyikbL6ghOtvKMhBCxX2qXcyHf7JRvi8wXvObz22HofCOwzdRQSMlDbLTymUAbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wlrDm1CY29XFi9mgKSHp/L+vG+pz7L9O9RKW24Sqvg=;
 b=PKCD7Pn9Ho5J0pBMTR/uQ0RgyOXOK4G2MAG9Fa6CqGHZmS4NujqYZ60A0X7tTKrjVTrtjDzWYkVu+iu/kVokqQSek/hYOdPtrbvpFsQbzMdlI63uQvFnMX2r7Dn28gHR6Y/mdnP75IKL9CgG36KxNfdAUxlMffXzTYFbgRYuyXMt1i5jOduACqRQfb3s2p2En7fO0davfGbBhxD03hA/7bWyeCXLOgdP0xco8FeQJwSFTx8ISijIFzXRynkEhgYm7k0y32+YR/Mp5Ipq0lDRDpmwJgjvxndNkEk6U7KBdBhRGT7vhJbmZS5HG8YncvxvsGgE7mdVrgroXOq6sCsDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wlrDm1CY29XFi9mgKSHp/L+vG+pz7L9O9RKW24Sqvg=;
 b=ZjdwWZXbgKuILXC2fSctr7rEKWAIelvkn87Sl3S5tjk6ZvaM6DI+ysSYabcUDMnyk/P+WIUyVozB2oxEk6BIb8/nFan5XNH+Okd+cFwNHz9qYK6ClUHxzmgu1CIHABuO80JeyRZIzS+1cUrlENZVKEST4gHeSDUMlBL0ELhAISC9MAYnR6QCJP9xgLKeTMpqlx8uFnBJRvWUCd/SIxtJ8AkYUpgK7YmaC80W2smDtmKBlNwzWcRV+pIQDYQoCXwKFJdd0Ns7+KmE+aawEgUg/H7hvEcF1Z8ZFad3mD3Gj33AnRPMRmgPRS7fZTkFe7fCIcStfY1s3siucEzrRi3jEg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 06:30:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:30:40 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 01/12] wifi: mwifiex: add missing locking
Thread-Topic: [EXT] Re: [PATCH 01/12] wifi: mwifiex: add missing locking
Thread-Index: AQHa+Hgipn77WJqEfEGkhpgrkJrCRbJEEcog
Date: Mon, 2 Sep 2024 06:30:40 +0000
Message-ID:
 <PA4PR04MB96382D5BE6F3594D7508828ED1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-1-56e6f8e056ec@pengutronix.de>
 <Zs2-x6nuAzKvKfng@gaggiata.pivistrello.it>
In-Reply-To: <Zs2-x6nuAzKvKfng@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB8PR04MB6827:EE_
x-ms-office365-filtering-correlation-id: a47483d3-10ad-429a-5d31-08dccb18c3f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fxZoOI/0fqVYJrkOJFCmc50SwoNuevsjkveFkKVtD6uQBFyiSClygd/b0UJK?=
 =?us-ascii?Q?EHEBQMEbdmxIHI+9uvd3Q1pTW4HTZOS/tZbSEcVbSW9BuML/E5XjLYGe7t4I?=
 =?us-ascii?Q?moWRzu1Ukev3c7WpLaFlPgdgG7R4ve28DwTBe+ON/K7bsNKIM5xJrVQvo629?=
 =?us-ascii?Q?wEspAKLi+bonuK5VUfyeFvm2y9BdSLjFNdfDvOeJCffplE9Eggehjo76/RMk?=
 =?us-ascii?Q?sZ4mcWHY/zUt3Es5gZ8ud6x4JtLo02dogVmMrGBzaT2EwrRRYhaIvNm4HtQ2?=
 =?us-ascii?Q?NJdj6rapJLs7XyG81ReacpAM2dESPb+gxEKiHVb6hFnOMD11qqE4KANJjIwP?=
 =?us-ascii?Q?+gnxCFva/KNcBIUFXy0VocFqqWik9o95yTROSZNcwc11ATly1G5IgipG2x5l?=
 =?us-ascii?Q?3//xqneE+rce6pPcK+bCDbUFfM3FF/lLM2VZNmdMdL3px7lolf/rks6aUfPh?=
 =?us-ascii?Q?ZfyxtQAhQAvhXHuF/qLKR75PVFFH1eDYLSv8Vh2KrwxVfosjPU7c8NO0BQPT?=
 =?us-ascii?Q?uPKlWMPbnQBU2i+eUPu9TAc+t4CuB4QsLgFQ2lRLk/fmioYrnl28HiALYDzo?=
 =?us-ascii?Q?pg0ZzmQ1B9tYjAZ9GIorJWfexGVxxhepaUkIy1ZwiT392dNgdVtOngGSjEMZ?=
 =?us-ascii?Q?GC3q17EJ4RBvTztQ2PCOW946WOVXuDKnl9dBs5qHeFcjo7QW7ls8wRXCGW/M?=
 =?us-ascii?Q?V3RUg71eLelka7qLM9OjDBh9FxUZxPoIC7mnPy0qqqEl/ikWnJimE/G/yY6U?=
 =?us-ascii?Q?yHx+bm61OIrv0EBmxRN+XMDVKWkQYkDEln+X59ohP5DQ6dnWznsy3isIh1fu?=
 =?us-ascii?Q?WT/wdLbnTiY+2cIJg7Uh70ChuWlHgXleGlAuLHIlrUpz+5aVLkCCLUh2UCql?=
 =?us-ascii?Q?gb+15fl0FXbvpc/7G331TVlJglX68upKecbwkNYHFaCes8HT3QJugeMo2/+Y?=
 =?us-ascii?Q?WlxcCmHy6PyX5IgPH5DAFK1sLlGgpdRavdSAlumrOxouLbFxXshYAfoE2jVn?=
 =?us-ascii?Q?3vO9VvLAfhRY57AjY0a/70UKkPOFL5vRjb8yWUO706KHGp70xENO3XKnPNTr?=
 =?us-ascii?Q?M2S1APsxFDwb+zC6AnK6KJpUwOBeJUaN9zG0Dk9rscIFltb4zKqjUZhk91AJ?=
 =?us-ascii?Q?EOr3THOGgQFKEpyVnzeJ4YN5bZkCOVKGec2TiZQr3IzNwqxTq5jWFKH+LAUG?=
 =?us-ascii?Q?iX2p9x+HH46j5K49p5eCzPgfaciF03EljmVI2vzO/T+1o4TnrJP104TqheEe?=
 =?us-ascii?Q?nVaL77Y47q4j6/BUBwI9foBKWYXpjkmSpwE934AsoWA4APvHk/XaAxFhicD7?=
 =?us-ascii?Q?CAmFYa5f/wRB9dOUVsqZbP7VHg6X6q3hKRtPUJKrsxrAlb6mF/4hGXsIhhDp?=
 =?us-ascii?Q?GA4DTRdZoZkC2++S3x/LzqdjAn8S59CRe8i1rWrYY9bDj2RXCg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1Gg4vjPbWKkmDfj3L6QFm3haVFCRsPkwVOHQkgZqEdB/TLsdMgdKjBTHo7ED?=
 =?us-ascii?Q?kubi4p40sR5/GG2uaYQ3MTDoGa5TFS3w4H3r4veGVLn7QPUlr2nBEO5R2mJP?=
 =?us-ascii?Q?de3Hcqy1fNABpVys+Aifr5xlzLbG59HKSxNcIOHbjMI6CySNUOIkyoWRzl/8?=
 =?us-ascii?Q?2AQpMILTeEBzJhNF7asxTblxxOd7DDqK9whFPAlbiBK4alYAZuPrsD61lZQs?=
 =?us-ascii?Q?A82u+ZNMfdiHWkSOCYb8K1Nrhd0mZ1Z2tSVvhKVy6vx9WtzvyEgdRB4hXZGY?=
 =?us-ascii?Q?/PtkIrquSx7rHT6bTJ4GkEcPg6OuFISIOdAgtWWdXVvED6wxl+KcQ/2qekdN?=
 =?us-ascii?Q?SZBco40pMDtUoV4T+7A5avPAMwJ49EauU+uXy9j+NXoplMrUzFsUo7fdpe1p?=
 =?us-ascii?Q?K17WRAFRT95y2OUVfZa1unlFsosdUiJx5wGNRfHVhQPMX4wJYBwb9j4lG2p7?=
 =?us-ascii?Q?FF6LD46pXHRbPOA9foPDT3dx9NrShT0hFG0wG5YLDp2QaXwjHODre38mVnvm?=
 =?us-ascii?Q?DyMEszZkt5DT7X9OsztiH9Uj1n47bSzkNgc+yR2hS5ZKFFymKHlFin6zOGsD?=
 =?us-ascii?Q?we/dfZmOIMB20VBMUhFy5StkvD+BYmcsvA9IxDJE+1VJme02MRq6f06BAIw2?=
 =?us-ascii?Q?obMHcPyrojfOVLgYpDvQaQ0HvRr8tX6Xoobt/NGH4bdlnXtjxoORN8MMI5Z4?=
 =?us-ascii?Q?Y48rt3c5NS0CixSUWK3o7ZKRE842YD88WsmJ9yVzSHRHz44NFvPXm2Y8jg9+?=
 =?us-ascii?Q?6E3IDkS7IjmZH6xqBVA6wxwSsbcpFUD8JkQQPjwEvmAkCoptLlubMmJo3aqt?=
 =?us-ascii?Q?h09Png0mtVeaOD7nirIJnvmLgzumq0htKk6CRgLZpi3P+NAzbb02itg1SaI6?=
 =?us-ascii?Q?7CSzpiSEV+A3BQtucyvRy/ZJvCnMlACD79U61vkc5POZnnjca/URuMutg4nX?=
 =?us-ascii?Q?km2aqTwDYYc5oloYvYi0TShztW0KhSwrw0Wa9buu9C1rnQAngbvBci/kaUrA?=
 =?us-ascii?Q?X1CqsNrZRqV6LUrJyfKYJg+AynBaCzjrLFSi8fxGcafeTq6R34kIXktbLrJg?=
 =?us-ascii?Q?07/4aJvyrSjp8V4vP/LQJmtqviLqooFxrNJCDPXD43xSv5LtzTtXGIbwTQAU?=
 =?us-ascii?Q?AFpjA0Oh1jEM9mbkyLMtWakXYaNxkzSoNEhfCBZ65yszn8FrhjzeVhwFvViN?=
 =?us-ascii?Q?bYruoXBmVuwlgz8qt/ExzIKVYVj3EhFFKGg13LZ5Iu/dGwSA7WR+/JPUYR/m?=
 =?us-ascii?Q?ftxt5kTk5+In7cDgSMly9IB8mYUH+AHrJKzDK0RRQDwcUUANwVW2ML0+iIzs?=
 =?us-ascii?Q?xOkpLlsHGXdALO4QFWlilQ1jticvUssEAdpMhlfFkfEJJgC7wv37eIeJhPZf?=
 =?us-ascii?Q?7RA3RuCvVXDXsM52ufXlIp4Y/nZAToSQ+5yRT3qOJ1HwMNw+HKAVqMOm1ju7?=
 =?us-ascii?Q?eqKeiThrbp8EnszJTDqSU5Sq01eALz2uYXahwRe0QEiYkCmJtn0FTkU0SsBc?=
 =?us-ascii?Q?9Tvmmd74i0m1ke+YatpSpxuhWoqE2J5lp1WT6WFp/nJlELl/ddrLr10jDLPI?=
 =?us-ascii?Q?gUkw+OuWmTYVkz1mVFhdDWISJspmGfE4lKyr1u0G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a47483d3-10ad-429a-5d31-08dccb18c3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:30:40.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeMdYyhQiK2r9mS/HbXnwmBveVXgLenjXkCG0EbcLWFdPulJ2tlhEGKVrxNuRe1V0NmiYpwvKclNgbxgB0E8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827

Thanks. I will update this fix to nxpwifi.

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Tuesday, August 27, 2024 7:56 PM
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 01/12] wifi: mwifiex: add missing locking
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Aug 26, 2024 at 01:01:22PM +0200, Sascha Hauer wrote:
> > cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
> > with the wiphy locked, so lock it before calling these functions.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20


