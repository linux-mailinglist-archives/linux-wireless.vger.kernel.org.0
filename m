Return-Path: <linux-wireless+bounces-11926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EE95E6B1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 04:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EC71F21720
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA14A33;
	Mon, 26 Aug 2024 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OOmdbURR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1521FBA;
	Mon, 26 Aug 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724639465; cv=fail; b=jd1KHiz5udT62/SKcVdNG1L5UXaed9Z9dAYy7lT4cXuyAVjnxgXzw12Dp8cWMHKxODWktRiOeyK00j3qY1EndQwbMTLw0FuUM7+xaUssxB489wZKqJXeYrRXOl3qB+QwpgVC2nkEdBxCiXuxDiam99zKwWrCiDSHs8rDZnWL2XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724639465; c=relaxed/simple;
	bh=HjI4XyQxEZ/oHjaie+q3bFKo8RwBYUxN0MyH81rte30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5FM4LB+eZViPz9ZYr+C80AB1C58IazSrUZPYFcOjxH/Nvwk6Do6T3BEFbpw1iVXFFIVwJvXrvLRH0Z+PNNWyWtw4uD0qfVCZ9v2EfLrg2C67ijeV/4SRdwYGYuCiGhRQzOZ4yJYz63aaGElnUie1xmeS9+RqJUY13qoMjj15PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OOmdbURR; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUd1KQU/tQSHa7hLeFfbQ5Z0BRm0FUCMbqXqo3i7jb1RpU2QaC/D9LsOvIXulvO3bg7T329aY7IN82YjPd4a4ppQb5HMaUxVD+1KtEsZK60NFqhosq2uMu8tD9HlLKkhJs7IuO9ocBhqZ84W0DiHUJcRuaXn0wjzTLkAhAuG0bzFFnNOj7GHKHbtAC9RdORnq5jfL/Oi1ePmdMMmyNGoBNGm6wSvbZsaA2WQRQQ0bqn8mkrsbgE1TMXbuRiq5XCwweOK5u6YVTV1WxetyhNUXClOZ1stGIzwSkEUMnbWhPZckNLldA9E2eWcdLISRIbrz//zAcPjCg1pC45KyZFXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE4TcJNY/Rv8/8Fxvfd325mN0Nw0AkOu95CuqXmq2k0=;
 b=dbb7wcZAlwwIAKQ076WRu5Vh+7QF5Kinp8M46AeficqgUqk2L8FMcoV5mxKHH93GqqcMNtnPvZbRvxMMiHcts5hn6NwW2wBCqCOvHxcd4+bHXmd1qQJZD4klZqfU9hGk0SyBV6GuHwnYjG2yNlkdB1Wi9rsk7Q313ErQdl2d4avKikfbbUOPKQtR4ZoMCS6pTmSowYMVboZlBwGINORAIegK92g0vNJagdu2kZAWFp6LfnFdQiKHU7iIyIXsW6kT6l+444KN6zK7fyJ0ctfbpFUUefTqG9JE7tsYa/wnYoVhzYXKDX2NVLoiEs7DrwfI0I7xXWhfXM6QVZ2wiFA5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE4TcJNY/Rv8/8Fxvfd325mN0Nw0AkOu95CuqXmq2k0=;
 b=OOmdbURR9OYLB/D/65kW69wndmpn1aZ7kyBb3eX/RnB3QXLYrkfObvVK6s7626lgBhYpLaPdUi6jeS5kxYpTep4HXJwfhbXcC7+OuV/TiMgqzwwyHR/EhqdBHolZ5UK8oCDAeFrmSw9hLDNCJknfRqCl4osQcLhg+yjM+POE8DuyIbAjHNmhqt2SfrnZhU53pyJXiKWJPH63MO/MSlnqFFZzcy/jI0RlsXCd5+q83svaPc86i9b8eRA+6UGCrK8qoLE32bQb1lV/FPU1YnEWTAiWMZ/wPiRmEepqXsEzSn34SZzp676z8GxzFilWzxQSt4erF9JbKGDLKBMldEpdGg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 02:30:57 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 02:30:57 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgAMzQYCAAmHlEA==
Date: Mon, 26 Aug 2024 02:30:56 +0000
Message-ID:
 <PA4PR04MB9638376BB62B8ED8654F4AF8D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de> <20240824134839.GA21315@francesco-nb>
