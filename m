Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB83AB8EF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhFQQLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:17 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:32846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233729AbhFQQKH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsWQQ4slqQ1Q7WxPYz9uXF14lVTChGImCL+cGTsIIn/qPZB/AxxllHkIEz6tQaQJROflXWKl/ipN0ptbaQcVFcJGFfXcmnJ7e5XJDeOTAQEAhxq1D4NmwouaOpIQv36u+ZMVEW2TVJ0rjUTcrLMYUKnZPckkv4PCtMiUGt6zmeEPgNY7o1c5vu3+BIwQPhOPQK9vmrQ+KNmerfqS1LjStGxVd7y+oXgNOhATeBOpPBjfcbTYBUXxn+SbGFpvJUJrwzImz5kSOkGoeMRJ/75GJTu6zDdsznjUzQdbMC6PPBNGcrVcLH8rsK8zKIqy7oOui+WyrhIlWg4rGeXGH+gLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hZdk7k70XSVKxVKV2BeSsFsewnI2AwuagNgASorCCI=;
 b=WR3SznZi5/Y4Cex3K7/B8OBgLsI43xIswvZWsxa8CRpk2LkEjNtWhFvtr8CTnmsf4hOV2BFcsVbhUf6C+wLnx87JxWL+A826sfz03R2mRv0d6D8uo8VzSx6TSSd0sJxfleNpK0U+CYbQoi53/ohu6yhqglaYX8ROvUT8SP/gm/SAiirGhu9fLGDyZwmbGRfR1lBQai/3ErKqbjSytW4eoO3hX5Pt1eiVNzfX/o/feFh2EUPc5xW+JsmFbyOq+3u7PZ/q2kxBACO/iTT98pKFTnmFs79JKoCPKQHqc2P0pvWQrUd2tCMstpNZAImVGl0Js8FikHF2qCEENvVjdfTNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hZdk7k70XSVKxVKV2BeSsFsewnI2AwuagNgASorCCI=;
 b=F8oTBgBUuOvfbogcGHGORwGJIVwllYIB587Uuj/0iFjujdyKwS9/7oqs15rKXyREPMqTyC49ul2L6uSd1QtqrjmLvaWkB5pJNLmfHwQbnrM+/apadcAMlmhSzc0L8Oq93uxYhxaTGXOHFLKv/4IHbRGvbzHsP0j0UTHRvXBYidA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:08 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:08 +0000
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
Subject: [RFC v1 180/256] cl8k: add sounding.c
Date:   Thu, 17 Jun 2021 16:01:07 +0000
Message-Id: <20210617160223.160998-181-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550d6e54-7a25-4d53-1581-08d931a9c831
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260F0D35E10BFEE7A49A930F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9KnR5/W69MRh+zJ+KA/N/WTiLKFiOPDxC1SVV2duqLwc5k9CWm52mxdVODsZ4qESXuzCxSED3RE9TdwfrrsYipDR6VOEN6EbFlz/mwx/c+SeRz0mCAJAHq2WfMJ1si0HVDaV+0Q92YATUw+N6yBI4pUHRQUS5uNARb+T5kfEM0Q1NwT7RpcfEO4YopyosadH5WQWtf7wsAEddqhX+Q4s8iLbX81/EwqURpHZUJ/YXmLyqpfilcKm/OU3qhrZWbgu3mjEpO+XJcsKs5aI+t/rOy5ykLx/6HcxySITOlNSZj3sRxIhAWDpRDu9m2BCnCXH56OHqPuneAsEGxbAJoa8tGUtPY6KEOX8vtmrtcObvZIjrd6daRnF1j8QWWfvkEivVpRTVonkn+6r6SnY38GvdITycEh6XnnjcdYR0sb/4KJAKbff25nRQaQY8RGPCpFBRWFEW5MhUAoYl0GieutaL32XaARklyF3lp4ij5J+RS3MINddXrN0u/JqSnJ/59s8t/N5gKuuUgJB/pbaVSGmb2TBNfjaINuhvF5fzTBkNtCqmfW9EZoWIPtJ6XACGO4humqs7Z/IrYgNsGVqg1ingOEcfvCquJrdXlrN5+BcL0okLVI8HNg2S1PW+nUF/RJ10EBFu+71bSWJGX0O5g2mJstspGSO1Mclqm0+0xMpBKVCJmKuYQgcDcvm3acl8Vku+6V131hK0IeB2zDmKcbDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jo+ifzXbIHeX+u/+LamGL+hX5vgGax2BGc7niu231XD1T8IDqhEjJsebrEZs?=
 =?us-ascii?Q?F8oTBMwu1KTJmPDIXq1KVOSPetGB7sCOLLFyF+hiAw5pojHCI0L7diY82Xha?=
 =?us-ascii?Q?uJpKDdn5fqDSeezbsXuL71csRZxEepfeksNVQBe0K0fK5ayP+tTYXUx0Vd63?=
 =?us-ascii?Q?5rF4CQPToDfUFDjXoOzclwHU4jUThYb2sfv/MHcNpL7h6fEgIO02mQuUapdi?=
 =?us-ascii?Q?LhTdTKVUHBLTKRrRYSJRVrkJTzre4j7JZyYecsn2xfDf1V3w08865E7BLV1S?=
 =?us-ascii?Q?kPt3dmEAZpfWQQtjkw+pyChO4w+JyNdeu7n01JQOrxkHpbr1rXloJNaoAybW?=
 =?us-ascii?Q?acKXfaJ63CSXumnQdmKSq5AzjIrgs+oSZGrlP9quKX8UQP+osqKHvdqgSq65?=
 =?us-ascii?Q?FNyFLc0BcSVyzFPpWj9yYXkiGRc262PgoQghF+niyIYGrkK9oilTOSe+OSR/?=
 =?us-ascii?Q?Ny0/9fhoWAvbUsxMWWLEkI/Nq+AiztXeADkgnPDwYCxq36EypP9k++/yu0D7?=
 =?us-ascii?Q?qYbFY6U88c0orlEJNhbFKP5LgVODcYi827xZtKs+uBkRLy8PPh038SxG0VcB?=
 =?us-ascii?Q?Nc7UbjsKIa6DhzqDVwc/H71Fdp+HNM8II/NRExrAPhXqwAaBO+7wO6+SfUdg?=
 =?us-ascii?Q?UL65N72/w/8G6oSPau6K2O81L4bM2FR/dxKYiqgKiBjBIGbqdO/wJx0BCwXb?=
 =?us-ascii?Q?6Pbpo/qHDuJ3Ckynarlw8SSRGj1jcVBniI7Jl5/0oY4e1fK/u8HTg+nZkqwx?=
 =?us-ascii?Q?sOTe+CLFfvT2gIA/r9VzPYTtKSG7J1g+J/T0bWFmkojkq6Et5hU1ShsCzGXL?=
 =?us-ascii?Q?e1TgNUadUAujjpebWbKONUhPSozwenctYW/Mg1vSTimpSTzTRnSNLNRWDllY?=
 =?us-ascii?Q?NwUM8WQZqwBp0V0+DY0qm60nGYzrKbGFi/adK0TGlQBL9+5TtHLUYKw2HXXv?=
 =?us-ascii?Q?VozTLu7emI3xJmFdfbyEw0a/B5XGB+m1sWow2OStjsVQpwORQ6NoQrwPsmIy?=
 =?us-ascii?Q?5dct9MACnkM0KdibZUPmEi1bY6/7KpeaNVPQJqVYm7IM75PqJ5gdgth/8GCs?=
 =?us-ascii?Q?p87pTBnACcKrRs2JIfL+BVWzzgp2Vdb0RH0hcj7B9PyR6wc8k84QNDyi9XiP?=
 =?us-ascii?Q?z5xGYb6XnnJr2z2ePZlDEMVQaa7OB7fkL6ybYr4S3zb1Zhat/zaPaZdmQ4LN?=
 =?us-ascii?Q?3c2377fQFOK981+QO7f3+3weNU7krsGPINuTFoR4G9cdszG8PbV/NgS2tJ2U?=
 =?us-ascii?Q?SWvyRvMNsdWzO1GUN3lLTCRqX22c7esMNLEH0jNco1P+pCZXCYDm0RSEuu3o?=
 =?us-ascii?Q?UgmLKAjsd3vQNDaBZRKh+fkL?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550d6e54-7a25-4d53-1581-08d931a9c831
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:53.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTq5I5q/zbW2pEfMddq1Q4E8EeKoU+0JcpG8CyJUfJa6C3cZxVEndZOvIohHwMneydqgQQ/KvvmmKZpBKHIxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/sounding.c | 1432 +++++++++++++++++++
 1 file changed, 1432 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.c

