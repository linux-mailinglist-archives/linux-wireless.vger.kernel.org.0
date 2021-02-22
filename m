Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33103219CC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBVOIl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 09:08:41 -0500
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:46561
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232016AbhBVOF7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 09:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byO8hI4oAJjVJ/8EE6bw9QXDvrc2zSYWFTvnG04Zv+lEa1nhc0ufVG5vEUoOQnnZfP1/TGoaSlnd/9YOmtHSe2BykzZd/GrxlSR74M9wzuw1myryxt9enj1EW4vItcuYJSoTzOLUKHcBu6XuXBHHZ6M60BP6aoDc6D9WondkdxzKfrBU6lX1V0RUwRU7/xKbsH0+0EWim35UaV5/pJuRq0N9Jm2jEr6cBDy5vkekw8FayA+7Z5GEOXWaoAQipvVu19g/kvkpDXNmDd2UEGQWbdqfiTyPacg7Txy+zNBCKMlEvNibyPAfZ5c0YAt2qLok0UPbDP4fsDvMaZzZ2vzh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e2AZ9dpvyBdW6hHgZ7At67INzjLTWhZItVLpuGRszQ=;
 b=lIUqFBeZXJiGe28HEaaUNHBlXWY8zI6rguDwjzmWJZgc5gGG5dAB2D0lQY0vASE59TDK5Btx5p9jBj6MUhSE9haii0TVDvBZO0spJlGWCjCct5+avhgVR9EPP3N5xU+jZDKdqlWvu1bWWF/7NDwRYFNrlbq5+kLbcn4E3ESbttYeWZVkAKDrLq1MOBk2Lx11irShRfY+VNQdJEAA/3LhF07S2Y6g33qDqvC3a8tK5eaHLPoSUdRQzZcso8NN6phpnv/i7kLc49/CLNxtyY0v2nHk9yWtM9jHlnpEhePSVFH0NIlyq5EUkwGhQ+BT7bOJJFOL0BYh9duzw5Bx8wfjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e2AZ9dpvyBdW6hHgZ7At67INzjLTWhZItVLpuGRszQ=;
 b=q2RmDGVlqvqwf8ZxcEcKdhKDB/3E8tF+TqAjwxQ2vhgMMAa8O53fUQBCbBD0MMZKseqW5qt6/djGT5hvij3RvLfmdAZipIuxBCgztZX2WgQOtbh8MQ/k2QS6ONP1T3a/Nn3Qv3GzzHbcq867cD1eyExWCeRdVBw5/vg82x3jLM4=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR0402MB3325.eurprd04.prod.outlook.com (2603:10a6:803:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 14:05:09 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::a459:619a:3b9e:bb40]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::a459:619a:3b9e:bb40%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 14:05:09 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Pali Rohar <pali@kernel.org>
Subject: RE: [EXT] Re: [PATCH] MAINTAINERS: update for mwifiex driver
 maintainers
Thread-Topic: [EXT] Re: [PATCH] MAINTAINERS: update for mwifiex driver
 maintainers
Thread-Index: AQHXCSKUFirADbvaXEmlRWHDmMDfOapkNPfw
Date:   Mon, 22 Feb 2021 14:05:09 +0000
Message-ID: <VI1PR04MB43664C16F5F80C98E92CDEF18F819@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
 <878s7gfbon.fsf@tynnyri.adurom.net>
