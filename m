Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04041DB49C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgETNIt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 09:08:49 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:50950 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgETNIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 09:08:47 -0400
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KD2bJt027306;
        Wed, 20 May 2020 07:08:46 -0600
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00183b01.pphosted.com with ESMTP id 312b16khfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 07:08:46 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhql6xEqDoMhArh8fXIdqfx/zArjXOsHsiERh7ZXYRXMNlcgvHBIQYigwj5KT8HT4h9DOH5AHyGXGrk0mznjP32EhDeRDEqb4ql0rpyzjwpQm2P+P/E3xJYZ92N/mhsCF3Zpu8EtpqcC3fUFyy/h7Tj+cSTuA6Sl8x6bpsQm5HyTbi4MrMiBFaaSQNIholb6IpsnTOG5/BSpdnKMtuI9fDOKSYcviptkYBW70r6duhi49krhoMxFcWSpWVR6opv06OIG1/JGPRaiZ/CtVHFF53fNzXxWF0e9JkbBKsYRkECdF8RCtQkjV+EeS2DuRxVN0yfJUV3jD41p6k9znCrrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDHxSxo8FRYnOb5BmkwB2gjFgj7PIe5v3itscetwAk8=;
 b=PnrC5xeBJDOZ1HQYWc2xxyhrf3QjWgXe9tas+hJ4peF+Ou1tWmq6/xpGu8qECmk0/eX1KZCX993mAYn+6YoHgyHlVSNfbyDe3WRtGFObSDXOOkqPKTfLxJcqKNgALtJgbQlR47DDv+f1x4/+BMYvhZ42V3d9u4dDCYV2CrSxxb9/UpklvB92Oxr2wWnIgdzjP7Ub8eI0h2rWVSacTIqxBCbVuJS2F4ICPNohf0Q655Y990GJmP09oKj4MI4qJJd+D4UO5xQ4ORqmBPkixW29vy06+RRdc/83/bIvciovqBON6XpIGhn4JGBu7WTKZSAub0RU4UJx9bVTljlD5XrRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDHxSxo8FRYnOb5BmkwB2gjFgj7PIe5v3itscetwAk8=;
 b=OUeJN+Z4y9haoo6QJKE7mih0NFMg3ecHs2nedk1YYuQVb9P7VzoInDZY2zzdrf/vtzLBIxc0qdQI/Mqq6H6eSSjNQFNCuDfWS5bxGrFndiyOUpXbT9X47fo1qxgcqXeRfnda87vzrUEfGEgkxs05wEoHCBJqLqk76GKc2RDQ0ug=
