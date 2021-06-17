Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14D3AB942
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhFQQNy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:54 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:11146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232841AbhFQQM6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb60M3HKw14suikNP0NmQ0g2ZWlJiEUHlx8Sm/ynpkDRHSAtNXdsh+3hdHKIGeuJBn4PW+RgFA9oAbwGzg41U4ACWysvKzZH6CK9oOh1ZxrpHK/j6xTNaL7OJSGnmUtsALX2TseFvyiIIhrI4gZ0OhtqVqSzNdQHssetef/oROHxW3t8VvSoUoXUaFbtc3woIqSnS+DpxBTrR2sYnzIsd0Cxsm5DNsgbfLtc48sG1Q/t/J+nygoeeK/bO2GDEnLsQkFej9x7lFBiL+qaI0BJYiXnEu2v8LgNNNH7ogLEtsCP/6t/mGoMHzZqzSfLWh5slecrQqtcNQTNyLlyBnCZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz6rfeNE+gs6C1UiHsMymXvMCQM9LZxnBGq8GRbtVGI=;
 b=mtnYy/xx2vjCDzAhUz9YxdmIFmXn1lzgkSdi1R9R65iUV0qIXVgiAm/ehaNCRivNlup58LfdzYN4rIatR4hX18JtSIIGOxwm9rE3a2YkhQkU1eDe7MYZZN6in4IrqfMah4j5ZLWlzVuDwFhxmQC/bJ4lAkgTZqVsoMn0coiO+PC/jewse2lWdTwhx+XeCu7oCEUQe51UEQWnPS/wcnfhT9FNA6cvjPRRivg60+/FfWk/Shk8y4glZV6Ej0MpFalkWder2Yxt9ifD4QlrrCBzHn1pqGzGHqi2cVEPQXKEMZ0HO+Xvc19Ote/bTM2jgKfqZYU/AdtENe+wmcCrVkeO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz6rfeNE+gs6C1UiHsMymXvMCQM9LZxnBGq8GRbtVGI=;
 b=t6qU+OWdoo2Q86qa+xdd2Spy5qi0c0qxM7BydnFC/Q/gavQ7Fvv7G7xqEOb117mj6ugEpJj3IE4adqhc6G4PXTZqP/bG7cVBrkpy6hyiMVIPgQMlndT13J/oYNaS+S4VJAg5tixqu3ltunQ1Xpt3FdM5aIw/bWn27owAjV0PI90=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:35 +0000
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
Subject: [RFC v1 250/256] cl8k: add wrs/wrs_sta.c
Date:   Thu, 17 Jun 2021 16:02:17 +0000
Message-Id: <20210617160223.160998-251-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f325d6-6025-4d59-d623-08d931a9f87e
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978E6C93038F114336920CCF60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZoU0xoL6uXn0HX0vDl4SAYbb91K+s9tl6Nu94ksAKG7W5RKTq48N2n8LlWXKaXOGM7DVxDsVmNoED3nsbZ7NqPr3UAdb7FTpzpGzZFbYnyFQUOp5Wh3S2dzlm8OHVfyZZ8y2YsbVys+7uhvvPRCrRm91d9fg3m6wTOiDsl+UXM4p/MffPIIUgxqSfUejm0Infmz9A2WBIRHe2Pb4eEWcvSlL6DOd/4REgSTFJKevtc0jVDN46+B4JsEdvL6nvO1uM1Te/lnBuPUBiermZiMXzxcjSPblnBoRA0TnQObCD7yVW9q0whNqoeVoEp0jNs7W5IrRlKwqUsybF9ivSDzxktGn1gJPPdVD66KAQpWl/IGkI+hjhkeZIgYw9120M2+q07hn0GG0uiXtdfByYyTzItHVV0+n5KicWll8W4dFiYbuv6wTIcvE6fDGkZEqKS4iY1Za2vnMyV+wlaD07RlQosynXJs4KiAehkFWPlA3qNFMXb8OB9efe+kudhLmh+PIn8fYyGtx6EtDJPR3rijIBiIQF11Q9LpI7rmjx+MDMSOlWpNmzt8nKibR8JiShV5eU4WVJN7xXiIObbX58+nkNlhSNCtUNELAdWSAZR+ttBDg2ZPAdgldv4zO+CtvyY+FTEgIcLH+/EG9OAn9YgTtP0hYjcgRExZ0EY4jDHoaWXCoqwqEZ+iqjl1t7LA07S0hrRWMPOx6nrGiY8Uwf/bKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(30864003)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qW1BhYgQicjsDvkybqR9x+UlvsVN8TFxXFXtWTHWu0kNa2jJLx9/AcDGUM6i?=
 =?us-ascii?Q?+7wb/W55pCXHRJcWIOKZhUQedoMbzcwx2YYJkN0YD50+LUR1np5rg9ILECEB?=
 =?us-ascii?Q?bReT0txVJwxLnuY9c8HL8UxYdToS+y1Ji+sbxfss7ZHpYXjVKS1Ig3cLUNeE?=
 =?us-ascii?Q?KgaVH7Vlz0/KMY1w6EyeZ1Qprkb0DV5RuxKuujzKyKSQiUwqT9uuJ/7RSqdZ?=
 =?us-ascii?Q?wp/DuTZOGay95Bk/6UbZc19pz1USjPw2MLTyvpz3fnd5VANksS/GX8BpgG8t?=
 =?us-ascii?Q?7tSjNz6e8WctONcrgwGT6YeYHbXQ2HK4od2dhUbr3tBak3XuqUQeYuo2KxLM?=
 =?us-ascii?Q?F9Cq47uR8zERCyzrBmOdTQagImtUa9G/h5vo6SxIiYPQ++NJgPOYeyjwesWD?=
 =?us-ascii?Q?rEDwf96GfvfeG51B3YCJ7vxdD4FxscsqhOuLawlwWggh1KtDtWysNjC39PXS?=
 =?us-ascii?Q?uJHpvQOCKSVDMlfXOKTLyUDDbdRdQ5g+OHo563oMfC5alaUi5FVsqtz6GQs3?=
 =?us-ascii?Q?ECbRQd4dN/EJrxSj4PlgL0z2okL2QbN8q4yr4AmCUL5onmApFQ+nxtalZBbH?=
 =?us-ascii?Q?sGKLd8tvSlGd87zlKp8YbL+3qj8oNlkUMwWJt8HxZ04EgJCkdLVW1ieYlb1O?=
 =?us-ascii?Q?Ez0hfn33Gn2o905aFL16cf+98lHbMrtLhinpw72C1KBrowcBQ+/L736p5w+G?=
 =?us-ascii?Q?7IAB3Ew9ibLTW66av8p/qJevDQT5dy/sbNmK5jBKGaZZw89e7LtskNLK9bQE?=
 =?us-ascii?Q?vkJAH20oZBAB9JfXsnU3kxDbY42wNLhmvSTEHqD42QaA4Jg2pXLyoIH+lU3I?=
 =?us-ascii?Q?2cDDsZEg0zN1Lvc7bIptookmw/yaMb4wBryjk52TcL8QvzvWa91CoMWND5+1?=
 =?us-ascii?Q?OYZQfXTBPJKO/IFYpcZPNuqkiqXwmHKFcngjW6j3arcDeGRDuG0NTK9R9vWd?=
 =?us-ascii?Q?pk/SL7P+i/w4mxwTHP91f1HppyiotudLYlhSW3eGMngWi0qoBW3x+ruyFmBg?=
 =?us-ascii?Q?X1h3JeVbtdVoNsj1ZpUkgE3YcngtbxYz7YeF1he9XPiIIc08Wt4AsIizs2pV?=
 =?us-ascii?Q?d/QvfVjsOj1RXbrPjUIXzkyfEInJKxjLVvMDgP5quXLoGlxsq28IERZwpHpG?=
 =?us-ascii?Q?wvWJmfwbuurkdDDtRLLyzNJ8mPmh83j0pEZKBWil/zuC3v4QsOXyrz8K9y2v?=
 =?us-ascii?Q?o1cCVL4AhJ6q8hX4sasKzM6Rw+Z3KkiwRV+GHrIqiEpHeABcne7nW9e4D9Ko?=
 =?us-ascii?Q?8uuo1V9Sy4EpdbrnLr10cgqDoPhTFM6Ra3qxe/ln3j/NXqaVdZfZikAxn077?=
 =?us-ascii?Q?ujOuwoHb9hRPyvK7zYzzAwjZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f325d6-6025-4d59-d623-08d931a9f87e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:14.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TphgjTwbRN/vHQh8LTuYnfN3npg8fr7zCaYS8Z9s9r391kMazgjHis+G9IvmaduOytstC04aAEPVJ/tnLNlgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_sta.c    | 360 ++++++++++++++++++
 1 file changed, 360 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.c b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_sta.c
