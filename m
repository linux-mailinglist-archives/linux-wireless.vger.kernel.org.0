Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE554DC40
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jun 2022 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359170AbiFPHzH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358971AbiFPHzF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 03:55:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BAA5D181;
        Thu, 16 Jun 2022 00:55:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G53R4m005230;
        Thu, 16 Jun 2022 07:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QZRNtCfuF9Ag2egGZqLAq+77u7AfPePpxCYwWTfvYQI=;
 b=or0zZkWBhMt7Zy1i4mAAt9RGtifYnNfmK//xLcUI0cZp2CvjICXg1+O5sO5ZbUmASki6
 kYCQ20FBKlyziVYUGR+zCSPNpCb1D153TTLwDwH1ZhgaKgr6GyaEEoF5OyLioMscxmyA
 BBOVqVNeIhLj9lR47lnbpXcsOO0mmXUsxWLeqK/1xDkZf7HNSBHR3e1AE1LTasvVmBmM
 idv7eFdlbSzItLy5QwGbt2OVqg2X2D+p8cg6FRH0YPPDeqcFGi/mge1g+ZkBoVF4zQb3
 gepHWmVh39XZT/hoeCzyjHna4kV2+5AH4TLndBiHHkN8tUgL/HEDHG/QEJN0JJBAaJpL fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjnsah8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 07:54:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G7kJPP005200;
        Thu, 16 Jun 2022 07:54:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq24eg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 07:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCHZUuhvpqGrv9uYIyJhuyg5+20MEiToINWpEKOOl2eHjMveK5z9TupDOOmvGBKj6Urrk40Yx3O82SF+aXjkoa+IYtPIVFQanxUMXJVwrcVZs93Hq3KRvCgrA95NWdR6VTYqyAyTrQPtTsfRvbFNISPLrZiVMwqgh9s7ruCbkRKuVroiYnV6lOXVoMyjN9GyMQAEk1B03K0ZtCFN+aw+vYBHjYKbnpyx6+RNPKB4JnWbnqmD5ajjhQWAQybWONugqXoyWTRpchD0cvv/RT9IGX+N9rwtPkSwo3vpQBSv4bGlqqI1os2a97c24rmaOSxceFEeFBDoU8cNuRlE4JJMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZRNtCfuF9Ag2egGZqLAq+77u7AfPePpxCYwWTfvYQI=;
 b=R5jJP4jpfeshTg3wENh4LK0qm3apn0PGZxv1Sf3bKXDggdL6RHd4EigZASKerrlJP3DlAxR4PrOwE2LrgkXYLvtBIuT5MUihDXSA4kY9ePN+lq9/WnpwfG1KLJYLz7MZeMMHkSjuKsbCswfLfKKYc7PS8xK2SfLVZI+BVJJfYcg5XywE93BK7RSMeBb2RwrVWkN2dEDQum0UmS/gGYPb2wYNMUaSiJUKQ/RZP4i9hIzPIKoxY8iFYRSmW7rdAIpNRKTofq3HbViFloV9NLaWKo4v5TSuP/zm+xG7OsIZ9j8VkYoCWeoMz+ouNw4h2Td0qsi+7hhV5vBgjjwV+ggaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZRNtCfuF9Ag2egGZqLAq+77u7AfPePpxCYwWTfvYQI=;
 b=gGQOUQIu8oHbVmkeg0mrjM8ZqnjTFG9z3K2vYFm4YeoGzb5azldkrbbsHiWIRgWPVLUnrZfpLxs6ts3GnhC8/1x91sGJ2LQNzbf+UbOnUgF9S1YY4/yw44UI+YVk/V9M5oHZjvb3cF2utaA+m3mBc0qvVOmi2zXhyYxUr4ulR7A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2308.namprd10.prod.outlook.com
 (2603:10b6:405:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 07:54:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 07:54:37 +0000
Date:   Thu, 16 Jun 2022 10:54:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Len Baker <len.baker@gmx.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] brcmfmac: use strreplace() in brcmf_of_probe()
Message-ID: <YqrhsKcjEA7B2pC4@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3759610-14aa-4e99-798a-08da4f6d75e8
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2308:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2308FA1003583398E2C86C038EAC9@BN6PR1001MB2308.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exsYq5mn9c33Wby5EaEhBrOLK+9kOt+nGZGFEsC2C0I/9mLmRiRo13TzXtycBv3ZRap44gjoOmZ9V54KVLC/HRMsGPND1nGgeUMt/9yFP0L/WoH9y6VY4AFq2spBPmsTHADTkwAFLcw0K/EEkinYvVyjsOWFdBImJAFtuhbD8eZmDRab40Bzy5jgJF/QiGWRmLwHaknAs2i1QDdMw5rg/nrUINfq/WrrzlOk8OeR9jYhpSu9xNMrxZTxGLhdHc79/wxMBuO2QCDCMShtpi5bt8fobxE06ugjM8AN3SaGhhNs+YwRGTLjB3fKrpDm5TKhwVJQAB36y+KOzgj94oD1g82Pg2OAg6ZjFWokTxuU+3Q/wlUo/CxQlfOWbDYzvu9oBIvctoFMn0gCAQzkHMEJAjrDCDEUESZtrIPuJlqqHYcg+qo3PAQTOksvIrcdE/Y4HyXz66WLhE5d/V/71BPMMrL1FW0s+KUdSR11npNgQdQ6VSTl31Gpn8UP+tRqOKsjsWxL0CQ8Fn1rFr2K5DTAVV3inVgDH/lLrWqngm/VHVP7J6tr7fjEOd1o9kSQLqv8+4pQnd1ohh0jmQy+aZAO5j1zpF1s8ucIgVzzfaXufaHZ+T5PObTpJi6To83Z0qerdteqaaqiJNOPnM7gvk+BC+IPZhIC/uy3dygExIl74ymole+593DpPSJ3vOYMA06o+rjOq9w0QC5J4KZSN0tFKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66556008)(66946007)(86362001)(33716001)(2906002)(4326008)(38100700002)(5660300002)(66476007)(54906003)(6666004)(7416002)(38350700002)(110136005)(8936002)(8676002)(52116002)(9686003)(44832011)(6512007)(508600001)(316002)(6486002)(83380400001)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQKqoWoNmKFE3pH8Sip5oeazDp3hOGRsW2Ml3APp01thv664rgWNik6YZbEb?=
 =?us-ascii?Q?kFxXxNGwdc1N1G6mvhdbs5W14Ct2Dt9oTPDPbYVEWMgG26UvOUyEcHptJosp?=
 =?us-ascii?Q?+0K67dKG1kiTwIIRPFrWzzQz/Y+wZfBHFtrBympHMeogTt8ZnzNgqR68SmOj?=
 =?us-ascii?Q?KZbS3bGgQfKBmO2FscTG5X0Me9WE8ishqEjNs0/tuw9k98t7qryB169HokAI?=
 =?us-ascii?Q?Slbm4MnriXh73eZjBMAuqxYxa3NzWe2mM0rLeiXDH0xsi2Xf5ur+n68WsBqH?=
 =?us-ascii?Q?e2Jgt2CPya8drF/Ilav7g1G84SLhonnl7zldROTKnwVTjxsdjk2vL81HcFjs?=
 =?us-ascii?Q?+/Bb+o5Fo07D6Rx2CdBsaoAdGvAa4SGU+PEDzgJF/Efuiah6fNXcaSl53m1X?=
 =?us-ascii?Q?Fvce6+F7cvzjM/A0QUd9WNiqb3jvXSsvjJnOkNCS/tD6+ALFithJLsimA43s?=
 =?us-ascii?Q?XfpJjaqajB2Z+MQ92ZnkMoWvG2cvBQ1gQLDGCpme1GZviytCSuqgWhYQAYei?=
 =?us-ascii?Q?TChj+PqTBv/cCVzaZvePeNZ5b0GB0R8K8xlNfA2sZeRaTCX0cxpbvlJZzlKO?=
 =?us-ascii?Q?QB/Ke8/aBf+yaiEDr9xU0o5EQnMWS6AP69AWNMhFT5CaLnEdEePsdVHxQ2rF?=
 =?us-ascii?Q?6p079qDxBjwRnLAldDIZfrEjaexqAOLgVlwF4v9WSMddXOfnY+PVllgXgjWK?=
 =?us-ascii?Q?+ENBFbY4ZXAJrD3S2wUbr1wXh6nFHjKpw7l+ZydT1RDO7ac6ZcAht0ILJ+d3?=
 =?us-ascii?Q?aaeU6ObN7NaVx6N0qR8TlgJtJfTBFh4ubcGCzfIh98EFG07UkGmAbnCJTNtb?=
 =?us-ascii?Q?O3vNOMi1aCZWUzRB1Ukw0QbUbwx1rs+lRBPK08l+wjdoSIRj6PxiJGLMEpJV?=
 =?us-ascii?Q?zXr3TTN3vFS1UsLdcN3S1Sk6f4a1SG4iReuaQ2PPqX/qOIMxEJJBwOGu2BdL?=
 =?us-ascii?Q?0lCHsFTemen7NzzHN26JqkgSQFP4jjfQRTpMO44Kn44jLRl1+Spd7pb1L4NT?=
 =?us-ascii?Q?VKSj0+Ui77c2DUfaxiCu9ZNysz+ypg3t0OncY/4XDvD43TYwsUNdufM5L5/A?=
 =?us-ascii?Q?/1u+WfVCKMqGfDbPzNYmZ/1Pqo4DK7R645ybALNgk0CoDhHYuyYZKGunhimA?=
 =?us-ascii?Q?qbX+f8wjgagLGLGtwxorFMdE8OJCl91pEmZMPt4X5mZNQNmNWb9kxrqbVrv7?=
 =?us-ascii?Q?uOCFdomPbVy6QkHq/T6iF1pdZuLmNdMdThU1k+H1H64v5w02azzbhCWqykcT?=
 =?us-ascii?Q?9BJySPK4i1M7HHSaIYIDKlKDTsvGjLaHFvWjTEkl6E9V0/ynrORHDJmRB6rB?=
 =?us-ascii?Q?QqhPOqTTgAYhrxXsKtPwZrmvpyivnLXD/9FHQPSrhDMMkuwBJfB0bvl7dbGh?=
 =?us-ascii?Q?JB9+tDoa5A1ngKDaI/T+bp/YXeSsSnTXQpY9qIF0cfEiyeCPN5co4eQMPr+q?=
 =?us-ascii?Q?iZ+LdHnBOfGO6M4Tq/uLhwJRCWTYe9c8JDqDH1cVsoaEvnxFbIOcm9xtEkGR?=
 =?us-ascii?Q?z9PhE+TLKaHCKdUJ+CzEx5AeJLylXaTEvwWNxqFB7xlisxeKPD6JRAV/QUmw?=
 =?us-ascii?Q?DP5PJ5bZCJtFuQxYSX1PUa9gK62YcSqKwUXbZrVOiaXs5KE0EofrnfynKcPZ?=
 =?us-ascii?Q?dAZkBZuiepc4KovDYtQA4XggrsMK4o+dMMdGvACxA9SUi/McydSV7RdFhPEn?=
 =?us-ascii?Q?poYNNAavGavN0qE2qlcpgIzPzsu8bM0xonmZbUb6wrtYPFQahj+sAMv2eZ/k?=
 =?us-ascii?Q?DFtBXXi1lDOQRiaieIfiU+5H2p8HbKE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3759610-14aa-4e99-798a-08da4f6d75e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:54:37.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJsHc0V++zSj59mswj9CVQndVBjZBBJ0myLxghFZTkCKG9RZ1QkyPThyUE7ZxpT4vw196b15nTzEpJ6ll1B12i0zrUzXJ0zk6SyE7abyMgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-16_04:2022-06-15,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160029
X-Proofpoint-GUID: SoGR7CDMUgWkBer-DY3QOrn-6I1541z-
X-Proofpoint-ORIG-GUID: SoGR7CDMUgWkBer-DY3QOrn-6I1541z-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The for loop in brcmf_of_probe() would ideally end with something like
"i <= strlen(board_type)" instead of "i < board_type[i]".  But
fortunately, the two are equivalent.

Anyway, it's simpler to use strreplace() instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
---
I sent something like this last year but I did something wrong and it
never made it patchwork.  This is basically a new patch.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 083ac58f466d..811bd55f0d62 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -72,7 +72,6 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	/* Set board-type to the first string of the machine compatible prop */
 	root = of_find_node_by_path("/");
 	if (root) {
-		int i;
 		char *board_type;
 		const char *tmp;
 
@@ -84,10 +83,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 			of_node_put(root);
 			return;
 		}
-		for (i = 0; i < board_type[i]; i++) {
-			if (board_type[i] == '/')
-				board_type[i] = '-';
-		}
+		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
 
 		of_node_put(root);
-- 
2.35.1

