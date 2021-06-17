Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8293AB8A5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhFQQJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:38 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233619AbhFQQIQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn9yyYyZB33OwI6a+y8DX6/jMvUuzKkdR27HcJHOl5WZbfrQjy+QsIaggXpPeHrr2rZWRNv1266QWkSoyAEsY8BIpMJTLhU+RqwClEfLqZtQbNia5ZqHhPb4jyZPsJZGYagaj6PHb3SoKD7mbVgieEh4lQ4eH4cd58wvQo1FinVcCZcDiVLRQkbT3Ylnhji4bSMgezNXvBN0jefvGdN9eGAGVoythd2eofRyuZ4W2FXVZLMFlHYddSjPGkNu3x3jQ7UmLseuQyEnQlqZrsdaO/Sur1MTvSEWPR8dONgfmQwoWrYlepHNQ+iPeJdIaXAHZHumks8dC4WlhabU4V9IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axFvcZdm1TQFW66FrDnuuqQTNlt7wEuVFd4M+CfkqxQ=;
 b=YPx5eGdPUeXd2OowtFSu5toLMd3sG5cmJ0kQdBKLXIT4sQul+WI615JPvrZgj5V6yQlehIL1vxHX3p69ed/vpVjKuRr+b/kJpvriF2OcmCpPtS9Lr3TQIJhHsHEx8DiyIjrFQ1J2oqH+PH+UDTG+RYymnV5i/sKVp1xCesLP694ynlYb+Hze21yuaLgfzHueqcJfyfoJkQuTqSYcDS2glCmdDbLFvaMprmgoYE62Q9bkAS7nG96WTZUoQ3UZS2rDzgKgYe98Ssw4pP29yDzdL0Q5HIC/UWZmshuaYR4dua1j47PEgWW8lL7vyDJC0olEaN8uF1wqEzf5laSFQNJvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axFvcZdm1TQFW66FrDnuuqQTNlt7wEuVFd4M+CfkqxQ=;
 b=s2UuffiOxkthYL+thkQQhlgDOhckMQYFoBr+83wZI2IkHtE684sSrJEMoNwwsRPZ3UUVip/yeNtP/hsI2XsMhbZ958hV7RyH2E5Ij+pFLTZBCiLZngNKcajTNsaqT5FyQO0qFwgbgZ+XMZ9Zx/kMwPimHr3ofynYiNb3TmCC0TU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:05 +0000
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
Subject: [RFC v1 103/256] cl8k: add key.c
Date:   Thu, 17 Jun 2021 15:59:50 +0000
Message-Id: <20210617160223.160998-104-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d50d0b62-c35e-47d5-c5ac-08d931a995a4
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887B754A06EEC8950A396ADF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGvNm/dr9L5qccGwiUqVsPvdRCPKp4x4ASjPCOfFTJg6dwtMXpYZ+yJ0BMUxSl+C3UY4JLWPBsswXZE2DWj+pKqjd96uEr1xoZRRk9j6KSbi65SR5W7RQhnbWfvdpiVMDOLUbUT8ZGGXd8G3LFh7DZCy9UO2ZN+HHol4OLNSbN0D1FiQYIGVp0yu4xxGPbDawDMzpkW5I5SCBEJtxfXq2vb/s+ybpGlfJxh6fKMykbVPLQrHvI8NFBbaxn7GVwWyd/rJ3BP3/yBu3oE+4ZF2A4kUxZKurnu+8E28EmD+FDnP0bojbeXpFa2Ej7EaFModHkyBDxDHwYthk9WqH1/4bCPxdncWkZNrdC+sGUMoWB8MwDD26saC1CnzFOyogne014tAw6r1pAKRl5wMI4YrCj0liTfLVLz8ANMDWtxBjiLGfDkUg016ThbpmLXefjrHWnvFarqwnASoDGJ92HIn16HIkFym7ADycLAes+fApTICfPVorHjx1QX64lJ6LYvXk3p0erYg7B+nMoseyFBqs66HW6F13hGazQz8o1v2vtIExOYEFepoSfDGYlpTyMpFCbUfteszybfa3S+XnV5lABAJHM6eonR1Xs/aOP+av2+crJ2d22AaVRiiegfUKndYzXSNwBSBFWXTkaRu1t+2R2GTzIt7c4SsuNlu1n2Nk4wowsvcjULs6P0CFfcVpJ6ogYleSDy0XTc8xNwkOawDpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h//KKRFudclNsPTFZcTVuOeH0MsjAyXinfZsw544vDopgT6eTGBg+Vho4UbW?=
 =?us-ascii?Q?masR3LlSX/wza/PP3Z7skJxjbcEdPm3YA9GzrYPJdvqdKQY/U68anOlXyUi3?=
 =?us-ascii?Q?83olqE+RDGTFGxDZ4Id7z70NOfHqz7ae1qPPZiLGtrp9scBf7mmXFaDP9/Nv?=
 =?us-ascii?Q?WIi4ZWg8GwoVD47fyErsZIUbwPgkx8Owk2ntGMwUToLavQJ2p3QgeRAyYuN0?=
 =?us-ascii?Q?GjFnLp+IRjBLWxP4khGp6qOXQ/HbRRQFzXaNDXuGQSlCcBc/JUyw4Swl1yZf?=
 =?us-ascii?Q?KX8uf6Hr3V44Cc748XvabeNPFJ+HvUk3rUKmXbILG8k4MX0uOEW60dmM3Pmm?=
 =?us-ascii?Q?yGm7HjKsjpX4LCC47Eg5KDJi2JenUWLUaAtUDah9FnsyUi7JUDdcWQSXqAU0?=
 =?us-ascii?Q?aOeCLn+vccALB2rkYHaZhdmhLPi6CyjgVZodZ4gVRvQhSAZtigKBElYg1hnK?=
 =?us-ascii?Q?RIZoN5c9XQljUk5S91FIsaEU01/js6Kwo++HjFnPJqsS/QJKnNW4lfJ79BM8?=
 =?us-ascii?Q?+dJLIYMTZXJ4QPooAKphVXT+Bbkqv0XPhgYDHtgzwGMtCulv4IyKOJrywqYg?=
 =?us-ascii?Q?WuUkwcb01AfcZWj6oYDgGyXGQ9vzuo+TSC7jghedRg/3OCpTesbXnp55BaJK?=
 =?us-ascii?Q?ffu09AfVVBZTPSG/2MOHjA2Z+x5ACfpbcNRgJcVtwrq1EGJH70oYMVb2+aH8?=
 =?us-ascii?Q?ogwAKEl1AXw+lp5l4JU7KRVg5r0eviORCetfzu3gOyMudtYhdAtFyYkpA5++?=
 =?us-ascii?Q?TSaYBh+NZ7uVk7XeZ+HkKPEqzFDmDxwNE+Aj5+m/9hVsHBpcmymxTxIGbVvS?=
 =?us-ascii?Q?sdOptMNoN0LYy5nF4hTtYUG72ifOxgpLkXhMzuVEKqXnKvaJ2JBrWY+/4GOK?=
 =?us-ascii?Q?zKnGdmsAxboUnl5pEgtWwvaADNHRlFTDf5uD97UTaya2bXQsDo2ECP8CYwm/?=
 =?us-ascii?Q?7XaSoSTjglSQiGTLmJQmv2eJ0LZ+gqwLyfksJVD8XRpbsXCKvxdrUXZPOHYd?=
 =?us-ascii?Q?exWwfaLeiMs2p75vHnd7JYDwufh1brKjEzHsN3q3/9NxR21BOsZdPUzV3nPF?=
 =?us-ascii?Q?Pi/VQKDZAHQMvdVCyrNSuXeTNQJ5tV5VlL+EW8X9exfPRGkupEtskTxqpatM?=
 =?us-ascii?Q?R36ekztY4dYUJtjMfKWN7mGvLuVcm4NeCPGrvhamcUKg6DkynqiIrCNeWJ/4?=
 =?us-ascii?Q?UClexA5cObdgpzpey3XhUs/F6ZAZCCnjWsUVFL3PNb8GiDENjkYExJ4P2so2?=
 =?us-ascii?Q?Mo2DdJRXsbdUZlIQRrPvwILS53fx5KyxfTSaNv/+Ii82XixZp1Y34vBZ04Sa?=
 =?us-ascii?Q?lZyKI5V52nIKwOAJFEW9oUp/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d0b62-c35e-47d5-c5ac-08d931a995a4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:28.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: an8Van5D0PXptXOce+1UFGmOU3VUJwxYGI4WN+vv79pb/7rDJucCpx2vSEJsl+9eJBSlCg5ePhVtNwzj0QUR+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/key.c | 197 +++++++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.c

