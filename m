Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C45A52E0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 19:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiH2ROE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiH2RN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 13:13:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FF86B46;
        Mon, 29 Aug 2022 10:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmgSuSIOVMe4AA1yad/H6iAbSO0iIqs32SoxVJ53sG2aDphOfRckn5kOQxDi+k0Bj0WGP0AlJpMQNN1GHOjsd7sCBPhAMSGMaNSm0OCDNk1lbDgX1fTgjXE7HermXdhtWtTAeo6QovCuaFQ/rUi9fXZ8QsLJLAZIBRmfSVTVWg9jfmHKpgWgvXv3O8ODGK1SaI192yVN5tMbcsjVcqtrpVYbzyn26nH6qms/q3VKYQk6eA00N7N58+Qt05YvXaXlZU8RvoP/2r73w+Ijhkwq3PD+MUMjQ3u5zq6gapsaw1s6hsq0R1nmWjOnmQSbfOlOoedBzTXzsrjE4wPqFn+ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpVQ0tYjmBdtBYddxlHL0aaVBtmHT3nCvFYm1xaYt7Y=;
 b=QOZx/hpY+3eZEhbBE2p7s5WLDtFWc1DhyEnIbPv+XSYKHG01wdZrG8eoHJ3/oxVJ1SHCQLq1TCww3Dwv2lIOqOhfVnWNhcOaPhOS21XFdGwsfUqzTCbVNDXThWh63BU8gFBd5wasfVTBq+xgYwvLBzMXKNuSYqH/1EybL+ywa8Ti7N+j7m1hPIkXS4fGxqLewtYqPQ77nbMkvz2dwR0Hu5KI7d/MdjIv3uxCppwhnH+ov6/TKdNwZEoeggvWH56GmBxqMxEA7uYp89lKYWT6T54iVu98PXB9YG5QrLHWl+qOEoJnPTP8f+eC9yw1uEVuIFyt6jZs2XFjvFw7ofK9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpVQ0tYjmBdtBYddxlHL0aaVBtmHT3nCvFYm1xaYt7Y=;
 b=Sw5pp0vnqVxjqVag3onnTPj/TSsoUwv/4a+Ij/f4v0h3VAUh27SouccLGblTGfUyM3wseGVHYeL7J0VRxMMALgotu9nIPgiuLkHvHYH5cMipTF0IZthiRcWkAEQg4Evgw12Vouy0bzvKQfgHQRb1QFuRp5jdscOEiYnJJQRtyiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) by
 IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 17:12:44 +0000
