Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930C53295B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiEXLjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiEXLjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC808D6B7
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzzaWOSJ3HdcP0u2o4pJFa6k4qaNUDUl8/IZm78z+BFH6G0rImiS6/xLjEoiKSoIVdKfTC9ytahEbtNfG4ldaSL8iBci9qENEYlzhLnbXm4vFf/3gyeZFQOwacAzthkQ9S8SDVkg+bXTx8xnIEEJk9ZNOcx11qBIr8RL1hNDN4gqfF+aBwQrVf120QcF9SCzv1ZwVyF4eXe/UuNHdSDuMforq6DmZjcIOfwe0YEyOxo6VHV5PJdxqg3GO0RLcTAh7DZSWf4hSFI8fHHyR0lfDemLtcEtCJBjz29xXv1+Afu3ktzIGFRtS51grlSolHG2Aa2YlbPBm1cp+wXbWae5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6JZoNFmGNSqyK+7OiN9STKegkIvcAT/apf77LQ7+to=;
 b=P9gJxFPwdgt0E6UGfrOCnWTGRoEWgj7Se2EkLE7wu91aUFQ1E1749uvkQguPZWJXIEJksUKdrYfNkMZssEBcf4OvXy9RQWoj06s1Zp3jJKqSJJTI/SyRk2znU52sFjRYKIzb7S4K7kqJSG8DxyRr2x+DunsjelM6Hj3s4KYyrDD+oozaMoem9pezmk9Y8ddCLjRqghFV3L9FQJ5UyJ7v57nD3N7XrML36yEBz1n1HPbIkPTKM9wsWBKglRRGAmtj/7pyL4883YH8PN2DU6DQuk+ElNMfF0B/hhmiW/tQLANUiWdXASzdsAeij1MZzsBVtcjpRLTdn5E1csGODBiFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6JZoNFmGNSqyK+7OiN9STKegkIvcAT/apf77LQ7+to=;
 b=Q8tNWzdtALG+ifpbX/5ZFgJ3q1o1p14Z3gp3eDIJJqOiXnp8o1W6T35MP7ZGDXlzGNJ2RpQmMJYwjzeQuDlzDI2u8jg6Uj7LPVmt1nMwJ++iqyCOcCk3WZclLdFFW8vCHB7h6GKbwUDrOMT/3mF9hr/1Zx+R0gRw9XxpqUGSHIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:41 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 39/96] cl8k: add mac80211.h
