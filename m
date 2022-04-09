Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885794FA55E
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiDIGPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 02:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIGPu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 02:15:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F6D3703;
        Fri,  8 Apr 2022 23:13:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2393vbcQ012645;
        Sat, 9 Apr 2022 06:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=gcYpcPI7AFaRWzjjc43/ymIP1TZXa2J66gfyR5aHsLQ=;
 b=lHbznCBqdPIieQ8R93p4oWQNmXA2smAVXulgRTJMIx50YW+IZxLVPGO8ViNBIMS7TMIF
 GElc/+7e/t38ZvIe+owxlfqI1TY2AJ0QcmCPWer18fc4ngi0ZSarPGCBxCekYCtl8s2H
 qjWruqeitqVsEWtj5HI637Wpb+jzA0GyS/DX/GYYYe23ENq3coKX5KgzBjYkw55OqEYJ
 zsMcnO1wrPMY/jIaVjgUpSUBIOGaoMnwQwc9+nSBzQHhKWUhpBnPLm2Jru3uwzE/OTId
 nnVdIL4d+giFOb4bzBkgxONwCN0o19xHkmcpxZ2ooxOEdX0Gv83Nch1vq6qYPz2r7bTp DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptr2rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Apr 2022 06:13:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2396Beji019391;
        Sat, 9 Apr 2022 06:13:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0jyuvm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Apr 2022 06:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwT0UxG0GD/IHSd2GgRyujUC9ciggW9JJKkk+bWkrf02AsYjUJAS2ot8yuyWtW31NMj4uN9AsreiGj+VNhL2CmYcCDoFkq7UYDeS2FdrFHLttGO+p10VIhoZdPVI+6PZ7dnZovnat2zFXzLAo6UclZ4NXMvXzZWxnoz8t4suLPFpdMRiiWnBltI4ofEdsGTyYZPUzyr4MjdHwAMqnKMfd1g1M4SloJrloqx1OrMgJtT/V0rsJFiD9kfbiOqNt6X8Rd54yl2RGBOB7dBNSrtIJ4+DL7IGuParLEshHUHa6KVR62tz0L/GYSd3Zd1KpqUPrYMaLkpcrxWwRZuQEz6OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcYpcPI7AFaRWzjjc43/ymIP1TZXa2J66gfyR5aHsLQ=;
 b=nOo+6N4zBnnYvNYwSiS/P+9S1UmOJ03N9lwXYz5KZNd5DZ+RnbJTh4CryhbTG2GPpxKGZW/rG1o4t2SXTHnzsHH6rLtlnDwVwD3dzsW6dHSVrYZ14kLI9Ki1N1I1Ry89DcYVqPB87phBsiWPTyfbOJXmI4azCj8XUxst4gqD+g7qNjoo+mUQ/sUQL3EbklRhnETmo9Fp4YoFjsOxRQPm2ng0EbxQzCSIHtXAXZWMx/FaBHPvPKB7kTFDaZQbfP1ioiscAfm+Crv2wL4cX+liczllCY73IBh8JRsx1IJSNBHLvtlzNuJ8T4y0zZiPQS3vss+l4l4dIkgaCtoDwwWD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcYpcPI7AFaRWzjjc43/ymIP1TZXa2J66gfyR5aHsLQ=;
 b=BN46m0rtEyvaZqeZXPtgPsUYRm9H4InVRR6Bbr9HEHwSyw5NDRfDlQ2AShShCeyoZVuFrSXvQonHkXZNSj0EZCdngmqI6l2+rpwetI3wrVnnKQ0nqP9E9BurvhWjdB28VsLj904CJ69VEtQP0CJUN7KbpvSD5qKItsW6brFkh/k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1681.namprd10.prod.outlook.com
 (2603:10b6:405:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Sat, 9 Apr
 2022 06:13:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Sat, 9 Apr 2022
 06:13:29 +0000
Date:   Sat, 9 Apr 2022 09:13:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw89: pci: reversed conditions in rtw89_write16_mdio_mask()
Message-ID: <20220409061318.GB5447@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc77f5f9-43fd-4c17-f74e-08da19f01129
X-MS-TrafficTypeDiagnostic: BN6PR10MB1681:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB168185DC8EB88CBBAF4700108EE89@BN6PR10MB1681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XW1kxBI3V4ZgbZUgZwESWfu2l+92MZBAFDfEVNWrfwuoTSGmDZR7nP5vc1bh01AzBC1rIyKCVpLkhJ5n2XvPRY9X3rQnhs+lNi7oybAKMwnNut8N4VHdLPhRT0bU/n6vC/u0aV6LUXZq7ZYp/ehOEVQsDGeZLHkBIQTUOd3lOHkRx7+x85csjPjbxoH7At9ub8KwlffeLN4BEP/j3SCffzwvmMSlWMVnc19sww+hiQSCL7tJeCsGpKipOrkJrAEYb242j56l5/FeseyihOuMkp7GJHNWmFfi1Sq8kImTl6vzPn2cPEE53Q9F5siBCwUa/+DzMM8eutL4VJl2cDvyZZNA2/o5+K4Q61Myn7Zcv3YGW8E2fJRtX9WbHzfPzQjxsdjAkUMPGzxo5oq+NiGHjHggKYvktBlLBnzjhoB3CPXPxyVcBznaqA+r7ii2dOZUtili+da8Mwj0gxXD1OMw6SVgJsH8s4x7gV28CVkUAfNsGHvZTESZDBvez01/K3HZVK2/rZ9EV3/I0/t9+XNTDlq+M+VSfDJEyewqW3/AfiF4hN9awBnAhdGVx7sYV00TtL3/bq4foKSY9t2wHWGPTFyWQzE9f8Lao9LMO6A6xwa7qUPLTp0Mqv8BRZFwiLu55KuLtTL5m9lk/WoHUuiMP5+FkMynM/1gIagGz3lvwueRAqA5d4Rd0WYqMYUh660jC4TATdhYCRFqWGXeqyUAhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(33716001)(2906002)(8676002)(66476007)(4326008)(86362001)(66556008)(44832011)(66946007)(5660300002)(316002)(6916009)(6666004)(54906003)(6506007)(33656002)(52116002)(6512007)(9686003)(26005)(1076003)(186003)(83380400001)(6486002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LyzdGB7WRSdb5UENndfAobgeBSZH2fxjQfaR5A1nTk69IOFJLm6ILoL8TW1t?=
 =?us-ascii?Q?HxhTRlqdmBkPkGMnfWWHXVbwIULc5wBLRbsUHEMXhokiIIbVtPAYaUriW/mS?=
 =?us-ascii?Q?iwZbq6314/WBnUBbKpXW1xxEBQrLYDYshK8nkZ2KA1/GfR3EJC0oYedmJu6w?=
 =?us-ascii?Q?o+Ttrhm6giRRDRrZkeG9vUr+CkCrINyt+FOVHUxNgjlco54ToRmLNQEzBktS?=
 =?us-ascii?Q?dP88aTIARQ8jEfW9lOEH3M+BO+YBs6RrElrGVtxXUZLTYxTtQ+H+Z9LvzdZ8?=
 =?us-ascii?Q?AO1kR3tsGxanby13GL+Y4ybNPBhW0tsgwAsbNkK/8YS6GDz/iZgMN9nAZy2+?=
 =?us-ascii?Q?ChxYuVOis80+wDVX+97UyJVdSpRHro6f4YZr5OntNtW4es1VruSBIRmzk8KQ?=
 =?us-ascii?Q?TPQUEq4h+JiVjYuGZ7/PLe05Hrr9zlNlB37jF2Z43YRmm/leOLUoN7TueNIX?=
 =?us-ascii?Q?lkkQfb3eW8GocOC1X6QMCOiDV8d56qLmtfZMDPFbW/cDTd6Vs7Y8ry6Vl5jZ?=
 =?us-ascii?Q?gs/iTA5xl6I5lSC0yZkOeOgXrms3Rzt3UEe7rzCqPeqnmMgD6UzciJqQbOec?=
 =?us-ascii?Q?kdsqWDd4zWhAA9FcvOmIRl/iWixNGNyU7wI+wBrLVQlfldyW6ebjJM8i0rKS?=
 =?us-ascii?Q?tEmQDqRoVDHw/foVEZigL+sflBKcvALRjeENQ3JbNyHVJsRowsOwrKp1+HA+?=
 =?us-ascii?Q?LoVizaQBKngPczGJHBLyM7myCezjOqh+dsS/W+LGXat17yb+praYY3W2+GwQ?=
 =?us-ascii?Q?HQXHOBpnw846o4nDNOyU4k4CzN8gjmk4MK1YLcL0vpQfdZixpde7ySIIfGYu?=
 =?us-ascii?Q?Ya9Ww/aX7DVHqDuUnIqGsKIGBkkyqNcrrYdqTqJW73j5dFShKJ8d8iMXPnYK?=
 =?us-ascii?Q?8++vUF/vP2artlVE6QYbvodMxd5MNfNnlHSODdz7OIDsfNds5vEAoDvOpBdb?=
 =?us-ascii?Q?WTAkRct0Lw4Jy1/ZNSRmpnOEyYZtXE0FBBCO7u+sU06LdxG7NMUxg0Q/+oGp?=
 =?us-ascii?Q?9V19amKaLDcNL38b18asLYrwtnx4bbnvZZUC/VEsG4Ij9LcKMg3eQfWAfeAS?=
 =?us-ascii?Q?MMztzsEH8IvQV7fjeMKZAl/GDYVFeR9LnWIjBJNiCHjqv4XdUYxGA3yEUDBT?=
 =?us-ascii?Q?8ygFWzG66jek3rn4DpRwNviZ1ry1Hvu32pAioP27qWz6E7LQBaobVVPJhZjy?=
 =?us-ascii?Q?x39XxGcPxqmN+VlFOeazX2v1HjUBPA+xSAvqF/wRh0W45LkzTiTNCOKrPCCd?=
 =?us-ascii?Q?EAkEI8p7aIfiIDcCRrNe4IsPYb2YPlEiR9EvlEWU0r2CjsvZ2O1nvP68tR5G?=
 =?us-ascii?Q?W0KNi5ji6Wo4NeE1YxncW1kGr2QC+b28spJG8RDCOUKkJwcrbLqVgvk0Y5nq?=
 =?us-ascii?Q?DPPqeFFJf4AXRse8pkVKMlbJ8Of07H/cc+HMu3NXh6DKGoRS/UeYeOZHlzf0?=
 =?us-ascii?Q?4IAKX0rKIECCO9u0y67j+u8NGb7Tm2g8sFXa0g7X1KUh92pu5wEX19WJJ6fe?=
 =?us-ascii?Q?qqVGFJu2j8plkFmfgD7YWJGJXVOYlb4z6e8HiaNjdHpBVN9h7yyBUkzVl14Z?=
 =?us-ascii?Q?qDm1BneVDm8E6bxX9doQNR9F1tAp79NyitFPhJ2/NilSo0na2t7kBA/5yAcz?=
 =?us-ascii?Q?ghCTmU8lU5FI4iufTic7jZt74kNE76ktx3XKDMqvwm73irKemLZ6wKfp8xP8?=
 =?us-ascii?Q?dN4fNVQAGcXQdpkgAQn+OhdcqZ7+HeG8Ikg4MAZG58NSS2yTJh0a1t13ANsN?=
 =?us-ascii?Q?Zm/qJWhoLdC5JGw57q4YN//D1ERgNKg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc77f5f9-43fd-4c17-f74e-08da19f01129
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 06:13:29.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP5TFIZW8VD9X3FhkWyIXM/hohqCV33Ku3fS4TeQH1H2hQ0LK+Ys/s4fVqKeBkzGGnOozJPf/DcnXUx+BCpA0tQT6GcAI2PEjHQZRmFV9u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_09:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204090038
X-Proofpoint-ORIG-GUID: Y6Hv87vnT8EowbgKElCIGcJqZ8QbbZwf
X-Proofpoint-GUID: Y6Hv87vnT8EowbgKElCIGcJqZ8QbbZwf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These if conditions are reversed so it will just return success without
writing.

Fixes: 740c431c22fe ("rtw89: pci: add register definition to rtw89_pci_info to generalize pci code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index dcf907b81cff..ecb419010f0c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1522,7 +1522,7 @@ rtw89_write16_mdio_mask(struct rtw89_dev *rtwdev, u8 addr, u16 mask, u16 data, u
 	u16 val;
 
 	ret = rtw89_read16_mdio(rtwdev, addr, speed, &val);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	shift = __ffs(mask);
@@ -1530,7 +1530,7 @@ rtw89_write16_mdio_mask(struct rtw89_dev *rtwdev, u8 addr, u16 mask, u16 data, u
 	val |= ((data << shift) & mask);
 
 	ret = rtw89_write16_mdio(rtwdev, addr, val, speed);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	return 0;
-- 
2.20.1

