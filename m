Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955B567F0B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiGFG4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jul 2022 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGFG4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jul 2022 02:56:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD5B1BE8A;
        Tue,  5 Jul 2022 23:56:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266641mY017821;
        Wed, 6 Jul 2022 06:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4JaVe1IloRwpGT4ikJwSfLNPbCSJw1NZ3MZO9TgHlTs=;
 b=oXImPXy1rHHv8AZdbxSiIH1mIYKF8KchkkCzuVfnXBRuYL4ZuoKQUSqNJNfnAD1s3fGS
 ualnMgTpuahDZIIcXBJRFZJQ+yWEMDpHUb2j29YTRw6forGvurOZe5DKLW5QBY6UYNzk
 dH4Z8nTLKzyKmrIzY3msO+FWYLigwD4EBCO8SpSgKoq34vDtZc5oM+xR7R1V3AM0Ov/F
 5tChEbYdj0+jXVyueOFoDDfwXC7tA1idJs/iSbJ25DLenRunV9b1PIvtIn1Ej7UoG5FZ
 Fwx+qvfuVTKcQIXcJKjpmMhcH1ldOu7mnePdbzkDKgv++ZQDdogjcecCggye0HcFxKab 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyh2dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:55:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2666fBKI028419;
        Wed, 6 Jul 2022 06:55:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud0jjgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxfai07+pt0CUO1luyNrpjc7kPOue4uIBwxumceOEONAVyB30ONqPKAOmJSLF2FMPsdykwwInXiHX5GM9s2Yht3CcjRn+w0TAPbTrjdxpbZ3pcCW0xm9cAKNSRdcgfTGxZykYIi5X8vMbVnJjVp+XGMSE2PTC4OwDiq761D+UYpy2UNyI+A3npIDr44c/qChTWE4icIMGm1iqa07Mhh6mqGdOL5zEi6+cItLdp4A4K2KszW4Jsq4VjaokKqbPBqqIUKcuheCty8vt0ht8Pi12yua+Q5RZN4AUN/Ojg99h9XaRxe6SLHo3b3SnJcDnKl0vwEyDCC3ys7EM1fQHkDR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JaVe1IloRwpGT4ikJwSfLNPbCSJw1NZ3MZO9TgHlTs=;
 b=B01vAYIjK2mYP3/fwi6cC2YGOtiaL5rmug4rsjdjvaR2wq2Y6FVJ7jRjtWBdw+EpY8oKtkRxzGsqhscIVNr/6Ol9t9jnPUH0csI5WL94NqKqfAWiRZf8cQah2WNdE9pS/o3YVPeeg2MXI0QuY4vPz+IMaz+kgSgXno5TSQEQx/zJgrgPM9YHcVdReJYfUu9ho5K+lZ8oli8otdLNoItpPSNUrZBog71kUmYhClxkdy49Chs5NmphHTRL9K5Dee5Nz1h2XrbV3hNLXFSQ2rM9knQNfLN7yEG0R6BGIL4hTozj0FpOMKGyl554q8Jkg0fD1tFCA1d2sytM/XSukXJDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JaVe1IloRwpGT4ikJwSfLNPbCSJw1NZ3MZO9TgHlTs=;
 b=ZbHswLCDrohCi2AOkZG6nh9xoW53Y0F/KdVdtpaZjBU+cgmtqG9SB/XeQpn+aSozhkxlAOHP2TChwPB2XGeO6px4cjjs8DEMJ3SEWopMr6R8DCn5sHjozxD6PsK76M29jtfbX72WKq4KJSEc4bi53q3bexjsBseitO9722rl+t4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4642.namprd10.prod.outlook.com
 (2603:10b6:303:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 06:55:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:55:49 +0000
Date:   Wed, 6 Jul 2022 09:55:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Kondratiev <qca_vkondrat@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] wil6210: debugfs: fix info leak in wil_write_file_wmi()
Message-ID: <YsUx6tbR5jhJc/UH@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0174.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c99d74e-89fc-4500-7253-08da5f1c8ee7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fz3+DYDphidgct4FFabBIYyKnQt11sNPOs0xnTB+k9lmOk+EhIo4sLkTXtYPpb2lcUrkYXNgriLIkGXNko1cvIYkYn5nBV/UYSNX1L52IINRIsQDktlE623O+PyLQgLKWHW0DmDVYfq1unkQledqEN2UHf/TjsDLTnwGIyLjWDUp+aGg+RdFTDegnJRc89SQtmO6ilYc/sMhR++0EMzenW2KIJJ64VhY1rdgPX4VG4+ycHgkq8a76ZqYggsVWVlzYZtK0gW0jizhtY/3R/lEVHpnkzaVWShTX2Yz8P0iqgCVsclXSVuJnOc5wrNeboHiR3EadNvLmhORi6FuMScCyyWk6gsjIJ2zChDYgeRGMQXbIFlNKk/K34uZziKxG4GA8EHyEwtKgkpckhe4CDmhwHRPWJvgB7nlstImCk3VrQs5SVndRL2VcGWIbBJ5vCUXCfA/df0vcUBL2mxqcatfyWpxF41yiml9jbVl0P59MDEp6cYfvvOJ7YLep1+0XokK8AwZ9nkT2vC8ahYuejI7K/uM+GnhPtKJ+Xc1UJdT0rNdj4WBtU3+J6hytoLJGpfXeUTao+R7lZAa5FebYGl/2RyM4b4WEROeUpf7QG9/h2XYrsIT4aMbPd70xOfPyXjlasHzgvo1oxQFuAjqBOq6PmfWBBWNDejLfS6aXmM17wsJNeX0vtaN0L1zKSGzhhCvaHBSxMzp6cDoSg06tcaIsnWFzYcrRF8ksgh4dFvSH4XTicO4DlVZzyYB0MywLD7KI5WZhndmFougx8xUY3DniV0HO6oh1EFh84YosEyER75WWtrdhd7YskEAsCNMpwYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(38350700002)(6486002)(186003)(6506007)(41300700001)(6666004)(52116002)(110136005)(2906002)(66556008)(316002)(54906003)(8936002)(5660300002)(44832011)(86362001)(6512007)(26005)(9686003)(83380400001)(66946007)(66476007)(33716001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6j7nc5AJdB0MLJ0YPCDOTAKVmpmKDoMkUWlBYlQo3U5N2nkrxvURmz2X4zx?=
 =?us-ascii?Q?wrNenjHn3vIH4TMD0yi/MJQMsW/iFuwcoLqKo2CXUmf79X7Y5yoh+NZlON+S?=
 =?us-ascii?Q?+UEdYUvC4aMrtKP6GJL15akvXTx8qNdxMoJd+MTnLZMI8TeSibLlOO/egKAO?=
 =?us-ascii?Q?hEOgI1n3Mb/L7GXc59slm3tktH+ifjCtRlfit89tcxE4YUShVura5luxVNDO?=
 =?us-ascii?Q?Kvw/n2I3H15ZoeTbidFHjQBOYQVJnCiDBmb8vtshdB8o4i6qP9ANc/15Kjw3?=
 =?us-ascii?Q?tA99aljhWkGDY6hC9uyoC4LT1EfqRhDCbcSHIMhMQ1Cy/dVRmKGrJkNJJqSC?=
 =?us-ascii?Q?45UaIlP98mmdqdzBbHH1cjAn2H7P6PTXiimi2NBMj4uawmN9hzNtsXEwPgs4?=
 =?us-ascii?Q?XmGyMaJKAV7CEjaQxJrBPA9JZoUufyhFMlJqA6DUKoN0/B4jyjrekMiARU4Y?=
 =?us-ascii?Q?OnMzfnJbmf7p7RwfxoQzO2s0tVqyLBVDRHyX1rM7TU6+xtaa7zWGy94yF1LA?=
 =?us-ascii?Q?xsVktTgW13q2OwsH1SBKUUqsuscfbMZ7Jb7AcvvCSiVRboJpr814znvqk7IX?=
 =?us-ascii?Q?TQSOzxjmE8T7Sv8STTM0ECPVJPSuEm40HLwHpKCrHg0jRgyAiDqsE40CEtwk?=
 =?us-ascii?Q?Kr7YZFvRQQX94xDsjbGmRRcrKiw4xf1zNlkRC12lIxKhxdS52QIXGVenHeqf?=
 =?us-ascii?Q?rKTtpeI3fbflEZ/QOW7oRMYpAk2JAPtzqFUzFTTEp9gOOAfqdIEmw12WY+KY?=
 =?us-ascii?Q?iuxV68Tv3zPTSSJ5JhSLsovZtzgp3Kt+BAstjD3Hu8DIIbQogHTIExxrmFGG?=
 =?us-ascii?Q?qW9eYBhwYrQRA7NoXWRcZPP1zM5FTjuO5PfEAQr6w+HGF1qcOBfOODCqqp3/?=
 =?us-ascii?Q?8pyblrCX+0lsGmQxW8oA8Nsm0hGRAUiXF7Y5kh/mYdQHTrP4NK45qFzoJeqf?=
 =?us-ascii?Q?b1F1M2q8JVizvVdK4ZttHW9nEW0UGjU5uBvcQvBy/qy0ZNwd5Dc2Cgtb1Hq1?=
 =?us-ascii?Q?PgJQjHJQNT1Tj8xbya7N0xy94Qfsru6fEurO28pxiuZUfuZmEg85V2oeXRuR?=
 =?us-ascii?Q?859gTcfOdSlQU9nsNtihQlp0zFAW0Sm7m9uzCkch3DrWpCY2NC6Q3vvyFG18?=
 =?us-ascii?Q?0fbmK0cNVyrdLdywznxqOZ12YNG19DxnYbMIAC4bqMWh2sircP+PIaVNXYcP?=
 =?us-ascii?Q?1QgRKahyKYDRC1NG/2iHEl5wBP1uJGb76laSAVYaRlEFFpOZaYQsjB414J/s?=
 =?us-ascii?Q?SddVDgqWZ0a9wG8UBYFdZ786Um7EluFfpKIMyTI0fr5yXxaJk07XfJbahuHY?=
 =?us-ascii?Q?ItWHmAcGJGlfxHUZ/AEwzKN9XgkTZ5bND+J+25/Dan8KjzqGGs+ExZMwBmFs?=
 =?us-ascii?Q?EZ8XzWqL8k/wDKyc1mhPFryPtEX8rRS+0bgXe3RoZrgUDFbdBl+knah3/ggw?=
 =?us-ascii?Q?foEizk6xlcv/s3/DA2xG7/Us04b2F5SdX7ctLArv/P/pml65FqlvHcQUFQMJ?=
 =?us-ascii?Q?+gG7T3Jp2cJyp/utbY40MPXt+hDAEImlUHW0wplHBmbMxFnsw/IU9Zt/omtA?=
 =?us-ascii?Q?ydcAXbUz4n1HPL8Ksmm/H9oTAC/2rUUPhFEGd5TUobaL+sN7oq/L4QWe9Vcp?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c99d74e-89fc-4500-7253-08da5f1c8ee7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:55:49.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH9+1EH+C9cedEEySR4tpvjIosPC9iehd2R2G7xTSh3CFf8BOoV9BE7aPcW/u78iYsDFw8lP/vkT2Rq6vnX+SdabAheRwnEtzTiGpyTT+c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_03:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060025
X-Proofpoint-GUID: syK9cHyjw6R_9moI7nzZTzfdz0ufT8wP
X-Proofpoint-ORIG-GUID: syK9cHyjw6R_9moI7nzZTzfdz0ufT8wP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The simple_write_to_buffer() function will succeed if even a single
byte is initialized.  However we need to initialize the whole buffer
to prevent information leaks.  Just use memdup_user().

Fixes: ff974e408334 ("wil6210: debugfs interface to send raw WMI command")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 64d6c98174c8..fe84362718de 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1012,18 +1012,12 @@ static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
 	u16 cmdid;
 	int rc, rc1;
 
-	if (cmdlen < 0)
+	if (cmdlen < 0 || *ppos != 0)
 		return -EINVAL;
 
-	wmi = kmalloc(len, GFP_KERNEL);
-	if (!wmi)
-		return -ENOMEM;
-
-	rc = simple_write_to_buffer(wmi, len, ppos, buf, len);
-	if (rc < 0) {
-		kfree(wmi);
-		return rc;
-	}
+	wmi = memdup_user(buf, len);
+	if (IS_ERR(wmi))
+		return PTR_ERR(wmi);
 
 	cmd = (cmdlen > 0) ? &wmi[1] : NULL;
 	cmdid = le16_to_cpu(wmi->command_id);
-- 
2.35.1

