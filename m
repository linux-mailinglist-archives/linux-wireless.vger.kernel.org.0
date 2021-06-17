Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D667C3AB8FA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhFQQLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:41 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:35227
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230390AbhFQQKT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBeOE5QXgLUBDINlU/QPXi5kuoFMFNIutIhYEsKA0FkJErFY/CUu+NVZb2uK3bULFWcPTsmWtSXETkbHc5Gn6mv+7tgwxyqM7SRz3Ea/Mh5KyJKiLXAEBET4WnPIGu6vkUzeJjQreSg89QbzxVEVyfpHq6b+exo0s78vtkxCOY2chP/KP09l69TBX+pXDKsj/jVowm23y6Xo4e4NE+DXx4uiod5eN53l7PS5GliT9+vxdFQo9z7ulBJc/yxxSheuKLME4jp7QlmC/cZBbbmt/5z5CA8kkt/vwXeCZ7yIuUFZIYN/obuOQSLF3Gy/CRK3dKIR9/txST9hcAwK8U+Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOM1dpDsgSjyPthsnlO524aS3J7dmt+xjHz99N7urvk=;
 b=MRszM4/m56fsqa3/LwDcaH1RsU+fadI169Iry0RTgzfa7jiCBAS2PPzuYrYfza2+GjubrDkJhoYo5p61pkuAVqoEylzAL7uZ68BIB2A+13LUGWlSIDrj4W7bWn6HYE4YjdIfHXtctpT/2QAn5nJckFLk8Q7kr5SgN8Rpof6132W46YftpwJOBR4cjgpoaCfxivlaRHktdPaRMkx49K89V2srizsU7ODoNcw0SIafBWexlG5g4jUKwePPdArHZmzYq9lqMpb3luIUKarxBbpodbfnW1j8xIDBnxMjPGnyp0l0BVPdk5Nm6lbTMicUmbH9FtD5fuC1xu32wSZ3tZhR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOM1dpDsgSjyPthsnlO524aS3J7dmt+xjHz99N7urvk=;
 b=l5ozBXT+CRGZqAS0nxdhw49059zOXxFAZnUmnEtCoV9RvdjYb5yl65egwVVfYDTtWMkfSdC6c8SiY81mmgx0yOYDibFatcRvjf9kReobiiYAEXslDo/MJYXrUEgb3Y/A8qSwrdKXriFNjrzImMnbNVaGlS35e6pEJVmPVulRO9M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:15 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:15 +0000
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
Subject: [RFC v1 198/256] cl8k: add twt_frame.c
Date:   Thu, 17 Jun 2021 16:01:25 +0000
Message-Id: <20210617160223.160998-199-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf26cb1-434e-488b-69df-08d931a9d46b
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10751459F93FF292FFCB5D65F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8cUhXz07a4tiN8bk+GbtMzOjlK/MR0SAuh1EhPoELU0hljyT22Sa1EgKqesASuNiS0pr7McoHTlxPgtanGLJxoBxcyuES396o2MGnS5bmQdDpkzcCdP8RS4lRG0pcqAQzXrxKcYXRGjZKSh6ErFj9YiUVUr/5im/iA6cG7whkTSd86fpHGRTxWlSHSs1dLwxHnlRXEjjAi6D3xEzTGhKt7PYjxaVl8NIS3IANTQCTSKpqhQFPoGFp1Qmz9qNhH4LM1NDS3RPSGeteDsou2cKlCEpbojMy7qCVd4k+Z8N94ew4vaEEVTKp6do4q3NvXTWJ+RVU2/rORidWABsD8Zvo1QY1pWXsaSSaG/qiUjJnJomDhs/iJO13reX9sRRAl294lhdbAtnrc8sBdmRB6rLaTBKCFIi1RqMQ/4W2FPB6Mhw8cCobpmIYSyKQp2R6JZk3CszmO9Spw58YkG2FY4n5Jqd8jmuOJBKT9nlnc+RZUSYbgA8HTFDPuHMu6EWer9cCOmBtfwFMAtUPKJaw23alLckr+b898AXeX7P2bu/s563iRkMGBuhamEtglghAy0nXKi0vYKkzUGE6wWaqkGZH66aElFCUoQS9I6K6Mu8EUyAn+6dETQf9seufjt7gvYCjNj2oWFJhKwPY40uhNQa2nzGSNtA+As7TNn3ENa2b/uhMgROvc5vnBw7ctVmG0vCaW1w1mk3WZz1PzRUjT6Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(30864003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOB4zBvHQ/jqFr2UPE/ZBYu0dnT15khbTaO3RgGx4Bv+6kLU1N0vCLAxd7Xe?=
 =?us-ascii?Q?B83ezU8BwYZMHSYOTAPpaXCXWKawljpFnjQzAl2ROBC3fIUyJXkmvU4qxjg2?=
 =?us-ascii?Q?wombmQ24x8lrsrB0Dvl+IkN9Hz45wYXgh2AD4nbBt5h1DDg4S5lWfJ8YBbIw?=
 =?us-ascii?Q?M1KjHAzWzqK1PxmwghyU+ZB/6GfnKQfps430F6n0vNxrcMgZAoGcUDrCuSO7?=
 =?us-ascii?Q?5fjtIuu4zW0z6LhpheaJ8lQR8peQGzEHASsznxqkmNAKakpNUl+UK/VOGJv2?=
 =?us-ascii?Q?ZzIskGRgF2vcIMt4R58Q4/G1M++By+zpGaUNcexoPQ4VmW907tcQulW0GTfN?=
 =?us-ascii?Q?lAGrc1R5H69oj23pV80jvhVDJp0aUWq67MgtXapeNuhaIU0OPbLPMkiKd0Zg?=
 =?us-ascii?Q?9TuzWFiHa6LPvI1j1zXZB7CkusYv88/oRGhcrUgUmnswCXR0AOwrb7wVZMJk?=
 =?us-ascii?Q?aAQu5UWcsRz10lR/aqz4dPYzch7UTOe8BYZEk1zCTO/Dp7woEorkOKBZizUY?=
 =?us-ascii?Q?M2EVfhoH+UrHFJ578p3bdkMSIm7A8t9Rbv6UXiB71KM/rzeTCpKuHJ7k4Lo1?=
 =?us-ascii?Q?1BDe+9sFaQ3XEc/uyir+i5+q3M6S3FbsCItRyoSS0ufOLBwh91MQ2WgwVT05?=
 =?us-ascii?Q?yfMsV31ORjaOZIPI4Z/qHrFPRRC3O+pf5TIPu02SXdxNuHCFNST/A+ZRKqSa?=
 =?us-ascii?Q?WOVsi409EWgO0BFIU6DnNSxprCi7nMqS0tsOmhMxjqujnVOjxjZgf5/ce2+p?=
 =?us-ascii?Q?uUT1/Mqlal+yjq1BSJ9ezlPhgtshQrfuhdB2rHTnrq2NTtDnPSpN8RR/LOdL?=
 =?us-ascii?Q?DCdQDhr+MMBP+RUt/o5yExrsyfmx4zHCjtxtWnW59WA8xOJSJbroH/V55eEi?=
 =?us-ascii?Q?NJtVt9VCRw0bdMTIk220jx/UMmbLNuF2chwfu0l6pY0c9jCNm5NYyGDiuq8l?=
 =?us-ascii?Q?1UjhgjqzVgSutmz6DU0WaBI1QPgXkfCv7cYunIXZyzwPQ+8mqRzyDAQh+EhL?=
 =?us-ascii?Q?Uq1OdH9mKT6cY3sIR0h0ilfn66opmbjeA2GQ/q8m7Z9XDDcHlehneEqRqs5a?=
 =?us-ascii?Q?1VQtQ8QlYXI89g9Pu3ti5k0GwUmZJSaFXM3/nc1UDNgBcoDaNYGza96AJIsn?=
 =?us-ascii?Q?NKAVHFQKsx+Ps+04TH1+axamvyJsmUvGgbLJLu2RKlcIvYPpyKQyYDhiKNuC?=
 =?us-ascii?Q?Go6IG0HGTpM8bJC5ZYtqj0tST/heXmCuUZE/6ovPM8+8LQGMvD1xS7C7qvCv?=
 =?us-ascii?Q?RZ7sBKPJjlww/S8WTYi/naaEXBPva/FE1oaYFU6c51+Bv2SUxPJif5WRLxks?=
 =?us-ascii?Q?dRQxLqfqmKWUY/e+ikuhCuo0?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf26cb1-434e-488b-69df-08d931a9d46b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:13.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGdLAla5xxe55OkxAOPgj7Prbxsxb3Jc4Zo8fgZnRP852+F04VNO0vCQlrf4gQQ8zxDs7coLxG0DEeDdBGWvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt_frame.c | 385 +++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_frame.c

diff --git a/drivers/net/wireless/celeno/cl8k/twt_frame.c b/drivers/net/wir=
eless/celeno/cl8k/twt_frame.c
new file mode 100644
index 000000000000..52373e8e950e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt_frame.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "twt_frame.h"
+#include "twt.h"
+#include "sta.h"
+#include "mac_addr.h"
+#include "tx/tx.h"
+
+static int cl_twt_frame_build_individual_setup(struct cl_hw *cl_hw,
+                                              struct sk_buff **skb_ptr,
+                                              struct cl_sta *cl_sta)
+{
+       struct ieee80211_sub_if_data *sdata =3D cl_sta->stainfo->sdata;
+       struct sk_buff *skb;
+       struct cl_ieee80211_mgmt *mgmt;
+       int hdr_len =3D offsetof(struct cl_ieee80211_mgmt, u.action.u.twt_i=
ndividual_setup) +
+               sizeof(mgmt->u.action.u.twt_individual_setup);
+       u8 *bssid;
+
+       skb =3D dev_alloc_skb(cl_hw->hw->extra_tx_headroom + hdr_len);
+
+       if (!skb)
+               return -ENOMEM;
+
+       if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION)
+               bssid =3D sdata->u.mgd.bssid;
+       else
+               bssid =3D sdata->vif.addr;
+
+       skb_reserve(skb, cl_hw->hw->extra_tx_headroom);
+       mgmt =3D (struct cl_ieee80211_mgmt *)skb_put_zero(skb, hdr_len);
+       cl_mac_addr_copy(mgmt->sa, sdata->vif.addr);
+       cl_mac_addr_copy(mgmt->da, cl_sta->addr);
+       cl_mac_addr_copy(mgmt->bssid, bssid);
+       mgmt->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT |
+                                         IEEE80211_STYPE_ACTION);
+
+       mgmt->u.action.category =3D WLAN_CATEGORY_UNPROTECTED_S1G;
+       mgmt->u.action.u.twt_individual_setup.action_code =3D WLAN_UNPROT_S=
1G_ACTION_TWT_SETUP;
+       mgmt->u.action.u.twt_individual_setup.dialog_token =3D cl_hw->twt_d=
b.dialog_token++;
+
+       mgmt->u.action.u.twt_individual_setup.twt_elem_id =3D WLAN_EID_TWT;
+       mgmt->u.action.u.twt_individual_setup.twt_elem_length =3D
+               sizeof(struct ieee80211_twt_individual_elem);
+
+       *skb_ptr =3D skb;
+       return 0;
+}
+
+static int cl_twt_frame_build_individual_teardown(struct cl_hw *cl_hw,
+                                                 struct sk_buff **skb_ptr,
+                                                 struct cl_sta *cl_sta,
+                                                 u8 flow_id)
+{
+       struct ieee80211_sub_if_data *sdata =3D cl_sta->stainfo->sdata;
+       struct sk_buff *skb;
+       struct cl_ieee80211_mgmt *mgmt;
+       int hdr_len =3D offsetof(struct cl_ieee80211_mgmt, u.action.u.twt_i=
ndividual_teardown) +
+               sizeof(mgmt->u.action.u.twt_individual_teardown);
+       u8 *bssid;
+
+       skb =3D dev_alloc_skb(cl_hw->hw->extra_tx_headroom + hdr_len);
+
+       if (!skb)
+               return -ENOMEM;
+
+       if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION)
+               bssid =3D sdata->u.mgd.bssid;
+       else
+               bssid =3D sdata->vif.addr;
+
+       skb_reserve(skb, cl_hw->hw->extra_tx_headroom);
+       mgmt =3D (struct cl_ieee80211_mgmt *)skb_put_zero(skb, hdr_len);
+       cl_mac_addr_copy(mgmt->sa, sdata->vif.addr);
+       cl_mac_addr_copy(mgmt->da, cl_sta->addr);
+       cl_mac_addr_copy(mgmt->bssid, bssid);
+       mgmt->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT |
+                                         IEEE80211_STYPE_ACTION);
+
+       mgmt->u.action.category =3D WLAN_CATEGORY_UNPROTECTED_S1G;
+       mgmt->u.action.u.twt_individual_teardown.action_code =3D WLAN_UNPRO=
T_S1G_ACTION_TWT_TEARDOWN;
+       mgmt->u.action.u.twt_individual_teardown.negotiation_type =3D 0;
+
+       if (flow_id =3D=3D CL_TWT_FLOW_ID_ALL) {
+               mgmt->u.action.u.twt_individual_teardown.teardown_all_twt =
=3D 1;
+               mgmt->u.action.u.twt_individual_teardown.flow_id =3D 0;
+       } else {
+               mgmt->u.action.u.twt_individual_teardown.teardown_all_twt =
=3D 0;
+               mgmt->u.action.u.twt_individual_teardown.flow_id =3D flow_i=
d;
+       }
+
+       *skb_ptr =3D skb;
+       return 0;
+}
+
+static void
+cl_twt_frame_fill_setup_response_parameters(struct cl_hw *cl_hw,
+                                           struct ieee80211_twt_individual=
_elem *request_ie,
+                                           struct cl_ieee80211_mgmt *mgmt)
+{
+       struct ieee80211_twt_individual_elem *twt_elem =3D
+               &mgmt->u.action.u.twt_individual_setup.twt_elem;
+       u64 interval;
+       u32 default_interval =3D cl_hw->conf->ce_twt_default_interval;
+       u32 default_min_wake_duration =3D cl_hw->conf->ce_twt_default_min_w=
ake_duration;
+
+       /* Copy TWT element parameters from the request */
+       *twt_elem =3D *request_ie;
+
+       /* Override the relevant parameters */
+       twt_elem->req_type.fields.request =3D 0;
+       twt_elem->control.fields.negotiation_type =3D 0;
+       twt_elem->req_type.fields.setup_cmd =3D IEEE80211_TWT_SETUP_COMMAND=
_ACCEPT;
+       twt_elem->req_type.fields.protection =3D 0;
+       twt_elem->channel =3D 0;
+
+       /*
+        * Set default values of wake interval exponent/mantissa and min
+        * wake duration in case that at least one of them equals to 0
+        */
+       interval =3D cl_twt_get_wake_interval_us(twt_elem);
+
+       if (!twt_elem->min_wake_duration) {
+               if (default_min_wake_duration < interval) {
+                       cl_twt_set_min_wake_duration(cl_hw, twt_elem, defau=
lt_min_wake_duration);
+               } else if (interval) {
+                       /* If default min wake time > interval - set it to =
half of the interval */
+                       cl_twt_set_min_wake_duration(cl_hw, twt_elem, (inte=
rval >> 1));
+               } else {
+                       /* Set default interval and min wake duration */
+                       cl_twt_set_interval(cl_hw, twt_elem, default_interv=
al);
+                       cl_twt_set_min_wake_duration(cl_hw, twt_elem, defau=
lt_min_wake_duration);
+               }
+       } else if (!interval) {
+               u32 min_wake_duration =3D cl_twt_get_min_wake_time_us(twt_e=
lem);
+
+               if (min_wake_duration < default_interval)
+                       cl_twt_set_interval(cl_hw, twt_elem, default_interv=
al);
+               else
+                       /*
+                        * If the default interval < min wake duration -
+                        * set it to be double the min wake duration
+                        */
+                       cl_twt_set_interval(cl_hw, twt_elem, (min_wake_dura=
tion << 1));
+       }
+
+       cl_twt_set_target_wake_time(cl_hw, twt_elem);
+}
+
+static void cl_twt_frmae_fill_setup_request_parameters(struct cl_hw *cl_hw=
,
+                                                      struct cl_ieee80211_=
mgmt *mgmt,
+                                                      enum ieee80211_twt_s=
etup_command setup_cmd,
+                                                      u8 flow_id,
+                                                      bool announced,
+                                                      bool triggered,
+                                                      u64 interval_us,
+                                                      u32 min_wake_duratio=
n_us)
+{
+       struct ieee80211_twt_individual_elem *twt_elem =3D
+               &mgmt->u.action.u.twt_individual_setup.twt_elem;
+       u64 _interval_us =3D interval_us;
+       u32 _min_wake_duration_us =3D min_wake_duration_us;
+
+       /* Override the relevant parameters */
+
+       twt_elem->control.fields.negotiation_type =3D 0;
+       twt_elem->req_type.fields.protection =3D 0;
+       twt_elem->channel =3D 0;
+       twt_elem->req_type.fields.request =3D 1;
+       twt_elem->req_type.fields.implicit =3D 1;
+       twt_elem->req_type.fields.setup_cmd =3D setup_cmd;
+       twt_elem->req_type.fields.flow_id =3D flow_id;
+       twt_elem->req_type.fields.flow_type =3D !announced;
+       twt_elem->req_type.fields.trigger =3D triggered;
+
+       if (!interval_us)
+               _interval_us =3D cl_hw->conf->ce_twt_default_interval;
+
+       if (!min_wake_duration_us)
+               _min_wake_duration_us =3D cl_hw->conf->ce_twt_default_min_w=
ake_duration;
+
+       if (_min_wake_duration_us < _interval_us) {
+               /* Min wake duration < interval */
+               cl_twt_set_interval(cl_hw, twt_elem, _interval_us);
+               cl_twt_set_min_wake_duration(cl_hw, twt_elem, _min_wake_dur=
ation_us);
+       } else {
+               if (!interval_us) {
+                       /*
+                        * Min wake duration argument >=3D default interval=
 =3D>
+                        * Set the interval to be double the min wake durat=
ion
+                        */
+                       cl_twt_set_min_wake_duration(cl_hw, twt_elem, _min_=
wake_duration_us);
+                       cl_twt_set_interval(cl_hw, twt_elem, (_min_wake_dur=
ation_us << 1));
+               } else {
+                       /*
+                        * Interval argument <=3D default min wake duration=
 =3D>
+                        * Set the min wake duration to be half the interva=
l
+                        */
+                       cl_twt_set_interval(cl_hw, twt_elem, _interval_us);
+                       cl_twt_set_min_wake_duration(cl_hw, twt_elem, (_int=
erval_us >> 1));
+               }
+       }
+}
+
+bool cl_twt_frame_is_individual_setup_request_valid(struct cl_hw *cl_hw,
+                                                   struct cl_ieee80211_mgm=
t *request)
+{
+       u8 twt_elem_len =3D request->u.action.u.twt_individual_setup.twt_el=
em_length;
+       struct ieee80211_twt_individual_elem *twt_elem =3D
+               &request->u.action.u.twt_individual_setup.twt_elem;
+       u64 wake_interval_us;
+       u32 min_wake_time_us;
+
+       if (twt_elem_len !=3D sizeof(struct ieee80211_twt_individual_elem))=
 {
+               cl_dbg_err(cl_hw, "Illegal size of twt individual element %=
u (should be %zu)\n",
+                          twt_elem_len, sizeof(struct ieee80211_twt_indivi=
dual_elem));
+               return false;
+       }
+
+       wake_interval_us =3D cl_twt_get_wake_interval_us(twt_elem);
+       min_wake_time_us =3D cl_twt_get_min_wake_time_us(twt_elem);
+
+       if (min_wake_time_us && wake_interval_us && min_wake_time_us > wake=
_interval_us) {
+               cl_dbg_err(cl_hw, "min wake duration (%u) > wake interval (=
%llu)!\n",
+                          min_wake_time_us, wake_interval_us);
+               return false;
+       }
+
+       return true;
+}
+
+int cl_twt_frame_send_individual_setup_response(struct cl_hw *cl_hw,
+                                               struct cl_sta *cl_sta,
+                                               struct cl_ieee80211_mgmt *r=
equest,
+                                               struct cl_twt_session_db **=
session)
+{
+       struct sk_buff *skb;
+       struct cl_ieee80211_mgmt *mgmt;
+       struct ieee80211_twt_individual_elem *req_twt_elem;
+       struct ieee80211_twt_individual_elem *res_twt_elem;
+       u8 flow_id;
+
+       if (cl_twt_frame_build_individual_setup(cl_hw, &skb, cl_sta)) {
+               cl_dbg_err(cl_hw, "Build of TWT individual setup request fa=
iled!\n");
+               return -1;
+       }
+
+       req_twt_elem =3D &request->u.action.u.twt_individual_setup.twt_elem=
;
+       mgmt =3D (struct cl_ieee80211_mgmt *)skb->data;
+       cl_twt_frame_fill_setup_response_parameters(cl_hw, req_twt_elem, mg=
mt);
+       flow_id =3D req_twt_elem->req_type.fields.flow_id;
+       res_twt_elem =3D &mgmt->u.action.u.twt_individual_setup.twt_elem;
+
+       /* Check if a session with the same sta_idx and flow_id already exi=
sts */
+       *session =3D cl_twt_get_session(cl_hw, cl_sta, flow_id);
+
+       /*
+        * If the seesion already exists - update it.
+        * Otherwise add a new TWT session to the db.
+        */
+       if (*session) {
+               cl_dbg_info(cl_hw, "Updating an existing TWT session sta_id=
x %u, flow_id %u\n",
+                           cl_sta->sta_idx, flow_id);
+               cl_twt_update_session(cl_hw, cl_sta, res_twt_elem, *session=
);
+       } else if (cl_twt_add_session(cl_hw, cl_sta, res_twt_elem, session)=
) {
+               cl_dbg_err(cl_hw, "Session for sta %u could not be added. A=
borting\n",
+                          cl_sta->sta_idx);
+               dev_kfree_skb_any(skb);
+               goto error;
+       } else {
+               cl_dbg_info(cl_hw, "A new TWT session was added. sta_idx %u=
, flow_id %u\n",
+                           cl_sta->sta_idx, flow_id);
+       }
+
+       /* Send the TWT response */
+       ieee80211_tx_prepare_skb(cl_hw->hw, cl_sta->cl_vif->vif, skb, cl_hw=
->nl_band, NULL);
+       cl_tx_single(cl_hw, cl_sta, skb, false, true);
+       cl_dbg_trace(cl_hw, "TWT individual setup response sent to STA %u\n=
", cl_sta->sta_idx);
+
+       return 0;
+ error:
+       return -1;
+}
+
+int cl_twt_frame_send_individual_setup_request(struct cl_hw *cl_hw,
+                                              struct cl_sta *cl_sta,
+                                              enum ieee80211_twt_setup_com=
mand setup_cmd,
+                                              u8 flow_id,
+                                              bool announced,
+                                              bool triggered,
+                                              u64 interval_us,
+                                              u32 min_wake_duration_us)
+{
+       /* Send a TWT individual setup request (should be used in STA mode)=
 */
+       struct sk_buff *skb;
+
+       if (cl_twt_frame_build_individual_setup(cl_hw, &skb, cl_sta)) {
+               cl_dbg_err(cl_hw, "Build of TWT individual setup request fa=
iled!\n");
+               return -1;
+       }
+
+       cl_twt_frmae_fill_setup_request_parameters(cl_hw, (struct cl_ieee80=
211_mgmt *)skb->data,
+                                                  setup_cmd, flow_id, anno=
unced, triggered,
+                                                  interval_us, min_wake_du=
ration_us);
+
+       /* Send the TWT request */
+       ieee80211_tx_prepare_skb(cl_hw->hw, cl_sta->cl_vif->vif, skb, cl_hw=
->nl_band, NULL);
+       cl_tx_single(cl_hw, cl_sta, skb, false, true);
+       cl_dbg_trace(cl_hw, "TWT individual setup request sent\n");
+
+       return 0;
+}
+
+int cl_twt_frame_simulate_individual_setup_request(struct cl_hw *cl_hw,
+                                                  struct cl_sta *cl_sta,
+                                                  enum ieee80211_twt_setup=
_command setup_cmd,
+                                                  u8 flow_id,
+                                                  bool announced,
+                                                  bool triggered,
+                                                  u64 interval_us,
+                                                  u32 min_wake_duration_us=
)
+{
+       /* Simulates a TWT individual setup request in STA mode */
+       struct sk_buff *skb;
+       struct cl_ieee80211_mgmt *mgmt;
+
+       if (cl_twt_frame_build_individual_setup(cl_hw, &skb, cl_sta)) {
+               cl_dbg_err(cl_hw, "Build of TWT individual setup request fa=
iled!\n");
+               return -1;
+       }
+
+       mgmt =3D (struct cl_ieee80211_mgmt *)skb->data;
+
+       cl_twt_frmae_fill_setup_request_parameters(cl_hw, mgmt, setup_cmd,
+                                                  flow_id, announced, trig=
gered,
+                                                  interval_us, min_wake_du=
ration_us);
+       cl_dbg_trace(cl_hw, "TWT individual setup request simulated\n");
+       cl_twt_handle_individual_setup_request(cl_hw, cl_sta, mgmt);
+
+       dev_kfree_skb_any(skb);
+       return 0;
+}
+
+int cl_twt_frame_send_individual_teardown_request(struct cl_hw *cl_hw,
+                                                 struct cl_sta *cl_sta,
+                                                 u8 flow_id)
+{
+       /* Send a TWT individual teardown request */
+       struct sk_buff *skb;
+
+       if (cl_twt_frame_build_individual_teardown(cl_hw, &skb, cl_sta, flo=
w_id)) {
+               cl_dbg_err(cl_hw, "Build of a TWT individual teardown reque=
st failed!\n");
+               return -1;
+       }
+
+       /* Send the TWT request */
+       ieee80211_tx_prepare_skb(cl_hw->hw, cl_sta->cl_vif->vif, skb, cl_hw=
->nl_band, NULL);
+       cl_tx_single(cl_hw, cl_sta, skb, false, true);
+       cl_dbg_trace(cl_hw, "TWT individual teardown request sent\n");
+
+       return 0;
+}
+
+int cl_twt_frame_simulate_individual_teardown_request(struct cl_hw *cl_hw,
+                                                     struct cl_sta *cl_sta=
,
+                                                     u8 flow_id)
+{
+       /* Simulate a TWT individual teardown request */
+       struct sk_buff *skb;
+       struct cl_ieee80211_mgmt *mgmt;
+
+       if (cl_twt_frame_build_individual_teardown(cl_hw, &skb, cl_sta, flo=
w_id)) {
+               cl_dbg_err(cl_hw, "Build of TWT individual teardown request=
 failed!\n");
+               return -1;
+       }
+
+       mgmt =3D (struct cl_ieee80211_mgmt *)skb->data;
+
+       cl_dbg_trace(cl_hw, "TWT individual teardown request simulated\n");
+       cl_twt_handle_individual_teardown_request(cl_hw, cl_sta, mgmt);
+
+       dev_kfree_skb_any(skb);
+       return 0;
+}
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

