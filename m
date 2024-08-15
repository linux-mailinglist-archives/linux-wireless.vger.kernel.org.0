Return-Path: <linux-wireless+bounces-11447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E29527A4
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA152861BC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909D17C9;
	Thu, 15 Aug 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdLPhR0i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902034A07;
	Thu, 15 Aug 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686744; cv=fail; b=ck47SnmGLRCO8Wns+kZmzCTsWylxIgTBA7dyiwFSABMsYygWHn0LjNBqQuOW5Xile9hfa/6QQtrAovwXQRh/IGJmQpMuqskHKPGf4ZYxHOKdppjn4mooosfioQYI1NvEwTCSGtoWMorwGkYQFnjk+Qt4ZLUfzwW27J5k0avp3w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686744; c=relaxed/simple;
	bh=Q2COEZ4QYyVdRgeXKg03vqnJRFRxjHsZFzoBp0iE6Dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qta8v6Xbf2kCxomCmVT2KXLX5yBlTPQRG+VkAfw+e6rtYo27OumHdUC3ioVvU8znvAshQ0tRNBziE02lMHX6e91uE97MGh49md2/C1tH1HCHlQFf9chof/dd/eaU9z507heElFJE0rt6EgGOpFNkW5LHLHCN4vEm1fHPtGfwmec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdLPhR0i; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNuX6kBZhkKNtt+3qQkivx6+2+7XUAtj3Z7Yyz/KhiYZObOkKnbqKyHOnLbTU02NFzltvaJDuGTGuHAUPrhiZqSDpAr0fX2t1DRf//chrCNtf1vAbqoyu2nhv6gPzzENoQ8N5F0hdojtCoGmnqtZZafZLRhUfXOe25l52mzHhETTo3cJCY2m35+8tDjhAf6pDTZ/R7pfx2+pPWQpzIE9BwK7xEDaDt5ZKtl+U5TisqE38uke/tSykIFvteynAerTXI/U3tVE+smZNif3HYCOBMRUpXAHhGIvjO7Is7R+FJB0xseDfKHKEFrTpdzenl2wkbfnS+sZsBauINt3h3XZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt5vxusmf3mKmV9jZVBcwHZbitpGwJk4FQtbXjAmPzk=;
 b=KX05rsYb5rjRkG7DREd4lAbkIwO0s794gPoPyqipT3GJhkr/TX8YnDuJwkvy0qcg9ALqQXlw87cBdXYfSuoXvNutH7Ikn0eB551zZwQppdgrEEGbLhhmlGMonFUy/u8sXZekJr4cm5NGLe3CBS8/W/GWyFI7ib9dIf9WvTaVT0QtuVmx/JyfZbmxfAccwVSKRtLQf3f5gstb8DEbatqfHfARE9N67o6h+K/DKQTdncoAkuarig9ujtZMi29kJuYt8ZGBEdUORQruJetIjuJpl0tf9K2oS+8MLdBIe0H0+4r+3djbWIbhUhAdR4r1xAsanNgoMeElvqmbhJBA8YgV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt5vxusmf3mKmV9jZVBcwHZbitpGwJk4FQtbXjAmPzk=;
 b=kdLPhR0iYwGeRd6TuECCQ3hHvFXEaaMyuEfa1oNi5oyDOim+Wu9BptH+AjJMi+YvE5ZDMlP7/kJkNi0d+In9ezDwaZysd2Rp1m1BBgoG1HUFb4km7WOPJ1U3IOMZVX2zWiPNo9GxNWFtRfFzg+QkOG0RuM0+BHUej715UFlCIpkcFtElUH0wQ8f8MDTfSaIisXXECIJccriSAzmEMnrquseMGSOP3o3ZYoFDYDdcJkhqX0/MBImOV2oN/Fp5CmsF3PiRYpvaE9A6JHzb8VOOmd0615iB+Y1FmFUmf6nmkaaMM33Ofwr8U8cWWvQ4iegwf0WiTVI0dS+OoljeHw2tYQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 01:52:18 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 01:52:18 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Topic: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Index: AQHa6kE6j/gZp6A6LU6lI8Wv3luu3rInIIOAgAB1deA=