diff --git a/drivers/net/wireless/celeno/cl8k/sounding.c b/drivers/net/wire=
less/celeno/cl8k/sounding.c
new file mode 100644
index 000000000000..a51348eacbe7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sounding.c
@@ -0,0 +1,1432 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "sounding.h"
+#include "fw/msg_tx.h"
+#include "debug.h"
+#include "bf.h"
+#include "chip.h"
+#include "band.h"
+#include "recovery.h"
+
+#define DBG_PREFIX_MAX_LENGTH 64
+#define sounding_pr(level, format, ...) \
+       do { \
+               if ((level) <=3D cl_hw->sounding.dbg_level) { \
+                       char __dbg_prefix[DBG_PREFIX_MAX_LENGTH] =3D {0}; \
+                       if ((level) >=3D DBG_LVL_TRACE) \
+                               snprintf(__dbg_prefix, DBG_PREFIX_MAX_LENGT=
H, "[%s][%d]", \
+                                        __func__, __LINE__); \
+                       pr_debug("%s [Sounding] " format, __dbg_prefix, ##_=
_VA_ARGS__); \
+               } \
+       } while (0)
+
+#define sounding_pr_verbose(...) sounding_pr(DBG_LVL_VERBOSE, ##__VA_ARGS_=
_)
+#define sounding_pr_err(...)     sounding_pr(DBG_LVL_ERROR, ##__VA_ARGS__)
+#define sounding_pr_warn(...)    sounding_pr(DBG_LVL_WARNING, ##__VA_ARGS_=
_)
+#define sounding_pr_trace(...)   sounding_pr(DBG_LVL_TRACE, ##__VA_ARGS__)
+#define sounding_pr_info(...)    sounding_pr(DBG_LVL_INFO, ##__VA_ARGS__)
+
+#define CL_SOUNDING_TYPE_2_STR(type) ((type) =3D=3D SOUNDING_TYPE_HE_SU ? =
"HE_SU" : \
+                                     (type) =3D=3D SOUNDING_TYPE_HE_SU_TB =
? "HE_SU_TB" : \
+                                     (type) =3D=3D SOUNDING_TYPE_VHT_SU ? =
"VHT_SU" : \
+                                     (type) =3D=3D SOUNDING_TYPE_HE_CQI ? =
"HE_CQI" : \
+                                     (type) =3D=3D SOUNDING_TYPE_HE_CQI_TB=
 ? "HE_CQI_TB" :\
