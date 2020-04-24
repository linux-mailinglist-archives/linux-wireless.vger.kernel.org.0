Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED31B731C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgDXLam (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:30:42 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:40830 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgDXLal (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:30:41 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBQo8s032588;
        Fri, 24 Apr 2020 05:30:37 -0600
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fxuf1t5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:37 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC7r+kIQ+lL23nhOnUsF+IHCGYd6pCQINofAGQgXxMBXiZK34NwuAX/WQ8t/Au/YJEXHJmB1MaMfvEdkOljQt/mYVI+tqIUwruRAWpqKmgZQi04bRtjuKFAubIZUFzKmEbp+a85SXhXWkea6JOHS5NvGgnuREmaUtYe6M50giI9atUjrDPIMSrgj4IiMTHU3y4/DTgcKKx/MOB4itnjhPOakwh0MoCeirYxMlpZwm9MxB8Re1HSRc3/ixsNpVebmmc1EgISZkCRV4Zf9/ZbmBF39C9/lsIZB5emn846Uwu1plu2aceR1EngMPncWCoDZSME6MiGkPMRmu0bWdTNR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8OcPkuw2awlnfwW8cIsiZ3qeqIoBbCceKRjdys56rE=;
 b=KmkXAJtxGBtnjJCxu9fECSTfw8soaGJb2Pr4nyHL6DJpplhk9wrbBWUq/cLhSPtJn41UPJWDPz4Bx6+RJkL10+2Dx/JPYfhR7le0MFGhnKWPNJ3kVUSQstA6jLRgcPcj/Z+KxxMc6ULMF2Rb/YcJ43RuxURPtOrFuO3WXEofaGWesANETYFg/ZYci8mCnzTiJn6R2HtOCeE03wfNEvtAjjGLO0HSXOt2+rdDGZ7oGwt4hZyI+khxbf1KpJGAELPYnXJyHYe6HKS5FxWe+s4rgWsmiiIb5Qk3NtDSg1zFp7Rsj/9UsZ5vQMxysGwZWw+gY6jMPsrIpbjbhmIbEipwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8OcPkuw2awlnfwW8cIsiZ3qeqIoBbCceKRjdys56rE=;
 b=bZ8JeThvMMEBXA2SQPFTYtT+nmkXMWLXMPfbreH4dNgkwm/eAaZi0+8vXhmTuCJiW5DttwlsVMRpS/dneGy35E+z8bmzEz9bAKhv+0YpDT0u7OXqorGM3vOL/t/mtlrb1XoDQQ9pzbHeRs8ozjRtBCJxdLsfB+yGbE9zYwT+msc=
Received: from SN6PR05MB5695.namprd05.prod.outlook.com (2603:10b6:805:101::30)
 by SN6PR05MB4525.namprd05.prod.outlook.com (2603:10b6:805:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.12; Fri, 24 Apr
 2020 11:30:36 +0000
Received: from SN6PR05MB5695.namprd05.prod.outlook.com
 ([fe80::1053:d922:d99e:c3f8]) by SN6PR05MB5695.namprd05.prod.outlook.com
 ([fe80::1053:d922:d99e:c3f8%7]) with mapi id 15.20.2958.010; Fri, 24 Apr 2020
 11:30:35 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:15 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:15 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 1/5] cfg80211: fix mask type in cfg80211_tid_cfg structure
Date:   Fri, 24 Apr 2020 14:29:01 +0300
Message-ID: <20200424112905.26770-2-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:14 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f8e8f1-91d8-40bd-2b2b-08d7e842b84b
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|SN6PR05MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB316012C1191A39CF68116322A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:27 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR05MB5695.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(366004)(136003)(396003)(103116003)(1076003)(8676002)(52116002)(8936002)(4744005)(478600001)(2906002)(107886003)(26005)(81156014)(5660300002)(6916009)(7696005)(316002)(66946007)(54906003)(66476007)(186003)(66556008)(16526019)(6486002)(2616005)(6666004)(956004)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh/+RBV+teNd+kGJCiHkn63L/WRiDTgIPvmiiqROlrhvbSl+RW9jRyfb/4o1hhv5MJXadclM17/FWAq5+E2xNbxlAzvWwoNGGGOG6/FI4KsoJShe83BD+3zWBQKsqhVahpNed0TTsbkvtAKdr6K99jn4Qms5Bw3+HbdCbXe8UqG0OwmsXvjFEKp3WM2G9RBCZ0g8qukarVWdZjqwkXNU/gj8xFjGKNEs/C/4r+5t4EjAagIYdmntAZPtbW6qzz8WMDe4MT0XYtdmcC9JZ0HTu4LotF514yEKzOvkTY1zM/dOBCVLg8AvbMgNaXs2CR8W9YmXWCAUcwlkoFK9O9bTGoMirKvIwlFMuG6thn066ikZ/7wUDHwOU3BPu6cnjshdmhsDZHBNMh/3s+1jwgV8445xMEQPeA1nRpLC9U7A6ARvOMHD79r9k3b1TGyWmfxf
X-MS-Exchange-AntiSpam-MessageData: PymyQrObkh5/v1ZckQPt5K2qWsPl1jx4CYNsqYdxs5zn9Ha7GK+1yh6Et0NJI37rWgbwM+ZTo+Iahzo0Og++pL4Qa91AZE8FoK+mmt6bkZ7B3H9N/a++CZdbDR/SpkQxFQ9FvY4W8Ov6wV3Gu53Fmw==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f8e8f1-91d8-40bd-2b2b-08d7e842b84b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AuO+++cI5dsgEV8rLLgFXfZJtLP9PbQPn2dyQSHXpZDfJpUbkjbCknnRuTJeVlmQehHTwb34jdvOx9HNL3kmAHcI/eGx4DlkU2iJftN8iCLtSU2aYaVTC2Li8IBQq3fukFOg+PUnyyaLacW2rNv3pS0YB6Jbx1H70RLTCUyAcndUMyk/H10ebf9v367aGBtMTwt+WyU0iD45g/Sx+swHNCAqOsWc/K+aZYIimTkOBc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:35.8426
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4525
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240091
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
index a82fc59a1d82..a2b2d31530a9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -646,7 +646,7 @@ struct cfg80211_chan_def {
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

