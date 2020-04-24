Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B01B7317
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgDXLaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:30:17 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:58030 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgDXLaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:30:16 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBQZQb032536;
        Fri, 24 Apr 2020 05:30:12 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fxuf1t3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:12 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch5p+VQzmAXKjkN63fE0uKiN6w/bTvKUJnzT95JjklPqqYrCXfM4q5+Na4e6rM3sSYvlmSjoHKww4+3o36MfvKbQZeV1Ej8rHXgvhG7oC6Gzpu/pdObt5B5mfWFyyFeFKv7zHbyJdFk0Om4fAPkT5faQ7ZKBpNtCkSgog0BTe+NLIa2HXkEK3nvZwEqewwItM3qyknKNPYe4Lp/euIQmprqSe2agodvFvbJdXcd7l7FUzyHcIynAGEXXfTtrAYsB18nvxzCB31PoaN7tKs2rf0XwwbBF9S9G3uILGqBSWkf42Ctn5DMUE3NwXVr2uxsjox9FYJ3JdBvfRs78fzs8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT9YqyX9nLsHbZ7+SvXBQ6vtQ3gfbdHPemUxqA4c/DI=;
 b=RUHMl+ITCmmqdxAkdTteN7x4lCMShLR/jXVZWm6aYt8jX7U3hyL8c/uW3rCzgXAl9oDA1O/0X8ice68mD2w4RMyxmv6MAIvUcAkBy0ZhOWisAfegvHec3kYt/pU2sjCTUsGvpXIfwneJVIG1IoTwn3VrEnAy5aIo7zCgcs00VtuBoD4S5dpBTHuKLGDxPP38zwHDZew1Tj8712KWLs3FERTXydyiIoF+hqX5PUX3tPDPeyIFUMQYty2t0CIjHIRdPgz2vp6T/uefBjOdCajXmGW7kqNp3JYFPKp4FbsARLl7W/BauFJ6dP+lJQDqOg0mvxz0O+ckf5r07IF9Xg7bGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT9YqyX9nLsHbZ7+SvXBQ6vtQ3gfbdHPemUxqA4c/DI=;
 b=RzgkqegWMxeTVLdp9vePNRIgnhd4+Ga3ij2SMIVGAMhmNDnjgaW9SVGqCS6UKPupq7xwnUQpS999ZX0LHXZIjK5UqpII3HLVMWISh23QE1bQNlcfPbJkiFVsXebe8KvbEw5Tei+XLYDb87ErACUhuzPLE1UTsg3jRpIZww3fhwM=
