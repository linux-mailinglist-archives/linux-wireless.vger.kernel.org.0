Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E927448A834
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 08:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbiAKHPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 02:15:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23746 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235102AbiAKHPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 02:15:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TJGM027047;
        Tue, 11 Jan 2022 07:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ID76x2Og7KjV91V6BHPcJ3TxX/Ptv6HlQKUUVPBeeT4=;
 b=UW2X+qOv+AZV3GiqZyG39LoROiPQEHtbGYTzXE4JbV46FUWoGdyiNME6PpvyE9ByhiDL
 znlwoE/EXtta/Ijrc9oy/3X1wRBcRutfkc8WfHRiX8ot3Ogf4lyt1m3MjZjQA0lWc3gm
 EwbtcF5+yj9V3f1midzTT0b3sqn6yBJkkmBCXZTi0JSH6zqalOiup5GTiNTW20m2etJ+
 2/Vd60L6CZRA1OKcsZAJOBSvZ+37jE0TC3Kr/6naxgzTkeNpvHjMm0BBIt2fmdThziJi
 G2caE8fCnMP3YwSZNsUOvo/DPRtiF2KE0VdkhB4n/U2+m60LiV/fBbgyG5bj8XUgjjdT Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74a705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:15:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7A7Hs067664;
        Tue, 11 Jan 2022 07:14:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3deyqwnyfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVzH7Vfre+8+M/RSLTzycP2W+mqZaRYKfKWkdS6gSgxlOYAfGCZbvCmyelmNcCMEbbKdgG/7Lox6gRSRO7kEp1hwzLrHR/JO9K7a62oXuvErR2sDGKICBw+npwgNVd7y777MbvYYetZoFBkYHfsuQ7cUUKfpO+R1QxI4R7x/6mirL27mgXH+ANMLeqlu/uTHEuSgEH3HEsSRDaEIhXT2idgoju9UYAvxScTyHAJha5Rln/BEpIEPZ5/jJ1oNFPRORkaSRoKheodvqpw2FiODALS5+oVWpcPtNGtpJwzjl81UcMQsI8eYCui/WQCb+jkw0eTL8KOpdvYk3ayw6rQrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID76x2Og7KjV91V6BHPcJ3TxX/Ptv6HlQKUUVPBeeT4=;
 b=PqJQSWqeVayRt4tlbmQwg+lft0eSjfur6ILLdvrR2BSVQikuhLV4urOsjkV+mo37Q7FG6R1/0IGNhozI8f5vZgbm83ESuLlbHCcmVNvTkg+CsMDR9/SInLN6yoK8FKZfCzWw2Pn91kL459raEmdPcfPP7KxDQArFfcKBwXQH0cMjahqg2teupS146dTEaHoHfy4TJRSYKyRiemdK+RBVpUrh5+uNnLOlvdb2lsFZ0JA9rOIDW/a3te7cP10RtKPlUBhpFhTl/uZN0zYnTcz82bzHheHULJbzEqc8n7GxGR43YytjAiEJlrYr+QN1KAokQBh9ozgVvfvuHanQQci2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID76x2Og7KjV91V6BHPcJ3TxX/Ptv6HlQKUUVPBeeT4=;
 b=NpMOxK9pf2rFjmqyy6Ub8xT9eEPbXr5OdUkY5zFVkWnaiO82/fR2EKPhCCdrym53+7FwmjNnl31f+tUWOrgLQeqWhOHn7bE2R8gwPCAM00yt2iqqczP/dJKk+liPrytUyZcSebiFO380EkKKuKPjIBNGu78fV8mNDE4/RZHhq0M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 07:14:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:14:56 +0000
Date:   Tue, 11 Jan 2022 10:14:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: fix error code in
 ath11k_qmi_assign_target_mem_chunk()
