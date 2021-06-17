Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0A3AB867
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhFQQHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:51 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:41442
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230167AbhFQQHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjHj7RjCrjRL4FodG73KhUAmtmP3Of4L2BEpwWdpxb/wt0Q5Gh359cumJZ16lwXsYuCy53aG7CfGH5Q9SOV2n9GWE8/bYF8FpKQqOR354ToR7aDUdtGwYgW+KNcPp06M6YEjVuOYKK+l0UT+fOpzEoDMlzqV7IXDAvi0sDeageoW3WUfRpYG3o5GLgnUoZJ2UQfLwWBX1/26irs/NatRLSX8MeYEStPmq/FwUyOphcIwuPY6i8K71bMKlBwWczi7kqse53E60bG/aaeIID4I6xxL4/C6xbeIeD8YkmOGh0okHmGQ+dit8G17bbpRh7fXomwZpiNJjJklhgSvbh75iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knDtX294vQYSjbFyLfKqP4nnUWeJm6eVXe5Lg9jYR+U=;
 b=e+riFRbyb4EAdh4EV/715qseloGCRNpXSJQOAwwW/jCChWYJKPAkEK4N3AavzA97vf9rBxlC0hwjL4JLknbIonBO1BYpYXxP7X6y9fXIu0Vv8AGlxUO6EpZdLlgaSA8A0dlgDzKU/Yl7ZXBVGoGT9k+KoqaZ7XqAkx9E9/Jj9DvbzBJYFNcZwM6mh8xc9TP++r/zIBSpiJHWIdEWsHPVXb4iI9cmjIetbhTskqpIpvWReSLkUpkiYfNPSAYhRDJoHGq94+tM8Yz0x0mzY9wsu/nm8MOAXCZhtJJG5uGnjM91BLqv4kbnPWcOQaregHkrtyIB6T5EbfTiffuE10r8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knDtX294vQYSjbFyLfKqP4nnUWeJm6eVXe5Lg9jYR+U=;
 b=2OvPSwQFk5i6sc2hS6/8hjPhXGh2vNtuWtEoHUyRJZUg+KGGIc+kcyakUgLcCn3ZxwccSkPUHY2O5tsL0F4xKb7RUKaAcMDgMz4W9w/m8z5QMQEE0rC7Xy2r5LdzyYoq84Od5asCEov2vBW/dvgVt2X1xhulOaTIKR+AqvlQDgU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:06 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:06 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 106/256] cl8k: add mac80211.h
