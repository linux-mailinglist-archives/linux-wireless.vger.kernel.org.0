Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7232E1AFE68
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDSVYJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 17:24:09 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:34430 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSVYI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 17:24:08 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03JLIoV6021136;
        Sun, 19 Apr 2020 15:22:23 -0600
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0b-00183b01.pphosted.com with ESMTP id 30fv2uatty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Apr 2020 15:22:23 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNXqYJububWlf1w4pevLilzyL5aSKywbPku5bRgKNBt+B+yU+YpcexCzhbYHO9DBaQVftbwyO49GeI7SENTi8uFeKr2TZ0tOl/wgVbXoiOhf57Flb7SLv62eZNyfv4pKFkHmVUQZsuRRjSaxdVjGFidbNqJ7WCDU9CrM8H8icD5mIO8VZdCtPg2PvUnkxd4XCsseLfEwhjELOtnLOzBLL/Sygjpv+364aXDbU83ViVMdqlin3Hxm6u7XpoCdytDP5OZE/Xfmp6WX6KfYz7cL/JLKaO+Kdo+SwZJJkwD5v/gWYaxQyX1qUBZTglWCtVbNh47qyVW3Zp94KUMbGrzZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qxa4d4a25/O+ohZXZMUtHRhc4a5bfo1oKIkz10KcKc=;
 b=j1CFYZhaiMKgUyQdD/Hl2m3WFw+rORBoU7M9EKmTqEBuKI2o1ItdlKjPz04UWJbLCdo3yocBiFEl8OeEl02nwjmyDXzTV5fa5+4dAPjP0lTi8LJWK7JR4TIV+kSHN/YhKlGLT42YaV4N9OR/iP7VWXbZb9xg+MyPPyt80ZBEVyU7zG8RBDLWugevvccHW3kkUPGLcvxC/vmQFR1XgVZMqdUGGHS1TyyGuUY5Y06YM/jtpNZPDQEqejoyUhvYmaV/qpBM6p/dlDTsJN72S6M0ydhLcutYC7qHDOGIUDUCmQRks3t9uh5OoKWfn+TpIsFdPcCoj4RGWKi3+nyMFaqCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qxa4d4a25/O+ohZXZMUtHRhc4a5bfo1oKIkz10KcKc=;
 b=LmUke3/a4rUWRfjIiz0mAYD3pjX4awDvb36BM3QjcMavVNYgZLggR+xKH/t/BC1oKb6sSnPN7r5VaylHkpAPsRJS6XwGFtshMFw8evxDSdhpHnRHFSQDD0cOB2butuZK7cZHMBuvdUX4h0L8bnVvDOg2Vx6tM76BoaT0OvFBBe4=
Received: from SN2PR05MB2445.namprd05.prod.outlook.com (2603:10b6:804:6::19)
 by SN2PR05MB2464.namprd05.prod.outlook.com (2603:10b6:804:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Sun, 19 Apr
 2020 21:22:21 +0000
Received: from SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::eda4:17cd:9f9:c823]) by SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::eda4:17cd:9f9:c823%3]) with mapi id 15.20.2937.011; Sun, 19 Apr 2020
 21:22:21 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB2981.namprd05.prod.outlook.com (2603:10b6:903:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Sun, 19 Apr
 2020 21:21:59 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Sun, 19 Apr 2020
 21:21:59 +0000
Date:   Mon, 20 Apr 2020 00:21:53 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless@vger.kernel.org, j@w1.fi,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH] cfg80211: support multicast RX registrationy
Message-ID: <20200419212152.vlkmpackkrqlcna7@bars>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, j@w1.fi,
        Johannes Berg <johannes.berg@intel.com>
