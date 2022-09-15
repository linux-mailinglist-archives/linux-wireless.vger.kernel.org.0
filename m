Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8FF5B9CB0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIOOOG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOOOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 10:14:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC219C2E8;
        Thu, 15 Sep 2022 07:13:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FDtqrB003530;
        Thu, 15 Sep 2022 14:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=vJPNjqRBs2DOAQ6SYq7pb5Atotwhf01lynICAXvPMWI=;
 b=2+HGaYqgLBLDBa26u9XUSKIntnoXOh77UtfizM3qzxZi4pkuToXOcBXq+M/QbQjdxzwa
 bagGmX+u5DV4Z1MLdPwDOD3t9/EUOsE5oWixr1dhPnKGI6IIudLdeoxzGelq3JEMavc4
 K1/E8kYwyVDbsOETeC9HAbV4QT9B3o8AtZvumNXfSM+GypkIIqNMipYHK0pykIdYrcef
 VIQDZLGeClkYLHaacmSsAi+F/eIMmfUeH+/N0bXLybP+5xwQQsfZ/ejL7KRG4ivoQw8F
 QFXY4mS+rU5w9QiXAeJVyYzrfrOug9HiFCQLm3XsO2Mz3JNIWWXr8IfTglx5FdwIrI5G tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycdbgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 14:13:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FE9FIv004852;
        Thu, 15 Sep 2022 14:13:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyeeawv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 14:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaV2Pw+MCfxycBEheowax8fhh1kofqblVefONqdq9tuFP7+yIMxaDGsT6bqgRkdlGIgIIvTFc+qoBTnfERLwYM0+EHeMIFEjlAAXlEALHoIkQttSqId60yyFIoUv/qnpvkoGQKp2FPeSfHCN21DcRNF+DV+TeDX7jAWhdCq8W3f9RePpL7juoySgKKjgnYaZt56FE0+aLNDlDwcW+ncbupXyhYNUeUSTMwukx4LXzdbHrjscMJbGZ7NBnHWOfwSNEJ6dywc8ib21pQ6j1Ddd20HldWmpYpMEn4vjl3QyY984PIej5RcUW2Ce9eePVup2DH2R/m2nM0b+ZBERApbvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJPNjqRBs2DOAQ6SYq7pb5Atotwhf01lynICAXvPMWI=;
 b=QaIwNpNeQgjqDy2Bps+geBPwuzrj3LDPjB41p09c4P3uINkb60/33NiRzDdLmvBdyNHi3+6nU3fe22dAMKCawhDsSRtK6fVIY1GbHAR89Ejrcg7jeQHk0svEkjiB1jVlu7lEpASEYcrLVbPf4Knue2zXDe1lpeM4ZSLBLMjq3AzXWgRM240DL3uqZDhStiZSeV51Y+bktreUG9IlioQz+oXGoqqcnbWMUStOY3xbxbw+hv36mmlqFPb/4EziyDpLYQw1KzCD+biOqestpWGq7eeCf7i5eA0LSOPUUxmg37A8o10cxAroxG7nEb827oB/ph5oTUUVqoUiKZqpE4LtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJPNjqRBs2DOAQ6SYq7pb5Atotwhf01lynICAXvPMWI=;
 b=qJ2mr9PVP+MLdd0AnCkKC/iw6hzYlih4hD6gwaaWCSUcvcfHOKEth/lIJn/RDdO4cMVNbpQL+/IjyXAc9NCg+VoCUSDQdGr285HlQstSbtdkZOjN9sryVDG2Q9PyKn4p3EIIYzYBgeNyaTloirKEChVtn6nhhowER1j8u1QZxSg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 15 Sep
 2022 14:13:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 14:13:41 +0000
Date:   Thu, 15 Sep 2022 17:13:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtw89: uninitialized variable on error in
 rtw89_early_fw_feature_recognize()
