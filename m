Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5152A0B3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbiEQLtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 07:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiEQLtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 07:49:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0F286E2;
        Tue, 17 May 2022 04:49:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAjYbS011964;
        Tue, 17 May 2022 11:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ajhJqC4ZRXyCscuDr1EBQlvnDYWh7BR6qFDNPVN06Z0=;
 b=dmbHxnChSLW3GQzoXOYFuIZiWrffjLMaxXgsIRk2BF4HLHsSJIghxwcDCB8ckdyiMafm
 uZVrw298Rf61AJtGIX8P+FiFAYSJ3823eU600w86F7NtNaGEpnhFt18fWJ7ruhgd/dWW
 1LC/969ovl3Fq2bwjZO71lhnHRcH4QNe/7eSzV5NiGXuyAL9cQ4HzoBHR4anBE8/PQIq
 DngGRrTQt8mONOPSIleUP524TcBzA7oWDOPRydf0usrRXSar61CZEUb4jjjrhz3H3i/k
 HWoLFdx44hSrnIzky16Ni2TPV1I0HFWYQ3LwIfJHEJbv6Suj+45oGVt/vN6mkiTOcsFW hA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s5xx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:48:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HBj0vb004728;
        Tue, 17 May 2022 11:48:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v313j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icxo+n/rjP1+GLawwje4PyCjSObUgakP8M+tI2lml8JF3Y4Yz52KAf49ukqoAo5GbYkI53MJjt7u3iLxRZeVnEwV0drzk14I9lgby4xIuztvaziW7fCE+zXsw7rbQoIHx49tOmkHxWY41igPOs13u1rOuiYsFkpu1kOa6rwx8rsHnUfsspNgXn7QY0CJzpyyAR3iJZBNOWO3JTkuU7ywdDoGnNMQLYRhMpsOTKOEucbgco725fflLlGCP2aIDdJ5OemIbT5MFK8aw45vyYZta3gXOGOHDOgwnVMHdF6HnAbGirPRpG0ZyoBXLL8zb+SEXG30/wfcxRn2NcAUVQ2mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajhJqC4ZRXyCscuDr1EBQlvnDYWh7BR6qFDNPVN06Z0=;
 b=YjcjyFfzr5SIXnXYmQBXhg4iY/SEq1QLbb4bvOYXWjSdtwF2IKE3kAab+ERV6Qu35Dm5uGVBL5fCxAe8JmVdKlCPupLktWvKkmLrzpxz9bHKkqkLx8Fjlk6Yig9y0akc65IQ1RwBYQhUwiL9LG+tSAeV5oYpeXPGn/9UhRWG5mj7Ap7OEV1Tfg9n/qFoii3r/UkP9rVgVVULhN4xbPqteGJCiqaYOmlCO4ebOt49w6mawG/Cv5q2riI/wvMo+JTy4fKIhAGDpC4SwAHnHba4uSNgZp3DfeJYriExPsZiGld1uW2erlqNAOtSYEx4DikCfYtUlTOYnFxIR2i8LcGYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajhJqC4ZRXyCscuDr1EBQlvnDYWh7BR6qFDNPVN06Z0=;
 b=x0bwJMZHPu89fO6zvAXTb1Wup2/stiEFo9KHaaTDLseIudIsUryuu1cgJcyczx3m8gDV99JwIXtYUXmsNZc3nUueAGJ3QkAJBlsYaTCXAGNFgaPx9G9dw5TfZxs5rztD/8H6EHdUDAfEyzDm2Dc+lE3J3qk0R5TEUL0m0rGoImU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1770.namprd10.prod.outlook.com
 (2603:10b6:4:c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 11:48:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:48:56 +0000
Date:   Tue, 17 May 2022 14:48:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()
Message-ID: <YoOLnDkHgVltyXK7@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e19ad5f3-a3b5-4e7a-1ebe-08da37fb38e7
X-MS-TrafficTypeDiagnostic: DM5PR10MB1770:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17703324D75779B041A1B5638ECE9@DM5PR10MB1770.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+dnuyhbW9k4yf19hVI2Z8zy0rsIwsYYdZRCN5O2hJqLzQBwPC8qwLej2j4AQHn8SgUx8wrpM10/eRoEU3ukJyfEWu0/S+DlqIPwRcQ9JSEAXgRnVDbvnR7DWZgR+yxTOK1ewBsXlnV+j3ga2z1hOrUKGJA3mKjnayC5w4FW0dORrmWo4nYbFfZ+bkiqasIW/9lNJKilIH9mcyKAk/YYYdbhPxFicseJRXLn1hVFaxt80fNMK+wjnHreWqCr4MrdBt3IkUg/72YkRFhTUuf3sQMhx26uIcxY7QMiwhpqn7C9Mbyh1XBIjzIyauQsmA+0jPLZ6Tc2FbfraB0+d5xLPz+apqd61o31ENzKTbwa06trdkbqlXE4LGGCIB/rySCaU3qXfKyuR7XWOA4JqMWgujFFcf6g9cA19l74b0QZXF31Jc9qEYqVbrql7dA9fSByFzRcXMSdg/fQM2+lApU0WS7yzHWymFLjP8LOHRQ4MgPlo1GtyDT46gzrO9c60dwkyTkFhhdjpJlut8lo0KPu8WPxtH1XfvMK0F6ywDhdiXPtVL7qw2/wXmBPFaEFvWJL8d+bEO97DPZstN1OXAStfguuyAcvA/ks1oUV9Uy+jFnA98+LDVX0091dn6P8HOrtvLj3pq79CQAv3ZE427F/wVsGjZBbhS+T+/drJTJwHahlK1fuvCBQ5srIQXGefTyBHlS/nSvdn33aXQ/IfWzi1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(6916009)(54906003)(66946007)(38350700002)(38100700002)(186003)(4326008)(66476007)(44832011)(66556008)(52116002)(9686003)(6666004)(6512007)(6506007)(8936002)(6486002)(5660300002)(508600001)(86362001)(83380400001)(33716001)(2906002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uc5a2IyMqZGZBI02AbaOr7TNGf/nEMc6Z/lcfOO03Kbe125f6lXXa/7eV0EL?=
 =?us-ascii?Q?RPqa5iu1sjmdutWiW1vAosiU9bl6Ud66W/fTVOSvQY2NayI8hLe6P8lsPose?=
 =?us-ascii?Q?65cHDWEcW6s0aYAMT05Wv+irCAcCGIsu2yhftByjqu/JIlbFz5PBITJK6kQk?=
 =?us-ascii?Q?mj697h1EWoJHgMcjbW0UqxK0g8GK2JnEGAFPzG3m2SuF0X7UJ5cUWWGzDyfJ?=
 =?us-ascii?Q?c/TF8zpyuXqemjlGbqejfSAR1SZMlZdU2JeVjZHMGeTordjwfRlU5CyRn103?=
 =?us-ascii?Q?28BxeWL6twVLX8ZIcUWT1OJUv9bODRsxKB2b8Pb0d6fi78TaMpa4yyWJkR+F?=
 =?us-ascii?Q?0+Bm/T6tmueiRuDeODeIqNL8JA/HHKL+yYdXedxLu2+Iku7MbELR0RjKKx/V?=
 =?us-ascii?Q?ffWiHPnTiKySwilq8AvORBOCAA3Q2QFxtt17YJDsgpZsHX6NgLiqMXFOf6TW?=
 =?us-ascii?Q?tn9XQZ7D3pJyORYG+4yaG8DN5BeGE35WTAdmGayQnLKpAH0Zti7MYJW69LNS?=
 =?us-ascii?Q?8CgvJm1KirGIroIRBlhriB6I5akOSL1xxXbq+G4OwEYptAqmZ60iH2omo6/X?=
 =?us-ascii?Q?5ytEAVXv5jWcZQZxDxrsO50BjxbhGm5+tQ0AmvLsswM4EcirMwYzuH5hmHu/?=
 =?us-ascii?Q?mShMA8XcWYR4q8YaQ7mi9WReDNxCgtcuqB5i8eqpab2ZNVz3WnWDtLvhLhPF?=
 =?us-ascii?Q?zMciYwk8vrY8H4YfER0smkqRybhg6GtSDIxMyGfQNxogtl0kFtlX89PgpJOY?=
 =?us-ascii?Q?fjPSd4dX8WbWTR92nX6a3iQ2q/SXiUntfX/udWzfhTGAcPI1k92+EjckecGq?=
 =?us-ascii?Q?fUKt9foev5iO8I+mOFKELGLt6RZ5upSyjV3j4cixnPa2WsTK/Z1/ihgRJsmL?=
 =?us-ascii?Q?oMGZEyV6vAgvGvuCh9YfxXfsaGPEc8DyWx00COfCh4OYt54V2v6sstMlfGOk?=
 =?us-ascii?Q?CII2r2EPE0HOoKKuzUSrkE2e9tqq0lUw9lsXZxKYSA+uw5zqDL5+VhwiqLRx?=
 =?us-ascii?Q?lzolJGI9EVePkNNbC7NDwPOUxYbNmUfPz4HLLzCB9HeeX97U7nErNLiLKJvI?=
 =?us-ascii?Q?8FpuXpzTlth6XHjv3Qmf/a/efJnevcbJF/jL50yFYDFVLE/uFKSS+uVyBy1/?=
 =?us-ascii?Q?0bnJUVi48zdgFKrJ7WQLloiu4CSKtKvd754RU1AuK7PfNjcDbZauW775CNev?=
 =?us-ascii?Q?ZEuEpB5GpRdFzURMVTvXVetq+Um9AuZFwzvIwoVFkOjDhHhZaRR6olGRaayv?=
 =?us-ascii?Q?jcRc/OG35UFWwI9sEm+jvZt4op8D7MZufAWR0DLQLnzi+d6/C2kLrGEGldgC?=
 =?us-ascii?Q?ngJx7iFnYqwIIw8Yq1bv4lBnIkllAbL5YhaUQbOozVgzM/Keeufh9Q19aajt?=
 =?us-ascii?Q?fhX/lgM0ewUis5dTWeO++ATLaV8H73sNv7nP3cj3oJvqPlcDIUvOVGSRMY+t?=
 =?us-ascii?Q?P23UdnRpr5w2tjsWzmswBiKDzX4npe1QGZALvK+gca3/aCP3beUstIsZqHcu?=
 =?us-ascii?Q?5DOne3nsCljwyDCIqnd3lRqiuP4KtKXsQzk9Dbcvou55Jvbh2aUY5C6HCMiF?=
 =?us-ascii?Q?aX0LYwIk84PjmHSeLEMZarvf1T603K9s1brPeQAtzpRvk8lJoZTsOHof9Q8O?=
 =?us-ascii?Q?OxqGaDQ8TSyaYeeLufujYAASu5Y8AYYqG5jkqpoF8ftkhgnr8NsgXXMr8Xe+?=
 =?us-ascii?Q?mx79oSdfzySTotJwe5Tf6UzFgK/ug4XEDl48mHTv+yra5JJtlAMT8dBmrqQb?=
 =?us-ascii?Q?ic1vRTzIq3IBgphOv469hQQrLC4qRKk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19ad5f3-a3b5-4e7a-1ebe-08da37fb38e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:48:56.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDWT+A9dVU9tplvTumRcS4PaEWiHSE2E1KP9Em0Sjkcj1X6Bebj+Z0fEH2pTAl5KI6xiBujxb0WC3/4N1VhslRdJGR85dNEhc0S2K3HnRhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1770
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_02:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170071
X-Proofpoint-GUID: nYcH0ockRbbS3oKCiygCkGd2eZg90-SH
X-Proofpoint-ORIG-GUID: nYcH0ockRbbS3oKCiygCkGd2eZg90-SH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the copy_from_user() fails or the user gives invalid date then the
correct thing to do is to return a negative error code.  (Currently it
returns success).

I made a copy additional related cleanups:
1) There is no need to check "buffer" for NULL.  That's handled by
copy_from_user().
2) The "h2c_len" variable cannot be negative because it is unsigned
and because sscanf() does not return negative error codes.

Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 901cdfe3723c..0b1bc04cb6ad 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -329,8 +329,8 @@ static ssize_t rtl_debugfs_set_write_h2c(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -340,8 +340,8 @@ static ssize_t rtl_debugfs_set_write_h2c(struct file *filp,
 			 &h2c_data[4], &h2c_data[5],
 			 &h2c_data[6], &h2c_data[7]);
 
-	if (h2c_len <= 0)
-		return count;
+	if (h2c_len == 0)
+		return -EINVAL;
 
 	for (i = 0; i < h2c_len; i++)
 		h2c_data_packed[i] = (u8)h2c_data[i];
-- 
2.35.1

