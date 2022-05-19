Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF552D576
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiESOCO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiESOAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 10:00:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945EEC33D;
        Thu, 19 May 2022 06:58:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JCxsds009233;
        Thu, 19 May 2022 13:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=OPLKH6QRLHnZLvghbm6oc6FwmL7O2t0XVxH1l2nLSys=;
 b=SyIqKVcXoef6OFjOUVlYUxp0hNxkFtzspZ5KU9sQ7EqelJ56xl/1rBe6NWZKvIn57r+i
 +tfO/2lgmThnUmB5pdXNzrjYJYOT0KHbRFgtcV6+PBBgo22OlU/rq72h+ByFCKOJLZAM
 ZawUKGgtb0tjBNEmOI1yhw1PSkjP3F7IWC8ZwMZSYod/SzUQfDuxQ8n/4A61FF8PIbVL
 0M0ygffdo0FrJB5j947AoEwNsg2+iUleHikF9TIOHmLfRUNnVqEiC1gof8ffrVjIpVxx
 hkPKZ9DD5bIVjVWXoRJ9pdc3g3BnXHPDWkPVbLw6OuvP1hn5HAS3UcsfQ/c/0NSgFOUD qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310vaw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 13:58:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JDtqPQ025119;
        Thu, 19 May 2022 13:58:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5fp6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 13:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blfH+vLZN9gbmBkBF1+0YUpPZn6dyMFVYQ3Cu334fNi8L2aPUdkXG/4i8GMvf2dNbNo/5zrZSJpxgYWLF8Av6qVRJ8jyvjN6sU0lVVQOcnaXqvey2ni5/BYaBPjz/SYZq8zP2k4MqMFnqjFHWG3DHbYlUvYpb2f8zw2wVgyaynlF5smhQLtuAd8EiO9dxZT82zQp3XuHgEHp0eVZjriF1E5E8WAzQiG4spDcRubLSKDIApJZn8v14b06mfb/Vaz7w7LhMbwKzsNaASkXPtQzIvFPtiDuQgXQn1+Y+PGKs3x6vgy1hIUi+iiMx7rNuhV0FhKPdv/+jlUh4khuXWYffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPLKH6QRLHnZLvghbm6oc6FwmL7O2t0XVxH1l2nLSys=;
 b=jNt5OysMkRFH+qfYHWVFC0fHkSzOG1jZvPe+Yo8/H6nATcwscBA/m/8IkZUu24m+eoVYgQaxHbMSdFfArR6ZvbSKgQ0twIPGeZB47tuoXZGWCFOO1qQj0gDWaOe+FHyJbTbwUZ3S3C/0bfXIvfmnlcH1lNgt7K8hxf9tNgtYPRphkJPrQt/ivgr1Q7E2SWVSrlf7Ko13N7UqYaXvudZAC8gxvoD3Y7n17gYW/6+i2ri31+QV7iZixAnDdAoszRExhoiTCuUPaYVtcIrptmG5PRmKZ99V03jznbLYJ536FzhFw6sun+zEMsiiggfjJ7WvWMkY5UD0kzlHV1uyUKqsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPLKH6QRLHnZLvghbm6oc6FwmL7O2t0XVxH1l2nLSys=;
 b=VPOQ/zmMIPCRKltISI68N+yfC46cs9+0VzkDJrU6T248C6IK1pqHBnM234gqoMvKC1X/wxNFD/vzTwiWbOCR7CUU1CuGs91Hlm/FXnUKEldf+JMVQWnwH6JL6jxhfSCJTkKqcsmqn7Tg/DXW1nEyWbpXZea2vvQLKOrzRWCZ+OQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3023.namprd10.prod.outlook.com
 (2603:10b6:805:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 13:58:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 13:58:13 +0000
Date:   Thu, 19 May 2022 16:57:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix endian bug in mt7915_rf_regval_set()
Message-ID: <YoZMwqVnZYUprg6u@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0170193d-0170-4ac1-f9da-08da399f9d60
X-MS-TrafficTypeDiagnostic: SN6PR10MB3023:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3023AFE8118CF7E732DC2F488ED09@SN6PR10MB3023.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3c7r58lPXmgWMYsTPosvIg6YWGRby5wv6Sz2VZ64SmaKrDwhpVeIq58hdwgqysJRKKZ0EZJbWwLMjAKB1LzFkZc8222nUYeDndqq1LybuwKXgBVUf41EXhhiFCJFjIEu2cESkxNbA8+KYE+tYh37gqIii5wx+B5ZJqyyRI4+FwfvoH/cdKxx+cCS5uM8K+6spCSXGRUgT+Q0tvthy0XQZ9wf9kumYTAe8kS3cL6yvHcZ6+VH/aFHNqwvcrvwqqZVbOxh9l1ueAXv24CpRsbglCsZChGDp+rLqjHX7iaMvwhdUPyAiPRMrNJ6r5hHn+aJ5VeX20ARoO6LmGXFQhk7N7JVqIQfO1Zanhz5zuOFgarKNGwX07q9RpPt6s9f2XEMgyRFtlItINmYw5mwmqVn1QC04eC+tkysFIvRwIfKmZZUH6FfO3XC79Fac7baNM0sARe2uqaCxf7mu604dVFxJwx7IH9PaFwC+bOTY+2J65EvVTbwLfp+f9ZT/y/0L+ksO9+OSLyEBfI32GM4t1TWaYJ+vi3YUphf6vcM8xvNwF/pz1ePpwLZAJ2Jl3XnVpgadaRt067jQkEz3XrcPHHBW3FhMRANQtNO4ceAK+/fmDe6J1CZzO1J8eDcudFNbfS3alDVKHMKZh1b2MPHJaCBKlK99cLlc+5WCD8ES6dPVs/pefVmVXOBCFw9G/6z65VZw0r2HDD5CuSqeUuIWxqsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(54906003)(4326008)(6916009)(6486002)(66476007)(8676002)(66946007)(5660300002)(316002)(66556008)(83380400001)(44832011)(4744005)(7416002)(508600001)(8936002)(33716001)(186003)(26005)(2906002)(52116002)(38100700002)(6506007)(9686003)(38350700002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fHaYD3iA569RI1pFCDkO44Ws8R3XtqgzidJtzPC1JpFgfJ/4rZ/qJz0pa6u?=
 =?us-ascii?Q?YsmzUeXTFAYnKz1iIyFE9AmnMWKLGuWXjy4thxKv7153hNRoKTsOr2rYWniq?=
 =?us-ascii?Q?GfMZpZ3uzy0nIdE7RBYCPBVIHByWqV7kPXVZTfpcsAuoR7aNkXIOo81jvQDw?=
 =?us-ascii?Q?/XGrGw24/n1mJx2ObOV0K8Q2wcVNZQmMgMnIZJ9n0tNhsE5Zb8GPg6wCDvYS?=
 =?us-ascii?Q?myDNAvX9TOw4oLuGRtSrnDVFoH/hh9UJPJ2tREorbP+TSiNKZq/frIIn2Sfy?=
 =?us-ascii?Q?V33HN79gThOAYGE7vJk3K8BaJWeh9ImGCPy08DmDgafUl3oy/j2SBiNlpqhE?=
 =?us-ascii?Q?sJ1v7YbqQZeZpB5BAue7ZEO/ryK3IJm9FCpkM9IE03yYsbDpwoz1VkTTSlkR?=
 =?us-ascii?Q?B7HbofG+rGoAaDDj3LAwY/PXKyofBLdBnwgfe6m+PYSFJFJP4zFBf08bD+jA?=
 =?us-ascii?Q?+8fWVBlEyA4yo0MyPldXsUAqJr2wUnGlF4SqAEEgIggxHff2cyo0fxvyfTMa?=
 =?us-ascii?Q?tRcqDJXd2Hdo3F/9jdJDA6WG3c9DFVnSrlWTgiUyT3HQzgr2bpc0UQD+wVx+?=
 =?us-ascii?Q?/tYh26MTQDVkIdSL93VuoVNmOapbs1vjNJbnEg1ajnQThWJOkobz8myg1ho2?=
 =?us-ascii?Q?5TSNdr3WziqLEm5d6k9xAoCYScqvmDQeJ3gmM+xw8OKL4CLr3cjhTWfHo5Gv?=
 =?us-ascii?Q?1m73CeBRbdy9BQGxPqxxOBwNlPUdRPD04HNv+WIbxe12vRf+zaHdeb6V/TJp?=
 =?us-ascii?Q?OuoUdOvbkxN/JOZ/5L90dxZBF1PBJuol6nDChndeZ52xtMxrQM2fDTo9jB6h?=
 =?us-ascii?Q?/6sNRu0iBiVFHm9HOIChvl7TJdqryBgjag5Xt/7H9AT3zE/mAQpGMUVYiPaH?=
 =?us-ascii?Q?R9lW+78iDVg20kK62izQwD49ARS1DAYIWrBXUZMteTjNLKC9YGBV1azaU7d8?=
 =?us-ascii?Q?zd5kXFk+GR5u7b4F4lAcOfRoFntfcA6+0h2YChZF6gb0xiDyeTseNi2WCe29?=
 =?us-ascii?Q?ngcqw8Zg5EsBhC/w85kcPBE90WG/JMzMcVEYPB7CQYg8r1C5xk1gqmQVqMfL?=
 =?us-ascii?Q?q+epU1HSt/aUvdtw4jjRgK4ntb/d+W0g8c4S0ssFkvj+J1y9/u8Tx2Aah+qs?=
 =?us-ascii?Q?w9prAdyJXrj86EcXUc/rYwRNHsS682P8vB5caI6his3nFo1xn5HDNQbj7xUM?=
 =?us-ascii?Q?m2cxyP8r976hVjf+AVeAXVE90fZ3tOnlPDU87d8ssch/pfLnZ4QzMK5KIsRi?=
 =?us-ascii?Q?smaOj1belF4w789vE/o5WxG1+xfk0XCmoTSLpCA6BITpEtFKNcrTcESlijik?=
 =?us-ascii?Q?wnBbtzKYWT9rqRDo2Z+c5xh55HOQiYl7Tqv6qCXGED+t9lzc07Kq7m0deCp8?=
 =?us-ascii?Q?LCjObox+FauMsf4uF/WLOM5sF1sOPVA8662XOwYJRMF5MU+T5tY7h3aEyI13?=
 =?us-ascii?Q?etCI0FmxIJllkgDCzIXIEq9BGxCvvQrfewPzB5dECmpJCWU/9Ef1CabIfJMi?=
 =?us-ascii?Q?iBwBUu5aTEhciahq4QTO7vXAW4vg4AQ8vAYwxxeGsDoYRJop/Lz9GW5Z3TfC?=
 =?us-ascii?Q?QUUJGgYa+HlpH64tW2Q9vMGK6A6qU149pVrZNRp1YWuAjGe8TOItpr8R1DjK?=
 =?us-ascii?Q?aS1D6Wz4LO2bcuLDs23HhBIusUCGnTlqBBoltOXXX9wBC7sk3KUOkv5/6q9g?=
 =?us-ascii?Q?P/J54voFPWy22xg79kJG5QrR+OnXZZ4HD2eJe42lLTCkYPY3WdT275Bp58I2?=
 =?us-ascii?Q?2HmSLR7amTq72jQ5VqIYWzQJd2P+bHY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0170193d-0170-4ac1-f9da-08da399f9d60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:58:13.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnxRJWbw//At5A7rSZRwAOpgC+5FGtM05iqosGpdhjKzkuQKU18U348tEE09U6sc8nixgBN+C+xbuQtEtF5BGDYMm+gfB9g1FYSIPfNbQa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3023
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190081
X-Proofpoint-ORIG-GUID: xp_zIaBwmZZyiyguDtc1jXlF5gWdYZLu
X-Proofpoint-GUID: xp_zIaBwmZZyiyguDtc1jXlF5gWdYZLu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code is supposed to set a u32 value, but casting will not work on
big endian systems.

Fixes: 0a17329ae9c1 ("mt76: mt7915: add debugfs knob for RF registers read/write")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index cab6e02e1f8c..5dc8ef8cec83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -985,8 +985,9 @@ static int
 mt7915_rf_regval_set(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
+	u32 val32 = val;
 
-	return mt7915_mcu_rf_regval(dev, dev->mt76.debugfs_reg, (u32 *)&val, true);
+	return mt7915_mcu_rf_regval(dev, dev->mt76.debugfs_reg, &val32, true);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7915_rf_regval_get,
-- 
2.35.1

