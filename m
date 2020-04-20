Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435A61B0782
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDTLhR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:37:17 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:58630 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:17 -0400
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBXxBk000927;
        Mon, 20 Apr 2020 05:35:32 -0600
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-00183b01.pphosted.com with ESMTP id 30fvsbm25h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:35:32 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXy+V5ux+Z4GfCJqWgt1bEnwDpOuWaUwXtq4sAaPuDqo408pDQEyd+GXaVF4VlyoyYjfw1JXk3RvVbZzwJY/FFLSpykGt3bHMd5i/JYOvpHRC3t+4JatE1vH5Zl4avtzo4A8xOUjBHlwZJcFltWCIv6UWnyVzFdeHj+YI93S+R9XWdRHdiVHVBK0WltzVSOJwwh7T8MkAn7umsXSNijEkjGLhSjIW5DZ3/0MWEpS7c9PFBEFSwQYHR1np1io+gfHfo7SaGTpUj+cw4wBwMJvONKusE+vLnJn6w3xfPC7lyYOdJ6rt3RUH7TmEniqXpx8wXPYHfHEHCqovijTjCEfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMrsFds6VopZIM3Eys96yadPSA7OjGtgyPSR5Tp1taQ=;
 b=c6AIIy0TX15huMp9wK2XWexVgG4ZqkybI5OlY2zW1hxN+pHNHZc2TBB62itkHaRUAbiEsvf3kGLZ5FuhvZ0CX3+Qm6MxWeCeyQkLhACR6kKPFslgivtmZXYWMBKFkMYFf96kxPw51tX1ZuX4KthD6n3IhwlgKZWNysEfgzCDbeM+8TP71DSraH8pcizXoIdH0+7bha5NzZRnZFR8njdeRQYOeIe9ntsTkLzGKCVqw07oW9lFQNJjPOeKXaUFHYmqbDtLwao3ay26Ydhi8WkRNn+HxLrCAVAr3Jr6nnpcR9881gnsuitZqDKe3vt9pB+nVPXpI0rBBOJjuhqQxRyVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMrsFds6VopZIM3Eys96yadPSA7OjGtgyPSR5Tp1taQ=;
 b=L1OFFqecmsJScGyWXqY1KpVlbzJqKhQGRst83tF7MikmkwKF5wyZ9xcLB2W0/AEip8zusnh9Bo1w1aE9U4+vHzu4SQvc3yAzuukz8Tgsk9gMc0ak3O5zzCyykomtOfdrHpx5EnwcEELWQVzM3yp+TU0KZ8uWP+/ZvX9sWGqBhDY=
