Return-Path: <linux-wireless+bounces-10168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8692DDFC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF61C2122C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46533D66;
	Thu, 11 Jul 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ort/wogj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677323CE;
	Thu, 11 Jul 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661604; cv=fail; b=FhzRBzgl39fLMMlSfx9ugOkK2TbA56jDtIChgAJCGgOkfEYKKynP4cvYmGdD6OsRoWCvWDZRLRY52c0OKKZzn9vucfHUcQZkLyq4XUpI7zutPEVUmVLjWUiBSUvcg3dV6Cmm80zj4JntBmRT0/WasZBI9ssT+dfZOr0VL7prLBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661604; c=relaxed/simple;
	bh=kLOkxGCMh2fdh1wKWJ+oJcX2M6FmLR6Y3TEjecbcmrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnppgPTzPeTgbH2Mf9fsmWZa6B+8Gs+WFy+qDMRTOzavD4TdTPb+JvuE8lx4wLqb1lEa3Bqc+ivzI37xzMwFuTxL8GUDEt9cD9gC4Y+arYpU+UcTTp9et4oKdULc5ga4mKm0GL6Z9arsbh2SvaieTLfVHCiZ5+1uqwQRJ8JSuF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ort/wogj; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3OIYvoY0iCxkkA2/5PyhTxtvRoXtC5kYXJJHYqyvK75G2OPlwrbkSBfRwp2lAy2WP0JxvPhuYQqmFHCGf45I9/a0dZ6RE6VCZUBM+lS8U4+XuZcWyYvNX6Ny+Hq6ca+kTm3Up8nZ82HHL1trblb1svZebORIvE7nzsgGXq69390fnxZcrXKvQ5CSBh+wsYZKQL3GpjuEnZJVym45os1qtIP69sDbwj7KKYtsNeXV+wXiyMPjcSwZby09jHvrYaEWqD+eoyM050NNM2fgsaWF6kC/WMD9kp0ie/n+XTtmwL/eICLw3Kam77Z/Oh9+QFUCCYA/y80nTsX1sZhE6DF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLOkxGCMh2fdh1wKWJ+oJcX2M6FmLR6Y3TEjecbcmrE=;
 b=lExIEhpY4cThpu/6e1wAhKVmjMB2NWTFncz1yb4ps7zdoc3eMAG0w+DslzRupKkhaq3zKR4iRQcEuD2wBHI7otUBQJR0nwAaZue6YOt7WrthaW984686hYpUa8kiDy1l4pVwkTR6KNAEZz2Qbt004lx3/lJ0knRFYTBYC+OJXQqs5JmPPyr4p8+9n+Bh3HtKqx8HxBOV7HnKdvh0WkccYNJ/0yG1B1kEYoFcITlCmZFEOcDIPwvEGoqC95UAHOIeQvUAUzOKVESizxlbHXsocL8yKliICQKzMWsW4Jtrb7oLWnXzlMgstDJQGiF7rznwGJXy0SNVf1GUG5cQjHIT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLOkxGCMh2fdh1wKWJ+oJcX2M6FmLR6Y3TEjecbcmrE=;
 b=Ort/wogj4zHtTS93iXTNnIT0C0ZJTyXAqMYUJAMtF5a+LI4DhhYxjSNHvZ0ehAoOqfr8LjIvSyzMwd5W0asxDUDm/zFZ31eDD64U5Riv429DOtm8aI3nD16dtvtpTEA+eGcElrrf0RqXpTby9hqyh2c3dGHh63b8rpIij4B7xaY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 01:33:17 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 01:33:17 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Rafael Beims
	<rafael.beims@toradex.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v11 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v11 0/2] wifi: mwifiex: add code to support
 host mlme
Thread-Index: AQHazcJ9oDCg+GgGMkqUSOf86PFchbHvOSrAgABqRqGAASV5UA==
Date: Thu, 11 Jul 2024 01:33:17 +0000
Message-ID:
 <PA4PR04MB963820FD55F250775FB37C84D1A52@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
	<PA4PR04MB9638BD3D09017A786FC3DAECD1A42@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <8734ohn08x.fsf@kernel.org>
