Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148DF42390D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 09:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhJFHkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 03:40:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15844 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhJFHkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 03:40:55 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1967B1hM014783;
        Wed, 6 Oct 2021 07:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=RUCztaPgsrI13QjlNGdoBAyhzj+hNbgVu9OdaPjif7A=;
 b=PCzH8P3Do1y9WbefBIxGyZENuYWBh5J/Y5SUViMnvywgqNn5wPLk3ecjPiwt0NlXPKEE
 PjVnjr7vETxxZWogxBB0FZsdw/QCjWGfXUVQpBLdrXldqUN/siD6ZMBGCUSuBBTLJtZ7
 Hesfkw01AwmUmLKSTnjLaVJRX2ieugL4dEtF/4NAXMi7b89nySXDk0s6LeBTROO2YZem
 hTW8yI5/TMaR9w7V+6C8GbVTalBEZevwF+GBMo7v3UtqrTZVCJwk2Jmz9vn4NFnt4pOX
 rVKlWQ7XE/0xMeHy4BqWLrgSfPasewM30cTTWXpjimXrtCDk1IKOKEvg6DUK7BWSfIuI +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y590sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:36:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1967a01Z196103;
        Wed, 6 Oct 2021 07:36:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 3bev7ueshs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRGBjrjVXSCVQS05jpjhWMcyoyio2oVcPnbPlyJyJStcWriVnp9wD1ymD/DCR2amDx4S6xDdg3Fvk4YkbV9mDco+MBbD462F5kXHGicLszZ6ZhC6krLcAQwZKUSsgPeywtDSU/z6XkZausPiMGeJ65kt0l+QCLvjOjUNfW8CPF3ZnW/TTAxAJ/O+cguTiDHPp9nayPa9W7didCwd7KZ7jiamJ1xZ4lTvgB3nJCcRxaAqySE/JfwCcN/gJubu2UgLfHQGtHIr7qzak75btMx+lLPqGVc2r0WiKMm+7d5CGCJAMf7etbo4IFaAF0SfR5xuDo65JgdIE4U9HqgR40EJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUCztaPgsrI13QjlNGdoBAyhzj+hNbgVu9OdaPjif7A=;
 b=NMfV/sLgXu/RMXXW/HEheQKaSB73w1+BzCG1qWsH0P7jMd8VOg9GUBSAGQpLIxhODEHHrGzNY/xTG0kbBlPyM2CS8s0bLbFD1a8LziiptYOPjp5NcvVPrWWSQuOX/J1Tz3lkmwxG8IegVFcBjZNxXGJRas7GaStFxR6BdXtfT071KZNl31y5ab8YeSurUUQcZtuscFDNGorbisQIlBE2l7XXKzik3G5lXtH4GrL2aSE9NcPoDbx6xH42zNJhvoksmNxr7RJEJrNS00q4XnOxettYNDIY/DaHh7hFrAqXRy9t7Kc0yrkHg6m44iI5imp8Eq9OmeKhDiY0GZmN9j9kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUCztaPgsrI13QjlNGdoBAyhzj+hNbgVu9OdaPjif7A=;
 b=ipow/mx+bVVcBc63Bt/GVTFKq25zxZuueAgz26+n6Spkq5S/gHvh5a371x5Lafc3MqoXFtmpN0BR6ktO50QQ4PMLtYgH+KwcIQlXzQp0y+TDbP37HOWB3zeu2aXYKQ0hgPice7vLlKlNmsmlD+WXx823CTtizeJD3e/vJsogSLo=