Received: from DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::54ad:4f63:71df:fb59]) by DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::54ad:4f63:71df:fb59%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:12:44 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wfx: prevent underflow in wfx_send_pds()
Date:   Mon, 29 Aug 2022 19:12:40 +0200
Message-ID: <37769865.10thIPus4b@pc-42>
Organization: Silicon Labs
In-Reply-To: <87a67ndokl.fsf@kernel.org>
References: <Yv8eX7Xv2ubUOvW7@kili> <2729343.a3EqFhE7eK@pc-42> <87a67ndokl.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::6) To DS7PR11MB6038.namprd11.prod.outlook.com
 (2603:10b6:8:75::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d2add4-83ae-4b97-997f-08da89e1affc
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/Hsmso4M+Qs1Q6h0Cxu/HoOQzm2OlJk+2sPP7MDXewvK+atFAGkNQ5dvYK+zUMsX8fGuiz5DZ4tTeDRxKCQSXCp3OuTCEm6vmFk/NtHjw5t1eOdf72YhdvKALuDIxxlUeSa5YKhdHeIYj9jOfF/otM2HsOIKiHk/00aXlcbSP3t1D8z3cGOioUHzZdXgEOUzBLxTZmq0u5Iv0BmtkrQBJnJIaFceWkKghoBkPjgVflJOzrUsEq25Tum0ksLrhDdVNrt3C79V0MPcXrajqtTGpAzi3k5g2tNt6X+xYzJx6+P1IU5Jclco77Oa8e8zomL609lbms2HDpD1Y7wMJAqRfcB3c3SBp18k5jhrgfUY6aF6+jE2z5O7GNIP8rz++H6aAmnSC+aezzo1CYgNi/HgQg7K7vysbx1yRbyO1mC/Ad92EG5y6vWYLY0T65wS+jERHr3HZEKbmNQX1DPbEuxLaOc5caDo8fj4S4WtcCbhtIcEQabVeYoxEh66ep64h4+dchn1SD7zfVRHo4zrZaym327b6MGhUXfdRlqTu/+ijD0H2NMFapYgjECfMqmB90+EUSby29KhgA14p93UOjVCXi0HZDa1JINVXqOSNfgw9v/juQQ8+jKA9HJys8MHWKzpXh9HIv3SXVnn/A9RfiocEMawQhFo6L3qaKiYOI06Yr9siIkebwFCkyDDSI+QQakYk6ryKpasaFu2MndoTXCoblR03Il5f1Y/jyDNHsfHbC51gmlhuitO6WUQL+ulD1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6038.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(366004)(39850400004)(396003)(9686003)(52116002)(86362001)(33716001)(478600001)(6512007)(6486002)(6506007)(36916002)(41300700001)(6666004)(38100700002)(186003)(6916009)(66476007)(5660300002)(66556008)(4326008)(8676002)(8936002)(66946007)(316002)(2906002)(4744005)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tyOIsURdqWzRAwmYsbVBJ/n/hiL7Yfj/HTm+8heDN1+VD9ioyhziNxgBKL?=
 =?iso-8859-1?Q?QM0FwCSNWrNO+WKuhTZYQFC2IOQnXhqMvwWIlgnqG+RJEnlIVLFSKQD9p5?=
 =?iso-8859-1?Q?i1KDgfJj1FXAHNPvZoDL+3mPZFU5YJ2AOw++GC0P/vIUvvEonSkpWaL/uM?=
 =?iso-8859-1?Q?amJbPbx8LWct2WqPvgbbkTKRXPyq/QT6xLmGbSl9e1Kpyd9Qu5lABf9o5k?=
 =?iso-8859-1?Q?ZPftbPXoDomH0LfCMC/QyO7mdnxYJ1/W8ZNrzvRFElHZkRmkVcbW7m/H2l?=
 =?iso-8859-1?Q?fQp3Sx034YL3h9TqhEsf8g4V8+Vw7F7oDMAARt+IYaX+2vsKIuHUL121Hy?=
 =?iso-8859-1?Q?rK/3fwE6+6vvk/FFGPebqlyKg29ierRhamtl+MCk9Zbom9b2PK1vzUdjzn?=
 =?iso-8859-1?Q?pagS66fSu/p/Ocb4sqI9XCMUojkMHNGfl/YwG7irul80CT5LXxn8sA5bID?=
 =?iso-8859-1?Q?YazArDC0PEbc8hU4yIGkSBciLvy9JGQv3fRDV/6g0J1lV4TgW6hkFzoQN0?=
 =?iso-8859-1?Q?UGW2J2iFl+cr1+OYs2iyLGbuwGVitwmkhRipVrwhYXRpiQPAlbcdEzlIVO?=
 =?iso-8859-1?Q?hd0UGzpv8WefJ4DY5VnHgk2pgzdlrDvE9A4VnKJSATS7DNU6WTTvWteXGI?=
 =?iso-8859-1?Q?ieto3IMcCqgQ5m2HmgXFmuRwj5ZbWClbWriKCr4nwkjpIQVy3B2EaDDHW4?=
 =?iso-8859-1?Q?wbMSkB/b1//UmC3jEuUOU5U1DGy9d1DTPEpZF4mYpJ1senHa+mQkBin/vA?=
 =?iso-8859-1?Q?KZ/K9ZxIW9ujPCaN6XTMe1JIporARmShrZbvOZN/eBHeup8cSEtvqZZYGO?=
 =?iso-8859-1?Q?q1bPARD0k+XE3esQXYwEk8/f1Nv4i2oNEqdgsq0C+514DjS6ehvol6TQAR?=
 =?iso-8859-1?Q?IuHskkuIjode70ciNEMBh+AIvyQu1S5ZpP8YLHnNo9oEmEnR69g7MJO7iT?=
 =?iso-8859-1?Q?x4ovn3Oct3Dipl0juxvVauy0m9zPQK6cPBGXqb3EP/IznBAx7InpxLqkOY?=
 =?iso-8859-1?Q?bkLH7tWBPBazTinjVEO88Q57+b+ev3TiKT4hqFAy9NYSlyRVYtPdy2phnB?=
 =?iso-8859-1?Q?uCNHVXcAjttkUwdcTWPFfFncW15fbWTo8/2O1UMTyNSrtU/OYuIiarFh25?=
 =?iso-8859-1?Q?fPdVFEn4WWvP/y35Pq7DZTfUHs/cZCZ5pckBpd92B/6+TTO9xRciGqq0qk?=
 =?iso-8859-1?Q?zoBJvIyaZakbTnQUTfY1Pe0ufeH8jBIgIUgQmIWSi1z3MbiKvfVJrPDSos?=
 =?iso-8859-1?Q?/RBlrldAeQT4fn9XhAecx4vYWZSYb7wVxQu+niOLWxtum3r447+xw4mBUe?=
 =?iso-8859-1?Q?RVQhEFEIjg6FAKMCx81kAzeI2FnpXCPZmMCWVACsIhNDRtibwwFK05lyP7?=
 =?iso-8859-1?Q?SiHfgUEHEn4EgW1O3+3pHNEgekv2CAw10SelpBuYEBc9GqPR58Elpfm2ka?=
 =?iso-8859-1?Q?eg3Qwxk2uWTaznrt7J5B5o8Z7m/kNFFZgtx6fepwy4DPuKbDLHG6Z8RdkU?=
 =?iso-8859-1?Q?HFoB9FGoFVRouSiDcQMMnGnM9Rr9qOpIioS9hWdCMefW3yMSD/+JbSBoOk?=
 =?iso-8859-1?Q?2NorZzoheRAAdEutQM3pKbOuOHibRdckyx3JtkxmrPaA4VgrwMAeMijCrx?=
 =?iso-8859-1?Q?kFSkVOCly22CU/+l9WJANyKMvD+Oc/s4TE4Ov2i+/UoNTDVOTl0t2laXi/?=
 =?iso-8859-1?Q?H9ryU+P2elT3DCI7FAD4dwCf+SVZAFUkbQGLhX0N?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2add4-83ae-4b97-997f-08da89e1affc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6038.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:12:44.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEuDtsYxqahdZrRd5mLDKpxjb6AOFPzQQ2/OgI5Ahtdh+zQXQkd3U6u4/kqDtO3oiRJ3VO14OB9wpjpXEhR9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6195
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday 29 August 2022 18:03:38 CEST Kalle Valo wrote:
> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
>=20
> > On Friday 19 August 2022 07:23:43 CEST Dan Carpenter wrote:
> >> This does a "chunk_len - 4" subtraction later when it calls:
> >>
> >>         ret =3D wfx_hif_configuration(wdev, buf + 4, chunk_len - 4);
> >>
> >> so check for "chunk_len" is less than 4.
> >
> > This patch also ensures that buf[4] won't overflow during:
> >
> >     if (buf[4] !=3D '{' || buf[chunk_len - 1] !=3D '}')
> >       dev_warn(wdev->dev, "PDS:%d: unexpected content\n", chunk_num);
> >
> >> Fixes: dcbecb497908 ("staging: wfx: allow new PDS format")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
>=20
> BTW J=E9r=F4me, as you are the driver maintainer you can use Acked-by.

Reviewed-by does not imply Acked-by?

--=20
J=E9r=F4me Pouiller