Date:   Thu, 17 Jun 2021 15:59:53 +0000
Message-Id: <20210617160223.160998-107-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c080d996-01b8-4a50-4c33-08d931a99785
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04021ED51A0A1ADA2122E64FF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vDuC2Rh5O7lfrfMrlFU1az2euLKIIgxkkB+sWDQ8DsvKw/IslweynE4RMf21PW8/JaIVarCfutaWCAo9OY66i+ESF2QQ2wqV5XKY6U9KkollJNroCK3pyILwKey+svfD9ZuU1PLfcBCL1V5W6ofO9pPwUPXJX1SwfEVX7RhjDHehvq9/ZKzo7KIOIrIGf7S/JXtlBUETfTxINB53Rr3aG5d3LY8fmMepMFeDJDIwzM7IcL3zzLdbdJ8Ss7LiUFetNUFo2rC2w1pehqqMt8pXDnyxlRrd+US/Gg+P4/M7oGKOkvZD0bYVee5UIRt40RVwwcB9C0CcebRStDZD0fhxYK1QVzdKtvXgeztZILCi1+RVmi8MtKh4hWnPbRFQT+sOy4E8DAHFpO6XPG7tNNekywlUn8wHLNzgNbDBIKbgMKmvWXWmQX05u2PyufQw12IV2KVk5OzJEXDw82MUtoL/TecPdwQGsDeJJEiv/3IOG2e87vlgdr0OfQvxWbh6RLTpqdz3ya2z9XsiIrHrtdqbHeX/gfQImCy5rKcXR7slu9Yq6NpoGUJaKDZQJz+yvA6XxXZIXaiJ3GrHD+yv3yLWLVSUHmmamg6IEhYUxNDQjK0aL2Jn82NkZpWIhA5e1N3HDrEWN/5bjmBdM1Zbyrr33OT98v0it8usXtYJPdAHFcPvED4kz0pFMCZo5qBhbtw6iNAYpdPLqVSHJpw4amxBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zmi1Qp0FYOfWwi3otmrqQ0I650og7wAxLfofO01XL6ejd4bLWHy7s7iLOVi?=
 =?us-ascii?Q?7IwyzbWJQCOnMvfWvA7KVr8IMJ0jIZPZQLZDnbwUWu0Nz/+c1HSFt4a4dIKf?=
 =?us-ascii?Q?PJd6bfMV/t82l/DLXYBL1G0haM7M9J+Wznkw82dYorO31hzXU64kr+BeTUBj?=
 =?us-ascii?Q?H3WXwncruvOsp6mb+4BUA/NGhRnGTv4Fe2Bt7XS13whHCQ5lEHSDHOS26KfQ?=
 =?us-ascii?Q?JCC1mp31m8hUaf+B/5A/PGgUlG73Ofz6WOBy+DBk4RtDbbQ39TvlISKfUku2?=
 =?us-ascii?Q?jljJiPcbKBeNyGLGaRuDuvyTRmXPH1kHvHJ+6Xl/xyBPeyAq5rHDav+3lHEx?=
 =?us-ascii?Q?yH1KobTlBdXWTeLyh0zEjOCPwVkzwoJuvTK25Z50c8euR81yASuJR18kMAsQ?=
 =?us-ascii?Q?so2XmPvxrxuO/fq6TwSvk/xegLp8ZT6aHsvhrMPykjTC3j7TceDiwcaeFbIh?=
 =?us-ascii?Q?9juSyVZI5WQVGTnvRp3xL+w9IzFXRDc6isuESnUi0STIvpKel0H8eoTVpwoh?=
 =?us-ascii?Q?cncx2vDZgwptjfT1vQbRt+hMU+py/yU3guj3hBEIzEjvJhxz3y8udHGVfMle?=
 =?us-ascii?Q?UiWFDMcc6QCxnZSoeopPRWUuI8yh4lBg7+7vVeNOJt7m/Qxtj8GGdZ6PiuOg?=
 =?us-ascii?Q?4HSb/2CHT71+0UZEKceBKa9Rj/0NmijIxJ9+UqiB/Ds80n9Xj1abwUT5mMuU?=
 =?us-ascii?Q?YNZ51xgyajgVh2v6mL2DCmy2UFihjcJRDfpImWOpwSAbrpDflXtEeOAChJnN?=
 =?us-ascii?Q?nQTZ3HCw4fp3cpZz2cuiGBY9LQX7ewEi1/nCPtccWPxa33buZbtN098V3emj?=
 =?us-ascii?Q?hTWzN3PDtyRaBSMVPAyEKWSWYZ9EGYCHWLi3h/38GAmsPg8WeBDwGYB0+wnz?=
 =?us-ascii?Q?Xcx0IsXl6/3Q80uvgkfmcEZsCkqQbQ26J5fQAtJ8FTknWVm30LCZ8HvM8ZZe?=
 =?us-ascii?Q?Fd2FjUywpKYci8XvPNoiRrokHIvsbBv6u3ZegDudaYLSi9Vn0P6eqYrEmq89?=
 =?us-ascii?Q?F4cH1/M9aP7bPjHFKtZxpqUcEm071GUvpx+iVwJYYYZqTdyxNqa8IzV+Zk6C?=
 =?us-ascii?Q?lgYzfMn3+wb703Mun7Fj3gfUs1z8e46Ldn1LZ9A/5pChdoCVhaIlDqE986xE?=
 =?us-ascii?Q?+Uf/MK09p80jF9fyL8Iax83l2hTUWTh/yD8mBrQR62KtyuRa/SDDh6MNDjEP?=
 =?us-ascii?Q?ztVoe8ZRZsZO9/xvM6aZq2T21ZTQDbtI7lrG0Y10vZyljFMXXuxJlGRRCY2z?=
 =?us-ascii?Q?dIJn6YFcGSt7kdeZSQlzQbYvwLPRdDcA/CUl74eHAEFrvEXfezffPaZYMkTY?=
 =?us-ascii?Q?yp6tYGDAq8X4hIInbiPWbQYd?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c080d996-01b8-4a50-4c33-08d931a99785
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:31.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkOn0DvRVSAD5RPVtkwIUfLrnzKTj95+lbapZNfrFGWCvwQuiDBAmemeicSjdZkhH6BHg0CM+nMoLqSWScYu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mac80211.h | 310 ++++++++++++++++++++
 1 file changed, 310 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.h

