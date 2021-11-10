Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9411344BC96
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 09:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhKJILF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 03:11:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57650 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhKJILE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 03:11:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA82uLF017928;
        Wed, 10 Nov 2021 08:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YyIdiVM4eBe9YGHCotIhkswbvil0ruqfWFcV7pXPnJ0=;
 b=ToHKQJgFteQOaaZPOr2Kvw5OPt22/5mSocSW8ygdfm2Q9HrFXT89PuR7KigoLSqMpOJD
 mFKgGod36uLrJppExDu77hmbjdr0+yqrn2ngiy7rIMnn9xkxKoK12hO07s+hKmMPxa9O
 388A9q4cf7+ePXnAhHn3Lpi001hupQxpyuUO9RfK3R7lJ6dyf+oTPP22PwlsFbjHHIhF
 i9swAbLTcKab//qecCh6XkyKLdPJmEiHVy1bWkag3rPCV1FIC2X0/OSz1/sax5Cqkq2a
 ON9RT5f4NOHDDWnNMbFMNCqg0Of9uPcryJDvqT/7IQE16eg9wQcaQ7SbroBSi7vLE1Eh pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c7yq7b5d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:08:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA80Klp024216;
        Wed, 10 Nov 2021 08:08:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3c5hh4x77g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgc77ff0gmmlEPCwGkgQ+Oz2QD4kUzk3CrsF3ZXHsad0FLniKn1QArWzd9FZy9xqOgjaXlVLIuB6YNMhApvnX34cgMcwDuuHvDynZNs+h3CDhVnz5guezhUBUbFauUnNAil7q1CFXhPp/zk/1ynn0fniGS3L8nNzVGRq9qXJtXSaQ7R5lcepp1LTW6l3738qRemjqFDfCwdDNiM9YVFfVrl/DcWOjgyu8Aw+++yyv/jL52zLVnbBcwqHSshkaJyUJqbTfbb3vsTKoLe7QCroaWxzKxVGETRASspRpmATJGF0q54JxOIely+vlMlCCMMwXNr24KPeI2AoSzV+AMa7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyIdiVM4eBe9YGHCotIhkswbvil0ruqfWFcV7pXPnJ0=;
 b=bEIFst+fTZppneG6n4oLhaS+Ur8OQbse/PDq5KzzD1jBYe+hxaV0JRF3OIb8E1GJGa4nER4WsvWcywbBY5CdpVSek27uYJN2IvmeH81YBRjvtdutgPdOwKwtFhPzJHWdUpEwAZAXiIsxZeMZYze7PLEMar5Kc8fhw7FGd9awKAsfb0yEuw8R/6VPV/MOaQ014Hz59tj7dXdp86TXNh9QL2ERQd6cWlE9IOrmkwi7XXugDN5tEMMPKY+3rCivkyGKM0Jn/feYwGo1EjqTaa8zHvt899ygYaahP5zQi6BbmMksxc3rMoCuEgh61im+r61YYpE9B3xBqsxQnoigvSGijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyIdiVM4eBe9YGHCotIhkswbvil0ruqfWFcV7pXPnJ0=;
 b=HmYxNvw/FiyGI35eFqQkcnlSnr6B64bZORPk2DrjHtowBB5r/I3wOXpufFafc1HC9sqbzUnFjbix7Bi2oNJEFw4jwGpj2r3XnS7QyPwf6k901MakPaInCMpXg+4FYYnLR+ZkNDI/HoRgf1wFSpRpFwzjhM6QQm8Dc1sj3lmTfLc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 08:08:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 08:08:11 +0000
