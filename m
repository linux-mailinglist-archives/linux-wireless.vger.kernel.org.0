Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823C214377D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 08:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUHSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 02:18:12 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:40626 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgAUHSM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 02:18:12 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L7Hu10008439;
        Tue, 21 Jan 2020 00:18:08 -0700
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xkwrce7r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 00:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1I2dXCbXC9Ogd3AlzLZvH7zXSrtS3qJoJtubTeqbM/+UxgzhgZlLNcoCa7Sq6vtck3hGtzVfaqqTtrbhIM8z6XKD0rbEyCWvRIqL/U7xdPKEDfWPMgbCUHU0O4yJDBl8yGjtGATxP/smEo/456eBrCFL3+MMrQMyumRj8Ux2zxayL7b6YI7mA2cx8GyYvN8X//wuRzpnm5ay9STm2F+eLPKq6R9S/SfdH2KwK90CoLRwASqgUoYO4qn2eIyNOmLMQWHOVZD8FsD882KrRMePbC/RL5OXurvRgaTVYmgblQm+K+hyemw7K3Cf1op991bLYmPxTFfNhrc4kgbHQXVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcMrWZ/kcPZ3LeIOHuCPxanVfcQIPy/GUqQjNqdW4w0=;
 b=fiX6luP+/eacoBJ74rM4rM+4Doj+Oq4HA/Vr8KMwYnI3J5/Wq9HcHCDeUKbHZ3TP+n3efduhauSgpKLlfWQNAvVHfZR9aF0oJr/dVX5GN9s0/ZCHD/jSfsNj9iU2FZKlsJ65oig6tHT77cLoF0CDF1dMS3u8kJJMs0zFla2ZLoU7tkw2ELSTxNqwXb9f1SS60heQBS8hVupxG07OBrnzp5u3Qat0hlaC22RD0DLn0Q5lpFvJI6fVQQJ/zgdTLFTrh5Eyj73su7fN46UwZxcO8JuCyLbVE2sWdHycDEs2+wNNZEcahvhrIhNFxb6c7dNQSR5PFq5qHveGQ746KmYlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcMrWZ/kcPZ3LeIOHuCPxanVfcQIPy/GUqQjNqdW4w0=;
 b=AprKorpThal+gqskZ/KbgUVjIYyxXMz3pUUNNn5FrfpRtCayrhXmIdZ3iwdsXeF+2dtjyKAqsupjmO9yepHmhmWMeJd8QccSZkFi15kCaGt62PA9Yodo8qG947dgm2dSYeEC6qV6uDtEwjAJSPhVdHKL3i4uxETTBysEz3NnWgc=
