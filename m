Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7013EB49B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhHMLfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 07:35:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57020 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238157AbhHMLfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 07:35:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DBVMhx000938;
        Fri, 13 Aug 2021 11:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=c0cj7t1CI7GpIgveATtc1Wcbm0/RLHqzoj+DDchp6RY=;
 b=V0DEhVt+nhOjLiDyRqyMGv9XRy3OHqwXR3Xh4FtuMmd65WQtiHguKOP3D2nYaLkLiF2S
 w6JDTzD1i2baovndWepkTnH4b27LGDpZVBqNZCu/PRkeP/H83P1TVW6t0xDhMRGe6CBI
 9KvdDl/LMfm+cnnL5XtFZhIxfJi08NY3/hgGHfBH00w8aT1RetKbU/ih3ef0Qw8G/Ywk
 R1Yic0Yliuui6x0SYbOoE7h1pN/NeVaq9zagcxj5jzeoBwDcvDJiMmtUrhJA84bvls0y
 uGa8xPUq35zxP3oF9q9Ul4RulXhXObMPziSD55BLAaUD35cdmhV//luuOmh4qWj3kz5V pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=c0cj7t1CI7GpIgveATtc1Wcbm0/RLHqzoj+DDchp6RY=;
 b=FXQfzKtXJksoGPKjJtGP4Sr382jWXpIo5559IYM6+ceNWDh7jRXRy2MzBxUYh+jT/VG6
 b+xLBeLn/xrEUTOiLM/cnwY/jucKNObs9aZarHKu/MUobLJJ7A13OMBekVNSbp4uUxER
 tPBcW/uh/xuOh/pxkFreS8V+D256DG7A/2tcltY8zcj2ZiLwai0CE2/E7YDpFkNC+3tQ
 zbzxY14+KWVKJpMdfVGHOVJOjS6xH75d5jlLCCDMq7hFmGTGeSoCzA6b2VoZd9VaaV+A
 4hnOLC03bZqKANH5ZOMRRFU03rPppYhoF0PZH3WELWjGeFOug3DjOnRmU2z8VTbx6gHo Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3adq9g829y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 11:34:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DBUfGq148673;
        Fri, 13 Aug 2021 11:34:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3abx40jjvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 11:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FILx20Yp6amyMCTAj+EdXIji+rw7Ta7fq0NLnBqHDLFcf9YZ1fBU8lV1k33CNW+KRqABQv9tFcbf7joCrB/I+yH7Zg8EIBT2oYwqriC775WKat18x1gvzJugFw1nUKdY1/itREfmMsWL0biPAo+ksgInJW+hWGFexWmL9wRYdBttjZ0LsrgyIFxsemrh8cLR3hcsH54bklnvUwAnDA/prdr+X7T4UN2cLlOxFvinHY46hx5HjnVR6iqeTNMYyJr+o9shVFLp0dyTGH0bZIFy6gvkW/H5BSvEuRIkC1A3GLMKglNlwfrBWk1q9FGKhQruJpHjHEM3TXHiPQ5aiZs+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0cj7t1CI7GpIgveATtc1Wcbm0/RLHqzoj+DDchp6RY=;
 b=ORFPLZ7Khi90I9FSvuKSX8NI8CFsMD49tiRaUObqA8bFis5kwuRrlkYU8IcMbpgF1CiB/J3EoNBjMVAF+nB9BWT4zJHVPlN6emFSiqI2XL/Qm2+vvr9+eIMrat077lLZm85zIjTzrphPydycIk2VQTyCk5aXVzZG8NUnycp4W5A8Efu7USADB22YWU8G9cGGQnfAJpzD/1kpoWjHvv7ZfEjej9b9wJwu/3umhskqMcs+Tzy1KHEIgfRZqfd34azrXpxX8AfLJXDzpwcsUZkm5b4ZX5tfAhlQ1PxC0X1qhSPhOCxn4neVVotoDJ5RZJz91WPwV6FeLWaMLXpB5AsgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0cj7t1CI7GpIgveATtc1Wcbm0/RLHqzoj+DDchp6RY=;
 b=lns5FcDJIWOgBEbHZz+XoPcdRl0r3/7Llk+7EtgIo6pM3gWBjgT+hdgkhtQyf5oSkDPe6etRq5J85aaDfbB+o3IJMZ3d2ajcwHK2mQOQbowCgZ5BX7SmISTugyTJTWH0ynuxieDhWS7icDfI3uPpTJYjytxXmsYKklc7nkdKJK8=
