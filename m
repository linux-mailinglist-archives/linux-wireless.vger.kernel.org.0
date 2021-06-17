Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54D3AB89D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhFQQJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:21 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233662AbhFQQII (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHdDPzIbPcrgmZ9Aq2uXAOeKZE9ES5oBu6OdLkTc6JJAVOT5EGKFVXb5DFwo1PsSRGWeMpsUBfBzd0Y+HHezLqlsAPkSY9ycfL/u3wLEKOt3J2Wvig+fMUaSuz2fJZLb+Xv93/qVA41uimh2WDd0wLL9UxpxqnVU4PVu3sHob/gMX6AV/aevYIcZfKj22B6yJ7HbhhhSz4+99UsG02aekYJ3pl6UaFhpwSGOql9EftC/ryf6oFbuQOsGVRgEbAPsh8tAjr+ShUn4nwxNIz7RrSgCqXnG/Jeb0HrcfZ4CpA2MzDjp3xuBX2Tlw+tMD7Tog2U5LqPi9jpXINULckRr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkDnfh/60p7Hz7HOuzDd+HdM6y+UbLo4Enc2u6BTNn0=;
 b=R98vx6BaFmbpnaQ5JKpmV0CfOlPjTdLJYEfTlXLU4FSsWi5x7uJITVk0vo7YM9Hwqbd6/+XNX76cSRNror/nmtrb156mgFaUMS1iagk2Yz3GcYHQWrSPivHQxJgv3fJnKVFahIecZo9hzWCVQwCFbTJco0Ppo73yXXWrUpCFt7eYRVfEw9ZgXpZ2NeIsn8wLmzWCwSzRvKbFtKRH8gTOqf7KMfl6w/s/vFmVbiOVLUcGejB0/tPKQfgkpl+HOi1msAFAZ5lw2YI2bMstCARwDMt0mIQO5Wqyr9tvIimp2qMvljaBHLDmNs8dYNv9f7eoD7Nd6JMgtgtQkDgPQj/hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkDnfh/60p7Hz7HOuzDd+HdM6y+UbLo4Enc2u6BTNn0=;
 b=AUF86F4j1TjiyM03gEAYW2jnkWbRHCBFAGnNTX1IINAmzZIcY5DBsXtjR8Mh7kEzR+Fd+9vmlyn9a/aV1f5QC6IcfMm4WaUIoRbVyiLitDFBAoexiFEal1dJJl27BJspAxdMsU7ZNZUJu3AFoBn3Uv9HquC9x0XLfGlu9gRZw8o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:44 +0000
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
Subject: [RFC v1 124/256] cl8k: add ops.h
Date:   Thu, 17 Jun 2021 16:00:11 +0000
Message-Id: <20210617160223.160998-125-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16a6c21d-1104-4644-872a-08d931a9a329
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314533645366E954A3EA65FF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q14HuzLLe3dHRIulo3hLbbA8XnqUqUdSz/2zCnIKPACTpcMbC27ZnTDEmUW2QEquRFuKpGQe3xteW2DRoWspBMAHIRXviRUze6/4EzM2TE3vLii66sR168OavPi6Ok8uMiuN8m97ywy/FyGdAakhLflIbBPbNwrv55zPX+A9DV+gl8X9gAs/2ANO2alw5pSV+Bphx0vHvFl8E2rE2fwUzNn0SsSScOUrPqqoUC5lF5+d2t0uthOBYlGEVrTqLdrinBW0PSC7JQG6Aei3Gf5LPw/iI3ALkUmd8MpWS28W5aYe9gDnFbACvL6pBq8sGTzAtz9aOIoX1G4qHLbcgIDYy/+QTg0HgcO0L71o5Ev9sGsgyrgl9n69SRbJh5IKBLYu8rGQqFP8ifC+U21UZzcmihuJMs/PtcEKQxqd7Sz4P+duR9pp4FfrSJDAXrNvuv3FxfZrDeGDE9NUv8N9Hrh8LcD6xXhKMvzIPOfHvyo/r9CsOZ6NAprWIHOE5PaPQ273YJht1TLgXthdJRtUyMKmP65AI6xtINZCcQfVfTfgqsHdIY0tD1fJB4fwb4i0i1QlYfl/KdODaVHZQ0P9CnMuRYuVxwJQ24Hx8mrx8jHWcvRM3izds9A9J9496KoeiN6uS51+0kjiWtma7LGYMuDVRtLR0ozQBfz/xq01vuVdY/QgpUpwYfaN0JCwZiqvXt69u4jgFlpDoLyp+owAxoXfCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGVYlggI2F5+9xf5T7bEledj4boVUNtYvDYi5EEClHvqkjGp8688ap/79FKU?=
 =?us-ascii?Q?a2sQp+U1zL/v7/1m3n3LZf1hU0g+g4PVSvCr55nmeib28hc96EU5ydORWKPJ?=
 =?us-ascii?Q?x5iMNdBXWdnreokKAOiX3OfeCIp3hDP/OsS4G+rbpNOYztNW/1nw/H6Uhh3U?=
 =?us-ascii?Q?rdVEOtMvVpBfT9dAjVPj27K+57gB8lLPGANf6J2s4C8s/qGajuxSn1XVXJnN?=
 =?us-ascii?Q?phryNX9Yt3BuMedG3O4tejmhwNW+LGlx5FUoP4osRgowIsJk88/tAIH7I6Gl?=
 =?us-ascii?Q?Kx6/tn6AzSCLqb4+SPXuTyZkqq5hXPOI/QYBjXLuATnpRA4IH4gVLT6Ws/6B?=
 =?us-ascii?Q?I9+lXUwd0mNPiUv/uQCyUZLaOCK0Cgem3JADP1bT9QBzgioNcwLV6XT1+wvt?=
 =?us-ascii?Q?cW4UbwIkUXHllRm4eU+GWAXAi8XIB0tIF8VXFYYmMhPJ3sZQtdEg8rJQcl27?=
 =?us-ascii?Q?ZPWbrO1GF1fzcv9WMNr1eZK5xcvj25CbhDsoEUjIt+NQ5AZoDLJ3HHG/a2qD?=
 =?us-ascii?Q?WTo89PC2byxHVZYpOCwULCxBBz7gcwsV//9Awl55DkIT6WjsBqlAqHR242cC?=
 =?us-ascii?Q?JmOSMMp3k9vq6I5dslEc1TeLDFh7F4R2oin9zzUa20b1aTGQi3HB1C4Orkjx?=
 =?us-ascii?Q?jgc3GFpfuH84ms2luuDZwgyi8gtSUrMcdTP4r8oqvC1Ig+UIhCFivna5qvxT?=
 =?us-ascii?Q?VfEsv/p4FruQZtGM3Hqm4hH9ZfGMVblCPmOpqlDBXIhTEghnct1l9KH06hR2?=
 =?us-ascii?Q?9fC32AYovIthBipJrI8h0pt98l1G4uNYBLaDcZkA2J0S+qk/OHqQA2MK6zG5?=
 =?us-ascii?Q?zbgLk7frjy5SQ25wfvu/8cAKRTxFn+zYhSrxxwNV5v1tWTrLnf/lNFxxJYr2?=
 =?us-ascii?Q?AVFHpsr86Qg94Ze+kSMqiTw527lDG9rs5GqNKI1eTLzmFE9g/kt5RB7axCDR?=
 =?us-ascii?Q?WY+nNzJDRhk+evfh98mGGIo6/ULjlxmLp7lYRGrkrwUGugZKlASf0MMKa0Zp?=
 =?us-ascii?Q?TGbGz/aPW466SwANxpJ6+U1xAUJY8GUVqqxD2/gBA5OkZfzDPYF0KYGyjDmq?=
 =?us-ascii?Q?olLpx1S0zxUYF88lHeZtUhExm1tkO/RoAXTomir66udYTQ+2dwa7v5WPPxtD?=
 =?us-ascii?Q?qX+UlHTUJVHYrMBGsndPlnAXnsXyAZqGRdpacAEsP14+DQan5Gh5MSZsa7pk?=
 =?us-ascii?Q?9F03J3Yyji2qVBXM4ai0Y1iKH/hE6gaeM+khBSuZgdE56KFwybMfnc6MKRc7?=
 =?us-ascii?Q?vOB0aGCIXR4H27sBsdC048swOpn4O/lWONqDuljPzQ2YooY4maawEJAxAY7c?=
 =?us-ascii?Q?NaRYfvugTrWAdOyoEAvpjsxS?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a6c21d-1104-4644-872a-08d931a9a329
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:50.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MeHRiXItLwaObbqF/qDelC7g61IqJIi9JlviAGYom57WHv65DRi/oTyfE3v+MSYdHvfnMnFfQReYy5Q4C/cUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ops.h | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ops.h

diff --git a/drivers/net/wireless/celeno/cl8k/ops.h b/drivers/net/wireless/=
celeno/cl8k/ops.h
new file mode 100644
index 000000000000..24532f9efacc
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ops.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_OPS_H
+#define CL_OPS_H
+
+#include <net/mac80211.h>
+
+void cl_ops_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *contr=
ol, struct sk_buff *skb);
+int cl_ops_start(struct ieee80211_hw *hw);
+void cl_ops_stop(struct ieee80211_hw *hw);
+int cl_ops_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vi=
f);
+void cl_ops_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif=
 *vif);
