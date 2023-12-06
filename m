Return-Path: <linux-wireless+bounces-446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CBB8064E6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1994282210
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2D5695;
	Wed,  6 Dec 2023 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlvfl9x9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863EBD44;
	Tue,  5 Dec 2023 18:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRtbUwzkTEwkqqL3sVHNYerqIn9xRrDJy+jfSKR7/1pqUuUvX7hRT3kXQ+kMdMy53V7GQmaH9k5vyG/pkmn4eft8/Jhu3hVEtkAIvonpRUp1jO299zKSVilBWdo8cK1E2bebgD4lMMZlyV7BXWRD8PoK1Sc4xXWZcG+24ZEwkYuN+qyzBZtOcS4vcF9LxoZD1qdmmpSTQgxbFpNlCuOC0lu3aHSaIxwl50hXA5t9cbQl+HfymtccBOsUz48k2jxDel7PGctSNVFCC8RkVHeppJtiBtdhm/1hBLUwaDPbNbTxt9ZjFu6DrPlVQqyTdhztTGj6DTlCut8j+vsdkSNMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix20dz5bEEk/+aVwlkaPG6Ldj8IbnkFZJ4DWG9a0Yts=;
 b=SNF05W66isR0u1SaCuFpUeU3tDuA3kB4J3BmKZTzGK/MlN+PIWmWjMFYzi++D5XckbqlamG9srZzQ0RMMmA9M/EiGGrgFbkiaurrnnRA+ZXKtF2tCfzSnJNuT9MceaIvsNJqjXYdobKJUwRgCOtggejFXj6VN0lSegxC0Z23LzMeru1etP8nU6EeCQBiMyNDuxlB6DVfnVS0xLLC3xGFETBQd4bdXdDBy5hKyS5H+UMA4HztpgVKAD7eu29Panko0umnDd6SLUtYIvQgNb9/fEAZBljrneJEwp4mFBlRGyFzpwx5uijKPBQem/KNLuMyFDVptKIgRBDH/lR6Vv3f6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix20dz5bEEk/+aVwlkaPG6Ldj8IbnkFZJ4DWG9a0Yts=;
 b=hlvfl9x912kVCHkoJfq2eRVH6fpK+Yz2JD01W5rqE/O+5moMGdexBdS6a1Snll18eKHqfAx+p2QM82ax3Bqf57ux7Ruuy2hSWtPiC+dbzAUyCUBrQ/YlvjqZtH40o2dv+bUVKkp48H2C+INsif0AwiyUiOlrNjY1i4TfILnSnWY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Wed, 6 Dec
 2023 02:19:26 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 02:19:26 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware
 ready.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware
 ready.
Thread-Index: AQHaIdSgkWy+z6AqY0y9BY3vh1TVyLCbLwIAgABiMeA=
Date: Wed, 6 Dec 2023 02:19:25 +0000
Message-ID:
 <PA4PR04MB9638E447753FE4D08A5677E3D184A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
 <ZW-HeGCvxpqzBukB@google.com>