Date:   Tue, 24 May 2022 14:34:05 +0300
Message-Id: <20220524113502.1094459-40-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06082275-11e4-4fb3-c8f3-08da3d79e2f6
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384372169B416905D30BCA8F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1db7U7nVw5vZV6/kd5r7DK7Ss2PnG6BcXzpr9v/Yc7FKoYL8PYR1ROk0Q1jxB2r7u2GMfOVuWJTsm0r1e3J/8QPZ26s3tlFdUFgkEeX73E8sod7G9k+FmOR4K8oj+7ewCKgR2ak2BuezAbGnLa2yR+hFDynHvKJzJPANVEzfOCstM4DTLX3CAeEfQ8ih6MTglLlROaT2hmMhvOwhCagfPnzrLgrJlpWhYBao8SOkUtozIISbiQDofBEq1Y6LMbgsObyXMz38BenORPseGHk43aPtaspL8KA8hLjLiyl7XO1fdEs88JSdU4ogEnhq79Jm4OsC9leWSQvKmyCqxPUast2hDqS25HFtLyMqwVUVhuy6v6WXyI+LHLxFve9kqR3wwpe3e7N61GFZCmeDfzmjUeBzRdGLQoczW8vp22++7hpiae6Eir16f9jPj+++4XycvYreed8SjHytQ2iiNgRjVKEFGSPSPnXUMOw/VRKgsa9shFGtvkhHuEkHdOGgL5VnJPEGjeAaeRDf8hFfS1WqLQs5O1QP7X8Amg0ovaeevh7mwtzap90LTMIXktnjeXRg0kkiJRga5I7G4sF5w4VQMfnYgpMCpVwf71/Iq/EqGg5SJPKkn/l61gbwKpBwpwu3Bjh9gyinlCMnSveJs4zsIsvvP50tj8iEZ2Sh+ucrxjITkjxwRDHzbMQkUpAiDwa3KhMnwtnQGf+B+Fhhi1jx60B3c2djb+8VZyNvjJCO2Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCvo8EtcIyZWXrGHdtRNjd6UYfbDTCimwpjP+MiHdYnefCSYNeDlrTifLj5n?=
 =?us-ascii?Q?FWNKaod70haX+l9caXavxTB6S+Onhwqr0ih7T7HB2k5vPi4r3eCB3ioSavHC?=
 =?us-ascii?Q?zRvhD7HRqesnshSxAZEbvFX+xVHplS/G8//9Rf3VmcgUB51ba3yPq0AQftUi?=
 =?us-ascii?Q?5niUSOCncwkDY9T3XlcUtYMaDGABJnHHgHeFZMo3HcUcVZQU6jWa+TJy4N0o?=
 =?us-ascii?Q?1yU1RU+ItJHDoo8J49F7QtxkoK3UbCgqmkO51R8smIg03iAH+ImpRc57lwc/?=
 =?us-ascii?Q?R+gLvBpBRtIcJ9iUP7uUS/WeHCSI5RllxhmQyMYcvVkQ6WV37FHbCSRM0Dkz?=
 =?us-ascii?Q?igrY+psSkEjvKzxBB+eLRuzh93VOmtqiGXxBDXETrMqXUnBzCo4kWUHreIE5?=
 =?us-ascii?Q?Vu7CgQiQiBidm+XCb0cydPv4c5QDu2QZbYMA8wWIto0K52NTU6PWONA5W91H?=
 =?us-ascii?Q?kvVFW4NwI8QL5zW55ID8PJ4Vb8l3zIbMF146dbwBYWcB5NiN47nfK4jGs0pI?=
 =?us-ascii?Q?HduTRbSH66JyTmfVj9Iga5PRpHX6UBQRb8/2NFQsDFQbsRuPb8p4XL7DSIHu?=
 =?us-ascii?Q?DnQopIwY3PiWJD3aVqnKN/lX2ArQ53vTstoJhFpsPU8fe8nhrQzepvCOI3OB?=
 =?us-ascii?Q?+q7Jvosn1YTosc/Wasx2/ROQrrb1qOspvnijm79JaRtlMPO3a6D0LNz4nviF?=
 =?us-ascii?Q?8rYaj1vUfhDkGI+CxA53fhNwaBDMUyi0juKUzU53imRxPftTAP7XV7j/LnUo?=
 =?us-ascii?Q?PM3x8Ho14Gm6TSzZwz+FAfBjuFgoAMGJwPIRfYgUive2gRIFSbsQRT8YCD6P?=
 =?us-ascii?Q?zNkSbX2fKOQZHyZ6Dc7RYYSCxsl6WYkTMRJDzsHUo5zPEA58U+g6fxwjeOKj?=
 =?us-ascii?Q?BnW7SD6EqtT5Pi2tfj/2GyVF0a206xn9H2Q7HnCvGsbaUF/2h/i0D1+26EXD?=
 =?us-ascii?Q?xOgjq4d5/4dU5aXrfNxcmb1zEXt93K9u3pkevk/itpnYeEVy/sWlNsu96ubl?=
 =?us-ascii?Q?HqcppDy7JybXgrwSSgpd/QnLuHa1SXJATop04ncQkLWd5xluBaMHpFNzUhyv?=
 =?us-ascii?Q?1rHqVwdsXv0tqwsqzC+M470rswpXLrWO440w6jJZ2iQSsjJAMoG0f7LVlSiN?=
 =?us-ascii?Q?IAi0LYfvZIyMa8FQB3HTf993y61h6spx5nRaaEjflPGyP/IwB58V4KQBiG0N?=
 =?us-ascii?Q?WqjAidkgiE5GY6kcg7fONTjIkA1xs+sI79BbscyoeuH/1cv6kHHCiSmdKsTb?=
 =?us-ascii?Q?mRZbz0DJOi/MAVXfl+Mpr9QcyqX64+a0jZ8a3oYiJCB0XRjlsXjKamj0pK0k?=
 =?us-ascii?Q?gcwwHqKl5baAN6/7yaG94xFDe3QQ3/ZNVvM1Ql+dq8f+utIFvY+fDa/KDSwf?=
 =?us-ascii?Q?5eLV2VRDRlRlRhvkaxBEO5ZJuFFL6w6bcKVQaFNFxiPZ8Wmh5xq1Ni8fwU2n?=
 =?us-ascii?Q?t5slT3MGnZjCmHOQjDFbir6Az9uhvsayLNHiaHHT/3w2e6eMcF8nbCbblSpT?=
 =?us-ascii?Q?5dGEGY0aWcYlQGsimY6tsYzdLImUvadqLuCXt6/nYV5ZaPYQxmuE2g1TatPS?=
 =?us-ascii?Q?lhlZcGCkoMgI1/GkIvNWMs565PkNI9OO6gkGZvc2k008TIeGiE3PnmH/0euh?=
 =?us-ascii?Q?gCZC2kGuXTrjR+UUpTtugsmee+jqKE5GCwQEVGv5uuWJmwqzxG5nhfOp7dSV?=
 =?us-ascii?Q?jBQQFAQLdrtiJMxZV074wxRCInCygEsjYKib5x3ChFRaJRVRBlYs0LOHWkKU?=
 =?us-ascii?Q?GrxC6q8r01jfu5W7OZBb53NYrTZHxBk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06082275-11e4-4fb3-c8f3-08da3d79e2f6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:13.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aa4LQWwaXfppPhB2jW8r3JPgyCdlHTmh7Sy6sI0snJIGxSBuQXcARfZFksjQX8ztR2IUujsA18UYMz1iFWO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mac80211.h | 197 ++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.h

