Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497113AB888
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhFQQIq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:46 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233602AbhFQQH4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chVlNi4Jn+T8IKw8ooZpEN4hVcL38wyp+n90g+CixeCGYoEuon/8C0Kf05SDx8B+c05Oy1p0OLSTdTiUx4FYsrQB6h5o+O1PY0xbTVdhyqcxi2QBTKojuIz5C1DI+tkjVEaUgyTTOfy9XYRhKFRvRvWiByyQKHvGwK3PMKG3iX/14WW4oIL3fx81nDhEu7B78R5u4p+Lstkzj7SmS5C2rjiIi92KTWR1Uy6E0ExGeNtMkqoLXnP+Tfe4hwiNBCUxqB7Vwifrwf27FsxPc+o0iDDaB0u6OlmE2Tii5mtfk+Ibub5zC1DzShWHf1i3qhxIJ1n3cZ786APnTJIv42z4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUqbG7SYbnCnFrDvAFYozASwVN4rIMw0yy3/EWAB52o=;
 b=K18/r0SahYyXWNxDIDr07mob1MUTXkEppxsRWemSzPl/OIX/7iSEzqbpB6yMpvfnGGCHSRPtAPGBIe/x0pFnVh0j72dYC6ZH3jX1oV6Gkfii5PPdkvRQSDulGkhm/TS9SKVjn8ul35cTMek6/1iOiZZockwzzuccTOWpZn5dP+G64ZTowCooI4HZd7fmtRc8ocYVc+vjiG9/6WvH2Qzp0L7AtQ8cE8gpnMZlj0soG0xABTQ5lU2NumE84qxkh+vmHUhjhcV96VBVSFumxQPDxBosXnQTbgvRs60uKCk6gUD215GW77n+5pZ/IlmGA/aSZfVD91MOqo4ZoDg30KPs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUqbG7SYbnCnFrDvAFYozASwVN4rIMw0yy3/EWAB52o=;
 b=cpa+zYZnAy916x9wEGIDtGev3aCqK5KMad9uL2tCyLlzXHybQaYCqOY4hck3+tv3QdwINhw0nnKieAt+kJFg7iM1WHMCh5uAb7jOZM4J0wUKNQf95JA37iqWAJCio3FvigoojmYNh3DgnvmP53os9xs1lRD+6KLmC4+kQoFNeWg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:43 +0000
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
Subject: [RFC v1 121/256] cl8k: add omi.c
Date:   Thu, 17 Jun 2021 16:00:08 +0000
Message-Id: <20210617160223.160998-122-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e04ce3a4-4bfc-4cd2-f3cc-08d931a9a14c
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314AC7890E55140D6ED8D23F60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:174;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNkA5WFStfPghcW/SoXVUOLsv+mfxe5Mib05/6YxEqvXpUjgMs98xDXx93X26xuo5q0UmnnEfbEJWAyEAERigfMQhoFhisQNLsk1IxouYO7kUpzX6WvVVRSVjWRN/ugP1/xWxs24hLdfDIOLILisRvvLPnyUYufcqeiifndbtGFXhhF4DZjx160doEjSUGjEs2CVXcOsyNCslpuefCqNkrTg4OEOOqRe8pdgx178caotrMRy7ET31Wrd44yGyBo7Q6aBBwRHCIoD15isGvZrCeyfGQIhydZVrLsfW3UPFzE12UsJ46qi1vjSAQpqKIuo6ZuxwG/9O+OiMQFLtE5yziqlehxsbml7BighHP+0bsdU7cWw/gBDvNrU8i+9fyrMb8GRs0sVvtBXoulBtAIzkU57PAJfauhk/a9o3X4IZDVUqnu5wHF7y4AbhEQzFcjIJ5v6QXkO7i38OfNEXETlUrwYnISVLJAsztHBjdiuyO+g4n11SD0afq1+9KHw5cJK8lKyMMskda1c0DruZtS8N7ZFaNitlcJxMJzP02akf5YHn2Vhq53Oef80AVly6vsApNsxMwwrEejFQDkFFVSnZ94qXfn9Tf5/7vke5DVBifiAiC8Wvfmj+LKEW2wuHEowjGd8as/uVzKhKFeM3V1/ExsmT4TWx3q/NL2fljJ6DTS3BisTK70Uhg0pXfb6nDJ/k+wyzo1zC7w1QEC8zBmwhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rXtaHvwloJPifqdGgJE+IESL8VFi4P2eSbcT9H/8tR77f20uGMwQ8tQXNEq?=
 =?us-ascii?Q?sSbJA1TD4LKHb0lYLOmbVO3LhAuGW18yphPSmbDslJA7M+RYJuSQ+3VaAEF5?=
 =?us-ascii?Q?0FGim1d4Dd4Hi0seGuAoNvt+kFobaZpiunIdXDr+qQ1hVtuiyJWzBj2LOaCr?=
 =?us-ascii?Q?cL7CxdB3WY3Ufm0ZfIv+7WEFz3gQeIx1h/V9bEVSWHgz6zMKx/I8lLH+Ubvi?=
 =?us-ascii?Q?V0ROc6D2YFL5zpzpHS7Kt0LG3cU5afJc92oUKzsBPXKl0f8AMKP/XvLngtWY?=
 =?us-ascii?Q?aja0dRIVDPDbeBXt/L/RILvfM/Qz9soSUdlXLMaWVDULWsClsYFuDzS1sGgN?=
 =?us-ascii?Q?gDf3sdMadIuG6VdtJmKcoOl6M3lvBZfI8W5tuPyjl6Ivt/UvZbvL7atC9vIz?=
 =?us-ascii?Q?3hqDKHZ4iaynrr/uKWrY/xchuJb6hel6vLlholuNtq3+B5vd2yPZ5q4X04y/?=
 =?us-ascii?Q?GAfnFhiQBC4qkW1QXWjBL6QIY9BOhCxt8OiSLE0yS5jhRDRDH4Axq9ST9b9o?=
 =?us-ascii?Q?EDuRVZV+yIT42/skmy2mKYV5jJ1yDceLd1KUUw3TYJREb2iQCY/YEYimL1Uc?=
 =?us-ascii?Q?3LiZ8x61ib0vj0Hi+UCt7cRjcRRMyQtru9+Plzgrdp4/L3FZhTERZGc1Lg+0?=
 =?us-ascii?Q?w7scR6NKUWwi9aHY0YYQktihPYqY2PIC8FHqBkfNyODnt2wuYMDeik98H/b0?=
 =?us-ascii?Q?0bB26y+cEB7HErDTi6uVhf8BX/bzvDeY3TUDzo9Y6C/S3M+e9eNLnr0nyoTk?=
 =?us-ascii?Q?nTWmWPBJkJdjHLFEuXHp2MiBGGxtoAB8RTlUwFDM3awxxk7WZ8VnrGYOhJzM?=
 =?us-ascii?Q?RlcIyFCNGud5HOEusioZEwBFkk7dCVvpc68YoWtCtzzD223EyafP0IiJ0yjd?=
 =?us-ascii?Q?Mlg8eBRRZCajufGOvqQH3BEWjGXldY7gfRXfUlA9Jlgz5btxA8Q9ghifBvNA?=
 =?us-ascii?Q?mtcm5oj0rz0tux9yKP9p58CFTeQjegluL7dqXgu3xRqHLcokvdYCN83i8lsh?=
 =?us-ascii?Q?hdO+/isQgDQkDdyyzVsWue3ExiRsNCK9E/c7j8hAcY0w/qtnK0ked1NeJZn4?=
 =?us-ascii?Q?kzYXYvqvdeM7TIMh29Nb5QSag+uCzCYKMnCkF/5IyEajduwA974KIx2PU/Ef?=
 =?us-ascii?Q?06yFsivgHuTst0iquaJ/MX4vNn7cqR9InggvKwVIK2eXbZAYogS69J4UR3/3?=
 =?us-ascii?Q?gcUwcDU9kdDawxHnGZM7U76H6F6vhAKG4/2GMnHLRkoQjq/Tbqyr3d+Bjxqz?=
 =?us-ascii?Q?ITEMN1hKMLPBhu7Z3SbGoXY4vHWSQW7hJ4JRNGkXQpMDkC7TiTIqPYjoPD3b?=
 =?us-ascii?Q?pQHL9CLT0XkgSoaEOSOMjj0S?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04ce3a4-4bfc-4cd2-f3cc-08d931a9a14c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:47.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAKbOLppDt+FILGNK48qERjMuwcOwc21oWUUEAPiWVSQLObXA1x+cZTZo1jRYclAH6Jpo7wyCWqp4cU5RuGleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/omi.c | 214 +++++++++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/omi.c