Authentication-Results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 11:34:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:34:52 +0000
Date:   Fri, 13 Aug 2021 14:34:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Raja Mani <rmani@qca.qualcomm.com>,
        Vasanthakumar Thiagarajan <vthiagar@qca.qualcomm.com>,
        Suraj Sumangala <surajs@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath6kl: wmi: fix an error code in ath6kl_wmi_sync_point()
Message-ID: <20210813113438.GB30697@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 11:34:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd212b9-27f6-4593-1d9f-08d95e4e5d51
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB556994D6358A70CA34F4E5BE8EFA9@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoKNtRIA1Ja8JxHNMSjRXiUI3Qz3i+/z4EkarGpMg1n/tzQlIq9V/oOxuaZzGUQRBR6H+WVWM9SDzI1DOewJJUu2u63mEQ1d2QtWCNMCRWL+S5+SneFr98f6GwODVvVvQPbdrvzUJzpwmtR6NJUMQQG41wtEnq29QKYoKfmajQiYMLMRlo+4iugiGkpiXkboHPA7GaU5aSxlzsWfx8F0AUahFbbrJW5ig7qeAqnaf/h2kBxAygaV0WrEwBzpWGxBnU5mL0ezI7CTR0Drb2xbf5ewoOTbvDsIABxAGt/4InEslk+kmkYnsGYLq8FDmI178v0v6gK1fsZJeSaNkE+eyHyNzpHry1dD04c4t+E0ml4VgVXVylKBxkTnINp8L6j4fo+CpVJz8blDFiw3wjdXoxIhenMglMSZm8i8hb5hTvWg2A2DBKED5fkPt3F9lL78zWdCsIMNfOHMymeAPXHt+eIouzKof+aetg/4I3JSVrE1j8XI/GtWBtez6cQGFMRAdPZ10POAjXl++ORUPkFSICvQkBItiEZHgsylrKq7n6g8zrbYU+7YHJsi+UtTsnacofz4xd+/m9L1hMmstWIcnzwUfZkIPlLFhgIITp4kV7by3B1t3/4Yp4p6bppqO2hrih8oEYwwwop2DSHs2M7luvoKD82riMaGrDPxaFAeKiOTb3mokmUDvBv46qDZv3LwiboFWs1IiYyWWzLZE4r4gwsah6nhs503/tWzVXqPMXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(9576002)(6916009)(55016002)(44832011)(86362001)(9686003)(5660300002)(316002)(4326008)(2906002)(33656002)(6496006)(52116002)(54906003)(38100700002)(38350700002)(6666004)(186003)(83380400001)(8676002)(33716001)(66946007)(66476007)(66556008)(956004)(26005)(8936002)(1076003)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AGoBKx9tkFNgnP7e5l5/yU4CmPDMs/i/Bqk2vRAgIn84xhGpzuAPjE6heoVI?=
 =?us-ascii?Q?d++ogmCPMsMZqN3dYy0jEGBu7dUxOc58cVYq/jYrF0td/+SpwoTWWN5SbnVn?=
 =?us-ascii?Q?DJHnCDgjijbZEAzscZzbgXBZcnSNc3Y70f4xhKTTt5O/o4mHSrHnHAhXrxN7?=
 =?us-ascii?Q?SuxXWTXYC4lNCas5PH6qHvTHR/16KgnGLXTfIpPw4VzEGYcq2Bt3XnLtUFnr?=
 =?us-ascii?Q?/pPBjgvuZ2Ku20p4liolfRT/mXN48ujZ75GSeejksIL3KcmO+vYibHCYzGKy?=
 =?us-ascii?Q?I3i3ydvet0AW+VF1w3mmjXf0V/t/Ue13l1DbtTvLBPgExnQDOkpHgaIncFvy?=
 =?us-ascii?Q?Dcf6wUXIhGBVHfH5YXrfSB0F0HfJwd49FLtDk03wyY7STZxmNpBM+jkJjku3?=
 =?us-ascii?Q?TPb13Lvg9tNfn7v8UAF1KZ8fhQw6xMooDZeykl2Gt11vdQVYA+kXn4QLnhys?=
 =?us-ascii?Q?cCyCwtMVJb6UxUiCMS1QKBmok0eQVkXBEDpbzi9KXfx/0BjNHSvMFSEtTrlR?=
 =?us-ascii?Q?4ZMMVwP+h6mL7d3hfEWuSUwyTgi03vovcK6qMYuI0nsLlA3M4sJ/s3IoKRKp?=
 =?us-ascii?Q?p4mPbJvuhqIBJCrgsuAIiySl4jwQm7xiM+3VfHaN2UjJhA1twugq4YqpAWWA?=
 =?us-ascii?Q?h3UlyUBeNE0S7M9U2tsnO/F68yBS8LFK+TGnURTKHlFKJUxv9kZTMNWvxj+g?=
 =?us-ascii?Q?K5/rRmyx6EW3Acqi2ybaoDjW3xNmQ6GbTuIt3VbRiXhJjyzveUmo4slPtCst?=
 =?us-ascii?Q?szSxy+HRTR/Fsgd5/Abopkf96kWD6jzcBxr1zJB4rKSH5N1FpMzxTNT3ky3l?=
 =?us-ascii?Q?aFecUPG4MT6X5lKI8bfgMqMT7g/GC90UXHhVCtCtFm7LGIV1DdJAdOiU/GJy?=
 =?us-ascii?Q?zK9vt/Le4lr5GfTTf++qiun7wfeLCQljpFqL9RbNLrTJeaUGyrt5kJahOivX?=
 =?us-ascii?Q?G59XrKe37Xo2/EJb3ZdcqRAeQo3FsmNY9kjfTJNn2LPInGLtaoZk50gb/OJS?=
 =?us-ascii?Q?OMkFifRCwY7xLqygV7xF53J35N9Xmu8vSMC8zRXXzw1jpUhTTn7wYYln1/xd?=
 =?us-ascii?Q?sp9IQfA8SKBmErSnsI5yY+XmI/FJPYxucRHMuSLRu8ZJRlWHWvTVdhK6Gi2e?=
 =?us-ascii?Q?0gWaRZb+nVBkx/AGABEx0HcDXlzzdQgp6wrzTxE9QaTZC4A0a9O3O4qsUBW5?=
 =?us-ascii?Q?3Vj1DKuQPlO8+/gs83oeedW/pO+2vaRzmlB0Izp6vlPPwl93yyJe5z2i+/eb?=
 =?us-ascii?Q?34QmTSNxyI8gKT4yF+xXg6VARZIXzLJISf5Kur8ka7xDSVUYaYp/8zQBLcKY?=
 =?us-ascii?Q?TNx4zaH+jLlKjZhZXvMAGhzW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd212b9-27f6-4593-1d9f-08d95e4e5d51
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 11:34:52.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2I5GOJMGXyDc6eay2/z7qEtNWbJeDl08dMHO7PzSU6YyllEk8qXldrQ6icdoqHPZjwHh/7fpzOovGsptMur512iOlJ88RmqllResalrSW4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130069
X-Proofpoint-ORIG-GUID: aM1NbUry3X8Ncjk5RypiTpd8GDzWsGb5
X-Proofpoint-GUID: aM1NbUry3X8Ncjk5RypiTpd8GDzWsGb5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This error path is unlikely because of it checked for NULL and
returned -ENOMEM earlier in the function.  But it should return
an error code here as well if we ever do hit it because of a
race condition or something.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index b137e7f34397..bd1ef6334997 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -2504,8 +2504,10 @@ static int ath6kl_wmi_sync_point(struct wmi *wmi, u8 if_idx)
 		goto free_data_skb;
 
 	for (index = 0; index < num_pri_streams; index++) {
-		if (WARN_ON(!data_sync_bufs[index].skb))
+		if (WARN_ON(!data_sync_bufs[index].skb)) {
+			ret = -ENOMEM;
 			goto free_data_skb;
+		}
 
 		ep_id = ath6kl_ac2_endpoint_id(wmi->parent_dev,
 					       data_sync_bufs[index].
-- 
2.20.1