diff --git a/drivers/net/wireless/celeno/cl8k/mac80211.h b/drivers/net/wireless/celeno/cl8k/mac80211.h
new file mode 100644
index 000000000000..f76c1a0ad820
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac80211.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_MAC80211_H
+#define CL_MAC80211_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+#include <net/mac80211.h>
+
+#define PPE_0US 0
+#define PPE_8US 1
+#define PPE_16US 2
+
+/*
+ * Extended Channel Switching capability to be set in the 1st byte of
+ * the @WLAN_EID_EXT_CAPABILITY information element
+ */
+#define WLAN_EXT_CAPA1_2040_BSS_COEX_MGMT_ENABLED BIT(0)
+
+/* WLAN_EID_BSS_COEX_2040 = 72 */
+/* 802.11n 7.3.2.61 */
+struct ieee80211_bss_coex_20_40_ie {
+	u8 element_id;
+	u8 len;
+	u8 info_req : 1;
+	/* Inter-BSS set 1 when prohibits a receiving BSS from operating as a 20/40 Mhz BSS */
+	u8 intolerant40 : 1;
+	/* Intra-BSS set 1 when prohibits a receiving AP from operating its BSS as a 20/40MHz BSS */
+	u8 bss20_width_req : 1;
+	u8 obss_scan_exemp_req : 1;
+	u8 obss_scan_exemp_grant : 1;
+	u8 rsv : 3;
+} __packed;
+
+/* WLAN_EID_BSS_INTOLERANT_CHL_REPORT = 73 */
+/*802.11n 7.3.2.59 */
+struct ieee80211_bss_intolerant_chl_report_ie {
+	u8 element_id;
+	u8 len;
+	u8 regulatory_class;
+	u8 ch_list[0];
+} __packed;
+
+/* Union options that are not included in 'struct ieee80211_mgmt' */
+struct cl_ieee80211_mgmt {
+	__le16 frame_control;
+	__le16 duration;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctrl;
+	union {
+		struct {
+			__le16 auth_alg;
+			__le16 auth_transaction;
+			__le16 status_code;
+			/* Possibly followed by Challenge text */
+			u8 variable[0];
+		} __packed auth;
+		struct {
+			__le16 reason_code;
+		} __packed deauth;
+		struct {
+			__le16 capab_info;
+			__le16 listen_interval;
+			/* Followed by SSID and Supported rates */
+			u8 variable[0];
+		} __packed assoc_req;
+		struct {
+			__le16 capab_info;
+			__le16 status_code;
+			__le16 aid;
+			/* Followed by Supported rates */
+			u8 variable[0];
+		} __packed assoc_resp, reassoc_resp;
+		struct {
+			__le16 capab_info;
+			__le16 listen_interval;
+			u8 current_ap[ETH_ALEN];
+			/* Followed by SSID and Supported rates */
+			u8 variable[0];
+		} __packed reassoc_req;
+		struct {
+			__le16 reason_code;
+		} __packed disassoc;
+		struct {
+			__le64 timestamp;
+			__le16 beacon_int;
+			__le16 capab_info;
+			/*
+			 * Followed by some of SSID, Supported rates,
+			 * FH Params, DS Params, CF Params, IBSS Params, TIM
+			 */
+			u8 variable[0];
+		} __packed beacon;
+		struct {
+			/* Only variable items: SSID, Supported rates */
+			u8 variable[0];
+		} __packed probe_req;
+		struct {
+			__le64 timestamp;
+			__le16 beacon_int;
+			__le16 capab_info;
+			/*
+			 * Followed by some of SSID, Supported rates,
+			 * FH Params, DS Params, CF Params, IBSS Params
+			 */
+			u8 variable[0];
+		} __packed probe_resp;
+		struct {
+			u8 category;
+			union {
+				struct {
+					u8 action_code;
+					struct ieee80211_bss_coex_20_40_ie bss_coex_20_40_ie;
+					/*
+					 * This IE May appear zero or more times,
+					 * that situation wasn't handled here.
+					 */
+					struct ieee80211_bss_intolerant_chl_report_ie
+						bss_intolerant_chl_report_ie;
+				} __packed coex_2040_mgmt;
+			} u;
+		} __packed action;
+	} u;
+} __packed __aligned(2);
+
+void cl_cap_dyn_params(struct cl_hw *cl_hw);
+void cl_cap_ppe_duration(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+			 u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE]);
+u16 cl_cap_set_mesh_basic_rates(struct cl_hw *cl_hw);
+void cl_ops_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control, struct sk_buff *skb);
+void cl_ops_rx_finish(struct ieee80211_hw *hw, struct sk_buff *skb, struct ieee80211_sta *sta);
+int cl_ops_start(struct ieee80211_hw *hw);
+void cl_ops_stop(struct ieee80211_hw *hw);
+int cl_ops_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void cl_ops_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+int cl_ops_config(struct ieee80211_hw *hw, u32 changed);
+void cl_ops_bss_info_changed(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *info,
+			     u32 changed);
+int cl_ops_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void cl_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+u64 cl_ops_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_addr_list *mc_list);
+void cl_ops_configure_filter(struct ieee80211_hw *hw, u32 changed_flags,
+			     u32 *total_flags, u64 multicast);
+int cl_ops_set_key(struct ieee80211_hw *hw,
+		   enum set_key_cmd cmd,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta,
+		   struct ieee80211_key_conf *key);
+void cl_ops_sw_scan_start(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  const u8 *mac_addr);
+void cl_ops_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+int cl_ops_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		     enum ieee80211_sta_state old_state, enum ieee80211_sta_state new_state);
+void cl_ops_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       enum sta_notify_cmd cmd, struct ieee80211_sta *sta);
+int cl_ops_conf_tx(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   u16 ac_queue,
+		   const struct ieee80211_tx_queue_params *params);
+void cl_ops_sta_rc_update(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  u32 changed);
+int cl_ops_ampdu_action(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct ieee80211_ampdu_params *params);
+int cl_ops_post_channel_switch(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif);
+void cl_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u32 queues, bool drop);
+bool cl_ops_tx_frames_pending(struct ieee80211_hw *hw);
+void cl_ops_reconfig_complete(struct ieee80211_hw *hw,
+			      enum ieee80211_reconfig_type reconfig_type);
+int cl_ops_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int *dbm);
+int cl_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+void cl_ops_event_callback(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   const struct ieee80211_event *event);
+int cl_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
+int cl_ops_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+u32 cl_ops_get_expected_throughput(struct ieee80211_hw *hw, struct ieee80211_sta *sta);
+void cl_ops_sta_statistics(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   struct station_info *sinfo);
+int cl_ops_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    const struct cfg80211_bitrate_mask *mask);
+int cl_ops_get_survey(struct ieee80211_hw *hw, int idx, struct survey_info *survey);
+int cl_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_scan_request *hw_req);
+void cl_ops_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+
+#endif /* CL_MAC80211_H */
-- 
2.36.1