Received: from CY4PR05MB3414.namprd05.prod.outlook.com (2603:10b6:910:5a::21)
 by CY4PR05MB2997.namprd05.prod.outlook.com (2603:10b6:903:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Mon, 20 Apr
 2020 11:35:30 +0000
Received: from CY4PR05MB3414.namprd05.prod.outlook.com
 ([fe80::4867:cde0:bd3f:3331]) by CY4PR05MB3414.namprd05.prod.outlook.com
 ([fe80::4867:cde0:bd3f:3331%4]) with mapi id 15.20.2921.024; Mon, 20 Apr 2020
 11:35:30 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB2982.namprd05.prod.outlook.com (2603:10b6:903:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:34:49 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:34:49 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 1/4] cfg80211: fix mask type in cfg80211_tid_cfg structure
Date:   Mon, 20 Apr 2020 14:34:34 +0300
Message-ID: <20200420113437.16998-2-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0101CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:34:47 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e78bda-9ba7-4b54-6582-08d7e51ed572
X-MS-TrafficTypeDiagnostic: CY4PR05MB2982:|CY4PR05MB2997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB29825DF3EA31E588101B38A0A3D40@CY4PR05MB2982.namprd05.prod.outlook.com>
X-Moderation-Data: 4/20/2020 11:35:24 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR05MB3414.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39840400004)(4744005)(36756003)(5660300002)(103116003)(66946007)(66556008)(66476007)(186003)(6666004)(16526019)(2616005)(956004)(107886003)(4326008)(86362001)(6486002)(26005)(2906002)(52116002)(7696005)(6916009)(81156014)(8676002)(478600001)(1076003)(54906003)(8936002)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WO2GgDkEfCCNCbvhOvfYX10Nifek1Bp6rcWnmSyP5fTHraK3nVRl5F7eeVICuNoXc0opzqEV2PTjiXH2qb6GOtNH38WAcRgPuJJoROPSveRZDa7ovHd4RhJ3xr7bNHIHL4RSowpxzq6EXkqP6lrNX5JDpKBq1GDaUXHzyfd6qWQHfW5oCYkb/rxx5ICz+bZ1vZFsvpgo3AYCJbkxXl/wxJn9KmlShrrcjKlqPrbXK4NtFEvm4ghEqUxnF1ssHMDL1a5l4MSElCO+PDRT8Yo9gY3AOmyYe15egihQA/i0KVbpZ6rvMVKgyfxlL/nIzKtylHi0bX587+VvJ7wBSgtSFjDlmiKRj6yxT+TzU4ZWL7aQTH+jN/UgIlseNggjKmukYDyWpTxLLA42EP+R1Nxk4e1TxHfM+bNwc+kdjLmTrKVLQ3OzVSlKP8JFn00GRnzC
X-MS-Exchange-AntiSpam-MessageData: yFSRsmzH4AnoDK0lJFgwKDCTQkrDwDiJ1mgLP4nERsZb79TIDxZhJT48TD8g4Si9c8vk6Ht5fJJR123/KYHJNOHvrZLWkO28nbeANZjbdbAwmc7s9vJb7vvdAn6CABunqYZuW2mu7/HcGdqr6N8UJAl1RzBqyg1MuLpoHvwfybp4v+935KQZjtgXnYTOCMdW5TjLV93ynG3eorNkEasOksFc3T83MEHcx8FOsww+biC3nSBU2ig8c+Lyc7jmivocH3OOn8umIWgkC2KA/AOZf6RFYvWXOZj/J7Yg8a8xYGI9Zo8wSw+DR7MX/L2dMJ0wAskSw7oipGSY4U7vgo+Nq0/LMKSnQyTHMR9binVEVMilal91RLSilf8Y38Taih3t05h/XiBe1m5rp6zOSn9avkM0lo7qeIZnYOUjxyTLj0hgTkFrkytxP1HfY9TSw1o7dOlKcRS38zyfhktkmBHuMN3Zs2LZbuXZcZQmeO+4/TSiSN/xj21LLhmImruZ+8g4bQkOEQr0D57Ng5EQu6/iyrMc9TVjUHxHChHvUiaB9zIZHAb7qFFhpmqv/naKatadcXEAGTJWWYWyopZ7zT2a9IzdPu3WHmEZ/Gjk1V2pf7cVgFaR029wF2G9Gcsnrr7ZAM3X6yGkmLLAa9U0Mhf+qeE+z7JEHstZ1RFvVQZb55VSUtiWHzWqbCpGCUfqgfRbDjUEsN4Jf1THQ+WVu3GZEpuWfjr+XPSA7YXXTLhxPDPSaLH35OBzMZe1ro5o6zFgZ214VvTfYBTpE8B+ezrwFwsOJVmyOAIsFKmyCM0Amdk=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e78bda-9ba7-4b54-6582-08d7e51ed572
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch8OJejqOrA2o3CWchi6DDnXrseb/C0YcH5wQjtEXXU+Kt35kSvjX6L4FE8VAHO+5P3UNwLxfZXbCU/r9uTD8tu1mqAO8HSqnQiTfaFcAwvqq8ILrmX9INEGxiuM9fQETGfpnFZ+UNF3rjox387h3qfAlRm6unKeZ782pYkE5OvmTUmr24/y8xFdcQXH3Gq2p3nDw1KfnRJ9qUY0ttqRvLF9ymeRFBhYjf61jU1xoAQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:35:30.7493
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB2997
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200104
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TIDs mask type is u64 in wiphy settings and nl80211 processing, see:
- wiphy TIDs mask sizes in tid_config_support structure
- prepare driver command in parse_tid_conf

Use the same type for TIDs mask in cfg80211_tid_cfg.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f66dac8..6ff2646ed5fa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -642,7 +642,7 @@ struct cfg80211_chan_def {
 struct cfg80211_tid_cfg {
 	bool config_override;
 	u8 tids;
-	u32 mask;
+	u64 mask;
 	enum nl80211_tid_config noack;
 	u8 retry_long, retry_short;
 	enum nl80211_tid_config ampdu;
-- 
2.11.0