Authentication-Results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4546.namprd10.prod.outlook.com
 (2603:10b6:303:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 07:36:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 07:36:33 +0000
Date:   Wed, 6 Oct 2021 10:36:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Michael Buesch <mb@bu3sch.de>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] b43: fix a lower bounds test
Message-ID: <20211006073621.GE8404@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006073542.GD8404@kili>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS8P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::26) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by AS8P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 07:36:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6af2a66-753e-4e12-ec17-08d9889c0506
X-MS-TrafficTypeDiagnostic: CO1PR10MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45461EF2E1C40F8CB5462D708EB09@CO1PR10MB4546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNVk5qwYrwae1ltFBrJs7VKOWKtDl0nX/hgf36KXjQ68BI5Luy1Z6Y4dat6B6ww1vc8IOaKGaKoQ6dXCQDudtEaNkI/kTaHB/S+q4+lfeNJviOtBQf8i58yxqX3Ls+dENccxyqpjQR2OWq5pt5ToDhz11KPiYiDDIGQ/3P49bPGLYgtmWFsXwZjh1lDfP5qdbBD7rU+frbLteuL59ScTMrOV+ztujvZjif3OuYtyIs/KlAEk/i7zo/Wo4+fC09TtnC0QCFN7l9Gv5dY3cq4GJll9fOxN0kTAlWHUAo/2pL7btt++uLln5AmuFSX5l2ul6wZEZ/E4u745MMweRn4AQ9Vpolynr7FUrJ2zcMix6LkPH3k+A64Wx/fDzS90qcbaiGbMn/g4sh6wXO3TCVw4yNQQPfw8XKjCU94TzGNWZarYdEwoATyocB7RpVsmsjBzbAAlGtnnjaxLJSA6lbtFuHFhnSL7nKLMP4Mm2BUQv6nfDEXCjvR/ZaXciW6OwuAxgoCL38NbCKmjVtJdyqBLPLXF2rWTVURxqs54PyyScT4bs4tHE4tnaoJIs/dYMAmQS5tYXkPx2QhOWIBePSMLFEwXw9iJ7Wehh5qJrnO0E4twFHICBnt7l4McgW1Q7wX3A53HwIXGVzVdSalFIMOTH5wcoVOwlcocICKtNcRBvLLHZEdoNqfzqnpUUMEA0R31Fd0ORLAQozdiEsP+iGvISw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(86362001)(6916009)(33716001)(1076003)(26005)(508600001)(6666004)(44832011)(956004)(4326008)(186003)(2906002)(38350700002)(52116002)(9686003)(6496006)(66946007)(66476007)(66556008)(8676002)(316002)(8936002)(38100700002)(33656002)(55016002)(9576002)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUxIvrDmORY7QRPERUwRWt7ILR6kmZxw7+CTGo0iS7j9B0MKtxTMOQxPza6M?=
 =?us-ascii?Q?xkw9DLW5YppNw/DFIP13OvjfVRw8DTrFoUjXV1CDb2+aBqsuibydAY06wX0w?=
 =?us-ascii?Q?URmQAkSGVZ7ckRKd3l4OS9wpRTCkyBQkcqaZcjrFQzbKJYJlNDZW26Lu9DNv?=
 =?us-ascii?Q?izOhpozdBUR4M+9/+63Dbtdzij4bMEafdsXVQDgA5YER+QQTo37h01I/PAUE?=
 =?us-ascii?Q?5KYTRnp1onSPVktMPXpcTDKPtmebdAd8N8B9RmKTv7liC9YCnRBtWtrk0B3g?=
 =?us-ascii?Q?96Swr/FRT1CsHG7L7pv55OyJ2phg/bMAuUTEYXAzJeX7dBe4GCBQvZ4/Xjx2?=
 =?us-ascii?Q?DYy2hVzeUlzoNRgQKu8Jypo4OfJ0u7mIG64yS5cSkmwuyodcFtuRuahSd2lO?=
 =?us-ascii?Q?tDqKqJ8PwdfsRR8tQQrRWaf/80HuNHs5qe64my31pRLw6h4TzEiZk7/Qz+rN?=
 =?us-ascii?Q?7Pa9Z29ZbctuT8OlM3FQN6z/j1SjVCrj0Dk0b9PbpEElebscAmcEpMSgrA0i?=
 =?us-ascii?Q?KdoQpzNS2BkpvEjI9NDTTTMrYu5RMrmJMxK2uTtGbJhQR2iwRe8HLxswup3T?=
 =?us-ascii?Q?aS3uprbtvhLuzaK83ksQ4Q+tb6NAhOPHTvBhGEjQLouzEE4vE1phjIf+2Ev2?=
 =?us-ascii?Q?hqyf2t4fmFs9c0kDs1QOcGhCYa7XUSXz+PhpGsPchJte7KleoihtSubixD9O?=
 =?us-ascii?Q?YqHsQtGPwbBqMQlyyhThQKw1OnwyYa4+pbfRFAe4R5jP859n5OTuON3i3Ncp?=
 =?us-ascii?Q?Q/yIjUVuPeEctFBpOnCHeBEaato/E6HpJb7omoyllkzaJvi2gz8eRgDHsvY9?=
 =?us-ascii?Q?Fj+9050ONMRJUdTqpQLLKL6y3+4Rtjy2gqnK2bwSd18KgYw+vKvMs6iSp/0O?=
 =?us-ascii?Q?erLSd21zvAWDjIteeEUhzTnEE2R5VTTYMC0Vxp6PfJu3GzcpVbbVKvWh2lKm?=
 =?us-ascii?Q?Jf9rPXD9KJ0eyipWvdLxcumIQi8vLgt9/0KQvBKDsFUsMhi+/fNZ3gUfPzJ9?=
 =?us-ascii?Q?brlGgbwYqQ4pQLDLKTE6oPR58MJXcCGICrpA5u/wnomjAA+aKJ847+YFEySt?=
 =?us-ascii?Q?OJcqGZsMCyTYbBb6tLzstxptBX5fF6uHUT95jGH28dscuH1DfmD1xmIO7In3?=
 =?us-ascii?Q?tm8F2Y8I5SNEUkwfnOs0LrtfRtqOcCIpaoDsQSMWL3F6i9I5kUiP5OqNS3Jg?=
 =?us-ascii?Q?zJNKTqMl1Zu0JUx92aLMujVv3Lz2+JjekH/0UxMOW0qHH9FhPhdXsUUi/YMV?=
 =?us-ascii?Q?0FYU/tB1dCD9RfnsRVi3G1mIYA10wtePSNBMrjOhd6jewQ2n4yCaB7PjrFLy?=
 =?us-ascii?Q?VI2JujyVeJYxck+I9vpeNVP9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af2a66-753e-4e12-ec17-08d9889c0506
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 07:36:33.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrLnFwD2r3C6fqtm1ZhmfOgjoCIdGqjZrPZL6IvUbIFyUoBXopSMMCT54w/DZnmah4aq+JH6HEeeXQOxTx7p3iam2AyBEEJpmCGwbcZ4Hjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060047
X-Proofpoint-GUID: 4Ic2UQjB61Sjm7jCkVqLO6u7bPt3GDHe
X-Proofpoint-ORIG-GUID: 4Ic2UQjB61Sjm7jCkVqLO6u7bPt3GDHe
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that "channel" is an unsigned int, when it's less 5 the
value of "channel - 5" is not a negative number as one would expect but
is very high positive value instead.

This means that "start" becomes a very high positive value.  The result
of that is that we never enter the "for (i = start; i <= end; i++) {"
loop.  Instead of storing the result from b43legacy_radio_aci_detect()
it just uses zero.

Fixes: ef1a628d83fc ("b43: Implement dynamic PHY API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/broadcom/b43/phy_g.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_g.c b/drivers/net/wireless/broadcom/b43/phy_g.c
index d5a1a5c58236..ac72ca39e409 100644
--- a/drivers/net/wireless/broadcom/b43/phy_g.c
+++ b/drivers/net/wireless/broadcom/b43/phy_g.c
@@ -2297,7 +2297,7 @@ static u8 b43_gphy_aci_scan(struct b43_wldev *dev)
 	b43_phy_mask(dev, B43_PHY_G_CRS, 0x7FFF);
 	b43_set_all_gains(dev, 3, 8, 1);
 
-	start = (channel - 5 > 0) ? channel - 5 : 1;
+	start = (channel > 5) ? channel - 5 : 1;
 	end = (channel + 5 < 14) ? channel + 5 : 13;
 
 	for (i = start; i <= end; i++) {
-- 
2.20.1