+                                     (type) =3D=3D SOUNDING_TYPE_HE_MU ? "=
HE_MU" : \
+                                     (type) =3D=3D SOUNDING_TYPE_VHT_MU ? =
"VHT_MU" : "INVALID")
+
+#define CL_SOUNDING_ALL_STA          0xff
+#define CL_SOUNDING_LIFETIME_MAX     4095
+#define CL_SOUNDING_LIFETIME_FACTOR  5
+#define CL_SOUNDING_V_MATRIX_PADDING 32
+#define V_MATRIX_MAC_OVERHEAD        41
+#define Q_MATRIX_BITMAP_MASK         0xf
+
+enum cl_sounding_feedback_type {
+       CL_SOUNDING_FEEDBACK_TYPE_SU =3D 0,
+       CL_SOUNDING_FEEDBACK_TYPE_MU,
+};
+
+enum cl_sounding_ng {
+       CL_SOUNDING_NG_4 =3D 0,
+       CL_SOUNDING_NG_16,
+       CL_SOUNDING_NG_MAX
+};
+
+struct sounding_work_data {
+       struct work_struct  work;
+       struct cl_hw *cl_hw;
+       bool start;
+       bool is_recovery;
+       struct cl_sounding_info *elem; /* For stop and recovery cases */
+       enum sounding_type sounding_type;
+       u8 gid;
+       u8 sta_num;
+       u8 bw;
+       u8 q_matrix_bitmap;
+       u8 sta_indices[CL_MU_MAX_STA_PER_GROUP];
+};
+
+static u16 ng_bw_to_nsc[CL_SOUNDING_NG_MAX][CHNL_BW_MAX_HE] =3D {
+       {64, 122, 250, 500},
+       {20, 32, 64, 128}
+};
+
+static int cl_sounding_check_response(struct cl_hw *cl_hw, u8 param_err)
+{
+       int ret =3D -1;
+
+       switch (param_err) {
+       case CL_SOUNDING_RSP_OK:
+               sounding_pr_trace("param OK!\n");
+               ret =3D 0;
+               break;
+       case CL_SOUNDING_RSP_ERR_RLIMIT:
+               sounding_pr_err("error, resource limit reached\n");
+               break;
+       case CL_SOUNDING_RSP_ERR_BW:
+               sounding_pr_err("error, unsupported BW tx requested\n");
+               break;
+       case CL_SOUNDING_RSP_ERR_NSS:
+               sounding_pr_err("error, unsupported ndp NSS tx requested\n"=
);
+               break;
+       case CL_SOUNDING_RSP_ERR_INTERVAL:
+               sounding_pr_err("error, interval value is invalid\n");
+               break;
+       case CL_SOUNDING_RSP_ERR_ALREADY:
+               sounding_pr_err("error, station already associated/disassoc=
iated with sounding\n");
+               break;
+       case CL_SOUNDING_RSP_ERR_STA:
+               sounding_pr_err("error, station is inactive/active\n");
+               break;
+       case CL_SOUNDING_RSP_ERR_TYPE:
+               sounding_pr_err("error, invalid sounding type\n");
+               break;
+       default:
+               sounding_pr_err("error status unknown, BUG\n");
+               break;
+       }
+
+       return ret;
+}
+
+static u32 cl_sounding_get_lifetime(struct cl_hw *cl_hw, u32 interval)
+{
+       u32 lifetime =3D (interval * CL_SOUNDING_LIFETIME_FACTOR) >> 1;
+
+       if (lifetime > CL_SOUNDING_LIFETIME_MAX) {
+               sounding_pr_err("lifetime (%u) exceeds 4095\n", lifetime);
+               lifetime =3D CL_SOUNDING_LIFETIME_MAX;
+       }
+
+       return lifetime;
+}
+
+static bool cl_sounding_is_sta_ng_16_capable(struct cl_hw *cl_hw, struct c=
l_sta *cl_sta,
+                                            bool mu_cap)
+{
+       struct ieee80211_sta_he_cap *he_cap =3D &cl_sta->stainfo->sta.he_ca=
p;
+
+       if (he_cap->has_he) {
+               if (mu_cap)
+                       return (he_cap->he_cap_elem.phy_cap_info[5] &
+                               IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK) ? t=
rue : false;
+               else
+                       return (he_cap->he_cap_elem.phy_cap_info[5] &
+                               IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK) ? t=
rue : false;
+       }
+
+       return false;
+}
+
+static bool cl_sounding_is_sta_codebook_size_75_capable(struct cl_hw *cl_h=
w, struct cl_sta *cl_sta)
+{
+       struct ieee80211_sta_he_cap *he_cap =3D &cl_sta->stainfo->sta.he_ca=
p;
+
+       if (he_cap->has_he)
+               return (he_cap->he_cap_elem.phy_cap_info[6] &
+                       IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU) ? true :=
 false;
+
+       return false;
+}
+
+static void cl_sounding_extract_ng_cb_size(struct cl_hw *cl_hw, u8 fb_type=
_ng_cb_size,
+                                          enum cl_sounding_ng *ng, u8 *phi=
_psi_sum)
+{
+       enum cl_sounding_feedback_type fb_type =3D
+               SOUNDING_FEEDBACK_TYPE_VAL(fb_type_ng_cb_size);
+       u8 cb_size =3D SOUNDING_CODEBOOK_SIZE_VAL(fb_type_ng_cb_size);
+
+       *ng =3D SOUNDING_NG_VAL(fb_type_ng_cb_size);
+
+       switch (fb_type) {
+       case CL_SOUNDING_FEEDBACK_TYPE_SU:
+               *phi_psi_sum =3D (cb_size ? 10 : 6);
+               break;
+       case CL_SOUNDING_FEEDBACK_TYPE_MU:
+               *phi_psi_sum =3D (cb_size ? 16 : 12);
+               break;
+       default:
+               sounding_pr_err("Invalid feedback_type %d\n", fb_type);
+               break;
+       }
+}
+
+static u32 cl_sounding_get_v_matrix_size(struct cl_hw *cl_hw, u8 sta_idx, =
u8 bw, u8 nc, u8 nr,
+                                        u8 fb_type_ng_cb_size)
+{
+       enum cl_sounding_ng ng =3D 0;
+       u8 phi_psi_sum =3D 0;
+       u8 nsc;
+       u32 v_size;
+
+       cl_sounding_extract_ng_cb_size(cl_hw, fb_type_ng_cb_size, &ng, &phi=
_psi_sum);
+       nsc =3D ng_bw_to_nsc[ng][bw];
+
+       /* NC and NR should start from 1 and not 0 for the below calculatio=
n */
+       nc++;
+       nr++;
+
+       /* v_size =3D [8*41 + 8*nc + (phi + psi)/2 * nsc*(nc * (2*nr-nc-1))=
] / 8 + extra padding */
+       v_size =3D V_MATRIX_MAC_OVERHEAD + nc +
+                    ((phi_psi_sum * nsc * nc * (2 * nr - nc - 1)) >> 4) +
+                    CL_SOUNDING_V_MATRIX_PADDING;
+
+       sounding_pr_info("sta %u, nc %u, nr %u, ng %d, phi_psi_sum %u, nsc =
%u, v_size %u\n",
+                        sta_idx, nc, nr, ng, phi_psi_sum, nsc, v_size);
+
+       return v_size;
+}
+
+static u32 cl_sounding_get_v_matrices_data_size(struct cl_hw *cl_hw,
+                                               struct sounding_info_per_st=
a *info_per_sta,
+                                               u8 sta_num, u8 bw, u8 nr)
+{
+       u8 i;
+       u32 v_size =3D 0;
+
+       for (i =3D 0; i < sta_num; i++)
+               v_size +=3D cl_sounding_get_v_matrix_size(cl_hw, info_per_s=
ta[i].sta_idx,
+                                                       bw, info_per_sta[i]=
.nc,
+                                                       nr, info_per_sta[i]=
.fb_type_ng_cb_size);
+
+       sounding_pr_info("v_matrices data size %u, sta_num %u\n", v_size, s=
ta_num);
+
+       return v_size;
+}
+
+static u32 cl_sounding_get_q_matrix_size(struct cl_hw *cl_hw,
+                                        const struct sounding_info_per_sta=
 *info_per_sta,
+                                        u8 sta_num, u8 bw, u8 nr)
+{
+       u8 i;
+       u8 nc =3D 0;
+       enum cl_sounding_ng ng =3D 0;
+       u8 nsc, phi_psi_sum =3D 0;
+       u32 q_size =3D 0;
+
+       /*
+        * NC and NR should start from 1 and not 0 for the below calculatio=
n
+        * In MU-MIMO case, when sta_num > 1, we should take the sum of all=
 nc's
+        */
+       for (i =3D 0; i < sta_num; i++)
+               nc +=3D info_per_sta[i].nc + 1;
+
+       nr++;
+
+       cl_sounding_extract_ng_cb_size(cl_hw, info_per_sta[0].fb_type_ng_cb=
_size, &ng,
+                                      &phi_psi_sum);
+       nsc =3D ng_bw_to_nsc[ng][bw];
+       q_size =3D (nr * nc * nsc) << 2;
+
+       sounding_pr_info("q_matrix size %u, sta_num %u\n", q_size, sta_num)=
;
+
+       return q_size;
+}
+
+static u32 cl_sounding_get_required_xmem_size(struct cl_hw *cl_hw,
+                                             const struct mm_sounding_req =
*sounding_req,
+                                             const struct sounding_info_pe=
r_sta *info_per_sta)
+{
+       u8 i;
+       u8 sta_num =3D sounding_req->sta_num;
+       u8 q_matrix_bitmap =3D sounding_req->q_matrix_bitmap;
+       u8 bw =3D sounding_req->req_txbw;
+       u8 nr =3D sounding_req->ndp_nsts;
+       u32 total_size =3D 0;
+
+       /*
+        * In case of MU sounding only one Q matrix is generated.
+        * Otherwise, the number of Q matrices equals to the number of stat=
ions
+        */
+       if (sta_num > 1 &&
+           sounding_req->sounding_type !=3D SOUNDING_TYPE_HE_MU &&
+           sounding_req->sounding_type !=3D SOUNDING_TYPE_VHT_MU)
+               for (i =3D 0; i < sta_num; i++)
+                       total_size +=3D
+                       cl_sounding_get_q_matrix_size(cl_hw, &info_per_sta[=
i], 1, bw, nr);
+       else
+               total_size =3D
+                       cl_sounding_get_q_matrix_size(cl_hw, info_per_sta, =
sta_num, bw, nr);
+
+       /*
+        * If additional SU Q matrices should be generated - consider them =
also when calculating
+        * the required XMEM space
+        */
+       if (q_matrix_bitmap) {
+               for (i =3D 0; i < CL_MU_MIMO_MAX_STA_PER_GRP; i++)
+                       if (q_matrix_bitmap & BIT(i))
+                               total_size +=3D
+                               cl_sounding_get_q_matrix_size(cl_hw, &info_=
per_sta[i], 1, bw, nr);
+       }
+
+       return total_size;
+}
+
+static bool cl_sounding_is_enough_xmem_space(struct cl_hw *cl_hw,
+                                            const struct mm_sounding_req *=
sounding_req,
+                                            const struct sounding_info_per=
_sta *info_per_sta,
+                                            u32 *required_size)
+{
+       struct cl_xmem *xmem_db =3D &cl_hw->chip->xmem_db;
+       u32 req_mem =3D cl_sounding_get_required_xmem_size(cl_hw, sounding_=
req, info_per_sta);
+
+       if (required_size)
+               *required_size =3D req_mem;
+
+       return ((xmem_db->size - xmem_db->total_used) >=3D req_mem);
+}
+
+static void cl_sounding_fill_info_per_sta(struct cl_hw *cl_hw, u8 sounding=
_type, u8 bw, u8 sta_num,
+                                         struct cl_sta **cl_sta_arr,
+                                         struct sounding_info_per_sta *inf=
o_per_sta,
+                                         u8 *n_sts)
+{
+       u8 i;
+       u8 min_sts =3D cl_hw->num_antennas;
+       struct cl_sta *cl_sta =3D NULL;
+       u8 mu_fb_type_ng_cb_size =3D FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_=
7;
+       u8 curr_fb_type_ng_cb_size;
+       bool should_update_fb_type_ng_cb_size =3D false;
+
+       for (i =3D 0; i < sta_num; i++) {
+               cl_sta =3D cl_sta_arr[i];
+
+               if (!cl_sta)
+                       continue;
+
+               info_per_sta[i].sta_idx =3D cl_sta->sta_idx;
+               info_per_sta[i].nc =3D cl_sta->bf_db.nc;
+
+               /* TODO: Add handling of MU-MIMO case. The nc should be tak=
en from the group */
+
+               min_sts =3D min(min_sts, cl_sta->bf_db.beamformee_sts);
+
+               switch (sounding_type) {
+               case SOUNDING_TYPE_HE_CQI:
+               case SOUNDING_TYPE_HE_SU:
+               case SOUNDING_TYPE_VHT_SU:
+               case SOUNDING_TYPE_VHT_MU:
+                       info_per_sta[i].fb_type_ng_cb_size =3D
+                               FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_4_2;
+                       break;
+               case SOUNDING_TYPE_HE_SU_TB:
+                       info_per_sta[i].fb_type_ng_cb_size =3D
+                               FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_6_4;
+                       break;
+               case SOUNDING_TYPE_HE_CQI_TB:
+                       info_per_sta[i].fb_type_ng_cb_size =3D
+                               FEEDBACK_TYPE_CQI_TB;
+                       break;
+               case SOUNDING_TYPE_HE_MU:
+                       if (bw =3D=3D CHNL_BW_160 &&
+                           info_per_sta[i].nc >=3D WRS_SS_3 &&
+                           min_sts =3D=3D MAX_ANTENNAS) {
+                               should_update_fb_type_ng_cb_size =3D true;
+
+                               if (cl_sounding_is_sta_codebook_size_75_cap=
able(cl_hw, cl_sta)) {
+                                       curr_fb_type_ng_cb_size =3D
+                                               FEEDBACK_TYPE_MU_NG_4_CODEB=
OOK_SIZE_7_5;
+                               } else if (cl_sounding_is_sta_ng_16_capable=
(cl_hw, cl_sta, true)) {
+                                       curr_fb_type_ng_cb_size =3D
+                                               FEEDBACK_TYPE_MU_NG_16_CODE=
BOOK_SIZE_9_7;
+                               } else {
+                                       curr_fb_type_ng_cb_size =3D
+                                               FEEDBACK_TYPE_MU_NG_4_CODEB=
OOK_SIZE_9_7;
+                                       mu_fb_type_ng_cb_size =3D
+                                               FEEDBACK_TYPE_MU_NG_4_CODEB=
OOK_SIZE_9_7;
+                                       min_sts--;
+                               }
+
+                               if ((SOUNDING_NG_VAL(curr_fb_type_ng_cb_siz=
e) >
+                                                       SOUNDING_NG_VAL(mu_=
fb_type_ng_cb_size)) ||
+                                   (SOUNDING_CODEBOOK_SIZE_VAL(curr_fb_typ=
e_ng_cb_size) <
+                                    SOUNDING_CODEBOOK_SIZE_VAL(mu_fb_type_=
ng_cb_size)))
+                                       mu_fb_type_ng_cb_size =3D curr_fb_t=
ype_ng_cb_size;
+                       }
+
+                       info_per_sta[i].fb_type_ng_cb_size =3D mu_fb_type_n=
g_cb_size;
+                       break;
+               default:
+                       sounding_pr_trace("Invalid sounding type %u\n", sou=
nding_type);
+                       break;
+               }
+       }
+
+       *n_sts =3D min_sts;
+
+       if (should_update_fb_type_ng_cb_size)
+               for (i =3D 0; i < sta_num; i++)
+                       info_per_sta[i].fb_type_ng_cb_size =3D mu_fb_type_n=
g_cb_size;
+}
+
+struct cl_sounding_info *cl_sounding_elem_alloc(struct cl_hw *cl_hw, u32 v=
_mat_len)
+{
+       struct cl_sounding_info *elem =3D NULL;
+       dma_addr_t phys_dma_addr;
+       struct v_matrix_header *buf =3D NULL;
+
+       elem =3D kzalloc(sizeof(*elem), GFP_KERNEL);
+
+       if (!elem) {
+               CL_DBG(cl_hw, DBG_LVL_ERROR, "kzalloc failed\n");
+               return NULL;
+       }
+
+       buf =3D dma_alloc_coherent(cl_hw->chip->dev, v_mat_len, &phys_dma_a=
ddr, GFP_KERNEL);
+
+       if (!buf) {
+               CL_DBG(cl_hw, DBG_LVL_ERROR, "dma_alloc_coherent failed. si=
ze=3D%u\n", v_mat_len);
+               kfree(elem);
+               return NULL;
+       }
+
+       elem->v_matrices_data =3D buf;
+       elem->v_matrices_dma_addr =3D phys_dma_addr;
+       elem->v_matrices_data_len =3D v_mat_len;
+
+       return elem;
+}
+
+void cl_sounding_elem_free(struct cl_hw *cl_hw, struct cl_sounding_info *e=
lem)
+{
+       struct v_matrix_header *v_data =3D elem->v_matrices_data;
+
+       if (v_data) {
+               dma_free_coherent(cl_hw->chip->dev, elem->v_matrices_data_l=
en, (void *)v_data,
+                                 elem->v_matrices_dma_addr);
+       } else {
+               sounding_pr_err("%s: v_matrices_data is NULL for sid %u\n",
+                               __func__, elem->sounding_id);
+       }
+
+       elem->v_matrices_data =3D NULL;
+       kfree(elem);
+}
+
+void cl_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_info =
*elem)
+{
+       if (!elem->gid)
+               cl_bf_sounding_req_success(cl_hw, elem);
+}
+
+void cl_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_info =
*elem)
+{
+       if (!elem->gid)
+               cl_bf_sounding_req_failure(cl_hw, elem);
+}
+
+static void cl_sounding_increase_num_profiles(struct cl_hw *cl_hw, u8 soun=
ding_type, u8 sta_num)
+{
+       if (SOUNDING_TYPE_IS_CQI(sounding_type))
+               cl_hw->sounding.cqi_profiles +=3D sta_num;
+       else
+               cl_hw->sounding.active_profiles +=3D sta_num;
+}
+
+static void cl_sounding_decrease_num_profiles(struct cl_hw *cl_hw, u8 soun=
ding_type, u8 sta_num)
+{
+       if (SOUNDING_TYPE_IS_CQI(sounding_type))
+               cl_hw->sounding.cqi_profiles -=3D sta_num;
+       else
+               cl_hw->sounding.active_profiles -=3D sta_num;
+}
+
+static void _cl_sounding_add(struct cl_hw *cl_hw, struct cl_sounding_info =
*elem, u8 sounding_id,
+                            u32 req_xmem)
+{
+       write_lock_bh(&cl_hw->sounding.list_lock);
+       elem->sounding_id =3D sounding_id;
+       elem->xmem_space =3D req_xmem;
+       cl_hw->chip->xmem_db.total_used +=3D req_xmem;
+       cl_hw->sounding.num_soundings++;
+       list_add_tail(&elem->list, &cl_hw->sounding.head);
+       cl_sounding_increase_num_profiles(cl_hw, elem->type, elem->sta_num)=
;
+       write_unlock_bh(&cl_hw->sounding.list_lock);
+}
+
+static void cl_sounding_remove_from_list(struct cl_hw *cl_hw, struct cl_so=
unding_info *elem)
+{
+       /* Remove the sounding sequence from the list and update the XMEM a=
nd profile counters */
+       write_lock_bh(&cl_hw->sounding.list_lock);
+       list_del(&elem->list);
+       cl_hw->chip->xmem_db.total_used -=3D elem->xmem_space;
+       cl_hw->sounding.num_soundings--;
+       cl_sounding_decrease_num_profiles(cl_hw, elem->type, elem->sta_num)=
;
+       write_unlock_bh(&cl_hw->sounding.list_lock);
+}
+
+static void cl_sounding_remove_recovery(struct cl_hw *cl_hw, struct cl_sou=
nding_info *elem)
+{
+       u8 i;
+
+       cl_sounding_remove_from_list(cl_hw, elem);
+
+       /* Set invalid sid for all STAs related to this sounding sequence *=
/
+       for (i =3D 0; i < elem->sta_num; i++) {
+               struct cl_sta *cl_sta =3D elem->su_cl_sta_arr[i];
+
+               if (cl_sta)
+                       cl_sta->su_sid =3D INVALID_SID;
+       }
+
+       /* Free the deleted sounding element */
+       cl_sounding_elem_free(cl_hw, elem);
+}
+
+static void cl_sounding_start_handler(struct cl_hw *cl_hw, struct sounding=
_work_data *data)
+{
+       struct mm_sounding_req sounding_req;
+       struct mm_sounding_cfm *cfm =3D NULL;
+       int ret =3D 0;
+       u32 len =3D 0;
+       u32 req_xmem =3D 0;
+       struct cl_sounding_info *elem =3D NULL;
+       u8 sounding_type =3D data->sounding_type;
+       u8 bw =3D data->bw;
+       u8 i, sta_num =3D 0;
+       u8 q_matrix_bitmap =3D data->q_matrix_bitmap;
+       u8 min_nsts =3D 0;
+       struct cl_sta *cl_sta_arr[CL_MU_MAX_STA_PER_GROUP] =3D {0};
+
+       cl_sta_lock_bh(cl_hw);
+
+       for (i =3D 0; i < data->sta_num; i++) {
+               u8 sta_idx =3D data->sta_indices[i];
+               struct cl_sta *cl_sta;
+
+               cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+               if (!cl_sta)
+                       continue;
+
+               cl_sta_arr[sta_num] =3D cl_sta;
+               sta_num++;
+       }
+
+       if (!sta_num) {
+               cl_sta_unlock_bh(cl_hw);
+               sounding_pr_err("%s: No STA found!\n", __func__);
+               return;
+       }
+
+       q_matrix_bitmap &=3D Q_MATRIX_BITMAP_MASK;
+
+       /* Configure sounding request parameters */
+       sounding_req.start =3D true;
+       sounding_req.sounding_type =3D sounding_type;
+       sounding_req.req_txbw =3D bw;
+       sounding_req.sta_num =3D sta_num;
+       sounding_req.interval =3D cl_sounding_get_interval(cl_hw);
+       sounding_req.lifetime =3D cl_sounding_get_lifetime(cl_hw, sounding_=
req.interval);
+       sounding_req.q_matrix_bitmap =3D q_matrix_bitmap;
+       cl_sounding_fill_info_per_sta(cl_hw, sounding_type, bw, sta_num, cl=
_sta_arr,
+                                     sounding_req.info_per_sta, &min_nsts)=
;
+       cl_sta_unlock_bh(cl_hw);
+
+       sounding_req.ndp_nsts =3D min_nsts;
+
+       if (data->is_recovery) {
+               elem =3D data->elem;
+       } else {
+               /*
+                * Check if there is enough XMEM space.
+                * Should be called after filling sounding req struct
+                */
+               if (!cl_sounding_is_enough_xmem_space(cl_hw, &sounding_req,
+                                                     sounding_req.info_per=
_sta, &req_xmem)) {
+                       sounding_pr_err("There is not enough space in XMEM!=
\n");
+                       return;
+               }
+
+               /* Should be called after filling info per STA */
+               len =3D cl_sounding_get_v_matrices_data_size(cl_hw, soundin=
g_req.info_per_sta,
+                                                          sta_num, bw, min=
_nsts);
+               elem =3D cl_sounding_elem_alloc(cl_hw, len);
+
+               if (!elem)
+                       return;
+
+               elem->type =3D sounding_type;
+               elem->bw =3D bw;
+               elem->sta_num =3D sta_num;
+               elem->q_matrix_bitmap =3D q_matrix_bitmap;
+
+               if (data->gid)
+                       elem->gid =3D data->gid;
+               else
+                       memcpy(elem->su_cl_sta_arr, cl_sta_arr,
+                              sta_num * sizeof(cl_sta_arr[0]));
+       }
+
+       sounding_req.host_address =3D cpu_to_le32(elem->v_matrices_dma_addr=
);
+
+       /* Print request parameters */
+       sounding_pr_trace("Request: start=3D%u, bfr_lifetime=3D%u, interval=
=3D%u, "
+                          "req_txbw=3D%u, ndp_nsts=3D%u, sounding_type=3D%=
u\n",
+                          sounding_req.start,
+                          sounding_req.lifetime,
+                          sounding_req.interval,
+                          sounding_req.req_txbw,
+                          sounding_req.ndp_nsts,
+                          sounding_req.sounding_type);
+
+       /* Send message to firmware */
+       ret =3D cl_msg_tx_sounding(cl_hw, &sounding_req);
+
+       cfm =3D cl_hw->msg_cfm_params[MM_SOUNDING_CFM];
+
+       /* Check firmware response */
+       if (ret =3D=3D 0 && cfm) {
+
+               ret =3D cl_sounding_check_response(cl_hw, cfm->param_err);
+
+               if (ret =3D=3D 0) {
+                       if (!data->is_recovery)
+                               _cl_sounding_add(cl_hw, elem, cfm->sounding=
_id, req_xmem);
+
+                       cl_sounding_req_success(cl_hw, elem);
+
+                       sounding_pr_trace("Sounding %u was enabled successf=
ully\n",
+                                         cfm->sounding_id);
+               } else {
+                       cl_sounding_req_failure(cl_hw, elem);
+
+                       if (data->is_recovery)
+                               cl_sounding_remove_recovery(cl_hw, elem);
+               }
+       } else {
+               sounding_pr_err("%s: failed to send message (%d)\n", __func=
__, ret);
+               cl_sounding_req_failure(cl_hw, elem);
+
+               if (data->is_recovery)
+                       cl_sounding_remove_recovery(cl_hw, elem);
+               else
+                       cl_sounding_elem_free(cl_hw, elem);
+       }
+
+       /* Free message confirmation */
+       cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_CFM);
+}
+
+static void _cl_sounding_remove(struct cl_hw *cl_hw, struct cl_sounding_in=
fo *elem)
+{
+       u8 i;
+       struct sounding_work_data data =3D {
+               .cl_hw =3D cl_hw,
+               .bw =3D elem->bw,
+               .start =3D true,
+               .is_recovery =3D false,
+               .sta_num =3D 0
+       };
+
+       cl_sounding_remove_from_list(cl_hw, elem);
+
+       for (i =3D 0; i < elem->sta_num; i++) {
+               struct cl_sta *cl_sta =3D elem->su_cl_sta_arr[i];
+
+               if (!cl_sta)
+                       continue;
+
+               cl_sta->su_sid =3D INVALID_SID;
+
+               /* After stopping the multi STA sounding - check if a new s=
ounding is needed */
+               if (elem->sounding_restart_required) {
+                       if (!cl_sta->bf_db.sounding_remove_required) {
+                               data.sta_indices[data.sta_num] =3D cl_sta->=
sta_idx;
+                               data.sta_num++;
+                       } else {
+                               cl_sta->bf_db.sounding_remove_required =3D =
false;
+                       }
+               }
+       }
+
+       /* Start a new sounding for the remaining stations only when needed=
 */
+       if (data.sta_num) {
+               /* Determine new sounding type */
+               if (SOUNDING_TYPE_IS_CQI(elem->type)) {
+                       if (data.sta_num > 1)
+                               data.sounding_type =3D elem->type;
+                       else
+                               data.sounding_type =3D SOUNDING_TYPE_HE_CQI=
;
+               } else if (SOUNDING_TYPE_IS_VHT(elem->type)) {
+                       data.sounding_type =3D SOUNDING_TYPE_VHT_SU;
+               } else {
+                       if (data.sta_num > 1)
+                               data.sounding_type =3D SOUNDING_TYPE_HE_SU_=
TB;
+                       else
+                               data.sounding_type =3D SOUNDING_TYPE_HE_SU;
+               }
+
+               cl_sounding_start_handler(cl_hw, &data);
+       }
+
+       /* Free the deleted sounding element */
+       cl_sounding_elem_free(cl_hw, elem);
+}
+
+static void cl_sounding_stop_handler(struct cl_hw *cl_hw, struct cl_soundi=
ng_info *elem)
+{
+       struct mm_sounding_req sounding_req;
+       int ret =3D 0;
+
+       if (!elem) {
+               sounding_pr_err("elem is NULL!!\n");
+               return;
+       }
+
+       /* Configure sounding request parameters */
+       sounding_req.start =3D false;
+       sounding_req.sounding_type =3D elem->type;
+       sounding_req.sid =3D elem->sounding_id;
+
+       /* Print request parameters */
+       sounding_pr_trace("Delete request: sid=3D%u, sounding_type=3D%u\n",
+                         elem->sounding_id, elem->type);
+
+       /* Send message to firmware */
+       ret =3D cl_msg_tx_sounding(cl_hw, &sounding_req);
+
+       /* Check firmware response */
+       if (ret)
+               sounding_pr_err("%s: failed to send message (%d)\n", __func=
__, ret);
+       else
+               /* Free message confirmation */
+               cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_CFM);
+
+       /* Remove the sounding sequence from the list and update the used X=
MEM counter.
+        * Notice that elem is freed and shouldn't be accessed after the ca=
ll to this function.
+        */
+       _cl_sounding_remove(cl_hw, elem);
+}
+
+static void cl_sounding_handler_send_request(struct work_struct *work)
+{
+       struct sounding_work_data *data =3D (struct sounding_work_data *)wo=
rk;
+       struct cl_hw *cl_hw =3D data->cl_hw;
+
+       if (data->start) {
+               cl_sounding_start_handler(cl_hw, data);
+       } else {
+               u8 sid;
+               u8 sta_idx =3D data->sta_indices[0];
+               struct cl_sta *cl_sta;
+
+               cl_sta_lock_bh(cl_hw);
+               cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+               sid =3D cl_sta ? cl_sta->su_sid : U8_MAX;
+               cl_sta_unlock_bh(cl_hw);
+
+               if (data->elem)
+                       cl_sounding_stop_handler(cl_hw, data->elem);
+               else
+                       cl_sounding_stop_by_sid(cl_hw, sid, false);
+       }
+
+       kfree(data);
+}
+
+static u16 cl_sounding_calc_interval(struct cl_hw *cl_hw, u8 active_profil=
es)
+{
+       /* Sounding interval =3D min interval + [(active_profiles - 1) / ST=
A step] * interval step */
+
+       u16 *coefs =3D cl_hw->conf->ce_sounding_interval_coefs;
+       u16 min_interval =3D coefs[SOUNDING_INTERVAL_COEF_MIN_INTERVAL];
+       u16 max_interval =3D coefs[SOUNDING_INTERVAL_COEF_MAX_INTERVAL];
+       u8 sta_step =3D coefs[SOUNDING_INTERVAL_COEF_STA_STEP];
+       u8 interval_step =3D coefs[SOUNDING_INTERVAL_COEF_INTERVAL_STEP];
+       u16 ret =3D min_interval;
+
+       if (active_profiles <=3D sta_step)
+               return ret;
+
+       active_profiles--;
+       ret +=3D (active_profiles / sta_step) * interval_step;
+
+       return min(ret, max_interval);
+}
+
+static void cl_sounding_handler_change_interval(struct work_struct *work)
+{
+       struct sounding_work_data *data =3D (struct sounding_work_data *)wo=
rk;
+       struct cl_hw *cl_hw =3D data->cl_hw;
+       struct mm_sounding_interval_cfm *sounding_interval_cfm =3D NULL;
+       int ret =3D 0;
+       /* Configure sounding request parameters */
+       u16 interval =3D cl_sounding_get_interval(cl_hw);
+       u16 lifetime =3D cl_sounding_get_lifetime(cl_hw, interval);
+
+       sounding_pr_trace("Sounding interval request: sta_idx=3D%d, interva=
l=3D%u, "
+                         "lifetime=3D%u, sounding_type=3D%u\n",
+                         CL_SOUNDING_ALL_STA, interval, lifetime, data->so=
unding_type);
+
+       /* Start/Stop synchronize sounding request periodically */
+       ret =3D cl_msg_tx_sounding_interval(cl_hw, interval, lifetime, data=
->sounding_type,
+                                         CL_SOUNDING_ALL_STA);
+       sounding_interval_cfm =3D (struct mm_sounding_interval_cfm *)
+                               (cl_hw->msg_cfm_params[MM_SOUNDING_INTERVAL=
_CFM]);
+
+       if (ret =3D=3D 0 && sounding_interval_cfm)
+               cl_sounding_check_response(cl_hw, sounding_interval_cfm->pa=
ram_err);
+       else
+               sounding_pr_err("%s: failed to send message (%d)\n", __func=
__, ret);
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_INTERVAL_CFM);
+       kfree(data);
+}
+
+static void cl_sounding_recovery_reset(struct cl_hw *cl_hw)
+{
+       struct cl_sounding_db *sounding_db =3D &cl_hw->sounding;
+
+       memset(sounding_db->active_profiles_prev, 0, sizeof(u8) * CL_SOUNDI=
NG_STABILITY_TIME);
+       sounding_db->active_profiles_idx =3D 0;
+       cl_sta_loop(cl_hw, cl_bf_reset_sounding_ind);
+}
+
+static int cl_sounding_cli_help(struct cl_hw *cl_hw)
+{
+       char *ret_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!ret_buf)
+               return -ENOMEM;
+
+       snprintf(ret_buf, PAGE_SIZE,
+                "sounding usage\n"
+                "-a: Create a sounding sequence [type].[bw].[gid].[q_matri=
x_bitmap].[sta_idx 1]"
+                "...[sta_idx n]\n\t* Available types: 0-HE_SU, 1-HE_SU_TB,=
 2-VHT_SU, 3-HE_CQI, "
