Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0583AB8B2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhFQQJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:53 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:62080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhFQQIi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0qKz1F5dFw683zn1h+gOVn780kC1lsGbWiEQNSDe9iMtLcnvzczWk8DzruiCzIX5zH+64C+kkyxRy+/2cBSAdkXIJsWXKquMXMk3vVlFAZykULg8KQ2EaU3UY/MSwcg5p4tNqMhuC8cBdO4fZHlarMvidxWXrJY0Kg9XHVcSLPrVakU5OOmquHcyvpi+4fOPIiUcY3Q+nU5ZJxYGE/t7t4nUOy3y8MsydFkXbFzhgZSZNMjJPQSlp0MI/0/XisCwp/XuDRlNS7cVX2+pieyBq6tFW7L11t9ivmTz92fXsBUDXSgCzPGqAVtmyrosCVNEG+eukiLGyuCOcskFNkXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAG28DIo4QVVSDNtJ3nWkShyRvWvM2f8U3sApPWgAOg=;
 b=MN4wRqFv40Ayxywfr3EtFFqXcC7xfJYS/O4l9xRpCgQWAKGeTtQfQXy08tOrEA0fWxd+pA8cWHdIqG+vlY+uLk2ppVOViOryhegIHORWUj9QSikt7h5p0epfXPBfDsX1a1aM4O4jIxIthVifNJZIEyT/b0khnSi57G1hT6euLNRKEJWfbBbFOqHl4zyyg0tTuy693DbbVl71yc7gdgiVitNNcRZ7f4neBCrgRTl1Zp37RnCu8JG4DlwuPvj5w2yj535Fwb4Cat3XEyuPnbKHAusfVcU0lWc8z0u0GAVUickZwU+zop4alUKyg/gcw/BC/ZSMlt7z+99i8KJNnFCSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAG28DIo4QVVSDNtJ3nWkShyRvWvM2f8U3sApPWgAOg=;
 b=m9mTLk3kw7c+c3fACaIaxPjnsTUamxR8eYcAMh3yls6oW6LveqyQkOygorEghDrgloJrL+SSVjHBcyNDZGBXVqVrzt4ny4kLfKiXmyVvp/OkVwZNJkCx1ufCq+77E1i9Hy7MtTCe40Boi5dBsE0/gUIijLRElRbxj5FTvUXBdts=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:12 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:12 +0000
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
Subject: [RFC v1 119/256] cl8k: add noise.c
Date:   Thu, 17 Jun 2021 16:00:06 +0000
Message-Id: <20210617160223.160998-120-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1a978f-3db3-4e9b-804c-08d931a9a010
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04021E27119F6BD3A61A74A3F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npY8sgtAUnDfjeGyQ1GYPEazoO2eH9s/KNjZu7ZHpEEfT8x8OjtSSG3yqpNnJuTzP+wKcKwmQnp26qSEGj5NgJNpNa/7SCUNipmDo2+YdAGOuQqFfXirT8Ia5recdlUdhh/MjHEcsfdR72As43YX503xbDdKI97agtzLu+yNgX0lEQrw9tLPwS5Xd2R6394WAC8X0Fk3HSadTJv4RpZtsFp5v5+xI79Jp0fla/31/i5K3m9jsW1BnO6UyNVVtZet6NhttfSdwaC+CIwygCYsbdh5AG6hLW72C9d6JPbXK3lTHQpCIquS1TUZaWuj94tzOAClTkd/X76cKowSaAUZP5kngcCX5nDk8jb2PMZCCv2rjTj/Dbj7nAeCbmTDEVGcnN1nSik+iIxmP/aRWiBj+gaf7h+fNMINqYqU8Cn7dbTNQ2E+5QCEGlYVTovuxSJlnk9lfybymQNknyC0rFKi+s+qySwEp6jdeG85comoWY6x6OntmnhpZ8+09Xqm0MU2jOHpvK9aKReZQEda4Srdg0oSdrrKzJ4UAHJq6EyAZ5EV68IAGFnhQ0nSxIh8FHO2LBWCblK6G3IcPQ17cqpMAxFcadcCsGsoCZ9W4tHyeHyuFrinYOZxNeOPMVIfkPRlvQrUze7CVkZ2gbNb969gaKGI1YdmfZYfDK6B8NlntPa8C1fjC2g0CSCJK4Iwl+XfKLQdyWe9Fz7so6WndtyMwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(30864003)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O4LKxvcLejaRCH/Nd1ClBNkMS7ldymbA3XIq/iDmMm46hD1Ljhqd8AHR5La5?=
 =?us-ascii?Q?mDiZVihEpclRzfG0ZK0v6m+6RPO9AK+mUc0KJzYvAS8vxBhynXDPmW0tKzT3?=
 =?us-ascii?Q?FdPvb3SGCR47XiQrP+ti0ta9RvT7vN8CBfL8BbUAUuyOWxQhYueSFQVLFtmB?=
 =?us-ascii?Q?m5hMBognqWcqqCkX1GS9uZPnDg1cRjJivHzgDIOS/P4khSjrhSAmpYrriFs0?=
 =?us-ascii?Q?HGOpaA4othN4wOBPLPfnmjomR8R2RVdEk1TwOKdQtY2WD/o1Pc15XtOqP12Y?=
 =?us-ascii?Q?iiBx1QomJpYUG7HkvEPCjCUVx2HKrkrjV5HRjI24JI8g0ifNyv1SpbV5/sdW?=
 =?us-ascii?Q?xCTa8CIpQ6NmK2eK7DwWEni+auPK17FOQmvxL37QBqCOq5WPz41hfrCZKBe9?=
 =?us-ascii?Q?HC3ghwWS+j/+fveYKC+ivD1Sexq5xfWlQ8rBXN9VmVi/uhMhiov7Uru5xOlb?=
 =?us-ascii?Q?lnn5fAG5ono+j6fJzOVVyOTZEs3GmPmIo3+jLCZnRJqWatj/SX/vJzu8424R?=
 =?us-ascii?Q?JFa30zAViAQGrZS0kSMiX8WIgzf2RAjj/7c0YjONHsVefFi+i9Gq3tWt+fGN?=
 =?us-ascii?Q?SQLdIPQE+qUN+KFUrcC6a8Cny/m447o1HbFIq4MAbLWjSj/sHhjCSdqz7YTr?=
 =?us-ascii?Q?b66LhYJL0gejc0ZYDnwFSZhAi2NcMiwQQw+VDCK0B3jixKDtXmhjZqMLfJec?=
 =?us-ascii?Q?fsKVUwO1N1LnXWiMLVqkMRJy/rzTvhshJs1NTRAu3jP7zguMymN0MZEkcqg4?=
 =?us-ascii?Q?tJl4yAcqNpJKrmqzModvol2W64c1ymhmNN6cTFs8uKv1nQBDph8vF1WzCbah?=
 =?us-ascii?Q?7L3PAlM2IKYqSMfSlFApeMgqTlaUgRxiynI87l/HYvXj+kOWABoij1Jb//aO?=
 =?us-ascii?Q?n8qZH3wZ7PBnJaaVaOvSEnX1gC8lgbss7Xuy+E/drlhGe1dOfz3cnLC2E6a0?=
 =?us-ascii?Q?RF3Nl0yPyv0fGHDDilSgtlj9KgTxTeSlxm9qzaVzSaXSlCPGrzo6dYz3bGF2?=
 =?us-ascii?Q?d03dltZp/rcTRJaAxYHHCeW+EmSYgdmO8DVIgjRy1BJD2itd3NyaqgyqoD6a?=
 =?us-ascii?Q?izEOKpygpmJ+9Vcw6uU04J3I24UKBOsQwkQVdkk8Gn+wgQOa8QQePV5QyOTe?=
 =?us-ascii?Q?0rzhcVmRP+UZFyb/xPGvZzvT6JDTlDPlBLVXFyKmDzRvyIKV99UEl3o/RviF?=
 =?us-ascii?Q?XTpuWzBhTCFBL+VEIDsYUkRWlA0rJglZgGpy+GtLU2TqJzM1srCgATrY0jy1?=
 =?us-ascii?Q?WZ+FjsyU0iLC1urC+5wnnyfSsoeOL6kHVQi3fm9JDWxI60NJKGEFkjhVYU/u?=
 =?us-ascii?Q?gLZafajFHoUfewf5c99WXJ63?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1a978f-3db3-4e9b-804c-08d931a9a010
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:45.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkvsIGkLwVBXYnh+hFJUvneVE/5oaamlotXyMYjN9yR+UFK3C6Zl6BoX2S0fk9Jg/w5fS7hYkONwwbx3ID0ekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/noise.c | 499 +++++++++++++++++++++++
 1 file changed, 499 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/noise.c