Date: Thu, 15 Aug 2024 01:52:18 +0000
Message-ID:
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
In-Reply-To: <2024081430-derail-diocese-78dc@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB7044:EE_
x-ms-office365-filtering-correlation-id: c277dbb1-3bf8-49af-17c1-08dcbccce548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Oyno8vUKZ9zBuYWIJZcxhVCxJMMa5yUmqUFSUJrzxBnC7z1hx9+HI3QkVoGJ?=
 =?us-ascii?Q?HVoyWcBoMhHwuofskxNzqxlMYA1511f8bnOK4wTh6hafTHRAleCub8K0emJW?=
 =?us-ascii?Q?CnE97TTdtjBTl/gcLzqvgmJTC92vpzHhuV8upYoea3746Q1/XkslpoIhyWLE?=
 =?us-ascii?Q?ZgRb+MfbyZmS21xUbla9wyAxaVQPk/eb1s5oBGZ7/zroXfQPe0M2M94p188M?=
 =?us-ascii?Q?VjYAVdFlwdt3m7as+JEULPjdbCqToE9H8p3v95dDIWu4aBI1bVy874oaFVeN?=
 =?us-ascii?Q?rG6JgXh30HrxkqNrIRH1sfBiMqaXi35AZRuztfUoGcH/HwQfjfr7PAyz4+/Q?=
 =?us-ascii?Q?Oc7KmycUZ0l292wVB3eXclAyj6h133ld0hOPb0AiUFRBgPWBgOF5AXPq4TuV?=
 =?us-ascii?Q?BtLAzDh/Z01CAtxBqfIxKsXYDS3bURIIEUjgFD1BFZoZfVdF+AYFmgpRz73t?=
 =?us-ascii?Q?fyrha5gNPSnEBWDwtPvHelI03CbJ+gwFIPy0uI+1a7d3nkm4SKRHk6XmK2xj?=
 =?us-ascii?Q?SmXXl8WjYnMp+yRIpa49qdeFVRAFwUsU6zfrphG6l5ME1y/IGyyCjqYORI16?=
 =?us-ascii?Q?RT3a3VVcs1kmdsXOe/zGLVc75C/gdmfJAY9krv8ZElOwPj87XZ8fuTgkvJHC?=
 =?us-ascii?Q?/piEPJz03/igHMKanhmgd8CZ2yR2h3XHxnhqwhvv5a8j51ZjaTdPlO8J3biO?=
 =?us-ascii?Q?XdGBXu7Tww2dzYQ+haJPtlFTFg4qJ5jPg4tcAxk3ErNbtmNQDXwow/nkEsoL?=
 =?us-ascii?Q?MWAQ9zh9nr8+ZI/QAmhU3Yu2oaXut8wQ/suN/Xx0KwXWW7UJOzug3xk0Fq8G?=
 =?us-ascii?Q?qqY+5jE2vrYDgwuVS7wlzNAudE3CLMsNZ5L7Hxvx19p/ZyJ3ccQcEaOQM6II?=
 =?us-ascii?Q?8hCB0cI49AeKD7Uuot8m+SjTcy3geju5b/vSU2ciasPDH73+a3V//3XwU4hu?=
 =?us-ascii?Q?JEtEGdPyebiyRnGdOrLn82s9kHDiyWF867IBajCHNzToBGc5qJLTarLi3a+g?=
 =?us-ascii?Q?KRfZ7XVjT9j6rKa0gxJ09eoQu52YozZIJQdsnKVtAJpYyXY4cwhqxRadK5C0?=
 =?us-ascii?Q?YZRxxL8xhTgCGyoh9WmBymbVYknmH6x41qye/OZ31MeKT2Kedu3DOhYbxjdb?=
 =?us-ascii?Q?ZKpiGq4rbmVYFbh2TUzTrDxRqluDRlikrTimEPMZdeDPzLSDj8VWgRMwUfZy?=
 =?us-ascii?Q?U2mVBA3MFiuENyzFhoT8m6NB1V1xsrl5s+/Yjr35SB4O6oP4fYp8Sl87dzPh?=
 =?us-ascii?Q?FwYGdfOHBQnVK1O4Wcp3sQPvpoTX3+Z9sY9uoTfzd9+1LK1ZZ5Nz3c31VXs1?=
 =?us-ascii?Q?Z8mKzYfU9M8TGeM0qx18iPTjAhDfE79ACTf6Zt1vc1S/KwuSa7eJBKLPHUNa?=
 =?us-ascii?Q?pq2xsloH4ZQTvng9l7FVi2hAdWX9ndk4h8DXToMrammoFEMsbg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LSRZ3yNvF8Jn6KEhNdbGL7ReRXSdGGVsOACDto2DH3delr0Mtd3/kZmhDvh4?=
 =?us-ascii?Q?UjoI7dsKjAYZzO6XSQDfIjkoljE1q2sFw/FcEcO4TpOJveduSP/0eBT2A0Fy?=
 =?us-ascii?Q?hRQpvLDTaghpqcyX5ZQZG8FAolXWuODCq20MqfwC6xmWtAG8xQS5dHBhQgZ+?=
 =?us-ascii?Q?S2v0ojCgcdaXdBKhW3UI2JqbyqWq7z2jxCy+ptmpEq0IvxduFyYEsIGNZrHu?=
 =?us-ascii?Q?jh2BYpCWvo7Kp3/W6SX97oeBF5ky6iZe9TiHwLg/ypWV1KFA+ox6G4Y2ItK7?=
 =?us-ascii?Q?cHF3FlC56hINc7Q7DSzrORuHHx5lTxnQCwCUsfHdS00V0qmr9+tr458Uj7ZQ?=
 =?us-ascii?Q?KLiJb7TP9pLuMARIcTz7HkaaVPljyeBZqbXIuLZE0uSetXs0tQOjU8uSoeHO?=
 =?us-ascii?Q?6VMPIIXmIAlJLYBBg6D4F0A6wEGGNNPBCoBTztgVfSO/4mX1xo0bVCn/gVWx?=
 =?us-ascii?Q?sd+/AiR0RkQcR1qea22um5Vigee/tMbBzFkqKHZIauchTAEPsGJFZONX/FuT?=
 =?us-ascii?Q?Vq17s64SajhIuYV1Sc7/udMXORRjcjjtA5JkAz+NK8QF6W5wiNtI1xLhO6FL?=
 =?us-ascii?Q?cX/8VVr229YLT8UkwvnCe9q/OCx2k7tHb8NxTBNqUI0GPhjSLdHy2ju7yONz?=
 =?us-ascii?Q?XYChZbXnhWghAxjKP/vupSDUiTgZ59sTFiOMba1a4/4lNLRGUftOH/MrB2j/?=
 =?us-ascii?Q?1WExZNU5eBmxFRHzEgfGE8F9NmGJ7YMogpJQbwCCx2LsYmns2trVKKcpDJJX?=
 =?us-ascii?Q?PfE03Y+FGME2JFMTbjw/VG9fph/kbIL8IND2drEl4ZBuKN+w5aOfvFOrW5Hk?=
 =?us-ascii?Q?JdqqmHHCoYZ9iDqa4RQ527gfCAdfPoCAICoQJjqcDpphrWiGh7eMSi4t5bMk?=
 =?us-ascii?Q?bzp2wysoaKTcVHIqp/GQdAl10bsJnTVq2lVfCsKPA93WhnbG4FrDtz2GU4u1?=
 =?us-ascii?Q?tMxBEemeAlWkMnnCd4bA2L7OGxoSopY7kT5Hjd9cYT87fQjRVW7IV7IWDFzq?=
 =?us-ascii?Q?mlXYmj+q1VoiR31i/iSdu2C0DzCJByXOzBKunVou8KYUYzND4rqURcuw4RGJ?=
 =?us-ascii?Q?96myjHGhYnGs6AqJVaqL5/iJAhWKsYEjqfIuAEVU6QmccF5M+vDWEnfgjsU9?=
 =?us-ascii?Q?TpaIKfYUbun12gALicitLLiG+L12xy9ayVjZP/c10ugcm+KakBV8hpys27gJ?=
 =?us-ascii?Q?ndREqLDnoMJbXfueE0RnFP6t3/wKkF6Camol/1iaszyOKSLsq5eXYGPCr/uJ?=
 =?us-ascii?Q?t7vKXGvPysSaZXhM/NFQKY34ETqedCkRX7xM8qf6jCRMvpYnjleuQse//ey0?=
 =?us-ascii?Q?LEfHsXCCHNVvnhJhxU4jBVJaBoXZVkDbC6bztPS1V8g6zVACMqx6jHqtYd8P?=
 =?us-ascii?Q?cVNebrBeiDR/QOr0vUtkiGaDOJUGSUc1eGPfNnr/hh7AvvsLyUgEXvr9zg8x?=
 =?us-ascii?Q?vsuSALTsggBbHqB2yUbUezdU14lCzXADKWSJPN1Bei8ny3XP5Z78R8MGjyHj?=
 =?us-ascii?Q?AU4lZdKjxy6vFwQC3PcjHd+K7Cl9JVgYtclVyDDcylGk1rlohzsUSumGvfQs?=
 =?us-ascii?Q?0hTh1ecK6FXK0kTNixseB5OnO8IvjH+6VVhGHX2e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c277dbb1-3bf8-49af-17c1-08dcbccce548
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:52:18.5618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUdczvIzcTnXJ2sWlK4RptKoYIjDGu19xx3j3e9nOrDd1zHlKZz50JVtvexps+18t6leJ56DmWXVfoLubplLWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044