Date:   Wed, 10 Nov 2021 11:07:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: fix a stray tab
Message-ID: <20211110080759.GE5176@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 08:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a659251-8943-46a2-a854-08d9a4213d1c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1950FECF0DDE0F8BFE2FC2F58E939@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhKRrOe46Sfub/dRjUxrbctFRlWsPtrYdCzYeR3jb4LVeX/yD74Nz4cvZBgTqTnynCKMAoUbFkgRwHF4Lh3v+0WzHQ9sqU4GKEtSv6YLVeW1a8RYcpxq4alWI3bos+KsC/L5ufceo8RXTqaugIKS6jYFSrzwcsaFrWP0pInoyzDsXOKnLG7zbr/aAoXjxKV76gFfhRSQdaOjuw5ABV6au6daSMWoJN0EK+tLV+8tmG2SUSN8eTzWa4GNisP2FBntKBtRvrYKyu3lLcks6srWvaHPHkLVztCVgRl/3QU1orfFm6tdElN3DqkMr3c6yGPVXXoPdaaWjL6msap/DU95al+2uem5h4y36DpOFVVHHAqORFS6i6uo6yE7YAwZEto25L8+mVqiL3RiSuKAEiBAIOXHqa/jWGJkGL8yJVTB2oYn1VP7OhHm/0CBfh5QK1U88h9D7PqndiUfSEBoSPxDBFs8b5njlOYSf9FnrEcOg8krKB6cKZk6sODfJaguF84+YL35o3ZMvnDPWdOzdBTCotcL/iMDAFDUj+7ZLfsbCzK6R+Tp8WB+oFMzHCKTZd5pdM8GSGM1vJENK4FdCpE95HD9VuM42EBNVPzQgmaSWQ8p7Kx9YAcQGcGt6++k6rVJSrIE7ppCVw91suMcIgi3reAxqdwcsz4DSl9QENdrcQmdYQsRKtUO55kQe5wYRwb6gDVINHNTfaAQJqkbsZ2ZPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(186003)(38100700002)(4744005)(8676002)(6666004)(2906002)(33656002)(66556008)(1076003)(6916009)(86362001)(4326008)(66946007)(5660300002)(66476007)(33716001)(54906003)(9576002)(508600001)(956004)(55016002)(26005)(83380400001)(52116002)(6496006)(9686003)(8936002)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HbBDkWg2AJviybQRObKDiHb/1jlBWevt30QK/4l0+cqIzyTH4KvQOqZf6wPi?=
 =?us-ascii?Q?RYxyAEUSNVssZmUZ4s/bqDZ6qx0UxQ+Oy7cHKQjjU25JIA4fbL/pnfY0bwYS?=
 =?us-ascii?Q?SwU4msRdQNFT2afxO1mv4Xoh+PE6yXMiSCcB8PAzh7umrj/1jTBDXAbUy+cd?=
 =?us-ascii?Q?ybDZSwGu8t+502Jyo9EjYFfbQ/8Vcy85Ipiza8N9zlFloaEVyuJCUTa13eB+?=
 =?us-ascii?Q?wFf7v2yPZURYLL96ZN07kKDDPUnJoWGaOZ8UiSk3mEw/h0HgwUM5j3gPdOqH?=
 =?us-ascii?Q?hPLQ1CMvapXf+I0t5ak7ypBIokN5tD2xbEGozXPt+9iJzFy7MjEgeX8Z3tnS?=
 =?us-ascii?Q?sZ8wruOBh//zrI6FbAqheVOSlH1RccTdzv3FciHW43YMykz2+G+hYwmMSole?=
 =?us-ascii?Q?G6aVBPQTKgzEYcLogCDtnQ3uYSf9EB/UHTfrauP6dxXMcMykhXwfedbrmykQ?=
 =?us-ascii?Q?f8vdL8nqi2ofAk4dGbk7OJluMdZ/h7St5Jsbunk0+UXxJwVeLK3E5ZfDvx21?=
 =?us-ascii?Q?S48KVGgCJtFHg7I+JLezEaJSNeMVdMQXvuLddY6cfricANKcpmrkcb+tRRbm?=
 =?us-ascii?Q?gNF+cRJJIiGKiEusw8rr7NOhxZZv/ousPSCpxvIGi3uBt/ydm1FRASR5JPim?=
 =?us-ascii?Q?xNGnTLCn91Qt1eDGm+Yh9tIoR5cAGoWf1vbwp7k6l/XeJtLI8gKz+7SBlcHm?=
 =?us-ascii?Q?0XoXInFL41MJNPbDvCqZcFz7XLn4YYdOMa4vtnnv3AMQ+HQyfrt4fFGWMo1D?=
 =?us-ascii?Q?8awflkD4qA2EBf4RWvU6uCZAZKwff+W5G5xwRBGEU3a6bsBDx4pLS04UIlOt?=
 =?us-ascii?Q?WyZ3NRDoUHUNw4OamO7wm+MHa2KDYsQCKmfyn0A+zO0KqDL2rt6a8Pyy5YJC?=
 =?us-ascii?Q?hRcLFKVy0oLVYBoxPxAqXs29n8yled8oWWnL9THRM/AfPa6MKBQm7t2UR2tf?=
 =?us-ascii?Q?AP9BaFOxMcHw8B+XDBTCNFCd9sKGO2/lR5wtTc6CdfRF007MEprn3l0onUGT?=
 =?us-ascii?Q?rAzw5B85zmjW4CNa3Qrm2APJrcp0B/+/+LC5R+jtE+d/eNJBsRGIyWdjyWPh?=
 =?us-ascii?Q?EeYFDu3RCXUG5w/s6SDuWRoT0fhC+oAzUYsWvO117v6HxYK5xhOfIacRsAT9?=
 =?us-ascii?Q?nbwdMCHLbYl6xA8xKA7Uq0N25sRWyYqrH7wNste427JM3LzTyQL2jdVCm2ul?=
 =?us-ascii?Q?LIwtZbnMeBvECBYqkvzTUN5Yfcpa3QSdtZ/z1PqIom7cdElNf89/mWa7CvoE?=
 =?us-ascii?Q?3Kgr5xC6/bJfJOUxDG/LahQ89yYt39cTukUPhxnuu6qTjv2KLlka+kQ9hlMh?=
 =?us-ascii?Q?rVMn6yRzJ+O4gAyHNczNuPf/a3nNA1Wrpt2UUVTHVIf9cxID3x182ukNn5mW?=
 =?us-ascii?Q?m56l4nAaEgaN3QODBU23T8wjKsf9TuFcEfUAX/IY5spalEi48txo4Y3qP6Vl?=
 =?us-ascii?Q?3izbH8jiOFH/IdqO/uBIwxVr2PmM/nNP75kaczt/X5pd38GnqjlDvS+mPh2J?=
 =?us-ascii?Q?4Xt5cTEdVco/xZbTHajEc/RpRSBjVK1D30OtKZOeK/8jxPBZ3x6nfIRmv92X?=
 =?us-ascii?Q?VqFqXtuEAyUgdK+oYIYBpRP1me89j7tX5nkYdzcaz5//LAsPOjjeUk+tePcP?=
 =?us-ascii?Q?sV/+g8uQcSt0IQfEwYGJOWSB5Gos01kKc07OtreS+Ao9Gr0ag8tvznUc++R/?=
 =?us-ascii?Q?QlQ2v3dIAfcTCV5EM88BDO4UKfo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a659251-8943-46a2-a854-08d9a4213d1c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 08:08:11.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XNdfDmtlThiK855lJmQu18w+scA9zChi7PMJfuxEBYB7CnSg7ynWcMKsyGtiiuH0jMcVw0o0gm0Q7qRuYnA4LzNqHyX+LMu987sX5YlZGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100043
X-Proofpoint-GUID: 7fbhYseFv86uA-XrKDBrRxHwmopwOfO0
X-Proofpoint-ORIG-GUID: 7fbhYseFv86uA-XrKDBrRxHwmopwOfO0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This line was indented too far and was a bit confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e0601f802628..11bdfb76f4cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1961,8 +1961,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	} else if (format == RATE_MCS_VHT_MSK) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 			RATE_MCS_STBC_POS;
-			rx_status->nss =
-			((rate_n_flags & RATE_MCS_NSS_MSK) >>
+		rx_status->nss = ((rate_n_flags & RATE_MCS_NSS_MSK) >>
 			RATE_MCS_NSS_POS) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
-- 
2.20.1