In-Reply-To: <ZW-HeGCvxpqzBukB@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB7814:EE_
x-ms-office365-filtering-correlation-id: 3bda7a58-7fc3-4dcb-7545-08dbf601c4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iJLV8EIvhC2EKffFVHPFwVyV/W108bR97A3jZP8UtyE4ylyQPDT0ciF2p8OXcCy3TTEO9VG2yL10p3eE0t5covCj+h0k7G1U0SMI9/aPpcFmRbutcM53KGlLCDLZI+KvV/m1dpoxPW9JG01JUW9gu4oZW3gG3w9JZXrrRp0OemIg7pQ30dQtEZd6X+hoXQaycCDKAdD/Y2qVBAwgHIj8BY6j3Nz3eVmhU92Wxz3Vpn4lvNVXig+RmsDoewVlEQ8e+TYy5Wh0iCuYPJyg9/plAScp/I4fr49ZyZU8mCEdcfVZY9SSLhj12HGyto7oXDKhcoz3uxkO0KIw+61EV4xBX7qf/65Yp7vZkvMhVA6ujq7voD3NnW71V3ok0g2OTJpCxY69iUb/gXnls91yzYvKOnxRKoA6lbgyOBJIP6STjVIjpbtJWQLorNH+GIMVXzHvzTkG9eRKPu6ogliT758iJW1kepRsYd6jm0badoc/xcXvqYVyqa6NgAYvkKJPMaRrNe7b2HVIalUQD6rlNSdZX+FiO5cF941I36CnAG2tH3ucBZdsq84YlhG+p5TK3VvaMjnDtI1SNX/tP50ytDFyFF5Cz8Y6ILQ2gK1FysM/dLNHYAT78dFa1LxCq9eokSrIpPUzI27pYpQ9hUXWwog/DXBHapX3LBCL3ubRmTLTFv4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(122000001)(9686003)(478600001)(8676002)(4326008)(66946007)(66446008)(38100700002)(6916009)(76116006)(316002)(66476007)(54906003)(66556008)(64756008)(8936002)(83380400001)(26005)(55016003)(71200400001)(7696005)(6506007)(53546011)(52536014)(86362001)(5660300002)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KTa76epgemksWi94kBRZ0kp/8QsIkqBKVFe54uIWv6v1c1LFmM8o38UXa7Y5?=
 =?us-ascii?Q?q4SVr1R4HaRtlS7t4t3RxTJ8yLQn2HpO4cJyW1VNIYXAuR6kp5DkZ83G/Rux?=
 =?us-ascii?Q?CzgBH29UgeksFklwWfoLTd2KwBqgj9DNl+dWDArgAdM8txE9Bx/II8Ndn7UR?=
 =?us-ascii?Q?yPhZ1A/gNq4+0/0l0JvgirHsivQ8Q6icylnw57Xr0KKAx2IG53PNZm1b9yih?=
 =?us-ascii?Q?rAVlN7Wz8IhrdNOt+s7KFOZfQCWuSa1ebHbQohkhTOYEQXXnmvGMw7WxtIt5?=
 =?us-ascii?Q?r98YDRxmO30bEuqN4jeeOi0ycseADTonQxGlUcEvioe2LQNYs2iImBUYkP0F?=
 =?us-ascii?Q?TkcGcEE5PRGD8kxks7mE05CZNOM7WJqGSjce7Yf9B9z762MmasI/t8ROjw4i?=
 =?us-ascii?Q?Ymuro71nySFvVF8whqUpFepAYXSPdi3z3T1rvdnQ/dix1OE+O+pXM0eVMJ1d?=
 =?us-ascii?Q?Q6bUt8AqFFh+pP6gPyy0MwsZe3UQ7Ek0K7nw3VIQkCHuXl6By8Q6KeZxWmkS?=
 =?us-ascii?Q?AA6/PaL3Ql/Q0mz5bcWlLwdvLxRaxa2//CuuMIKznhXxA0H0WoPId8faUfwp?=
 =?us-ascii?Q?ao/FoE4fSsCg909DOoOgNSdxGMPQVe4K+fN+u2++3XK54Sxnjo06GkgLdDwA?=
 =?us-ascii?Q?qH6KUms5cJ79Kbzo8T4+AGtle89FoXKlOL4vePfv05u0SlSyC5XeoQ5upthY?=
 =?us-ascii?Q?Hj1IyD+iO+7QhgXwL9cP5rzSt9is4eJG1pUK1LnBBhZp6M1tncGpNIFAZ+3P?=
 =?us-ascii?Q?Yb3zkW/Jg1VgLPkH/sQyiSRWzuKAZk+JX3jo+OH0Ki2wx5lune7CK2J2ie3V?=
 =?us-ascii?Q?Uo/ywXNam9LG9J9dnmnmE481NofWNXlHY1GlH8Nx8hpj+tusIjAISISGssbG?=
 =?us-ascii?Q?vUmvArH38TwSNinrDzlXaUj2IpCySzVFFRsocvawiacoKXBbp3VH3r8Vtlvx?=
 =?us-ascii?Q?A85qPZkqcMr/1r/g75cibS0tF7NALhdNFG7/Y6Rp5MpjAUwQl87cE7UXzlwO?=
 =?us-ascii?Q?nqSA+IoINudjorJ4xt75Am/NKuiRrq/GSFEkVumyP1eISFnJFxURzRAv6cyF?=
 =?us-ascii?Q?+P9UZ1VKGzV5bfSqOndq+AHCw/efvWf/X+IYACeqErcAk9RGZHuhFw9T0ENG?=
 =?us-ascii?Q?RbI8/bV/ncupatyf6yoaSVAInANkFTsly1E7zHEc4DorT9/uBmsYQvFnCXyN?=
 =?us-ascii?Q?jmJQxP9C+r4fJmsRLO5GjxzABhOepmgrQ/MVBmbBD3LxtOa+lpDibhFF89ZU?=
 =?us-ascii?Q?NeeCqKcwgsElA2QYnPOlTOCsLlPs59GgMEgVcMvVm0JHeuV6dcDsFJWZwpft?=
 =?us-ascii?Q?J53f4yzTJGuLIanQ16Wt8w96Kgwn1vS/BmNwT4gKHK+88wF4OkqSrh2jOXNG?=
 =?us-ascii?Q?bqQab8e5wRvNetwuKDOgS4d0zhcvsnhoaFlsxMX4qFEqyiudwCX8hhn76xrg?=
 =?us-ascii?Q?dpfmqi2Sv91m3WOu9YozcUNqq8nOX40EuA6rsIyq7IVHam4gvNZlDljCOROP?=
 =?us-ascii?Q?j7Jp6S1MnghjyyF4V1vt+SrKP53abA/gsqW10SwpAyfUozgo/YZjdk7A9ob2?=
 =?us-ascii?Q?MGhIehu9eNkpWET/AZlnTw71v5BcW1SyULru3Ibo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda7a58-7fc3-4dcb-7545-08dbf601c4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 02:19:25.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOSN3fGXYlQnJbishTyc4dvc+jPNaXTVcU3MdREm+6RPKZwaeRO/2NyBhMYI5N0KMAS3S/J3uElEEeyvmWnTJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814

> From: Brian Norris <briannorris@chromium.org>
> Sent: Wednesday, December 6, 2023 4:27 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware =
ready.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> > For SDIO IW416, in a corner case FW may return ready before complete
> > full initialization.
> > Command timeout may occur at driver load after reboot.
>=20
> Do you have any idea why? Is it specific to this chip and/or firmware?
> I'm hesitant to add magic sleeps to everything, just because you have one
> buggy chip/firmware.
>=20
> If it's a known issue with a single chip, it seems like you should add a =
flag to
> struct mwifiex_sdio_device / mwifiex_sdio_sd8978.
>=20

This issue is reported by customer
We confirmed it's specific to this chip and 100ms is sufficient and relativ=
ely safe/easy then change FW.=20

Will add flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978

> Brian
>=20
> > Workaround by adding 100ms delay at checking FW status.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>

