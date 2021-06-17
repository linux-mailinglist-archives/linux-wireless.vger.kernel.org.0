Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E373F3AB90B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhFQQMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:08 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:36864
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232626AbhFQQKx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4MrOMibFd6KN3BFYk8AdG1M3aKL/TdzOkhmd0zabGpIfj1zQ2mOTCM0ln8k4gZkq/zSje8NXcevIBrt95fS8SltQbbxUe+vN0ktcGk1SDDsSo1vqP4B9wz/INZpKsPVvPA/6WYH7nMxUXxF0g423DsXVbX2nhaNEPUEghVulOrvCRJyPBBcOqmdv9GEXW0Vxyzzut3/qAaERu2Baq7P3uKE/mh7JXk9FVFtgqPykEjDN7XP82hH2gBTiPJBF+IMa3FaOzjX634yJj976Q7iDnSSb0bL58H+xdxt0OKfVcsZTyOfdr9jQRK8zEebtG8DUR21rd03x9++cdc58DFdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo0bQGDDdPp/AdKeM3MPNfMIMsobXAZGUwPpOb5nXBA=;
 b=k3JOz9766765hNgRrgQfA8/A07oVYBE6gwPjqjDrBKczVDbG003K//di45TK3WCGVEAUvDMriuDZJiLUDoF+WryGj+1NFeKyNQVjelIu5hYtWfgK76Dn+DlAWNVDg4SZ6iTNtmBocAnuEY8Cl7XGR3c5VW6nprmtHN29cAlQSDbnCbkXMhsY2TV6UwYQ/He3CbMVWCq5l1qTZddP+4cCDDUkEqaTBdhnsVwR7CqvXFv4hQ3xcV0qBd6TmfJ1Ysgh0kVFzg3AxC2pocajfaudo46DpiY6VY2QT1vKnSf9XJFcAbQUxug1LCsT+AYQ5x7ZJ3cTNoQNpr4WEv9D3vKmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo0bQGDDdPp/AdKeM3MPNfMIMsobXAZGUwPpOb5nXBA=;
 b=VU6mNi/1SqOLqNSjCEDQgNY6H3WhBRJHjQ2qWJ06lIBS7x6L9+UaYitmkhur5wvlH1uuP5lSHQgKUewtCea5J4Eoa3cczoNywv0z5YZiApHB8ObKl+2iAiKjT+dfhlpnpDkfqtruEJPK68SQ2rZryXKR68+0mOY52hVc3lQoaA8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:33 +0000
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
Subject: [RFC v1 243/256] cl8k: add wrs/wrs_api.c
Date:   Thu, 17 Jun 2021 16:02:10 +0000
Message-Id: <20210617160223.160998-244-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: befcea40-c2fb-439e-b071-08d931a9f389
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB097897D9C641AC3CD4D72176F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZQuOZkdlpiKcUNjJdUgqE/eqLuBwUILytjKDD52odzZIL0XzfClXJcqSlwSguqeSgYUxDftYvPX7a+9muO48wRLYhizqsWEFdQyYlYu9x+M0GbQmAPeEX7HMVySiAMyhhnbp7IyVR1ELuHfYazMx6gnv69w/WOCnnSs81YNlw5IpqKXYh7h8YxfM0KwZ3URKcwLyEJG5VB0oOuGyRIk4vj1vmWpwd7k48WHAnyRHHyB1lOD6dpDWFDab3MzIQZJca1o67tqetpXFeA8/5NeP46wxJ8ge+ZdWFr5lKE6rZocvCoYMyTnu/Fm9fNoXonLGej8Xz2Sa60WlvFN0JjkAG/+1ubteOG+/y4wd07hYfjT0cg2W4GfVnSmZUzekjnsgKEEWKZkpiQpg28ZRGNHuDzkViNsrJB/yGKmo13WpACFy/EUkrG5XjGeJ7HsH1mn9luGmYmd8AZYLJgrnzlkmaM1q9tg7JDMYQ3sHiOApKqw13vIT0rYv2ROkMtRsnF2iX90+ucT5iNk0cPHYdol9xCQbQ0SA1sl360/jbwOCG4jBnsjCbaMyVHM3tYejyenCFofdXPGaxCRlJcYvBosLo1qNwmfpCTBspWVUnXc90D700ZF+H+YIbiEXDMPRyyCcSMpWqYIHAIhbyTLLG68g56OKiRCCI6t+4jNFVLCLH5WrzGuhVXHT29pnbsS2i3qVUxwpIUpnnaTh+8GDNfCvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(6666004)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DU+qFbE6aqwh++kDmQ4MvRLMwUH37ujM7tkWH869PLik24L1CZ5xrgsRm2k5?=
 =?us-ascii?Q?qN0/pcdpW8/Mjcdbld/OpSqdR8A4EmKHFp0AsxEpsdApefER8sDBtrdCHL0o?=
 =?us-ascii?Q?HI0K1eYEu3WoRMD4NKuTkB6JWmaiXfa3mcQBwqVpuc2olK357rdF3vgiERxX?=
 =?us-ascii?Q?U9bbSLUnfVXydwCTZLugt7fn/V5IArCxIh/gbk0wdbI5jX6hb/mn5IVZAFEp?=
 =?us-ascii?Q?js7NgGwTm1bvaF2hARKGjJEdOKyqohqL7hE3AbpD+Ow4fMorWs2U4EOCQDvO?=
 =?us-ascii?Q?7Dv72Vhk33MBm6XzLNqVv10t6UUOXSST3dnfYHle2yppSZM6iQZBRTA9LN+x?=
 =?us-ascii?Q?FQ2qIPi96Jy2u9njnb1GnyFLoLb661z9Hzu4rB45+TLUJYts0MmzGgNK39OG?=
 =?us-ascii?Q?s67444KwaV5RI2s7bMuUwz8uq9RVTUg8yzOrj39w0lhK4KI9LSRLJj0fdR2u?=
 =?us-ascii?Q?b6L7m427UxfpsMWy7dSxbPNF1xxIvlnBj7CdomvadPJo8GoVFrkA5pdqCZlm?=
 =?us-ascii?Q?DPgFtyvdLGVYFRflCx4k8jUxbdTJD0LAFhHoolRoDx6QEHUnR0gfQsPrRMVj?=
 =?us-ascii?Q?GpaAjVxH57uCNXedUkTEpB2xc1Op2CD6QVzKDPZhWkaIeyQ4MSRnkToc2bEt?=
 =?us-ascii?Q?zdLCQSq5GYaA1FHThkGCrvAL+ViYjsvng5E8cqHRJCQYADGck2SzlSCuLmTV?=
 =?us-ascii?Q?w3a1ozw4PkdISdGY7kqxcmF/8ygpZiYQBiXMVMT2c+uc8ziScSSPcUuYVSuC?=
 =?us-ascii?Q?GGRMewVkMo+b2JPbdba7tVcCBX3edCU5X6F9ZZTrEMkxAleUvCFECfCEd8EQ?=
 =?us-ascii?Q?B7V93msp0h/Ej/2jeApC/Lpsn/yXlRwTRELev5bahMWH8HuHbLfm2TLTJ3ri?=
 =?us-ascii?Q?+uNnrWqQppnS/FTcFgzaSqUa8mI1OYr+zNYKneOE/UTCG2RgtJU+DIbFeILY?=
 =?us-ascii?Q?PKLH0B/C74e6HFIdy0IU2KeKYr4zXvkVEJySCC/cOBcumCiuo1w7zoFQFeUr?=
 =?us-ascii?Q?B+qGCmF2lmtvieX9RR4SGpfUi7+ocUG8ruND94gkai5b1w9h2mwRNjSB7P+r?=
 =?us-ascii?Q?pJ+iOq7367o6TbaLeXcbFxer4hecbZh+zQcgEk+mms5gjESaxUcILuRROSXF?=
 =?us-ascii?Q?rU+h4URuIok+fOGml5xnfVaGGvTqXvpdXdcognagp2xhCRtGF1vskwuFMi3g?=
 =?us-ascii?Q?+JJU95Aab13cSeGWNFEA65ujxHxpKpCyXZ/ih4SHIkZ2nZxPXAggnRnHehi8?=
 =?us-ascii?Q?pfgz5HmlIemBy9dqqI1fUSfWziCy8Y1t4qTJuv3WOZgG/FIMPqzKayILfl7i?=
 =?us-ascii?Q?6/EnX6Q+E/GF+AGboYSIooZ4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befcea40-c2fb-439e-b071-08d931a9f389
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:05.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJdpJEK67ItwSk4tTqosweWLrVyKwHKJslqBGTH2Hvb5w2DuBu7gJM/CPxpkybitlYJkZ9GA7XK3KRE4J4rF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_api.c    | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_api.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_api.c b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_api.c
new file mode 100644
index 000000000000..180f234eae5b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_api.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_api.h"
+#include "wrs/wrs.h"
+#include "wrs/wrs_sta.h"
+#include "wrs/wrs_ap.h"
+#include "wrs/wrs_cli.h"
+#include "rate_ctrl.h"
+#include "prot_mode.h"
+#include "utils/utils.h"
+#include "band.h"
+#include "sta.h"
+#include "data_rates.h"
+
+void cl_wrs_api_init(struct cl_hw *cl_hw)
+{
+       cl_wrs_init(cl_hw);
+       cl_wrs_ap_capab_set(cl_hw);
+}
+
+void cl_wrs_api_close(struct cl_hw *cl_hw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_timer_disable_sync(&wrs_db->timer_maintenance);
+}
+
+void cl_wrs_api_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_lock_bh(wrs_db);
+       cl_wrs_sta_add(cl_hw, sta);
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_lock_bh(wrs_db);
+       cl_wrs_sta_remove(cl_hw, wrs_db, cl_sta);
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_bss_set_bw(struct cl_hw *cl_hw, u8 bw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_lock_bh(wrs_db);
+       cl_wrs_ap_capab_modify_bw(cl_hw, wrs_db, bw);
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_bw_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta,=
 u8 bw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+
+       cl_wrs_lock_bh(wrs_db);
+
+       wrs_sta->max_rate_cap.bw =3D bw;
+       cl_wrs_sta_capabilities_set(wrs_db, sta);
+       cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->su_params);
+
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_nss_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta=
, u8 nss)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+
+       cl_wrs_lock_bh(wrs_db);
+
+       wrs_sta->max_rate_cap.nss =3D nss;
+       cl_wrs_sta_capabilities_set(wrs_db, sta);
+       cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->su_params);
+
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+static void _cl_wrs_api_recovery(struct cl_hw *cl_hw, struct cl_wrs_sta *w=
rs_sta,
+                                struct cl_wrs_params *wrs_params)
+{
+       u16 fallback_rate_idx =3D wrs_params->table[wrs_params->rate_idx].r=
ate_down.rate_idx;
+       struct cl_wrs_rate *rate_fallback =3D &wrs_params->table[fallback_r=
ate_idx].rate;
+       struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_params;
+
+       cl_wrs_tx_param_set(cl_hw, wrs_sta, wrs_params, tx_params, rate_fal=
lback);
+}
+
+void cl_wrs_api_recovery(struct cl_hw *cl_hw)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+
+       cl_wrs_lock_bh(wrs_db);
+       cl_sta_lock(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               wrs_sta =3D &cl_sta->wrs_sta;
+
+               _cl_wrs_api_recovery(cl_hw, wrs_sta, &wrs_sta->su_params);
+       }
+
+       cl_sta_unlock(cl_hw);
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_beamforming_sync(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_params *wrs_params =3D &cl_sta->wrs_sta.su_params;
+       u8 up_idx =3D 0;
+       u16 rate_idx =3D wrs_params->rate_idx;
+
+       cl_wrs_lock(wrs_db);
+
+       for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++)
+               wrs_params->table[rate_idx].rate_up[up_idx].time_th =3D WRS=
_INIT_MSEC_WEIGHT_UP;
+
+       cl_wrs_unlock(wrs_db);
+
+       wrs_pr_info(wrs_db, "[WRS] sta %u - beamforming sync\n", cl_sta->st=
a_idx);
+}
+
+void cl_wrs_api_quick_down_check(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a,
+                                struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_lock(wrs_db);
+       cl_wrs_quick_down_check(cl_hw, wrs_db, &cl_sta->wrs_sta, wrs_params=
);
+       cl_wrs_unlock(wrs_db);
+}
+
+void cl_wrs_api_rate_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                         struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_lock(wrs_db);
+       cl_wrs_tx_param_sync(wrs_db, &cl_sta->wrs_sta, wrs_params);
+       cl_wrs_unlock(wrs_db);
+}
+
+bool cl_wrs_api_up_mcs1(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                       struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       bool result =3D false;
+
+       cl_wrs_lock(wrs_db);
+       result =3D cl_wrs_up_mcs1(cl_hw, wrs_db, &cl_sta->wrs_sta, wrs_para=
ms);
+       cl_wrs_unlock(wrs_db);
+
+       return result;
+}
+
+void cl_wrs_api_set_smps_mode(struct cl_hw *cl_hw, struct ieee80211_sta *s=
ta, const u8 bw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       u8 min_bw;
+
+       if (sta->smps_mode =3D=3D IEEE80211_SMPS_STATIC ||
+           sta->smps_mode =3D=3D IEEE80211_SMPS_DYNAMIC) {
+               /* If RTS is enabled, there is no need to go down to 1ss */
+               if (cl_prot_mode_get(cl_hw) =3D=3D TXL_PROT_RTS)
+                       return;
+
+               wrs_sta->smps_enable =3D true;
+       } else if (sta->smps_mode =3D=3D IEEE80211_SMPS_OFF && wrs_sta->smp=
s_enable) {
+               wrs_sta->smps_enable =3D false;
+       }
+
+       cl_wrs_lock_bh(wrs_db);
+       min_bw =3D min_t(u8, bw, wrs_db->max_cap.bw);
+
+       if (wrs_sta->max_rate_cap.bw !=3D min_bw) {
+               wrs_sta->max_rate_cap.bw =3D min_bw;
+               wrs_pr_trace(wrs_db, "[WRS] SMPS mode: sta %u, bw %u\n",
+                            wrs_sta->sta_idx, min_bw);
+               cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->su_params);
+       }
+
+       cl_wrs_unlock_bh(wrs_db);
+}
+
+u16 cl_wrs_api_get_sta_data_rate(struct cl_sta *cl_sta)
+{
+       return cl_sta->wrs_sta.su_params.data_rate;
+}
+
+int cl_wrs_api_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_=
params *cli_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       int ret;
+
+       cl_wrs_lock_bh(wrs_db);
+       ret =3D cl_wrs_cli(cl_hw, cl_vif, cli_params);
+       cl_wrs_unlock_bh(wrs_db);
+
+       return ret;
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

