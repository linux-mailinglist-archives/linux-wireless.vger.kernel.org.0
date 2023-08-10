Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D587F777647
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHJKvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjHJKvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 06:51:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941210E9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 03:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbKpk1ccwno0Clz8jjmNj7qBZ8mLNf76dcsaLmrMJg/Z/F4FO6caFpexa+hElP/mJOLW14j4sOhv3bdA7DVh9Ps357UdRmHgrJic3kh69yP7RQ60o0UeVCAusH3o+B3spBFXg9LrlZdm6tVRCrGkdV4xmVT9d9e0WSv2ztMCgCF1kGsYYubzyj7X3luJ/sfWnE3RAsP4WmR6uveEJLe2OY63yIEuWYR3WXdUs3nnjeveAPi0M7q7V2QgJfLcE8BdWdFgW8FC4F7958+GU03cZEzFsW7lmKF8/u4Ah1z/oAbHECpeT7mZfDi5CW4bSrPULwPGD7TtyJuMHPrS63sdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLS9dkui/ydU6eUnYJ/6O5WXyKUnj473nixJrIXs+Q0=;
 b=jv0NQ3S8QXe0ASdc9Sk6x8N3UwWZUsXMZ5Or748/uaqkKKTNFEC9mnai7CG7URWcrdRfkCxzFg2/US2tYV/+M9AkD/9uWWZtomUPZtLfCCtvzKi/FGZSqJ1opGbfBxX+pqEqD3MlxLxOCEtCQXkPf3cGa9JpT+R5fNZ0V/BhOG5vJUy7dWhDd/74AA2Xd9i9+7sXHxZiikpxA+GfwACam21E4YWybS4+gts0kB6ju07YXHXmN5nWX0w5taPQMtR1O/bigWFhfYFJTk3u6i+FbtCmEfkeE1x4zMcUQbXv562nLhkesWrpdAXMTZtJ5qW5Mtu58jWDphj9P1PCl6G3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLS9dkui/ydU6eUnYJ/6O5WXyKUnj473nixJrIXs+Q0=;
 b=ZU1mrMn4Ennwa4DnMCD2qhOlyoLBK8oPJdV33hNu3eVwtnXG0tiJ63BPDOqnciBnkkecJX7zCN7cKo0UGE8iPMvodvetG+BUbxlklqKEfdkGEljWNKdXSEXYGhYBCJRUC+FUHEy5/7dbWAejNh51kQKfoUey2G0SNrIAj+D2nvM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:51:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:51:36 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgAN8B0AAAMu0UA=
