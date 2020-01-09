Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4470135A1F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAIN3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:29:53 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:4860 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727701AbgAIN3w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:29:52 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009DA7EL017063
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:19:24 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xap422x8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je5/UfrPsZ3FQ3FucOY9zw4joW8rZ4prGAYX4i2sYIRaCF2N/XMM0V6IUB2J6X3f85lbcCKfQasxdAGcbjQkETXlW5nzDprUoRclB6ennduqMzmS7a6F5FKt+UuPo40VbAD/LCNWtb/xwW9Qe+kY4QVkQhFQK8+fMFhEoAsrU8aJTKxnWNo213gLJhOZ6FZ3oNYPMzX5otAv/xPvb37DRRr99hLA8RrFMOuLxWjLBnmBmMOvE2krNjyyg3rHBi6OQWvIUwC9b5eRqctVP/1TNl9lGRi6sBQxn9TiDnIvH3ulmEPtRT+2qzCc72rloVGWPjKkgWbMvy4znJORwm4dPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV62/mFxGP6y1SHj9aHc2W6MOrx1a/4NunDyH/QBx2I=;
 b=btv/F9WPADiUf31YxNJB8GTioR3df0FnwOkJhdJq1XYHizmsAljyJGCHN1f82JQJsE/fgRqh37u1TNdq+AZFykasppraIt6FXtrVfTRk9vZ21vDSJMP/0n6AmlRmM3fEGpasmDmhZ4+hpmv+3YQNOFeMWdXR+nyNbbfwUr2/0Dsl2P+1xRUr2fvklxUSVbnWw/OUBZbAGwtDHkel1EwNckgm7pm4woxpVioeC+G8vZG+NitYlA9nt5dwAYqzY4IJ9iAP3RxHP04cBfxRf9XBONU6o6jo47MVnBNP5+4upEmXNIbWidDgfqoHFRx4+1G1u8Z8ATMnXBnG67mjMqWLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV62/mFxGP6y1SHj9aHc2W6MOrx1a/4NunDyH/QBx2I=;
 b=ZGREb86qbsd155R8l+++gAP2rKgxo2ni+BFQNwqiZrPYhlGPWsu+uImd2Z9XbNRSnb2WhY5Fp20bDdQDcZwfuzrgaDhMXW31r1PHLBkhsjnjC8/qt0B9bSsn2Jt6LJYrNLlKDFVtP27lS9uo4cNhwmpTCSYUM7ygmZ3flAJlEKc=
Received: from MN2PR05MB6478.namprd05.prod.outlook.com (20.178.246.16) by
 MN2PR05MB6445.namprd05.prod.outlook.com (20.178.246.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.7; Thu, 9 Jan 2020 13:19:23 +0000
Received: from MN2PR05MB6478.namprd05.prod.outlook.com
 ([fe80::55ba:fc8c:12f:a0d3]) by MN2PR05MB6478.namprd05.prod.outlook.com
 ([fe80::55ba:fc8c:12f:a0d3%7]) with mapi id 15.20.2644.006; Thu, 9 Jan 2020
 13:19:23 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:13 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:13 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 5/5] qtnfmac: add support for TWT responder and spatial reuse
Date:   Thu,  9 Jan 2020 16:17:55 +0300
Message-ID: <20200109131755.7729-6-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:12 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3310508-1048-4388-aed9-08d795066192
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|MN2PR05MB6445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB46378D5A67E84544B6249A5BA3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:19:21 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(396003)(376002)(366004)(199004)(189003)(6666004)(81156014)(316002)(52116002)(8936002)(2906002)(478600001)(16526019)(36756003)(7696005)(107886003)(8676002)(4326008)(66946007)(86362001)(6486002)(5660300002)(956004)(54906003)(26005)(186003)(2616005)(103116003)(66476007)(1076003)(81166006)(6916009)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6445;H:MN2PR05MB6478.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K44GQHrH6sNx7PB5vXR7/AGu0gAvPVjLcpnhDEPJN+q36jCE/vnCA6QqWjYRoqkYZaZqSpIJ9lZay4oDmHC8ltfL7ADfRKC9qSXgM/fyFKQZOzzu2r0mqyof3sWyHrdrVIAULPBIJ6gWsy2MHW2ksbLKKC7rotog0AyzA1CteDegtt7SEVBBaPyS5QVdM54sPQQXV5JkRcFM6WeUCNHQ5bTAcs20Ep/xlMnkbICdG5v+5YGP62JVAbOrkLXWOt4XeZ31Yznt72ExzgO3pamYyADxH7PSFDXgnr22LrcxJG/pqzT6jp/buRZowuwA64g8j8/XjO+XHm9iB+e+mk6xpwd3IqKxq2ld/FmpLJoG1sCQqEgwxNNMLpH8Uhz1yaVcYhBQOUlOLtcWIEwHks/a5aDXqXyZpf9tFLjlb3dQCnWQrRgQybDjQmfr+XXRulTG
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3310508-1048-4388-aed9-08d795066192
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHwAkkDrxydVHgYNyBnuVvBPxl8kD3zCEssx4+E7zsCszkDrvuZksaZZyepMKvbcIHsqI+Sz+kdaEccd1VLRLWKXw5ooBJPeyUriutK8TswUDPZEwKM6KNyEJ2jw5MwW770AgT+2ug+S2dBbs0spsoympB4cfMnvNUe9yJgwdmg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:19:23.1072
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=1 clxscore=1015 impostorscore=0 mlxlogscore=932 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mikhail Karpenko <mkarpenko@quantenna.com>

