Return-Path: <linux-wireless+bounces-27960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00254BD5B06
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 20:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C72E18A6AA1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA82D2397;
	Mon, 13 Oct 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gP5fgmfn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD22D238A;
	Mon, 13 Oct 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379750; cv=fail; b=Ea6FM/VxGZQU3xs0tozqQVrBmXcPueydQN9zbGOHS1sZ56vApCuHmBrrIK54foJMAE65a7DB7krYll22mZiZpxs2l8waCLK3c6gXJur5OTNdUPm6bQrQq+6+JZL9NHPuPSA2gdYFwKftSE52WDDaC7UkiltTOX4Ds6MHAbYYdRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379750; c=relaxed/simple;
	bh=4y97jtcZNR2gQz1e4O7fgNFQPp9S+oS/gyvG5Gk5Xvk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t99SVcvaVCPUvg0xEIebervy7C6WvrEYYsXq+OnT69E64KKeSEgJjO259WYfc1GQNDk/Sbm3Pw7MrvNmCBU1neAMGDR0V1E+2lE5mUp8anPYwmSJ7H46cAKGMiRQEl2gch9kLs4svspKjmbmNadE+0X1p8lHZxEU4wWDt/YusdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gP5fgmfn; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiUcmtO7E3aburOF2YBNqNwRhflMgKJrfDHrTogBaB98JqPcKacpjoQdWuhlbtATZ+TLseipiqhZBqO+65zdlm/mNix6c4yYo7QkQ4vwaxeKUqR4b9d+wYmb0Q7oJfoX4FYT9hxxgA/Le5XsLvgpN9W2pDeNrDaL7PxrHeaVs1I8gqOHzIdd/cH1/a7z4C9+v3IuQSNzId9E7iHAaWqvGBT54bDBeTp2FydwYJejg4UjE5thK7jsiKYQhO1ieRbAqGMn4WNCW2+ElNb5LeU/4K8Hr5OkIuc3bNZNWEolaBGr00PWfpnD9JmVlKTAEckI03BWe0oXkmcZHtUnC3LlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y97jtcZNR2gQz1e4O7fgNFQPp9S+oS/gyvG5Gk5Xvk=;
 b=t7X3cqfxC3PZkEiaRQ+mWBPNR8mOq0aT1eYVywQQSJ4g5azZAB7iKeOcgQuoUIo9eci0Ze60M4MYjbnh3RlXgSXQDXrdK6UJkOKWyV9795ucB1BFbQn0kloooCjWDebCuw/9XiE+DxRKkUUQ3qIXmXuiwiyOoRPAJ/LfPQJtFfCLB8J+BzxzFqo6xbhoAh544zVvqavjIVFliOoK+QaxjZG0Z/5iz9z4Lu+Eq/+38Q479cL5illk2SD5JEVSAVVifee9z9QsuBlzLjZJQoyc9VATuPGGIqKLwU51+NZYmyC5SBIvJyo2DO6iEU/H55dXJgaNNQNB5qtEL0hYlI0OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y97jtcZNR2gQz1e4O7fgNFQPp9S+oS/gyvG5Gk5Xvk=;
 b=gP5fgmfnOz/ZD9y9akMz7hqm/5BtPHhA0aT8ye324YYveP45oGCD9ritnEOhNoOH6fsjXKBibpiE19/qXq1yYEYMPgFyqR2qa1i5BjVY7K8CW/Yod5CTFQTPnkilLN32ZAv0eYVzvFevyHGPz2ukUSA7CV7eCmZHLddtoDSou8rRZUphYfKCKrubZC5X6ygK+KST9+Giz5zahro56kKhb2lfBVfsjlPlZ5liA7gSbpE1qjpXkhPmhyhno9sRHAVHj0C7232hCvkIYNwU3cv/dz4Lc+hu5ClZAU3Ls3mreBGaERpsTWnLLGvrcW+t/5TgOFbej6zO5gLCw1ul/P0+0A==
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11507.eurprd04.prod.outlook.com (2603:10a6:102:4e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 18:22:25 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:22:25 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, Brian Hsu <brian.hsu@nxp.com>
Subject: Recall: [EXT] Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHcPG5SOvbZOS3OekuueSuiGwPqBg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 13 Oct 2025 18:22:25 +0000
Message-ID:
 <DBBPR04MB77409014CAE95BFF66208DC69CEAA@DBBPR04MB7740.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-traffictypediagnostic:
 DBBPR04MB7740:EE_|PA1PR04MB11507:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb387ebd-6241-40a3-b23f-08de0a857578
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jrHp1+Lhdf36hUsLnRVKuKqBl9rHGUkj9FQh6E/aY6tEWTcIGIxB3Ipo7YeL?=
 =?us-ascii?Q?M7QD0qbNHspmyDMcNP0pTgIhNF/SvVoiT/u2opt0phbWendFmpN94UJEkNHU?=
 =?us-ascii?Q?18JnJsY5MOS06H6Lh2axqb4vduHPsdvmKXbk/j/WQch6sS3UGRVPDwEIQ7PW?=
 =?us-ascii?Q?bDYr4VtGc1vgpTR8dOs9pS+wcDjbvm0cfVgQCj8ijJsPDYgBqSvZpMg9EVE5?=
 =?us-ascii?Q?azemKfoE2ZpArbQkek+Zwik3dnt7ARSJcPs6kN5vlzqdUxEFrA9GANvfx8MG?=
 =?us-ascii?Q?qTf4vq46SmYhAcMHpF837QiPaZBOFG8Dff+LcNZdrj1etUPTRgWUCPq2DUl3?=
 =?us-ascii?Q?/2aS7pyHZ9rQ90YuzCjPgjiQty/BSzeDKkmfYXn5IcKb88w5uT4h247u/2Qc?=
 =?us-ascii?Q?LuinhdkCd6qS0upxdCceTYCMHK/esedJNNtQCB3iwcsgLcMwBFaqLty0ZA2A?=
 =?us-ascii?Q?A75KpExIb/50zyezliAwkPS5mveTIYdhXEzVdko/rLqCH/rGzROrxfYR2tbP?=
 =?us-ascii?Q?tbY6fM/IjlarZeXzflZ/oLuhMRihlDNrNNuqVp0Jehxd9wKQ7Pf/ncxNY5sL?=
 =?us-ascii?Q?evpXSFB5TtSl8eNxjMhSDTuUHTlFvRqDkpKtzSVfL10mWoUSlJdEpPrYwQvZ?=
 =?us-ascii?Q?FtF0fBuXXn1y5dV9dhHuA4lFcXbOYgMPCPpiSkJuDdwgDG1tPj1AOnf7xZSY?=
 =?us-ascii?Q?zwBKc+4gu84ChFnK3BUVI8L54dvXveqS5V8sjF1ZhG81iA1cGbRbOPNKNPoC?=
 =?us-ascii?Q?Tbb8Rwq/+sdcSATb4/bjsFyDOtYAYJ9WW8Q2D6hwbhIh7mlJ8pJzHH0yFi/X?=
 =?us-ascii?Q?CKyovUII/hv6HStTMO4bg9YUJrIiYqbQsGZU28t/4exwJvnflu9Ks+s4P/Fo?=
 =?us-ascii?Q?+6IWvYQJq9LTf5/zA6nqXbViA9Il5J5aCB4eTUgZF6k9oSV/+NAXeieasG8h?=
 =?us-ascii?Q?BK8kNeH7k4U2IHcYyOyVY0SiMOP5pI9bheFlZZE6W8DidmZps1vB8j5ePD19?=
 =?us-ascii?Q?Gg0BB2m9Y5qanzXEr9bJJzh2MeUzbll7oKd0vC9FH4yF7U9OPv6LoXz6RPSN?=
 =?us-ascii?Q?diXuoI+fPkgGlF9qltcr9APc1yWTWbEwt3AM8Il+w8E06M43CqUl2eQARIPQ?=
 =?us-ascii?Q?9uvv+bnOHyRtm6OcFT6Om4TWHJxn9/0Am2L1ekWxmQfVnF/KBvymr7D7QBXc?=
 =?us-ascii?Q?zgGntNUreK9cnSZtQjRMdjF7wIBtcgx43pe6HWAvuNbd5Kcx8Cc/u2XQ0qIN?=
 =?us-ascii?Q?h4SX/wFZdfZ9weF41W4mXM5M1OmhhEJd8jc2he+arPr5/rT8kVDBFQzWmieX?=
 =?us-ascii?Q?D9cPlSW3TnplMCdd5tnScxEjVeCZ5xqpDMDyu8erTGd6pwtoe+tBrC15CFJA?=
 =?us-ascii?Q?XFU+VZY2FH1wyrg2yUs3GlLPdFwI1GnnUg1u3I28yocpMbT+yWSscN6XAdJL?=
 =?us-ascii?Q?MM/D2BTgybixWwF1WK3wT9SI9IR1haU6cnZq9iu2iuwpkIxbukY+vKILlZh+?=
 =?us-ascii?Q?LAEeAVtCV2ZlPkIH6A9po/wfjIWIURYPUEgl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wuGumMdfIv5wubkP2joO18o7zXwHtk5Gem08EByuqK3RICi+bBcqRE1E3XDo?=
 =?us-ascii?Q?qtkzP8PIEaxVRjCh2WHb9HfkowKhyXxugsvSEquye1gU2Dm1xZAVpocSH3KI?=
 =?us-ascii?Q?Y/pSYWE6vb6a1JmE6eFx9JkqTm4p3MXCKCEX5ZVCGCWP9lwvCGigDOMqRfNq?=
 =?us-ascii?Q?bSL5XUvXiuDdzKs+brwhWxPuWKpR9bZIUcG29UELMBusP68xCPMJlrl09AhI?=
 =?us-ascii?Q?J/3ls22GKEZ2+XRO2I4j8CcPEGKjM2WifqKYulKrD5wdXwAgnRrTOY0Vhgh+?=
 =?us-ascii?Q?r5y3RuBI+IRZ6gRa1s0tfE/nwYaHfNf1E+RnInjIgzJWBe5TLrMAQ3ewFsYw?=
 =?us-ascii?Q?lXwzzWKZkcl+sQWQFZ55HMdRnrRRTPApcI83/c81KdRPiEC6dwfr8D7bVBkZ?=
 =?us-ascii?Q?jZ7eSKWhHyMDaJ/RFW6YUG++qjG5Q7AU7x+XMo0VygeMYyIJrOe2QheNSEm8?=
 =?us-ascii?Q?nZwH/Hkx4q82ss+N1D3e7MOqSslp4uUrkHdf4JYdj7jPbcSBfkpuw205wGYa?=
 =?us-ascii?Q?IkY9mevHElmSP04gwt/DsQa1mQYOMZsQGCJ7ACyTNpEJaLbDlaPttumIz+lx?=
 =?us-ascii?Q?Jxz6DZosDoMsxu5N7HwsbpkVGYbHOniQY2wabJVDXshzMY6/qSGIzgQy0pgN?=
 =?us-ascii?Q?ftbdH9CVxkWY0q7FKrwM5GCx9KAoMJJqQt7z2nfPpKIvsPR6Mw5wjlcIAPFD?=
 =?us-ascii?Q?FyfWkX+VGnnxUHhRVc8toZHsrArEJXcMGE3WngP0Ty54q1GlhqFNi50Jm93V?=
 =?us-ascii?Q?63kJg8AlKCrpyyvoTEvyIMZi2U706nKJj0CZGNTccOHlbwsBx7r63794qYk0?=
 =?us-ascii?Q?oEQ4FoMxhyVxjHkUdGMPPPrXQpx/xl8MhRpqq+MK31NEb/sMyafYiQ1TN4zo?=
 =?us-ascii?Q?Cu5RYVMXUGiMwvZq+n09OLxHiJs8+7ePLkto/XP2etFvAoEFd2XAWQeHgF/A?=
 =?us-ascii?Q?36ST50B2bcsI1oHxHRtOkhS7LsHct3oeij+H2Pezgf2SeAXplIPBr0ZpM8de?=
 =?us-ascii?Q?CLsCfhWJKWS7KvkXNGZZN0xwLZ4+P4xKGNQ5EQh1phqMNUJkR1tcc2JY598K?=
 =?us-ascii?Q?jM2PVTvWEhoYUBhtLkPtm0WunIzSy63pH4zo2Ivb9aTaCyH35flYqYbrIGQC?=
 =?us-ascii?Q?+sd8sTYONgDsJDLt+iD732XMYPqzd/yL0JBj5TywHSXR+om3Ueb+pZPdKhM9?=
 =?us-ascii?Q?t+D+X9FxrvXjBpKZdBoI+MkxoQxP3eByGfHx8Fw2f2WJyNQz7HlLB+Mjfkhk?=
 =?us-ascii?Q?ssoJs+uarzHqihdSqLcmN9KMbaIzhnsxgXCeONKnZ/a/8MI512JyyQIVNYdC?=
 =?us-ascii?Q?SXqASTkt2u5usWg6rd5zanhxg/+375pZzwNL3R6p6EMNuqzHdrOJhq6yZlLe?=
 =?us-ascii?Q?5O0BuOKOxseCiP2hNwOoLyEXgqxzfAZnBsTo6X6lWwFAnNAHb8eTeJeprlZT?=
 =?us-ascii?Q?HqxgaBY6y9oj/0h9XgET1GlZg28aXxfMPFAMrlG1EV/kUUDaEdNV7RnnFEwI?=
 =?us-ascii?Q?7WRIXAuKWjd0w3D/cxy5m5GCXDAx3lnP87IOrBhzzrSzmQXg64LcWEDB27Yw?=
 =?us-ascii?Q?wO/wD+dGiMX3YC1F/1LUIM+9OYfrXPA5InDx9kVR?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb387ebd-6241-40a3-b23f-08de0a857578
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 18:22:25.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMpRpEwGFbWJS/d4CYCTICWskfZ2lpZMGvOiYTXeJmazXsuhA4VA/qJMo4SYy2vPFZGLFZz6b8IB5y33rJ86uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11507

Jeff Chen would like to recall the message, "[EXT] Re: [PATCH v5 00/22] wif=
i: nxpwifi: create nxpwifi to support iw61x".=