Date:   Thu, 10 Aug 2023 10:51:36 +0000
Message-ID: <PA4PR04MB9638C1DB606524BD57AB59CED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
In-Reply-To: <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB9710:EE_
x-ms-office365-filtering-correlation-id: 858d25e9-af39-4b3f-321b-08db998fc514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmQ503OUOpt7zhbGYnDLswLn5tGNs4uvTnUxTsT2m2Z85hzKJPF1G1UXg32L2FUIWj49U7LMpGzEhAN+JC6OPPRtooXsVOsjKxFK/PWMeJz6FtYK+hoNZlvNwJzC1wIKZTm+VzS1qwCcIn9AtB0pRdvDiTS0NBYwIEYVdMOGZhvroFbyeH2tIo73hNwrWt42bVY/LGiKKGkst5ej8zkfGaBHheCmuLYwOtuEAzKXw3d1s0QN2hh+fUXdUcC9lZ9SGNeq+0W0NuM4QcIwhLwcw+qimQA8i7D6alTinxSaROcfpjSkNiY0pjrYGTdCh/PkcktyD7bcve+0eVZribzWdWOoxjnVx8sTndfine3RB3JFPQqjT9v53Qdo4N3ICqjCu5BRXyBHIJ+QHhtTTHicDeSS7/k7Dlto9Fv7srHUnKsaO2wXsI2E82o5mzN3byGMQu4d4Yxy2V+70mJDzoi5VWafpIdxferjeacV8VWNoSmTrKoKWF+pa3V7OSYafAT7B8Xpo9OQnMlAgGDWgPr6y4WuwFGbPBrIOXXF8dbG3kN34ri0QkHyu6V/Wma7iwJI08S+OR2UMhjAGqjDYEcA7T3FNFVFuBWE0HlXRw4H7piWG3peQLGVsS5wK128o0Aa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(1800799006)(451199021)(186006)(8676002)(8936002)(26005)(53546011)(6506007)(41300700001)(33656002)(83380400001)(2906002)(122000001)(38100700002)(38070700005)(86362001)(55016003)(52536014)(66556008)(64756008)(6916009)(66446008)(66476007)(66946007)(76116006)(9686003)(4326008)(71200400001)(54906003)(7696005)(478600001)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtVhXvamWPIFJc7o2Td1dIGin0/7nvr8bPXns9HCEROFpuzpf4VDyxnF38Rk?=
 =?us-ascii?Q?PFSPCFm0JlQinsEHAbJ0zVbu4TNBV+xdFNRSjON5uubkhxOttD3YT7nTyQva?=
 =?us-ascii?Q?oa2U/9ycpWNjNEY+MYeM8VkhqiK6UxR5l1rP7o7labmd3IGuzurjNtd/BP8L?=
 =?us-ascii?Q?vqCzqOXAJLEzLkMgyM1pC02g+I+hUG0K/Mf9M4aSQPYAIMZ+v0nFFSmzPtVY?=
 =?us-ascii?Q?WnkdIWBk0x1GuVzi0MdfuK6E37Yb+itKW+AA96YhW3d/S8dQDa4XlfPCauMK?=
 =?us-ascii?Q?97eEByd3iXUxUAAf/Cp1jUFCYqZbRaRlSxETxZgJQpcLc1reQEOkqv7Id4Yj?=
 =?us-ascii?Q?xFNiV+I7ZGWNa/VUChLrrqZ+HVhlBmPKhlBWpY9im5nfRWpnBEEZI8nAmMbV?=
 =?us-ascii?Q?+KEfX61gxhucRzatTjUNEiKI8zPXnlwRx6tB6XI4DdUcGsu10MnUr229rMeR?=
 =?us-ascii?Q?/fqT78ruznnoK8LzjefCY05b2v7GOeE59XHOBZ4Jk9rdMMfCz9wLf6HC+DHE?=
 =?us-ascii?Q?iFYKZ5Q72ozRiKtflbCH+yjNo+3NDn6mE6Wrfd8HMo8+dvZfGH2hY+wcSWEU?=
 =?us-ascii?Q?xYNfYT4Rc0G1UshMD7ICDLKxBDf0DikTRVZawqWfo8KAkfWUAfs+oWL1SMSJ?=
 =?us-ascii?Q?PVPsD6/9hiKSm3lfKkKck/bD8kTLu2qQHh571CoyK79KsWLEeBF/CZG9niSQ?=
 =?us-ascii?Q?KsUffrxJs9fdnF1Gt/JzMM8rH5u5VYrAYCxmzQhcfvpot3POu09xmMV0NTAW?=
 =?us-ascii?Q?Kl3s2IiVEgXtOlvWPe+nLdMPII87W3ajvEt/YMNj3MtzX8P5RGmV0hXegXkc?=
 =?us-ascii?Q?RS9+oqaZjkvhOLoR1LxAGWDnHiHWSoVwZl1+FpvsbuSClaXMzpKHwvOjIZOh?=
 =?us-ascii?Q?X5rKZUe5b6ZzKV4O0T8AdKcnG8BWkTy0GxSMflW8+/rXF9cdKDWWy5BEURoL?=
 =?us-ascii?Q?jzsJO33i3vmL2FB8PtR9Et8SE2Knm0/YNU3/rndEY4F/LE8eTrPRAZStwfZO?=
 =?us-ascii?Q?YIAQ58MJvR7EliCxcu9wa8KWd0YpTVj70PJpyAAntgKpSDN+OI6dsUaqUVvr?=
 =?us-ascii?Q?sNdpk6iJf0OF+TlPVtProxjBIQLugtiKUcZDho2OZAVdbOTOASB37cCHM9RC?=
 =?us-ascii?Q?1bMUhmQTyehxjWQ7Dnpo0/VNhlQo9cqoU3lLDLteuhhZA5AhrBVyPITUzvS7?=
 =?us-ascii?Q?9EE2bYpNvUIxG4At12obgBnopRpjgnL8N7MpYT1g1fxEkodTcUODtJfrwh+Q?=
 =?us-ascii?Q?QKWRI+u/zw7Y+OfSSqvNmR1wg8TmBr+b+R2wBB1pxEuNrAqa6EZ8Wni8ivn/?=
 =?us-ascii?Q?2lK6aogfLC8cTUBi6krQlnT2haS/0EZCUJH+I6gM6HtvzJ3e/ggg/4GLUDsA?=
 =?us-ascii?Q?88m1KK8Z9SKhAd1aah7Uc38rMu7U0FJPTcGMdZPYYaRdDdexYmA4UKexyrSI?=
 =?us-ascii?Q?Q+UNsQt1iscOox8B0tYO69SFY/GEFcEU+8X7UA8JEC/EcBVxE5iiN+h4q30Q?=
 =?us-ascii?Q?eUCTcQSewGYDNbw8iYlYtQyvryMies+vj/WRykxYv2s1/hJJYG3dpSVYEuYi?=
 =?us-ascii?Q?3cCQgYVwQ6nG9wrmcBDdh+8G3ChhdrPlrFU0w3jr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d25e9-af39-4b3f-321b-08db998fc514
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 10:51:36.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ko8ayHYOPNuLc5D2fzgnwAhD+3DFI67juwY2noim+EmSVt+tmh1D5LM81FRCk4rOSEgFPmuQBBPx5NxRBauEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, August 10, 2023 5:18 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; Sharvari Harisangam
> <sharvari.harisangam@nxp.com>; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host m=
lme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
>=20
> On Thu, Aug 10, 2023 at 02:39:21AM +0000, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. Firmware version 2 is needed for this feature.
> That would mean that we could just enable it for other Wi-Fi chip variant=
 that
> has firmware version 2, after testing it?
>=20

Yes. But I only tested with IW416.

> > 4. The code is only enabled and tested with IW416.
> > 5. This feature is disabled for other chips.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
>=20
> You should provide a changelog for each new version of the patch you are
> sending.
>=20
O.K. I will prepare changelog since PATCH v4.

> Francesco

