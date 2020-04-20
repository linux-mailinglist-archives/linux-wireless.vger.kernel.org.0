Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4F1B077D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDTLgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:36:04 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:65512 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgDTLgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:36:04 -0400
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03KBZhJg026281;
        Mon, 20 Apr 2020 05:36:00 -0600
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by m0059812.ppops.net with ESMTP id 30fv3svmjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:36:00 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNXvnECMSZ8CuSbV7hfA7wRVDHi8Bvcc0EGs3jzrlm4trsJYMfJJE+YEluy+IsVrE4/mbpHt5KjEKM0BcYHL8kMeJi0Hcv3Y97G1yXi+1a3fZdEWhpEKrEs+I+UtSyjvkNZ7NM03xy+M/Z2gAb3LrU4F0ikcP/YZvv0yNzHgEGYuiRBIheMFqw6QPy+K4ypcD1FeeS2PIH7dsqFETSs2Mf+VlpnqsMI+OdKxj/0wXGjEJvEo+1DTz+ThshQZjLtfZOZ7O8Gq1qSTq/+Irva4tv3H84tnubwDrS9ldXWM0em36f0XjV+IPVzg5xU7aEGfGjnaFu1twnup+NyeP0mILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcb8wRdfCPM8cgUHHc8oQWP65KXHb3+f37OOShvlpSg=;
 b=ZrCNCvYNDXysZBa1zIIcQrcqGNFQO64NRhY8TMqYfLlkbj9E1guHiKrE2CkChB4WLysef5B0aJbeL5wiz3SXx9xHbhMcO7yzADg3Um384njbpvHVEjB7q5zJAapc/58uSXcaaZdadnOZT0umrVDzL/cCKrDJWuSIIJ8n7OuU91Bz2zeetl+NgCf0kt6+pZe7LUr0EaDJOlv6qAJOwl6a9KlKHqApAMcO1m2XhggC9rXO9rnri1cuO5ae88SqmgfNhkXQB8Gwf0ZXdYipoRvAk/WIA3FMmeSdi3ZSH4KvMRA1D3QhuBHZzQTak2BJLhiY8vr9BcPftEXjSbAwMbcYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcb8wRdfCPM8cgUHHc8oQWP65KXHb3+f37OOShvlpSg=;
 b=JBCGMZDnCdzrUlhX+u6ort0t8ICVUyrTJ5VdDCaqRoX2iDGca4RzMV7zYoZtP+QLNRCjDEkJt+3HZ4TWoRF2Pk1300UcTDYYBzZKbZiMtb0lvejNUMuXg9wwWn1CXT3JFcerTWM381/Kdb77BoaLEks44dmgP4zaL16kmdaiIJE=
Received: from DM6PR05MB5801.namprd05.prod.outlook.com (2603:10b6:5:106::30)
 by DM6PR05MB4043.namprd05.prod.outlook.com (2603:10b6:5:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:35:53 +0000
Received: from DM6PR05MB5801.namprd05.prod.outlook.com
 ([fe80::bd8d:8575:c72a:8191]) by DM6PR05MB5801.namprd05.prod.outlook.com
 ([fe80::bd8d:8575:c72a:8191%7]) with mapi id 15.20.2937.012; Mon, 20 Apr 2020
 11:35:53 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3605.namprd05.prod.outlook.com (2603:10b6:910:51::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:34:52 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:34:52 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 3/4] cfg80211: add support for TID specific AMSDU configuration
Date:   Mon, 20 Apr 2020 14:34:36 +0300
Message-ID: <20200420113437.16998-4-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0101CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:34:51 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b75613-bd49-4229-7216-08d7e51ed766
X-MS-TrafficTypeDiagnostic: CY4PR05MB3605:|DM6PR05MB4043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3605D6DE644717BDD0753AACA3D40@CY4PR05MB3605.namprd05.prod.outlook.com>
X-Moderation-Data: 4/20/2020 11:35:30 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5801.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(136003)(39840400004)(366004)(316002)(478600001)(7696005)(52116002)(2906002)(54906003)(86362001)(8936002)(4326008)(2616005)(956004)(103116003)(5660300002)(66946007)(81156014)(26005)(66556008)(107886003)(36756003)(1076003)(6666004)(8676002)(66476007)(6486002)(186003)(16526019)(6916009);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJtpJtrMvHEjfd4GszfzVxQwB26+yNl7eKxIwH/A52XapY6hGXSKQ9fokbMdDg3xGpeHaJya196USD7DmtGt8uRyCEeEpap2jjLCMxgAD5fnOTSo34XDs+mD3O/SRvGLIU+zyd6lPV/8RM7LKbZM4FYmPkPmsgjnMkaktyH6PLeTeK2MCDFNrBHCoFgoRVc7T/YLkpCTBuCUdl+gWYmMTK98aenoM4zcwc+A+0bun0yi9NR63euu8zxaCWAPMHGO9j0Ce6fRYCIESKCBPaa/RkUVUk9s2e9eCQkU0eA3ZbqaZRRE0OjoLfJeEW4ns9B81BZ3q+1nsF33Jzaqwchi8irCen5KGJJkO4Y4ZPZDAeRvIVi0lkBYs2YVeCxpVGn/WrMBjs2zkvjUhisW3m+WHvFxKL9TDCyZbmghPI4q4lP4m/xCNokOOpRh0K5hDMkP
X-MS-Exchange-AntiSpam-MessageData: gUKvyItLe5hj7rjE6egROpKPGkWkB9vtL89fZm2pXGOAxUIGg7Ty2tWYLlDPly6XKTClZ1rIpV9sQ4JvX0Rtel4Yzcpeeciozv3NMSXlrlOuiu9GlP2kKCPDG7UrVV8KXoUTe4S2m/CVOadYiwySsA==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b75613-bd49-4229-7216-08d7e51ed766
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+0fkR4Dcjt8HK7E6LBc2vF2QJVvjfDEvpEVCzzWPm8DCak0fyHuKCqGOB/3MS3LMYAGzDyN2zpw7dNQ1Mn+03ZGAw03toBh42ZOgl2sfk3usjmw/UkAP2iW6RZAIW4IR2HRoaDFcLtEZAuNE2JcyNJHpTI2WR7pMJVr47FAGwKN+1jb35yLlksDHnl2qg8UId4biHWtCupche68gcVSfHUlxhipzJ1d+dbeddOWORg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:35:53.1970
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200105
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
 net/wireless/nl80211.c       |  6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ff2646ed5fa..6dfae972730c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -636,8 +636,9 @@ struct cfg80211_chan_def {
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
@@ -647,6 +648,7 @@ struct cfg80211_tid_cfg {
 	u8 retry_long, retry_short;
 	enum nl80211_tid_config ampdu;
 	enum nl80211_tid_config rtscts;
+	enum nl80211_tid_config amsdu;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..1bf34a39c776 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4828,12 +4828,15 @@ enum nl80211_tid_config {
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
@@ -4847,6 +4850,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+	NL80211_TID_CONFIG_ATTR_AMSDU_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..ea0e588b6f6a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14104,6 +14104,12 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
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