In-Reply-To: <8734ohn08x.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB7569:EE_
x-ms-office365-filtering-correlation-id: 3d995fb7-414e-45b9-a6ab-08dca1497076
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?keGMtOcQoFUWN4Jmkn7u08H0eqWrmfL8Lzn6xpwsfPhmIxYxSxlcMsYNmWNp?=
 =?us-ascii?Q?Lv0Iw0b/Da/77XH3mJFS0Mft9+4YYCacFp0LWOD8jj1Ki6PT1GM0LH/AoDn8?=
 =?us-ascii?Q?cqa9Gfo0+fZdeQ7CE37LnhMk1Z+pAr+g4nonc3ahtJ9Z+mhYVb7wNvMi/E2G?=
 =?us-ascii?Q?GXwLFk/aCjgLCzNp8SOsNU812ZNtv5wwqH+tr+amuzwcfGBYPC2SYwe9htYt?=
 =?us-ascii?Q?r3MEi856DOlb3VGGZYMsMSJF86g03RK3MKfNsRewuaU7mAFomuVBkNP/Rwiu?=
 =?us-ascii?Q?yzZvfDEpsFVxyN2pkY6OiJE65D7/VxG9DceIh3GrOi6ZnoTlY1ugVXXGPxLN?=
 =?us-ascii?Q?yP8X9c08oIFXDZUVieSZdj27Jl5p4VLtQqYgP4VEsGX2JRd0if2YpMyZp9bs?=
 =?us-ascii?Q?R74jbSgYy02BjSgkR8lHyqKaA2xBI+xMqISfrTnBXiKbzEDg6fJWDlvpgapZ?=
 =?us-ascii?Q?WfjyyjGjBVNN+mXcFjoWrW+GMrgLDhUFRbXvPOq9pR9zA0rmQQnsokIf7Ki3?=
 =?us-ascii?Q?FUpRMKyYRLpCRA3cx6pBYiQud3vAj1yudLBsbYcCTcXuuXS6v7BZU9s6Wp5V?=
 =?us-ascii?Q?84eGgRAVNMbLQVsNIznHkBhbN3xxPPIha6JjeGacbEY/8YNgdvHP3fwIqXMT?=
 =?us-ascii?Q?g3YNe8a3zO1wk1XrFKkWSVdrAjVLMEadTTXmnq/pmQ3sjrDrxDAZdzqly8Wq?=
 =?us-ascii?Q?gVJiqgGPyzEnTlHSB8EaQ/yolTbjjx7c/9KU92mtHaK9ISnI0j6VFK9u5BkH?=
 =?us-ascii?Q?NrKkaykGJcMtNJ1yNsgfcqZJbHOP1oauIJl9I3uaI3y3S3YMmKeomU+XVzBr?=
 =?us-ascii?Q?gVjN9vihV83CCp6p7VM8Mph2xgir5FA0XKHBsuO99uYogNW+Y8Fngjlrp5tL?=
 =?us-ascii?Q?YhiNlyinDrY52mYzjtpKf7omOS9vOyMBib+6ZO+hq+1rInTZjeE0dl2YtP2C?=
 =?us-ascii?Q?0rHw0D/LoMMJJMLdgqiDb3QB9hHa6lC08k/tNhTlbCwLUV+STWhd4iFQp9f7?=
 =?us-ascii?Q?KzxeQnkEACdH+7QYOqSyIJ1AaTrWu2U7/a5SZIU4HbOFhUAWacN4CU2rrxBY?=
 =?us-ascii?Q?6fPR9WnMxCV71w/MIhepUGUkx8dJ+O2jzfAk5Za7Je6lhDjvlQGkMceO9o8S?=
 =?us-ascii?Q?WG+kis0q+ipTgkHL7okdmgTprUT6EVyKDHgOYJ7zS3uZqax2R+29aqnkeTHH?=
 =?us-ascii?Q?lXcruVQj7Rd5rdhwjwtveegc+RR9tKR3kSr/hj526KMURlWVQMn/0KirxSLe?=
 =?us-ascii?Q?9jSkARW08LJ46UnUVvX9mSelWvtVbFZKLTT9vefQ0HRWa91ssxU1lbyqLH65?=
 =?us-ascii?Q?dpYTT0/g0wPh9ewKHUoP4chCuAAF0j8GjTt8HO+HMTfyrT3TRTYvEXJQ13X3?=
 =?us-ascii?Q?4UPjeqSzMlSxbhE7Nv7oxDwady3MNE5Vl24Brxh6RUdzSrzosw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hWgZg/L/jAnLT4B9YrkW3vG+Z6phdhENqNHvsOfdGlSsELzTQzpRtNtLPFGe?=
 =?us-ascii?Q?PF5HYqM+gRhEWH/1fxX+P7vZTIQuLB+E1Pc+i/EjtHBQ00GCdn8yVqdmtEhR?=
 =?us-ascii?Q?aQ9JX3EwTvoN0wutIF3MGn/AVMEZOasKdG4GTnr/XJLZxl+IL1hpX1EDCa0P?=
 =?us-ascii?Q?hFVe5jTapkS9POjP0E0nk/86aYeiUFN8TYil3A/pgGWeq1aNhwQpQhVn1dXY?=
 =?us-ascii?Q?npiDb7PLlVOMZoi6IRqXx9qTj1VZRq8nX+QxG+I5TbKWOUMjScJNoVmkrteS?=
 =?us-ascii?Q?XraUUbFizwHrpQ00FaEzDHsq5xomqG+eB2UUpaLaZxY0MpeMe0dJ+GONSDgG?=
 =?us-ascii?Q?tBUeTowPHUXVxE8rT5Z8/5HXxr8R0KWT3iyfQIoM9kY6a0MtNgtkCT8JoR+P?=
 =?us-ascii?Q?/7HKQNDJcSbZ+ZYhlOHMBngB0Ck+mrQyF+yhFzxYES82o+zB3Z4XXMbnLHFP?=
 =?us-ascii?Q?bKQa/Zk4uViWntL8H8V3ey8Z5Kk8XYlg3cNgcGkeKAs7SjvpQrg86dwkh+lM?=
 =?us-ascii?Q?F4Y0GVzdpSltXC0nXk3/XMFsCTSUGldhC5+YCaLvCcHPcqg3/payif1Wr+gA?=
 =?us-ascii?Q?PXryTMxlKs4dn+QN8ApFoHf7yAf+0N2KTFQRmIG+JTK8a5b+vU5xh59DqMNt?=
 =?us-ascii?Q?frD2ik/4WLrXwT9L7g2o2hjt5JH+v5UYm89qXipYnZZXSaAFluujC/ruXh1t?=
 =?us-ascii?Q?Xse1+DOJaxo9rFjIqZfRq26fxjfyJTXmaSAKz4B+4VhhbNxk3QzsDumzc4Oo?=
 =?us-ascii?Q?b9Ynk2lyDtyTUNv9YpEEvV8rgfgTuE0+fLABLMTYEbUmiqE/YR55Cpaknzot?=
 =?us-ascii?Q?mabb8Fewi/bDk4LdOI8CVysEwtZyrmFIMfWNdeH+JE7zBcSpeQr7qWDAeAvz?=
 =?us-ascii?Q?70tMQ0heUV3b3z8gcuv5r2Myi/YWp/uii30iHrCwHXnczi7B3+ST8MTu79jW?=
 =?us-ascii?Q?CxB6R4I2qEuq7KFyCQQTFKjpYqVYckI/F82cwXrCxipIeX5aPsWIca3XDmGM?=
 =?us-ascii?Q?wd8sLxcg6PqHI/4+4BlUiIkOhqE9eSaeV+SqthfjayF9ewUeGK95JjAU0xH3?=
 =?us-ascii?Q?VbfCZ+vMgcNu60NEPTQ3NEVpEgvCRxdJszGBjJvAllkH3pakvfoDK63VUS/A?=
 =?us-ascii?Q?WHlq4PucOHGaUHivFdpkRuymRCnZoWmnWTHQvFHElz9mNefBdjZ9TSIE6dk4?=
 =?us-ascii?Q?EOFwHhJAuBHCbzuuiJKCXY7z0lbiFYACYjbQpyrt6wcgj1DsQp2NAZkOHPiU?=
 =?us-ascii?Q?975IO5AutbqBmBlop2yOYnbEPXegpLP+PyXk2/KS6bJhq3PrWfhDGdsbWVId?=
 =?us-ascii?Q?f3l6Y5fKuE1DYmmTuzB1sCX6Z/L+BW9QMOOK3l7roRORtoWOemOh/gT+lP6/?=
 =?us-ascii?Q?mZf4khGT6FbjXxqTYf45TrAsrtgM+AEDIztO0+c3A3frVv732F0uwlmxqsBo?=
 =?us-ascii?Q?vJgksCPPuYshoqW/RAvF04dObwVtmbLXKxEOJ8s7JLlDRHbGrNkMKSCa1jFR?=
 =?us-ascii?Q?p+UdFgqOreveelMxYB7+koMNRpgOV4CmBa+Y05BxMNyE0h7nbuTyMv3K146p?=
 =?us-ascii?Q?q4RrT8fPWyCde7zf6Jk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d995fb7-414e-45b9-a6ab-08dca1497076
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 01:33:17.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chRiI08JS+k0zABcXi0upEbdCHw4hz0fBnmfSFYKZXk048634qLHrurha/7Frxa6mL+ll2re6RM2f1l0A3fVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, July 10, 2024 4:02 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Rafael Beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v11 0/2] wifi: mwifiex: add code to support hos=
t
> mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> David Lin <yu-hao.lin@nxp.com> writes:
>=20
> > I found the state of this patch series had been changed to "Deferred".
> >
> > Since this patch series had been reviewed for a long period of time
> > and reviewed, tested, and acked by members from community. I wonder
> > what else should I do to let it be merged to mainline Linux kernel?
>=20
> Most likely the merge window opens on Sunday and I didn't want to apply t=
he
> patchset last minute. So this has to wait v6.12.
>=20

Thanks for your help.

David