diff --git a/drivers/net/wireless/celeno/cl8k/noise.c b/drivers/net/wireles=
s/celeno/cl8k/noise.c
new file mode 100644
index 000000000000..0bfd025196a6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/noise.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/list.h>
+#include "hw.h"
+#include "noise.h"
+#include "reg/reg_riu.h"
+#include "utils/utils.h"
+
+#define NOISE_LOWER_LIMIT -100
+#define NOISE_UPPER_LIMIT -30
+/* Range is -100dBm to -30dBm */
+#define NOISE_SCALE_RANGE  (NOISE_UPPER_LIMIT - NOISE_LOWER_LIMIT + 1)
+#define NOISE_MAX_SAMPLES  U8_MAX
+#define MAX_20M_SUB_BAND   8
+#define MAX_SEC_BW_CNT     3
+#define MAX_ANT_PER_REG    4
+
+static s8 cl_noise_process_sample(u32 sample, u8 cnt)
+{
+       s8 val =3D (s8)((sample >> (8 * cnt)) & 0xff);
+
+       if (val < NOISE_LOWER_LIMIT)
+               val =3D NOISE_LOWER_LIMIT;
+       else if (val > NOISE_UPPER_LIMIT)
+               val =3D NOISE_UPPER_LIMIT;
+
+       return val;
+}
+
+static bool cl_noise_is_hist_line_empty(u8 *hist, u8 cnt)
+{
+       u8 i;
+
+       for (i =3D 0; i < cnt; i++)
+               if (hist[i] !=3D 0)
+                       return false;
+
+       return true;
+}
+
+static int cl_noise_print_hist(struct cl_hw *cl_hw, bool nasp_stats)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       struct cl_noise_reg *reg =3D NULL;
+       u8 hist[NOISE_SCALE_RANGE][MAX_ANTENNAS] =3D { { 0 } };
+       u8 num_antennas =3D cl_hw->num_antennas;
+       s8 val_stat;
+       u8 i =3D 0, j =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (list_empty(&noise_db->reg_list))
+               return 0;
+
+       list_for_each_entry(reg, &noise_db->reg_list, list) {
+               for (i =3D 0; i < min_t(u8, num_antennas, MAX_ANT_PER_REG);=
 i++) {
+                       if (nasp_stats)
+                               val_stat =3D cl_noise_process_sample(reg->n=
asp_prim20_per_ant, i);
+                       else
+                               val_stat =3D cl_noise_process_sample(reg->n=
p_prim20_per_ant, i);
+
+                       hist[(val_stat * -1) + NOISE_UPPER_LIMIT][i]++;
+               }
+
+               if (num_antennas <=3D MAX_ANT_PER_REG)
+                       continue;
+
+               for (i =3D 0; i < num_antennas - MAX_ANT_PER_REG; i++) {
+                       if (nasp_stats)
+                               val_stat =3D cl_noise_process_sample(reg->n=
asp_prim20_per_ant2, i);
+                       else
+                               val_stat =3D cl_noise_process_sample(reg->n=
p_prim20_per_ant2, i);
+
+                       hist[(val_stat * -1) + NOISE_UPPER_LIMIT][i + MAX_A=
NT_PER_REG]++;
+               }
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Noise %sstrength histogram (dBm):\n", nasp_stats ? "an=
d signal " : "");
+
+       cl_snprintf(&buf, &len, &buf_size, "------------------");
+       for (j =3D 0; j < num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "-------");
+
+       cl_snprintf(&buf, &len, &buf_size, "\n| Noise Strength ");
+
+       for (j =3D 0; j < num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "| Ant%u ", j);
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n|----------------");
+
+       for (j =3D 0; j < num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       for (i =3D 0; i < NOISE_SCALE_RANGE; i++) {
+               if (cl_noise_is_hist_line_empty(hist[i], num_antennas))
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size, "|%9d       ", -i + NOIS=
E_UPPER_LIMIT);
+               for (j =3D 0; j < num_antennas; j++)
+                       cl_snprintf(&buf, &len, &buf_size, "| %3u  ", hist[=
i][j]);
+
+               cl_snprintf(&buf, &len, &buf_size, "|\n");
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|----------------");
+       for (j =3D 0; j < num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_noise_print_hist_per_channel(struct cl_hw *cl_hw,
+                                          bool nasp_stats)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       struct cl_noise_reg *reg =3D NULL;
+       u8 ch_bw =3D cl_hw->conf->ce_channel_bandwidth;
+       u8 ch_cnt =3D 1 << ch_bw;
+       u8 hist[NOISE_SCALE_RANGE][MAX_20M_SUB_BAND] =3D { { 0 } };
+       s8 val1, val2;
+       u8 i =3D 0, j =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (list_empty(&noise_db->reg_list))
+               return 0;
+
+       list_for_each_entry(reg, &noise_db->reg_list, list) {
+               for (i =3D 0; i < min_t(u8, ch_cnt, MAX_ANT_PER_REG); i++) =
{
+                       if (nasp_stats) {
+                               val1 =3D cl_noise_process_sample(reg->nasp_=
sub20_per_chn, i);
+
+                               if (ch_bw =3D=3D CHNL_BW_160)
+                                       val2 =3D cl_noise_process_sample(re=
g->nasp_sub20_per_chn2, i);
+                       } else {
+                               val1 =3D cl_noise_process_sample(reg->np_su=
b20_per_chn, i);
+
+                               if (ch_bw =3D=3D CHNL_BW_160)
+                                       val2 =3D cl_noise_process_sample(re=
g->np_sub20_per_chn2, i);
+                       }
+
+                       hist[(val1 * -1) + NOISE_UPPER_LIMIT][i]++;
+                       if (ch_bw =3D=3D CHNL_BW_160)
+                               hist[(val2 * -1) + NOISE_UPPER_LIMIT][i + M=
AX_ANT_PER_REG]++;
+               }
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Noise %sstrength per 20 Mhz channel histogram ant %u (=
dBm):\n"
+                   "------------------",
+                   nasp_stats ? "and signal " : "", noise_db->active_ant);
+
+       for (j =3D 0; j < ch_cnt; j++)
+               cl_snprintf(&buf, &len, &buf_size, "--------");
+
+       cl_snprintf(&buf, &len, &buf_size, "\n| Noise Strength ");
+       for (j =3D 0; j < ch_cnt; j++)
+               cl_snprintf(&buf, &len, &buf_size, "| Chan%u ", j);
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n|----------------");
+
+       for (j =3D 0; j < ch_cnt; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+-------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       for (i =3D 0; i < NOISE_SCALE_RANGE; i++) {
+               if (cl_noise_is_hist_line_empty(hist[i], ch_cnt))
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size, "|%9d       ", -i + NOIS=
E_UPPER_LIMIT);
+
+               for (j =3D 0; j < ch_cnt; j++)
+                       cl_snprintf(&buf, &len, &buf_size, "| %3u   ", hist=
[i][j]);
+
+               cl_snprintf(&buf, &len, &buf_size, "|\n");
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|----------------");
+
+       for (j =3D 0; j < ch_cnt; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+-------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_noise_print_hist_dens(struct cl_hw *cl_hw, bool nasp_stats)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       struct cl_noise_reg *reg =3D NULL;
+       u8 hist[NOISE_SCALE_RANGE][MAX_SEC_BW_CNT] =3D { { 0 } };
+       u8 ch_bw =3D cl_hw->conf->ce_channel_bandwidth;
+       s8 val;
+       u8 i =3D 0, j =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (list_empty(&noise_db->reg_list) || ch_bw =3D=3D 0)
+               return 0;
+
+       list_for_each_entry(reg, &noise_db->reg_list, list) {
+               for (i =3D 0; i < ch_bw; i++) {
+                       if (nasp_stats)
+                               val =3D cl_noise_process_sample(reg->nasp_s=
ec20_dens_per_ant, i);
+                       else
+                               val =3D cl_noise_process_sample(reg->np_sec=
20_dens_per_ant, i);
+
+                       hist[(val * -1) + NOISE_UPPER_LIMIT][i]++;
+               }
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Noise %spower density histogram ant %u (dBm/20Mhz):\n"=
,
+                   nasp_stats ? "and signal " : "", noise_db->active_ant);
+
+       cl_snprintf(&buf, &len, &buf_size, "-----------------");
+
+       for (j =3D 0; j < ch_bw; j++)
+               cl_snprintf(&buf, &len, &buf_size, "--------");
+
+       cl_snprintf(&buf, &len, &buf_size, "\n| Noise Density ");
+
+       for (j =3D 0; j < ch_bw; j++)
+               cl_snprintf(&buf, &len, &buf_size, "| SEC%u ", 20 * (1 << j=
));
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n|---------------");
+       for (j =3D 0; j < ch_bw; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+-------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       for (i =3D 0; i < NOISE_SCALE_RANGE; i++) {
+               if (cl_noise_is_hist_line_empty(hist[i], ch_bw))
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size, "|%9d      ", -i + NOISE=
_UPPER_LIMIT);
+               for (j =3D 0; j < ch_bw; j++)
+                       cl_snprintf(&buf, &len, &buf_size, "| %3u   ", hist=
[i][j]);
+
+               cl_snprintf(&buf, &len, &buf_size, "|\n");
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|---------------");
+       for (j =3D 0; j < ch_bw; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+-------");
+
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_noise_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "stats usage:\n"
+                "-a : Set antenna\n"
+                "-b : En/Dis noise histogram [0-stop, max samples-255]\n"
+                "-c : Print 20Mhz channels noise power\n"
+                "-d : Print 20Mhz channels noise and signal power\n"
+                "-e : Print noise density histogram\n"
+                "-f : Print noise and signal density histogram\n"
+                "-g : Print noise power histogram\n"
+                "-h : Print noise and signal power histogram\n"
+                "-r : Reset histogram\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_noise_set_ant(struct cl_hw *cl_hw, u8 active_ant)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       u8 max_ant =3D cl_hw->num_antennas - 1;
+
+       if (noise_db->sample_cnt !=3D 0) {
+               pr_warn("Can't set antenna during statistics collection\n")=
;
+               return;
+       }
+
+       if (active_ant > max_ant) {
+               pr_err("Invalid antennas configuration. Should be 0-%u!\n",=
 max_ant);
+               return;
+       }
+
+       if (active_ant =3D=3D noise_db->active_ant) {
+               pr_warn("Ant %u already set!\n", active_ant);
+               return;
+       }
+
+       /* Antenna is different now so clear all stats */
+       cl_noise_close(cl_hw);
+
+       riu_rwnxagcccactrl_cca_main_ant_sel_setf(cl_hw, active_ant);
+
+       noise_db->active_ant =3D active_ant;
+
+       pr_debug("Antenna selected : %u\n", active_ant);
+}
+
+void cl_noise_init(struct cl_hw *cl_hw)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+
+       INIT_LIST_HEAD(&noise_db->reg_list);
+}
+
+void cl_noise_close(struct cl_hw *cl_hw)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       struct cl_noise_reg *elem =3D NULL;
+       struct cl_noise_reg *tmp =3D NULL;
+
+       list_for_each_entry_safe(elem, tmp, &noise_db->reg_list, list) {
+               list_del(&elem->list);
+               kfree(elem);
+       }
+}
+
+void cl_noise_maintenance(struct cl_hw *cl_hw)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       struct cl_noise_reg *reg =3D NULL;
+       u8 ch_bw =3D cl_hw->conf->ce_channel_bandwidth;
+
+       if (noise_db->sample_cnt =3D=3D 0)
+               return;
+
+       reg =3D kzalloc(sizeof(*reg), GFP_ATOMIC);
+
+       if (!reg)
+               return;
+
+       /*collect statistics */
+       reg->np_prim20_per_ant =3D riu_agcinbdpow_20_pnoisestat_get(cl_hw);
+       reg->np_sub20_per_chn =3D riu_agcinbdpownoiseper_20_stat_0_get(cl_h=
w);
+       reg->np_sec20_dens_per_ant =3D riu_agcinbdpowsecnoisestat_get(cl_hw=
);
+       reg->nasp_prim20_per_ant =3D riu_inbdpowformac_0_get(cl_hw);
+       reg->nasp_sub20_per_chn =3D riu_inbdpowformac_3_get(cl_hw);
+       reg->nasp_sec20_dens_per_ant =3D riu_inbdpowformac_2_get(cl_hw);
+
+       if (ch_bw =3D=3D CHNL_BW_160) {
+               reg->np_sub20_per_chn2 =3D riu_agcinbdpownoiseper_20_stat_1=
_get(cl_hw);
+               reg->nasp_sub20_per_chn2 =3D riu_inbdpowformac_4_get(cl_hw)=
;
+       }
+
+       if (cl_hw->num_antennas > MAX_ANT_PER_REG) {
+               reg->np_prim20_per_ant2 =3D riu_agcinbdpow_20_pnoisestat_2_=
get(cl_hw);
+               reg->nasp_prim20_per_ant2 =3D riu_inbdpowformac_1_get(cl_hw=
);
+       }
+
+       list_add(&reg->list, &noise_db->reg_list);
+
+       noise_db->sample_cnt--;
+
+       if (noise_db->sample_cnt =3D=3D 0)
+               pr_debug("record done\n");
+}
+
+int cl_noise_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       struct cl_noise_db *noise_db =3D &cl_hw->noise_db;
+       bool set_ant =3D false;
+       bool hist_enable =3D false;
+       bool hist_per_channel =3D false;
+       bool hist_mac_per_channel =3D false;
+       bool hist_dens =3D false;
+       bool hist_mac_dens =3D false;
+       bool hist_pwr_print =3D false;
+       bool hist_mac_pwr_print =3D false;
+       bool hist_reset =3D false;
+       u32 param =3D (u32)cli_params->params[0];
+       u32 expected_params =3D -1;
+
+       switch (cli_params->option) {
+       case 'a':
+               set_ant =3D true;
+               expected_params =3D 1;
+               break;
+       case 'b':
+               hist_enable =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               hist_per_channel =3D true;
+               expected_params =3D 0;
+               break;
+       case 'd':
+               hist_mac_per_channel =3D true;
+               expected_params =3D 0;
+               break;
+       case 'e':
+               hist_dens =3D true;
+               expected_params =3D 0;
+               break;
+       case 'f':
+               hist_mac_dens =3D true;
+               expected_params =3D 0;
+               break;
+       case 'g':
+               hist_pwr_print =3D true;
+               expected_params =3D 0;
+               break;
+       case 'h':
+               hist_mac_pwr_print =3D true;
+               expected_params =3D 0;
+               break;
+       case 'r':
+               hist_reset =3D true;
+               expected_params =3D 0;
+               break;
+       case '?':
+               return cl_noise_cli_help(cl_hw);
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
+       if (set_ant) {
+               cl_noise_set_ant(cl_hw, (u8)param);
+
+               return 0;
+       }
+
+       if (hist_enable) {
+               if (param > NOISE_MAX_SAMPLES) {
+                       pr_err("Error! Max samples should be < %u\n", NOISE=
_MAX_SAMPLES);
+               } else {
+                       pr_debug("%s record histogram\n", param ? "Start" :=
 "Stop");
+                       noise_db->sample_cnt =3D param;
+               }
+
+               return 0;
+       }
+
+       if (hist_per_channel)
+               return cl_noise_print_hist_per_channel(cl_hw, false);
+
+       if (hist_mac_per_channel)
+               return cl_noise_print_hist_per_channel(cl_hw, true);
+
+       if (hist_dens)
+               return cl_noise_print_hist_dens(cl_hw, false);
+
+       if (hist_mac_dens)
+               return cl_noise_print_hist_dens(cl_hw, true);
+
+       if (hist_pwr_print)
+               return cl_noise_print_hist(cl_hw, false);
+
+       if (hist_mac_pwr_print)
+               return cl_noise_print_hist(cl_hw, true);
+
+       if (hist_reset) {
+               pr_debug("Clear histogram\n");
+               cl_noise_close(cl_hw);
+               return 0;
+       }
+
+out_err:
+       return -EIO;
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