In-Reply-To: <20240824134839.GA21315@francesco-nb>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7149:EE_
x-ms-office365-filtering-correlation-id: fb361c48-9444-4c6f-94ed-08dcc5771db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EkSPonuqfRYD7EmK5iLn1ei/6TyePVuqeK5cH7ala72sxZklYrpwoiFZYeTk?=
 =?us-ascii?Q?PrE2t5y0/pSj233FeCj2ObrRPVLjnjigmdUsH1yQuefOFw/YHpAuZRuXevDL?=
 =?us-ascii?Q?DpIk8VPT7nAQ18v1TF4IheTgno4dia1vkUagxADF42cOBI8q8E7kFK4ur+Ix?=
 =?us-ascii?Q?9jA9GPvd9XOEoJuYcve4e5WRblsLP16ELWRpwZi0gBmoqi+tpHTiBsXm8PUC?=
 =?us-ascii?Q?fAs+j5VHdWc/Z9BLbLpzIi09DdrLWLzTjQK4AWliMIeWPSsJHNvoBIcbKpOf?=
 =?us-ascii?Q?o+kQram5ySw4q0Ln7sLXE5V3porKeD3EoxNjlZhFNDgOP+kFbxDGYI4+4dJT?=
 =?us-ascii?Q?sBddWZoq1MqZO6Vm03Dzj9Dk+s5zkTaDpRjpoxYEwFfNxsfcvj436SZGPTFt?=
 =?us-ascii?Q?h3gBodFr/0Y0ZsmZO2JjfCiDVtsu/hujo+9wjI2F2GSXyZMGL8ReCCuRkoK9?=
 =?us-ascii?Q?Lkj52BXPFfwKlSceanCV/UfpHyDFBTtIa/Lo3IayJCoKpaI05PXQUfQVnmBY?=
 =?us-ascii?Q?JAtT5bJ41nDwxNN0KNmGXN0K/NjGGllq9usdx4OT0wCper7/Sq5Hn7WyaNEV?=
 =?us-ascii?Q?ehR0oWLzkZUYGd/O0Uxl/3luRvxnC7Ud758LNDZOd4B6xX38UjkafHte9z0j?=
 =?us-ascii?Q?p6OkYg+mz6C35rHDaJcIJijNp1XhAQTmzR2C2LNeGRyNtBL74+gaaRpz2p5N?=
 =?us-ascii?Q?XK5BqsGdsFhZ2qG+8GF5dGt9rQRjgloj2EnTwjd43X51kOZaXdS5FUwT7+J/?=
 =?us-ascii?Q?QXHKcxHUG42G1IlqWY+G+JgrQtdBJrQ5gk7b108z9m/pjpDD+M2DUFScuVZ6?=
 =?us-ascii?Q?OY2NQW5KD8IQ8Fn4Svbtqmavkuy5yZq23euBZHKzIkYYPpWaO4m5x+RcPxQb?=
 =?us-ascii?Q?pcBoAdCMtKFfBy2+jUZWmdj50AoNVva8nzMdRo2Wa0T4y3BJb49YMhsPeJc1?=
 =?us-ascii?Q?z+6Gh+hCW8qJac1S346tGpDcMQjj3NdUJh7WUqF0Ug8FWvQJnj92xfjw3XC6?=
 =?us-ascii?Q?mFqUlC1RKNKzhLQVaSwM6XuGF22nZe62S0dJxqlOqgp+zvvywFjC9MuS+5eJ?=
 =?us-ascii?Q?4OBRgqASBCGLSwLBusO2VozvI2JGMCkWS4yca+YsNZLtgGoWcaodoQyPT1gW?=
 =?us-ascii?Q?n8SynQEjqmF6SA0lcN7+fBPQG800SYp61qsf9DdQpYvZ9lfW0vgC5KsngcIS?=
 =?us-ascii?Q?YEtB0X4r6j58ztnbidEHvUqnMqCA3tkoB7GmSIpZnmncmYbB1pNWcN9ZbLkE?=
 =?us-ascii?Q?Lj43U8Pu2SgF517DbRS0qjg+7mWBFHkjMZzyHiTUgmPn9l0pj/YrbyhCu7ck?=
 =?us-ascii?Q?OfDxn3W/sou8HWKCc9abgHeHDNyz0pdGUFzrKGY3qbz72EKrgkZcFoBT4f3J?=
 =?us-ascii?Q?dnL4ruEhN1vrzQH1GQEr1ea7E2M0+WFj14lxbU3y5iBYjVFS5A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ouytOSqu9IaZ4t+3e1TI/zxw0EIyCN0J7M+VamR/Y/3Etayw9H/op7hPo//r?=
 =?us-ascii?Q?/BQvYJxZuyO7BBg1nmTQve5OL6R2DG53t8U2oByUOVAWe6ASuDG81hoDFIe5?=
 =?us-ascii?Q?lbtJaG0CPwYH+Ikm38SsKEgFTTKSDvi6dpJX5hHR7g9zesRAMSkrhtsrr5JE?=
 =?us-ascii?Q?tLS/XDsIRJXb+QxXtkMEt6cqOPn+Y841TigShfn8ZrWrG9T40Z6ZlwhMPY8B?=
 =?us-ascii?Q?WYi78QwsBl3gkjmVSY0miyn9G6iMl0F7Lndl5PupTo2XFZ3ZpUJ1c3543pLP?=
 =?us-ascii?Q?NbdyfgzmEusA6/T3C+1Ksycc0O291SIHA4lbyNOQt4VmpBvssyPfL4TG2Bfu?=
 =?us-ascii?Q?LTyubO8pIyupPELK8L7SRvSchh0/5XnlBj8xGOmHZXka4tw0ROMvSLImaXL+?=
 =?us-ascii?Q?5vMkY//nvv1k21EXC6eg/UDa/iH7omnW8bJaySQseWkUhCWZO8YcvQdZ3i0z?=
 =?us-ascii?Q?oKpvGf4LjlfktOKVSpLByOLvAxM5caahCkNLJ6ieDSFaChoOVGADU+ikjVuP?=
 =?us-ascii?Q?i/TiHEiiMI/1K3//MKwZThnB/2eH1pu0IouKpF9DH1SGbR1w43QD4RD6YpJN?=
 =?us-ascii?Q?TLpOeSov6m5VQBIMbcJCFfLWi0VrZFVzqxev2UipMtSD5u2XJXPPOOigliG3?=
 =?us-ascii?Q?49EBz+xjhp+cvJjt4uNsjGJRbIxtw+F5xXfCzeurNxQSFjgty5rhPKbX3ZfV?=
 =?us-ascii?Q?LSFNW6VB4Pn9jK4zCmH9TluNWZzJOd4af0TKc18o4cwZixViA2hDpV1PMCR8?=
 =?us-ascii?Q?SGKE5YftHfLSO5bDG72riJMtW5g+mD5UVP9Vnue4OSRg/E7ksBDskVDggql5?=
 =?us-ascii?Q?ZRci7MDA/YuMUYMgGLDJconYxGTGjl6c4jH4G29FQocI8ZnfFvYLQ/w9xawY?=
 =?us-ascii?Q?Q7pcnQwPkJgxvCwsHkSucRJ95CSx9GqItvGd3rMvY8HimpUsNL9HIh72Sqag?=
 =?us-ascii?Q?GuUK50siCcfMWLI6VRJiBXRs3yYiYA92N6SzC5NbkBOL2QW02hfWQvGwi3hA?=
 =?us-ascii?Q?XAHQbIQYQccB2l6LKDouy0oY9Ungv5WciQJ5GgGK02uefyaJec0AmQ7Ngzuj?=
 =?us-ascii?Q?T4cFSJ67Vr7HkDXwf+4YFCAyDuWwsb5Onj2pnmEnFG+TzZlFii3LNejq02WV?=
 =?us-ascii?Q?jY/DIpwXm8XZBwgLxykVvh0cG1CH+svd3xkAPmLx4UtzU90LnXAhLwIVvxrT?=
 =?us-ascii?Q?D6VoYD3Az9dCyekvNhG8tclmFgDK+NTW6cvvJOa1WdZeRqC/fldba4NlblBr?=
 =?us-ascii?Q?emfJ0XVKpkLwqSi59kQEeNk/sqJKvDP+DKGDr7E/hEKFFNXhK78V0dQ1qrY8?=
 =?us-ascii?Q?ffnW/rrvVLNkeQBk5QDV8dNNV5MctX+B5BBtWGkOGxZA4Ex7lmqAibPMG8iA?=
 =?us-ascii?Q?nXH1peSlevPWXWs40jGRODLgG+yyK0iI7bkARTua94482XnbqgY2OFRRPhMS?=
 =?us-ascii?Q?4LloadQB1CshwmF3gYrOSrN/SZTrXNHyKEvR2ypJFAyUewpYle+hVdcXQ/gv?=
 =?us-ascii?Q?av9Ys4plKTcUJwm2nJs5pFf1+By5GuXFUm1U/FUcyLmkHvQOSUdCvRyjIOPs?=
 =?us-ascii?Q?G1zAhCexPGy3LV//2KUt8AUdT68tFMxUty2vcYLm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb361c48-9444-4c6f-94ed-08dcc5771db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 02:30:56.9182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIx/eccUkQm54QayVg5FEbNbOp8Jb8znM3BzIfczWJoBnUW8+gVHvF0Dg9y/l/Ljo8uawOcgCo7ofikHk1dW3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Saturday, August 24, 2024 9:49 PM