+int cl_ops_config(struct ieee80211_hw *hw, u32 changed);
+void cl_ops_bss_info_changed(struct ieee80211_hw *hw,
+                            struct ieee80211_vif *vif,
+                            struct ieee80211_bss_conf *info,
+                            u32 changed);
+int cl_ops_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void cl_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+u64 cl_ops_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_add=
r_list *mc_list);
+void cl_ops_configure_filter(struct ieee80211_hw *hw, u32 changed_flags,
+                            u32 *total_flags, u64 multicast);
+int cl_ops_set_key(struct ieee80211_hw *hw,
+                  enum set_key_cmd cmd,
+                  struct ieee80211_vif *vif,
+                  struct ieee80211_sta *sta,
+                  struct ieee80211_key_conf *key);
+void cl_ops_sw_scan_start(struct ieee80211_hw *hw,
+                         struct ieee80211_vif *vif,
+                         const u8 *mac_addr);
+int cl_ops_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif, s=
truct ieee80211_sta *sta,
+                    enum ieee80211_sta_state old_state, enum ieee80211_sta=
_state new_state);
+void cl_ops_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+                      enum sta_notify_cmd cmd, struct ieee80211_sta *sta);
+int cl_ops_conf_tx(struct ieee80211_hw *hw,
+                  struct ieee80211_vif *vif,
+                  u16 ac_queue,
+                  const struct ieee80211_tx_queue_params *params);
+void cl_ops_sta_rc_update(struct ieee80211_hw *hw,
+                         struct ieee80211_vif *vif,
+                         struct ieee80211_sta *sta,
+                         u32 changed);
+int cl_ops_ampdu_action(struct ieee80211_hw *hw,
+                       struct ieee80211_vif *vif,
+                       struct ieee80211_ampdu_params *params);
+int cl_ops_post_channel_switch(struct ieee80211_hw *hw,
+                              struct ieee80211_vif *vif);
+void cl_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u32 =
queues, bool drop);
+bool cl_ops_tx_frames_pending(struct ieee80211_hw *hw);
+void cl_ops_reconfig_complete(struct ieee80211_hw *hw,
+                             enum ieee80211_reconfig_type reconfig_type);
+int cl_ops_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,=
 int *dbm);
+int cl_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+void cl_ops_event_callback(struct ieee80211_hw *hw, struct ieee80211_vif *=
vif,
+                          const struct ieee80211_event *event);
+int cl_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, boo=
l set);
+
+#endif /* CL_OPS_H */
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

