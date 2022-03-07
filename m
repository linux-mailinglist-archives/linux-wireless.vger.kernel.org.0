Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA364D00DC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiCGOPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 09:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiCGOPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 09:15:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96471CBF;
        Mon,  7 Mar 2022 06:14:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227BqBPm018407;
        Mon, 7 Mar 2022 14:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=FWloTEmHovTsA6/HKJRoLmaM0xgD28CZ3daybT6zudY=;
 b=EEKOhf4C3XEpbIQUzBKZ2m2nJqk6SGMqDwlnWxQKRitMrLUyjmZyEpDlmke3FXb7vSVp
 uD8t/gAbzEJdcv5voN6Ki6VE67gkUNgeKb9F7N6tpjhWITGoIcMBCYN1V2Om1lGnN8pG
 WgoQfJnd5lAAjVlIKa2WNLNgl3LVxLPmgMz0JLkQUf7JzRuP9duuxu6CIxuoRxOBe4+n
 29LrEzyc+OupyJad+RvzG2zKOioQEkxn1w426CI5Vg28bdfKUNVkewxKjzf9iP+yo5VU
 ONQO4QyNcNOpi9YS11xPXi6qJnG0VRZwFRBIj7U+Y2oFxbxCyDC1reCCLbmiKdPyhMdL RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0dtuwv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 14:14:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227EB6kP017672;
        Mon, 7 Mar 2022 14:14:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3020.oracle.com with ESMTP id 3ekyp16xf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 14:14:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LarO7Y8B+eg8Xb7v1mXaGH0J98ti4s7FCOGRK8fPZFWmxWTf8LLTEa02KXOHfSwc13Ezqo9ZQr2H3nrp7d9SZRMBzAhic/16tYjgwGhar/oviec7fEdp5UhCyI4WbvWGDUpQJ9LDO++QWZsWJLD+lYPPyREytAxio+pwyIea+D/LJbjYqZgNqQ4O8qZecaUTzkgNyZ8pjH+O4YO4VyCal2xTSLO4hVmpXXHawDQpVIxF5u3oQLH7+uWf/6TSb4rz0v8U7Y14XPNRvrodqOKDV2NhoRUWp14q9pu2kS4P68KBrNHMad6yRtYKR2nbMGMD9me8jfcQOaWgziY5ClAgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWloTEmHovTsA6/HKJRoLmaM0xgD28CZ3daybT6zudY=;
 b=igHmnCMQNoBygtNFn53jj9kUrfXZ1ppC/Ddu6sMVjqSMNzikEcH6pQ0gRzWGDPbeDX2NCVays8dLIKO3TsDLFA0ZOjRIEFgNp0057CKw8C+kjkOTsSdqdPIbwL3yy/00j0R9EKYW/Up0lpq33MvdMVahZ+U4+ryadOIjq+sjGJiwG25E2vnvkex42ULj0Tpzgda6sr5nKGW0v7lLE4ifZI79d+RXLqZ6rzW/9pwK+AXCnXu7XDZzPFvc1G8gPWYkFVkOomel9CbLcUrRE3c0ZoNxm6WZyXQwLtgYghwjbYFVVcrxR5IYY3t0/7wKWjyhNBth9SjRr9vbvUEOfWNVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWloTEmHovTsA6/HKJRoLmaM0xgD28CZ3daybT6zudY=;
 b=YGIoQtGd3el/YEcCRDqSy0tVBqTbMrqzV+sK9y4sxp9PsZPwY2n5AgrjfAb6Pp9FEG7NjMULtpV9LKWh72ScCX+9N7XtLhBn/GB6DvMdMwmhXeIVxAN8Bo9TlTVYnxmGo+GwKKqM7GG2RtKyqsvhrKiSz9bpAGlBqXTFC56vkfc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4242.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 14:14:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 14:14:05 +0000