In-Reply-To: <878s7gfbon.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c00c2db-3f85-4e75-ab5b-08d8d73add85
x-ms-traffictypediagnostic: VI1PR0402MB3325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB33252B004284C7EB9D4939B88F819@VI1PR0402MB3325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgkQwKvCkwANiztYLK04L9E4uxxcWzN6AY4Ct1b2F0aHLqUrOtcLTr1gxJJTwl3p54O3mf+pyrRNgJakuUpYA12KbR/27IFpfFg6YeFl2TFJFs4PYTw6Hrxd2qYfeFhhqF2FhcS5FHK8WdO9Smffo/JwZG77NhvWhnxCOmcV+b4h8nSKn0OONaPe8w1Hc3wtghi+N1HbWan+8JWEYf8dvTYJNTgtVBia3XifA74LWiCrNnVcuaAGLdJ+zfBVJufWK5BZy8584eyWERfVU+Q2JN/zTOoRxZiN2EG6wZEDeAgCmGAzhpcL84OG4VQo7RNyZNLHk4nNk15hjCQ7y99mlZo/btYfFtmYV/KU3bN9FbUUNH/5l1/lI6Cuo0QUWYmNatnErH3sLJrT9MwKrlEFqG7/JEjrYHYjqEeP4SI0FGdayzxWxFUYLRqnOxj5TQs1m5bFOo79M5qdoxQ1vO15sFjoMsFH7VQWuFqKvTjO3GABdYxdCoO5agqcAX1le1G3VaHKMIozJKcmg+jKzNfCSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(64756008)(6636002)(26005)(76116006)(7696005)(316002)(66946007)(66476007)(66556008)(54906003)(2906002)(8676002)(66446008)(55236004)(478600001)(558084003)(33656002)(6506007)(86362001)(8936002)(9686003)(71200400001)(52536014)(186003)(44832011)(5660300002)(55016002)(4326008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tIt4htwc0TpHsGcdDIq9pA1/eo+E6tv9BZ/TBRdPf6qAxJrC6aJ8Tcm3MFh7?=
 =?us-ascii?Q?hpf6nyPD6G1gUKCOU0FR/rtRP1+mQTraJHJh2V5BfksnE07VTZKGUkipjzSC?=
 =?us-ascii?Q?K56zngciF3lEVJW+hwNwvanaVmcE0619Rlur0R70eIYKeQfv/eH72WJ8xPqP?=
 =?us-ascii?Q?xb6L0z1MPQON771WMpSzsMXhtiG1qTl+NUs6s16FZMXW9aS58X+GaxTFUlWL?=
 =?us-ascii?Q?czjbZTnWAMb7Tf+7E4CVQNE+BNzvuU0riwxiBI7FH2Wr9yiE+RgJXj5MdpRT?=
 =?us-ascii?Q?amq2sFjxG3WS3AEtnJ8qmZPoofbOz9HBVsYVCI77hrx32JzDwVjQGxlzPpgL?=
 =?us-ascii?Q?NvOdeHRyCY8XPUxP5yYxibvi2fMriJ2OyHtZ8djyhYyQ0mqp5nxcQXRPtQ0U?=
 =?us-ascii?Q?j1KP4YZdx6Zg6cLfhq6WvS/K2iO8obvhRPorPKI7mrLfTNdmnexdW69sffQM?=
 =?us-ascii?Q?lCQLxKVuU9efOe6F2Hu3pEP6P4+98HFbowk7FIlx18f/A2YZpoU5ulAMFjWW?=
 =?us-ascii?Q?d00yMcsa7wY/WT2wajFs/9KTIqbaHXF/dmmN3fOXSHxSfJwe1NrVVjI7VwDD?=
 =?us-ascii?Q?2+E++F3s1gCRj/2+ShyVJ/iuKw4xiyxbsycQQ75vdV/NFUioota8SdU5FbH2?=
 =?us-ascii?Q?yTEKVVX49Zk9HSIZi/1f3eb4BnRLQNusAUcNiSRbRW+oNNzj0uEH6uG+JfiA?=
 =?us-ascii?Q?F6C/UPK3xQuAKk8NoUX4W1XPyuykfERomBcscs3WubUzN1DPx3lxOTwGjqM0?=
 =?us-ascii?Q?Lqwd0wCTQRTZQXineCS31v8YyKAgN/1rhZ9fbXQdlUB8CzRBQ/PKsxfSbz8s?=
 =?us-ascii?Q?dYyrvyGy5fOrfZ6GdUY1zPSB1+K2bziulqdCmLJLTEVvs91nERyVPHfmLeoD?=
 =?us-ascii?Q?RSJIEZN5pUXNU3VlFF6clEjclCj5pXSzqC/+pCj6RMgYIvDakJt4NkRJCC0v?=
 =?us-ascii?Q?9pF66lZeeUy8tfuhUqhxXutcw+Wv4L/sQGyJJj+MaaZQi2v/w6O7CFwZC075?=
 =?us-ascii?Q?qHVmYUOBsuUPRx32xjstV/zoQtzuyXn/UZ+APUPciL7bgc3R6iWQV7kHRGn/?=
 =?us-ascii?Q?oQOsTAyle2Nc5gfVzIlMtBVWAeHNokEZFzFaV3tQfAVAEQDAyq1ZDnBGcJ+G?=
 =?us-ascii?Q?p3Jxb+FeSCEUcFRSP1LyBLt/dLv+3+T5f7em/iujEI7nrkMLljESTd6aRt9s?=
 =?us-ascii?Q?Ukux3sG8vrTJTYay/DvvDhNJ16vebbPfWeH1EFZ/mOPA2OV8JuxiOG8VQk3g?=
 =?us-ascii?Q?SQpbPc6xibjybqabEf3fWaAM/KxmVKUsub7c3Tqtd2VfDqZjjXnGl/Kgqkya?=
 =?us-ascii?Q?5z4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c00c2db-3f85-4e75-ab5b-08d8d73add85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 14:05:09.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUoJyBbY18q4DdX0caqWRkncMnNxT7Puvzk56IZ/lqENkDrVQQLOOZ7mixM9y5//Yj/LwBgwqjI7mSMXbweysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3325
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

>=20
> Can I have an ack from Ganapathi?

OK, Sure.

Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
