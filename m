Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979C03AB908
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhFQQMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:05 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:11146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233787AbhFQQKs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSXTDopIP5NPvW6w2/wvn5hev7T0eRaWvtyd8L//DrHo/jApQIPYYEYBt1EmD6m8HxHhCU1zIBzD3lQaRtZ7mDWou+wZGx5itQFGAo7Jo2/Ti91vTYgMGaHx0XXWqE3FNVe9w4YlewakMdO8bgmh8X4L3du3rifCljSgdxLCfZtCB6ra9r80up5Zt25d+7scxD5hXGnyui/dXPNoIDf3pynMJwJePgtQyJSc5SGM/dBoh7b+yCxsMM2Ym+yaQ4KarnADjpfW8TJ9bNenO/0CMaEiUVDcVSU+/oc6/4MA+S0kmHYEQaWqjqCIYwxMg+/m+xCqEfOewBvmAdPr+DGVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXSAYy+bXQPp0mLXlgRkmQaY4AJBCSOdtj2ck2VrSjc=;
 b=YdPkCo6i53sXRQPrXGihp9aWl2kCFe1XfFFeJSUt6km44dTR4exWq8+1WVNSFZl0zO0oAxIE6h3Bq7RExN+//0GD3vfxMtB5OlM9UMXkQDsh/e2gY7FNLqbLRFUl0PhMT8cXvkSqvaY2L6xy8anby2cuQ/qYI3O8Yylj7bageQV2yOIkK/bYAJ5AlXtBoOLB/sIr3P560Uj1kyXQtXKdPIVwn2cIsP3CkbtJkYwBX3VWur9akOsBHrYpi4EVnUCZPzAzUbPSb7yG3fJeKps7menxeTDj3n0vYyYuZOJCvLDeD4gORW0Nov4j6P08MKKakIJjSMwAGA8B9MU9XTffjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXSAYy+bXQPp0mLXlgRkmQaY4AJBCSOdtj2ck2VrSjc=;
 b=dw2aZnz+Mz9Fwhh2qw2T1ZY+Yyqa8WwXmmWoCzEZE2KmVIYF7xeQRXf+L05TrS5VW4zZ1APiLwFrNhDZL6/nLZWpbvBpfGs7BY8wtP/3NRPLYTXQ5s2YzKZ3Bdqf+H3wZ8fSzSFGYWk7TQpdVRk+WFQFolpTxaMqp26RgK51zG4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:32 +0000
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
Subject: [RFC v1 241/256] cl8k: add wrs/wrs_ap.c
Date:   Thu, 17 Jun 2021 16:02:08 +0000
Message-Id: <20210617160223.160998-242-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0c8b2fd-2063-4653-c96a-08d931a9f215
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB097830A609B2F40225B52EE2F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tcj6EOuZzk21DjAmbRKm6QzFtUPtrWHRAbdHIC2o6St3x4g/8Syn3G/G6W3UmoxEkNCsHkX5EO4g91kL9QazScrF+VOrW4URI/NsABZOfPcq4wCQ13cL9T0EGU+ka2kU0wZFC5WB2i2bg5gbkEW8eEjCn35pwkL85HRxex5dUA//tgU1mprNJM2NpKbNdzI+bUVuI0OBL8Iw9JZq+Vo6f96nfip8TG05gWehKBl1oNxhDdoSNtAhGEcM9NDeRSiznlzTqthuvlhgnxV4OF6HbGClswQH8dNhagZG+B+jJ2koE6pLlmYGZfQdB2g098z2Hm2Kck0z2Qk7ExqLEXI9XD7R381zvY/Y7sYiW+5S4dGzznlHQXzdHbPUo+4b32WMM8pfQqI1Bx+kNKvCCKW6n0I7XJLFnGal9hmR0jq+bqKzvR5ACY9RMQhZfQxR3hdULmzyqE/5+t8XbSsxcHpdWb1I/EsaHgEZAGvtUwVHBggid/hRBymFUm9uRzIVYYuClns2Xm0pyJD/gcG+I7SaaCiXy5S/48/r7ixFfqLeo/ecks1ROkN7wpfitTQUUZA6sLok4q24gu9mI6/VuFTEk1twUP2ZmG8omeYp4clir4V08UGr0Az9vS/ByMV2ntirQdtImuvRWAD1Bk1Z/R72j/XOCa/7rfRkwLugpQT+Wz5Gceyxk2oogMIqSb+TVqZXMpxlNEvFB2VZa8zKIniqDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4eQ8STadqusGwRv/Tm25PBVSW0DZ2oWVHszV0gqAtycW7Fq/9woSjUUtQBcD?=
 =?us-ascii?Q?B5EG1ndtAzhpDkn1Km22k6lgigMp4TUKORISTzk39qEYin0RiqIRfIvavSNO?=
 =?us-ascii?Q?y9sudQnOpKSee0/hUwJUN4SD13FUAl3fPRaSESm3AcEUz8VSNicZ5jknSoIt?=
 =?us-ascii?Q?nP/h38ievjheA+EfEC+Zt5FQw2u1FsPhvf31t+se5RqoNUV6AjMbKysmmqOw?=
 =?us-ascii?Q?lsYfHsHt4F3ympf64al1ioraclbjezq+HKZvrZbS5CPDnSWNpjVK68GpemBc?=
 =?us-ascii?Q?BSj3pqp10EYcYQI7sncg1fmP+lLeIbGoslIALLYc8t6v8OUUIH3Tr7EwjE5g?=
 =?us-ascii?Q?rpJ1mgEGEgvvlaUVDgmVzotAuuQ2t0IueJMiH5KrZuREpWQgE+MoviX9lwFf?=
 =?us-ascii?Q?XyZipruRhc2ilHj1/jFNz7ZNSNyhFa5JnvzCdFSrgoR5gcsXCh1bQFigWTZI?=
 =?us-ascii?Q?GBsgCKZrzLeHjBlU4P8XZlsJrZKDtJ1Fmr/uqhNz/Lpwe+OR7wMngJD/d+gz?=
 =?us-ascii?Q?QFCD90Wbc+QpJGQNIW2Fh+shzZxF4Mg7mZ0yDL/LwzEQBHkMS4EeSclammJ0?=
 =?us-ascii?Q?3/84EVes7W7+L3g2CD7p7UnFXG6cCl8UQ0oLwNRxhcyJZ6eStKI0xqw8ASyv?=
 =?us-ascii?Q?2nmCwnTILe6I+7E+86EMc1Ki46ZKR/IeOvx9bWwfKywqcB6VWy2UUnIIDfLv?=
 =?us-ascii?Q?gnp0vVuhOMLOO65WuSMMof7h1YP+E2TXALkuYZN8G/YzgmZ8zFjImqTv1+AZ?=
 =?us-ascii?Q?mlHyUqsmtINwzIo7M2qYr3O+IpMH2OtO9bP3prPsuRl1uHi+EoC/ze1Kpnei?=
 =?us-ascii?Q?1RtkdMP8QAT//Kzc3Chui1UQ3BTQlmLqEvZ3NoKw1+oXKIAMKLlKVJqrKI5X?=
 =?us-ascii?Q?7KSAzIPdiNS5VZvKKKUHO4dTJ6DRqWRN60fXOl0qn30h0waYWayLfEDp7YBD?=
 =?us-ascii?Q?w/jxmEUt89Xj8Qy7q751wW7BRYCl6y0GIy53geueu/cigVOAqw2mR/iTSiaN?=
 =?us-ascii?Q?oEjfoue9eFnBTJmt7yuQhWPyjSnOmZgXewJ2U61m4y+fEo5zdJEYmFjKQNLa?=
 =?us-ascii?Q?7lQhrDVC1wzR02lRzxkr7YZcqzdoNpOarkYPZZVRHozWxGSS/LKdPNK1kEJf?=
 =?us-ascii?Q?hiXhbuwc0D1cRdxunWa1Lnel8GT5MdKr14J49dBJPotKeZtfUgLdNIpARiUt?=
 =?us-ascii?Q?3nElk3uCDs4s5AeAw8fGyfJXF97BFBI4Xho3LoKEQoJwZmaKNUK6RVvqVQX1?=
 =?us-ascii?Q?oG7W+KkMrtpBXhJxP37b0T4DQJc6atsN9LSY2exRK7qnNRa92KJfocw6ReTw?=
 =?us-ascii?Q?eGoGTD0611z+dYFRyQ/9Kqwy?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c8b2fd-2063-4653-c96a-08d931a9f215
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:03.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PibeUNrj9TMzsfO/AVK94/jV92Ug8bI8tlPdwBkazG6BqPVBXM/v8MhHwbOnklzG8uQU7SdTlw77BS2AMOa4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c b/drivers/net/wi=
reless/celeno/cl8k/wrs/wrs_ap.c
new file mode 100644
index 000000000000..8ac8f7f8c644
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_ap.h"
+
+static void cl_wrs_ap_set_bitmap(struct cl_hw *cl_hw, struct cl_wrs_db *wr=
s_db)
+{
+       u8 mcs, bw, nss, rate_idx;
+
+       memset(wrs_db->ap_supported_rates, 0, sizeof(wrs_db->ap_supported_r=
ates));
+
+       for (bw =3D cl_hw->conf->ci_wrs_min_bw; bw <=3D wrs_db->max_cap.bw;=
 bw++)
+               for (nss =3D 0; nss <=3D wrs_db->max_cap.nss; nss++)
+                       for (mcs =3D 0; mcs <=3D wrs_db->max_cap.mcs; mcs++=
) {
+                               rate_idx =3D mcs + (nss * WRS_MCS_MAX);
+                               wrs_db->ap_supported_rates[bw] |=3D BIT(rat=
e_idx);
+                       }
+}
+
+static void cl_wrs_ap_capab_print(struct cl_hw *cl_hw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_rate *max_cap =3D &wrs_db->max_cap;
+       u8 bw_mhz =3D BW_TO_MHZ(max_cap->bw);
+
+       pr_debug("\n");
+       pr_debug("AP max capabilities\n");
+       pr_debug("-------------------\n");
+       pr_debug("Band : %ug\n", cl_hw->conf->ci_band_num);
+       pr_debug("Mode : %s\n", WRS_MODE_STR(wrs_db->mode));
+       pr_debug("BW   : %uMHz\n", bw_mhz);
+       pr_debug("NSS  : %u\n", max_cap->nss);
+       pr_debug("MCS  : %u\n", max_cap->mcs);
+       pr_debug("GI   : %u\n", max_cap->gi);
+}
+
+void cl_wrs_ap_capab_set(struct cl_hw *cl_hw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_rate *max_cap =3D &wrs_db->max_cap;
+       u8 conf_bw =3D cl_hw->conf->ce_channel_bandwidth;
+       u8 conf_nss =3D cl_hw->conf->ce_tx_nss - 1;
+       u8 conf_gi =3D cl_hw->conf->ha_short_guard_interval;
+
+       switch (cl_hw->conf->ce_wireless_mode) {
+       case WIRELESS_MODE_HE:
+       case WIRELESS_MODE_HT_VHT_HE:
+               wrs_db->mode =3D WRS_MODE_HE;
+               max_cap->bw =3D conf_bw;
+               max_cap->nss =3D conf_nss;
+               max_cap->mcs =3D WRS_MCS_11;
+               max_cap->gi =3D conf_gi ? WRS_GI_VSHORT : 0;
+               break;
+       case WIRELESS_MODE_HT_VHT:
+               wrs_db->mode =3D WRS_MODE_VHT;
+               max_cap->bw =3D conf_bw;
+               max_cap->nss =3D conf_nss;
+               max_cap->mcs =3D WRS_MCS_9;
+               max_cap->gi =3D conf_gi ? WRS_GI_SHORT : 0;
+               break;
+       case WIRELESS_MODE_HT:
+               wrs_db->mode =3D WRS_MODE_HT;
+               max_cap->bw =3D min_t(u8, conf_bw, CHNL_BW_80);
+               max_cap->nss =3D conf_nss;
+               max_cap->mcs =3D WRS_MCS_7;
+               max_cap->gi =3D conf_gi ? WRS_GI_SHORT : 0;
+               break;
+       case WIRELESS_MODE_LEGACY:
+       default:
+               if (cl_hw->conf->ha_hw_mode =3D=3D HW_MODE_B) {
+                       wrs_db->mode =3D WRS_MODE_CCK;
+                       max_cap->mcs =3D WRS_MCS_3;
+               } else {
+                       wrs_db->mode =3D WRS_MODE_OFDM;
+                       max_cap->mcs =3D WRS_MCS_7;
+               }
+
+               max_cap->bw =3D CHNL_BW_20;
+               max_cap->nss =3D 0;
+               max_cap->gi =3D 0;
+               break;
+       }
+
+       if (cl_hw->conf->ci_wrs_max_bw < max_cap->bw) {
+               max_cap->bw =3D cl_hw->conf->ci_wrs_max_bw;
+               pr_debug("[WRS] Max BW limited to %uMHz\n", BW_TO_MHZ(max_c=
ap->bw));
+       }
+
+       cl_wrs_ap_set_bitmap(cl_hw, wrs_db);
+
+       cl_wrs_ap_capab_print(cl_hw);
+}
+
+void cl_wrs_ap_capab_modify_bw(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_=
db, u8 max_bw)
+{
+       wrs_db->max_cap.bw =3D max_bw;
+
+       cl_wrs_ap_set_bitmap(cl_hw, wrs_db);
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