References: <20200417124013.c46238801048.Ib041d437ce0bff28a0c6d5dc915f68f1d8591002@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417124013.c46238801048.Ib041d437ce0bff28a0c6d5dc915f68f1d8591002@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29 via Frontend Transport; Sun, 19 Apr 2020 21:21:57 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5059a7d2-acc6-4316-4b8a-08d7e4a7b1a4
X-MS-TrafficTypeDiagnostic: CY4PR05MB2981:|SN2PR05MB2464:
X-Microsoft-Antispam-PRVS: <CY4PR05MB2981F2F8469EEB9CF3960832A3D70@CY4PR05MB2981.namprd05.prod.outlook.com>
X-Moderation-Data: 4/19/2020 9:22:18 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0378F1E47A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR05MB2445.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(346002)(366004)(136003)(396003)(376002)(5660300002)(6916009)(6666004)(1076003)(86362001)(4326008)(55016002)(9686003)(478600001)(2906002)(316002)(8936002)(26005)(81156014)(8676002)(956004)(186003)(16526019)(66946007)(9576002)(52116002)(6496006)(33716001)(66556008)(66476007)(4744005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kzFaJXKlm2v/vBFD8kSD3Doq80UphiXfiH4qqIehgsGqy4YuGm5VM2R2Ud35Yn/w3BL5VIdpgjntXKP65i+V6Q8tqrWd8X9FgwbNvGReQ8+2a/ij/mHf4BKyAMPUt0ML8ZnfwvXqMm5eDXolkv5U+C1L+ltdA+iGVeJjbrwW3uZBqIVzvGiZsIfvJlAT54D0KHGVW6kzC3O2DLRRg+/dS9ku/jE+OKYsIw/h+r/mCIh04m4WK2zXifMK9Md8csF3yEPbii3KbzzsIs+UBZwrxRvB5zb7y4CwaGfAQ+PsKIwJqfltEBDeeU/JRF90f7m1zboEvMBl5/TStY78qDSzS4iVu+GvVRLX9LAaIdtRb4vhxsjydGZ0HIEO1Xby6tTFjsGSe+ZRBGHcrGvhBk39+FPExOSiNyPAt1zlmsEYYXVNU6pIoy5XZpDYFbYD5vo
X-MS-Exchange-AntiSpam-MessageData: LJzL9tSvHG+hYXP036zNSEQUuLzBmgYFBbyJANDw65+Z6i2BrY/x4F7Wu92LUU3HzW5vnEmIycjhS0XIhC9iXZ3O3uTVXKw9OVzvVvBHRAaf1VlGVu81xmhJRdCv7eTDTSfHR8lE5gHf6FdrLZnfdpanCt/cC4k0UTbLF9BS8dAxIQj1sE96K98sPKwVj/d5Yi2N90zjSrJhcTBK26tquCkFWi4/S1pnrWIql54x0QQQriZ17Be9b6WjYfbeJCN5LBRVx7suPzVeWlPVGG1PFDJ6+XcuFSLOY+l00Cr/WeL+C5QbrPf00oZAoSUXYRZ02CUGqfUfa/MzrIV6/mUrxizZOfbIwPq3fYBIE1p1XBIz1+SFhdxxCEV8uO9ytyxUg0fP8KaM2zERTwQ+0KNV82WXRG8FZ5Os3dttFzecMJODhX/IF8ILUbOXeX6tDyZ+dspQXQBlm4j1cKUuwROl70ixZ6WQRpPfw0Wqm6+YFM1SGa5s7QX/63YwrfrDv47WtozdbFBGc7cd687qOYyTk1vwRMzAmaZSFQepaapxTvvcQcT035T30LGLqSyRYtqi2gwaXzPR7icT5Cj/ASh5QwtllbQDdNRoedWVDdcCgy0qQSn7OWLNJhBXvFoma4lnk9CCQ+avI9H0QAy24rcuyeJKbGz3bmAGkxb4k7TuBtCnMJNEdJsw6cebLBkM6vmnlInYxm68RMuesl2vutwjqO5VW3qTlMf46uD9dEHMg76NDkDEJ/IVYPs6Et1qVRkizuTy0zSnTrE7t1yVsYnUa2DRfKZyYx0FO/hhDmVUh+M=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5059a7d2-acc6-4316-4b8a-08d7e4a7b1a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7CC0qNsW7yoWi8cRungG2eE0ku/7y7keszMnUutFOoxxnS2h8NCI4PHuJsIs/fw52RrqxGCPqcARFxEdkGBMBFOsKIDm2OpQB28giyybJWJjwO8v/58JqiBk3oH8CW2S+hsv2GaJWbfFR0W3YuEEwZl06MzrkVogXif8jb+hC10ZMSmqXOAaU3H7Au3x4YutZjJ54LFxj1u2n1539SojoVnf5FaQImyHMzzAbQhbR0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 21:22:21.5332
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2464
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-19_05:2020-04-17,2020-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=427
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004190183
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes.berg@intel.com>
> 
> For DPP, there's a need to receive multicast action frames,
> but many drivers need a special filter configuration for this.
> 
> Support announcing from userspace in the management registration
> that multicast RX is required, with an extended feature flag if
> the driver handles this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/net/cfg80211.h       |  4 ++++
>  include/uapi/linux/nl80211.h | 13 ++++++++++++
>  net/wireless/core.h          |  3 ++-
>  net/wireless/mlme.c          | 38 ++++++++++++++++++++++++++++--------
>  net/wireless/nl80211.c       | 10 ++++++++++
>  5 files changed, 59 insertions(+), 9 deletions(-)

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