Received: from BY5PR05MB7043.namprd05.prod.outlook.com (2603:10b6:a03:1c8::14)
 by BY5PR05MB7122.namprd05.prod.outlook.com (2603:10b6:a03:1bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Wed, 20 May
 2020 13:08:44 +0000
Received: from BY5PR05MB7043.namprd05.prod.outlook.com
 ([fe80::7d1b:dedd:4da9:33fd]) by BY5PR05MB7043.namprd05.prod.outlook.com
 ([fe80::7d1b:dedd:4da9:33fd%6]) with mapi id 15.20.3021.019; Wed, 20 May 2020
 13:08:43 +0000
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=quantenna.com;
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3190.namprd05.prod.outlook.com (2603:10b6:903:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Wed, 20 May
 2020 13:08:10 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.3021.019; Wed, 20 May 2020
 13:08:10 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Sergey Matyukevich <geomatsi@gmail.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Subject: [PATCH] MAINTAINERS: update qtnfmac maintainers
Date:   Wed, 20 May 2020 16:08:00 +0300
Message-ID: <20200520130800.1902-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::38) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Wed, 20 May 2020 13:08:08 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334ceb08-b461-44fd-6a84-08d7fcbed85c
X-MS-TrafficTypeDiagnostic: CY4PR05MB3190:|BY5PR05MB7122:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3190C77FB25FDAB2D6215F03A3B60@CY4PR05MB3190.namprd05.prod.outlook.com>
X-Moderation-Data: 5/20/2020 1:08:41 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzn96XZLWWHV1GH4Nam2oc5pSOKTJwQ4sWsEA4P/o5ijd/1eqpq0xjbkd6axrnpcTDxVhtEvL/BnOLhzszIyB1gOVkPOek5ytHwDi7+GXnTT0pgsCf4lIxCL6dOlW2k8dA++yKGz6qu44UX80F6d50olINdb+uzi5H/OH8HPqxXg7Eb4GdlOdZHS1dHLDHIQ1bRzojq6lsKKXCL//EdoMkD/sxYf8B80jjiKtJTbYMUNibUroGr3n7lQcEnri2cVKP4/ZhHFARW7uUKZBrOBDUTDlD08An6s0UMeRDHAIwbksrTCeWB3jycqk5wojvfkzWXPVC2pUjHED9JEpnMY+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR05MB7043.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39850400004)(396003)(346002)(366004)(6916009)(54906003)(107886003)(316002)(478600001)(2906002)(86362001)(6666004)(4326008)(6486002)(186003)(16526019)(66476007)(7696005)(8676002)(26005)(52116002)(66556008)(5660300002)(2616005)(103116003)(36756003)(66946007)(1076003)(8936002)(4744005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9d6qwl66yK2oQU+XTixVIQXI5VvQDfVMEP6/jnYy0oF3f/RfaRK5/bDttFjD5vGs60qTuImK/rAf49w5BTUv/LJRNzZ3haS/dv8h6nUvvMNf6lzsy4aRzhaQ1TZE+diolQUWefpEaTyZ7qIaoFiMZEEuNqt0EMG8d0w/QKDmivlTzNk01BrAu+XRIF2PtLqwGlAF2dg+hyivL7rt7ZitgjWKTTmk6NYa3KWtdFR/StkIS2F4p9rqPzb9Bp7TS7TRz9gIMKTBh53tiS+MXGNL1/a0YV902aH/IbgttfZsM6zD9gM7cFnPOmqxmpYbI9HOcK5pF1TcXt81pUOhJTYys70HTqr7jUofF+Y/qS2meto9nZ5rOay14vod8wyqIHrcpRNcVLANVbL28dnwaakx5vt5BSjJBnVW7A32eP088ITJCtskVCBOmXith9A3nRepF46FKfU65UuNDD8ml0As2R6WhlVJiBAnI8ERLBjp0ts=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334ceb08-b461-44fd-6a84-08d7fcbed85c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgLpsCk7I9+DTYBge9Lz9qzQdpwOtT3JrPnvk7v+CTfHmZwEbq9DJinWov/1wBq8cOEVHdiK8LwP3mwnaPonLZcvzBTwXxeKjLAZEREFN4WqgNwrGvFSFdwkObYirwoS4PwXe4o0BBQVqgtW/BpKv2JDkOWEYJPjO9Bbo92oMk0Q+6GX06q4amLYTfYWeAgdwZNi3OiOcKSxegD8TK0n2C0vrTQbCwbhiBYT7UA3umg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 13:08:44.0020
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7122
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_09:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=1 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=630 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200113
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am leaving Quantenna, so I will no longer have access to firmware and
hardware. Meanwhile I plan to participate in reviewing qtnfmac patches
for a while until my firmware knowledge becomes completely obsolete.
Adding myself as a reviewer using my personal email address.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e581ae499057..9a8941cdc76a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14061,7 +14061,7 @@ F:	drivers/net/wireless/ath/wcn36xx/
 
 QUANTENNA QTNFMAC WIRELESS DRIVER
 M:	Igor Mitsyanko <imitsyanko@quantenna.com>
-M:	Sergey Matyukevich <smatyukevich@quantenna.com>
+R:	Sergey Matyukevich <geomatsi@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/quantenna
-- 
2.11.0

