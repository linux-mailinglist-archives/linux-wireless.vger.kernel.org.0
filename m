Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4E1359ED
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgAINSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:18:46 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:3398 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730913AbgAINSp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:18:45 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009DBs80028957
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:18:45 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xarvjwv1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAAZoN9ERW+yAA3jg+fMMuTrokIdhY/jXIe1bia5shks+uHsDiE+Cn8I8qhQXETZcLQbOc/kR5x6Ol7i2Ac1R7TSxYWPvUalwuQ/jzQLWhaJzmnR1jtvs862qlheiMJEBW4M5Pc+9HlDRYVpi78UMFuDDCIoLI6F4jIDgVZtyH02eCTS23N2kvnZgRJtH56DChZzgFeyPiGoaejESs5LpcXML4Hql+CpeEqfUOWjiGUmeAW2WRw+0f7Cti9/0ZdxAiuK8Rzx5VlU2+Gqj0P0Azic8Ah5tLou3mCGN7ReUdNf8hcHZIDUVKdIqL2ZYJLSNHuH3AcRrSFwfL09hmlhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iywlqjWLXB71LATX4YgJMaaUaAOFUyhGzxh7B29Xlj8=;
 b=VM2+Rw/1Dw97R94c4ghVClCBp18QievzobtUyUjxVV9Guan/HIfG0pAaAefYdoBs7r5ZF2KtketESm+GLyAyxvrG8M7evt+NDtkQfM00Uy3/XoOMig15jrNjMw1GQVqJoHV33DpaY2QliysX4VmhkWpdgVN0gyALaoFdS0jvkpf7sy208XfHSNyYZlq1izgTt8GWxTIfSsGHfivRLUnaEjrXbEprtYJb0lcgFPhUY9T7ZfMVWGuGUFAXooOo9c3nFZlmO4INzdkySSUJzxJyCMSNLSG7rxEgKCfxyHbtX7LGQztn758uo5TO1yTdP8xarLuPZ+VLA0/EjhOxKP7t6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iywlqjWLXB71LATX4YgJMaaUaAOFUyhGzxh7B29Xlj8=;
 b=Fx+RShbN6X2Bn8cnm6YG2nXcbu2YrAi8lnRR3LGlvXvc/5qOkyEmf2OOwLQkMIbjv2fToWQznETe6G1yC+b0cprAygyL4U3zXU9Wwj+Hh0hTjoxzIBeMTlGJzIvL29qHO6RwA8iDaPbClAbUReYbVK2XHXGGevG/NbKVM8qMVTE=
Received: from BYAPR05MB5528.namprd05.prod.outlook.com (20.177.126.225) by
 BYAPR05MB5317.namprd05.prod.outlook.com (20.177.186.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Thu, 9 Jan 2020 13:18:43 +0000
Received: from BYAPR05MB5528.namprd05.prod.outlook.com
 ([fe80::cca9:480b:10e8:cd9e]) by BYAPR05MB5528.namprd05.prod.outlook.com
 ([fe80::cca9:480b:10e8:cd9e%7]) with mapi id 15.20.2644.006; Thu, 9 Jan 2020
 13:18:43 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:05 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:05 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/5] qtnfmac: minor features and fixes
Date:   Thu,  9 Jan 2020 16:17:50 +0300
Message-ID: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:04 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7965ebf6-7773-4bc4-ba99-08d795065c9e
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|BYAPR05MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB4637E3322884CA4455E390DAA3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:18:41 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(478600001)(52116002)(186003)(103116003)(7696005)(26005)(5660300002)(8936002)(2906002)(66946007)(316002)(66556008)(16526019)(86362001)(54906003)(66476007)(4326008)(6666004)(1076003)(6486002)(8676002)(81156014)(956004)(6916009)(107886003)(2616005)(81166006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5317;H:BYAPR05MB5528.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9E9vRWKdw7wuDxcFRWxe4Jyfgg7fxuHCzRODI1RWLqwXPMmlyLiGZfYyValYiKsTM3F6+Pza6nJi6Wrk2KnsyUioAQjGO+Y5KCYrtgtO27XHCNmeXKZ6iMiiRjWXWOV7kSrqVJrJUcu0Ls4NTY/qSovMb0dR0xCWGO2fuh1TWAIFzs6mrbgkacjHHJTn8svn0XittuYJwNRs7+PLF/pJG4hPTd7aFQQysR//GwsK7sA3dutq0ZbL+zsBqEMKWRl9t2z7hMB3/i9WOq0ov0JyqWb6F/UOTr5r7Cie6s29ARgwliCfG8Pst/pvyNJhXh4lozJPn62ckZvg+JxDqVnBAVkBpD8M0a/JlDhVwD/jpcU8k/BxJUfVQKU4hrUlrCb9q0W4MWgj8AbCkL21oUV03XDAAKv7i9zcPO/OqdtpZbPxX7aw4vk8zNBNJlyW23J
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7965ebf6-7773-4bc4-ba99-08d795065c9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nFf37Szldl0+sjRC+aDjsxj1SyZGzRQmVE2bJJ2eHRSdLnxLQBYJQnqzNUZ5VEFy97/73QibKzWZ65vXPtggWCa47JJX+skMVxTa70zxEp1+TsU9bTV70Voo6XRZ9w+36lKE3TICYTbSuI5dAJrDY9PHPVB1G1bjvgBPAaZtBwbjFFfVf9E51ahzZLA9c0OonpLlk0GaI7b207rtUi02/fhF0J+xtJQ1ofxm4EgGx4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:18:43.0531
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=462 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle and all,

Here is the patch set with some fixes and minor enhancements for
qtnfmac driver. The changes include the following major items:

- enable more 11ax features: TWT responder, spatial reuse, STA HE rates
- sanity check before bridging qtnfmac wireless interfaces
- enable support for DFS offload to firmware

Regards,
Sergey

Mikhail Karpenko (1):
  qtnfmac: add support for TWT responder and spatial reuse

Sergey Matyukevich (4):
  qtnfmac: cleanup slave_radar access function
  qtnfmac: add module param to configure DFS offload
  qtnfmac: control qtnfmac wireless interfaces bridging
  qtnfmac: add support for STA HE rates

 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  9 ++-
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 13 ++++-
 drivers/net/wireless/quantenna/qtnfmac/commands.h |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 71 +++++++++++++++--------
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  3 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 52 ++++++++++++++++-
 6 files changed, 118 insertions(+), 32 deletions(-)

-- 
2.11.0