Add support for 11ax features: TWT responder and spatial reuse.
Add separate structure for spatial reuse parameters and pass this
structure to firmware along with other parameters in start_ap
command. Pass TWT responder value to firmware. Bump qlink
protocol version.

Signed-off-by: Mikhail Karpenko <mkarpenko@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c |  8 ++++
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 46 ++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index fa932f771856..d0d7ec8794c4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -257,6 +257,14 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 	cmd->pbss = s->pbss;
 	cmd->ht_required = s->ht_required;
 	cmd->vht_required = s->vht_required;
+	cmd->twt_responder = s->twt_responder;
+	if (s->he_obss_pd.enable) {
+		cmd->sr_params.sr_control |= QLINK_SR_SRG_INFORMATION_PRESENT;
+		cmd->sr_params.srg_obss_pd_min_offset =
+			s->he_obss_pd.min_offset;
+		cmd->sr_params.srg_obss_pd_max_offset =
+			s->he_obss_pd.max_offset;
+	}
 
 	aen = &cmd->aen;
 	aen->auth_type = s->auth_type;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 19e432b28de5..b2edb03819d1 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -6,7 +6,7 @@
 
 #include <linux/ieee80211.h>
 
-#define QLINK_PROTO_VER		15
+#define QLINK_PROTO_VER		16
 
 #define QLINK_MACID_RSVD		0xFF
 #define QLINK_VIFID_RSVD		0xFF
@@ -196,6 +196,45 @@ struct qlink_sta_info_state {
 	__le32 value;
 } __packed;
 
+/**
+ * enum qlink_sr_ctrl_flags - control flags for spatial reuse parameter set
+ *
+ * @QLINK_SR_PSR_DISALLOWED: indicates whether or not PSR-based spatial reuse
+ * transmissions are allowed for STAs associated with the AP
+ * @QLINK_SR_NON_SRG_OBSS_PD_SR_DISALLOWED: indicates whether or not
+ * Non-SRG OBSS PD spatial reuse transmissions are allowed for STAs associated
+ * with the AP
+ * @NON_SRG_OFFSET_PRESENT: indicates whether or not Non-SRG OBSS PD Max offset
+ * field is valid in the element
+ * @QLINK_SR_SRG_INFORMATION_PRESENT: indicates whether or not SRG OBSS PD
+ * Min/Max offset fields ore valid in the element
+ */
+enum qlink_sr_ctrl_flags {
+	QLINK_SR_PSR_DISALLOWED                = BIT(0),
+	QLINK_SR_NON_SRG_OBSS_PD_SR_DISALLOWED = BIT(1),
+	QLINK_SR_NON_SRG_OFFSET_PRESENT        = BIT(2),
+	QLINK_SR_SRG_INFORMATION_PRESENT       = BIT(3),
+};
+
+/**
+ * struct qlink_sr_params - spatial reuse parameters
+ *
+ * @sr_control: spatial reuse control field; flags contained in this field are
+ * defined in @qlink_sr_ctrl_flags
+ * @non_srg_obss_pd_max: added to -82 dBm to generate the value of the
+ * Non-SRG OBSS PD Max parameter
+ * @srg_obss_pd_min_offset: added to -82 dBm to generate the value of the
+ * SRG OBSS PD Min parameter
+ * @srg_obss_pd_max_offset: added to -82 dBm to generate the value of the
+ * SRG PBSS PD Max parameter
+ */
+struct qlink_sr_params {
+	u8 sr_control;
+	u8 non_srg_obss_pd_max;
+	u8 srg_obss_pd_min_offset;
+	u8 srg_obss_pd_max_offset;
+} __packed;
+
 /* QLINK Command messages related definitions
  */
 
@@ -651,6 +690,8 @@ enum qlink_hidden_ssid {
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @aen: encryption info
+ * @sr_params: spatial reuse parameters
+ * @twt_responder: enable Target Wake Time
  * @info: variable configurations
  */
 struct qlink_cmd_start_ap {
@@ -666,6 +707,9 @@ struct qlink_cmd_start_ap {
 	u8 ht_required;
 	u8 vht_required;
 	struct qlink_auth_encr aen;
+	struct qlink_sr_params sr_params;
+	u8 twt_responder;
+	u8 rsvd[3];
 	u8 info[0];
 } __packed;
 
-- 
2.11.0