Received: from BYAPR05MB5624.namprd05.prod.outlook.com (20.177.186.205) by
 BYAPR05MB5399.namprd05.prod.outlook.com (20.177.126.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.11; Tue, 21 Jan 2020 07:18:05 +0000
Received: from BYAPR05MB5624.namprd05.prod.outlook.com
 ([fe80::8157:2c66:769f:e06]) by BYAPR05MB5624.namprd05.prod.outlook.com
 ([fe80::8157:2c66:769f:e06%7]) with mapi id 15.20.2665.016; Tue, 21 Jan 2020
 07:18:04 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4671.namprd05.prod.outlook.com (52.135.114.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.11; Tue, 21 Jan 2020 07:17:30 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2665.014; Tue, 21 Jan 2020
 07:17:30 +0000
Date:   Tue, 21 Jan 2020 10:17:25 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
CC:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv10 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Message-ID: <20200121071724.p6mbyiqjal3jjfin@bars>
Mail-Followup-To: Tamizh Chelvam <tamizhr@codeaurora.org>,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM0PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::46) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars (195.182.157.78) by AM0PR07CA0033.eurprd07.prod.outlook.com (2603:10a6:208:ac::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Tue, 21 Jan 2020 07:17:29 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e56ab4-0035-42ce-53e1-08d79e41f9fa
X-MS-TrafficTypeDiagnostic: SN6PR05MB4671:|BYAPR05MB5399:
X-Microsoft-Antispam-PRVS: <SN6PR05MB4671817133F483EB53769E15A30D0@SN6PR05MB4671.namprd05.prod.outlook.com>
X-Moderation-Data: 1/21/2020 7:18:00 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39840400004)(346002)(376002)(199004)(189003)(316002)(66946007)(66556008)(66476007)(5660300002)(86362001)(1076003)(6666004)(9686003)(55016002)(4326008)(6916009)(956004)(478600001)(33716001)(81166006)(81156014)(8936002)(186003)(8676002)(2906002)(52116002)(6496006)(26005)(16526019)(9576002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5399;H:BYAPR05MB5624.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sL1HJ3Z7VoN4aRl1ygbo/blmilhm7nMk0zR00eB/SBIsi2FSeN4o4YJeLKCv7eGsDDp+Xx5T78RvvMgeIz5uEOyVgcxOaesP44fjvVOp4KrNYH2w5eeg3jXJG/M5D5yqZ2gYFAUzrZiEysZYRVGxqgqFBLlTzmrlzrpOdJalCJdSVQ/yMt5YfWVtaGMKCoD2kzPNl+bNm7e6JQ9I8d23Yqo1R5PznWS270QHYUmtNpgHenEbFbNlGcVFygT+cQxO6lxUUzj35ebCrmYuVsOTBGKduLJxRH4Q3mYGmcgZWE1GJAaKiuRjiX8fymymSjXXv0jCCNXeM1Fyrxv/6xzdfoZmQ6MyhATILL9yCOxbIvpEd8f/zTL5lV5r76hG2n7sosv6KsbV8BN+HuJ87lZspI9rG7FcZx6nqqRh0Ni6KRdwjajst/qfPmnyMXkvkctL
X-MS-Exchange-AntiSpam-MessageData: Q9cKL9VOGMPGM0oulibZHbblvQiGQjHGYuWpc0FnCX8Qr8weYFTGc1y8vPHJVDfXENCeW9U5VKxiK0DrXElYnvr9jauAwMhKetBo7N01YQhgvYXam9T7/0RaWGReNsa7x/Mgx+cLUfQypLzcFC/q5A==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e56ab4-0035-42ce-53e1-08d79e41f9fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjYXkjTaVDKwHbLvtNlgow9MgV6I4V32vhsTVLMkHdxuBojqeX9bAUGtHJ9HO/19Ol707LxarHotgqPUWn5kuXbEK0mHQ6Wb2KRizWEJigrgIJEodRZ72sPH8AWFtDOUwv6xOYnIuW4WE5TKls2UMiC1gCVU8SDsAUKJ2ch1ktYDRiRXbzNHrJFYXU/gQSFH8CNka+PymW0nNSf8rm/WCWgHPgd57BTbYB7pkJmRjik=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 07:18:04.4054
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5399
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210063
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Add infrastructure to support per TID configurations like noack policy,
> retry count, AMPDU control(disable/enable), RTSCTS control(enable/disable)
> and TX rate mask configurations.
> This will be useful for the driver which can supports data TID
> specific configuration rather than phy level configurations.
> Here NL80211_CMD_SET_TID_CONFIG added to support this operation by
> accepting TID configuration.
> This command can accept STA mac addreess to make the configuration
> station specific rather than applying to all the connected stations
> to the netdev.
> And this nested command configuration can accept multiple number of
> data TID specific configuration in a single command,
> enum ieee80211_tid_conf_mask used to notify the driver that which
> configuration got modified for the TID.
> 
> Tamizh chelvam (6):
>   nl80211: Add NL command to support TID speicific configurations
>   nl80211: Add support to configure TID specific retry configuration
>   nl80211: Add support to configure TID specific AMPDU configuration
>   nl80211: Add support to configure TID specific RTSCTS configuration
>   nl80211: Add support to configure TID specific txrate configuration
>   mac80211: Add api to support configuring TID specific configuration
> 
>  include/net/cfg80211.h       |   65 ++++++++++
>  include/net/mac80211.h       |   10 ++
>  include/uapi/linux/nl80211.h |  140 +++++++++++++++++++++
>  net/mac80211/cfg.c           |   56 +++++++++
>  net/mac80211/driver-ops.h    |   27 ++++
>  net/wireless/nl80211.c       |  287 +++++++++++++++++++++++++++++++++++++++---
>  net/wireless/rdev-ops.h      |   24 ++++
>  net/wireless/trace.h         |   37 ++++++
>  8 files changed, 629 insertions(+), 17 deletions(-)

Hello Tamizh,

Thanks for you fixes and patience! The last two versions look pretty
good to me.

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