Received: from DM6PR05MB4684.namprd05.prod.outlook.com (2603:10b6:5:fa::12) by
 DM6PR05MB6347.namprd05.prod.outlook.com (2603:10b6:5:132::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6; Fri, 24 Apr 2020 11:30:10 +0000
Received: from DM6PR05MB4684.namprd05.prod.outlook.com
 ([fe80::fc28:e348:eef6:bc06]) by DM6PR05MB4684.namprd05.prod.outlook.com
 ([fe80::fc28:e348:eef6:bc06%2]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:30:10 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:18 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:18 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 3/5] cfg80211: add support for TID specific AMSDU configuration
Date:   Fri, 24 Apr 2020 14:29:03 +0300
Message-ID: <20200424112905.26770-4-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:17 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186fb5a3-fc54-4ab9-f8ec-08d7e842ba14
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|DM6PR05MB6347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3160C650AF6631E43A8092D0A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:09 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4684.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(376002)(39850400004)(6916009)(5660300002)(7696005)(107886003)(103116003)(52116002)(66556008)(36756003)(2616005)(186003)(316002)(6486002)(54906003)(478600001)(66946007)(66476007)(2906002)(4326008)(16526019)(6666004)(8936002)(8676002)(86362001)(1076003)(81156014)(26005)(956004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71gi+ay/CfKIrrgX/w6GBoOaUV/3Oxvv482+23zdVqfVAo6Lxnt4flbNeSrJk1Jx5BvTXvDGZGSJDkza2qfgumg+YL1/Cw4QTQNsIhuG9jdQ81fB1aMSH8cEdo/Ew+eCtyrJuI8ErMpH+AiCBfUoCl8UzX/jhGI08amzwlV6AGB+1VK+1vTG6fGmxtAXhVjnQirPlrZ3Nv9j0ZK7xQK0q9eeInAmuQbeGjWw5sA/7EoKZtqg53eK+3JNDt68Z5jpCPMrfW5rAxu1wJtJJzRBa3JdPyicQSRhcCljVWuLLTpvX3E1/BMS/1oZlf3Ut+zorfWhh0scjxNNiSSAtRej/AlD95BMneXbR1IYxHBSIfX+RhAv2zpQk840f4HiaAytzJHmht36nZirMD57GIEnd2jFrH4NM/KHd/9sAa5uffVvOqd9peNC7OMVTBdiYPC+
X-MS-Exchange-AntiSpam-MessageData: FqEI6HPCT+HEDmwkToA7IRehrlZkwHganRwlXH6RQeHtgcZdbMln3m+dOlDoiR7npYK4egjraZCDxRMAoPFJygpmBntAWw6+ksyS1vcs9xSaSlwIndTRI+yM09RGhc3y73B+2P+GhyeV2+mC0y1XIerHwdWNK4D4oRiRsgj32KkUdFLy8uqtMth8kDjDPtzOw4Z7SQsmtmyj444FZwAVT4O3B3gCPQ1gMU1m5FIQkS5fSexJqy2OL1i1sb49ti51glZjAtxBVBmDl8ezOJpAqElhlgxZvITD24Zj9K8iwjACPt9m6KzjfWVJjtPVvEcQwvuFJcKlhJCha85NG3KCb+lLH5OpN3VLqXKtnCXUV5rerTKfbmKeR2I5a/84uB56fB3FuCJOhMjKL3AqugN4gDf6EVCMzwObgRyY+TA2dzPszrSYWTdtr1lx2mff4gg6D6Nzq8TkVdk69m2bfeoXhI+NOFqUvwWplzSfghYA3mIwbaxZdjBM7P3dmeU7mDdESU5fGHFE8lOJ/bvGJ8SI3RWaLs23Py4YdeUtovrLq+UOqw9jpinwZUKMpMt4OvvSIEuUGLRbdDoo29s6CPM6IMdW4C/ZfhEjloPNEM4r/jsSHMuZJeVp/XeHgxGjO2S57L8Uayn1oY5P7xUKss90C13b0TOk2+2enYCP1IOLyziYwcccpDOxxEbxwywI0Gpw1gf4lfJmXom0Ntu+eGJHEAIid3acsX3ZsKNzopJB4Vv53dgtqaxgoEdW4EGhJgANCu4xGgXzvi+5DOOaoGLNoZCePij/qV4HUYHdZ1dyoek=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186fb5a3-fc54-4ab9-f8ec-08d7e842ba14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPtiVLnmojQEabET/b872UkdVP/zH9VcEDiDaFipBmSYMNdKBDND2czLrdMXxCu2q6RDUD9Ilu6uVjUocj4N+5dAzSC9piuufelfB5sqkVWfjU1A2G0Ngf5P91EtyC8Cdg7SSQbSm+MLNfiLVqsbaLa4J4GGW+Ggtmju7v+X8DEGfRw/DiU+kOdHYXxXg/QAWOmAnC0dvFuEjmPj8M76WA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:10.8270
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6347
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

This patch adds support to control per TID MSDU aggregation
using the NL80211_TID_CONFIG_ATTR_AMSDU_CTRL attribute.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h | 10 +++++++---
 net/wireless/nl80211.c       |  8 ++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a2b2d31530a9..83148b2d4907 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -640,8 +640,9 @@ struct cfg80211_chan_def {
  * @noack: noack configuration value for the TID
  * @retry_long: retry count value
  * @retry_short: retry count value
- * @ampdu: Enable/Disable aggregation
+ * @ampdu: Enable/Disable MPDU aggregation
  * @rtscts: Enable/Disable RTS/CTS
+ * @amsdu: Enable/Disable MSDU aggregation
  */
 struct cfg80211_tid_cfg {
 	bool config_override;
@@ -651,6 +652,7 @@ struct cfg80211_tid_cfg {
 	u8 retry_long, retry_short;
 	enum nl80211_tid_config ampdu;
 	enum nl80211_tid_config rtscts;
+	enum nl80211_tid_config amsdu;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9679d561f7d0..1ccb0bf657ec 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4844,12 +4844,15 @@ enum nl80211_tid_config {
  *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
  *	the max value is advertised by the driver in this attribute on
  *	output in wiphy capabilities.
- * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable aggregation for the TIDs
- *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. Its type is u8, using
- *	the values from &nl80211_tid_config.
+ * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable MPDU aggregation
+ *	for the TIDs specified in %NL80211_TID_CONFIG_ATTR_TIDS.
+ *	Its type is u8, using the values from &nl80211_tid_config.
  * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TIDs
  *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. It is u8 type, using
  *	the values from &nl80211_tid_config.
+ * @NL80211_TID_CONFIG_ATTR_AMSDU_CTRL: Enable/Disable MSDU aggregation
+ *	for the TIDs specified in %NL80211_TID_CONFIG_ATTR_TIDS.
+ *	Its type is u8, using the values from &nl80211_tid_config.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4863,6 +4866,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+	NL80211_TID_CONFIG_ATTR_AMSDU_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3d27b24c68b2..aef0dd59dd4f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -345,6 +345,8 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_AMSDU_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -14127,6 +14129,12 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_AMSDU_CTRL]) {
+		tid_conf->mask |= BIT(NL80211_TID_CONFIG_ATTR_AMSDU_CTRL);
+		tid_conf->amsdu =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMSDU_CTRL]);
+	}
+
 	if (peer)
 		mask = rdev->wiphy.tid_config_support.peer;
 	else
-- 
2.11.0

