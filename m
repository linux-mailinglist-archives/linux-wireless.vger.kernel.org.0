Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660157DA64
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiGVGhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 02:37:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E2715A3B;
        Thu, 21 Jul 2022 23:37:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M6SpuZ002647;
        Fri, 22 Jul 2022 06:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=nLB1+MnklAt1DZngAoP7Vq/cdCAcS/+QuLCXVJPh+20=;
 b=pcZh7Ge3YWVBaihRccPBX1yj06pMYfxiCv8yMOcbwf3BjAIZtCT2T8nFFj1UJ1zhQt44
 rzgiGFnop5LxKE2/3SdNimbe2Y2o1nkii91TqFGVUy63nDQIpfXKWKCbYjQt4cwM1bqt
 TsCpaFcDlkycHoOOus/hPGSTAN3RoawlMj7oM+bOF2VmUjE9SavPRLPeIIVdwp09JhbN
 xW+EwoQOfA8am6a1FIJmbj+hgDjFUI2N282Oa/ryRai/X3anIxyqdqkgVTYB2+7yoeny
 w+Eu2bM9L5vERtUOfaiPbIGK5+bY120RaCVK+/CumQmrck60Ngbl1w3GYXbUyODUaM+U Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42pjvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:37:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M52vGr039183;
        Fri, 22 Jul 2022 06:37:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k7hsf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuBIwb/i4AImo/CyZpLGqCLltPbdi4FH8XjhUE+ly0aub49j36/Uq/wyXGWQiLes0RzKZmWbbezu4T/MkwSalP/d22W6LE3mojp0NCTHmQ3JVLdhx9yWiLpZ61tB2ZRl6Uq3qj93dmPMzJLgw96s7SL2G0cVHYYFEU7h9UgUS9htOc9QZPLumNTUJOei7K3z6KzGphutqdrQxWNq5j9zfhTOcLDLL2Ooeq5O9CAfVZp7wRMZQzg8RfhzXlcJNdO3Rq3RTgUcknhyKI4jCnXR6RVhOAzv6aXQP3q2ihVv0RONHqNu14G22coUml5OpqAQPio5PqwgcqjTpKI6nCXk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLB1+MnklAt1DZngAoP7Vq/cdCAcS/+QuLCXVJPh+20=;
 b=nJZrv7E6eMAd/B38IG5vrIGgUiEdXFDKIkk6sHsa1kp5RGLrpkrR1i0IYhStgHSNGwbbErrB9T1lE6Xf3BwEI8UIDtzf6OY2T1VDPc+gEf78BkyggNTQV7Zs+fKXpprF5kYaXpBx5SQtgV6pvf3KD1oaL34Fz16XwOpc9QUUsJQeqX2m0rEgpRczfZ0ZKNoWPFN4vb1MZClrB/c6uSxOLQCYJU21wVV5RBZEfkTlRX1sLsolDaUzFbWG+grh5EzMA/qOFlXnCBOUKl9pYLkMpPHtMovff1LZ6bflx/vgbSO1Ny5+XFxYRcaep343LnzXeXWpcRVBRX4t1ixiRbLiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLB1+MnklAt1DZngAoP7Vq/cdCAcS/+QuLCXVJPh+20=;
 b=wSyW3OBVbu6IbD9TWpPtGFdlrCEhCAPFeTcHFxbQHKkZbvV2bh0d4MyAdxdFnXguHsNNMRgDwyJZuSFoNNAUcBhCW7GPm8E0Y4Ss90ryaA7eA4rnIR3ltJizaJq+cP1C10y8qYA/8uWZI37viwaNWdGHiM6q3zmm1AEmCu2Rh5A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6196.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 06:37:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 06:37:20 +0000
