Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478943AB909
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhFQQMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:06 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:58683
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233805AbhFQQKt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL3MWfkydnpHoAj3KG9BA+ptEsbUKnIFrrW8PV/rPWYcH0QyapXY6Blap0++EYH/LhdDkqxz+XsOIiZbhVgVjbHoBIxojDJj0po1oUXWvuq9THPc6qMZBMEjnH/xbpZPbEn5AdAFY0mWsWjR0l9fThcH5oWhiHfL63r5E81lgsHFa0I541EbNmMQlw9xIf/oq+AoG1oKgtXtNbbIGHj8TOGuPVmGu28julPkGORidj5lwzD4dgSWPqzRMP/XQnv2FXAzOR65EL4ec2yV7LGvEDNZiFWPDiyBAuCfb4pu7/NybwWhR+s2csxBaE8w3wNkN/A8PntMrWVbcdX6xdd9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZORK/eU497SVPt5EDkh3yY85FkarXgYaUUpscdrxTc=;
 b=hbYTwyGNSc/Bi+i6JtlcU8ZRDF77JtJ5WY7YO+8D/dHn6E65OKiuxIaCEgqd6Anvlrb7g7PidA+dU+HYmVXGU7cVHNutguCp1yEOkpIa7kXA/SOpYnbNfIOtx+9mkoGvX2QP7yFlIzP/UEvd/VvOgArY8meh7py/KcZlks5PBxwBBFpTAkmsO376Jr1is+a2486yHjXVc5AOy/biULzHogH0Hsc1uCKuFRC2owx9DsH6EJOMTuH0bKv3fFKKnhqLr1BOjJEDdY6YLayy6/VYHxK1eWyqMO9WZxv/4LzJ/bEv+dSJr0JoEA0aRxa02JtjsvBUl6ajVvVNM+D9YtX7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZORK/eU497SVPt5EDkh3yY85FkarXgYaUUpscdrxTc=;
 b=o4hdPQT6jf4mAwmxNtfOGMafyuOXAzg5QnbqoLK0yeGdJ20OB/Dy0mpbf3iDEWuQyOYaRfTxwKFJ0mq5A7jpuN/jdkWW9qfQntxyiGyKbSXs3yv7zApDSG8kAJAPvBs1EV2myUvGwzNSSPsR/ExNmdLM0YNLVndVInBCEujkIXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:51 +0000
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
Subject: [RFC v1 212/256] cl8k: add tx/tx.c
Date:   Thu, 17 Jun 2021 16:01:39 +0000
Message-Id: <20210617160223.160998-213-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3525cabf-f1aa-486f-3bf8-08d931a9dddd
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB132990C6A1234BE29152F122F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGY0p+d9aLCi223ktt5C400H9iFK+hX2XyJMUiTHY/MP3NxaJZtURq7Lzl8Ltzzo30I+dS2/xa9Djv1jiEDza2BqdxJ2Xa+fEi/dyyO+nJ67JBnbrYIwFLcJmNabRdbx3SSqS8ezSxgXDFzuLrAMXr0+Y7qJobYEFnQFFgk8WUNzmEf9dt+/IagZWeIemhCRGt3JY1mVPLkZ3Pv659czhwbn5iJ4G55rOCfsaebNbylHaFesvqegwtE197hKdBLxbVaVaWtUzmvFCaa+M0jKhAXthIMb/+IHQLFTiBRNdghiXxi8dJNhoNqc2p8Bwymq5/cyagwoPkel66Tbss19YXsWkbVa8NXMjF9X6C3Y4qrnCVANbwQPWN2lSvCATNpwwEcCIa9TqXTUfOHfF36T4+rlgsRaQAUXAfujMXCu88KoOyfNcy3JW0zbVNfI2sBN/F/6njFS3iiJ0g8WDsXztPH7IrYXEPGlxqH+rxwt7T5ey1rpeq+51Z0bpvyiD27Us2uvHFKLVmOt1A6UgFXLURvVauhY4lCvPRno4GwZ9i6HqoER5f15QIKGZNzx5tHJdYm8M8J1EWGmFYvPDisQKRS4x/GKNj0wGi82VaJMwv9yJSKkfIG0ppBv824hd88EKee6lJoqpfiaoKHjLZNK7SN/2e/549Atk5YSteyF6/f0EKCmotfdRkLCUHA8ooXP4Oi5Gltpk3b1qM+7Cb/xkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(30864003)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dGLpxWvzFsU7ZBn0qcWR2kgUzyCAbKjlOKyeONbSjVE9snPvU4000gm0cq8?=
 =?us-ascii?Q?RHEgRhfiOtirtICJXc3V5jT8rye8NztH17pbLdcNZBL+ttkMWeLuSb0Nntxr?=
 =?us-ascii?Q?VT2FZFrV9uGGKOEtb49aNSdN+9MkaD6zL7mfWYCTVEvC5gjzrk8ZvqhMCdWo?=
 =?us-ascii?Q?rf3PqZD4LLnSkftJu4+pkBPkIx8pEz5KSXEVaP5cv+YbVpu9oDj8cDX4CMAt?=
 =?us-ascii?Q?WlFI/rlIq5tmKRNU+LtnwlO/ZW7hgtQRzEqNU5ETAWyXlrBiJfT1osBebIpz?=
 =?us-ascii?Q?DrTfY7O7OJtEEncKaY4EU2ZsVfyy6VQ1oTm4L2wtUMa3wVq5Gn45dnuWH7+9?=
 =?us-ascii?Q?vg+lYwEFvgs9/bk74Vg1MFo/QFLgRLeKBayfMGul82JSH6UBrlBdEPtsj9GE?=
 =?us-ascii?Q?+lwKr1zoCAUyvPx1sVZHewj7PdVFTkbYM2SDKcTAbH/xTVM1bq9g08/eMSQv?=
 =?us-ascii?Q?sCuHFw+9E1PTAIXsUr9z4zt22BVgxE/4iXRSNAxYMSrLgP1GaAjIjioB61qS?=
 =?us-ascii?Q?NLhjKiVHru8lm0mTD3r17bJDElK56uYBeocDM6TA/l9vcOka9qlz0vezUeM4?=
 =?us-ascii?Q?qQpqN4gaf1C7Zok81hCMHF8gP02oG+yuzvkp+ARyAT2TeFS+IkvgZxZjXgkE?=
 =?us-ascii?Q?gPN6WPaSTsqMDP14Yq6P+yoYYKrnIzN9JBkJPeowMQ8jarBkhyv3Z5krpzYR?=
 =?us-ascii?Q?K1C4o+FtnnPm1ZTSGcgMFF1l9mjBkTnp9SVy8dqWboFzXgowWReCu1xI5ayo?=
 =?us-ascii?Q?v99nONS9jDAP2UWrrniuzd2rLU5fmw3mSAtG1eqlMNfum0Dk2nGm2rAHDVU8?=
 =?us-ascii?Q?/igU1SIELuZ9Kxo5nN9iMii5aXuYLQyxJiWJbfeNK+NJ1sg84occoCTWXPdA?=
 =?us-ascii?Q?Pimw6EJsMTRgYjpC4ECtwKbfiTJzDNSMEkSqFjFknSYI3eujEAY9LsIt4QSC?=
 =?us-ascii?Q?Nrv4mKof9ZSON/PMUfmgsd2oL+dV9Qv5kASD0OMaa/A2FuR8Ijxeo0dnNCwS?=
 =?us-ascii?Q?wLqfzIsRccc2ZtBuSVsTVN7wkOOmjnpy3CuU0D3izaRzo+97iCLwtIRak+nk?=
 =?us-ascii?Q?ZiwMAxYw9wfmXLMMZD4XGTW6hXKnkpQHR6034Ax/VsuFlCHauJWCEYYyfOBm?=
 =?us-ascii?Q?nIqcs8rkjrzEA3RFLp3nh2Kpiw5u8XP3PGSzkJQ5Fo2JpXlbEa4XALnbRwDM?=
 =?us-ascii?Q?vgHcV++RUODVPGUSu5dT2hO3S4qvhnE9B9STcb5AgbqBaM+h2UFvdSUdQlxr?=
 =?us-ascii?Q?qBHc9bCK2ShRukgsjj+MBZXkrKJMCOpax5qj0ZcStrZ0Ab8wyrJghJ6vW54E?=
 =?us-ascii?Q?iR6BZ3CiginUd3V4AY/SQcOw?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3525cabf-f1aa-486f-3bf8-08d931a9dddd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:29.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82CQesnTbD54GizGLzVXj7o79ZC+LP0h5vubqUrl4ibB0ZcZSkq+UZQm8gpMQWN97pmwLHLiOkaqvR/thbsGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/tx.c | 1325 ++++++++++++++++++++++
 1 file changed, 1325 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx.c b/drivers/net/wireles=