diff --git a/drivers/net/wireless/celeno/cl8k/mac80211.h b/drivers/net/wire=
less/celeno/cl8k/mac80211.h
new file mode 100644
index 000000000000..57bd08d5a730
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac80211.h
@@ -0,0 +1,310 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MAC80211_H
+#define CL_MAC80211_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+extern const int ieee802_1d_to_ac[8];
+
+#define IEEE80211_CTRL_A_CTRL_MASK  0x3
+
+#define IEEE80211_CTRL_A_CTRL_ID_OM  0x1
+#define IEEE80211_CTRL_A_CTRL_ID_UPH 0x4
+
+#define IEEE80211_CTRL_UPH_OFFSET 6
+
+static inline bool ieee80211_has_a_ctrl(u32 val)
+{
+       return ((val & IEEE80211_CTRL_A_CTRL_MASK) =3D=3D IEEE80211_CTRL_A_=
CTRL_MASK);
+}
+
+struct ieee80211_a_control {
+       union {
+               struct {
+                       u32 b0 : 1,
+                          b1 : 1,
+                          control_id : 4,
+                          control_info : 26;
+               } __packed fields;
+               u32 value;
+       } u;
+} __packed;
+
+struct ieee80211_uph_ctrl {
+       union {
+               struct {
+                       u8 pwr_headroom : 5,
+                          min_pwr      : 1,
+                          reserved     : 2;
+               } __packed fields;
+               u8 value;
+       } u;
+} __packed;
+
+/* HTC header might includes HT/VHT/HE variant */
+/* This struct implements only HE variant type */
+struct ieee80211_qos_htc_hdr {
+       __le16 frame_control;
+       __le16 duration_id;
+       u8 addr1[ETH_ALEN];
+       u8 addr2[ETH_ALEN];
+       u8 addr3[ETH_ALEN];
+       __le16 seq_ctrl;
+       __le16 qos_ctrl;
+       struct ieee80211_a_control a_ctrl;
+} __packed __aligned(2);
+
+/* WLAN_EID_BSS_COEX_2040 =3D 72 */
+/* 802.11n 7.3.2.61 */
+struct ieee80211_bss_coex_20_40_ie {
+       u8 element_id;
+       u8 len;
+       u8 info_req : 1;
+       /* Inter-BSS set 1 when prohibits a receiving BSS from operating as=
 a 20/40 Mhz BSS */
+       u8 intolerant40 : 1;
+       /* Intra-BSS set 1 when prohibits a receiving AP from operating its=
 BSS as a 20/40MHz BSS */
+       u8 bss20_width_req : 1;
+       u8 obss_scan_exemp_req : 1;
+       u8 obss_scan_exemp_grant : 1;
+       u8 rsv : 3;
+} __packed;
+
+/* WLAN_EID_BSS_INTOLERANT_CHL_REPORT =3D 73 */
+/*802.11n 7.3.2.59 */
+struct ieee80211_bss_intolerant_chl_report_ie {
+       u8 element_id;
+       u8 len;
+       u8 regulatory_class;
+       u8 ch_list[0];
+} __packed;
+
+enum ieee80211_twt_setup_command {
+       IEEE80211_TWT_SETUP_COMMAND_REQUEST =3D 0,
+       IEEE80211_TWT_SETUP_COMMAND_SUGGEST =3D 1,
+       IEEE80211_TWT_SETUP_COMMAND_DEMAND =3D 2,
+       IEEE80211_TWT_SETUP_COMMAND_GROUPING =3D 3,
+       IEEE80211_TWT_SETUP_COMMAND_ACCEPT =3D 4,
+       IEEE80211_TWT_SETUP_COMMAND_ALTERNATE =3D 5,
+       IEEE80211_TWT_SETUP_COMMAND_DICTATE =3D 6,
+       IEEE80211_TWT_SETUP_COMMAND_REJECT =3D 7
+};
+
+union ieee80211_twt_control_field {
+       struct {
+               u8 ndp_paging_indicator:1,
+                  responder_pm_mode:1,
+                  negotiation_type:2,
+                  twt_info_frame_disabled:1,
+                  wake_duration_unit:1, /* 0 - 256us, 1 - 1024us */
+                  reserved:2;
+       } __packed fields;
+       u8 value;
+} __packed;
+
+struct ieee80211_twt_individual_elem {
+       union ieee80211_twt_control_field control;
+       union {
+               struct {
+                       u16 request               :1,
+                           setup_cmd             :3,
+                           trigger               :1,
+                           implicit              :1,
+                           flow_type             :1,
+                           flow_id               :3,
+                           wake_interval_exponent:5,
+                           protection            :1;
+               } __packed fields;
+               u16 value;
+       } req_type;
+       u64 target_wake_time;
+       u8 min_wake_duration;
+       u16 wake_interval_mantissa;
+       u8 channel;
+} __packed;
+
+struct ieee80211_twt_broadcast_elem {
+       union ieee80211_twt_control_field control;
+       union {
+               struct {
+                       u16 request                 :1,
+                           setup_cmd               :3,
+                           trigger                 :1,
+                           last_broadcast_param_set:1,
+                           flow_type               :1,
+                           recommendation          :3,
+                           wake_interval_exponent  :5,
+                           reserved                :1;
+               } __packed fields;
+               u16 value;
+       } req_type;
+       u16 target_wake_time;
+       u8 min_wake_duration;
+       u16 wake_interval_mantissa;
+       union {
+               struct {
+                       u16 reserved   :3,
+                           id         :5,
+                           persistence:8;
+               } __packed fields;
+               u16 value;
+       } broadcast_twt_info;
+} __packed;
+
+/* Union options that are not included in 'struct ieee80211_mgmt' */
+struct cl_ieee80211_mgmt {
+       __le16 frame_control;
+       __le16 duration;
+       u8 da[ETH_ALEN];
+       u8 sa[ETH_ALEN];
+       u8 bssid[ETH_ALEN];
+       __le16 seq_ctrl;
+       union {
+               struct {
+                       __le16 auth_alg;
+                       __le16 auth_transaction;
+                       __le16 status_code;
+                       /* Possibly followed by Challenge text */
+                       u8 variable[0];
+               } __packed auth;
+               struct {
+                       __le16 reason_code;
+               } __packed deauth;
+               struct {
+                       __le16 capab_info;
+                       __le16 listen_interval;
+                       /* Followed by SSID and Supported rates */
+                       u8 variable[0];
+               } __packed assoc_req;
+               struct {
+                       __le16 capab_info;
+                       __le16 status_code;
+                       __le16 aid;
+                       /* Followed by Supported rates */
+                       u8 variable[0];
+               } __packed assoc_resp, reassoc_resp;
+               struct {
+                       __le16 capab_info;
+                       __le16 listen_interval;
+                       u8 current_ap[ETH_ALEN];
+                       /* Followed by SSID and Supported rates */
+                       u8 variable[0];
+               } __packed reassoc_req;
+               struct {
+                       __le16 reason_code;
+               } __packed disassoc;
+               struct {
+                       __le64 timestamp;
+                       __le16 beacon_int;
+                       __le16 capab_info;
+                       /*
+                        * Followed by some of SSID, Supported rates,
+                        * FH Params, DS Params, CF Params, IBSS Params, TI=
M
+                        */
+                       u8 variable[0];
+               } __packed beacon;
+               struct {
+                       /* Only variable items: SSID, Supported rates */
+                       u8 variable[0];
+               } __packed probe_req;
+               struct {
+                       __le64 timestamp;
+                       __le16 beacon_int;
+                       __le16 capab_info;
+                       /*
+                        * Followed by some of SSID, Supported rates,
+                        * FH Params, DS Params, CF Params, IBSS Params
+                        */
+                       u8 variable[0];
+               } __packed probe_resp;
+               struct {
+                       u8 category;
+                       union {
+                               struct {
+                                       u8 action_code;
+                                       struct ieee80211_bss_coex_20_40_ie =
bss_coex_20_40_ie;
+                                       /*
+                                        * This IE May appear zero or more =
times,
+                                        * that situation wasn't handled he=
re.
+                                        */
+                                       struct ieee80211_bss_intolerant_chl=
_report_ie
+                                               bss_intolerant_chl_report_i=
e;
+                               } __packed coex_2040_mgmt;
+                               struct {
+                                       u8 action_code;
+                                       u8 dialog_token;
+                                       u8 twt_elem_id;
+                                       u8 twt_elem_length;
+                                       struct ieee80211_twt_individual_ele=
m twt_elem;
+                               } __packed twt_individual_setup;
+                               struct {
+                                       u8 action_code;
+                                       u8 dialog_token;
+                                       u8 twt_elem_id;
+                                       u8 twt_elem_length;
+                                       struct ieee80211_twt_broadcast_elem=
 twt_elem;
+                               } __packed twt_broadcast_setup;
+                               struct {
+                                       u8 action_code;
+                                       /*
+                                        * reserved bits can be combined wi=
th flow_id to
+                                        * form broadcast TWT id of 5 bits =
in case that
+                                        * negotiation_type =3D 3
+                                        */
+                                       u8 flow_id :3,
+                                          reserved:2,
+                                          negotiation_type:2,
+                                          teardown_all_twt:1;
+                               } __packed twt_individual_teardown;
+                               struct {
+                                       u8 action_code;
+                                       u8 flow_id:3,
+                                          response_requested:1,
+                                          next_twt_request:1,
+                                          next_twt_subfield_size:2,
+                                          all_twt:1;
+                                       u8 next_twt[64];
+                               } __packed twt_information;
+                       } u;
+               } __packed action;
+       } u;
+} __packed __aligned(2);
+
+/*
+ * Information Element IDs
+ * Should be part of 'enum ieee80211_eid'
+ */
+#define WLAN_EID_TWT 216
+
+/*
+ * Action category code
+ * Should be part of 'enum ieee80211_category'
+ */
+#define WLAN_CATEGORY_UNPROTECTED_S1G 22
+#define WLAN_CATEGORY_S1G 23
+
+enum ieee80211_unprotected_s1g_actioncode {
+       WLAN_UNPROT_S1G_ACTION_AID_SWITCH_REQUEST =3D 0,
+       WLAN_UNPROT_S1G_ACTION_AID_SWITCH_RESPONSE =3D 1,
+       WLAN_UNPROT_S1G_ACTION_SYNC_CONTROL =3D 2,
+       WLAN_UNPROT_S1G_ACTION_STA_INFO_ANNOUNCEMENT =3D 3,
+       WLAN_UNPROT_S1G_ACTION_EDCA_PARAMETER_SET =3D 4,
+       WLAN_UNPROT_S1G_ACTION_EL_OPERATION =3D 5,
+       WLAN_UNPROT_S1G_ACTION_TWT_SETUP =3D 6,
+       WLAN_UNPROT_S1G_ACTION_TWT_TEARDOWN =3D 7,
+       WLAN_UNPROT_S1G_ACTION_SECTORIZED_GROUP_ID_LIST =3D 8,
+       WLAN_UNPROT_S1G_ACTION_SECTOR_ID_FEEDBACK =3D 9,
+       WLAN_UNPROT_S1G_ACTION_RESERVED =3D 10,
+       WLAN_UNPROT_S1G_ACTION_TWT_INFORMATION =3D 11,
+};
+
+/*
+ * Extended Channel Switching capability to be set in the 1st byte of
+ * the @WLAN_EID_EXT_CAPABILITY information element
+ */
+#define WLAN_EXT_CAPA1_2040_BSS_COEX_MGMT_ENABLED BIT(0)
+#define WLAN_EXT_CAPA11_COMPLETE_LIST_OF_NONTXBSSID_PROFILES BIT(0)
+
+#endif /* CL_MAC80211_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