Date:   Fri, 22 Jul 2022 09:37:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7921: fix use after free in mt7921_acpi_read()
Message-ID: <YtpFk+w5Q4VA8gyK@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb520553-55c6-4b0f-0d16-08da6baca098
X-MS-TrafficTypeDiagnostic: IA1PR10MB6196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufdRuCAiIsVbK/k/gb4T+qekmW67TXxdWcv2ICpJSUnPZgM+Y417UFEAM1E4cq+oNcZJQgYNxg9DFbVILkS4WXH+HBrLrMx+H0IYTDKabNNMUv60LWrg3D6Elo1ZNWL2sOtJ5A+NAecCRNu5XobrnoSTIxwcJgzyjH1QtjBHqVbRht8/oHWtmsv9q6yBjqOerZpA5bydlqcivYhRRE0AWUPwJVEvZXGA11Dvw8CAsCopuqliiERCUusAVbuJoBnHmLU2BzV93QGIQmSx/YUObyGMKyu1+8FDctHPgEYR/pL6bNDU3Igpq9eLcqi/ktY4c40xHUlIFRLv15OEHvgIlfawvDHIGxwGgrSS80AAwR9dHl7xKQvElcaX4D7daSvuEQoESC/0+jKtg9XHsl02EaOy7ylybhR6VVrMgJl9H9naAppaTD9kP4vrJPdTPy3Yq84/DlUZGV6YoPubZlkO4ydq4pQvs72ROFD+ymqXIIposk9Eq2bIrRCDVbbCdjq8f3EpadBFN3pbIF01pJcQLJAELKtPjE+vuCnOomv3NSepY6S3aEmKMafxF47QSrmuwzLuWeCeS6OIMnrmKylEQ7awWr+KGhux+K01bQxovXvEoDMdk/mbnLNWKVYFX0LRXH0/CbnOhQKzZ0n8rhJWdo2sgRdWvNtFxCcN3CHyp7DZe662vuP7ULKlhcu5y9NcjOmJHf2BUyxR/U2bMgNLJVc7Fgo76czz0k5E2Sjh7i8ofOXBMjLxCP1OoyFqpQ6PcQCqy6s01+uNZg7lTafiPPG1QIfO9P5w2dIfJr812CTq4n6LS55L2MNPcz12igpBLAgQIEX3oHjaxLyI/oMAGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(4326008)(66946007)(33716001)(8936002)(7416002)(66476007)(66556008)(44832011)(9686003)(5660300002)(6506007)(38350700002)(2906002)(38100700002)(6916009)(478600001)(26005)(6486002)(41300700001)(83380400001)(86362001)(54906003)(316002)(6666004)(186003)(52116002)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oQNs3Jsn8je8DxPtvsRwLbzX30j8aWy62M8YhD8555kXq/lixNvpgh9P7U7k?=
 =?us-ascii?Q?SK5mthUV1Fl2dceWese0rCk6tQ4hS2jH4gcXOFZ6mqwv2ogm7AhEwrJK/+Ej?=
 =?us-ascii?Q?5UltUgYVE0vv4nHZ8mccwfHgFukgSmYwmXrOg2Ga9HpPfyQz3iJ7yRnXbaEP?=
 =?us-ascii?Q?Byz7LPD9F7YtVGT5KQJa6u5nvpMk1450HbjWp1JqJh52wkZQYVYT0bLbFv+M?=
 =?us-ascii?Q?pVah4vfGQX0I1RzSDSUenN5Im08AzhHm4YHewZCURMqBeBNapWOC5Rs6eTTa?=
 =?us-ascii?Q?b7faDwzzH8VS4zgMx6xTI/6BZWqiT1K5RgKYJQ9uHiZCcO0lTa2q38jePoZm?=
 =?us-ascii?Q?dCnAB9NLLpsoZBo9xvgJaMYwXG2ognFvCy6OEFglR6QFaG1qkFdVGk+Axruo?=
 =?us-ascii?Q?I6oDe7VMxlk9fHTNYLH1xh5FctjACbZCZySAcxyCDdjnW/oHkaZXB+IVfhqW?=
 =?us-ascii?Q?DLKO+HHcL5EPBroP8qn1QMAyfK9tr1Xe5LOpE3ife4doO+g34+FiQt8WNWWT?=
 =?us-ascii?Q?SlIEfjnX16XC/wcpJE9qxT3mFE8wc4hSQOnjjMWJeBhpdDdMoWTvBCAZxYZn?=
 =?us-ascii?Q?Ou7ZuxfzztjpDHLIUNhTm/Lmbw1ENkq215UFIkGmTEZjl95ehXFvMgZa5y59?=
 =?us-ascii?Q?YoWhx6pBELPIIolq9gsoXVh65cvteq4aIhV7s/ipd8c6YhGn/jRaS7ddlvpG?=
 =?us-ascii?Q?rOHEMiUFQd2t1LoxR8K1NTr4ff0FQ0FcSQVF4ZL70hYfzPIBqK/+NwUbq+ZM?=
 =?us-ascii?Q?/PcgZctFyE/zvRsq5agI/rnai6XQoa6PdeRzRx5HQESluv9Yo3Thvwr6PcqE?=
 =?us-ascii?Q?l1wCDcRk8Cb3I5NB5s4qcgxDHV5oDqZTjaNEjjVsKCxzrqYqO41fuXAu+NIZ?=
 =?us-ascii?Q?MX6UDF5/XwkOPwQxZ1veE7SCw3zSSGRDJulwZLEgfYtMuj/pSGPPGKIdiUkB?=
 =?us-ascii?Q?dWz7CPa5VHMKGdLtUGRWEsyZk7k+lCTqooBQlwiSPQmRlXQX5mJUo/6OWqcF?=
 =?us-ascii?Q?e8a2s2OKIWpp9PXjmtRcs6bNS5FgU/99m32NQ3UoYO077CzlvOpEMozaaT3b?=
 =?us-ascii?Q?zP7eQUHPOrjh/i/+O0ooQMQQ6nwGD1oikU/SQPXfezFv7esUR+bO9YSysqou?=
 =?us-ascii?Q?WPpX5ataRM2iqyMzLFZT647+Ixi5Wp4kLXKla8C950QRsn5gmEkh9pWWQnYe?=
 =?us-ascii?Q?nuTcbDl/B8R8y2+T+l8275pC2BZFp8+EWKEkJN2/Fi0XkiJ3FYgdpF2wtwa+?=
 =?us-ascii?Q?WA84qaDOsTSsAVTgLAtjKJLxoymxuLXrMDZMSoEivSxdvdGIWEXHind3y+4R?=
 =?us-ascii?Q?vHC7vpz45QEZpk3xMW8uqwjYP48oL3CshQEublcYUtfVJ4s/XF275KNESdlX?=
 =?us-ascii?Q?Q0xfUfBK6aCRJbaVu/aSEEJQitkcDapv5cGvKh31e07pCOYvVPl6PWRrHUHX?=
 =?us-ascii?Q?ZIFgZ9uRdwlL50ERCvb9yTN7D3BGc9uMFkO9XEQdgTarTxw4PKxD1vghnsNN?=
 =?us-ascii?Q?Jt18hgdsjNZHLAgp8L9Pu61YDWm17agyXhNky6PYdKlrz/8vSVc1BaSqGu5k?=
 =?us-ascii?Q?WREBfYoxMqPVEbXanTYyy2AlVx7WB4+cyuFyl2UVwn+GDATDLuGpbHCiNsvz?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb520553-55c6-4b0f-0d16-08da6baca098
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 06:37:20.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e4cW0Op7QzIXI/hzGxRDG6hdrd560TgtxWaDSHWSZ4edVT+UQOT3zgFniH5piPTfBmrPu15qDUyr7qsyG7WovO7cr9uRm92I/s/QajA5Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220026
X-Proofpoint-ORIG-GUID: 8Yt3Z5ey_LYxKOInzosAGYbOJ1LrnV5J
X-Proofpoint-GUID: 8Yt3Z5ey_LYxKOInzosAGYbOJ1LrnV5J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't dereference "sar_root" after it has been freed.

Fixes: f965333e491e ("mt76: mt7921: introduce ACPI SAR support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
index be4f07ad3af9..47e034a9b003 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -13,6 +13,7 @@ mt7921_acpi_read(struct mt7921_dev *dev, u8 *method, u8 **tbl, u32 *len)
 	acpi_handle root, handle;
 	acpi_status status;
 	u32 i = 0;
+	int ret;
 
 	root = ACPI_HANDLE(mdev->dev);
 	if (!root)
@@ -52,9 +53,11 @@ mt7921_acpi_read(struct mt7921_dev *dev, u8 *method, u8 **tbl, u32 *len)
 		*(*tbl + i) = (u8)sar_unit->integer.value;
 	}
 free:
+	ret = (i == sar_root->package.count) ? 0 : -EINVAL;
+
 	kfree(sar_root);
 
-	return (i == sar_root->package.count) ? 0 : -EINVAL;
+	return ret;
 }
 
 /* MTCL : Country List Table for 6G band */
-- 
2.35.1

