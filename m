Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C55A4559
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiH2Il7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH2Il6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 04:41:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96FE2DA87;
        Mon, 29 Aug 2022 01:41:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7CQJZ032698;
        Mon, 29 Aug 2022 08:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=sCdIXgom5faZXyiOFX0uWNuZbub3J7byUrXwmGuF5wE=;
 b=AasWqBLV66Za/pvqO3D/bD4EsZKr+UJGujuZt0zXvtWlvhpXwDfdkkoP2BFjc/lWjRyE
 iID+Dh9ecaByzxQjeIQNb2bobWKAlywlptj5tmNObwKDWlZK5jqsJzahrlQyTHAcKCK5
 FVLv+CRc3/BLnTe+0fEi+VhCkMdZeaQWnaybjoEfwFap2DuYIQYfm/eHk2Chfybj23yE
 esnBq/hT5GMpaWbejSG/Wo4ev5FLuRA9WFHduf8nZgAR4dtdKGUh9V+S3ZfpfIP3jTs4
 kFWHkLarExLGeJVEaE5jpFVSDGhlBLn5r7FFqC2a6zUxj6N7r8ses4aa11C0770tkh8s 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59tph2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:41:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27T76Zrv018026;
        Mon, 29 Aug 2022 08:41:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q27g3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdyX2wiv3yOUknxtXUXjBns6s4ZosThmR+7RmwKxql/HDQ5L6UqDnARBuNl/1WMZh+5Fw6GDbAQbtWg9Xw6fEwOnXgh+2xIZkuqliElc0GDzCUB9g4YjSUlU7/9u5tDoDtUr1J0ty5bv7CP7HbpWgtB+/pTE5TGDXnquKcQPH5zpx6Vsu059rLhp7m/zOL7RRDFUUXo5mZ3Pm/Be+ZShgTvlAqqzhVchPanpf1u8F7ifdh+4CVQOkAZtLogfhMSCRxvN4XrtCqZA4HIrGyBqguPoFvsfROSrckFgP7jcP/iUHrAZvfGR4282hdcLpkMy2iLhdWtC6A2hxqtVsbkf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCdIXgom5faZXyiOFX0uWNuZbub3J7byUrXwmGuF5wE=;
 b=aj75i6hcioYhyNwUsvk9fRbY8SgCepgbiOy7zZxalT7Ibn0NzscN3QeO+XX2MFyhvQrOqcP1a6szB1rnFx2gar6LEOrSdcQRVqIz4Pg3CABO0w39rE5V6pZKYLm+yrIEQhQIGzRdGqFu8b3i+OQ8osc0c1uq4r6WMgnIW/UjdW6nLUg6kdkydxiDTLzTSmkINum3f1kvsFLsL6DqvfAQp1VY+nMbV+RhOwu+cdgywivLoKwQ9uoSGVANPiUHazZlE9g0YYNH2aQQ+EJpVu+hnfnUQ6LVLKIAWB9RXmQiAliKJVE46hNUpa/OPpqSHPVGcJnP7KvtF7aOrTEIfB/XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCdIXgom5faZXyiOFX0uWNuZbub3J7byUrXwmGuF5wE=;
 b=SQJUFVMwM5Wcfydrtgt4Oio6z5wEviRpPWFAfQ4wBOCCIpPW6s+rhVMyJLSRRUFOKLDPgAh1tJwXc1UB3x2spc/7ihEKFvmEE2Zcs5Q/L6It94J06XDSFh5LMl+liX2fT8ngApHH84yyi8v/b3nrbr4H48l2rqMqK2gfAEkDZ04=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4962.namprd10.prod.outlook.com
 (2603:10b6:208:327::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 08:41:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:41:51 +0000
Date:   Mon, 29 Aug 2022 11:41:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ilan Peer <ilan.peer@intel.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Unlock on error path in ieee80211_key_link()
Message-ID: <Ywx7xR590F6lUA4l@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR2P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c83961d-0034-4ebb-f6ce-08da899a51a4
X-MS-TrafficTypeDiagnostic: BLAPR10MB4962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mjf3EJAim9sAekT3FFeH0JF0O+04t4yxtygpzo/OvxrGYwW4f/e3R79nFQC+lT8Hwx1+5EA0T+Z1Yl73x8IlYliOs5Pcp+E8WSlejs6wcin/sME/UfbNsOamdgrUsDw6sVfxfLDGC6cgqh7JhgXIf3Wbn6J5L730ejmieCt5AY4pJH8mqUGSW47jkXlUFi4YStxTonx1KoOQil2JjJPiFMju8wQzu0njIlYalGyWbk01p3zNXToy9TFG9/LaYCs1CAgaviY0uH+frq2kzk8PZeX3IIuOToXekZmGzBxOz5FRQ7oTdyD33c4p6vXGVYtcZ0NCe00HxWpkgUuz7h/AQfnBldC86sJ57+DrDPlNz567Vna+W/MlhrfF+2Q3r8Uij7TdRyJqjspHHgMTGE/f+Ixwud19zmaUasEYKE2YQjXOKcGVfcuXlsc6URSaPLT5yoOkq26qdd5dgBM2IDzB0o3fM+PSNHd8N0Kh8OlGzyInKAMFvYC0uYDTpqX4oZ2akDAuJT+rzELJ7vyBk/aUwmmyavx2GX6L/I9/OAn9A5BV4ZSKyU9a4bSCODxztnmhujeIuPIv88n0hUl82daDfnMM/uREMvLg5nDWYdnZG0zGOvYzkOVZTgasqV4wWL/WP3mtaSY362tlJl8g58lhOVn+ENJDPL6uG4dmj587jVOBYw7jYcqumiwQIym/qu4zsp+iGpZNBRsnh6dFejd2nIU9pSowqsnF+WXFvTTNF1XpZDGkVUGZ1pTG1Zz8WMFPOdC3TQjSUIQ9gSkfriaOkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(6512007)(9686003)(26005)(6916009)(316002)(38100700002)(38350700002)(6506007)(8676002)(6486002)(8936002)(6666004)(66946007)(66556008)(44832011)(41300700001)(2906002)(4744005)(52116002)(33716001)(186003)(66476007)(4326008)(478600001)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WaCdfOhkl3HUcbb8QduJYxrKzhft6arheaQv/spBP0Pwexqk4qPVpBfRE9tG?=
 =?us-ascii?Q?5n6FPNkhmie0be7TZ9+MECccOnyd9bi4RNZNegiQ/qPMfo9zSGVyOhGahTdW?=
 =?us-ascii?Q?fw71Imqk/UVSGqyDpAyiceIXfqQBAfW8gdojG8aN3alHFdRcRrz1uAkYnRcR?=
 =?us-ascii?Q?mwSDt/ym5ItdOGuRwh7wLE7Mi5yyqwoqcVetHas4KsFfNaM7aCfbwfCm4xyO?=
 =?us-ascii?Q?6JBofky1WKV81zMFqCrq2K9qfeqYPqgmCpwHZPQwucgwkEX7DH+JqsXdFnC/?=
 =?us-ascii?Q?auomhU4cvzbqqorQqDCt5oUmtQMS4iesQic57lm6XeTJ8cmhjaCFOgcfZTav?=
 =?us-ascii?Q?LtoiroM7maMlq0Oez9oawDHQYz8c/7A4wgp9lhFn7Arizak2LquX/oZY6TAI?=
 =?us-ascii?Q?5ElKVxi/5plpDs1OTBe7Em2bx7bJqrscPA0lf3TvicnABe5BLtm4h8sxWSjL?=
 =?us-ascii?Q?wpCLEUt6hsCAMSVtjroNU4MJg7m8UYnV1pJcjWc3ly2j0gVq223AOBomdJ7f?=
 =?us-ascii?Q?qfS4B9UfSNqUlyEfqKKZls5shJxhXbWb/hg9vly0vyzcy8smCm0uIptWF5cP?=
 =?us-ascii?Q?bczeQgY/xzp7JaCu89rDIMPvlnIQrC7/6osWn6ciYf7rhogx5yNRff+SpM7A?=
 =?us-ascii?Q?ExUkWbNWwGESyrCPxFQ+zGaQIE8wSNHEkNMdyuhTZ1MkRQBgwskxRumErNbL?=
 =?us-ascii?Q?WiTZhaXSTyHbeZWjnCtxgyaSxOcPEvyt3vHy9f4c9WdOQag73jMa0tYKn+/K?=
 =?us-ascii?Q?bQRb7L/EcY/2fIk/Rxc2/M5yut/m40ydK4gI9HoI/jE8GzcFNUdqrZe6M4nx?=
 =?us-ascii?Q?ExDO0/2FxU88ior6NWJ9pD3C5r5LEgJKSkv24aoVmSo9uethy3dQax9voMtu?=
 =?us-ascii?Q?DuXUArtS815Te3cUdlDfJe6N+famPgMwZnRifXhgbmsXuURYiyDXhmZPi4+K?=
 =?us-ascii?Q?pyzdT9Q7n99xW82a0pSwEids78d3krxjj7Zaz1vHc/u0AYCz6Eb1OJKrJRgj?=
 =?us-ascii?Q?b6tM+BVJJcgbTn3b9f9TD9LL7C2kCiia3evUkYW6AUNayGOBVlmGQgG/xkx1?=
 =?us-ascii?Q?GQlRH77p2+S4r1f2K0aS9IRznrcdIg5+/rh/68frXSRvAU7JrwRF8V2qteqs?=
 =?us-ascii?Q?y9kwZnx6nEqPrJ2m5JGvxMb11/J8x72DOIAR+47fVS8xAyk2OEYJiPpQ/aVl?=
 =?us-ascii?Q?j8AlgwVpS5OubNH/okIe0cNuEWRM6flePheuMV8A35a3sPrCFNw56yTft9mx?=
 =?us-ascii?Q?yXpimEXb4eE8/7t1vhDjxs94WL0CZt4EQQwNgh4tkDcBR/rrg47y+DJ/4o6r?=
 =?us-ascii?Q?tzSkwMo6vK8rfpfekesoxyYsR3r9Dt10AwmMDslsER3GTQkAxvQ96cGUmg25?=
 =?us-ascii?Q?tiBK5r7WWyHyUSAJRObN90X/oxV2g+DvJu3CWIAmFJMhjrszCN3zpBf0TdCc?=
 =?us-ascii?Q?VqppoOyfcGVMO24XjbLPvMc881Djlk8tlPC5gyCbeQG9+a7FKB+NLe5LZLKH?=
 =?us-ascii?Q?OTa1diInMffCWZjUcIjL3iE6A3SPUjLLZAhB75KwycZsCWkJbVo9L1Oy4fT1?=
 =?us-ascii?Q?+4cnjnT+AqQcsnNkOiNUQTXS6iK7fJjfMlWQZSwQ0AiaSy31DnuoOS9cJSTl?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c83961d-0034-4ebb-f6ce-08da899a51a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:41:51.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ/v5RjWsizl5ZvQQjmve+QW9R4Vxz27TdD9R8tCvj4iBMbHa32CvF0Hph4xvYLfLUWX04ZnhSACSNX50ZuAQFJgEk5E7faDjHyxitMCznk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290042
X-Proofpoint-ORIG-GUID: Wxd-_88ypm9_UNYado1Qw1fPBjD0IZjb
X-Proofpoint-GUID: Wxd-_88ypm9_UNYado1Qw1fPBjD0IZjb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock before returning on this error path.

Fixes: ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/mac80211/key.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 86aac87e0211..d89ec93b243b 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -865,8 +865,10 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		if (link_id >= 0) {
 			link_sta = rcu_dereference_protected(sta->link[link_id],
 							     lockdep_is_held(&sta->local->sta_mtx));
-			if (!link_sta)
-				return -ENOLINK;
+			if (!link_sta) {
+				ret = -ENOLINK;
+				goto out;
+			}
 		}
 
 		old_key = key_mtx_dereference(sdata->local, link_sta->gtk[idx]);
-- 
2.35.1