s/celeno/cl8k/tx/tx.c
new file mode 100644
index 000000000000..ccf81dbeb8ec
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx.c
@@ -0,0 +1,1325 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "tx/tx.h"
+#include "tx/agg_cfm.h"
+#include "tx/single_cfm.h"
+#include "tx/bcmc_cfm.h"
+#include "tx/tx_queue.h"
+#include "stats.h"
+#include "fw/msg_tx.h"
+#include "rate_ctrl.h"
+#include "tx/tx_amsdu.h"
+#include "traffic.h"
+#include "dfs/dfs.h"
+#include "band.h"
+#include "vns.h"
+#include "utils/utils.h"
+#include "enhanced_tim.h"
+#include "mac_addr.h"
+#include "key.h"
+#include "utils/ip.h"
+#include "radio.h"
+#include "recovery.h"
+#include "ext/vlan_dscp.h"
+#include "wrs/wrs_api.h"
+#include "drv_ops.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+/* Expected Acknowledgment */
+#define EXPECTED_NO_ACK 0
+#define EXPECTED_ACK    1
+
+const u8 dscp_to_up[TID_MAX] =3D {0, 8, 16, 24, 32, 40, 48, 56};
+
+static DEFINE_PER_CPU(struct tasklet_struct, tx_remote_tasklet[TCV_TOTAL])=
;
+
+static void cl_tx_remote_tasklet_sched(void *t)
+{
+       tasklet_schedule((struct tasklet_struct *)t);
+}
+
+static void cl_tx_remote_cpu(struct cl_hw *cl_hw, struct sk_buff *skb, int=
 cpu)