+                "4-HE_CQI_TB, 5-HE_MU, 6-VHT_MU\n\t"
+                "* Notice that gid and q_matrix_bitmap should be passed on=
ly for MU sounding\n"
+                "-b: Delete a sounding sequence [sounding_id]\n"
+                "-c: Print sounding configuration\n"
+                "-d: Set debug level [0-Off, ..., 4-Highest]\n"
+                "-p: Print sounding db\n"
+                "-s: Simulate sounding indication [sid].[sta_idx (255 in c=
ase of MU)]\n");
+
+       err =3D cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+       kfree(ret_buf);
+
+       return err;
+}
+
+void cl_sounding_init(struct cl_hw *cl_hw)
+{
+       struct cl_sounding_db *sounding_db =3D &cl_hw->sounding;
+
+       memset(sounding_db, 0, sizeof(*sounding_db));
+       sounding_db->sounding_wq =3D create_workqueue("cl_sounding_wq");
+       sounding_db->current_interval =3D
+               cl_hw->conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_C=
OEF_MIN_INTERVAL];
+       sounding_db->dbg_level =3D 1;
+       cl_hw->chip->xmem_db.size =3D XMEM_SIZE;
+       INIT_LIST_HEAD(&sounding_db->head);
+       rwlock_init(&sounding_db->list_lock);
+}
+
+void cl_sounding_close(struct cl_hw *cl_hw)
+{
+       struct cl_sounding_info *elem, *tmp;
+
+       if (cl_hw->sounding.sounding_wq)
+               destroy_workqueue(cl_hw->sounding.sounding_wq);
+
+       list_for_each_entry_safe(elem, tmp, &cl_hw->sounding.head, list) {
+               /* Don't try to start a new sounding sequence after stoppin=
g this one */
+               elem->sounding_restart_required =3D false;
+               cl_sounding_stop_handler(cl_hw, elem);
+       }
+}
+
+struct cl_sounding_info *cl_sounding_get_elem(struct cl_hw *cl_hw, u8 soun=
ding_id)
+{
+       struct cl_sounding_info *elem =3D NULL;
+
+       read_lock_bh(&cl_hw->sounding.list_lock);
+
+       list_for_each_entry(elem, &cl_hw->sounding.head, list) {
+               if (elem->sounding_id =3D=3D sounding_id) {
+                       read_unlock_bh(&cl_hw->sounding.list_lock);
+                       return elem;
+               }
+       }
+
+       read_unlock_bh(&cl_hw->sounding.list_lock);
+
+       return NULL;
+}
+
+void cl_sounding_send_request(struct cl_hw *cl_hw, struct cl_sta **cl_sta_=
arr,
+                             u8 sta_num, bool enable, u8 sounding_type, u8=
 bw,
+                             u8 q_matrix_bitmap, struct cl_sounding_info *=
recovery_elem)
+{
+       struct sounding_work_data *data;
+       struct cl_sounding_info *elem =3D NULL;
+       u8 i;
+       bool background =3D (preempt_count() !=3D 0);
+
+       if (!cl_sta_arr) {
+               sounding_pr_err("Sta_indices is NULL! for sounding type %u\=
n", sounding_type);
+               return;
+       }
+
+       if (cl_band_is_24g(cl_hw) && SOUNDING_TYPE_IS_VHT(sounding_type)) {
+               sounding_pr_err("A VHT sounding type (%u) is not supported =
in 2.4g band\n",
+                               sounding_type);
+               return;
+       }
+
+       /*
+        * When Multiple STAs are members of a single sounding process, tha=
t is about to be stopped,
+        * we want to schedule the stopping work only once and possibly sta=
rt another sounding
+        * sequence for STAs that still want to use it.
+        */
+       if (!enable) {
+               struct cl_sta *cl_sta =3D cl_sta_arr[0];
+
+               if (cl_sta) {
+                       u8 sid =3D cl_sta->su_sid;
+
+                       if (sid !=3D INVALID_SID) {
+                               elem =3D cl_sounding_get_elem(cl_hw, sid);
+
+                               if (!elem) {
+                                       sounding_pr_trace("Sounding %u not =
found\n", sid);
+                                       return;
+                               }
+
+                               cl_sta->bf_db.sounding_remove_required =3D =
true;
+
+                               if (elem->sounding_restart_required)
+                                       return;
+
+                               elem->sounding_restart_required =3D true;
+                       }
+               }
+       }
+
+       /* data will be freed in work handler */
+       data =3D kzalloc(sizeof(*data), GFP_ATOMIC);
+
+       if (!data)
+               return;
+
+       data->cl_hw =3D cl_hw;
+       data->start =3D enable;
+       data->sounding_type =3D sounding_type;
+       data->bw =3D bw;
+       data->is_recovery =3D cl_recovery_in_progress(cl_hw);
+       data->elem =3D recovery_elem ? recovery_elem : elem;
+
+       /* Fill cl_sta_arr */
+       for (i =3D 0; i < sta_num; i++)
+               data->sta_indices[i] =3D cl_sta_arr[i]->sta_idx;
+
+       data->sta_num =3D sta_num;
+
+       if (background) {
+               INIT_WORK(&data->work, cl_sounding_handler_send_request);
+               queue_work(cl_hw->sounding.sounding_wq, &data->work);
+       } else {
+               cl_sounding_handler_send_request((struct work_struct *)data=
);
+       }
+}
+
+static void cl_sounding_change_interval(struct cl_hw *cl_hw, u8 sounding_t=
ype)
+{
+       /* Data will be freed in work handler */
+       struct sounding_work_data *data =3D kzalloc(sizeof(*data), GFP_ATOM=
IC);
+
+       if (!data)
+               return;
+
+       INIT_WORK(&data->work, cl_sounding_handler_change_interval);
+       data->cl_hw =3D cl_hw;
+       data->sounding_type =3D sounding_type;
+       queue_work(cl_hw->sounding.sounding_wq, &data->work);
+}
+
+u8 cl_sounding_get_active_profiles(struct cl_hw *cl_hw)
+{
+       return cl_hw->sounding.active_profiles;
+}
+
+void cl_sounding_stop_by_sid(struct cl_hw *cl_hw, u8 sid, bool sounding_re=
start_check)
+{
+       struct cl_sounding_info *elem =3D cl_sounding_get_elem(cl_hw, sid);
+
+       if (!elem) {
+               sounding_pr_trace("Sounding with id %u not found or is in t=
he middle of removal\n",
+                                 sid);
+               return;
+       }
+
+       elem->sounding_restart_required =3D sounding_restart_check;
+       cl_sounding_stop_handler(cl_hw, elem);
+}
+
+void cl_sounding_maintenance(struct cl_hw *cl_hw)
+{
+       /*
+        * Change sounding_index according to the number of active_profiles=
.
+        * sounding_index is modified only if number of active_profiles is =
stable for 5 seconds.
+        *
+        * Examples:
+        * e.g #1: active_profiles=3D2, active_profiles_prev=3D3,3,3,3,3 - =
stabilised on 3
+        * e.g #3: active_profiles=3D2, active_profiles_prev=3D1,1,1,1,1 - =
stabilised on 1
+        * e.g #2: active_profiles=3D5, active_profiles_prev=3D6,7,7,6,6 - =
stabilised on 6
+        * e.g #4: active_profiles=3D5, active_profiles_prev=3D4,3,3,2,4 - =
stabilised on 4
+        */
+
+       int i =3D 0;
+       u8 active_profiles_min =3D 255;
+       u8 active_profiles_max =3D 0;
+       u8 active_profiles =3D cl_hw->sounding.last_conf_active_profiles;
+       u8 active_profiles_new =3D 0;
+       u16 interval;
+       u16 interval_new;
+
+       /* Add to last 5 sec buffer */
+       cl_hw->sounding.active_profiles_prev[cl_hw->sounding.active_profile=
s_idx] =3D
+               cl_hw->sounding.active_profiles;
+
+       /* Increase cyclic index */
+       cl_hw->sounding.active_profiles_idx++;
+       if (cl_hw->sounding.active_profiles_idx =3D=3D CL_SOUNDING_STABILIT=
Y_TIME)
+               cl_hw->sounding.active_profiles_idx =3D 0;
+
+       /* Find active_profiles min/max in last 5 seconds */
+       for (i =3D 0; i < CL_SOUNDING_STABILITY_TIME; i++) {
+               if (cl_hw->sounding.active_profiles_prev[i] < active_profil=
es_min)
+                       active_profiles_min =3D cl_hw->sounding.active_prof=
iles_prev[i];
+
+               if (cl_hw->sounding.active_profiles_prev[i] > active_profil=
es_max)
+                       active_profiles_max =3D cl_hw->sounding.active_prof=
iles_prev[i];
+       }
+
+       if (active_profiles < active_profiles_min)
+               active_profiles_new =3D active_profiles_min;
+       else if (active_profiles > active_profiles_max)
+               active_profiles_new =3D active_profiles_max;
+       else /* Active_profiles in last 5 seconds did not change or is not =
stable */
+               return;
+
+       interval =3D cl_sounding_calc_interval(cl_hw, active_profiles);
+       interval_new =3D cl_sounding_calc_interval(cl_hw, active_profiles_n=
ew);
+
+       /* Check if sounding interval changed */
+       if (interval !=3D interval_new) {
+               cl_hw->sounding.last_conf_active_profiles =3D active_profil=
es_new;
+               cl_hw->sounding.current_interval =3D interval_new;
+               cl_sounding_change_interval(cl_hw, SOUNDING_TYPE_MAX);
+               sounding_pr_trace("Interval: current =3D %u, new =3D %u\n",
+                                 interval, interval_new);
+       }
+}
+
+u16 cl_sounding_get_interval(struct cl_hw *cl_hw)
+{
+       return cl_hw->sounding.current_interval;
+}
+
+static void cl_sounding_indication_pr(struct cl_hw *cl_hw,
+                                     struct mm_sounding_ind *ind,
+                                     struct v_matrix_header *v_matrix,
+                                     u8 *avg_snr)
+{
+       sounding_pr_info("Sounding indication: nc index =3D %u, BFR BW =3D =
%u, "
+                 "SNR1 =3D %u, SNR2 =3D %u, SNR3 =3D %u, SNR4 =3D %u, SNR5=
 =3D %u, SNR6 =3D %u,"
+                 "feedback type =3D %u, sta index =3D %u\n",
+                 v_matrix->nc_index, v_matrix->bw,
+                 avg_snr[0], avg_snr[1], avg_snr[2], avg_snr[3], avg_snr[4=
],
+                 avg_snr[5], ind->sounding_type, ind->sta_idx);
+}
+
+static void cl_sounding_indication_su(struct cl_hw *cl_hw,
+                                     struct mm_sounding_ind *ind,
+                                     struct cl_sounding_info *sounding_ele=
m)
+{
+       struct cl_sta *cl_sta;
+       struct v_matrix_header *v_matrix =3D NULL;
+       u8 *avg_snr =3D NULL;
+       bool pairing =3D false;
+
+       v_matrix =3D sounding_elem->v_matrices_data + ind->v_matrix_offset[=
0];
+       avg_snr =3D (u8 *)v_matrix + v_matrix->padding;
+
+       cl_sta_lock(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, ind->sta_idx);
+
+       if (cl_sta) {
+               struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+               /* Update Nc for the current STA */
+               bf_db->nc =3D v_matrix->nc_index;
+               bf_db->sounding_indications++;
+
+               if (bf_db->sounding_indications =3D=3D 1) {
+                       /*
+                        * After getting first indication disable the timer=
 and set the BF
+                        * bit in the firmware rate flags.
+                        */
+                       cl_timer_disable(&bf_db->timer);
+                       cl_bf_update_rate(cl_hw, cl_sta);
+                       pairing =3D true;
+               }
+       }
+
+       cl_sta_unlock(cl_hw);
+
+       /* Send a msg to fw to pair the STA with sounding ID */
+       if (pairing)
+               cl_msg_tx_sounding_pairing(cl_hw, ind->sid, ind->sounding_t=
ype, 0, ind->sta_idx);
+
+       cl_sounding_indication_pr(cl_hw, ind, v_matrix, avg_snr);
+}
+
+void cl_sounding_indication(struct cl_hw *cl_hw, struct mm_sounding_ind *i=
nd)
+{
+       struct cl_sounding_info *sounding_elem =3D NULL;
+       bool is_mu =3D false;
+
+       sounding_elem =3D cl_sounding_get_elem(cl_hw, ind->sid);
+
+       if (!sounding_elem) {
+               sounding_pr_err("[%s]: sounding id %u not found!\n", __func=
__, ind->sid);
+               return;
+       }
+
+       switch (ind->sounding_type) {
+       case SOUNDING_TYPE_HE_SU:
+       case SOUNDING_TYPE_HE_SU_TB:
+       case SOUNDING_TYPE_VHT_SU:
+       case SOUNDING_TYPE_HE_CQI:
+       case SOUNDING_TYPE_HE_CQI_TB:
+               is_mu =3D false;
+               break;
+       case SOUNDING_TYPE_HE_MU:
+               is_mu =3D ind->mu;
+               break;
+       case SOUNDING_TYPE_VHT_MU:
+               is_mu =3D true;
+               break;
+       default:
+               sounding_pr_err("[%s]: Invalid sounding type %u\n", __func_=
_,
+                               ind->sounding_type);
+               return;
+       }
+
+       cl_sounding_indication_su(cl_hw, ind, sounding_elem);
+}
+
+void cl_sounding_recovery(struct cl_hw *cl_hw)
+{
+       /*
+        * After recovery process we need to update sounding requests and
+        * sounding interval in firmware
+        */
+       struct cl_sounding_info *elem;
+
+       /* No sounding is active */
+       if (!cl_hw->sounding.num_soundings)
+               return;
+
+       /* Reset sounding parameters */
+       cl_sounding_recovery_reset(cl_hw);
+
+       /*
+        * Go over all clients that had sounding before recovery,
+        * and send a new sounding request to firmware.
+        */
+
+       sounding_pr_trace("Start sounding recovery\n");
+
+       list_for_each_entry(elem, &cl_hw->sounding.head, list)
+               cl_bf_sounding_start(cl_hw, elem->type, elem->su_cl_sta_arr=
, elem->sta_num, elem);
+}
+
+int cl_sounding_cli_create(struct cl_hw *cl_hw, struct cli_params *cli_par=
ams)
+{
+       u8 i;
+       u8 max_sta_params =3D 0;
+       u8 curr_param_idx =3D 0;
+       bool is_mu =3D false;
+       struct sounding_work_data *data =3D NULL;
+       int err =3D 0;
+
+       /* parameters extraction and validity checks */
+       if (cli_params->num_params < 4) {
+               sounding_pr_err("Too few parameters..\n");
+               return -EIO;
+       }
+
+       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+
+       if (!data)
+               return -ENOMEM;
+
+       data->sounding_type =3D (u8)cli_params->params[curr_param_idx++];
+       data->bw =3D (u8)cli_params->params[curr_param_idx++];
+       data->gid =3D (u8)cli_params->params[curr_param_idx++];
+       data->q_matrix_bitmap =3D (u8)cli_params->params[curr_param_idx++];
+
+       if (cl_band_is_24g(cl_hw) && SOUNDING_TYPE_IS_VHT(data->sounding_ty=
pe)) {
+               sounding_pr_err("A VHT sounding type (%u) is not supported =
in 2.4g band\n",
+                               data->sounding_type);
+               err =3D -EIO;
+               goto out_err;
+       }
+
+       switch (data->sounding_type) {
+       case SOUNDING_TYPE_VHT_SU:
+       case SOUNDING_TYPE_HE_CQI:
+       case SOUNDING_TYPE_HE_SU:
+               max_sta_params =3D 1;
+               break;
+       case SOUNDING_TYPE_HE_SU_TB:
+       case SOUNDING_TYPE_HE_CQI_TB:
+               max_sta_params =3D CL_MU_OFDMA_MAX_STA_PER_GRP;
+               break;
+       case SOUNDING_TYPE_VHT_MU:
+       case SOUNDING_TYPE_HE_MU:
+               max_sta_params =3D 0;
+               is_mu =3D true;
+               break;
+       default:
+               sounding_pr_err("Invalid sounding type %u\n", data->soundin=
g_type);
+               err =3D -EIO;
+               goto out_err;
+       }
+
+       if (cli_params->num_params > (curr_param_idx + max_sta_params)) {
+               sounding_pr_err("Too many parameters..\n");
+               err =3D -EIO;
+               goto out_err;
+       }
+
+       /* SU case */
+       struct cl_sta *cl_sta;
+
+       if (data->gid || data->q_matrix_bitmap) {
+               sounding_pr_err("Don't insert gid or q_matrix_bitmap !=3D 0=
 for SU types\n");
+               err =3D -EIO;
+               goto out_err;
+       }
+
+       if (cli_params->num_params < curr_param_idx + 1) {
+               sounding_pr_err("For SU sounding types at least 1 STA idx i=
s required\n");
+               err =3D -EIO;
+               goto out_err;
+       }
+
+       /* Fill cl_sta_arr */
+       for (i =3D 0;
+            curr_param_idx < cli_params->num_params; curr_param_idx++, i++=
) {
+               u8 sta_idx =3D (u8)cli_params->params[curr_param_idx];
+
+               cl_sta_lock_bh(cl_hw);
+               cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+               if (!cl_sta || cl_sta->su_sid !=3D INVALID_SID) {
+                       if (!cl_sta)
+                               sounding_pr_err("Invalid STA index %u\n", s=
ta_idx);
+                       else
+                               sounding_pr_err("STA %u already associated =
with sid %u\n",
+                                               cl_sta->sta_idx, cl_sta->su=
_sid);
+                       cl_sta_unlock_bh(cl_hw);
+                       err =3D -EIO;
+                       goto out_err;
+               }
+
+               data->sta_indices[i] =3D cl_sta->sta_idx;
+               cl_sta_unlock_bh(cl_hw);
+       }
+
+       data->sta_num =3D i;
+
+       /* Start the new sounding sequence */
+       cl_sounding_start_handler(cl_hw, data);
+
+out_err:
+       kfree(data);
+       return err;
+}
+
+void cl_sounding_cli_print_configuration(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       pr_debug("Min sounding interval:      %u\n",
+                conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_MI=
N_INTERVAL]);
+       pr_debug("Sounding interval STA step: %u\n",
+                conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_ST=
A_STEP]);
+       pr_debug("Sounding interval step:     %u\n",
+                conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_IN=
TERVAL_STEP]);
+       pr_debug("Max sounding interval:      %u\n",
+                conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_MA=
X_INTERVAL]);
+       pr_debug("Current interval:           %u\n\n", cl_sounding_get_inte=
rval(cl_hw));
+}
+
+void cl_sounding_cli_print_sounding_db(struct cl_hw *cl_hw)
+{
+#define STA_INDICES_STR_LEN 64
+
+       struct cl_sounding_info *elem =3D NULL;
+       char sta_indices_str[STA_INDICES_STR_LEN];
+       struct cl_sounding_db *sounding_db =3D &cl_hw->sounding;
+       struct cl_xmem *xmem_db =3D &cl_hw->chip->xmem_db;
+
+       pr_debug("---------------------------------------------------------=
-------------"
+                "-------------------------------------------------------\n=
");
+       pr_debug("| sid |   type    | bw  | gid | sta num |            sta =
indices           |"
+                " q matrix bitmap | xmem space | v matrices size |");
+
+       read_lock_bh(&cl_hw->sounding.list_lock);
+
+       list_for_each_entry(elem, &cl_hw->sounding.head, list) {
+               u8 i, len =3D 0;
+
+               memset(sta_indices_str, '\0', sizeof(sta_indices_str));
+
+               for (i =3D 0; i < elem->sta_num; i++) {
+                       len +=3D snprintf(sta_indices_str + len, STA_INDICE=
S_STR_LEN - len,
+                                       "%u%s", elem->su_cl_sta_arr[i]->sta=
_idx,
+                                       (i =3D=3D elem->sta_num - 1 ? "" : =
","));
+               }
+
+               pr_debug("+-----+-----------+-----+-----+---------+"
+                        "----------------------------------+--------------=
---+------------+"
+                        "-----------------+\n");
+               pr_debug("| %2u  | %-9s | %3u | %2u  |    %1u    | %-32s | =
      0x%01x       |"
+                        "  %6u    |     %6u      |",
+                        elem->sounding_id, CL_SOUNDING_TYPE_2_STR(elem->ty=
pe), BW_TO_MHZ(elem->bw),
+                        elem->gid, elem->sta_num, sta_indices_str, elem->q=
_matrix_bitmap,
+                        elem->xmem_space, elem->v_matrices_data_len);
+       }
+
+       read_unlock_bh(&cl_hw->sounding.list_lock);
+
+       pr_debug("---------------------------------------------------------=
--------------"
+                "------------------------------------------------------\n\=
n");
+       pr_debug("Num of soundings:         %u\n", sounding_db->num_soundin=
gs);
+       pr_debug("Active non-CQI profiles:  %u\n", sounding_db->active_prof=
iles);
+       pr_debug("Active CQI profiles:      %u\n", sounding_db->cqi_profile=
s);
+       pr_debug("Xmem size:                %u\n", xmem_db->size);
+       pr_debug("Total xmem used:          %u\n", xmem_db->total_used);
+#undef STA_INDICES_STR_LEN
+}
+
+static void cl_sounding_cli_simulate_indication(struct cl_hw *cl_hw, u8 si=
d, u8 sta_idx)
+{
+       struct cl_sounding_info *sounding_elem =3D NULL;
+       struct mm_sounding_ind ind =3D {
+               .sid =3D sid,
+               .status =3D 1
+       };
+
+       sounding_elem =3D cl_sounding_get_elem(cl_hw, sid);
+
+       if (!sounding_elem) {
+               sounding_pr_err("[%s]: sounding id %u not found!\n", __func=
__, sid);
+               return;
+       }
+
+       ind.sounding_type =3D sounding_elem->type;
+       ind.sta_idx =3D sta_idx;
+
+       cl_sounding_indication_su(cl_hw, &ind, sounding_elem);
+}
+
+int cl_sounding_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool create_sounding =3D false;
+       bool delete_sounding =3D false;
+       bool print_conf =3D false;
+       bool set_debug_level =3D false;
+       bool print_sounding_db =3D false;
+       bool simulate_indication =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               create_sounding =3D true;
+               goto skip_exp_params_check;
+       case 'b':
+               delete_sounding =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               print_conf =3D true;
+               expected_params =3D 0;
+               break;
+       case 'd':
+               set_debug_level =3D true;
+               expected_params =3D 1;
+               break;
+       case 'p':
+               print_sounding_db =3D true;
+               expected_params =3D 0;
+               break;
+       case 's':
+               simulate_indication =3D true;
+               expected_params =3D 2;
+               break;
+       case '?':
+               return cl_sounding_cli_help(cl_hw);
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
+skip_exp_params_check:
+       if (create_sounding) {
+               cl_sounding_cli_create(cl_hw, cli_params);
+       } else if (delete_sounding) {
+               u8 sid =3D (u8)cli_params->params[0];
+
+               cl_sounding_stop_by_sid(cl_hw, sid, false);
+       } else if (print_conf) {
+               cl_sounding_cli_print_configuration(cl_hw);
+       } else if (set_debug_level) {
+               u8 dbg_level =3D (u8)cli_params->params[0];
+
+               cl_hw->sounding.dbg_level =3D dbg_level;
+       } else if (print_sounding_db) {
+               cl_sounding_cli_print_sounding_db(cl_hw);
+       } else if (simulate_indication) {
+               u8 sid =3D (u8)cli_params->params[0];
+               u8 sta_idx =3D (u8)cli_params->params[1];
+
+               cl_sounding_cli_simulate_indication(cl_hw, sid, sta_idx);
+       }
+
+       return 0;
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