diff --git a/drivers/net/wireless/celeno/cl8k/key.c b/drivers/net/wireless/=
celeno/cl8k/key.c
new file mode 100644
index 000000000000..276c2e76e126
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/key.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "key.h"
+#include "fw/msg_tx.h"
+#include "fw/fw_msg.h"
+#include "sta.h"
+#include "tx/single_cfm.h"
+#include "tx/agg_cfm.h"
+#include "tx/tx_queue.h"
+
+static int cmd_set_key(struct cl_hw *cl_hw,
+                      struct ieee80211_vif *vif,
+                      struct ieee80211_sta *sta,
+                      struct ieee80211_key_conf *key)
+{
+       int error =3D 0;
+       struct mm_key_add_cfm *key_add_cfm;
+       u8 cipher_suite =3D 0;
+
+       /* Retrieve the cipher suite selector */
+       switch (key->cipher) {
+       case WLAN_CIPHER_SUITE_WEP40:
+               cipher_suite =3D MAC_CIPHER_SUITE_WEP40;
+               break;
+       case WLAN_CIPHER_SUITE_WEP104:
+               cipher_suite =3D MAC_CIPHER_SUITE_WEP104;
+               break;
+       case WLAN_CIPHER_SUITE_TKIP:
+               cipher_suite =3D MAC_CIPHER_SUITE_TKIP;
+               break;
+       case WLAN_CIPHER_SUITE_CCMP:
+               cipher_suite =3D MAC_CIPHER_SUITE_CCMP;
+               break;
+       case WLAN_CIPHER_SUITE_GCMP:
+       case WLAN_CIPHER_SUITE_GCMP_256:
+               cipher_suite =3D MAC_CIPHER_SUITE_GCMP;
+               break;
+       case WLAN_CIPHER_SUITE_AES_CMAC:
+               return -EOPNOTSUPP;
+       default:
+               return -EINVAL;
+       }
+
+       error =3D cl_msg_tx_key_add(cl_hw, vif, sta, key, cipher_suite);
+       if (error)
+               return error;
+
+       key_add_cfm =3D (struct mm_key_add_cfm *)(cl_hw->msg_cfm_params[MM_=
KEY_ADD_CFM]);
+       if (!key_add_cfm)
+               return -ENOMSG;
+
+       if (key_add_cfm->status !=3D 0) {
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", key_add_cfm->s=
tatus);
+               cl_msg_tx_free_cfm_params(cl_hw, MM_KEY_ADD_CFM);
+               return -EIO;
+       }
+
+       /* Save the index retrieved from firmware */
+       key->hw_key_idx =3D key_add_cfm->hw_key_idx;
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_KEY_ADD_CFM);
+
+       /*
+        * Now inform mac80211 about our choices regarding header fields ge=
neration:
+        * we let mac80211 take care of all generations
+        */
+       key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_IV;
+       if (key->cipher =3D=3D WLAN_CIPHER_SUITE_TKIP)
+               key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_MMIC;
+
+       if (sta) {
+               struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+
+               cl_sta->key_conf =3D key;
+       } else {
+               struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+
+               cl_vif->key_conf =3D key;
+       }
+
+       return error;
+}
+
+static int cmd_disable_key(struct cl_hw *cl_hw,
+                          struct ieee80211_vif *vif,
+                          struct ieee80211_sta *sta,
+                          struct ieee80211_key_conf *key)
+{
+       if (sta) {
+               struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+
+               cl_sta->key_conf =3D NULL;
+               cl_sta->key_disable =3D true;
+
+               /*
+                * Make sure there aren't any packets in firmware before de=
leting the key,
+                * otherwise they will be transmitted without encryption.
+                */
+               cl_txq_flush_sta(cl_hw, cl_sta);
+               cl_single_cfm_poll_empty_sta(cl_hw, cl_sta->sta_idx);
+               cl_agg_cfm_poll_empty_sta(cl_hw, cl_sta);
+       } else {
+               struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+
+               cl_vif->key_conf =3D NULL;
+       }
+
+       return cl_msg_tx_key_del(cl_hw, key->hw_key_idx);
+}
+
+int cl_key_set(struct cl_hw *cl_hw,
+              enum set_key_cmd cmd,
+              struct ieee80211_vif *vif,
+              struct ieee80211_sta *sta,
+              struct ieee80211_key_conf *key)
+{
+       int error =3D 0;
+
+       switch (cmd) {
+       case SET_KEY:
+               error =3D cmd_set_key(cl_hw, vif, sta, key);
+               break;
+
+       case DISABLE_KEY:
+               error =3D cmd_disable_key(cl_hw, vif, sta, key);
+               break;
+
+       default:
+               error =3D -EINVAL;
+               break;
+       }
+
+       return error;
+}
+
+struct ieee80211_key_conf *cl_key_get(struct cl_sta *cl_sta)
+{
+       if (cl_sta->key_conf)
+               return cl_sta->key_conf;
+
+       if (cl_sta->cl_vif->key_conf)
+               return cl_sta->cl_vif->key_conf;
+
+       return NULL;
+}
+
+bool cl_key_is_cipher_ccmp_gcmp(struct ieee80211_key_conf *keyconf)
+{
+       u32 cipher;
+
+       if (!keyconf)
+               return false;
+
+       cipher =3D keyconf->cipher;
+
+       return ((cipher =3D=3D WLAN_CIPHER_SUITE_CCMP) ||
+               (cipher =3D=3D WLAN_CIPHER_SUITE_GCMP) ||
+               (cipher =3D=3D WLAN_CIPHER_SUITE_GCMP_256));
+}
+
+void cl_key_ccmp_gcmp_pn_to_hdr(u8 *hdr, u64 pn, int key_id)
+{
+       hdr[0] =3D pn;
+       hdr[1] =3D pn >> 8;
+       hdr[2] =3D 0;
+       hdr[3] =3D 0x20 | (key_id << 6);
+       hdr[4] =3D pn >> 16;
+       hdr[5] =3D pn >> 24;
+       hdr[6] =3D pn >> 32;
+       hdr[7] =3D pn >> 40;
+}
+
+u8 cl_key_get_cipher_len(struct sk_buff *skb)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+
+       if (key_conf) {
+               switch (key_conf->cipher) {
+               case WLAN_CIPHER_SUITE_WEP40:
+               case WLAN_CIPHER_SUITE_WEP104:
+                       return IEEE80211_WEP_IV_LEN;
+               case WLAN_CIPHER_SUITE_TKIP:
+                       return  IEEE80211_TKIP_IV_LEN;
+               case WLAN_CIPHER_SUITE_CCMP:
+                       return  IEEE80211_CCMP_HDR_LEN;
+               case WLAN_CIPHER_SUITE_CCMP_256:
+                       return  IEEE80211_CCMP_256_HDR_LEN;
+               case WLAN_CIPHER_SUITE_GCMP:
+               case WLAN_CIPHER_SUITE_GCMP_256:
+                       return  IEEE80211_GCMP_HDR_LEN;
+               }
+       }
+
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