> To: Sascha Hauer <s.hauer@pengutronix.de>; David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; johannes@sipsolutions.net; briannorris@chromium.org;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> kernel@pengutronix.de
> Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to supp=
ort
> iw61x
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Aug 22, 2024 at 02:56:25PM +0200, Sascha Hauer wrote:
> > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > This series adds support for IW61x which is a new family of 2.4/5
> > > GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and
> > > 15.4 tri-radio single chip by NXP. These devices support 20/40/80MHz
> > > single spatial stream in both STA and AP mode. Communication to the
> > > IW61x is done via SDIO interface
> > >
> > > This driver is a derivative of existing Mwifiex [1] and based on
> > > similar full-MAC architecture [2]. It has been tested with i.MX8M
> > > Mini evaluation kits in both AP and STA mode.
> > >
> > > All code passes sparse and checkpatch
> > >
> > > Data sheet (require registration):
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-bluetooth-
> > >
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C6d7cf356022443738a3d08dcc4
> 437
> > >
> 926%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860104128552
> 0681%
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DZ5iuaainSgM%2BVdUBh
> AK4RHcv
> > > vERhiw3yu0S5kRKsldM%3D&reserved=3D0
> > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetoot
> > > h-5-
> > > 4-plus-802-15-4-tri-radio-solution:IW612
> > >
> > > Known gaps to be addressed in the following patches,
> > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > >   - Support DFS channel. This initial patch doesn't support DFS chann=
el in
> > >     both AP/STA mode.
> > >
> > > This patch is presented as a request for comment with the intention
> > > of being made into a patch after initial feedbacks are addressed
> > >
> > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > >     FW architecture, host command interface and supported features ar=
e
> > >     significantly different, we have to create the new nxpwifi driver=
.
> > >     Subsequent NXP chipsets will be added and sustained in this new
> driver.
> >
> > I added IW61x support to the mwifiex driver and besides the VDLL
> > handling which must be added I didn't notice any differences. There
> > might be other differences, but I doubt that these can't be integrated
> > into the mwifiex driver.
>=20
> Maybe you can share an RFC patch with what you currently have available t=
o
> support IW61x within the current mwifiex driver?
>=20
> Given what David @NXP wrote here

I don't think he can add IW61x to mwifiex without issues if the code for VD=
LL is missing.
Without the code to handle VDLL, command timeout will happen when firmware =
requests
VDLL from driver. This is new API which is not needed for the firmware of l=
egacy devices.
After this modification, a full QA cycle should be done to confirm the driv=
er can work
without issues. If you try to add these code to Mwifiex, you should also gu=
arantee the code
won't affect existed devices of Mwifiex. BTW, adding the support for 11ax i=
s not a trivial job.

>=20
> > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > >     FW architecture, host command interface and supported features ar=
e
> > >     significantly different, we have to create the new nxpwifi driver=
.
>=20
> David, given the code, he should be able to highlight the limitation of s=
uch
> approach and hopefully we can find a good path forward?
>=20
> One of the challenges with the current mwifiex driver is that it supports=
 quite a
> few wireless devices, and any new addition must be done in such a way to =
not
> break the old stuff. Not to mention the "Odd Fixes"
> maintenance status of the driver, quoting Brian: "My only interest in mwi=
fiex is
> in making sure existing hardware (especially those used on
> Chromebooks) doesn't get significantly worse.".
>=20
> Francesco

Yes. This is also one consideration for us to create Nxpwifi driver to supp=
ort NXP new chips.

David


