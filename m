Return-Path: <linux-wireless+bounces-9038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958490A263
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CC01F22C22
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270B1E51D;
	Mon, 17 Jun 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FK8Egl01"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EE10F4;
	Mon, 17 Jun 2024 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590547; cv=fail; b=CmvEv94d2unOOn812HAfHbP1k5M1MxAxmAIYQXy+9TN2g896c/YjGj85ZKutU88b8hKLLLWYuzGEsmkOtAjM3tOvt//oI9k/Pd1o8IeP5uvyqDWicYP3kWMj9T85FPEY0HrSOiWsRRzplfKT45GkNmb2mmOsJgF8eTUu1j8jrmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590547; c=relaxed/simple;
	bh=ZWhmA9+TjMTUZr+g8Tfd7Hd5ygYeMKVCR345+w3KLFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRPZMrbn9I3uOV7o5/5urNzg+M8zJposJMvwlhNfakOBRsRzUoJ9D1idngblUHAE/Hq5vvMN32d2DdR/MKJnnnidMX9FYOp2/PAdlesQjVni6FIJQ+GBCVvydF+sX7HDY9uh9ZIKdS+uqozZlaYW/QAd8rNbH8VuHb7X/9bp370=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FK8Egl01; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/p4RFqWO+rIT1x2tY2tCpjzILqaup+5Mdjf+IUL7PdkCr/MsSc0ivbVn0M3FFdFHYr4PM+Mv8cdYS5EWkFPxEqlsFcXsEJmX/D404oH1E7WUdazSvuR8jpgO6rulLlzAQzQrOcSsB1odvvLETkoTVKJFFlL5jcxzC/nsbisGPfKd2HK2RVKcuiaYh7ZtSxtBrDPz8wZWztyFIoIKX/1Lz/i8V58XRA3VvY3vM+86AagZu/o3mSRY5D3mk63aJoA+yc9zi4SblFD5vofKSIiraa6HrUoTMCxIjR7e6qQRzZ0EIeYZmerftjIpFL7OI+1Z09u2oZvvD/8FHxxV0b53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIwl/yTHmFQq0bXkSV9prnhqYd+QdMRbDa/S9BbohAg=;
 b=R0Ln7UGRG5uGw0QchYAq50MaJY6UAGJAy26FXDl+2Tspqc0Ar1p1kOKfzpHAD2oqjLLOcsh3fDderazLllTT3yOM2v+TNr3rOjyUj325vUiEb/yXNbnaydqim4wiDcNG57PHOSFfDb2sUOiBerdCfaY/d9KNwTOuN1GQFw1ur+zHdBWpyZA9kbeP57DLMr0beWiNUSZgPzZyuXUZuftaY9D18fcZyncpFPXVIjTT28m3fNoEvbeH6xL24RLujC+52HEw+OePGX8jRKx1Ah1XqNPw6BdGZXiyFk635F6i0JUIphd++SPNnpGb8xyeknOESGKTMIYPd75xgHUP/b+7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIwl/yTHmFQq0bXkSV9prnhqYd+QdMRbDa/S9BbohAg=;
 b=FK8Egl01zVdoatZrCGGQIlvqjBZYXjl6Lv1LTmQOHihwfuGPuwla/SOMMhUlFsPIetxuZ9LaJo8L6tqHSdQSwdopZHhZX93Kz22SPPXTxm4FOBgRIq+0UbwvbBb9xr+UxfpyqphZQHJMpqpyAIsZUawmkossptmVd1w8hHF1qfc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8985.eurprd04.prod.outlook.com (2603:10a6:20b:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:15:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:15:41 +0000
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
Thread-Index: AQHakVah/NlfkBV8NUyUKYHJ747D+LHEcWiAgAJqJoCAAErBgIAEbxxg
Date: Mon, 17 Jun 2024 02:15:41 +0000
Message-ID:
 <PA4PR04MB9638EE40501500C0B58BACC5D1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
 <Zmmeg15YQtiChZ70@pengutronix.de>
 <PA4PR04MB9638C0A141C53CC2F5898DA1D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zmvjw3aG9j8kW0Ld@pengutronix.de>
In-Reply-To: <Zmvjw3aG9j8kW0Ld@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8985:EE_
x-ms-office365-filtering-correlation-id: d6fb4864-66cb-44f6-9405-08dc8e736329
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9rH3ymeMn6tI9gmN8PY2h15h8BpvXZd/XUgiI3lDeKSj4BCIdpLADhBD0a7B?=
 =?us-ascii?Q?Z0PhyaJWZrW5a2HG3xtuM7Jd73amnj47w+dI53cVm6JFhbHd5yazaVSyr/91?=
 =?us-ascii?Q?fJDgyAiGyrawDtw97xyDEJMraZCR2xHA0u9EX7jAa7N5tPrV6qcsvhuERwHN?=
 =?us-ascii?Q?5decp10Nv6WHA0wro08kVxVRbsUuutLTx9ofyFXuHZCE88PxG6Ri0T/uXFHS?=
 =?us-ascii?Q?Bw3k80PJl1dZRb+ibZosfJfdFeWLyZVUOgerfUBy/caxtCKibEJ+WVGcAsYa?=
 =?us-ascii?Q?fAEH+YiO0tuJa0THgfkqtnzdp1PZxeR2wjTYVORp9Bpco3FtTO/X/eeHIwIm?=
 =?us-ascii?Q?OBAyL153V2vLCfLMyLaFox1CtbmPZOAKZrq4fZ2BBBFIP6zWrmbbalzmUYP2?=
 =?us-ascii?Q?2vTTNJr/oXta78rD8jfLz7U+hxlErCmS81TnwG2bGh/35YdYV1YdP7Nn74Ag?=
 =?us-ascii?Q?/tO5jAuFdgHVKMivbNvteNLiCfsTFG27XY2pGguwKOvcE0pf5OAGPIiOlvzM?=
 =?us-ascii?Q?WeoleGRdGyO5tAQjNFrc7YRjfZM5H/mDJeSPe6k1r0pBNfKJjwf1bumx2ueR?=
 =?us-ascii?Q?StKKtsGhU7NN+OuEjXUo8lw3xNb9kwIafMDpMguGwGcWYNVx7ap98fwdkLDm?=
 =?us-ascii?Q?qqcs+RPqQvvTdiNX3AcHcpxHvYJufY1m/gYpv0lUYEbFE1M2oB2bYu0BA7w/?=
 =?us-ascii?Q?od8MnVGF7wWGEO95g4k+yzujlV1XnGiEt5CjWOn0nTm1+soybzH30Ym6+lvX?=
 =?us-ascii?Q?G/1gGVNEInaHXyr0pyjnzc7birixYL4t30/fxOjthBmPq7HdKYuUS3N88QFe?=
 =?us-ascii?Q?yOVtZ5H9XM87Or7I77dbXtU/GH32OFlfbC1IKY63k2g6BVgsmox4rmmBxEir?=
 =?us-ascii?Q?vrLiSHkUVN1ffyCeL5zXn36/WxyKYtUth4hwusNsoVCZTHG5FYaalq2ITbq2?=
 =?us-ascii?Q?ejCVKnoM+YNOVR69E8A21HOtnbBbkIsVB01Md6hHBnVUJujxMCxc8PSFF7yo?=
 =?us-ascii?Q?b6+Y4mKNzMe4Mn/0QNbfkSLELc/VtBMTTVHEt34RrRcl3F/10cSF754QfWd3?=
 =?us-ascii?Q?sPHJjz8QnPVQCYd8yHTHwqnyx/9WgEfyV8pQQntp+lPr0f1+wb+Sjyafbdcl?=
 =?us-ascii?Q?2XdHHUaMrcK9ktSkzkASgmaRpsviXeuQSj3d5ky/yO83bdAQVxu+ZUxeX1TM?=
 =?us-ascii?Q?NNr0u/KU22XeN3S+436wydTKjca2TiW5uPvsJ7UTXDqAJOYe3Z2awIC/66Bf?=
 =?us-ascii?Q?3beVliyBk4UdA2B15TLZpatxKn3UycAwfcI408aC29UT4CCrCA4MWYHk3hdj?=
 =?us-ascii?Q?oY8ye5xu3biBOlxiPhYNQJKh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g6J50hZP8eGALL2AnveBBjYfInZr4kouCsNmlDf2Xrhu4jcVLE6PYGWL8ShH?=
 =?us-ascii?Q?8Jovl17yi2BNSiBqDHoGOWWUYlaomwHZlupIXEkwXj59YFbwIZOWK2XmpRp7?=
 =?us-ascii?Q?xZvM2uqLXXKHteAnvM+JxBy67eGoZNS5OAVPcS78G5OcXHOfNJUXtbbEd2r+?=
 =?us-ascii?Q?m+bLJs09WEkjpoXBAPuot+AQWT0IDG74fyfozFm5irC91xBk9fpimUwPPEO+?=
 =?us-ascii?Q?PJruWo7qga10b1LR6uOluQ39kw1YSn2wliNdrwI/gA1gh5PU+b/bE8lrKB7Y?=
 =?us-ascii?Q?sHdkwt3f9o0M6JgHR5VccNZZvxTGa6DUIoymfPMxe+MmFw9jtnWK8M8uOmns?=
 =?us-ascii?Q?fVjyI3KrEw1ZpRKep4Zu8yBKpVUJpprOczwUbgACVyNZaIG0pdCqZ5gE9ABK?=
 =?us-ascii?Q?+cZra/o4qx6583q2FAv+jz8PffudloJU6Gq1uEPHbkFhi/M5ebk/WnEqM9QM?=
 =?us-ascii?Q?XKng4t+Ez+nS+2zN8hIdtwPyY+lgJtHoXeq7SZrdvsfrm76Mn+E9Cv1lNehA?=
 =?us-ascii?Q?iDIGs7uCOj7VvDIJJW7Bg34QV1Ke0OzTs5XaBAl4v3C/IKUqVu1nKM2X8h5s?=
 =?us-ascii?Q?aqvVTbqdqtxxyT+e4dpd1CpQNB6pWaJHrhnBxxLOks7P2HZxx4T84EedKAT4?=
 =?us-ascii?Q?pE23bfH87kt3dVF3rdVviuRKzi3A2Cw2VUEpTR5YH3lCWJB5D1L4w1X1Wdfi?=
 =?us-ascii?Q?pGdG7a2yG6xzOr8OxEz44WfFeBv/0BGpIPgBoOTVILp+OQ+cWMmJV+MsCCsK?=
 =?us-ascii?Q?QlgHt2PHPlSTrm1QqTLq99M87zEAuIhpWsKQJyIGJMZvoXnoctbLoIxWxAGf?=
 =?us-ascii?Q?qWQhKC0ceoYrQ2qLloYkRwrT40KpfLB3LbbmCfGb4NvPh/wt17RnQW4ET2hE?=
 =?us-ascii?Q?jU5psc6Orwaf9Epvn4QhZH+4uljCoyj+KqKgNn5KjSdZcJoWyW+7GGlTv83M?=
 =?us-ascii?Q?bxrwOLeJiuCyROb1YdIehfGUfEy9Wzs2dev/15Diq5IIWQGcFRgfOl7Vq23H?=
 =?us-ascii?Q?iOHwvJElSgM96b+4hQH8Cr4QDPchLOvLMm7Uj9oy8k72lJRGD4xSeg8QP51S?=
 =?us-ascii?Q?nz3PDGd1qPr3B+Gnp6a5IdsSXBPtc6iUUPg0ueyiaQP0YIfsVDn1L8bdhdmr?=
 =?us-ascii?Q?dUXLNoDGMNxWnTMD1yyCRN4WoIcgsrwn3FyTCQoiT3SyVqlgzQWg3Wr0A8KU?=
 =?us-ascii?Q?x4A7ZYAfq61GhlewJCraf9haVvbUYu0TvwdRZ+fsaHW45WRL9ZNzLj0m1qEF?=
 =?us-ascii?Q?BLIvsHWpgYf/Iry/SJGlI7xRZnpZn1J/hOqGQ+fTDwN4LzHG+ZUZok9PBsaK?=
 =?us-ascii?Q?8XqXEGBBcZK3qsaCzYpHiJWV7otSEKE1MXp5RWjeOjbqb586nGAOXGbFxQBk?=
 =?us-ascii?Q?dO0z09nMU/fYikjrRelTyzYJ+K47h+X6uNyId0O1nJ1YySW8sZlnvBZinHS4?=
 =?us-ascii?Q?ILYAXZZcjnJvE7Thm/r8HM8FNvSQjHyjnGhhGLVkSV8zGEdgys+IdmfhrEzE?=
 =?us-ascii?Q?v4TeWi+FWYlqBTbXlgiFLY2tA4eFqaUccFmadA/mMDwLkcvrrZVor5TiY6AF?=
 =?us-ascii?Q?p/v8H9336gJZjqz4h+EjorMLkLkTleOgNzEW5i9d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb4864-66cb-44f6-9405-08dc8e736329
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 02:15:41.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12rRY7p+fH8aSwQhHNK6A7ycHHWBHZ2+vjUvItIjHMaivHKV5eqOPF30EKtBXmyWH7z0EJDU1OITO5L93xj2VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8985

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, June 14, 2024 2:32 PM
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
> On Fri, Jun 14, 2024 at 02:06:45AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Wednesday, June 12, 2024 9:12 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> > > <francesco.dolcini@toradex.com>
> > > Subject: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for
> > > AP mode
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > Hi David,
> > >
> > > On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> > > > Add host based MLME to enable WPA3 functionalities in AP mode.
> > > > This feature required a firmware with the corresponding V2 Key API
> > > > support. The feature (WPA3) is currently enabled and verified only
> > > > on IW416. Also, verified no regression with change when host MLME
> > > > is disabled.
> > > >
> > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >
> > >
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > index 491e36611909..073c665183b3 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > @@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct
> > > mwifiex_private *priv,
> > > >                               bss_config->key_mgmt =3D
> > > KEY_MGMT_PSK;
> > > >                       }
> > > >                       break;
> > > > +             case WLAN_AKM_SUITE_SAE:
> > > > +                     bss_config->protocol =3D PROTOCOL_WPA2;
> > > > +                     bss_config->key_mgmt =3D KEY_MGMT_SAE;
> > > > +                     break;
> > >
> > > Shouldn't this be |=3D PROTOCOL_WPA2 and |=3D KEY_MGMT_SAE?
> > > Clearing the other flags when SAE is enabled looks wrong to me.
> > >
> > > Sascha
> > >
> >
> > These fields are used for the configuration of FW, this is the correct =
setting.
>
> This is done in a loop iterating over the different AKM suites, with your=
 patch
