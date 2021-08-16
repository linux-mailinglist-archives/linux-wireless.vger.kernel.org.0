Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE593EDD3B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhHPSkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 14:40:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62398 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231258AbhHPSkh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 14:40:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GIaGkD014493;
        Mon, 16 Aug 2021 18:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4JA8Ee0lKQL0YoH+BQfwB5xbH/BC0hvDXma+LF064ys=;
 b=nUI8tY0WaVcEiwbMxc5KWkJtB31LaQcZeNSJ/Su26lnR8vdoAL7/jtn2BVMk7MMZmJ4l
 qAJ0YdS4TpBf/xs7so3O45csYdZhJa9hpNOtf9Ppkpq/Uqt5DkUTZOe5ry3vCi0Hjv4p
 zTdLeg0TrP/xp0Vde/7dQgbkBEXInRo+I4Ci1Y+3d9WXokmz0GSizk+g3hnvHR42ryCi
 EeWeyH3oHVWmmpaFjofbEz3e3vNKwPkxFheUcYh6ItFKlXF+Ic8k5Pe094CHIqItjIzi
 423vAeqVyEgCnmtI7wDJeTuF1aiqbkdhuw2u202tuU7aKYbfngpcHtCkpUDpcICS2Tp+ KA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=4JA8Ee0lKQL0YoH+BQfwB5xbH/BC0hvDXma+LF064ys=;
 b=KccR8ewM+uHrT6SFrO1nzNLRRvRd8CzuI6ydf0ha6XhwtwVMxJwjjmUqatysPgvsCEkK
 +0UHGPBqcGk9YAYgu7iBl2Pcv32r//kAhArNJMLR/Bh7v0OG0sLiupIRu3igZAYbMDfy
 HfyTj66Was+CMI67K7yFOMGEIAXx3Ss2jj5Qyzulhsdi2hN78CnXeYFFoj6aln9N5UL0
 k0zIldOvaqmlF/kWq1bmlSYnqCm0ciosCoN9KxQdXZc4NCe4fzWaPsmsirGCN62DGyAv
 c0tSboTa8M/R+T63fLZePXrXexpJJhK9oPcq1z4WVXCjHtmrMpbynP8pQueoUXkrGUYt fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af1q9aywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:40:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GIYuR2048071;
        Mon, 16 Aug 2021 18:40:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ae2xxpt8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npvIPnA9Cc8X67EKb0bZkQ5WZrq+t/IsA7ilJlfOCi7iZ30Eq2O7fWV1Sv+q8g17TxsLb5aMyo2md2vTh0ruvOTI6WhM20vCnn8ul6oKVhF3O60QKYlNdsj987zZEWcPfG8aFkMdzi3uyKQwMtqne/H7Rh+Wn972Qbww9WYbxqOv/L9oQbyHyMUBaKuWIpZsB8epKmQwCdBCnTpi8S1INvbBrlReeRoMuYAd41UAwtMfLQGoivch0snSNeZAjvIj392SHIVxaXCrY1PphGz+Wqm+/xInSJrAA4hww+mOJZMib0AYhxbtiNTvN3zuGdNqVob3fot4cOEOsFHP0KBUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JA8Ee0lKQL0YoH+BQfwB5xbH/BC0hvDXma+LF064ys=;
 b=SSMrD+zbnc/Qt1rmbZYiNrqp9I10RDVVrn04s1vIthF2jY9Roow+GauFSxoYVFc7ES2qIE2AeznQTxLOScLm1mK0wk1Xrb/5oTpWGDzje9M+cpIjcHn6GQ0g6xTDJTUtpYxTLLXJ67mXcHHwL8HIBITBPWYxTUTlX1dqzdBw2fvFWfwLm8A/wDSN90J5iy9HsWBk0rmbAgOKOI4RwvA/k5muin8VjgM3XR7f2XF5p9ZqJCNvpAY6nq2xnxw4YDvnQrI43zpnmh6O45Ohan7ssTljCRK6n6nm4dWURI0qNAAn6aJBJ9h1cNnDxcQYQf0d/FSXL/BELoIUMAEcrhOjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JA8Ee0lKQL0YoH+BQfwB5xbH/BC0hvDXma+LF064ys=;
 b=FXxm251Hc7Py5HZdfdtYErxbN5tKPCPQXg9tc7C6f9q8hbBkQquYI4KwcI2u2eHEgkD9S2r9AKRGstpqjtP/vjkcNZWkxBrJvBr3CisFpqTbsZ4RliGCZkYTK6tDRxFPwl7rX+n/TaK36FLFnga79h9oWuqhNE/MC+SpWXabua8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2160.namprd10.prod.outlook.com
 (2603:10b6:301:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 18:39:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:39:59 +0000
Date:   Mon, 16 Aug 2021 21:39:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rsi: fix an error code in rsi_probe()
Message-ID: <20210816183947.GA2119@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 18:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6e5a99-530f-4b5b-701b-08d960e54008
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2160C4C91782159EC10848BD8EFD9@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ehoa1eqHuFUP2THX41iaBJUVO2Ad/BvmONlKb3COJfo3lfQ6t0vk39OoghHva9G7Qz4jA44vLsYqQQEQB1fJd2mL+LTWmv12b5nex2b0Fouc4A8s6pxauC0Z7WgziWx3HXCpYIfxg6jAkQO3Vr9ffKmgAj02DAdynhp8cppU7cC+kHPlpthjXOHFT4NyDlR95Bc+ZsBpaglhVcY6Y7bvw6syHgrxAmp7Xru2iH6PvIlIp14lgR2yfyVhWPLj67UwewL6cf8BE3Ss5Tey+2Io4u+NL2h63ALMXjb905XEANya7nz1rONObJRnxUKlDbtN/4KIQWzm2cqOOd89kUvufruTCzhiDGNL9PmSHfJ1oWdh9jSxJ6fF1fbWmxM5TWPudcYXCdwWxThhRE9ghQfDady2k8gifSqwH8gEhNedk3R2AF2jHeBeHxyJrIgqZsBoyo4CJZVBDC9iMZlk+svLZi2wZgdzNC4Fq5kxGKACFDQ6xyEnT+1jO72Ee25K2v3yEBtq48N+UIVTL6+l4QJPL+Zyy38J2Eb3r+u3ijt50HQionTPbuc4arVHixmVq1IkwrLc5Tr1ULs/JGMI0Hj6yeMoof7SpMDD0Zdg50S1yfBjjFzlx5INrpA39l+C2AcFu3wj72xor8NCgwaN+E7Y4JRAxbO8NbJnAsYSp8pjFNZ1pMVn87LIG38lx7o/KGuE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(55016002)(4744005)(1076003)(33716001)(66946007)(52116002)(110136005)(44832011)(6496006)(478600001)(316002)(6666004)(5660300002)(66556008)(66476007)(9686003)(956004)(8936002)(4326008)(86362001)(38350700002)(26005)(186003)(9576002)(38100700002)(33656002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNzYjPIk3c6EUzRXvSJfwOuIyCFcwQzHgDaKMfEY3TXHqhM5rFX02NJVzAU+?=
 =?us-ascii?Q?sFjBSULWkVYy7vedcsW5ok7bviLtfBHW7oBOjQB2x3NhteMvtQfeKVd+q+F7?=
 =?us-ascii?Q?2GRemQxJWwoqyCDbgjMrLFepF/5IV1JFlCFJRxQeTJy96Sbrsg7WzjsTXGdd?=
 =?us-ascii?Q?z7bJDJnHaFBFQ87ls7xvT3zUeQ+9t29orgCMN282r5ssTI7mDAy0EL9Yt9fG?=
 =?us-ascii?Q?OHlN315JBAYUASchH6vuk2+4az6Wx/VY5cYjX0KV3HUh8vFYRmSWYatHxAiu?=
 =?us-ascii?Q?NcTZRSCnkixZW0V9A2xPT74zuM9gEGtZCRiIQwLdLedJ8r8+asBimbKi8Mzg?=
 =?us-ascii?Q?GMbXnlufPHFk+MEQRtWqaeynQvm7v/fH4P1jJvuPuROvZuZ2pSDEN5/Wq7uB?=
 =?us-ascii?Q?cNXgGFjzvcmGTUSh86sCWn9pOsQP/GZsVeSgdKM8sgvAy4WOTok7Q4joJi3f?=
 =?us-ascii?Q?quMKakWVOg1hVS/KtUf9hv4WRR7yD4sZRAXH4AAA1fm4wQwm6GUrtKUWYonS?=
 =?us-ascii?Q?PJaXpPFiAIvG7d5Jk5rYokrzTrKZ1dF5IvvZhmTYyatGc0OOEKQupbkY7Q9B?=
 =?us-ascii?Q?wF/3lZIWLnythA/ChB9Yu0xzpgGB2FyVSs79v7rmSf+ysE4zDQqoKNjyHmJl?=
 =?us-ascii?Q?e5eVO7M+2V5kXw6Zjh78HXz3a1G3Tr31A3vDgIbJHHdcvZEsQeqNth97qZQY?=
 =?us-ascii?Q?Qc/TzZk3tfycd0/B8Ho35VjDbJpSrHRXQ9Uv2Xa9jntdbZnA3OuLCsIq4lQY?=
 =?us-ascii?Q?aS12T3kE28OaiIBFKei2Jj2jw2/jgJWA/z+YZ2oRU+E0w0dIK8duKXJqQrM5?=
 =?us-ascii?Q?NAv5Srfy1xnmepv5rlf8p0hRL8QfjtKW4kmXfHPG7ErcxG/NtUC7vP6bsW/b?=
 =?us-ascii?Q?9n1Fej47y71l5vKCMDmQMUQ5QpcyIq7IJEA4PN64W3opf1r5cgED8XSSfgo8?=
 =?us-ascii?Q?Dy8GLyAbdy4wHZE/U4XucuAYgWyacpSdgn7vCqG/uE5Saygz4EhtNDR9a1Bs?=
 =?us-ascii?Q?YGV9Z5VcO00BrY23AYd8r3Y4n+X3s41A2FtlkZ9NMAP2dv6LnGlu9eT6J/2y?=
 =?us-ascii?Q?/kpUB9Dwxir4enCcbozrCXUg6pKclTtNtxJQQ8GFlRz5PO5AnuETUnhfF2RU?=
 =?us-ascii?Q?QJ5SvpAVI9p8jAB8caV89z16enOKOAnnvpXi4W7h/dwf10KPAOgmyXsqG9jk?=
 =?us-ascii?Q?cNlLbONO4fo5SlgKY+HcGiVPYTR+bFDjsssW7dkdXiK/0UzaHKqIqz5L10x6?=
 =?us-ascii?Q?eEWuUa74Nk55I4joWBDXWpzRNuPBogVbBQ6yjHqoaZu9a7VSU2PTZxlTcBfO?=
 =?us-ascii?Q?Dv0sj8QwM7g3G+e38w1FKsUR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6e5a99-530f-4b5b-701b-08d960e54008
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 18:39:58.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAhQOpEgqMsuD6NS6obPJh7w132nEh++PgvSIR+lWoLr10R5C4zz31N5glC57AIwmHg1LkAu7gBmHALRvsh7necr3H9SDIhiZpWacDhxaEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160117
X-Proofpoint-GUID: -76N3euhPURrKGwQKuNMFQTou2Ll2bZ6
X-Proofpoint-ORIG-GUID: -76N3euhPURrKGwQKuNMFQTou2Ll2bZ6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return -ENODEV instead of success for unsupported devices.

Fixes: 54fdb318c111 ("rsi: add new device model for 9116")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 3fbe2a3c1455..416976f09888 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -816,6 +816,7 @@ static int rsi_probe(struct usb_interface *pfunction,
 	} else {
 		rsi_dbg(ERR_ZONE, "%s: Unsupported RSI device id 0x%x\n",
 			__func__, id->idProduct);
+		status = -ENODEV;
 		goto err1;
 	}
 
-- 
2.20.1

