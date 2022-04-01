Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D769D4EECB1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiDAMBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiDAMBv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 08:01:51 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291F51E4A
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648814400; x=1649419200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5Yww57hA77Orm7fbA0zu8Bln3CWGv7SFR6lVFCXStA=;
  b=vS6I/IP7Z8g/F2gU1oaGMeCE1rtkZEhdK9gBPnb4JS3UJScgals/3zFr
   yyPE5ACp+uBR12+R4CMB0vLwGBI4bgC0FXvOq3axZdr+7m2XSnuiDj4HM
   pmA7okVwhMUS0AOBBXIv7FTaofoHxJPeV62MV5IApoHsBzy6631Lz6Qgo
   8=;
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg3/GaBybEMLjjkGHaYooINBrrg9ks9QI1wYSFm4Ib8VteJI10K86ET+VkdK+TdKtja2bDcjpzncBDzKBqublrWGy5kEzaGpFR7QR0MUUXrBrkroEYdqd/oKAGVzEcm0SUXg0TfqWwlHYU5P6c0DIpLgsH8hSRkajvCV82fBdJxumb8rh/wrWoa2kDJ+QC58rClWoxZltID4UAqRMtntgp1VB4DEuqDPAEXPMQw2uZ5A7UEQT/KB8lH2TpQeSSkgQsXGOXSyzqU78HO0HxrVbMsAqsacTVjmPSF7Du0r7MVmGsutu1FntzvGgcGehQs+2AqZtNoMwufngED20gMfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Yww57hA77Orm7fbA0zu8Bln3CWGv7SFR6lVFCXStA=;
 b=K09dW9w3YdnKpZMmceysFU1B0CGiDFTfwDSxJaZT3wB8A/7ae7PfINuthxmn8RC7/Z4FqRvSyjyLQB8IMacpBbQLDK1VSgozN3UE6j7rxWjE/+pqCur5oeQhNyJ9HygdSEhgXjeUO8v9r/YFT5cXVR8r1ZHZPJO49/7KLDIv2vINfcarUfd4CXs310wgWs64KDKlf9bWUAniScaW1nfkO5wtA+q7J72HgpWxQ0UUMz5fGAKuYvada0FlkihNQ86e17bHFMSGFtyAiKRrPsn2VyWop3oJJrosdptCWR4AnHuK+x8HcNZx1p8dfYmhwhWUKeLfauRnliGyqYtaLQHaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25)
 by SJ0PR02MB7405.namprd02.prod.outlook.com (2603:10b6:a03:29f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 11:59:57 +0000
Received: from BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055]) by BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055%5]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 11:59:57 +0000
From:   "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] ath11k: add support for extended wmi service bit
Thread-Topic: [PATCH v3 1/2] ath11k: add support for extended wmi service bit
Thread-Index: AQHYRb0AsdljZd7uy024/tNaRNi3fKza9IbQ
Date:   Fri, 1 Apr 2022 11:59:57 +0000
Message-ID: <BYAPR02MB543073F670B9B24C27DFBF4CE0E09@BYAPR02MB5430.namprd02.prod.outlook.com>
References: <20220401073200.1195070-1-quic_bqiang@quicinc.com>
 <875yntuj8d.fsf@kernel.org>
