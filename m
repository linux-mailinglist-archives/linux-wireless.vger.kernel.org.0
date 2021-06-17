Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1518A3AB940
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFQQNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:50 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:54427
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232887AbhFQQMx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsoT+Sdpxvsjidn8stbx+Tf/UZy+Aa6VfxryQCKe/s0HzntovenYSsGgyqTrUNdPR0hQUjbyYdTZ+sLB3DqJWFmbeNfVRFY5jjGURanzDHWFYdH8UfpwKeNCSTONk2RWtOG1fGnM8NfgtvCaR2DdplM8C3vIPPikO/98emOhjuPkEwozgQxX2pCcGCFWEcnBqa3IGl9voOT5KCbr3axD5nl4m/zIWCiaAiQJ4zJ49uk3XDvk5QHdxfdZcgOFnpfdnylXfb8cTFMDNgwEbDIRmBq/JdbX8sd2XnC5vF84ULBdxiPMtRkdUB/HVFEaPunywbYl+N/GNOkzikuBe0NB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY3Q7qvbfNnl8EuehHd2xpkNoafYE7pNbxUdVv1VgjU=;
 b=cyOrltrOIMMvwkXLmuigJsbLZCzfDe4Jgnk34ik/QMk1tdFk6oq2tnAVMyrTxGmJnS3jtJPlLx9NsC6Abupcuu/w689MNi5Ee0m6Tca845yPZo9PUuuvJKY+e/a/TJo/GwlUfwnY1AIRPAwkeW7LNCgt3jl/pDvi1Pi2pQq+xttqKY/r/MT5NBBc0lA+DXz71R6Y88S96YOCOX3MYMnmke1Cclvh/gj2uBkkcsowpQUP9fjnXgVE/nN89t2fFMYhEmb2VJycrTlJDF4Y8B066PJoG4VAuIgNKOBbyudKEGKWzuUfvycuqzhtduvExVCzWhLOKoV7ONo62490fy6+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY3Q7qvbfNnl8EuehHd2xpkNoafYE7pNbxUdVv1VgjU=;
 b=KjmOXUGSUCAHSVU89LHW3HQlbJQfOKBElXBbkIOWC81i5/kYq12wVVl4fI5UVdiULY52nKOAJF2rGz2mNyFkk9irHSY8cspizuJGDW/hiiYnw2/imF+3wHBhzYbZHHQr9IwplkwLEsv36Pgk2wn0G5ZWUc4zYC3R9up4Ww4UBzc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:08:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:00 +0000
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
Subject: [RFC v1 237/256] cl8k: add vns.c
Date:   Thu, 17 Jun 2021 16:02:04 +0000
Message-Id: <20210617160223.160998-238-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01dac17c-40c9-4345-a29b-08d931a9ef61
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452B46506D393EA1C8696ADF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rimp8nQU91oaufSXvmhcIaxSXUq7PvRpf7YRxz2nLSWpHQIcT+bdvObotFl/VKMYLFl3Ho4CAFPJJAAKW81FiLTFOvNgnIGlSNF39FycV5YxudHj0bRKwHr/Q0wk3qv9Lgwb7T6+8rME+OcoQd/xzHRwvAxpoPp4hFMZNFyxs1vqwAfpW1pZM0L6WuOINbEzLq6EXbknSoXOSesXtvFL479SNV/QS2093NaNf3wCt73o4ZbpK+/aUOfMflJDpG8eAaDdd+2TjlIwcUuImKmQHVUfJc7/67TtVvRJwUpxjsyBmz/EYBKkLz6pVPyfLNGHLk5QE1df8wrzIbEw4YkuSrzHdKpyq+Xu9T1cT+BpFUuxdTCABEzQ1yHYOlLX347n8XOy83QepyCw5sbYQ83E8a1wc6fDivnApUqVRhqISOOB7r17oPEfkw4CSbERM5II+BVKlVNiI8HQH/VeJkxDb2+S6dYGLhcXT+lHWX9fgsqwh3B44yjVPjWAJjlv6yIAHRSrS7erTdFMlaiM4geWvfMBBtys3Zw7+//iiiMAS08m338leD+F7xY73i1n3vDiapgbNdBMOXP5Olu5PNCjuwMwFYtOgwqvGyOhAJFQJRI+tYhKM3wyhoc78ERPTP9UJlZD+UCfE6nE21jsju599ryeROv8fcoOn/9P5Fr+n763BAuhibyfakwMsvlCkRK+Q4aa2DslGhcLIUA2WaZOuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(30864003)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYXaldK9kiZ2mkLcPCi/Syajnc77PJm7r/MVeJrzqum2M8eBm3q1hbgnDsjd?=
 =?us-ascii?Q?Am67cdOUxJ7u36QjR5q+4baYCv9NW3LAcawvpLAgL/hacB4rGJzMDS/ABX2r?=
 =?us-ascii?Q?cKEtqAR9ODM+API0lsyJF7KyxWYKqunt9XNCIDcmldTjkIQ33IG7HeWUkBf5?=
 =?us-ascii?Q?Wzri3GayAw8PebrsvVfaM2JEz6Wg4FHgCxTv4CtT93qeEByj8Gs66SgJZIh8?=
 =?us-ascii?Q?kCbrMoxBZv30hU+j5ZS9ZyO8iHLlR77iyioxJYNQhTEeKFsYl8S6Wz/p4oao?=
 =?us-ascii?Q?jdF81tqpzm2MFddMn6KSaZ7oIqzURoYX4B9X5O2p5uQPC97ZHUYQcGg2KQua?=
 =?us-ascii?Q?R6IKdY8WZmkNOV9CP1KDO7k0APaEKxoHY3qknEBA2EkTdcKBMLQiGvRipQGj?=
 =?us-ascii?Q?EPSWxClv9thKUfi3cxJc12FGbq63c6UZN5BU/0GekLlpc0elgtfA48HTjTWq?=
 =?us-ascii?Q?h+DplTjsN2Xv7V4Q1Ga7iWbXrJsFVd6m9cqTXHpfOT1gyCF8+sZkQEg84efA?=
 =?us-ascii?Q?LeHIKGd0Do/WJjTbpAZhTiC1mMB+bXfY9R/K1f9P4kweJuH3UlBcbkABtqeL?=
 =?us-ascii?Q?3DZf85XMzx9qr2FXgENhEUdjgLv2DD07BYa5nogoZMvpNOUiqdR3Bg2TXcvY?=
 =?us-ascii?Q?Hm9UqZMx54Eoxlo2I3uwqChsFN1MOq0FEVv5/qirUU9Mv7z1C3OgaDmlah5K?=
 =?us-ascii?Q?tu4wlY9nWBbccmRqHjXTsIbR9kn2JgbPhEQaPQmxxmzRgV02hJxLxXCMaXSo?=
 =?us-ascii?Q?ETjqmhSYwsV0n7zdzGEhcxf1ITduRxITP2Y3dDNIANN9pPDTdgD4KoeO3lso?=
 =?us-ascii?Q?j+K5JYMhthM9VHfFuQgoLfD2BYMIa7bYA8uXmzfGzmphYplhC6HMdqT7ARHm?=
 =?us-ascii?Q?HsotOLg+bGvnwMPb9vQASE1P4HOB9W6xH4hVHUiyVfN3gbIeqsSO1zi5uPfT?=
 =?us-ascii?Q?xVMssUQgMkUCaygzP35bxVqfRvssZhJ2NR9Gx7SmOoSo+2fS7ZYKldmdpqjn?=
 =?us-ascii?Q?zYQ8tiEeZmwlsYUda751oaCGTkC9zYGtT6b+qrhA2XEAco9AqCyx04681VrV?=
 =?us-ascii?Q?3yS93Lg+rtMXxNaqQsUBMfFPVqz8ibd2E8D6nIuEhfex+ypGiNAD351yKj7i?=
 =?us-ascii?Q?wvPZKXe5oy5gRMZtAqwI/QXIxwbTy7KAbwfPIRbHK4xd0U5ccoE3yPTaa+uw?=
 =?us-ascii?Q?GU14EJtp/RerbyDSsPgnI3LmJUAM11XVVqRThO4YgDQIc6x1W13TufTzthbU?=
 =?us-ascii?Q?6sV4jQkttle/ovoX18lhbFEb+qUN42X+JdDh1R2ZkVBbRLjzLag6WeqIwTXJ?=
 =?us-ascii?Q?Dv4ISt/Qp08Ywc9tqDxRla2C?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dac17c-40c9-4345-a29b-08d931a9ef61
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:58.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rYYZHeMGjT8f3fDve9JE0Qu0FhV3z0kokVAcYbHqG6W2AWNzx20NU8Uq2fqyTArcx7LEFtnmXcZE76vyica6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vns.c | 505 +++++++++++++++++++++++++
 1 file changed, 505 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.c