diff --git a/drivers/net/wireless/celeno/cl8k/omi.c b/drivers/net/wireless/=
celeno/cl8k/omi.c
new file mode 100644
index 000000000000..d25cbc12ac7a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/omi.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "omi.h"
+#include "mac80211.h"
+#include "sta.h"
+#include "mac_addr.h"
+#include "tx/tx.h"
+#include "wrs/wrs_api.h"
+#include "enhanced_tim.h"
+
+#define MAX_OMI_NSTS (WRS_SS_MAX - 1)
+
+static int cl_omi_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "omi usage:\n"
+                "-e : Enable/Disable OMI [0-dis, 1-en]\n"
+                "-s : Send OM control frame [sta_idx].[bw].[nss].[mu_ul_di=
s]."
+                       "[mu_ul_data_dis].[tx_nsts]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static bool cl_omi_validate_parms(u8 bw, u8 nss, u8 ul_mu_dis, u8 ul_mu_da=
ta_dis, u8 tx_nsts)
+{
+       return (bw < CHNL_BW_MAX && nss < WRS_SS_MAX && tx_nsts <=3D MAX_OM=
I_NSTS);
+}
+
+static int cl_omi_send(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 bw, =
u8 nss, u8 ul_mu_dis,
+                      u8 ul_mu_data_dis, u8 tx_nsts)
+{
+       struct ieee80211_sub_if_data *sdata =3D NULL;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_qos_htc_hdr *hdr =3D NULL;
+       struct cl_om_ctrl om_ctrl;
+       struct ieee80211_vif *vif =3D NULL;
+       int hdr_len =3D offsetof(struct ieee80211_qos_htc_hdr, a_ctrl) + si=
zeof(hdr->a_ctrl);
+
+       if (!cl_hw->conf->ce_omi_en || !cl_sta)
+               return -1;
+
+       vif =3D cl_sta->cl_vif->vif;
+       sdata =3D cl_sta->stainfo->sdata;
+
+       if (!cl_omi_validate_parms(bw, nss, ul_mu_dis, ul_mu_data_dis, tx_n=
sts) ||
+           vif->type !=3D NL80211_IFTYPE_STATION)
+               return -1;
+
+       skb =3D dev_alloc_skb(cl_hw->hw->extra_tx_headroom + hdr_len);
+
+       if (!skb)
+               return -ENOMEM;
+
+       skb_reserve(skb, cl_hw->hw->extra_tx_headroom);
+
+       hdr =3D (struct ieee80211_qos_htc_hdr *)skb_put_zero(skb, hdr_len);
+       cl_mac_addr_copy(hdr->addr1, cl_sta->addr);
+       cl_mac_addr_copy(hdr->addr2, sdata->vif.addr);
+       cl_mac_addr_copy(hdr->addr3, sdata->u.mgd.bssid);
+
+       hdr->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211=
_STYPE_ACTION |
+                                        IEEE80211_FCTL_ORDER);
+
+       om_ctrl.u.fields.chan_width =3D bw;
+       om_ctrl.u.fields.rx_nss =3D nss;
+       om_ctrl.u.fields.ul_mu_dis =3D ul_mu_dis;
+       om_ctrl.u.fields.ul_mu_data_dis =3D ul_mu_data_dis;
+       om_ctrl.u.fields.tx_nsts =3D tx_nsts;
+
+       /* Set A-control subfield */
+       hdr->a_ctrl.u.fields.b0 =3D 1;
+       hdr->a_ctrl.u.fields.b1 =3D 1;
+       hdr->a_ctrl.u.fields.control_id =3D IEEE80211_CTRL_A_CTRL_ID_OM;
+       hdr->a_ctrl.u.fields.control_info =3D om_ctrl.u.value;
+
+       if (!ieee80211_tx_prepare_skb(cl_hw->hw, vif, skb, cl_hw->nl_band, =
NULL))
+               return -1;
+
+       /* Send the OMI frame */
+       cl_tx_single(cl_hw, cl_sta, skb, false, true);
+       pr_debug("OM control frame was sent!\n");
+
+       return 0;
+}
+
+static void cl_omi_set_tb_mode(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              u8 ul_mu_dis, u8 ul_mu_data_dis)
+{
+       struct ieee80211_sta_he_cap *he_cap =3D &cl_hw->iftype_data[1].he_c=
ap;
+       bool mu_dis_rx_sup =3D (he_cap->he_cap_elem.mac_cap_info[5] &
+                             IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_=
RX) ? true : false;
+       u8 ac;
+
+       /*
+        * According to Table 9-24a - UL MU Disable and UL MU Data Disable =
subfields encoding
+        * At this point we need to suspend/resume trigger base flow
+        */
+
+       for (ac =3D 0; ac < AC_MAX; ac++)
+               cl_sta->data_pending[ac] =3D 0;
+
+       if (!ul_mu_dis && !ul_mu_data_dis) {
+               pr_debug("All trigger based UL MU transmissions are enabled=
!\n");
+       } else if (!ul_mu_dis && ul_mu_data_dis && mu_dis_rx_sup) {
+               cl_enhanced_tim_clear_rx_sta(cl_hw, cl_sta->sta_idx);
+               pr_debug("Basic Trigger is suspended!\n");
+       } else if (ul_mu_dis && !ul_mu_data_dis) {
+               cl_enhanced_tim_clear_rx_sta(cl_hw, cl_sta->sta_idx);
+               pr_debug("All trigger based UL MU transmissions are suspend=
ed!\n");
+       }
+}
+
+void cl_omi_parse_om_ctrl_frm(struct cl_hw *cl_hw, struct cl_sta *cl_sta, =
struct sk_buff *skb)
+{
+       struct ieee80211_qos_htc_hdr *hdr =3D (struct ieee80211_qos_htc_hdr=
 *)skb->data;
+       struct cl_wrs_rate *wrs_rate =3D &cl_sta->wrs_sta.max_rate_cap;
+       struct cl_om_ctrl om_ctrl;
+       u8 nss, bw, ul_mu_dis, ul_mu_data_dis, tx_nsts;
+
+       if (!cl_hw->conf->ce_omi_en)
+               return;
+
+       om_ctrl.u.value =3D hdr->a_ctrl.u.fields.control_info;
+       nss =3D om_ctrl.u.fields.rx_nss;
+       bw =3D om_ctrl.u.fields.chan_width;
+       ul_mu_dis =3D om_ctrl.u.fields.ul_mu_dis;
+       ul_mu_data_dis =3D om_ctrl.u.fields.ul_mu_data_dis;
+       tx_nsts =3D om_ctrl.u.fields.tx_nsts;
+
+       if (!cl_omi_validate_parms(bw, nss, ul_mu_dis, ul_mu_data_dis, tx_n=
sts))
+               return;
+
+       /* Set TB mode */
+       cl_omi_set_tb_mode(cl_hw, cl_sta, ul_mu_dis, ul_mu_data_dis);
+
+       if (nss !=3D wrs_rate->nss)
+               cl_wrs_api_nss_changed(cl_hw, &cl_sta->stainfo->sta, nss);
+
+       if (bw !=3D wrs_rate->bw)
+               cl_wrs_api_bw_changed(cl_hw, &cl_sta->stainfo->sta, bw);
+}
+
+int cl_omi_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool send_om_ctrl =3D false;
+       bool enable =3D false;
+
+       switch (cli_params->option) {
+       case 'e':
+               enable =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               send_om_ctrl =3D true;
+               expected_params =3D 6;
+               break;
+       case '?':
+               return cl_omi_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (enable) {
+               bool enable =3D (bool)cli_params->params[0];
+
+               if (enable !=3D cl_hw->conf->ce_omi_en) {
+                       cl_hw->conf->ce_omi_en =3D enable;
+                       pr_debug("OMI %s\n", enable ? "Enabled" : "Disabled=
");
+               } else {
+                       pr_debug("OMI already %s\n", enable ? "Enabled" : "=
Disabled");
+               }
+       }
+
+       if (send_om_ctrl) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u8 bw =3D (u8)cli_params->params[1];
+               u8 nss =3D (u8)cli_params->params[2];
+               bool ul_mu_dis =3D (bool)cli_params->params[3];
+               bool ul_mu_data_dis =3D (bool)cli_params->params[4];
+               u8 tx_nsts =3D (u8)cli_params->params[5];
+               struct cl_sta *cl_sta;
+
+               cl_sta_lock_bh(cl_hw);
+               cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+               if (cl_omi_send(cl_hw, cl_sta, bw, nss, ul_mu_dis, ul_mu_da=
ta_dis, tx_nsts))
+                       pr_warn("Failed to send OM control frame!\n");
+
+               cl_sta_unlock_bh(cl_hw);
+
+               return 0;
+       }
+
+out_err:
+       return -EIO;
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

