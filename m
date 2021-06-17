Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24BD3AB927
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFQQNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:06 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:59547
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233693AbhFQQLw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp61VMF/EcZFzMcooYL+LPQCnHQM1HFNnzy1kHwJPGiYUJKDdRvEHEAlg+l0+YgA7vc1YWZfDJ4V/Ns5frAKU7IcH56wJVosRWVPbDucHqvFHM59ER7+Hl5iCzzANm/o3VPJH5SO3NNFKDnKbUOAM9Hkri4ErETEaNasb622u2+rF2Le6KY9iQxrpczz8zgVIOu5EDamB3ARw2dWEwo+5RpcvuVuICfPaYui2ZwzDrAodX9QP8hVEJKkk+ZHWQqVkimWV/BJC32Kq8e1PLqSkgXzEwVWfHaQPOoe5UxCyhrX/e+bOsq4EDeSar2s93WXw6rSuEG08HPQhCc2ndjizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBwgm0yp/JjJADD/5k6NBSeL6KB2YeL4A1nO6qbaFbo=;
 b=DO3R7eccB9kS8iwwcR1BRKv7ZJZosxnMSsNfh/X/ShtcjRtppEaGUsDfI3Yw5aXfORo3JzmuDd5uiwFwuU+Z8MNZ8tx/H0q0/RojT/6e2uqDD1H2RzuHZCoO35Q01GxO4GFF5KNsnonzI2iIEhHv/5oZ0G138DjAYVvT6vVF0BwjCYA8qO0hF+lQEOWjM7E9PraNsBVFU5W1KwPmpdlelPIbwZPrm28hPJMToKPoHM80JBUN06JJeuUSjm+Xkvmw+STJDgPJ+G4CQ98Zx+ub/7qpW6eCB/I1hT9x1hJ1lkBv5GQNENIWzsDs1ZjP1teIR/eVN8HfI+OCYn/hVwVWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBwgm0yp/JjJADD/5k6NBSeL6KB2YeL4A1nO6qbaFbo=;
 b=bZlBBQdpnthxzHLlba9MmFlgC4Yr70jdHMOvetMPLC2tVzwpPZ1FDWgJxQAvPaBAC0OoT28Jbq0utHEXdJnuIQAPQoYCt3eL4xhtzViAEyNDeJODaCP62vG+ZPpXW1xjbSjyFPKdQ4hZgUi9lX6Dd/NTMTo+lvi5wqMjAGhJkio=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:56 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:56 +0000
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
Subject: [RFC v1 227/256] cl8k: add utils/timer.c
Date:   Thu, 17 Jun 2021 16:01:54 +0000
Message-Id: <20210617160223.160998-228-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71045015-cfb7-4fd5-9cc8-08d931a9e902
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04529C198AF539D5EFB289AEF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8KlmAvAPOeypdYa6KWN2JUPShL8dSoA4xodl5tkcSOT8JNU/y8MrCy9HmCc3yqOuy7l8gfr5FOFkWhhmIO51Z5oelBt8fFXWQBAPP8pB0KOfdpMxdqhX3qlbXAh7ecBd4RSF1SOfiwYHX9pXRUFicwspNV2Ul7LoKCIw/y8yvNLiCuAqFq6kif1NfMEXlpyvoemAljlf4V9Vja0hEqdA8YxhC3ymxpbjL7MIat+Knl9uD+XaMMxSCxu7RnxHsbjd1AnuSov4cg9RTpyftaeOb/tEgXofo9LHYI+AnEM9Bp4+EzluGPL+pKRJB0G70bAowZ3NTOhXBZwlthbLseO3muj/BCmlSaBIGuKPknQCyoHrXFaFSZ0ldsokDDv32xr3LXVewdXgsZBFitbdNy6/IyGbKTHszjqWt8OTMidNfDgCRV6QAU3agvJrgmxz84hfqFSU66CAkT3tJXwDoMoim/BPFWaPUu1t7UcbD+IpAh6QVG+E5q1kTfFiLZ5ecB/TCr2tSNDH5oSNleJTHI/vXxWS61kMtaQtu6ZssJstvzuHHfIVHhtsMCXyqeVLUffdmNu+vdyoZI7h03iIXpJFreYSgCYlVb1zwo1GHurVDIGCl09Ci+RDQkT0ab/YHB2Ujl4OPxxmpZHMruwlRdAr24gcE4S2kK7C2UqOnpljUTB26v5jpcb/e7FI4wjB/lxidWXD3K9Cyh0kniSsgnIAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?espAlb7EVOgObWDSLRwAexCuid+huNE1u16y8qupP954qrIOmPq1i+h55310?=
 =?us-ascii?Q?L52pY3AyFQ0etNFY2JiDqZjDWtbXytmQi548BwLvbyefhUT6fLUTwRR3uNtX?=
 =?us-ascii?Q?c4QEIIqtuniaa1vDN1TpjklE6u0EztS/RcpLZabXrmlFa2ZSdN8AuqAlNYbB?=
 =?us-ascii?Q?I6YWC2u8KD8DPQrpnDnq9N+xFcT+5ORgGazEyrigKOca0eulUKbM/f0PJnZx?=
 =?us-ascii?Q?vlAUwXAPvl7DIgR03AMEco1BP2VG56p56wcmxsecm0eJRVwAoZ2mRSnfE/Lh?=
 =?us-ascii?Q?jNbmil8pq7eroIrGi31UjeQGcNAU2h9rume7Z7YqZTQrao5lnOYBIkYCbzc7?=
 =?us-ascii?Q?3DJ1D9zWY2yyn9mLtEU8Utb01vl+MjNp8jy5qvdswmFwOtiw2ACflG4+dbXc?=
 =?us-ascii?Q?0j+S815KBwDvFLfejfPqu02Y8Xcd7A8Vez55bsAOGEcsBKCBPN5yGCIR4pJS?=
 =?us-ascii?Q?uUsP05sX2S1B8P/IVBZUFjtLDSZFg72lXxjVZ6PD75ZnCNp8QfACdMxVHdjh?=
 =?us-ascii?Q?0nd/pq9dxoluL0AFx2Bq1w9bGwaXD/Ry9RdT8pogjFVHNx6vvLMoaZoLrzu9?=
 =?us-ascii?Q?YPz9mWI6HG3fdi7ALpmhGmhVPDKBNMBOnemrQciKcOv8ThVdSTLqFzLwjjuh?=
 =?us-ascii?Q?cmuyP3uy3ceevwgkhgWRYpzOq0vSC/0iGIcqkhuYS/alA1VxlIqQ+euhIkJg?=
 =?us-ascii?Q?iwOb32pdFjyHO1+lF+1YWewHg8xsLg5N3Ngf1l4NWzyMXKkwieI8FqMo9oD6?=
 =?us-ascii?Q?iKvTfNSlxZFksUPMRlszi+rGhwD1CY+SVg7uRPdFaajUm0+prDHOGkeWSttC?=
 =?us-ascii?Q?wxZ0QZ6IKT0423men2M0GRt/0KEhryf8dzdbK5+QSFog6ScBBaKq7VXETq4o?=
 =?us-ascii?Q?Nyh7rMf3LZNHbKf0AuWUOix7IJBnYgCCKROFtReyt8JbmOLWPH+IdflIjkRG?=
 =?us-ascii?Q?Ps7ZIcRq6MJxf8SgrySv4lh2rfLjuW3idF0JmzD5hHnXxb3F4RuvF3x0DVOD?=
 =?us-ascii?Q?O3AYiavkaJGzNVI5648qhYGjchr236lt/wNRa47Ut1/Bp4+VnGUzVVqFgoaa?=
 =?us-ascii?Q?ZzluxgSRjJ+zzMxp+YfNcoUWM83ZzBY4C3yDNQtcZUWCn7kvqTLsDyIjdR/7?=
 =?us-ascii?Q?F7k/c3lERfioJYmssLWqTfyDdf5eusrNBATL8Rywu0M/eQINqLP2JOvHN/0f?=
 =?us-ascii?Q?AHw+++SC3WGK68GS/KHQFuIuw67E5iIZWD7EgLuWcST7VYzxpwzFs+tEyPCR?=
 =?us-ascii?Q?wk6T0TDB9GvesHS5pqqEI0/9yGqZ1Ew1He3QGj/aac1AdYiRhuigj+fjsFnc?=
 =?us-ascii?Q?p83F05zhE7Lua1axVFRT9YAM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71045015-cfb7-4fd5-9cc8-08d931a9e902
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:47.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xDBsMj/ufbeSM+hZuAu/BkG5VlZV1HPMiUhNYGsl6sM2M8eakDb5PRprIUzyT9aJsvQ4gHYqvsJu2EST2m0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/timer.c    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/timer.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils/timer.c b/drivers/net/w=
ireless/celeno/cl8k/utils/timer.c
new file mode 100644
index 000000000000..8ab8b44ef085
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/timer.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "utils/timer.h"
+
+static void cl_timer_func(struct timer_list *t)
+{
+       struct cl_timer *timer =3D from_timer(timer, t, obj);
+
+       timer->f(timer->data);
+       if (timer->enable && timer->periodic)
+               cl_timer_enable(timer);
+}
+
+void cl_timer_init(struct cl_timer *timer,
+                  void (*f)(unsigned long),
+                  unsigned long data,
+                  unsigned long period,
+                  bool periodic)
+{
+       timer_setup(&timer->obj, cl_timer_func, 0);
+       cl_timer_period_set(timer, period);
+       timer->data =3D data;
+       timer->f =3D f;
+       timer->periodic =3D periodic;
+       timer->enable =3D false;
+}
+
+void cl_timer_period_set(struct cl_timer *timer, unsigned long period)
+{
+       atomic_set(&timer->period, msecs_to_jiffies(period));
+}
+
+void cl_timer_enable(struct cl_timer *timer)
+{
+       if (timer_pending(&timer->obj))
+               return;
+
+       timer->obj.expires =3D jiffies + atomic_read(&timer->period);
+       timer->enable =3D true;
+       add_timer(&timer->obj);
+}
+
+void cl_timer_disable(struct cl_timer *timer)
+{
+       if (timer->enable) {
+               timer->enable =3D false;
+               del_timer(&timer->obj);
+       }
+}
+
+void cl_timer_disable_sync(struct cl_timer *timer)
+{
+       if (timer->enable) {
+               timer->enable =3D false;
+               del_timer_sync(&timer->obj);
+       }
+}
+
+void cl_timer_rearm(struct cl_timer *timer)
+{
+       timer->enable =3D true;
+
+       mod_timer(&timer->obj, jiffies + atomic_read(&timer->period));
+}
+
+int cl_timer_rearm_offset(struct cl_timer *timer, unsigned long time_offse=
t)
+{
+       timer->enable =3D true;
+
+       return mod_timer(&timer->obj, time_offset + atomic_read(&timer->per=
iod));
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