> this looks like this:
>
>         for (i =3D 0; i < params->crypto.n_akm_suites; i++) {
>                 switch (params->crypto.akm_suites[i]) {
>                 case WLAN_AKM_SUITE_8021X:
>                         if (params->crypto.wpa_versions &
>                             NL80211_WPA_VERSION_1) {
>                                 bss_config->protocol =3D
> PROTOCOL_WPA;
>                                 bss_config->key_mgmt =3D
> KEY_MGMT_EAP;
>                         }
>                         if (params->crypto.wpa_versions &
>                             NL80211_WPA_VERSION_2) {
>                                 bss_config->protocol |=3D
> PROTOCOL_WPA2;
>                                 bss_config->key_mgmt =3D
> KEY_MGMT_EAP;
>                         }
>                         break;
>                 case WLAN_AKM_SUITE_PSK:
>                         if (params->crypto.wpa_versions &
>                             NL80211_WPA_VERSION_1) {
>                                 bss_config->protocol =3D
> PROTOCOL_WPA;
>                                 bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
>                         }
>                         if (params->crypto.wpa_versions &
>                             NL80211_WPA_VERSION_2) {
>                                 bss_config->protocol |=3D
> PROTOCOL_WPA2;
>                                 bss_config->key_mgmt =3D
> KEY_MGMT_PSK;
>                         }
>                         break;
>                 case WLAN_AKM_SUITE_SAE:
>                         bss_config->protocol =3D PROTOCOL_WPA2;
>                         bss_config->key_mgmt =3D KEY_MGMT_SAE;
>                         break;
>
>                 default:
>                         break;
>                 }
>         }
>
> It looks wrong to overwrite bss_config->protocol and bss_config->key_mgmt=
 in
> each iteration of this loop. If that would be correct, you wouldn't need =
a loop
> at all, but could instead configure based on the last AKM suite entry.
>
> In my understanding the bits in bss_config->key_mgmt should be ored toget=
her
> depending on the possible AKM suites which is also what the downstream
> driver does.
>
> Sascha
>
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> http://www.pen/
> gutronix.de%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C7c90883e11414
> 5a307fa08dc8c3ba753%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638539435049441786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&
> sdata=3DQSbX5IuEvP18tf0t6sMe8%2F4kuHo7IFEURWabdE4Cxcg%3D&reserved=3D0
> |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |

For the configuration of FW, ored only happens for the same AKM suite.

David