+{
+       /* Move driver TX path to a different CPU */
+       struct tasklet_struct *t =3D &per_cpu(tx_remote_tasklet[cl_hw->idx]=
, cpu);
+
+       skb_queue_tail(&cl_hw->tx_remote_queue, skb);
+
+       if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+               smp_call_function_single(cpu, cl_tx_remote_tasklet_sched, t=
, 0);
+}
+
+static void cl_tx_remote_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct sk_buff *skb =3D NULL;
+
+       while ((skb =3D skb_dequeue(&cl_hw->tx_remote_queue)))
+               __cl_tx_start(cl_hw, skb, skb->dev);
+}
+
+void cl_tx_init(struct cl_hw *cl_hw)
+{
+       int cpu =3D cl_hw->conf->ci_tx_remote_cpu;
+
+       skb_queue_head_init(&cl_hw->tx_remote_queue);
+
+       if (cpu >=3D 0)
+               tasklet_init(&per_cpu(tx_remote_tasklet[cl_hw->idx], cpu),
+                            cl_tx_remote_tasklet,
+                            (unsigned long)cl_hw);
+}
+
+static void cl_tx_stop_remote_cpu(struct cl_hw *cl_hw)
+{
+       int cpu =3D cl_hw->conf->ci_tx_remote_cpu;
+
+       if (cpu >=3D 0) {
+               tasklet_kill(&per_cpu(tx_remote_tasklet[cl_hw->idx], cpu));
+               skb_queue_purge(&cl_hw->tx_remote_queue);
+       }
+}
+
+static void cl_tx_cpu_single(struct cl_hw *cl_hw)
+{
+       u32 processor_id =3D smp_processor_id();
+
+       if (processor_id < CPU_MAX_NUM)
+               cl_hw->cpu_cntr.tx_single[processor_id]++;
+}
+
+static void cl_tx_cpu_agg(struct cl_hw *cl_hw)
+{
+       u32 processor_id =3D smp_processor_id();
+
+       if (processor_id < CPU_MAX_NUM)
+               cl_hw->cpu_cntr.tx_agg[processor_id]++;
+}
+
+static inline void cl_tx_update_stats(struct sk_buff *skb, struct cl_sta *=
cl_sta, u16 ac, u8 tid)
+{
+       struct sta_info *stainfo =3D cl_sta->stainfo;
+       struct net_device *dev =3D skb->dev;
+       struct pcpu_sw_netstats *tstats =3D this_cpu_ptr(dev->tstats);
+
+       u64_stats_update_begin(&tstats->syncp);
+       tstats->tx_packets++;
+       tstats->tx_bytes +=3D skb->len;
+       u64_stats_update_end(&tstats->syncp);
+
+       stainfo->tx_stats.bytes[ac] +=3D skb->len;
+       stainfo->tx_stats.packets[ac]++;
+       stainfo->tx_stats.msdu[tid]++;
+}
+
+static char cl_tx_ctrl_single_frame_type(__le16 fc)
+{
+       if (ieee80211_is_data_qos(fc))
+               return CL_TX_SINGLE_FRAME_TYPE_QOS_DATA;
+       else if (ieee80211_is_qos_nullfunc(fc))
+               return CL_TX_SINGLE_FRAME_TYPE_QOS_NULL;
+       else if (ieee80211_is_mgmt(fc))
+               return CL_TX_SINGLE_FRAME_TYPE_MANAGEMENT;
+       else
+               return CL_TX_SINGLE_FRAME_TYPE_OTHER;
+}
+
+static void cl_tx_single_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_=
txhdr,
+                             u16 frame_len, u8 hdr_pads, bool is_vns)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+       struct txdesc *txdesc =3D &sw_txhdr->txdesc;
+       struct tx_host_info *host_info =3D &txdesc->host_info;
+
+       /* Reset txdesc */
+       memset(txdesc, 0, sizeof(struct txdesc));
+
+       /* Vif_index must be filled in even without header conversion */
+       if (!cl_tx_ctrl_is_inject(tx_info)) {
+               struct cl_vif *cl_vif =3D (struct cl_vif *)tx_info->control=
.vif->drv_priv;
+
+               host_info->vif_index =3D cl_vif->vif_index;
+       }
+
+       if (hdr_pads)
+               host_info->host_padding |=3D BIT(0);
+
+       host_info->is_bcn =3D sw_txhdr->is_bcn;
+       host_info->expected_ack =3D (tx_info->flags & IEEE80211_TX_CTL_NO_A=
CK) ?
+               EXPECTED_NO_ACK : EXPECTED_ACK;
+
+       /* Beware when prot and sta is unknown */
+       if (key_conf) {
+               frame_len +=3D key_conf->icv_len;
+               host_info->is_protected =3D true;
+               host_info->hw_key_idx =3D key_conf->hw_key_idx;
+       }
+
+       host_info->packet_cnt =3D 1;
+
+       txdesc->umacdesc.packet_len[0] =3D cpu_to_le16(frame_len);
+       txdesc->e2w_result.bcmc =3D (sw_txhdr->sta_idx =3D=3D STA_IDX_INVAL=
ID);
+       txdesc->e2w_result.tid =3D sw_txhdr->tid;
+       txdesc->e2w_result.is_vns =3D is_vns;
+       txdesc->e2w_result.is_txinject =3D cl_tx_ctrl_is_inject(tx_info);
+       txdesc->e2w_result.single_type =3D cl_tx_ctrl_single_frame_type(sw_=
txhdr->fc);
+       txdesc->e2w_result.single_valid_sta__agg_e2w_tx_done =3D sw_txhdr->=
cl_sta ? 1 : 0;
+       txdesc->e2w_natt_param.sta_index =3D sw_txhdr->sta_idx;
+
+       /* Set rate control */
+       cl_rate_ctrl_update_desc_single(cl_hw, host_info, sw_txhdr);
+}
+
+static void cl_tx_sub_frame_set(struct cl_sta *cl_sta, u8 tid)
+{
+       struct cl_tx_queue *tx_queue =3D cl_sta->agg_tx_queues[tid];
+
+       if (tx_queue)
+               tx_queue->total_packets++;
+}
+
+static void cl_tx_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+                      struct cl_amsdu_ctrl *amsdu_anchor)
+{
+       struct cl_tx_queue *tx_queue =3D sw_txhdr->tx_queue;
+
+       tx_queue->total_packets++;
+
+       if (cl_txq_is_fw_full(tx_queue)) {
+               /* If firmware is full push the packet to the queue */
+               cl_txq_push(cl_hw, sw_txhdr);
+       } else if (amsdu_anchor && amsdu_anchor->is_sw_amsdu) {
+               cl_txq_push(cl_hw, sw_txhdr);
+               tasklet_schedule(&cl_hw->tx_task);
+       } else if (!list_empty(&tx_queue->hdrs)) {
+               /*
+                * If queue in driver is not empty push the packet to the q=
ueue,
+                * and call cl_txq_sched() to transfer packets from the que=
ue to firmware
+                */
+               cl_txq_push(cl_hw, sw_txhdr);
+               cl_txq_sched(cl_hw, tx_queue);
+       } else {
+               /* Push the packet directly to firmware */
+               cl_tx_push(cl_hw, sw_txhdr, tx_queue);
+       }
+}
+
+void cl_tx_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, struct =
cl_tx_queue *tx_queue)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       struct ieee80211_key_conf *keyconf =3D tx_info->control.hw_key;
+       struct cl_sta *cl_sta =3D sw_txhdr->cl_sta;
+       struct cl_vif *cl_vif =3D sw_txhdr->cl_vif;
+       u8 tid =3D sw_txhdr->tid;
+       struct txdesc *txdesc =3D &sw_txhdr->txdesc;
+       struct tx_host_info *host_info =3D &txdesc->host_info;
+       struct cl_e2w_txhdr_param *e2w_txhdr_param =3D &txdesc->e2w_txhdr_p=
aram;
+       struct ieee80211_hdr *hdr80211 =3D sw_txhdr->hdr80211;
+       u8 queue_type =3D tx_queue->type;
+       bool is_mgmt =3D ieee80211_is_mgmt(sw_txhdr->fc);
+
+       if (cl_key_is_cipher_ccmp_gcmp(keyconf)) {
+               /*
+                * In case of CCMP or GCMP encryption we need to inc pn.
+                * In case of amsdu/header_conversion we need to pass it to=
 firmware as well
+                */
+               u64 pn =3D atomic64_inc_return(&keyconf->tx_pn);
+
+               if (txdesc->e2w_natt_param.hdr_conv_enable) {
+                       memcpy(&e2w_txhdr_param->encrypt_pn, &pn, CL_CCMP_G=
CMP_PN_SIZE);
+               } else {
+                       u8 hdrlen =3D ieee80211_hdrlen(sw_txhdr->fc);
+
+                       cl_key_ccmp_gcmp_pn_to_hdr((u8 *)hdr80211 + hdrlen,=
 pn, keyconf->keyidx);
+               }
+       }
+
+       if (queue_type =3D=3D QUEUE_TYPE_AGG) {
+               struct cl_baw *baw =3D &cl_sta->baws[tid];
+               bool is_amsdu =3D cl_tx_ctrl_is_amsdu(tx_info);
+
+               if (is_amsdu) {
+                       struct cl_amsdu_ctrl *amsdu_anchor =3D &cl_sta->ams=
du_anchor[tid];
+
+                       if (sw_txhdr->is_sw_amsdu) {
+                               u8 pkt_cnt =3D sw_txhdr->sw_amsdu_packet_cn=
t;
+
+                               if (pkt_cnt =3D=3D 1)
+                                       cl_tx_amsdu_unset(sw_txhdr); /* Cle=
ar AMSDU bit. */
+
+                               if (hdr80211)
+                                       hdr80211->seq_ctrl =3D cpu_to_le16(=
baw->tid_seq);
+
+                               tx_queue->stats_sw_amsdu_cnt[pkt_cnt - 1]++=
;
+                       } else {
+                               u8 pkt_cnt =3D host_info->packet_cnt;
+
+                               if (pkt_cnt =3D=3D 1)
+                                       cl_tx_amsdu_unset(sw_txhdr); /* Cle=
ar AMSDU bit. */
+
+                               tx_queue->stats_hw_amsdu_cnt[pkt_cnt - 1]++=
;
+                       }
+
+                       /* Reset anchor if needed */
+                       if (amsdu_anchor->sw_txhdr =3D=3D sw_txhdr)
+                               cl_tx_amsdu_anchor_init(amsdu_anchor);
+               }
+
+               /* Update sequence number and increase it */
+               e2w_txhdr_param->seq_ctrl =3D cpu_to_le16(baw->tid_seq);
+               baw->tid_seq =3D INC_SN(baw->tid_seq);
+       } else {
+               /*
+                * Update sequence number and increase it
+                * Management sequence number is set by firmware.
+                */
+               if (!is_mgmt) {
+                       hdr80211->seq_ctrl |=3D cpu_to_le16(cl_vif->sequenc=
e_number);
+                       cl_vif->sequence_number =3D INC_SN(cl_vif->sequence=
_number);
+               }
+       }
+
+       cl_drv_ops_pkt_fw_send(cl_hw, sw_txhdr, tx_queue);
+}
+
+void cl_tx_single_free_skb(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       if (IEEE80211_SKB_CB(skb)->ack_frame_id)
+               ieee80211_tx_status(cl_hw->hw, skb);
+       else
+               dev_kfree_skb_any(skb);
+}
+
+void cl_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                 struct sk_buff *skb, bool is_vns, bool lock)
+{
+       struct cl_tx_queue *tx_queue;
+       struct cl_sw_txhdr *sw_txhdr;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct cl_vif *cl_vif =3D (struct cl_vif *)tx_info->control.vif->dr=
v_priv;
+       struct ieee80211_hdr *hdr80211 =3D (struct ieee80211_hdr *)skb->dat=
a;
+       u8 hdr_pads =3D CL_SKB_DATA_ALIGN_PADS(hdr80211);
+       __le16 fc =3D hdr80211->frame_control;
+       u16 frame_len =3D (u16)skb->len;
+       u8 tid =3D ieee80211_is_data_qos(fc) ? ieee80211_get_tid(hdr80211) =
: 0;
+       u8 ac =3D tid_to_ac[tid];
+       bool is_beacon =3D ieee80211_is_beacon(fc);
+
+       cl_tx_cpu_single(cl_hw);
+
+       if (unlikely(!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+                    test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))) {
+               cl_tx_single_free_skb(cl_hw, skb);
+               cl_hw->tx_packet_cntr.drop.dev_flags++;
+               return;
+       }
+
+       if (unlikely(!cl_vif->tx_en || cl_hw->tx_disable_flags)) {
+               cl_tx_single_free_skb(cl_hw, skb);
+               cl_hw->tx_packet_cntr.drop.tx_disable++;
+               return;
+       }
+
+       /* Check if packet length exceeds max size */
+       if (unlikely(frame_len > CL_TX_MAX_FRAME_LEN_SINGLE)) {
+               cl_tx_single_free_skb(cl_hw, skb);
+               cl_dbg_err(cl_hw, "frame_len (%u) exceeds max size\n", fram=
e_len);
+               cl_hw->tx_packet_cntr.drop.length_limit++;
+               return;
+       }
+
+       if (cl_sta && cl_sta->key_disable) {
+               cl_tx_single_free_skb(cl_hw, skb);
+               cl_hw->tx_packet_cntr.drop.key_disable++;
+               return;
+       }
+
+       /* Allocate sw_txhdr */
+       sw_txhdr =3D cl_sw_txhdr_alloc(cl_hw);
+
+       if (unlikely(!sw_txhdr)) {
+               cl_tx_single_free_skb(cl_hw, skb);
+               cl_dbg_verbose(cl_hw, "sw_txhdr alloc failed\n");
+               cl_hw->tx_packet_cntr.drop.txhdr_alloc_fail++;
+               return;
+       }
+
+       /* Prepare sw_txhdr */
+       sw_txhdr->hdr80211 =3D hdr80211;
+       sw_txhdr->hw_queue =3D tx_info->hw_queue;
+       sw_txhdr->is_bcn =3D is_beacon;
+       sw_txhdr->skb =3D skb;
+       sw_txhdr->map_len =3D frame_len + hdr_pads;
+       sw_txhdr->fc =3D fc;
+       sw_txhdr->cl_vif =3D cl_vif;
+       sw_txhdr->tid =3D tid;
+       sw_txhdr->ac =3D ac;
+
+       if (cl_sta) {
+               sw_txhdr->cl_sta =3D cl_sta;
+               sw_txhdr->sta_idx =3D cl_sta->sta_idx;
+       } else {
+               sw_txhdr->cl_sta =3D NULL;
+               sw_txhdr->sta_idx =3D STA_IDX_INVALID;
+       }
+
+       /* Prepare txdesc */
+       cl_tx_single_prep(cl_hw, sw_txhdr, frame_len, hdr_pads, is_vns);
+
+       /*
+        * Fetch the driver queue.
+        * IEEE80211_TX_CTL_AMPDU is not set in tx_info->flags, otherwise c=
l_tx_agg()
+        * would have been called and not cl_tx_single().
+        * Therefore there is no need to check if tx_queue is NULL or if qu=
eue type
+        * is QUEUE_TYPE_AGG.
+        */
+       tx_queue =3D cl_txq_get(cl_hw, sw_txhdr);
+       sw_txhdr->tx_queue =3D tx_queue;
+
+       if (lock) {
+               if (tx_queue->type =3D=3D QUEUE_TYPE_BCMC) {
+                       /*
+                        * There is no need to take spin_lock_irqsave() bec=
ause bcmb queue
+                        * will be called only from interrupt context - cl_=
irq_status_tbtt().
+                        * All other broadcast/multicast packets are buffer=
ed in
+                        * ieee80211_tx_h_multicast_ps_buf() and will follo=
w the beacon.
+                        */
+                       spin_lock(&cl_hw->tx_lock_bcmc);
+                       cl_tx_send(cl_hw, sw_txhdr, NULL);
+                       spin_unlock(&cl_hw->tx_lock_bcmc);
+               } else {
+                       spin_lock_bh(&cl_hw->tx_lock_single);
+                       cl_tx_send(cl_hw, sw_txhdr, NULL);
+                       spin_unlock_bh(&cl_hw->tx_lock_single);
+               }
+       } else {
+               cl_tx_send(cl_hw, sw_txhdr, NULL);
+       }
+}
+
+void cl_tx_fast_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                      struct sk_buff *skb, bool lock)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+
+       /* hw_key must be set before calling cl_tx_8023_to_wlan() */
+       tx_info->control.hw_key =3D cl_key_get(cl_sta);
+
+       /* Convert 802.3 to 802.11 header */
+       if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, tid) =3D=3D 0) {
+               bool is_vns =3D cl_vns_is_very_near(cl_hw, cl_sta, skb);
+               u8 ac =3D tid_to_ac[tid];
+
+               tx_info->hw_queue =3D ac;
+               tx_info->control.vif =3D cl_sta->cl_vif->vif;
+
+               cl_tx_update_stats(skb, cl_sta, ac, tid);
+
+               cl_hw->tx_packet_cntr.forward.drv_fast_single++;
+
+               cl_tx_single(cl_hw, cl_sta, skb, is_vns, lock);
+       }
+}
+
+void cl_tx_agg_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+                   u16 frame_len, u8 hdr_pads, bool hdr_conv)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+       struct txdesc *txdesc =3D &sw_txhdr->txdesc;
+       struct lmacapi *umacdesc =3D &txdesc->umacdesc;
+       struct tx_host_info *host_info =3D &txdesc->host_info;
+       u16 qos_ctrl =3D sw_txhdr->tid;
+
+       /* Reset txdesc */
+       memset(txdesc, 0, sizeof(struct txdesc));
+
+       txdesc->e2w_result.tid =3D sw_txhdr->tid;
+       txdesc->e2w_result.is_txinject =3D cl_tx_ctrl_is_inject(tx_info);
+       txdesc->e2w_natt_param.sta_index =3D sw_txhdr->sta_idx;
+       txdesc->e2w_natt_param.ampdu =3D true;
+       txdesc->e2w_natt_param.hdr_conv_enable =3D hdr_conv;
+
+       if (hdr_conv) {
+               if (cl_tx_ctrl_is_amsdu(tx_info))
+                       qos_ctrl |=3D IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+
+               txdesc->e2w_txhdr_param.frame_ctrl =3D cpu_to_le16(sw_txhdr=
->fc);
+               txdesc->e2w_txhdr_param.qos_ctrl =3D cpu_to_le16(qos_ctrl);
+       }
+
+       if (hdr_pads)
+               host_info->host_padding |=3D BIT(0);
+
+       /* Vif_index must be filled in even without header conversion */
+       host_info->vif_index =3D sw_txhdr->cl_sta->cl_vif->vif_index;
+
+       /* Set the expected_ack flag */
+       host_info->expected_ack =3D (tx_info->flags & IEEE80211_TX_CTL_NO_A=
CK) ?
+               EXPECTED_NO_ACK : EXPECTED_ACK;
+
+       if (key_conf) {
+               host_info->is_protected =3D true;
+               host_info->hw_key_idx =3D key_conf->hw_key_idx;
+
+               if (!hdr_conv)
+                       frame_len +=3D key_conf->icv_len;
+       }
+
+       host_info->packet_cnt =3D 1;
+       umacdesc->packet_len[0] =3D cpu_to_le16(frame_len);
+
+       /* Set rate control */
+       cl_rate_ctrl_update_desc_agg(cl_hw, host_info);
+}
+
+static __le16 cl_tx_agg_frame_control(struct cl_vif *cl_vif,
+                                     struct ieee80211_key_conf *key_conf,
+                                     u8 *hdrlen)
+{
+       struct ieee80211_vif *vif =3D cl_vif->vif;
+       struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
+       enum nl80211_iftype type =3D vif->type;
+       __le16 fc =3D cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QO=
S_DATA);
+
+       if (type =3D=3D NL80211_IFTYPE_AP) {
+               fc |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS);
+               *hdrlen =3D 26;
+       } else if (type =3D=3D NL80211_IFTYPE_STATION) {
+               fc |=3D cpu_to_le16(IEEE80211_FCTL_TODS);
+
+               if (sdata->u.mgd.use_4addr) {
+                       fc |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS);
+                       *hdrlen =3D 32;
+               } else {
+                       *hdrlen =3D 26;
+               }
+       }
+
+       if (key_conf)
+               fc |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+       return fc;
+}
+
+static void _cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                      struct sk_buff *skb, bool hdr_conv)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct cl_tx_queue *tx_queue =3D NULL;
+       struct cl_vif *cl_vif =3D cl_sta->cl_vif;
+       u16 frame_len =3D (u16)skb->len;
+       u16 total_frame_len =3D 0;
+       u8 hdr_pads =3D CL_SKB_DATA_ALIGN_PADS(skb->data);
+       u8 is_amsdu =3D cl_tx_ctrl_is_amsdu(tx_info);
+       u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+       u8 ac =3D tid_to_ac[tid];
+       u8 hdrlen =3D 0;
+
+       cl_tx_cpu_agg(cl_hw);
+
+       if (unlikely(!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+                    test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))) {
+               kfree_skb(skb);
+               cl_hw->tx_packet_cntr.drop.dev_flags++;
+               return;
+       }
+
+       if (unlikely(!cl_vif->tx_en || cl_hw->tx_disable_flags)) {
+               kfree_skb(skb);
+               cl_hw->tx_packet_cntr.drop.tx_disable++;
+               return;
+       }
+
+       /* Check if packet length exceeds max size */
+       if (unlikely(frame_len > CL_TX_MAX_FRAME_LEN_AGG)) {
+               kfree_skb(skb);
+               cl_dbg_err(cl_hw, "frame_len exceeds max size %d\n", frame_=
len);
+               cl_hw->tx_packet_cntr.drop.length_limit++;
+               return;
+       }
+
+       if (cl_sta->key_disable) {
+               kfree_skb(skb);
+               cl_hw->tx_packet_cntr.drop.key_disable++;
+               return;
+       }
+
+       /* Check if amsdu is enable for current skb */
+       if (is_amsdu) {
+               enum cl_amsdu_result amsdu_res =3D cl_tx_amsdu_set(cl_hw, c=
l_sta, skb, tid);
+
+               switch (amsdu_res) {
+               case CL_AMSDU_SKIP:
+                       is_amsdu =3D false;
+                       tx_info->control.flags &=3D ~IEEE80211_TX_CTRL_AMSD=
U;
+               case CL_AMSDU_ANCHOR_SET:
+                       /*
+                        * If new anchor was set, or AMSDU is
+                        * skipped continue building sw_txhdr
+                        */
+                       break;
+               case CL_AMSDU_SUB_FRAME_SET:
+                       cl_tx_sub_frame_set(cl_sta, tid);
+                       fallthrough;
+               case CL_AMSDU_FAILED:
+               default:
+                       return;
+               }
+       } else {
+               /*
+                * If not amsdu & anchor exist. reset current anchor
+                * in order to avoid reordring packets.
+                */
+               if (cl_sta->amsdu_anchor[tid].sw_txhdr)
+                       cl_tx_amsdu_anchor_init(&cl_sta->amsdu_anchor[tid])=
;
+       }
+
+       /* Allocate sw_txhdr */
+       sw_txhdr =3D cl_sw_txhdr_alloc(cl_hw);
+       if (unlikely(!sw_txhdr)) {
+               kfree_skb(skb);
+               cl_dbg_err(cl_hw, "sw_txhdr alloc failed\n");
+               cl_hw->tx_packet_cntr.drop.txhdr_alloc_fail++;
+               return;
+       }
+
+       /* Fill sw_txhdr */
+       sw_txhdr->tid =3D tid;
+       sw_txhdr->ac =3D ac;
+       sw_txhdr->hw_queue =3D tx_info->hw_queue;
+       sw_txhdr->cl_sta =3D cl_sta;
+       sw_txhdr->sta_idx =3D cl_sta->sta_idx;
+       sw_txhdr->is_bcn =3D 0;
+       sw_txhdr->skb =3D skb;
+       sw_txhdr->map_len =3D frame_len + hdr_pads;
+       sw_txhdr->cl_vif =3D cl_vif;
+
+       if (cl_sta->amsdu_anchor[tid].is_sw_amsdu) {
+               sw_txhdr->is_sw_amsdu =3D true;
+               sw_txhdr->sw_amsdu_packet_cnt =3D 1;
+       } else {
+               sw_txhdr->is_sw_amsdu =3D false;
+       }
+
+       if (hdr_conv) {
+               sw_txhdr->hdr80211 =3D NULL;
+               sw_txhdr->fc =3D cl_tx_agg_frame_control(cl_vif, key_conf, =
&hdrlen);
+       } else {
+               struct ieee80211_hdr *hdr80211 =3D (struct ieee80211_hdr *)=
skb->data;
+               __le16 fc =3D hdr80211->frame_control;
+
+               sw_txhdr->hdr80211 =3D hdr80211;
+               sw_txhdr->fc =3D fc;
+               hdrlen =3D ieee80211_hdrlen(fc);
+       }
+
+       /* Fetch the relevant agg queue */
+       tx_queue =3D cl_sta->agg_tx_queues[tid];
+
+       if (unlikely(!tx_queue)) {
+               kfree_skb(skb);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+               cl_dbg_err(cl_hw, "tx_queue is NULL [sta_idx =3D %u] [tid =
=3D %u]\n",
+                          cl_sta->sta_idx, tid);
+               cl_hw->tx_packet_cntr.drop.queue_null++;
+               return;
+       }
+
+       sw_txhdr->tx_queue =3D tx_queue;
+
+       total_frame_len =3D frame_len + hdrlen - sizeof(struct ethhdr);
+
+       if (key_conf)
+               total_frame_len +=3D key_conf->icv_len;
+
+       /* Prepare txdesc */
+       cl_tx_agg_prep(cl_hw, sw_txhdr, frame_len, hdr_pads, hdr_conv);
+
+       /*
+        * AMSDU - first sub frame
+        * !!! Must be done after calling cl_tx_agg_prep() !!!
+        */
+       if (is_amsdu)
+               cl_tx_amsdu_first_sub_frame(sw_txhdr, cl_sta, skb, tid);
+
+       cl_tx_send(cl_hw, sw_txhdr, &cl_sta->amsdu_anchor[tid]);
+}
+
+void cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+              struct sk_buff *skb, bool hdr_conv, bool lock)
+{
+       if (lock) {
+               spin_lock_bh(&cl_hw->tx_lock_agg);
+               _cl_tx_agg(cl_hw, cl_sta, skb, hdr_conv);
+               spin_unlock_bh(&cl_hw->tx_lock_agg);
+       } else {
+               _cl_tx_agg(cl_hw, cl_sta, skb, hdr_conv);
+       }
+}
+
+static bool cl_tx_check_agg(struct ieee80211_sub_if_data *sdata, struct sk=
_buff *skb)
+{
+       u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
+
+       /* Control port protocol needs a lot of special handling */
+       if (cpu_to_be16(ethertype) =3D=3D sdata->control_port_protocol)
+               return false;
+
+       /* Only RFC 1042 SNAP */
+       if (ethertype < ETH_P_802_3_MIN)
+               return false;
+
+       /* Don't handle TX status request here either */
+       if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+               return false;
+
+       return true;
+}
+
+static void cl_tx_reset_session_timer(struct sta_info *stainfo, u8 tid)
+{
+       struct tid_ampdu_tx *tid_tx =3D NULL;
+
+       tid_tx =3D rcu_dereference(stainfo->ampdu_mlme.tid_tx[tid]);
+
+       if (tid_tx && tid_tx->timeout)
+               tid_tx->last_tx =3D jiffies;
+}
+
+void cl_tx_fast_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                   struct sk_buff *skb, bool lock)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct ieee80211_vif *vif =3D cl_sta->cl_vif->vif;
+       u16 ac =3D skb_get_queue_mapping(skb);
+       u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+
+       tx_info->control.vif =3D vif;
+       tx_info->control.hw_key =3D cl_key_get(cl_sta);
+       tx_info->hw_queue =3D vif->hw_queue[ac];
+       tx_info->flags |=3D IEEE80211_TX_CTL_AMPDU;
+
+       if (cl_sta->baws[tid].amsdu &&
+           (cl_wrs_api_get_sta_data_rate(cl_sta) > cl_hw->conf->ci_tx_amsd=
u_min_data_rate))
+               tx_info->control.flags |=3D IEEE80211_TX_CTRL_AMSDU;
+
+       cl_tx_update_stats(skb, cl_sta, ac, tid);
+       cl_tx_agg(cl_hw, cl_sta, skb, true, lock);
+       cl_tx_reset_session_timer(cl_sta->stainfo, tid);
+       cl_hw->tx_packet_cntr.forward.drv_fast_agg++;
+}
+
+void cl_tx_wlan_to_8023(struct sk_buff *skb)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       struct ethhdr tmp_eth;
+       struct ethhdr *ehdr;
+       struct {
+               u8 hdr[ETH_ALEN]__aligned(2);
+               __be16 proto;
+       } payload;
+       u16 hdrlen =3D ieee80211_hdrlen(hdr->frame_control);
+       u8 enc_len =3D cl_key_get_cipher_len(skb);
+
+       cl_mac_addr_copy(tmp_eth.h_dest, ieee80211_get_DA(hdr));
+       cl_mac_addr_copy(tmp_eth.h_source, ieee80211_get_SA(hdr));
+       skb_copy_bits(skb, hdrlen, &payload, sizeof(payload));
+       tmp_eth.h_proto =3D payload.proto;
+
+       if (enc_len) {
+               memcpy(skb->data + hdrlen,
+                      skb->data + hdrlen + enc_len,
+                      skb->len - hdrlen - enc_len);
+               skb_trim(skb, skb->len - enc_len);
+       }
+
+       if (likely((ether_addr_equal(payload.hdr, rfc1042_header) &&
+                   tmp_eth.h_proto !=3D htons(ETH_P_AARP) &&
+                   tmp_eth.h_proto !=3D htons(ETH_P_IPX)) ||
+                  ether_addr_equal(payload.hdr, bridge_tunnel_header)))
+               /* Remove RFC1042 or Bridge-Tunnel encapsulation and replac=
e ether_type */
+               hdrlen +=3D ETH_ALEN + 2;
+       else
+               tmp_eth.h_proto =3D htons(skb->len - hdrlen);
+
+       skb_pull(skb, hdrlen);
+       ehdr =3D skb_push(skb, sizeof(struct ethhdr));
+       memcpy(ehdr, &tmp_eth, sizeof(tmp_eth));
+}
+
+u16 cl_tx_prepare_wlan_hdr(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                          struct sk_buff *skb, struct ieee80211_hdr *hdr)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(skb=
->dev);
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       u16 hdrlen =3D 0;
+       __le16 fc =3D cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DA=
TA);
+
+       if (tx_info->control.hw_key)
+               fc |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+       switch (sdata->vif.type) {
+       case NL80211_IFTYPE_AP:
+               fc |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS);
+               /* DA BSSID SA */
+               memcpy(hdr->addr1, skb->data, ETH_ALEN);
+               memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
+               memcpy(hdr->addr3, skb->data + ETH_ALEN, ETH_ALEN);
+               hdrlen =3D 24;
+               break;
+       case NL80211_IFTYPE_STATION:
+               if (sdata->u.mgd.use_4addr) {
+                       fc |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS |
+                                         IEEE80211_FCTL_TODS);
+                       /* RA TA DA SA */
+                       memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+                       memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
+                       memcpy(hdr->addr3, skb->data, ETH_ALEN);
+                       memcpy(hdr->addr4, skb->data + ETH_ALEN, ETH_ALEN);
+                       hdrlen =3D 30;
+               } else {
+                       fc |=3D cpu_to_le16(IEEE80211_FCTL_TODS);
+                       /* BSSID SA DA */
+                       memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+                       memcpy(hdr->addr2, skb->data + ETH_ALEN, ETH_ALEN);
+                       memcpy(hdr->addr3, skb->data, ETH_ALEN);
+                       hdrlen =3D 24;
+               }
+               break;
+       default:
+               cl_dbg_err(cl_hw, "Unknown vif type %d !!!\n", sdata->vif.t=
ype);
+               return 0;
+       }
+
+       if (cl_sta->stainfo->sta.wme) {
+               fc |=3D cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
+               hdrlen +=3D 2;
+       }
+
+       hdr->frame_control =3D fc;
+       hdr->duration_id =3D 0;
+       hdr->seq_ctrl =3D 0;
+
+       return hdrlen;
+}
+
+int cl_tx_8023_to_wlan(struct cl_hw *cl_hw, struct sk_buff *skb, struct cl=
_sta *cl_sta, u8 tid)
+{
+       struct ieee80211_hdr hdr;
+       int head_need, ret =3D 0;
+       u16 ethertype, hdrlen;
+       const u8 *encaps_data =3D NULL;
+       int encaps_len =3D 0, skip_header_bytes =3D ETH_HLEN;
+       u8 enc_len =3D cl_key_get_cipher_len(skb);
+
+       /* Convert Ethernet header to proper 802.11 header */
+       ethertype =3D (skb->data[12] << 8) | skb->data[13];
+
+       hdrlen =3D cl_tx_prepare_wlan_hdr(cl_hw, cl_sta, skb, &hdr);
+       if (!hdrlen) {
+               ret =3D -EINVAL;
+               goto free;
+       }
+
+       if (ethertype >=3D ETH_P_802_3_MIN) {
+               encaps_data =3D rfc1042_header;
+               encaps_len =3D sizeof(rfc1042_header);
+               skip_header_bytes -=3D 2;
+       }
+
+       skb_pull(skb, skip_header_bytes);
+       head_need =3D hdrlen + enc_len + encaps_len - skb_headroom(skb);
+
+       if (head_need > 0) {
+               head_need =3D ((head_need + 3) & ~3);
+               if (pskb_expand_head(skb, head_need, 0, GFP_ATOMIC)) {
+                       ret =3D -ENOMEM;
+                       goto free;
+               }
+       }
+
+       if (encaps_data)
+               memcpy(skb_push(skb, encaps_len), encaps_data, encaps_len);
+
+       skb_push(skb, hdrlen + enc_len);
+
+       if (cl_sta->stainfo->sta.wme) {
+               u16 qos_ctrl =3D tid;
+
+               memcpy(skb->data, &hdr, hdrlen - 2);
+               memcpy(skb->data + hdrlen - 2, &qos_ctrl, 2);
+       } else {
+               memcpy(skb->data, &hdr, hdrlen);
+       }
+
+       skb_reset_mac_header(skb);
+
+       return ret;
+free:
+       cl_hw->tx_packet_cntr.drop.build_hdr_fail++;
+       kfree_skb(skb);
+       skb =3D NULL;
+
+       return ret;
+}
+
+void cl_tx_check_start_ba_session(struct cl_hw *cl_hw,
+                                 struct sta_info *stainfo,
+                                 struct sk_buff *skb)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       struct ieee80211_sta *sta =3D &stainfo->sta;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       u8 tid;
+
+       /* TODO: What about HE? */
+       if (!sta->ht_cap.ht_supported &&
+           !sta->vht_cap.vht_supported &&
+           !cl_band_is_6g(cl_hw))
+               return;
+
+       if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+               return;
+
+       if ((tx_info->flags & IEEE80211_TX_CTL_AMPDU) &&
+           !(tx_info->flags & IEEE80211_TX_STAT_AMPDU))
+               return;
+
+       if (cl_tx_ctrl_is_eapol(tx_info))
+               return;
+
+       if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
+               return;
+
+       if (unlikely(skb->protocol =3D=3D cpu_to_be16(ETH_P_PAE)))
+               return;
+
+       tid =3D ieee80211_get_tid(hdr);
+
+       if (likely(stainfo->ampdu_mlme.tid_tx[tid]))
+               return;
+
+       ieee80211_start_tx_ba_session(sta, tid, cl_hw->conf->ce_tx_ba_sessi=
on_timeout);
+}
+
+static struct sk_buff *cl_tx_beacon_get(struct ieee80211_hw *hw,
+                                       struct ieee80211_vif *vif)
+{
+       struct ieee80211_local *local =3D hw_to_local(hw);
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
+       struct ieee80211_if_ap *ap =3D &sdata->u.ap;
+       struct beacon_data *beacon =3D rcu_dereference(ap->beacon);
+
+       local->tim_in_locked_section =3D true;
+       if (beacon) {
+               if (beacon->cntdwn_counter_offsets[0] &&
+                   beacon->cntdwn_current_counter =3D=3D 1) {
+                       ieee80211_csa_finish(vif);
+                       goto out;
+               }
+       }
+
+       skb =3D ieee80211_beacon_get(hw, vif);
+out:
+       local->tim_in_locked_section =3D false;
+
+       return skb;
+}
+
+static void cl_tx_mc(struct cl_vif *cl_vif, int *mc_fw_free)
+{
+       struct cl_hw *cl_hw =3D cl_vif->cl_hw;
+       struct ieee80211_vif *vif =3D cl_vif->vif;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_tx_info *tx_info;
+
+       if (unlikely(!vif))
+               return;
+
+       while (((*mc_fw_free) > 0) &&
+              (skb =3D ieee80211_get_buffered_bc(cl_hw->hw, vif))) {
+               /* Route this MCBC frame to the BCN ipc queue */
+               tx_info =3D IEEE80211_SKB_CB(skb);
+               tx_info->hw_queue =3D CL_HWQ_BCN;
+
+               (*mc_fw_free)--;
+
+               /* Clear more data bit if this is the last frame in this SP=
 */
+               if (*mc_fw_free =3D=3D 0) {
+                       struct ieee80211_hdr *hdr =3D
+                                       (struct ieee80211_hdr *)skb->data;
+                       hdr->frame_control &=3D
+                                       cpu_to_le16(~IEEE80211_FCTL_MOREDAT=
A);
+               }
+
+               cl_tx_single(cl_hw, NULL, skb, false, true);
+       }
+}
+
+void cl_tx_bcn_mesh_task(unsigned long data)
+{
+       struct cl_vif *cl_vif =3D (struct cl_vif *)data;
+       struct cl_hw *cl_hw =3D cl_vif->cl_hw;
+       struct ieee80211_tx_info *tx_info;
+       struct sk_buff *skb;
+       int mc_fw_free;
+
+       if (cl_radio_is_off(cl_hw) ||
+           cl_recovery_in_progress(cl_hw) ||
+           !test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+           test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags) ||
+           cl_hw->tx_disable_flags)
+               return;
+
+       skb =3D cl_tx_beacon_get(cl_hw->hw, cl_vif->vif);
+       if (!skb)
+               return;
+
+       /* Route this BCN to the BCN ipc queue */
+       tx_info =3D IEEE80211_SKB_CB(skb);
+       tx_info->hw_queue =3D CL_HWQ_BCN;
+
+       cl_tx_single(cl_hw, NULL, skb, false, true);
+
+       mc_fw_free =3D cl_hw->tx_queues.bcmc.fw_free_space;
+       cl_tx_mc(cl_vif, &mc_fw_free);
+}
+
+static void cl_tx_bcn(struct cl_vif *cl_vif)
+{
+       struct cl_hw *cl_hw =3D cl_vif->cl_hw;
+       u8 vif_index =3D cl_vif->vif_index;
+       struct ieee80211_vif *vif =3D cl_vif->vif;
+       struct ieee80211_tx_info *tx_info;
+       struct sk_buff *skb;
+       struct ieee80211_sub_if_data *sdata =3D NULL;
+
+       if (!vif || vif->type !=3D NL80211_IFTYPE_AP)
+               return;
+
+       sdata =3D vif_to_sdata(vif);
+       /* TODO: Check if this is really needed */
+       sdata->u.ap.ps.dtim_count =3D
+               cl_hw->ipc_env->ring_indices_elem->indices->dtim_count[vif_=
index];
+
+       /*
+        * If we are in the middle of the CAC, we allow regular channel swi=
tch
+        * and retrigger the CAC (If needed).
+        */
+       if (cl_dfs_is_in_cac(cl_hw) && vif->csa_active) {
+               /*
+                * TODO: if radar is detected, we wait for all CSAs to be t=
ransmitted,
+                * before allowing channel switch
+                */
+
+               ieee80211_csa_finish(vif);
+               return;
+       }
+
+       skb =3D cl_tx_beacon_get(cl_hw->hw, vif);
+       if (!skb)
+               return;
+
+       /* Route this BCN to the BCN ipc queue */
+       tx_info =3D IEEE80211_SKB_CB(skb);
+       tx_info->hw_queue =3D CL_HWQ_BCN;
+
+       cl_tx_single(cl_hw, NULL, skb, false, true);
+}
+
+/* Cl_tx_bcns - generate BCNs and TX buffered MC frames each BCN DTIM inte=
rval
+ *
+ * Beacons are sent first followed by cyclic MC for fairness between VIF's
+ * the FW buffer is restricted to "IPC_TXDESC_CNT_BCMC" buffer size.
+ */
+void cl_tx_bcns(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif =3D NULL;
+       int mc_fw_free =3D 0;
+
+       /* Don't send beacons during scan */
+       if (cl_channel_is_scan_active(cl_hw))
+               return;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               cl_tx_bcn(cl_vif);
+
+       cl_vif =3D cl_hw->mc_vif;
+       mc_fw_free =3D cl_hw->tx_queues.bcmc.fw_free_space;
+
+       do {
+               cl_tx_mc(cl_vif, &mc_fw_free);
+               /* Cl_vif_get_next() is cyclic */
+               cl_vif =3D cl_vif_get_next(cl_hw, cl_vif);
+       } while ((cl_vif !=3D cl_hw->mc_vif) && mc_fw_free);
+
+       cl_hw->mc_vif =3D cl_vif_get_next(cl_hw, cl_hw->mc_vif);
+}
+
+void cl_tx_en(struct cl_hw *cl_hw, u8 reason, bool enable)
+{
+       unsigned long tx_disable_flags_prev =3D cl_hw->tx_disable_flags;
+
+       if (enable) {
+               clear_bit(reason, &cl_hw->tx_disable_flags);
+
+               if (tx_disable_flags_prev !=3D 0 && cl_hw->tx_disable_flags=
 =3D=3D 0)
+                       if (cl_hw->conf->ci_backup_bcn_en)
+                               cl_msg_tx_backup_bcn_en(cl_hw, true);
+       } else {
+               set_bit(reason, &cl_hw->tx_disable_flags);
+
+               if (tx_disable_flags_prev =3D=3D 0)
+                       if (cl_hw->conf->ci_backup_bcn_en)
+                               cl_msg_tx_backup_bcn_en(cl_hw, false);
+       }
+}
+
+static void cl_tx_flush(struct cl_hw *cl_hw)
+{
+       unsigned long flags;
+
+       /* Flush bcmc */
+       spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+       cl_bcmc_cfm_flush_queue(cl_hw);
+       spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+
+       /* Flush single */
+       spin_lock_bh(&cl_hw->tx_lock_single);
+       cl_txq_flush_all_single(cl_hw);
+       cl_single_cfm_flush_all(cl_hw);
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+
+       /* Flush agg */
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+       cl_txq_flush_all_agg(cl_hw);
+       cl_agg_cfm_flush_all(cl_hw);
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+void cl_tx_off(struct cl_hw *cl_hw)
+{
+       cl_tx_stop_remote_cpu(cl_hw);
+       cl_txq_stop(cl_hw);
+       cl_tx_flush(cl_hw);
+}
+
+static void cl_tx_set_mapping(struct cl_hw *cl_hw, struct sk_buff *skb, st=
ruct net_device *dev)
+{
+       struct cl_vif *cl_vif =3D NETDEV_TO_CL_VIF(dev);
+       u8 vif_index =3D cl_vif->vif_index;
+
+       if (!cl_hw->conf->ha_wmm_enabled[vif_index]) {
+               skb->priority =3D 0;
+               goto set_queue_mapping;
+       }
+
+       if (cl_vlan_dscp_is_enabled(cl_hw, cl_vif)) {
+               skb->priority =3D cl_vlan_dscp_check_ether_type(cl_hw, skb,=
 vif_index);
+       } else {
+               /*
+                * TODO: IPv6 support
+                * TODO: VLAN user priority support
+                */
+
+               u8 i =3D 0, dcsp_val =3D 0, *src_buf =3D NULL;
+               u16 ether_type =3D get_ether_type(2 * ETH_ALEN, skb->data);
+
+               /* Patch until IPv6 will be supported - set priority to 0 *=
/
+               if (ether_type !=3D ETH_P_IP) {
+                       skb->priority =3D 0;
+                       goto set_queue_mapping;
+               }
+
+               src_buf =3D skb->data;
+               src_buf +=3D ETH_HLEN;
+               dcsp_val =3D (*(src_buf + 1) & 0xec) >> 2;
+
+               for (i =3D 0; i < TID_MAX; i++)
+                       if (dscp_to_up[i] =3D=3D dcsp_val) {
+                               skb->priority =3D i;
+                               break;
+                       }
+       }
+
+set_queue_mapping:
+       skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
+}
+
+static bool cl_tx_packet_limit(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       if (cl_hw->conf->ci_tx_packet_limit > 0)
+               return (atomic_read(&cl_hw->tx_packet_count) >=3D cl_hw->co=
nf->ci_tx_packet_limit);
+
+       return false;
+}
+
+static void cl_tx_destructor(struct sk_buff *skb)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(skb=
->dev);
+       struct cl_hw *cl_hw =3D sdata->local->hw.priv;
+
+       atomic_dec(&cl_hw->tx_packet_count);
+}
+
+void cl_tx_drop_dkb(struct sk_buff *skb)
+{
+       skb->dev->stats.rx_dropped++;
+       kfree_skb(skb);
+}
+
+static netdev_tx_t _____cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *s=
kb,
+                                   struct net_device *dev, struct cl_sta *=
cl_sta)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev=
);
+       struct ieee80211_vif *vif =3D &sdata->vif;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       int buffer_cnt =3D 0;
+       u8 hw_queue =3D vif->hw_queue[skb_get_queue_mapping(skb)];
+
+       cl_hw->tx_packet_cntr.forward.tx_start++;
+
+       if (cl_hw->wd_restart_drv) {
+               cl_hw->tx_packet_cntr.drop.wd_restart++;
+               cl_tx_drop_dkb(skb);
+               return NETDEV_TX_OK;
+       }
+
+       if (cl_radio_is_off(cl_hw)) {
+               cl_hw->tx_packet_cntr.drop.radio_off++;
+               cl_tx_drop_dkb(skb);
+               return NETDEV_TX_OK;
+       }
+
+       if (cl_recovery_in_progress(cl_hw)) {
+               cl_hw->tx_packet_cntr.drop.in_recovery++;
+               cl_tx_drop_dkb(skb);
+               return NETDEV_TX_OK;
+       }
+
+       if (skb->len < ETH_HLEN) {
+               cl_hw->tx_packet_cntr.drop.short_length++;
+               cl_tx_drop_dkb(skb);
+               return NETDEV_TX_OK;
+       }
+
+       if (skb_queue_len(&sdata->local->pending[hw_queue]) >=3D
+           cl_hw->conf->ci_pending_queue_size) {
+               cl_hw->tx_packet_cntr.drop.pending_full++;
+               cl_tx_drop_dkb(skb);
+               tasklet_schedule(&sdata->local->tx_pending_tasklet);
+               return NETDEV_TX_OK;
+       }
+
+       /* Limit total packets for TX */
+       if (cl_tx_packet_limit(cl_hw, skb)) {
+               cl_hw->tx_packet_cntr.drop.packet_limit++;
+               cl_tx_drop_dkb(skb);
+               return NETDEV_TX_OK;
+       }
+
+       if (!skb->destructor) {
+               skb->destructor =3D cl_tx_destructor;
+               buffer_cnt =3D atomic_inc_return(&cl_hw->tx_packet_count);
+       }
+
+       memset(tx_info, 0, sizeof(struct ieee80211_tx_info));
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_start(cl_hw->idx, skb, buffer_cnt);
+#endif
+       if (cl_sta && cl_sta->stainfo &&
+           (test_sta_flag(cl_sta->stainfo, WLAN_STA_AUTHORIZED))) {
+               u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+               bool is_agg =3D cl_tx_check_agg(sdata, skb);
+
+               cl_traffic_tx_handler(cl_hw, cl_sta, skb->len);
+
+               if (!ieee80211_vif_is_mesh(&sdata->vif)) {
+                       if (is_agg && cl_sta->agg_tx_queues[tid])
+                               cl_tx_fast_agg(cl_hw, cl_sta, skb, true);
+                       else if (is_agg && cl_sta->baws[tid].action_start)
+                               __skb_queue_tail(&cl_sta->baws[tid].pending=
, skb);
+                       else
+                               cl_tx_fast_single(cl_hw, cl_sta, skb, true)=
;
+
+                       return NETDEV_TX_OK;
+               }
+       }
+
+       cl_hw->tx_packet_cntr.forward.to_mac++;
+       cl_vif->orig_dev_ops->ndo_start_xmit(skb, dev);
+
+       return NETDEV_TX_OK;
+}
+
+netdev_tx_t ____cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, stru=
ct net_device *dev)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev=
);
+       struct cl_sta *cl_sta;
+
+       cl_sta_lock(cl_hw);
+
+       if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION)
+               cl_sta =3D cl_sta_get_by_addr(cl_hw, sdata->u.mgd.bssid);
+       else
+               cl_sta =3D cl_sta_get_by_addr(cl_hw, skb->data);
+
+       if (cl_sta) {
+               netdev_tx_t ret =3D _____cl_tx_start(cl_hw, skb, dev, cl_st=
a);
+
+               cl_sta_unlock(cl_hw);
+               return ret;
+       }
+
+       cl_sta_unlock(cl_hw);
+       return _____cl_tx_start(cl_hw, skb, dev, NULL);
+}
+
+netdev_tx_t ___cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struc=
t net_device *dev)
+{
+       skb->dev =3D dev;
+       cl_tx_set_mapping(cl_hw, skb, dev);
+
+       return ____cl_tx_start(cl_hw, skb, dev);
+}
+
+netdev_tx_t __cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struct=
 net_device *dev)
+{
+       if (!skb_mac_header_was_set(skb))
+               skb_reset_mac_header(skb);
+
+       return ___cl_tx_start(cl_hw, skb, dev);
+}
+
+netdev_tx_t _cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struct =
net_device *dev)
+{
+       int cpu =3D cl_hw->conf->ci_tx_remote_cpu;
+
+       if (cpu =3D=3D -1)
+               return __cl_tx_start(cl_hw, skb, dev);
+
+       skb->dev =3D dev;
+       cl_tx_remote_cpu(cl_hw, skb, cpu);
+       return NETDEV_TX_OK;
+}
+
+netdev_tx_t cl_tx_start(struct sk_buff *skb, struct net_device *dev)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev=
);
+       struct cl_hw *cl_hw =3D sdata->local->hw.priv;
+
+       return _cl_tx_start(cl_hw, skb, dev);
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

