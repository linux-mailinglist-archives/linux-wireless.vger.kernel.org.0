Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C59589812
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 09:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiHDHGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 03:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHDHGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 03:06:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D02F64F5;
        Thu,  4 Aug 2022 00:06:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2741i3ul019763;
        Thu, 4 Aug 2022 07:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=vtFIy8/CgqDbXzpD4lWFoY5fDO6rCBWvJmgXbukckzU=;
 b=tnNu5WKeLwzYqP7EfVuee2gjan5HPom8O+CZUhQJVhT/59T8Q1nieYDYKIC9WVUvHTzP
 nwAmva37J4dJ5DpOb+O2PoxIrmdP5VZkNXsG84REnSTC2vnstW6Hgvqv2gyWHEPvIxU2
 f6R82cyxy/rbhH67RyUCkaBtoRhkpVCX8xX7K4tABafrd2wOH+HXaA7wr4zaNutXUfBH
 OaMVZ/b9RMCsUfUkxKUW+8dGeYFUn8xPTt/onr1wjJVvFeYLX9/ThYnBWac3bK9EC8h3
 R4P5jnNxTyDyXlbpebGx8PMhq+3XcAF+ivOadlJo5hYtogebtHpkorHN+rw8Etks+gGO 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2v4tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:03:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2744i8FC007572;
        Thu, 4 Aug 2022 07:03:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33qxsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hoi9c/ZepzRO0gN5BOjna8e0jAto3SHkL+xuAzrMjtxlBzi/z+9o8EU8A0BpF1ICSXLryC3q3y8m5UNaL28JUixBws0oEicGYYOnhrXv2b+VOePz2Zw9wmUdhbp5/8gaNwKioJ2zdi42N7GCZWIOKOvVI8+xScBZG8jARtv2mWqTRXf/VAWnvAetPgBTGjvxUOb9jTMT7dh0vMccGkhcEg+XDNFW4oErcTPmJqNCB/TYOqDIRP6H7Md0mdOTy6C1D4hIbnb4D9bepAVcJSaoxQJ51QQ/jOiKLGPzsvfcv87SXqm8VFM6Mpyq72esf1Xu+4fAn3ka8PFI3DT6WdXYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtFIy8/CgqDbXzpD4lWFoY5fDO6rCBWvJmgXbukckzU=;
 b=eBnV5jT30uyW3YBuwNd6ktry4mWn+SLeWHhHeNWuMgDy+jDqFFTB/mEtwiGnpkahUn5nyhRASCQ9/SPFSABxC5MlVFUoVmY7rrldLSSc64tj853APAixuc7Nw0McbLV5Fd12w3Sm+8t1QrKPrBxYO+wQprNAW/kA6X9/8Ld1CH5b/J7axLVMXentGEw/EcTtdEf8euEEuGxUBkOT7hgllWtKMng563gGmlPq8fHr8JAN9+jCQbv8fZ7G+syNgo30g8hbrbIlCuy0NEDTxmP+d1ey2CbovL9DDQOAZq+9N93XRUEvZO1YCd0l5uHuDghk5/jbygho9hHkQhrM0vumdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFIy8/CgqDbXzpD4lWFoY5fDO6rCBWvJmgXbukckzU=;
 b=G/6ejh38KIa6t4Y1PjCEHVsujd1LYsFAw7UWypukrGNP/pZ0BsI/mMlxIvb/3CCGsvlhXOFt1dg7vGOZtemII05lH905nSZIOc7gFYwJV/BHlg1uuq4h+V+FSxmZXmYIyDlDlj3BpfesMv2eichLhZFIsM4XsRFt/qROl+D8JOs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4328.namprd10.prod.outlook.com
 (2603:10b6:610:7e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:03:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 07:03:31 +0000
Date:   Thu, 4 Aug 2022 10:03:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cfg80211 debugfs: fix return type in ht40allow_map_read()
Message-ID: <YutvOQeJm0UjLhwU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cab5f65-1a9c-4824-1c73-08da75e770d3
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+bFFnJ4ayFD7pDkq6w+JdVyGgngfqGYrtCRav1mLDsehNm/xgU+K9qu6ldGcRHLhT8ndxMFDRPR8Yk0neNxJe/8mMFyIqDDoQ1UCoK6yFptC2gq/jGts9KK2aNegveJfpIWXl5ka+EuhkPMXytZrVm2HbCWYkWBC/GwebhOnYGuaGqz1siey2OghfcWnev4VQXdHZhsMtTO8SHXdFtT7zvmp5inTvdQyD57lVXmdj8mTiT7DEsq5df2RanWsKPupJUce30y+F8xPj8Qnnd7ldC+nuJAbATdTyIlAY4NbmChJH7cfGlCtHXbosOGHwJXpBMvsXhrWxuLX7AS1caMONTsS2DEh2G4D3wIOjLFu5HAVZrl5EE91aYUMYQhBZSPGT+wFDcA+81uSfJkUyebIrPRLGX8vD//gBVmIhpncqxSGt86LhPS+4SfCxfeHpML8rOFWvK0ma+kH7a846DDpEQz3BJibwDeDSwsiuKirW5KPKSbOtgolngz95F9bCYsgY4zdsp1mh9w7IlBgCjYQPs2Ww46O6A81w7wVGBzff0fU/9R5JTPW41uOSn+kuCm2FzZi2/TcSNvgDGcvdnAFzcd1Ocs1uJg+tzuM6+H2DVL9OBCmeX46l1tXwUWjjTxrERy6KW6ThoHTCId6jFALz6pxCayeMJD0M9xFp9GL9WOnksvYq6yepSPUcZj5YIZR+wr9y+32LZza56hmYn6DGuXLxOqXjkwxwIRX08gEq4U/OL/vpqGNxVuXMjpCmusjOA7s/RALbjOSIaaP48iA50u6MOqnlpLNjbK2DAmi83ljf/RhmibyMEuDXqHISrVCbLiv7rdb0iPU/5ZBVizhkWLvLHOdJfZmjJP1B56U3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(478600001)(4326008)(41300700001)(83380400001)(26005)(6512007)(6506007)(6666004)(33716001)(9686003)(8936002)(5660300002)(2906002)(4744005)(44832011)(66946007)(86362001)(52116002)(66476007)(6486002)(66556008)(38100700002)(186003)(38350700002)(316002)(8676002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTey3YElo+0zsmBqSSu2PgZLg723IMYsCSanHUclL8sRFf4m7OtJAoN9vEvX?=
 =?us-ascii?Q?RohwNGHhi0+MJbSBlcDCjs98AuGAk86qrQWsS88BhD/SN/Elj0aomDAb6TD/?=
 =?us-ascii?Q?3U945z78GXoewZ+IoTg/8hcQOgMywGQAfX7h50sLHLy+SnNrr0G9GZntPC/k?=
 =?us-ascii?Q?mHcJoC8GDt143LJUHu5jmdPA4ejKepc4j01rLjR4qaalRBbm332l0Px58vHy?=
 =?us-ascii?Q?/kTzzKzvkK7cEj1W2pxi1yZKyPwliIWpT5DJGK11w6oUrnxbAleONc3w8Buj?=
 =?us-ascii?Q?KbINV0ov6pitRdWC8MCketjVw2a+W4+j2pgHMjfkl17u2rp3sJzXvW9GtSGl?=
 =?us-ascii?Q?XYHsZCcWT0ERGKSQMlWW1hgLv8k57al3Wtv+ddv+yvReRzZsuBX0Jjq4b9k8?=
 =?us-ascii?Q?nbWtI27YGOlfK2D4ilbitnQ5xtBx6Nh+usKOX8Kj8nZCSk60KQGnuF+15aUA?=
 =?us-ascii?Q?nTDNTCDd+A3eWekw+3MAvXMxMWT+mV53orPSYVOn57Dhj7cI5P3FBMDXkgDQ?=
 =?us-ascii?Q?J3kZqD823JxSp1AbjSk7r0fXfWXbkFEq4P/b94JHmWJtkfIEidRV7xa+5hw9?=
 =?us-ascii?Q?14ZSXf12B4y5TRCHRlMzTq4QpjfLloA8IdAlqm/9PKwBZAJf/mfR9G+OhQi+?=
 =?us-ascii?Q?bBaBJd3/HiQnHSJLRHxEzKA581RoRfUazdTu7pgiTmNCxfE0Z1HUzjrR/YxM?=
 =?us-ascii?Q?j9biMMlbv1gxeS18916pUVgCNoMTQ2yzORes8wy9Qa2jvgXa994Tf8d5fAcR?=
 =?us-ascii?Q?wP47xa01BuRX6zTqNo3eVr4nHMA2yWwVTqk3E2hpnueDG5rXU9lSBMW/cHvP?=
 =?us-ascii?Q?WFcedfmdtR6+nivMVxehNEMR8A1sWFgbDay5IFUAbR6YA2To3lorP2cykt85?=
 =?us-ascii?Q?M8Oz7c1QSJqYzB0zNxKK/pdlAzANkCbcJu4Fmx7qQ8Hz5L2PuhXAXcHyeZWu?=
 =?us-ascii?Q?S4KrW1k1Wb6vYqIm9jxyvnGr5wnE7Vl+O+sWMWQQ9etoghAiZSeOH3XUbVGE?=
 =?us-ascii?Q?lvQER+MDLD8/nMQIny/guO4B5E5NgrR1wTqfEM1/zA6nnFk3JXlXgEc63D6X?=
 =?us-ascii?Q?4UjeZVLiJ+g5bsMFnm/gzMwhCSOkppzF0SckeBlijL10i9Vq5ANRtQvLNr1h?=
 =?us-ascii?Q?hOJNeV3cmjMNYRH7t77F3Pu8b9hg1q43AQt947YPZCwHV7CMAp12lHyjZlsB?=
 =?us-ascii?Q?1ORWMNN655HzlaI+78tcNDstEqleUnR+hR6QzVds/rPPhAjoA3JarMmSiReM?=
 =?us-ascii?Q?L9FoJJu9xSoMBMfcfAeO4dS6sFx95m8VchRkPQ+q1OsbphRcxqLV98YiMQGg?=
 =?us-ascii?Q?7kfI90HOMoLujZN3uSfibUshpTzAtbm7ExwnLLh62zsYFRMbmcySZEcGZMzO?=
 =?us-ascii?Q?OrgpOyPpQb//MKlbzC49nJpHR/0nmBt0A2c3K22i/glOS8rvG6SudatjCNlS?=
 =?us-ascii?Q?+f5P8kLr1tgL63X87WsVfRL4t/oDrCWG9XdjHVdY1kt1OEY5HnlXlRPGZJZP?=
 =?us-ascii?Q?h7BaArqb0pJqLBlIyPF6iO35rss+1CJ+X9tkWEeOyry6Bo5rhFJmUiDH7VNy?=
 =?us-ascii?Q?qqyyF6HaIjiYQJjhVlRxmZSefxzhoS5BAatJjpw4ptNue4Qvpp6Ly/KpOOt+?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab5f65-1a9c-4824-1c73-08da75e770d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 07:03:31.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLnZIa8LauxWpuWpeekodKkncwDF4/CHqvFxPKAanImcbxT8faTfnl49E7tEZqge5K64zimGfRAL2uvqDIkEwsDgOmgv5Hy5Ufnthoghf/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208040029
X-Proofpoint-ORIG-GUID: xtAM_B5rI46WcFOV6OD_-i7vMVDhjrzV
X-Proofpoint-GUID: xtAM_B5rI46WcFOV6OD_-i7vMVDhjrzV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The return type is supposed to be ssize_t, which is signed long,
but "r" was declared as unsigned int.  This means that on 64 bit systems
we return positive values instead of negative error codes.

Fixes: 80a3511d70e8 ("cfg80211: add debugfs HT40 allow map")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/wireless/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index aab43469a2f0..0878b162890a 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -65,9 +65,10 @@ static ssize_t ht40allow_map_read(struct file *file,
 {
 	struct wiphy *wiphy = file->private_data;
 	char *buf;
-	unsigned int offset = 0, buf_size = PAGE_SIZE, i, r;
+	unsigned int offset = 0, buf_size = PAGE_SIZE, i;
 	enum nl80211_band band;
 	struct ieee80211_supported_band *sband;
+	ssize_t r;
 
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
-- 
2.35.1

