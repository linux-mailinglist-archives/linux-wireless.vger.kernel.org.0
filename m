Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD504FB565
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiDKH5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiDKH5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 03:57:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EED13D0D;
        Mon, 11 Apr 2022 00:55:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23B7arWs028178;
        Mon, 11 Apr 2022 07:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=R71wek19mnkmLUQXJ0d5OzUBdNQ/GXEIMyWsPwKvWgE=;
 b=Pb8CEkRY84+3sKfdDJ8HDyOyY1hY4QnLFfOKBroAddg/bwkIQL/lk03sH+hRnJlVOajv
 Q1tVTXhImXxz2rIDFx8drq0ll2OvaD5kRjy5W+gZUikd/Zou6gXpJ86Md00YCUh8pAL6
 r4SRzZ/cR9zmR7ZMhOhdlck1FAkf82MjOOm32+2oqn/c0PaRHBcYGore3Lx9IEBL/VQs
 dSJ5TRwYBNQGg5PHLFYkAPRcaeIavMaVLJWBnX8LGPis5M7q6itGZuALIWo8VriJmF27
 dVEHF49v6ZF+M2WgHmPZAvEw3A6zJbgbJuRZQ7YhdywbCeNmeYZPrC93cUaNZHXwsbh+ dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219tpd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 07:54:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23B7l6tu033556;
        Mon, 11 Apr 2022 07:54:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k16rg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 07:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaHA40VHFa076BB8YcCA/jwJLatxAXhwdgPfW2KDE1jpltMmoqXRFSgQQervCp3q8XXhcJyG91MQVIKo0DJmZ+K3/jxIiJs3yfXN0hLJGXCnUVAndfv7xKOF+T/jBBCtM6+/pwTEDqUWmPWCPpQ0VOHl4MqnhQvRfn2QSvQC147nK0Yav5Mos+pyqXciJvxdo48lDPMChLlJvntycBxvrrnb+T5ReD3av15bv77Kygfot6dNK5KkeuJY/TRMDiUTSWgjStY94/WWLSBnlYhP/ucmlMmsUucKW0fqBY1FDzneO5tSn4zSDA2kfNm8eiYz/rVqS4/qkFhye76xwhSKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R71wek19mnkmLUQXJ0d5OzUBdNQ/GXEIMyWsPwKvWgE=;
 b=ZUb0P2dSLzA63Qf61crC/5FbV3losWHi3C2VuJ6iWu4/JjZQe7hKjEo0WfSI1tAmRehdRC2kwrzqzrMbQd9we6MM5Lthqrw99hoQqbHt7N9ZgBM4SdftRXm+vzQrn2RIq0r6bm6cfADoCfJ3zq62jRuuTR4kbN/ZQDg7uUCixDBNAS3VIApfu18Y8rVj+0hg7Q9VsoIk3FfaaLmCVZhNaI6yleyoHW3AsXECDo5BJd0q2yFJh1tcMMBlL6kHNIaxHdNsTy1MPb3mGrBJFTVdobup5V4sO4VVE2Lf68S6OKigjkxGdO7iuQLiaviGiEGDRu+B3HtmGbm0xDA1W0yJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R71wek19mnkmLUQXJ0d5OzUBdNQ/GXEIMyWsPwKvWgE=;
 b=Q11uS/0Sri+fxdJ7kTuXYATgs2E28yT6xr1WdjQnuZm82o1piqf2mUVbb6mwFDO/kAsjQiLqXAcJ9s9villHoEGfP5BRwFBvqWe3BjmotLI4ku7fE5dNFTS7xRV4q+zQ6lfUesttrBkBXQHmF4TCBDlVRdUr8CXBzrUgmlzwAK4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5478.namprd10.prod.outlook.com
 (2603:10b6:8:33::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:54:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 07:54:26 +0000
Date:   Mon, 11 Apr 2022 10:54:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oleksij Rempel <linux@rempel-privat.de>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid rxstatus->rs_keyix
Message-ID: <20220411075403.GZ12805@kadam>
References: <20220409061225.GA5447@kili>
 <00a0f9f7-2fbf-8883-38e7-edec3687e6a8@rempel-privat.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a0f9f7-2fbf-8883-38e7-edec3687e6a8@rempel-privat.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26346039-cb2e-4adc-e4ed-08da1b907feb
X-MS-TrafficTypeDiagnostic: DM8PR10MB5478:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5478BBAC48853887EDEF82CE8EEA9@DM8PR10MB5478.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbflHLKVvtYQBPGUjepPKLr23VORfnKV2JKiPS2wVhg+sByQDtM2GjSDmsd9ttL/e6fbh7ApyrPo+6Wp/yF+nNGBz+P8GMYmLfg9uK+Ph/LGBFZuO7/EGDvN+arRVbu3cimVML5xsSiyVUinInGIdfJghQXcL9yd53q9zWcSJ18d/sbOf7jqFfwKzyLMM7rbE4SLjptSxLMyReRGvKDtCzf/2zbJ+U1yhIaKE+cCmUS+0Rf/EJuj4G2pS0eEoV3/yHUWXQxPp0UzYGolcEW66ZJQihyPc5+FDWT/LsJUwM9fruTpXM42vjnr926Fd56p3X+2Uur4mrCq9/GcJTul1SDJ3DAVjj5OsOi3YIrWQQnEc9ExJHZZxyCmkCWLxqhBSfVq30joOoxD6+gtofJNNsnAXUt/LAXOiROGQ96cgWlgqHSOoVEOpHhaxAkDPjTMbVl220QTxuNpsvt7O16QxuvPxgnJ2fuwBQApgWUiXxkwiHkE1Bjr2QQd0Labt+oaqzSpQ4NHbkrK/5CFvabObLF92RxhCjG9OAArd1HvjcYYCye/LfOMFOxchBg47GD+uFRHV+7Fpxzr2y6RoCqsQlIRvr2oK0GvvETPCernbWyPAA7UKqChst7DFHx0VZd4KVC2mLxTL+579xWnMqHk1XnLLKu5D8RQvuXZF3tPXapjOXs9qUEYK7AJtaUlT7RB6MFjTSK3uBObtLLGY/Uadg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66476007)(4326008)(44832011)(5660300002)(8936002)(33716001)(86362001)(2906002)(38100700002)(38350700002)(6666004)(6506007)(9686003)(6512007)(66556008)(1076003)(26005)(8676002)(186003)(52116002)(316002)(6486002)(6916009)(54906003)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PPYiSyiTdLchwq95IaWj9WXOd4S/YigWSG3HcvdAygI8kXvIoJQFqeczd5vf?=
 =?us-ascii?Q?mM0IE6tlOfBXH9m4mtUK0SHB4cFiWaa26bo5wS9ZXuGzD6r1vd5vwJ4XApV3?=
 =?us-ascii?Q?u8x5TDtgjgQH1axKmro6D6ZmhUsHc08e9OlOTugkofOXVXfjaYd+lHbW9WsU?=
 =?us-ascii?Q?R/lKRjkckrdj+iQMcQ28wdZ2MmXo+Me2+U8PnjxGGb62IVSK2eopgGodTBof?=
 =?us-ascii?Q?KVlbauA+BqSOGGpRxmhORuCP2fsunU+NWlSlHRUzljHwebvOVPDMClVwhh+K?=
 =?us-ascii?Q?CwuyQ8a8Sh1A3I/Vnpt1g8TyMAO5/0aP8IPOEkPK/NteqFecSD7FNzzy9D0v?=
 =?us-ascii?Q?ZfFkqxcu/BQaO5aiyR97MEMTHuuZA1DjmtCANK6gh7FvahvHfd0wnQ9ZcRp2?=
 =?us-ascii?Q?7Xk8NARW2ydUKbGL815IS+6V9U53KQJs22BLlG1swMnRUGEIMeG1o4fsvSYk?=
 =?us-ascii?Q?G392Ax2yTQwmMBu0pwu0bcp64diOBlaiN6xsjpC4Ot6tPLQ9cyDvHnY12Nyr?=
 =?us-ascii?Q?ihJ8HK/nAwGDxwnPqL/2U92pegAFV7k92yRaQLJDXoiliG6q90pL3kOQw5OQ?=
 =?us-ascii?Q?XHfUB4ohMtmjxLelpCjlxQ5uJNYR33QHmz7eN/b11gHnbw2q5RKazd+6EhqO?=
 =?us-ascii?Q?Z2hKWvsH+uYJBKkmdQ+tqSpXg8td09f6hdObmlQXh02/7nWUDGsmCDgq0Twm?=
 =?us-ascii?Q?Pn42FEHMWmFDjVVrmoJSlmg83q4/d0fOLNUzfYJsrRTKiQ2z1M+ZXdwPl5x7?=
 =?us-ascii?Q?UWDXPXuJNgAwr2Dj1msgUj9nMdFC8Ihs4g9qXDjK2umd7txzaZ8P+dyOIa81?=
 =?us-ascii?Q?CDEmw0TiUVkFWT240csOF0IIzm2nLEW/i4eQaF5fyi0wAz/3VqTV3IC1K8N+?=
 =?us-ascii?Q?ozGSFNIj+JsKCKR6fM9QWBFU3UyZwtBKQU/0oZrZNEpCWYf+Kht8o4ptVMnU?=
 =?us-ascii?Q?vONZkpPoxr19N7cDIZpMu06xfTayj2jKe9UeSUSP3GIaTwaQK9K3v1QagbUk?=
 =?us-ascii?Q?zrhjov6UvgwtETwOa0PmQA3/B4ML508xKacMxX5oY+Mna5UK/ekf9PFtnf6j?=
 =?us-ascii?Q?PtMurZURFPw5h/wsAN6sUqx+EPUCVxwXe47HFsoOdNZFo6oP2gfW5qe3WcyM?=
 =?us-ascii?Q?sXnxX8IT+S5NDc8RpWlsdZQl//xRrSLMbhYahBn439E5ez/Yfj60iChIIVsi?=
 =?us-ascii?Q?gDZH+hpFqlCNncBoGXCRXJNbOHc4r63VjHWzZIUS5ElT07bg1Db3y5Gx/qGn?=
 =?us-ascii?Q?8zJK8/KxNLgQQiA1hI46tMwfAeNxceZrJWCAq2MRY7s9rM7T56WvGCunwBrk?=
 =?us-ascii?Q?9co7cZ30SUDTcc7qle5zXXX2kYcrfP26VzjY8DO4zL39DlRXJd2HsTJgGiol?=
 =?us-ascii?Q?gjtUXGL7AhflytIcvpcGxY7ycl8XQZvrJBlVGEvbU0PKW3FobhdpdagEO8co?=
 =?us-ascii?Q?7pARRmCnL61XRbzH9Bqs3ZNimmdilQu+Ax0BYSflWCUgiu1KqK/rWLyS4Txm?=
 =?us-ascii?Q?YKIO0X39OebefWWCp+Wu4T7Twsf7vS56Gf+NkSXcFi80mAHyyXHDW36xCIXC?=
 =?us-ascii?Q?CcuLscQ0iHi2ql11hx4vjcwAsvAwKk/D3EG7ZZ+sMEIcARaYXD8CL948C/NV?=
 =?us-ascii?Q?SrfMjNz2tJZu7IkOLBlAG6MYPqPkg1DjHuY6eXX3QN+JL9AHl6csRGsmo7m4?=
 =?us-ascii?Q?f+60kYLLxiib0AAMcG/+9Ynwvebfdsu4G4T8e/gSn0FYYu1uXErEwjhnMgCz?=
 =?us-ascii?Q?NH/acFI4sUeEOZYUwG4X6N0jL5odsA8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26346039-cb2e-4adc-e4ed-08da1b907feb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:54:26.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bppKqMOgBUKRpAgB7v1chXqZVXQb3SdAMR4BbYHDa/4pQim181luIGONvxHyPN1sSg/O7+Y/72IPPNVawlGrg7vZdLb++EWocuonaH6ntAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5478
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_02:2022-04-08,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110043
X-Proofpoint-GUID: bxROymkyYl4m5k3VOq--RwUS3sKaJ2wM
X-Proofpoint-ORIG-GUID: bxROymkyYl4m5k3VOq--RwUS3sKaJ2wM
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 09, 2022 at 09:53:53AM +0200, Oleksij Rempel wrote:
> > diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> > index 6a850a0bfa8a..a23eaca0326d 100644
> > --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> > +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> > @@ -1016,6 +1016,14 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
> >   		goto rx_next;
> >   	}
> > 
> > +	if (rxstatus->rs_keyix >= ATH_KEYMAX &&
> > +	    rxstatus->rs_keyix != ATH9K_RXKEYIX_INVALID) {
> > +		ath_dbg(common, ANY,
> > +			"Invalid keyix, dropping (keyix: %d)\n",
> > +			rxstatus->rs_keyix);
> > +		goto rx_next;
> > +	}
> > +
> >   	/* Get the RX status information */
> > 
> >   	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
> 
> Looks ok to me.

Thanks!

> 
> By the way, rs_keyix seems to have a wrong type. It is declared as u8, but used as s8.

That sounds like something outside the scope of the patch...
Why do you mean "used as s8"?  Which function are you talking about?

You made me panic briefly because ATH9K_RXKEYIX_INVALID is a u8 so it
needs to be u8.  I would have thought instinctively that u8 would be the
right type for an index like this.

regards,
dan carpenter