new file mode 100644
index 000000000000..2ebcb0c984ba
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_sta.h"
+#include "wrs/wrs.h"
+#include "wrs/wrs_rssi.h"
+#include "utils/math.h"
+#include "sta.h"
+#include "wrs/wrs_stats.h"
+#include "band.h"
+#include "utils/utils.h"
+
+static void cl_wrs_sta_info_set_he(struct cl_wrs_sta *wrs_sta)
+{
+       wrs_sta->mode =3D WRS_MODE_HE;
+
+       wrs_sta->gi_cap[CHNL_BW_20] =3D WRS_GI_VSHORT;
+       wrs_sta->gi_cap[CHNL_BW_40] =3D WRS_GI_VSHORT;
+       wrs_sta->gi_cap[CHNL_BW_80] =3D WRS_GI_VSHORT;
+       wrs_sta->gi_cap[CHNL_BW_160] =3D WRS_GI_VSHORT;
+}
+
+static void cl_wrs_sta_info_set_vht(struct cl_wrs_sta *wrs_sta,
+                                   struct ieee80211_sta_vht_cap *vht_cap,
+                                   struct ieee80211_sta_ht_cap *ht_cap)
+{
+       wrs_sta->mode =3D WRS_MODE_VHT;
+
+       wrs_sta->gi_cap[CHNL_BW_20] =3D
+               (ht_cap->cap & IEEE80211_HT_CAP_SGI_20) ? WRS_GI_SHORT : WR=
S_GI_LONG;
+       wrs_sta->gi_cap[CHNL_BW_40] =3D
+               (ht_cap->cap & IEEE80211_HT_CAP_SGI_40) ? WRS_GI_SHORT : WR=
S_GI_LONG;
+       wrs_sta->gi_cap[CHNL_BW_80] =3D
+               (vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80) ? WRS_GI_SHO=
RT : WRS_GI_LONG;
+       wrs_sta->gi_cap[CHNL_BW_160] =3D
+               (vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_160) ? WRS_GI_SH=
ORT : WRS_GI_LONG;
+}
+
+static void cl_wrs_sta_info_set_ht(struct cl_wrs_sta *wrs_sta,
+                                  struct ieee80211_sta_ht_cap *ht_cap)
+{
+       wrs_sta->mode =3D WRS_MODE_HT;
+
+       wrs_sta->gi_cap[CHNL_BW_20] =3D
+               (ht_cap->cap & IEEE80211_HT_CAP_SGI_20) ? WRS_GI_SHORT : WR=
S_GI_LONG;
+       wrs_sta->gi_cap[CHNL_BW_40] =3D
+               (ht_cap->cap & IEEE80211_HT_CAP_SGI_40) ? WRS_GI_SHORT : WR=
S_GI_LONG;
+}
+
+static void cl_wrs_sta_info_set_legacy(struct cl_wrs_sta *wrs_sta,
+                                      struct ieee80211_sta *sta)
+{
+       if (sta->supp_rates[NL80211_BAND_5GHZ] ||
+           (sta->supp_rates[NL80211_BAND_2GHZ] & 0xFF0))
+               wrs_sta->mode =3D WRS_MODE_OFDM;
+       else
+               wrs_sta->mode =3D WRS_MODE_CCK;
+}
+
+static void cl_wrs_sta_info_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wr=
s_sta,
+                               struct ieee80211_sta *sta)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct ieee80211_sta_ht_cap *ht_cap =3D &sta->ht_cap;
+       struct ieee80211_sta_vht_cap *vht_cap =3D &sta->vht_cap;
+       struct ieee80211_sta_he_cap *he_cap =3D &sta->he_cap;
+       u8 bw =3D min_t(u8, sta->bandwidth, wrs_db->max_cap.bw);
+
+       if (he_cap->has_he)
+               cl_wrs_sta_info_set_he(wrs_sta);
+       else if (vht_cap->vht_supported && ht_cap->ht_supported)
+               cl_wrs_sta_info_set_vht(wrs_sta, vht_cap, ht_cap);
+       else if (ht_cap->ht_supported)
+               cl_wrs_sta_info_set_ht(wrs_sta, ht_cap);
+       else
+               cl_wrs_sta_info_set_legacy(wrs_sta, sta);
+
+       wrs_sta->max_rate_cap.nss =3D min_t(u8, sta->rx_nss, WRS_SS_MAX) - =
1;
+       wrs_sta->max_rate_cap.bw =3D bw;
+
+       wrs_sta->assoc_bw =3D bw;
+}
+
+#define TWO_BITS_MASK 0x3
+
+static u8 cl_wrs_calc_max_nss(u16 rx_mcs, u8 max_nss)
+{
+       u8 i, nss =3D 0;
+
+       for (i =3D 0; i <=3D max_nss; i++) {
+               if (((rx_mcs >> (2 * i)) & TWO_BITS_MASK) !=3D IEEE80211_HE=
_MCS_NOT_SUPPORTED)
+                       nss++;
+               else
+                       break;
+       }
+
+       return nss;
+}
+
+static void cl_supported_rates_he_cap(struct cl_wrs_db *wrs_db, struct iee=
e80211_sta *sta)
+{
+       struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       struct ieee80211_he_mcs_nss_supp *mcs_nss =3D &sta->he_cap.he_mcs_n=
ss_supp;
+       int mcs =3D 0;
+       int supported_mcs =3D 0;
+       u16 rx_mcs =3D 0;
+       u8 max_nss =3D wrs_sta->max_rate_cap.nss;
+       u8 nss =3D 0, bw =3D 0;
+       u8 max_nss_80, max_nss_160;
+
+       for (bw =3D 0; bw <=3D wrs_sta->max_rate_cap.bw; bw++) {
+               if (bw < CHNL_BW_160) {
+                       rx_mcs =3D le16_to_cpu(mcs_nss->rx_mcs_80);
+               } else if (bw =3D=3D CHNL_BW_160) {
+                       max_nss_80 =3D cl_wrs_calc_max_nss(mcs_nss->rx_mcs_=
80, max_nss) + 1;
+                       rx_mcs =3D le16_to_cpu(mcs_nss->rx_mcs_160);
+                       max_nss_160 =3D cl_wrs_calc_max_nss(rx_mcs, max_nss=
) + 1;
+                       max_nss =3D max_nss * max_nss_160 / max_nss_80;
+               } else {
+                       wrs_pr_err(wrs_db, "[WRS] bw %u is not supported\n"=
, bw);
+               }
+
+               for (nss =3D 0; nss <=3D max_nss; nss++) {
+                       switch ((rx_mcs >> (2 * nss)) & TWO_BITS_MASK) {
+                       case IEEE80211_HE_MCS_SUPPORT_0_7:
+                               supported_mcs =3D WRS_MCS_7;
+                               break;
+                       case IEEE80211_HE_MCS_SUPPORT_0_9:
+                               supported_mcs =3D WRS_MCS_9;
+                               break;
+                       case IEEE80211_HE_MCS_SUPPORT_0_11:
+                               supported_mcs =3D WRS_MCS_11;
+                               break;
+                       case IEEE80211_HE_MCS_NOT_SUPPORTED:
+                               supported_mcs =3D -1;
+                               break;
+                       }
+
+                       for (mcs =3D 0; mcs <=3D supported_mcs; mcs++)
+                               cl_wrs_sta_set_supported_rate(wrs_sta, bw, =
nss, mcs);
+               }
+       }
+}
+
+static void cl_supported_rates_vht_cap(struct ieee80211_sta *sta)
+{
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       u16 mcs_map =3D le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
+       u8 bw =3D 0;
+       u8 nss =3D 0;
+       int mcs =3D 0;
+       int supported_mcs =3D 0;
+
+       for (bw =3D 0; bw <=3D wrs_sta->max_rate_cap.bw; bw++) {
+               for (nss =3D 0; nss <=3D wrs_sta->max_rate_cap.nss; nss++) =
{
+                       switch ((mcs_map >> (2 * nss)) & TWO_BITS_MASK) {
+                       case 0:
+                               supported_mcs =3D WRS_MCS_7;
+                               break;
+                       case 1:
+                               supported_mcs =3D WRS_MCS_8;
+                               break;
+                       case 2:
+                               supported_mcs =3D WRS_MCS_9;
+                               break;
+                       case 3:
+                               supported_mcs =3D -1;
+                               break;
+                       }
+
+                       for (mcs =3D 0; mcs <=3D supported_mcs; mcs++)
+                               cl_wrs_sta_set_supported_rate(wrs_sta, bw, =
nss, mcs);
+               }
+       }
+}
+
+static void cl_supported_rates_ht_cap(struct ieee80211_sta *sta)
+{
+       struct ieee80211_sta_ht_cap *ht_cap =3D &sta->ht_cap;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       u8 bw =3D 0;
+       u8 nss =3D 0;
+       u8 mcs =3D 0;
+
+       for (mcs =3D 0; mcs <=3D WRS_MCS_7; mcs++) {
+               for (nss =3D 0; nss <=3D wrs_sta->max_rate_cap.nss; nss++) =
{
+                       if ((ht_cap->mcs.rx_mask[nss] & (1 << mcs)) =3D=3D =
0)
+                               continue;
+
+                       for (bw =3D 0; bw <=3D wrs_sta->max_rate_cap.bw; bw=
++)
+                               cl_wrs_sta_set_supported_rate(wrs_sta, bw, =
nss, mcs);
+               }
+       }
+}
+
+static void cl_supported_rates_legacy_cap(struct cl_hw *cl_hw,
+                                         struct ieee80211_sta *sta,
+                                         u8 max_mcs)
+{
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       u8 mcs =3D 0;
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++)
+               if (rate_supported(sta, cl_hw->nl_band, mcs))
+                       cl_wrs_sta_set_supported_rate(wrs_sta, CHNL_BW_20, =
WRS_SS_1, mcs);
+}
+
+void cl_wrs_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+
+       wrs_params->rate_idx =3D WRS_INVALID_RATE;
+
+       wrs_sta->sta_idx =3D cl_sta->sta_idx;
+
+       cl_wrs_rssi_prot_start(cl_hw, cl_sta);
+       cl_wrs_stats_per_init(wrs_params);
+       cl_wrs_sta_info_set(cl_hw, wrs_sta, sta);
+       cl_wrs_sta_capabilities_set(wrs_db, sta);
+       cl_wrs_tables_build(cl_hw, wrs_sta, wrs_params);
+       cl_wrs_sta_select_first_rate(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+       wrs_pr_trace(wrs_db, "[WRS] Add station %pM to database (sta_idx %u=
)\n",
+                    cl_sta->addr, cl_sta->sta_idx);
+}
+
+static void _cl_wrs_sta_remove(struct cl_wrs_params *wrs_params)
+{
+       kfree(wrs_params->table);
+       wrs_params->table =3D NULL;
+
+       cl_wrs_stats_per_remove(wrs_params);
+}
+
+void cl_wrs_sta_remove(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, stru=
ct cl_sta *cl_sta)
+{
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+
+       _cl_wrs_sta_remove(&wrs_sta->su_params);
+
+       wrs_pr_trace(wrs_db, "[WRS] Remove station %pM from database (sta_i=
dx %u)\n",
+                    cl_sta->addr, cl_sta->sta_idx);
+}
+
+struct cl_wrs_sta *cl_wrs_sta_get(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       struct cl_sta *cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+       return cl_sta ? &cl_sta->wrs_sta : NULL;
+}
+
+void cl_wrs_sta_print_list(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+       struct cl_wrs_rate *max_rate_cap =3D NULL;
+       u8 num_sta =3D cl_sta_num_bh(cl_hw);
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Station list [%u]\n", num_sta);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
-\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|Sta|    Mac Address    |Mode|MaxBW|MaxSS|MaxMCS|MaxGI=
|\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|-----------------------------------------------------=
|\n");
+
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               wrs_sta =3D &cl_sta->wrs_sta;
+               max_rate_cap =3D &wrs_sta->max_rate_cap;
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "|%3u| %pM |%-4s|%-5s|%-5u|%-6u|%-5u|\n",
+                           cl_sta->sta_idx,
+                           cl_sta->addr,
+                           WRS_MODE_STR(wrs_sta->mode),
+                           WRS_BW_STR(max_rate_cap->bw),
+                           max_rate_cap->nss,
+                           max_rate_cap->mcs,
+                           max_rate_cap->gi);
+       }
+
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
-\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\n");
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+void cl_wrs_sta_select_first_rate(struct cl_hw *cl_hw, struct cl_wrs_db *w=
rs_db,
+                                 struct cl_wrs_sta *wrs_sta, struct cl_wrs=
_params *wrs_params)
+{
+       if (wrs_db->is_fixed_rate) {
+               s8 *fixed_rate =3D cl_hw->conf->ci_wrs_fixed_rate;
+
+               cl_wrs_fixed_rate_set(cl_hw, wrs_db, wrs_sta, wrs_params, w=
rs_db->is_fixed_rate,
+                                     fixed_rate[WRS_FIXED_PARAM_MODE],
+                                     fixed_rate[WRS_FIXED_PARAM_BW],
+                                     fixed_rate[WRS_FIXED_PARAM_NSS],
+                                     fixed_rate[WRS_FIXED_PARAM_MCS],
+                                     fixed_rate[WRS_FIXED_PARAM_GI]);
+       }
+
+       if (!wrs_params->is_fixed_rate) {
+               bool result =3D cl_wrs_rssi_set_rate(cl_hw, wrs_db, wrs_sta=
);
+
+               /*
+                * If new rate wasn't selected according to
+                * rssi (no samples) set rate to lowest possible
+                */
+               if (!result)
+                       cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta,
+                                               wrs_params, 0, false);
+       }
+}
+
+void cl_wrs_sta_capabilities_set(struct cl_wrs_db *wrs_db, struct ieee8021=
1_sta *sta)
+{
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       enum cl_wrs_mode mode =3D cl_sta->wrs_sta.mode;
+
+       if (mode =3D=3D WRS_MODE_HE)
+               cl_supported_rates_he_cap(wrs_db, sta);
+       else if (mode =3D=3D WRS_MODE_VHT)
+               cl_supported_rates_vht_cap(sta);
+       else if (mode =3D=3D WRS_MODE_HT)
+               cl_supported_rates_ht_cap(sta);
+       else {
+               struct cl_hw *cl_hw =3D cl_sta->cl_vif->cl_hw;
+               u8 max_mcs =3D (mode =3D=3D WRS_MODE_OFDM) ? WRS_MCS_MAX_OF=
DM : WRS_MCS_MAX_CCK;
+
+               cl_supported_rates_legacy_cap(cl_hw, sta, max_mcs);
+       }
+}
+
+void cl_wrs_sta_set_supported_rate(struct cl_wrs_sta *wrs_sta, u8 bw, u8 n=
ss, u8 mcs)
+{
+       u8 rate_idx =3D mcs + (nss * WRS_MCS_MAX);
+
+       wrs_sta->supported_rates[bw] |=3D BIT(rate_idx);
+}
+
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

