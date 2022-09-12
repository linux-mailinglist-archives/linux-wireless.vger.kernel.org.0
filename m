Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2271E5B5CEB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiILPHd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiILPHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 11:07:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5D1C129;
        Mon, 12 Sep 2022 08:07:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CF4lh5002163;
        Mon, 12 Sep 2022 15:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=pqAfzFwAMWbdujIn2RqRnlINmEG8HyuAWk7a2Mm9nBg=;
 b=TDxcTgRGkp6vp7tjftXipAZMaqSsiPZ1yllIXkOa0HMHjP8Io+Bxv9kQpk51dpNva4Xy
 VqavSgI8Ngx/aM2lQmtn4L1cZvdsAYeHQ4WWbeOHAboWPKJa7souO6MBUaIvz7Ty38dG
 Bn2mGGMf012lbpIJwCBjMuKfSYrsfnfihGJ5bzxJfUrl2h780D9TcCkW0U2GNeiYq1iC
 2FGmbxuH5LDfzPOOuQReJJMDcJ2X0uC6d8/0R8WIul9KCXisAFw+ky/pYXk7p1YQG6Mj
 1h0U9DKiPmBDP1R99Pjhf3i/5tXexo1os20rCAArmiraXS7G3b5uesS6WhNQtwzGu07n vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jj5w287et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 15:07:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CECOV1016843;
        Mon, 12 Sep 2022 15:07:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b1j7mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 15:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJp71yXi6GKKP4VelwhBQV9KHveE4NqDN9r9howfqq5L7IY/fJpZNePJ6sbDx+8+84dqLyg2CGsqmbKYeNPYkW3AJKkFY6J6r7tLkYoMc3Bf/WUfG1+jXggDauaWD1dc7ca/WlbG5n/kRTTFAaJFxcMXIO/dfnyoYcyZ/J3rcpViEBAUkhorRztLLv4F4PtKD7RTgaaf1Bk1IlaK2pOZGigfZMKexuCDyGwia2fmAPcSOj6qSh1Op4D9qIyKbuOXj87hlUEC/CQ877bLeFVVV1DicyZBrr+0PwU5KuZQsuINt/GTbh1NI7HNbsdVC2JRbxsv9iqY9nPZbTW/vYRtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqAfzFwAMWbdujIn2RqRnlINmEG8HyuAWk7a2Mm9nBg=;
 b=SgbkoRglWgE4rxvfKMHVbVNKdCQqcQ4yNtPPuMYwrRs1hjBRHyVl7czTLn0MrTyzcZkoUZnecOC+dgrLNUknYPy+rD8KVlwZvSjW5i2esRafJgM1bJkmXx/0NL9Tmd0O48kmVIbnh75U4Eul56U/2qifP6tNHfIMj/iavAilCc/0aL5Nt8nbExVsHKoo4Vt8g1Kq+VqdyDJpLDxTC5JvjAe19pJyl51MT0RCSI/QgIBFq6y4n64ciXCsLFtPEme5EZ8Jfz+4VD1sx+pjwA9s+z2ZePoQbXBQRFksvsP7X8sCDLAJeBAhPmaw5ihvior63fDkF/2DFkTjjNOUea+J1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqAfzFwAMWbdujIn2RqRnlINmEG8HyuAWk7a2Mm9nBg=;
 b=yweHbD0h7p5s14Vsn8xevDmbr2pOt24DYmT7fZ16VMnFkcX0x6Wo1pw2uLSUdR0nRU8Oqk9zkvkZNvA+rLGZ5QGX3fau/uCV0PYSV+RqZgJWOHBAXlkLkruW73XQvfRdkofCp+Ix8Dh4G6Kixl6I+t4nfhGwQG5vRFOh0gUjeHc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB6117.namprd10.prod.outlook.com
 (2603:10b6:930:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 15:07:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:07:22 +0000
Date:   Mon, 12 Sep 2022 18:07:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mac80211: unlock on error in
 ieee80211_can_powered_addr_change()
Message-ID: <Yx9LJFA7PDSRmb/M@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY5PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b24aa0d-17da-498b-dbff-08da94d07e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D+YQE29Q92YuNTjOGY8dJI8yX4Hs2nhuwnHraAQrUMrN2p8qweYOd8khvdOU06P6UWziTAmtL4hceOSO8j7NwcLkyp/A+RcI105XjEJ8kVESwUwObhKM4alO2nmMHiiizcpvFulw0vKTG/W8nfOlo0lnD0+duJ01Kuui4MUXYG0dUwTW56QrhQKWYXqXOKJttNLSJS6VRsjRle3OiWVXphZ5g0BgagN7XnomkQuclx59DJ/NNduWnj7PH7KPoLJQDvNlpDRULxzNN15f33xcdJGZWFacQj78l2z1DlAw2Bw68b8alo224Mw79DDgIx3EOAhgYoLHkxZLP4slKaueUpByt17C/L31+j67/b4ZIkL+aTyDqhBBgey3GPLmH0bZAvgklvY9A8cMazT6T2Xpe77H5201db5rWJBSYd0LUXa4vzjN+m4UfCPr+QSuJyD0uPpaXALVjU0GTW7L8G2uUg6KfrowgvOtJ414vCTJE9OkSnSkQANaYqyukzs5OWlZF2Ul95qy4CodpBb73lADMEavlkapx+afaZK9aSbBpIkYet9ZFNLxb9n9/Ow0gRrXAPQv7fImYjKecvuFpWT319vp6jq5Dq6xDOBEXJlA1VlOqYk33muAajYEbK3yKO9ErNSyn2ttHnYZ8wCVGUUSxC1r0g84/Rk6dZ9aI5WrLzbqdZMjt/LZbRmrQhlBSz/JnjB7Nb+KsjN75NHRgBSqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(66556008)(110136005)(66946007)(33716001)(316002)(478600001)(6486002)(6512007)(4744005)(9686003)(6506007)(2906002)(26005)(8676002)(4326008)(44832011)(86362001)(66476007)(6666004)(5660300002)(41300700001)(38100700002)(8936002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ebwhpV+Tjn7lGkHrgXjjzXCq/KpK+yIi0uSEp8EMAU8pzQXGfIJvTmodTFO5?=
 =?us-ascii?Q?oplNeR2zoeLDrUmU7i/x9Gt8BC3Me3uv7m05DVPMenuX0+oJ012uHiD5Joar?=
 =?us-ascii?Q?tSs2C8vxlLKDvZJbtqXNMyT+/PFYI/1MwhIKUFQFrMzzcoP+s5VrWwlrI5aP?=
 =?us-ascii?Q?TRIk8MQkQfCMEMorX7sapwa1S4xOq1Z1++XsbuxlzD0tCSI5eT/JgyEB4A83?=
 =?us-ascii?Q?X44KhFeDxRV0dA6Qkn+Hne4Ln8MYkvaYsVIE3QogmPT84g0RF7pjRjhtaEJ5?=
 =?us-ascii?Q?16ODjbEZPIwIMyIvEeD2NpATKM11sYoKYaLwOCvC9vNHWptAFYLBGY6j4aca?=
 =?us-ascii?Q?rbvFKsRKUY+F7isC7vu1JRcVYKkJiwYJSuwgXrBc+041gyQE2UG3qwYZUQ7/?=
 =?us-ascii?Q?GI1046VcoszKLHxO82A82f0/CEYsB12iodTVrTyvm6TtjTIdU1iy90paAjDR?=
 =?us-ascii?Q?3v1sOsYCZJqgPigWARQB4pUBYZnr4QsXPvTMmyGgllGoC4kLmhX9dC9ljMdo?=
 =?us-ascii?Q?MKYHSIH8u306nkMdpsv2O+lBCuIlKAIvajU3VDm2kecsK+FESpCqJwOPZz/0?=
 =?us-ascii?Q?KmA7KaQp9p7m0ddyJIhOGGiDNZkEMn8tNfYCEJMD8mDIAgaxKd8zzC6ql5e0?=
 =?us-ascii?Q?NQtsVWI5jKALvsdAw0v7iVvmreQ4eysD5ZhjGBFjpjC2vv0EftGJ84vcMAND?=
 =?us-ascii?Q?zsxefS2rd7Q8EFWZuqeLZJWq9auKX+xTAZtfc+x3yFJgfSU1OSCeWh9cGQHr?=
 =?us-ascii?Q?qWfgheF9og6RwVzON2XsBV3iEhBCE8vcOYDOj5nMXreV+7xDJCxOf65HzQj4?=
 =?us-ascii?Q?1CKeyyZ9zOmVetc3Z6D7kjcikc0DSTmZmVuQ5ckw0R6zA2nBOVHabdPq30Hz?=
 =?us-ascii?Q?Fp0FA7J69dMNnUEF4bragpuTxycyryBAPY/b73IXJcP3U2C5fx8dYCcWySj7?=
 =?us-ascii?Q?ESw/o83ihliOM2lCMUiS8P3e6MYmouL1I6OxLZCgWmNW/XRlgO844EYXeqim?=
 =?us-ascii?Q?MrH9eoNZk3T/JbDw4Us+mwIp+f2Q2dk2pYuIzP7X1IKWs8nTaByk/y1QJtRd?=
 =?us-ascii?Q?2H0ezejYW2oNCooaPLNk2Wb7fdKK1tTIMxj/DcitOsd73SfLLMUDE7I2RUfF?=
 =?us-ascii?Q?7vZAT2dSHsnHUMatIwP2uXnY+WsKUHbIfJMQivvU2dbwgDhnY/xYTy63bXdg?=
 =?us-ascii?Q?Pi/fepgjWh9bT6fA5xiuuGRX+LBwNi2YOnWV5naxVDawDFZ0lRy4iMbvTKOf?=
 =?us-ascii?Q?FdkolXiUqyjxXDPBvcY43IHEgWuu20lgp35LxVNtsoA2CvLN2JypSNi47vCy?=
 =?us-ascii?Q?rPjwQHpBz95SBipKoqas1032pANx0OMGRFC67Tt4EtUyeaExfW/7Jt+pPOie?=
 =?us-ascii?Q?uoAKtMKNzubbeZPy4tc6mfOzXprpgxfsIr6ucMal9x6lQlKNsjwYBNiDJykE?=
 =?us-ascii?Q?f80qvyNBeoMTgZCx/ebYaVBNg3hs0NlwIefJoZMkWuJoJy/sREx1Nue2Z0L5?=
 =?us-ascii?Q?H1qxswC7CFPZkjiwvP1gLRaLb3/g10QSoofe270Qt4wmycmNvPGQiIIGW6Sj?=
 =?us-ascii?Q?OX1zlBnniJP2nNVRKizWaS8KAOcIVGL/Dcj0iP1L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b24aa0d-17da-498b-dbff-08da94d07e80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 15:07:22.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8SL+nxL7miGRhQ48T12HWO3ONR13ti1B7NxacSkFsow5XGZv6vJBE3Z9BKy0NWKDp+N8TcOoYfbYdbgSXrvt5nqBsx+qE9DjDJJk4Cwhtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120051
X-Proofpoint-GUID: brZ9zWT34pelp5XFKawfigM24e4WtgF0
X-Proofpoint-ORIG-GUID: brZ9zWT34pelp5XFKawfigM24e4WtgF0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock before returning -EOPNOTSUPP.

Fixes: 3c06e91b40db ("wifi: mac80211: Support POWERED_ADDR_CHANGE feature")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/mac80211/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 572254366a0f..b15afa77b87c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -243,7 +243,7 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 		 */
 		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
 	}
 
 unlock:
-- 
2.35.1

