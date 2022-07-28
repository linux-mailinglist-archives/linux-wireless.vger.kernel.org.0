Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76E58410E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiG1OZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiG1OZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 10:25:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9CC54AF5;
        Thu, 28 Jul 2022 07:25:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD33Os018492;
        Thu, 28 Jul 2022 14:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=IlgsmKLAoRzetEu80gmzOFPOcdnbPkh0gWu3BaptaRU=;
 b=Gl4uXLfxTc4Kc7WsEWPkZzqCEtxeCq9QJKZUtA0hQj+fXLpRq8i1g1jUVQ/FjIanwuQH
 19XK99LqdrNOvnfnJGvOUXvLl5fV9RNwyXj5ZgQLuMw4XqF+ewmo50y5ACE8aRdy1QBC
 YjVtw0JlEVchYYBqOnNhaPeD1jYfQQZfIDtPLsEJPJxJwWk+Or2goaDNpK6k7jZpPpEQ
 /uXXDqDeHzLh9IyL3UdiM3BdlOr5ia4SOcmJdmpQjYsM7tyFXCGRlzqlRB/OYqzXq8fr
 +8k+Aulxyq6ocHsiNk1gShnOEETvHYg6ru48gt4qJ09wyKGZJM34krwiXPnhEmEbi4Dd GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gmpup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:25:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SBiFf7034537;
        Thu, 28 Jul 2022 14:25:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh635p6yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNhsRXQfM32ybRcS203epCulOjLTUFv+i4H/Xvuq721ogSUHbqJAONu6Mmzih+YiMNNnX/zxdTT3hbZfzQvy6Q8mThV/z2E4dcBQ0C2kEIc9VdJSU1YLaMwXMCQm9L1QaqNTrGcismp/nbs1zORIcQQEtFIfNm+smC8gzcL+AgsuKE2a/U9lp+7uhogUFLCM964u7q+4kP9/HqbUMt3hqCGAbR5fLg9h1us9APW+jkUnGXf8SuSA15aPgY038nc6/m+skh/VfpxIyuCmNHQOSJUD+yrg4mtDhG0TyC9Ux/tRrSd0ozwlUmzE0PJZmtuQTH5qN1bZ3olZAdU+Ek5QgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlgsmKLAoRzetEu80gmzOFPOcdnbPkh0gWu3BaptaRU=;
 b=l2mvFa+4UIazdvxwK9VJCnC1OpKRpkngqzoxhHhyP9LjrNsAQGj8sjy2lbXbk4Sw5fIVDc6oUWGps35wbJJDF59yQ8OOJ6Rc2CmIm/hA0J4dFnKYMK4skl9MUcZrRKPhl/rh1OXE/+apNHT9p/lnw3CWtQZf6VHCkaYSKd1Er3owQ2bYl8LOQ1GuhPqkKuXXDAD0K6xsK9UVu6QznbFxazVPnG9uijKJwrVCd4GFZGrZ6+4f2JrDIWxiKxUbwXAFT9/P7g1eJ2a/wwbfzfzj+IOWALkGSWWhxq7ho0P7tILurN3HZfEcT8k4PpMY0eb4IP7AnJy16by7MHx0qUuYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlgsmKLAoRzetEu80gmzOFPOcdnbPkh0gWu3BaptaRU=;
 b=OrQzprqI0kLoJCZBjpH+Vpfg5VUzahdlAveSaq50OaWMXFfQHg1nsy7R1JrDWnrvV4NILouFLeHqcyFmIFncZ6yjL67Ak1odYKPiMXBQzWousdMR5VS+axejpjRzY/lJ4v9PWX4shYMxnhJJTm66zdi7T8Nw3m4JbL4o7gazdNA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1946.namprd10.prod.outlook.com
 (2603:10b6:3:110::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 14:25:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:25:32 +0000
Date:   Thu, 28 Jul 2022 17:25:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mac80211: potential NULL dereference in
 ieee80211_tx_control_port()
Message-ID: <YuKcTAyO94YOy0Bu@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58d614e-eb13-45ba-489c-08da70a50760
X-MS-TrafficTypeDiagnostic: DM5PR10MB1946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFyoA0Qg94CeXoyyj+MTh+lK6Fs2QW2+5j06dh7ESbRKlaIfQnW0fhupO/ZvBrU9LCsoiZwY/4RvoKf+aq3UdoZoDLS4nmHb+LALT/IFMWVB9yinGdHjHe9qml8HIzdG4LpCecs/Jx2yoqIA4D1TR/s/y59utxK3cTVpcDdaPvYRlna5eO7kusPn8x2exSfhMYsEELHNcLpILKJbTUnw1GXywkhrUMdtMEnR81mFPpYt+mEpX4Gn3sL4zlM5eYc84BtEcLaJNNg/PY8XX68p0b5CX4CrajBPALNBUjS0AQ6DUlIZ/p+aZx6iFjyNV7T6GheYgIhqj5Xp6CxM3Ee6X/f/LzCvzBNq83sJE+uefqSzmxKysnrDU8+2Km7pnXfN+oateqtQ0cs69oGYKLIt6xJEPV31OCMKcnfXbHNYnp5ft9uEppJTQAt38domaW3ZGVVIPMJ7qDc86JgWMY/UyUl9soPSB9zxiHegw6frytXrNKJQqtOHFe2Aa/7hDlmSnaQcyG21TLDj6Z/HUrg4f3CGKZ6hmRTPI7Q38rBka2OAKzUY1k9miv6dmAmpJ4cffZvrILPrmCi9oIqEQziCgG4+G+a1JI4HpNSLDHPekncIMj6DDjsagfTW+UC1IFQ3nz1PIyPrlfUDyZ7YjReYipu4jgB4/lWeh1yajDVPMRixJh9redQPVHsGk+fcCKsAn6sTWH6ShnUx1lHSxweFvuyZMIc3lVlEVWFMYYQAAzn8XJvODaZ3062PJkja7Vbuzt7snqeuRHMFCIMpW+AmuVEIJni6YP5nBSoaODFQkO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(366004)(346002)(396003)(136003)(66946007)(83380400001)(316002)(4744005)(33716001)(38100700002)(6916009)(186003)(6506007)(2906002)(66476007)(38350700002)(86362001)(8676002)(52116002)(9686003)(6486002)(8936002)(4326008)(5660300002)(478600001)(66556008)(44832011)(26005)(41300700001)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XbgSwid6xsTp9aRLcH0+NSF7E/d6Tz/1TppxZ6pvhczPh7u+zhyQiZhdTGOn?=
 =?us-ascii?Q?wV6A0aHDkp8RMMOX0kZHU7fbZ6dtEGGiAdR9G3vsA+rnD9jQDBGOi4Kolkz7?=
 =?us-ascii?Q?iZXchIjnt/DON+evcZrlMFIl4fLf1W68BRI+wL2qNSq6c2o7HOn+L1BGE1EJ?=
 =?us-ascii?Q?eGZhUblk9FsSgOmYOcOTivAjHsapsZmRosmhAZef0NHjXCXo/L8HIVTaeQ41?=
 =?us-ascii?Q?5P33VBgdFpJZs1Y/5MrNfq/tU2tJsEw9F+qygrTsz0B84ZbSu0/LAMj+awFw?=
 =?us-ascii?Q?42JjhMkAMtxPga8GbrO43sotvcHWVJNXQgBfKQE6RAclpU5E5AU+tmYKozrd?=
 =?us-ascii?Q?3tz8FkKAH1G0Tl7f+ak4WMn9bVisf6HbsLaM4Ihd2L2lwt5RgJmBLaaTFJYr?=
 =?us-ascii?Q?8zXBx+1c3lVjtKoIukMTPYLE5yPJoxh3GVx5yzTROE8Y9O5dQ4CIjNB9wKy7?=
 =?us-ascii?Q?2IO3MKL+mxGlQRtXMxndT2rrJVEycD88SYzPVlofdL4Vabaip7VDR+ff4m0s?=
 =?us-ascii?Q?oWY0nGvjgkP/LJgyebtDLloA+lGW4Z9OxNwljFuJG1eL/uXe/oyY6L8OxsC6?=
 =?us-ascii?Q?QyGWRyvtLg91QbZhV6CsxbNLL/KatyMnvwBA0Ww6NhWQ27AXPfu/PHeg48r4?=
 =?us-ascii?Q?7go7kMQhpL6AznbwQq2w6rPaCND/QymG1KnvSFqZDb+xXy+M9VlC06GVS6//?=
 =?us-ascii?Q?oV88/tuV8phMiAp/96Qll3QTOAEuYd97ccASrKnCqsTUIO2ADmjDd98pTL/2?=
 =?us-ascii?Q?me+9h2VGpEovkwcQhN+xSrjQVSUAQzDcBc4U+Rd9TpE+mmFYMRH3ecYJGeaM?=
 =?us-ascii?Q?tegmK7lIjxUQbCb2Pt2ZhYwntHLdWs1JOxX/XWa+8ka0C7boywDsfk9ywBgr?=
 =?us-ascii?Q?LpqvWrEk6DlN8qtxgUqvmSBQMhX95aDPzF/u+Ymaip+PNFqZkVFDrR7UOcID?=
 =?us-ascii?Q?3t99l2A9bFZXIlw7UzLsV61Te/Z8oiLGv0pkNgRt+qXbrX3c4wgOan36np7J?=
 =?us-ascii?Q?pBlmxqUukqEDG9tPTp/vGqZp1xORA/LVput+0t4ei2ZuuGABUQcTCwoc+PVe?=
 =?us-ascii?Q?ZaZo6wm6c0b2dGkPq+Uos87vTGXyRhOWCkTlZpbRqtCJQB2Yaa427EKm7OKk?=
 =?us-ascii?Q?hjCX9NBfVh05V0xmIl7TRxXgXtkfjGLWFzHvgyoBAVpSshPSQl2f3HFERozZ?=
 =?us-ascii?Q?b8MVEsMejTIUVJmYJpUeG1bZgHJdgwDaX5CgKTFVyrBWU9ZUc4b7pYlgdY1D?=
 =?us-ascii?Q?Jbv85E1StChgekadAyNodzRybe+scMp+LDkB5OzA46u4PcjaIIQZZypyZQn1?=
 =?us-ascii?Q?7hDAFFYLdmomZkTOyn+yFDz2t5p63rJj63oMuW5SidmvLIZxxoAhAqHGo1La?=
 =?us-ascii?Q?Uq3kDxxUZ/HYTO2BHWuiUb3jWBUFRIpID6IYm1pJyg3/o5J4re4wdjFtmzQg?=
 =?us-ascii?Q?sGVFKPtBElVFOLLAK3AYjw/evXV3DUg6orN+DyOD0EQ7/j1B0htj+fFCgCiR?=
 =?us-ascii?Q?o74Y+kKcYw9WCxRKT9sb9dL4HcySGbwedL01QNaIVEratoTuTJu7Y2MhgrQ7?=
 =?us-ascii?Q?aUFIJI8yXSkv+0mjM4q9BbITen7czbczAfE/o33CPVLGk6U1W5OB2JtzCNrr?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58d614e-eb13-45ba-489c-08da70a50760
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 14:25:32.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpZi7kbqHElw7OFdbTp1I6otORQWZ7VLk8siTawufTeCDQTxZtn7S5QR2lNJXMU2JodROAf83lZw6K1KcpeZWazlN3c9NmUYGdLeWhIHIJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280065
X-Proofpoint-GUID: YI8BGlAVFGSRSd9T3Cc6IQ84R_AtQEEg
X-Proofpoint-ORIG-GUID: YI8BGlAVFGSRSd9T3Cc6IQ84R_AtQEEg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ieee80211_lookup_ra_sta() function will sometimes set "sta" to NULL
so add this NULL check to prevent an Oops.

Fixes: 9dd1953846c7 ("wifi: nl80211/mac80211: clarify link ID in control port TX")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 45df9932d0ba..fd7e7dd66efc 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5899,7 +5899,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 		 * for MLO STA, the SA should be the AP MLD address, but
 		 * the link ID has been selected already
 		 */
-		if (sta->sta.mlo)
+		if (sta && sta->sta.mlo)
 			memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
 	}
 	rcu_read_unlock();
-- 
2.35.1