Message-ID: <20220111071445.GA11243@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32fbe1bd-04e0-46e0-fea3-08d9d4d21265
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46919842BAD5108BE37C9B8D8E519@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PngRWJU5ds6wYTbKKuNueg8zb9gFE9LZQOSqcW4+/fyOudKAeQxrl2OneZZa+xHTOvuKFx0rQpefeyAo5awGG/TCWnxHbSUGSHfpkbGFACccRKSuP5d7JAPrnEzjgJpxTpxHJLfaMUbuD4e8JyKnKkySSJUy3BO5JmQYhDMtLO1bMUwVVHQsBuYg9eid8MdsI+uoK2nY1YlZcbs1j5ORRNzNs64LusKVan0Y7hMDJBC8d37CvB+7E1gGNLDMM6e2UYPN1B+353rv6PQ6zFZlWhWdI4cOD0IvZiG1HAyE+YAjFb697dGzkDfChz3Jo+UWlQhkJxliWiHilX7XezkDum88Acn47h5LLelbYtb00uZvW5u51aHc8KfjoX52qqwTyFndsPcMy8WOGHKBCgAnJ2aIAKJw0GMb1MGu4p7z0T9f0c29fE83spMCBM0X0GyslmIbM4G0PaTNahd1tuaAZxN6MM53uh2s7DRnM1kOjar2mtO4uxTaxZp2HNfpImL9mMN+W4SodN+fLI8TeLmn2khRM0HI8F4IpgI9By/eAcfCL2rqut3aZ12CPycJFMQNuvsYiSRe1gSb2fEuX0aS6IpcORVNMZbG8xXFVCPluPsvac9nW162Cv+SFLMrcMpyyWfqLFWw7c+oNVAx8dHA+Voeb0SWt6lNNZmea4JT0ZL503kMl9+DcFMjXpoqDk5HSlSrJ7upPHTPkrxDf5PmUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(110136005)(66476007)(33716001)(186003)(52116002)(5660300002)(4744005)(1076003)(66946007)(44832011)(86362001)(26005)(33656002)(6486002)(38350700002)(508600001)(83380400001)(2906002)(316002)(6512007)(9686003)(4326008)(8936002)(8676002)(6666004)(66556008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NSfebCQC8l0lprCoUnlSEgeoPCka3KmVYPwlLfPK2ZnChhSy5qR9C0HOKhs?=
 =?us-ascii?Q?gSvEEjXKSVIY5XBzmHjKaK/SVNskzx3J+GGCf5cRlA6Qd62fvE+8qWroNtv9?=
 =?us-ascii?Q?hhV1pU+3fsHpmOfjiDmA5skQh3S1037qmruq+uq/aCsoe34h9Ssej+BDqYAD?=
 =?us-ascii?Q?lni2oVR8l/gXBpQRwmaVe0ntI5qgo+/dlrwj15T+jqiyXCtaiV0Sh93HahNm?=
 =?us-ascii?Q?a3x1d29k3VczSJSJcXj+PTC4It7TtbTyS/xQwBhu6pgf/o66ckSl+cFO8C6m?=
 =?us-ascii?Q?DsoH2YxzGs89euRRAmdINSm1AiTB7g9H+eHOZedR/CDU54JviCDQH8veZCGJ?=
 =?us-ascii?Q?1VZzh945OlFi+w0sR0un8Xqz/ROQ9uJbpz6coJ7XT3Vt+f8BzFy3dvP+PWqW?=
 =?us-ascii?Q?x0W7WwNlG8TUvIUxBjKZ+dEi5J6Ztz6j3W32tPJmzJkKWisE0A3d4RLcNk4o?=
 =?us-ascii?Q?p+h3kNzlKSiHpqG3HcJ3ttBPxycBMsVzTFiiBljWJXQaMXk6xG3eflPm/0HD?=
 =?us-ascii?Q?MI1wkJixWlE1e7wayf20GLNbaqm9Yf7J9MJvd6HAbDOmJ86bdPKWb0pxJwNE?=
 =?us-ascii?Q?QpgB2yYZ3iGm8/aMWDwbCxdrC5F8Jn8d51oqe5VjqCTHgf0yMHgBIyRxkK66?=
 =?us-ascii?Q?aA7cLrwUweA9+9y16KUpmHvQnOnqfalV6Pevn6DQS7fERaKK75JTD1Fz5DxG?=
 =?us-ascii?Q?qF2xPxl2HVkrKhBn4fXgxxibT7umZYqPfjISXuxHhluInZo7aZxgRTcYYKSc?=
 =?us-ascii?Q?xaiUTbkWgAmA+mE2Sohkk9J5aoA5Jhs4y/oFGm55aBbcoYOCRUkn5sKJctzC?=
 =?us-ascii?Q?TiwbAySZEYClawG59ELCSTmCE1g3kd/ZOR5R+CnnAn8HVeVycVuexFVuoPMr?=
 =?us-ascii?Q?flNLU5+D55ZPfOLwrS0AeyJKfJ/dpov+3/fuc2kYqWG4x0Hdth5VkL9ViF4M?=
 =?us-ascii?Q?LQYlH+j0/rVySpoJDCe/iFTqwHljLJaoNPh3gEfRgIMjfG3pSckJ700iEj+U?=
 =?us-ascii?Q?Ic5oEbeN5S9DAfRDqiRFThQ4nPQ4JgBrElAP43OxIgXvbTvfAfd7g+Q52+N0?=
 =?us-ascii?Q?daWsc74aCA7DH3bgAYLdF2/ri5Y/STamC985FS6R/loLKztBw4XYSafkTcKj?=
 =?us-ascii?Q?iNTCIDDWMW5OrlgpnBrtajdMuWXvECaqVUh+Ug02gcHQsvxig0oyVE+F3ENl?=
 =?us-ascii?Q?EsmVqCpXPoPdxibiyrxvdb7MtPu65c6c3x6rLqGptFjlUVaT5h6k2BVMfgp0?=
 =?us-ascii?Q?8EVNQXPuPHbvEUf0S2fqoYbXqlOanVEwTKIg4qqof8iR4ppZqnw966Wo2fTu?=
 =?us-ascii?Q?MJYiRIXPWiu0KxjGkXUEGE6lk4e+eeYdblT2bKbnrwhlTn/fQ/akRpq5jYTw?=
 =?us-ascii?Q?ZfQot/yoRCytpp2KouZkk5mC8vuyzaGafQvR8/07SNMhIN4IfNkWcfzKrV/j?=
 =?us-ascii?Q?unhdfTh4J1rh3vHK7UmonHBueZdN2nvJorcfrWVqBMBTdrs5sXsBzJ9Qsswr?=
 =?us-ascii?Q?NHlZnCPfdq3d0Yz/IV4ITHjgkAC2cd9wTk/pImBW7/c2F8CRGzt7agnqgIcd?=
 =?us-ascii?Q?oQ61oMNmlpM8dsNsqZOHnJHg6Tn2JPA6iHfDQRgYwjWva36cB899fNtP+uGL?=
 =?us-ascii?Q?6DiTRMltQz33yaNtcBqbi6+LdQ4rKVkiw419rGgS9wiC+H+/4gmKbYtY8ReU?=
 =?us-ascii?Q?pUhQdnHsUSSMZcGHkc60JdOCkEE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fbe1bd-04e0-46e0-fea3-08d9d4d21265
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:14:56.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNtADsuQeNquWdKJBc3kAT2wLDYvekS3tFsgCdZwg4OF473vz5g8gQ5KEyhuwk32bnerbpI5SFbwx//ziOEKiq9e16j+Z7T+HG2Uh9uE1jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110038
X-Proofpoint-ORIG-GUID: W1cImyctvdCmERI9RLn51C0w8jausrXL
X-Proofpoint-GUID: W1cImyctvdCmERI9RLn51C0w8jausrXL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "ret" vairable is not set at this point.  It could be uninitialized
or zero.  The correct thing to return is -ENODEV.

Fixes: 6ac04bdc5edb ("ath11k: Use reserved host DDR addresses from DT for PCI devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 65d3c6ba35ae..cf9f4ba75e03 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1932,7 +1932,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			if (!hremote_node) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "qmi fail to get hremote_node\n");
-				return ret;
+				return -ENODEV;
 			}
 
 			ret = of_address_to_resource(hremote_node, 0, &res);
-- 
2.20.1