diff --git a/drivers/net/wireless/celeno/cl8k/vns.c b/drivers/net/wireless/=
celeno/cl8k/vns.c
new file mode 100644
index 000000000000..75c3c0374793
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vns.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "vns.h"
+#include "rssi.h"
+#include "fw/msg_tx.h"
+#include "maintenance.h"
+#include "mac_addr.h"
+
+#define CL_VNS_HASH_IDX    (ETH_ALEN - 2)
+#define CL_VNS_MGMT_AGEOUT 200
+
+#define CL_VNS_DBG(...) \
+       do { \
+               if (unlikely(cl_hw->vns_db.dbg)) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+#define CL_VNS_DBG_PER_PACKET(...) \
+       do { \
+               if (unlikely(cl_hw->vns_db.dbg_per_packet)) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+static void cl_vns_mgmt_list_add(struct cl_hw *cl_hw, u8 *addr, s8 strongs=
et_rssi)
+{
+       /* Add entry to mgmt list */
+       struct cl_vns_rssi_entry *entry =3D kzalloc(sizeof(*entry), GFP_ATO=
MIC);
+
+       if (!entry)
+               return;
+
+       /* Fill entry parameters */
+       INIT_LIST_HEAD(&entry->list_all);
+       INIT_LIST_HEAD(&entry->list_addr);
+       cl_mac_addr_copy(entry->addr, addr);
+       entry->strongset_rssi =3D strongset_rssi;
+       entry->timestamp =3D jiffies;
+
+       /* Add to list */
+       cl_hw->vns_db.mgmt_db.num_entries++;
+       list_add(&entry->list_all, &cl_hw->vns_db.mgmt_db.list_all);
+       list_add(&entry->list_addr, &cl_hw->vns_db.mgmt_db.list_addr[addr[C=
L_VNS_HASH_IDX]]);
+}
+
+static void cl_vns_mgmt_list_remove(struct cl_hw *cl_hw, struct cl_vns_rss=
i_entry *entry)
+{
+       /* Remove entry from mgmt list */
+       cl_hw->vns_db.mgmt_db.num_entries--;
+       list_del(&entry->list_all);
+       list_del(&entry->list_addr);
+       kfree(entry);
+}
+
+static void cl_vns_mgmt_list_flush(struct cl_hw *cl_hw)
+{
+       /* Flush all mgmt list */
+       if (cl_hw->vns_db.mgmt_db.num_entries > 0) {
+               struct cl_vns_rssi_entry *entry =3D NULL, *tmp =3D NULL;
+
+               list_for_each_entry_safe(entry, tmp, &cl_hw->vns_db.mgmt_db=
.list_all, list_all)
+                       cl_vns_mgmt_list_remove(cl_hw, entry);
+       }
+}
+
+static struct cl_vns_rssi_entry *cl_vns_mgmt_list_find(struct cl_hw *cl_hw=
, u8 *addr)
+{
+       /* Search for entry in mgmt list */
+       struct cl_vns_mgmt_db *mgmt_db =3D &cl_hw->vns_db.mgmt_db;
+
+       if (mgmt_db->num_entries > 0) {
+               struct cl_vns_rssi_entry *entry =3D NULL;
+
+               list_for_each_entry(entry, &mgmt_db->list_addr[addr[CL_VNS_=
HASH_IDX]], list_addr)
+                       if (ether_addr_equal(entry->addr, addr))
+                               return entry;
+       }
+
+       return NULL;
+}
+
+static bool cl_vns_mgmt_list_find_and_remove(struct cl_hw *cl_hw, u8 *addr=
)
+{
+       /*
+        * Search for entry in mgmt list
+        * If entry found remove it and return true
+        */
+       struct cl_vns_rssi_entry *entry =3D cl_vns_mgmt_list_find(cl_hw, ad=
dr);
+
+       if (entry) {
+               cl_vns_mgmt_list_remove(cl_hw, entry);
+               return true;
+       }
+
+       return false;
+}
+
+static void cl_vns_mgmt_list_ageout(struct cl_hw *cl_hw)
+{
+       /* Remove old entries from mgmt list */
+       struct cl_vns_mgmt_db *mgmt_db =3D &cl_hw->vns_db.mgmt_db;
+
+       if (mgmt_db->num_entries > 0) {
+               struct cl_vns_rssi_entry *entry =3D NULL, *tmp =3D NULL;
+               unsigned long delta_time;
+
+               list_for_each_entry_safe(entry, tmp, &mgmt_db->list_all, li=
st_all) {
+                       delta_time =3D jiffies_to_msecs(jiffies - entry->ti=
mestamp);
+
+                       if (delta_time > CL_VNS_MGMT_AGEOUT) {
+                               CL_VNS_DBG("[VNS] sta %pM removed from list=
 because of ageout\n",
+                                          entry->addr);
+                               cl_vns_mgmt_list_remove(cl_hw, entry);
+                       }
+               }
+       }
+}
+
+static s8 cl_vns_get_strongest_rssi(struct cl_hw *cl_hw, struct cl_sta *cl=
_sta)
+{
+       struct cl_vns_sta_db *vns_db =3D &cl_sta->vns_db;
+       s32 rssi_samples =3D vns_db->rssi_samples;
+
+       if (rssi_samples > 0) {
+               u8 i;
+               s32 strongest_rssi =3D S32_MIN;
+
+               for (i =3D 0; i < cl_hw->num_antennas; i++)
+                       if (vns_db->rssi_sum[i] > strongest_rssi)
+                               strongest_rssi =3D vns_db->rssi_sum[i];
+
+               /* Reset rssi for next time that cl_vns_get_strongest_rssi(=
) will be called */
+               memset(vns_db->rssi_sum, 0, sizeof(vns_db->rssi_sum));
+               vns_db->rssi_samples =3D 0;
+
+               return (s8)(strongest_rssi / rssi_samples);
+       }
+
+       return 0;
+}
+
+static void cl_vns_monitor_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
)
+{
+       /* Monitor RSSI of associated stations and update state if necessar=
y */
+       struct cl_vns_sta_db *vns_db =3D &cl_sta->vns_db;
+       s8 strongset_rssi =3D cl_vns_get_strongest_rssi(cl_hw, cl_sta);
+       s8 rssi_thr =3D 0;
+       bool is_vns =3D false;
+
+       if (strongset_rssi =3D=3D 0)
+               return;
+
+       /*
+        * Calculate RSSI threshold (take hystersis into
+        *  consideration according to current state)
+        */
+       if (vns_db->is_very_near)
+               rssi_thr =3D cl_hw->conf->ci_vns_rssi_thr - cl_hw->conf->ci=
_vns_rssi_hys;
+       else
+               rssi_thr =3D cl_hw->conf->ci_vns_rssi_thr + cl_hw->conf->ci=
_vns_rssi_hys;
+
+       is_vns =3D (strongset_rssi > rssi_thr) ? true : false;
+
+       /* Avoid toggling of VNS state - require two consecutive same decis=
ions */
+       if (is_vns !=3D vns_db->prev_decision) {
+               vns_db->prev_decision =3D is_vns;
+               return;
+       }
+
+       if (is_vns !=3D vns_db->is_very_near) {
+               CL_VNS_DBG("[VNS] sta %pM changed state, strongset_rssi =3D=
 %d, is_vns =3D %s\n",
+                          cl_sta->addr, strongset_rssi, is_vns ? "TRUE" : =
"FALSE");
+               vns_db->is_very_near =3D is_vns;
+               cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, is_vns);
+       }
+}
+
+static void cl_vns_recovery_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
)
+{
+       if (cl_sta->vns_db.is_very_near)
+               cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, true);
+}
+
+static int cl_vns_print_sta_state(struct cl_hw *cl_hw)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       /* Go over all stations - use bottom-half lock */
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+               cl_snprintf(&buf, &len, &buf_size,
+                           "sta_idx =3D %u, mac =3D %pM, is_very_near =3D =
%s\n",
+                           cl_sta->sta_idx, cl_sta->addr,
+                           cl_sta->vns_db.is_very_near ?
+                           "true" : "false");
+
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_vns_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "vns usage\n"
+                "-a: Set rssi auto response threshold [thr]\n"
+                "-d: Set debug [0/1]\n"
+                "-h: Set rssi hystersis [hyst]\n"
+                "-l: Set power limit [limit]\n"
+                "-m: Set power mode [mode]\n"
+                "-p: Set debug per packet [0/1]\n"
+                "-s: Print all stations state\n"
+                "-t: Set rssi threshold [thr]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+void cl_vns_init(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+       u8 vns_pwr_mode =3D cl_hw->conf->ci_vns_pwr_mode;
+
+       if (vns_pwr_mode =3D=3D VNS_MODE_DATA || vns_pwr_mode =3D=3D VNS_MO=
DE_ALL)
+               cl_hw->vns_db.enable =3D true;
+
+       spin_lock_init(&cl_hw->vns_db.lock);
+
+       INIT_LIST_HEAD(&cl_hw->vns_db.mgmt_db.list_all);
+
+       for (i =3D 0; i < STA_HASH_SIZE; i++)
+               INIT_LIST_HEAD(&cl_hw->vns_db.mgmt_db.list_addr[i]);
+}
+
+void cl_vns_close(struct cl_hw *cl_hw)
+{
+       if (cl_hw->vns_db.enable) {
+               spin_lock_bh(&cl_hw->vns_db.lock);
+               cl_vns_mgmt_list_flush(cl_hw);
+               spin_unlock_bh(&cl_hw->vns_db.lock);
+
+               cl_hw->vns_db.enable =3D false;
+       }
+}
+
+void cl_vns_maintenance(struct cl_hw *cl_hw)
+{
+       /*
+        * Maintenance:
+        * 1) Remove old entries from mgmt list
+        * 2) Update state for associated clients
+        */
+       if (!cl_hw->vns_db.enable)
+               return;
+
+       cl_hw->vns_db.interval_period +=3D CL_MAINTENANCE_PERIOD_SLOW_MS;
+
+       if (cl_hw->vns_db.interval_period < cl_hw->conf->ci_vns_maintenance=
_time)
+               return;
+
+       cl_hw->vns_db.interval_period =3D 0;
+
+       spin_lock_bh(&cl_hw->vns_db.lock);
+       cl_vns_mgmt_list_ageout(cl_hw);
+       spin_unlock_bh(&cl_hw->vns_db.lock);
+
+       /* Check RSSI of associated stations */
+       cl_sta_loop(cl_hw, cl_vns_monitor_rssi);
+}
+
+void cl_vns_mgmt_handler(struct cl_hw *cl_hw, u8 *addr, s8 rssi[MAX_ANTENN=
AS])
+{
+       /*
+        * Handle management frames of non-associated stations,
+        * and save the very-near ones in the mgmt list
+        */
+       s8 strongset_rssi =3D 0;
+       struct cl_vns_rssi_entry *entry =3D NULL;
+
+       if (!cl_hw->vns_db.enable)
+               return;
+
+       strongset_rssi =3D cl_rssi_get_strongest(cl_hw, rssi);
+
+       spin_lock_bh(&cl_hw->vns_db.lock);
+
+       entry =3D cl_vns_mgmt_list_find(cl_hw, addr);
+
+       if (entry) {
+               if (strongset_rssi > cl_hw->conf->ci_vns_rssi_thr) {
+                       /* Update existing entry */
+                       entry->strongset_rssi =3D strongset_rssi;
+                       entry->timestamp =3D jiffies;
+                       CL_VNS_DBG("[VNS] sta %pM updated in list (rssi=3D%=
d)\n",
+                                  addr, strongset_rssi);
+               } else {
+                       /* Remove existing entry */
+                       cl_vns_mgmt_list_remove(cl_hw, entry);
+                       CL_VNS_DBG("[VNS] sta %pM removed from list (rssi=
=3D%d)\n",
+                                  addr, strongset_rssi);
+               }
+       } else {
+               if (strongset_rssi > cl_hw->conf->ci_vns_rssi_thr) {
+                       /* Add new entry */
+                       cl_vns_mgmt_list_add(cl_hw, addr, strongset_rssi);
+                       CL_VNS_DBG("[VNS] sta %pM added to list (rssi=3D%d)=
\n",
+                                  addr, strongset_rssi);
+               }
+       }
+
+       spin_unlock_bh(&cl_hw->vns_db.lock);
+}
+
+bool cl_vns_is_very_near(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struc=
t sk_buff *skb)
+{
+       bool is_vns =3D false;
+       /* This function checks for every TX packet whether it's VNS or not=
 */
+       if (!cl_hw->vns_db.enable)
+               return false;
+
+       if (unlikely(!cl_sta)) {
+               struct ieee80211_hdr *mac_hdr =3D (struct ieee80211_hdr *)s=
kb->data;
+
+               spin_lock_bh(&cl_hw->vns_db.lock);
+               is_vns =3D cl_vns_mgmt_list_find(cl_hw, mac_hdr->addr1) ? t=
rue : false;
+               spin_unlock_bh(&cl_hw->vns_db.lock);
+
+               CL_VNS_DBG_PER_PACKET("[VNS] mgmt-sta %pM, is_vns =3D %s\n"=
,
+                                     mac_hdr->addr1, is_vns ? "TRUE" : "FA=
LSE");
+
+               return is_vns;
+       }
+       is_vns =3D cl_sta->vns_db.is_very_near;
+
+       CL_VNS_DBG_PER_PACKET("[VNS] assoc-sta %pM, is_vns =3D %s\n",
+                             cl_sta->addr, is_vns ? "TRUE" : "FALSE");
+
+       return is_vns;
+}
+
+void cl_vns_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       /* Update is_very_near according to mgmt list */
+       bool is_vns =3D false;
+
+       if (!cl_hw->vns_db.enable)
+               return;
+
+       spin_lock_bh(&cl_hw->vns_db.lock);
+       is_vns =3D cl_vns_mgmt_list_find_and_remove(cl_hw, cl_sta->addr);
+       spin_unlock_bh(&cl_hw->vns_db.lock);
+
+       if (is_vns) {
+               CL_VNS_DBG("[VNS] sta %pM connected - is_vns =3D TRUE\n", c=
l_sta->addr);
+               cl_sta->vns_db.is_very_near =3D true;
+               cl_sta->vns_db.prev_decision =3D true;
+               cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, true);
+       } else {
+               CL_VNS_DBG("[VNS] sta %pM connected - is_vns =3D FALSE\n", =
cl_sta->addr);
+       }
+}
+
+void cl_vns_handle_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rss=
i[MAX_ANTENNAS])
+{
+       /* Collect rssi samples */
+       int i;
+
+       if (!cl_hw->vns_db.enable)
+               return;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               cl_sta->vns_db.rssi_sum[i] +=3D rssi[i];
+
+       cl_sta->vns_db.rssi_samples++;
+}
+
+void cl_vns_recovery(struct cl_hw *cl_hw)
+{
+       CL_VNS_DBG("[VNS] Recovery\n");
+       cl_sta_loop_bh(cl_hw, cl_vns_recovery_sta);
+}
+
+int cl_vns_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool set_rssi_auto_rsp_thr =3D false;
+       bool set_dbg =3D false;
+       bool set_rssi_hyst =3D false;
+       bool set_pwr_limit =3D false;
+       bool set_pwr_mode =3D false;
+       bool set_dbg_per_packet =3D false;
+       bool print_sta_state =3D false;
+       bool set_rssi_thr =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               set_rssi_auto_rsp_thr =3D true;
+               expected_params =3D 1;
+               break;
+       case 'd':
+               set_dbg =3D true;
+               expected_params =3D 1;
+               break;
+       case 'h':
+               set_rssi_hyst =3D true;
+               expected_params =3D 1;
+               break;
+       case 'l':
+               set_pwr_limit =3D true;
+               expected_params =3D 1;
+               break;
+       case 'm':
+               set_pwr_mode =3D true;
+               expected_params =3D 1;
+               break;
+       case 'p':
+               set_dbg_per_packet =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               print_sta_state =3D true;
+               expected_params =3D 0;
+               break;
+       case 't':
+               set_rssi_thr =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_vns_cli_help(cl_hw);
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
+       if (set_rssi_auto_rsp_thr) {
+               cl_hw->conf->ci_vns_rssi_auto_resp_thr =3D (s8)cli_params->=
params[0];
+               pr_debug("[VNS] rssi auto response threshold =3D %d\n",
+                        cl_hw->conf->ci_vns_rssi_auto_resp_thr);
+               return 0;
+       }
+
+       if (set_dbg) {
+               cl_hw->vns_db.dbg =3D (bool)cli_params->params[0];
+               pr_debug("[VNS] debug =3D %s\n", cl_hw->vns_db.dbg ? "enabl=
e" : "disable");
+               return 0;
+       }
+
+       if (set_pwr_limit) {
+               cl_hw->conf->ci_vns_pwr_limit =3D (s8)cli_params->params[0]=
;
+               pr_debug("[VNS] power limit =3D %d\n", cl_hw->conf->ci_vns_=
pwr_limit);
+               return 0;
+       }
+
+       if (set_rssi_hyst) {
+               cl_hw->conf->ci_vns_rssi_hys =3D (s8)cli_params->params[0];
+               pr_debug("[VNS] rssi hystersis =3D %d\n", cl_hw->conf->ci_v=
ns_rssi_hys);
+               return 0;
+       }
+
+       if (set_pwr_mode) {
+               cl_hw->conf->ci_vns_pwr_mode =3D (u8)cli_params->params[0];
+               pr_debug("[VNS] power mode =3D %u\n", cl_hw->conf->ci_vns_p=
wr_mode);
+               return 0;
+       }
+
+       if (set_dbg_per_packet) {
+               cl_hw->vns_db.dbg_per_packet =3D (bool)cli_params->params[0=
];
+               pr_debug("[VNS] debug per packet =3D %s\n",
+                        cl_hw->vns_db.dbg_per_packet ? "enable" : "disable=
");
+               return 0;
+       }
+
+       if (set_rssi_thr) {
+               cl_hw->conf->ci_vns_rssi_thr =3D (s8)cli_params->params[0];
+               pr_debug("[VNS] rssi threshold =3D %d\n", cl_hw->conf->ci_v=
ns_rssi_thr);
+               return 0;
+       }
+
+       if (print_sta_state)
+               return cl_vns_print_sta_state(cl_hw);
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