Hi Greg,

	Following the guideline for new driver, it should let every file as a sing=
le patch for review and generate a final
	single patch after reviewing. I think stuffs mentioned by you can be got f=
rom cover letter.

	If I misunderstood anything, please let me know.

Thanks,
David

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, August 15, 2024 2:48 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; johannes@sipsolutions.net; briannorris@chromium.org;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Aug 09, 2024 at 05:45:30PM +0800, David Lin wrote:
> > ---
> >  drivers/net/wireless/nxp/nxpwifi/wmm.h | 78
> > ++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h
>=20
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him =
a
> patch that has triggered this response.  He used to manually respond to t=
hese
> common problems, but in order to save his sanity (he kept writing the sam=
e
> thing over and over, yet to different people), I was created.  Hopefully =
you will
> not take offence and will fix the problem in your patch and resubmit it s=
o that
> it can be accepted into the Linux kernel tree.
>=20
> You are receiving this message because of the following common error(s) a=
s
> indicated below:
>=20
> - Your patch does not have a Signed-off-by: line.  Please read the
>   kernel file, Documentation/process/submitting-patches.rst and resend
>   it after adding that line.  Note, the line needs to be in the body of
>   the email, before the patch, not at the bottom of the patch or in the
>   email signature.
>=20
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what is needed in
>   order to properly describe the change.
>=20
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.
>=20
> If you wish to discuss this problem further, or you have questions about =
how to
> resolve this issue, please feel free to respond to this email and Greg wi=
ll reply
> once he has dug out from the pending patches received from other develope=
rs.
>=20
> thanks,
>=20
> greg k-h's patch email bot