In-Reply-To: <875yntuj8d.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48cc1fad-3ff7-4293-a7c3-08da13d72453
x-ms-traffictypediagnostic: SJ0PR02MB7405:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7405555412EB45BB23C121149CE09@SJ0PR02MB7405.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOl4W5G1Os7JnPIzaDlBMfWWpjPBs6++wVnrTO4Z1HZTI9xOhjtSCfElDCkOBR8UOBOKmoJXeNJNVGYYwGaeXGyCSmvqCAK5SyUnQBl4LdlDeIIbv50noEpkE10YYupW+J8wQi+XY5TBv61UZ4jc1Z5FIzMI859l6haimeSE4JxBFlkYnELlp6UV899Wh0gJC3nLMEayRk+YK4X4wP1fJEKdKkZqa3VbxtfmzsakMk8s5wjowEnfpqci3eq6M14BcI6+/p9EWprikbLKQCQ4Gcn6xJRwbXLH+gcu8hvDUrnyXzwacXiZW5NbjTwb+xsh0Lkc4a2WZwJ9VADKIZOQtMZMcqZVA/Buo3g6AeuvgMclRjlTQjpIVsTnRJQKxQh0SW05c2JtoCUvpq5SIpBXm+5y79xRd20NpMY/0F4FflRb+VmfQgfRZiDvqul5sCCL1+WZHpS19Gdwevmzhz4EJ17soUyQs9bPssjkdF5muRraK72Xn2pOh3lxHC2kWwsLBA8IpkOFMssRHRdlN/4rqXQVtrqD4appMK51oNipkpQRxfPjUvIJSEOJR8g0l4BYgxPQQaht9FpswimqHK28S7I1Tzpa8k4Y7Ez8F7RC/j3NGnVi4nNVMMGbcQ33FoJCAVO2TQt+hmrKZk23NrjLO+CRNL2eaRDs+jDCdy0/vpKyGnohZ7HPwXLw/rKUyVa7onsDlBCFShTFndqmS3tK/E2payizGPktNm/bpRhPJZW1JIWbbA/llp47VagPxAAbx0kq0v+Yc3IZA6itL4qX5U5Lch9Omd3G8eqTXlA2SdKI2wodctkOeAPmn+/hNcChksiiMK3dPkzBF95a8J550Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5430.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(83380400001)(122000001)(9686003)(7696005)(6506007)(53546011)(4326008)(66446008)(66476007)(66556008)(76116006)(54906003)(33656002)(71200400001)(110136005)(8676002)(508600001)(52536014)(2906002)(26005)(5660300002)(64756008)(186003)(38070700005)(8936002)(55016003)(316002)(66946007)(38100700002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XcvnQXEuBJgjQKqt9lddF5DyK3eNZosQmcER5jjyJBzAHfC6OyxmtqbwvwDG?=
 =?us-ascii?Q?hwu4iX4UTVTHyheoxm2QIRlrpvis5SrNegh53jRBgA7YWCtclg0kYY9Zvfj8?=
 =?us-ascii?Q?oKy+RM8KY8m0n9IwupkIHJepGbxsFw3/nbGNz73TkjVqQWJ/oxrRfum7whdx?=
 =?us-ascii?Q?MhEZ93DrFqG60Bn8zLPcCQY7XLYMjlJQmkS6bPakFP6ZkWYlkkgRPiMdbHCR?=
 =?us-ascii?Q?6zh3FjWREDoYPJAzai0tSo9HGq7OY/H71+mWHmoaTrWaqlO6Y3TBnPkBhph1?=
 =?us-ascii?Q?7G1U7mh7j3u5UIbVtN/i2ufGpn7dmpAXVau0qIsU9zCIoYcGrgx9hmHp00rg?=
 =?us-ascii?Q?joSJ+edO2TH1OYIQnOYNDtwYOb6SzEPAQe/jqhitORyAddFlsdqOk8Wu2avt?=
 =?us-ascii?Q?SV5j6yc7ZaDQmLixIISwWay6E6QyRLcyWBkWGE2WKEacjGGdcVgj3sTbMM4N?=
 =?us-ascii?Q?vWOaH5lUyJo9NgSUHaubA8uhYAqseNe4qmPP4cwcGaSXG4qmWT5VANN03Pmj?=
 =?us-ascii?Q?VTSqZvSTN6XZ/OSLzShU/YYFKwv1J36zw4KH95vZ2Q4ZJtZUeZT1AjiCJ6U7?=
 =?us-ascii?Q?vG/CYSgo7wfIcYDBqMD1xgk6Nuj2fUZN5GWq+GhAQESSlcJwG4rA5eUax7ii?=
 =?us-ascii?Q?O9RuMUIQxnLCtjJnwObbmZ8xV26TaK9T5kkOEJ/zHVDsrq4Gt4GwBPr8qOIb?=
 =?us-ascii?Q?kmkaVh5G349jnnjR3zcjBCC0P9IPgPW+0f/DXgteZ6Ttba8+tfrSPZ1A34Ww?=
 =?us-ascii?Q?P/NpohbEsYwGKh8OX+KAem63tPNXhB7U3YHuPkjyOo4nbarckaniBfgDPn9M?=
 =?us-ascii?Q?GephGI5ty9u/kaqM27Bj88mMRDx1wrcMGoZF2TqoSii21mZXeymgE1JuQxz6?=
 =?us-ascii?Q?7upRAUvysJdMSTn4SF8e2sevjxe90gM9A8q87dhResnT/oVfLa78ZYRAlKpf?=
 =?us-ascii?Q?b+SPmcKhSKAginGMw/CxthUXHhcXy8F6vGcubSppNTAJu1B7owMvEHvo7DjF?=
 =?us-ascii?Q?lfwsyuMThTvLloM0wmY6QRqcsx++ezVWKhYcoi+jsNcXTbzp8nUb9VkjtMYU?=
 =?us-ascii?Q?6k+N75ws0DNaVcFpyxk+rH68zQJvBGZFTUaLPx91E+ouHDRh6C3YLxju7alc?=
 =?us-ascii?Q?VMs/dTwLzzxH8XlMqSE116JtpJAuiAovEfSai/Y79OgEXKyqL4U6rawe+fC6?=
 =?us-ascii?Q?61Ex6O8KDhr0Ngi6LbtsDsBAYUi148iQywmVlwJCjjMxMJxi3SX0+Pm5HWqO?=
 =?us-ascii?Q?iq+fP5v9hfPCQnhdWfWUMVAOweiici8Y0GmTOaPmPBrHiz1lQA9Ecv3ERhnZ?=
 =?us-ascii?Q?1mvOr/VWAIOhTPTMWOfyKLWtzF68G/eSNICvxX5/IemYlRqumFJSLC0XP4JY?=
 =?us-ascii?Q?TYOJKzvyRJe39aui6NkHi6Zt9LcplGLgv8YqdUj/Fo/ztK7QYZmSmCIPF8p3?=
 =?us-ascii?Q?QERoIhI/CYx6OrAgT0yWpz3Pe7OujVg5SRCRsCD7LIC/hTy0nIeZkeXTuzgX?=
 =?us-ascii?Q?vV0Gr5re+5OoA4tw1U6K2V+muxNEmPfKcGHQaOA+xxj+gPn/W4ozMe/0j0fA?=
 =?us-ascii?Q?ichRhZzQYwPsvR6bonsR6eX0ZJZyfKhCt/5wSATfBZ4BDuCQnF7FO0mUrQWF?=
 =?us-ascii?Q?1EmTNJNAQcNo+dkCXXWpihtQnvZSot3ik1RUA1446O4nfh58HLS6DK8/4xHx?=
 =?us-ascii?Q?v4O8aMrcsQQdImU3ihDeg8lKbDdFT63clFW05ZhltCpUbKNg4atUMV+8Ryz5?=
 =?us-ascii?Q?oQHb4yAEWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5430.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cc1fad-3ff7-4293-a7c3-08da13d72453
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 11:59:57.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDlLimt2Q5XBHl7/kdsmsTOROp8DLqjxEb4AvGo5ChwG5rEpf/4kO2zahk7ZZ+dBdKwYfbNeccjYFmNXPbJWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7405
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, April 1, 2022 7:38 PM
> To: Baochen Qiang (QUIC) <quic_bqiang@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] ath11k: add support for extended wmi service =
bit
>=20
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>=20
> > From: Wen Gong <quic_wgong@quicinc.com>
> >
> > Currently the wmi service bis is report from firmware, it is divided
> > to 128 bits for each segment. The first segment is processed by
> > ath11k_wmi_service_bitmap_copy(), the second segment is processed by
> > ath11k_service_available_event() with
> WMI_TAG_SERVICE_AVAILABLE_EVENT,
> > When the service bit exceed 256 bits, then firmware report it by tag
> > WMI_TAG_ARRAY_UINT32 in WMI_SERVICE_AVAILABLE_EVENTID.
> >
> > ath11k does not process the third segment, this is to extend the wmi
> > service bits from 256 to 384 for the third 128 bits. The 3 enum value
> >
> WMI_MAX_SERVICE(128)/WMI_MAX_EXT_SERVICE(256)/WMI_MAX_EXT2_SE
> RVICE(384
> > ) are convenient to process the service bits.
> >
> > Tested-on: WCN6855 hw2.0 PCI
> > WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> >
> > Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>=20
> Baochen, you need to add your own s-o-b in the end. Please read:
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#si=
gn-
> your-work-the-developer-s-certificate-of-origin
>=20
> But remember to keep Wen's s-o-b, they should be never removed.
>=20

Sure Kalle, I will resend the patch set.

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es