Message-ID: <YyMzDtX/3fUBnonC@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR2P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e608d-ddb8-4196-43ac-08da97247e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2BTf4xZNiqy84G+f57S0KI0rnt4FgGJwBVOUYTsxPTBEIDCa7ZnXgFi0h4uSOJhaG+iJ1ncIXilHm7yCf34p60xbbFctJS+yWRVo0JHknaa+FVFWjCxzMaIu8Pf/ZKirq32m16I6MJifVoR0I7mYP/vGmLs9vJhGI7P5STa+0gugshrhi8tZo4BB3s0OQAFVhjRPuSTlfjw3SyiUC4GftgmSK8logqLJ+0gZY4Kvw5FCP+V3IPrV2GAa/0LrHy/Z1EqaViMrDFCoLpY5iskLvZIY37u6sI2cojZPgLxw5sCZIfTbqR60ISHFSt7/5/mTaVnkKkosJ6+Xt+8FiumlCgVgthDtFtV/8iRQOYEJ80a38+tLCVdP6TL2xDn5OIQICXXOeGHT2xN2+1qFnTcYZfKJBIZBZ3xhcWAfdhqdKSf+WL71Qm3U7upypGmgexHqP9K3/31J67o6wcUx4TgVkBxFyS7iaClxNy37Q56tizXH2F/VPPVo5wIm7ppXtiRiUD6uwm+nvRClRZZmdAlrioIr53TA15xa/Ae/gdUfg00nFMKWisho8zwRCLb2uvwdV5cPivnOOr2jLEmcbPf6Y9UqMYi8AUHxke7eZYcHgW3GLMsT0n3AcFS8Vr+mtahqXBwEy+edmWk2g0NyET7G48npYtTs3zHK+Pv+RducJXdi8eUkaJgda8r+nmqSlzzZMWoQncOGMsqLveF2pVIqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(66946007)(316002)(8676002)(2906002)(6666004)(33716001)(9686003)(186003)(83380400001)(478600001)(26005)(38100700002)(6506007)(66556008)(86362001)(54906003)(41300700001)(110136005)(6512007)(44832011)(66476007)(6486002)(5660300002)(4326008)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LaQ0lWSgqBqq5C4jTe+FPK/xatIr5YbjOMPW7c+6P7KnidRIkuRmVj2z8CAO?=
 =?us-ascii?Q?C9jhISEzsYoTb6iF5amuKuh1mqh+cB1j7qxD8fHrbU0hx1dTphGv8W2ObxZ5?=
 =?us-ascii?Q?pd1itU8fJNegiVxLWzCXY8Rtrqv3Z6HqYSdt7Dtb7AxjOFYCg2Zc18MlZZDe?=
 =?us-ascii?Q?x4dO+2H1s39H035+aHkhYBS2Q9E9oQteywLXVngllJMlovI4E44pMyBXWYJ/?=
 =?us-ascii?Q?hvuC9jSY2KdWymKed5a5jsmiugLknHlF/Yyb9+5A9+QLjpGrJohR2rg87olT?=
 =?us-ascii?Q?CJBpHgPUklzMLRREa2l7pDkGkkuSWvnxvV15ZQ0mGuUYrow4+McP407U8NV3?=
 =?us-ascii?Q?vYIzfE4CiCZHa5loPX1hKTEVJxGRkH8yrh1mfUV2J0zUDuuYi5DwJEtyDFww?=
 =?us-ascii?Q?PHT5uW7eyWxTngF2EFAvFToTE728Fi0sBRvMnJl7axfIane2NABBck1ls+zh?=
 =?us-ascii?Q?+iMUN+S1vPELrPh+Z/H4zrkOdc8uEWA8QgQOBAddJtCxbp0qEDD4fYg++c4i?=
 =?us-ascii?Q?Og7oHLfUw4KPUJXq/gpvwrxCHF4tsnyCVZii2LBOcJ4qp0Yw/qwVgr3UUuLJ?=
 =?us-ascii?Q?3wX3UHhZS1fRJOAgOikyJVer2JBk4OZQd0Rd08KJnEIWgIe4/f2hhdux9GZP?=
 =?us-ascii?Q?16Oqez1WwkRJQ9uhLk1oaDQTNe8c1BxOfz1noyJZ/YhwL/znGWz73jNbZoV3?=
 =?us-ascii?Q?pEkudh/DiIdK078vwEpRGUYVxxDK94HkzSsSJHLW47/EV4dwnx+Zc4ibH4I3?=
 =?us-ascii?Q?dLHfrDlF3DLQuEfOcFGWnsd9XGf5H6J3H7YbWkGsFk3v36UCM4u6R9oEQ1Sf?=
 =?us-ascii?Q?fQEiwOSMi3KpRooeA/YyuX70M3j1Kunzafr25/Ua68B051qaqA1cIq5d8iVO?=
 =?us-ascii?Q?Enm0L6jDoxKgiUx9tuwv1OSoABoHyNJ/5gSgrtxpCnK1Y5vtix2Mvnw+ITne?=
 =?us-ascii?Q?ccwI1492sseiL1B4u+AnFimNJvTIsc7+BMSvXsMIlcqELEm9FzoKyMFldjxp?=
 =?us-ascii?Q?ThwLFoUjz89LXswp4UcMCaEtzG0QDRuexnRBqA+8ia4vMqN8zsCAOsRcgg9C?=
 =?us-ascii?Q?d3oT0Pj/Hv08g8jdhOuXdn9tFyKfUNDC/ivWFTFaVOYDtE2Lik8ur0F+GYes?=
 =?us-ascii?Q?QUTKLQqfRrnp+DsZtHfnUMvn56/E3TZEuOr7x9hK2029qggBZAXK8WGc9jV0?=
 =?us-ascii?Q?Iyf//CH4eLvDxKUh1cj8/F1iIfp5iLIgYX4aimGAxtGVWRN+WItNrI5ENWmq?=
 =?us-ascii?Q?mi+/DTFdQe0nVkQYmNDSeqk7qWxqXGmaX2qyXKWRxAsnn44T7krVPFfvNQDA?=
 =?us-ascii?Q?tTshaFU0OiEpJAHiuhDoLQENEfP0WSEAEp+tUbLHJYKoDpSWsZyVMSEuk9vH?=
 =?us-ascii?Q?rLlBilBE3BRlZeibO3+Zg2vR5uX0rK1FTofy2GYXEeXeQXXYUbAAASNSCPwE?=
 =?us-ascii?Q?AJZ9SXj1yTNEz0t1L3Ukpf2P3M2jCyBGM0FzlW1Ivu1xSBMeA/oWaoF93O3f?=
 =?us-ascii?Q?NNJL0zd+d1UkyIFYGObB24IYTdoTAqYWf3WK9wpV/d2Nc3FQbhSDiCZlEj/y?=
 =?us-ascii?Q?RZvQsLwNt8Y7LtCTFsXhDHRqB6y9IoyBSosRpogwafTKr+/hpVlsw2/7kfZO?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e608d-ddb8-4196-43ac-08da97247e0f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 14:13:41.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmVAJsH3elCsytUjjXuxFT+eupi8H3XyOL6zYaDckshvBs4UB5nkEJ1C0l1sq0w6ZdJjsQ8d6QRaGnsr/BC3O+FXkf5VXAuSXd6rd26ebJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150083
X-Proofpoint-ORIG-GUID: JZlRwbvNM532IAs9Hx2EZriFMenvifmN
X-Proofpoint-GUID: JZlRwbvNM532IAs9Hx2EZriFMenvifmN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If request_partial_firmware_into_buf() fails then "firmware" is not
initialized and the release_firmware(firmware) will crash.

Fixes: deebea35d699 ("wifi: rtw89: early recognize FW feature to decide if chanctx")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8e4d0e18fa71..2be70b907762 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -268,7 +268,7 @@ void rtw89_early_fw_feature_recognize(struct device *device,
 						device, &buf, sizeof(buf), 0);
 	if (ret) {
 		dev_err(device, "failed to early request firmware: %d\n", ret);
-		goto out;
+		return;
 	}
 
 	ver_code = buf.mfw_hdr.sig != RTW89_MFW_SIG ?
-- 
2.35.1

