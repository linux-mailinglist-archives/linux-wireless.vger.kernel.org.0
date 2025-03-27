Return-Path: <linux-wireless+bounces-20894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957BA73A58
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 18:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8BB3B7981
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCD18CC15;
	Thu, 27 Mar 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO2o43DU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD581DFF8;
	Thu, 27 Mar 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096417; cv=fail; b=iffRnR4g86rC84K+HTuBcF8rVE9WEGGniOOIhUDAs/abY/KxdkufavgNdS8N6sSo7jQdFJVFk9s9LYNyIJ0cmsccHooT6eF9Qgf2C5AqCuqj+cSw5JhOWVfIW0080dCj81hSQ96n6/XXKa2YO4lRifJforHrASs4BKO8rtUVnjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096417; c=relaxed/simple;
	bh=xJ2XZfHkwh3VgAKTwtUFor3jQWZFofBRZWg21Optbss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kenp/szaMc3e5RY6WknjGjHKFzgdJav+jC1lgC/ar8qADP7C/bL6ItkyfdTbUjJa/AWW8wwAIQf5F8LyLoTPCcv+UOerGTlFA6Nk5W8hsrVYMZtYOxyCiqUAsptVYmPug9HjSuUscf4gQE/bR10swKzfZxvmMe2bZHDVKwSLgaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO2o43DU; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsmhVOoimsGXE0lQg667NZYQ7gi/9JtaxbPaR8B//Jtzh9FbBzRo2Q4hG3iKmTq5rZjsGeofPXiIoDJZCxWASNZMGpwFPxU7SxRIfrMaOR7WzNSS+peNlpmQiCoSSZnjdMhlJi/KTIGc1c2muw6FUAGFvY5y/RQSl/YgUfd43q4WfGG3SMlrOtgDn4P4MlWVVZ0qXsmNfR3AONU7FrGVziOB8U0WMKQCiUDQbriAXduugzWPyhu26WkuLr7egik+9fsRgne0lf7EPNJyWAWSFDPSJTHOQNvIQ28tYsY2qM6Q5JvERDaqfjQAozT3xTOjx9TZr/E78ySxAfxJF7R32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ2XZfHkwh3VgAKTwtUFor3jQWZFofBRZWg21Optbss=;
 b=KA4PWtG2y3tRRGYMwChVVc7kKBqfJdjltNoVZkKkh9pQsnasQxny0xy1WTYqaOegIEOedkytq+NBoRnDWI+swO8w4E5WSqh1cdp3Vsaf2JAQNt2Al1AEaG4OFQ/8hKFqW1utXv4LMh9+89VN2Veh9dgS45lst7COAc1xuvNfsH72K+l+UzqqLhttbdPZBPOgRV+zzkjF7iBnazbS3NkGqtHsxqaEf0ea8nGG6V/+fE6jPXAkQ2CNPIlNnA2FPsRE968hv4wXLszmB9YI2Rd4rVUmEDG3dtbsMEDlnev/vzerCGSRR7XdFQuliBikyQ6JB26kYQTBFYpbHzRkDTE26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ2XZfHkwh3VgAKTwtUFor3jQWZFofBRZWg21Optbss=;
 b=TO2o43DUuyng363XADHn0lOtrHUZ1nukATbQ2X/BKtpyo8VNe0/P4XBvlKOQn6ltEc7EwzkiXu9CGu4vOu+Vm4E+T7vrFOcG3BMAQTVjrArn/MCF80Q0GladmdLVmas+YgpWvS3o3yvY2RL58AwC9QwAHwIz7uQddRNaGDnHmv+RaiQM20p96nr1KvBJGchLomTiaL6kAfCgmDR42tg3xIQGGylnq5RR8i2t73+eDTVAIzeRCjxBvC12BX29L9owpTxFkyM0fF4X/gR5b0Q4wV7QS3bQU9r2xWXvryYBWntlDuXd88Ar8mZ5QRfCd/MznaVlZ0NftbWPrbz5zS7otg==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DU0PR04MB9695.eurprd04.prod.outlook.com (2603:10a6:10:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:26:52 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:26:52 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	<francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Thread-Topic: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Thread-Index: AQHbl8PMECehi6j1KEedBcEe9Ioz87N6qGwAgAlvj2CAAUrEAIAAM7+AgAG0ChA=
Date: Thu, 27 Mar 2025 17:26:51 +0000
Message-ID:
 <PAWPR04MB9910A3CC13C8B0F0674E3FA29CA12@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
 <20250319162842.GA46894@francesco-nb>
 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
 <Z-PwgtSRNoCd2L3z@gaggiata.pivistrello.it> <Z-Qb6_1-sTZ_LTPs@google.com>
In-Reply-To: <Z-Qb6_1-sTZ_LTPs@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|DU0PR04MB9695:EE_
x-ms-office365-filtering-correlation-id: 118332dd-ea9d-49ef-70d1-08dd6d54900e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+i20OwcF4lox1cU17aaxuMS+2/IchfuiVOLpCNszlVqar0+3z4zsYhSIVUKU?=
 =?us-ascii?Q?2Qw5+F0Qjvqwe2RujfCrd97RbvEroQg7Tl8UvZvBO7pvywZaCoqe51Nvnf4B?=
 =?us-ascii?Q?bGSko8LloDOQ3+cOe9lV6LSZhAKVVNJF68DISl52nsFrpXg77/EpX+amZJjm?=
 =?us-ascii?Q?7sr2nesw5Avp6O8WYdKTvhkhXf/EhIZX3kHu4fxpIH7u2rclpbisfjaxVqNs?=
 =?us-ascii?Q?k3OFAsWg0IDISGoyx9NZXIvLtUEHaiuXal/gIaVw895oK7KvsC23ePYqbYcb?=
 =?us-ascii?Q?GSH/PiCzi8/ek9bMnDumNht5z/W/rs2ol3magzxtb1ceqMwJkdPe/BoL6/p7?=
 =?us-ascii?Q?dq3kyEROukTtQxHEtdEdrz5K98dFVCZqGn5RyrHsSx39Ji+9fe9Lh5fbqKMG?=
 =?us-ascii?Q?C1pXmG7ODRZdpoD4azgTTCvZU7YLso3qgl2A/N65Rsti6nq2GO3SMaWOZwml?=
 =?us-ascii?Q?PpAwzAMnRJA0eYIP5/9SsSehskqKT+KgLMhNhxOs/qqdR0rjUIfQOnLvlhaS?=
 =?us-ascii?Q?wcFMZ/4zrQdiHtlyFvIXMV7GexaQ/nweAJ8+hpJy/fNTaIpPogiAy2nYdieD?=
 =?us-ascii?Q?nQkU4/eLjsbeyGKat8RBLviOTHCX+0irnoo1fL0W52Lw/8GQi80CQKGrCHo1?=
 =?us-ascii?Q?dbLJK5TriD2GHpIgCFzFd/Av+DO6VR2EmTq8mS0mBOk0hRBVE+/TSU2dmjL6?=
 =?us-ascii?Q?n6rPuDfergsM02WeKIoIsIGym8tgixASV80j5xLJPJ23F2Q9NAYZ8Kii9sx5?=
 =?us-ascii?Q?VVmqIm8FOSS1/cP2Mog5Ro8FhHZx1LV0Bo7lgoWlSYV5KlMNtZ+IihEb9Qws?=
 =?us-ascii?Q?qnebvF2vdU8jiyTE8S9YSnisSrRFMaHodfWE0qhAyEXm5d7fHflXRbQKrh+Y?=
 =?us-ascii?Q?+3KoEsCvRJKTWnzeyUtbqQgf598rPHWRiUtEKozmwZ2FteglkVxoh7NMpcnj?=
 =?us-ascii?Q?wpCJ9OeqBkE/ZtWGqyhuWQgN3YV8HyJtMEuHZVbqTGnNfujhII6BWu4r2bW6?=
 =?us-ascii?Q?8KlscsnOBGRUV35qyRfsl1gK6LDcv6c8oFuXs4lYpNiqqr5OMgMiwU66gmqc?=
 =?us-ascii?Q?C43OL0ro1LZh8/KssW4G2r6g5ssRqa1pqg6Y5BMdpai4N6EoGmJE0zkt+v9Z?=
 =?us-ascii?Q?wB0n76HOOUC4OvY3W2O4W7yVdaG2he9G75P4EInnj8/4gnBQDoQhOWigq0rj?=
 =?us-ascii?Q?f/FUhMfXUjqoAi4rxhd1uWKAP8lkOx0E5nBRWPHp8q0sVyGsGXLLIRHfWAaK?=
 =?us-ascii?Q?cBuasME6UHKAFGDQrQru3C6/JTT2NSCiZ6OXXQF14yGLLJneEssoiuSZ58EL?=
 =?us-ascii?Q?90BseS921aeHv6IxKFGwuXYNsP2vXql5OFc11HBRViZGm2oG3JoHCMjaLeMg?=
 =?us-ascii?Q?NBnLp+ZlBLWAN5DrKjtLt1aAIYuEX2AXynr1vChf0RENsRDZ344FDsH9zk/V?=
 =?us-ascii?Q?GXqlm/04/0AyT0qFQ3KnWzyXkN8w52uaEXeqohNpB2WLxm3Hs04XGQ/PO8WC?=
 =?us-ascii?Q?OWjOht8esrLOqEI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NHKaNDclGB8203kIsk7OAIanZ540EsdfRXrLRB5zcVXYPqOSZt58aOBzGg9e?=
 =?us-ascii?Q?v5gokCvRokQeto6B8r1RoDUW+IODjsNYSc8kg52x/7lorDqw+nAS3ZlsYy1E?=
 =?us-ascii?Q?YAI9PGrTDtNcZieZMw2P2IDjnGMa03xmAfPR16497RyLSQDAdHq59S6s+NdZ?=
 =?us-ascii?Q?1YErjYcHrN+cUvJ5eg3M6lynKNW3xX1ls3HvakPCxgidV/XEbX6YejglTRLE?=
 =?us-ascii?Q?EUOvgf5FWZ2kFyPTRQ9JFSXNiIk3zeZVEQUO6mqBnDgWgu2FJoG8g+m3ZQcP?=
 =?us-ascii?Q?Y5GfbABANhVJx4J4WW550upkZCFYu+7Jxll1/A6jaNTVoq1EXrODDbH8xqYS?=
 =?us-ascii?Q?7OlxC8PH9Omm+RJBS20lQLVo/yNb4b40GlrLEOH8Vry4DlbHjoJEg7oroZwV?=
 =?us-ascii?Q?3AL+/x7XT8TZaYbQQf96n3mjRH3yXcbvi/b9LstNziQT9uFT/jHCQFGGwDuT?=
 =?us-ascii?Q?gdiVRbWSONUAtpvdgZ47G0QsQ2DEuOthbPTXGLsD/02JybmUF4SQo1/dVYcN?=
 =?us-ascii?Q?C2ITmckdn9sbLH8ETFsFcl063CrA65iiBseSMZ+DcocUKROiJr+KqqglLobD?=
 =?us-ascii?Q?UESAGZVBncJlCOxJ9Rit149pswGjKuGpUmQEGM2WlKlvWOXSJyTqGmeHIuKG?=
 =?us-ascii?Q?m9msbMwTKSCt5XQXtJdmlyrQVpbZj0T72R/fCIx5QcIb4GChOzVOV5phZf8/?=
 =?us-ascii?Q?89qjRPABj1VfCx2mFDIKeesg0CwClsy9Gp7NaIxWEJL7MHKpls4TeUU79VQY?=
 =?us-ascii?Q?QdTgDCesElhwO+ABSPkJG1xQ9nMPdNV3SDy3An38w7MKhO7jIeNCb7X4s6dv?=
 =?us-ascii?Q?IthIfzXQulIqQmqT5S/WcN1bguskZWK1XARtaNaXVxVhQ+8bTRR11dPMv59I?=
 =?us-ascii?Q?Bkpyka5DNu7snmEPJUvDvruAV9vaCHU+zLQwuGchDkUtaNC1EVcu1dUGrzoC?=
 =?us-ascii?Q?qWvvY5ELw4IsmN/EAEY49LaFdAkrHedbKa/obkKfg1BfJx9Z4ZI8cPHbmqUP?=
 =?us-ascii?Q?dVbXZNXk4hGyehAxpNc/EA54AoDmbajIbZqzqPuQDquyC8Ez+X7HQC2aIALl?=
 =?us-ascii?Q?8dTmz6KfvA3cktAaYr1KP2lKXipwJUx3xMVBvhe9RbNdP70gVeX1/EPu/GTO?=
 =?us-ascii?Q?3I+u1n/Y33iUdDW6H8E5MYPbNzqbNWyWfnjEnR+3oW3vZjhBXfzCq9Gs/A/g?=
 =?us-ascii?Q?5jvqUF8/v/N5QRWCg/SEQd59NrKwljpGBmuLQ2NNR/74iZOvub/ADSIJMeVB?=
 =?us-ascii?Q?t+cnnbhYkocTae7yKu2vYBWNWMOu/LqZ42VVOHOHj+Jnsz6oRdMkRRa1PkAU?=
 =?us-ascii?Q?bIm+LA/S7Rf0M166kbuXbTukDYe7T2SjSIdGXzKb0I6fhHy3TX8qfOiHCdMq?=
 =?us-ascii?Q?oomODoWrgkvJCJZ+9ipGeym0mhQrTO6gE07CvYojTZ8McFugxPUVuSrg2ukO?=
 =?us-ascii?Q?COHM7ZYNYUCxgRXfPTk4+rv7nsXFzZEOzqQA+Gkrx+lCPCUsm7biPuGyJ30d?=
 =?us-ascii?Q?kllIYFCa/uXWlcjltx71pPpZrzRyIZOVadMPONZqmSeEO1pmbMfeirH8LxEe?=
 =?us-ascii?Q?GbXz3MLnIP8wElIlmNbq2AqB7Jo+lV7fTwVibEtD?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118332dd-ea9d-49ef-70d1-08dd6d54900e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 17:26:51.7883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR6Z6QfJhlGhrIA7tUY1PWmOAV+pFNukA4OG6R5Ntt25+IPUGwA1/xXz1bR1rXHRl6ksyB1/v1HM6JFIbmKosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9695

> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Wednesday, March 26, 2025 11:23 PM
>=20
> On Wed, Mar 26, 2025 at 01:18:10PM +0100, Francesco Dolcini wrote:
> > On Tue, Mar 25, 2025 at 04:43:33PM +0000, Jeff Chen wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > > On Tue, Mar 18, 2025 at 01:07:38PM +0800, Jeff Chen wrote:
> > > > > This patch resolves an issue where RF calibration data was being
> > > > > released before the download process. Without this fix, the
> > > > > external calibration data file would not be downloaded at all.
> > > > >
> > > > > Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> > > > > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > > >
> > > > The code looks ok to me, however I do not understand the commit
> > > > you selected as fixes tag.
> > > >
> > > > From what I understand releasing the data before using it was done
> > > > since the initial commit 388ec385d5ce ("mwifiex: add calibration
> > > > data download feature"). What am I missing?
> > >
> > > Thank you for reviewing the patch. You are correct-the Fixes tag I in=
cluded
> was incorrect.
> > > After re-examining the issue, I found that the premature release of
> > > RF calibration data cannot be reproduced, which invalidates the probl=
em
> statement for this patch.
> > >
> > > I have decided to withdraw the patch. I appreciate your feedback and
> > > attention to detail, which helped identify this oversight.
> >
> > To me the code change is correct, and it is also merged in
> > wireless-next. No reason to drop it because of my comment on the fixes =
tag.
> >
> > Brian: are you ok with that?
>=20
> Oh, sorry, I don't think I really analyzed the nature of the reasons for
> "withdrawal". Yes, if it's just the Fixes tag, then reverting isn't even =
that helpful.
> I'm fine with keeping it as-is.
>=20
> Brian

Hi Johannes, Francesco, Brian, and all,
=20
Thank you for your feedback and for bringing attention to this discussion.=
=20
Moving forward, I will work on improving the process to avoid similar issue=
s and
ensure better maintenance of the `mwifiex` driver.
Thank you for your understanding and support.

Best regards, =20
Jeff =20