Date:   Mon, 7 Mar 2022 17:13:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: check for devm_pinctrl_get() failure
Message-ID: <20220307141349.GB18867@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd93859c-ed0e-48e4-8261-08da0044bcee
X-MS-TrafficTypeDiagnostic: BY5PR10MB4242:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB42426D853EAD1ACFB9AFD6128E089@BY5PR10MB4242.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aq7SBwGeMCEH62GFG/bnOa6cphOM2E/PWl7nOzYkJoq5UaKg+h6pwWpldDWeKgcv9emYpnBuB18ZKgb1+WnWFhYok19JY3wnEzba+Br/qW+0U5Qy7+f/EAlAetj+Fslx8IV3ekomBLpgrDDvDAeQR/qkmu9UFvU8X3lBwUkn0vxgYAYxazwnYU16hNzNqRsY3VkV8L7ap631e2y6/zveaJcwRNeHpu/qpqGHQJinsyU2p2YVtLLdHDvd+JmuvEVvq/91VUgnQYVA7CjUaTR1s06d0l0DSLeEIpClIMs6zYIZgTyeiIlTMr0KoeWiPE6YsFu8o1Zmuit7JAU1EZgEzsunfoIFPdKozKmt3GdYpLwwAhCtjeXmDmAbNfDulDVRGgSA5JHMw+N/GXwJhydpwZN7LIY7IryeqeKpVNh0vN2B3OkwT6azZ7K5Xrzox8cqeni3Kwzvwi9afH2L381VRN0cLFxiyvZGKzSuzV7dX4wNaZhcL45u4mo2Pz7j9cWyeJGbhdaVOZgQVKpWjhFiwZFsjoiD1hHE7/bn548WasAvtpTk5zaT4oXEj1tQ/63fdPGaTUhC6xMvK6XLl4V0sjriRMNtoC97j9Z7tB03Hp5xz/uov5UmMSIea1GbGYIAYSv2+0ujDIy3M8V5jes8I15SbolZCiZys6isLPp/QOk5KUjmrmBe8JC0Y4adXyy43cp4R1Cb2OA4VBB1Urh5Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(6506007)(38350700002)(33716001)(38100700002)(2906002)(33656002)(7416002)(5660300002)(66556008)(316002)(54906003)(26005)(66946007)(6512007)(9686003)(8936002)(44832011)(4744005)(6486002)(86362001)(186003)(1076003)(6666004)(4326008)(110136005)(8676002)(66476007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MYWYEBQk+pW0XvT00gOhv/SNQmflMEc3NOXn4b31cNzfyYUvjBIQFYcwq6In?=
 =?us-ascii?Q?9LyMtlLHUVXn67TRRLuuQAPRL3dkudF7dEazBQ67V+q9MeCIxq8YsGrhiB5R?=
 =?us-ascii?Q?pdZt4haaxROCMVeJl0+jaYYxrIeDYTKWPkh5oUNNg/kefJ2L2bo5Zuijh6qS?=
 =?us-ascii?Q?OU3yhhguwDWU6F9RKXhWSFUaJEoqYVx74tkwzH/3YSFrb9DdSZmIigOlhugm?=
 =?us-ascii?Q?xOI5Nm6arbA3cvkpZYuD7RrVYxCwu755xLcz+tz90m7BL9pit0SxyZH6LTyb?=
 =?us-ascii?Q?9R8fW0VQdn/1mn0OP/nRvH28MPBfz5CWzHybN5VwJMnSrK4GV7y8g6u49zkx?=
 =?us-ascii?Q?o9GtRaCUvmCE3jSKSRfpoauqvM8G89vJ7J4sGE58lljz+o9y5tIOmZuEZxCS?=
 =?us-ascii?Q?mFxg4mycS8+dcAipXUgH7rtM3ir81mpKTOsMOCB5UdJSK+pw/yO71OHSACZP?=
 =?us-ascii?Q?PhcjC0M2Aqqh/PimdryDHW+BbbZOabgfGyVBPQ6kqBEwvEm3+RtRZ6j+Jrrn?=
 =?us-ascii?Q?qvqmliC8vt1cs/ABzwJXNU6H1Rd5JV5btjkKScpxPbEZVJ1T8GpEZq0V2RlO?=
 =?us-ascii?Q?FiwQ1XwiRCcTvMNojt59U7dGUzC1jBvuY/XIWBq8p3dUcvhvhY3pmcQGTHgR?=
 =?us-ascii?Q?72R7r0HLwb1M0eimofDKPcKtXd1DPPr0pFW1Gtp6SVsYWf6nb8o23LXUlwwr?=
 =?us-ascii?Q?VFUZqCDHFc33KTGo2P/+qMlrr5ZJQERFGnejVvGatr5GzhzLvZSJ6eHqnywo?=
 =?us-ascii?Q?SqMfW2vmH3G2wP2Ay+WM35qwhqW+7ARLnKNiUrirYTncbNpQf0Ca2krgoLFG?=
 =?us-ascii?Q?4KVnfwKWmHhQrNh6TRhzKclyZI5rKUQ1h12oOMGd8alwIUkCHzMfFEt2LqWu?=
 =?us-ascii?Q?LTpnZIOqjjiOTU37kG5x/qK3QSkAWP4NIJsQ6flNGaQHA2O1z9xGVTCM491V?=
 =?us-ascii?Q?yUzY59MXA4338P/Vgd4RzRDYU7JLDmZu6Bcm9ZTbOJ3OK06rggntc+pbqYK4?=
 =?us-ascii?Q?n1wVVL4PNLkA3xeYVdBanOkEkhL/xWTcuJVGHR1akwL/8shsWn8FBxKAvbSv?=
 =?us-ascii?Q?UUd9qHryJdoaJMdNh26hir894CnV/2yCX6dysd6HgF+XP1de1VijtbKcq7cb?=
 =?us-ascii?Q?uFoUa0EEO6ZYu35VXIp+gfIFw3LBUK0rii64HSquohqkGEybdX27imxLDn2h?=
 =?us-ascii?Q?8rhYePsFeGYXk2VZ4Dxz/4ZI/U9YKJSymgcZx9Rj9g5GMKCe04Gtj21ppSWx?=
 =?us-ascii?Q?IwV6KJeFby5nALMbCTlQ6XnRsnI10xH/MqHWIfb8rT3ktERgZvSfPoL+9GUa?=
 =?us-ascii?Q?KDnER0qKFIAdHoahWogJO1q3VZrDGb54DPpEx2Gx21qYMruCfQLk+SMqSgjT?=
 =?us-ascii?Q?8xzuwAP5xOwPf8ail31jPxBOycsKvox64TYm6brahGFBFe3Oc6pJ3J7Oxlu1?=
 =?us-ascii?Q?dmc9Oqt2FzouQFJEsj/yM2haSLBNv1JVO6v/e8LfDwkwzK1V9HEalRyDF4M6?=
 =?us-ascii?Q?TRgCQo+yCahF8EeCJLxbTabPllZXvdcdeWDkH7rirkiiUOVb4t+S97yWmWBB?=
 =?us-ascii?Q?wBFsDJHQhC4TXofxcDfTCnIbDOVEzQ3scbYko01gEAldqsMItf+Z9+DqpkhC?=
 =?us-ascii?Q?43CzdMK9qsxsdyKX2cdwrCFBRICdQmA+1seYSel9+2CEBLeYiS0ecr/jWaPC?=
 =?us-ascii?Q?FU4CPA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd93859c-ed0e-48e4-8261-08da0044bcee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:14:05.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZR96/MusRyT6qy/Vb3ESdourlXpdH+SIweAxfKlMyAELXEps0Rm+cVIUYx9bGe9TB+7Vz47i7ago3uM/WPxdZU19ZLeWpN1OpRhHffziME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10278 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070083
X-Proofpoint-ORIG-GUID: i8XGtRWUlJmBU1tSDXhG4Mz7OoIZQRCe
X-Proofpoint-GUID: i8XGtRWUlJmBU1tSDXhG4Mz7OoIZQRCe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If devm_pinctrl_get() fails then it leads to an error pointer
dereference.  Add a check to prevent that.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 769874820f9b..3028c02cb840 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -196,6 +196,8 @@ static int mt7986_wmac_gpio_setup(struct mt7915_dev *dev)
 
 	type = mt7986_wmac_check_adie_type(dev);
 	pinctrl = devm_pinctrl_get(dev->mt76.dev);
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
 
 	switch (type) {
 	case ADIE_SB:
-- 
2.20.1

