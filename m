Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8E3AB93C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhFQQNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:46 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:34016
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233755AbhFQQMs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB6DdIco7Z/HrWXs3J42DvDEYGaCuX99hw7NJwuAjek05eYTxPWyfzH+pqpNHoIyYJsJyamAAC8OwlofbfkXP5qFQS/zyLXxOUJmrYPMRGX8IQu94JKlITFB0P+AmKUjsamyvVy15TI7x4opuORBMHjZnkwzHqhp/87WP6O74kHy5VTZnCTkSfaVVii9iC3jWWRu9gCFreUo2m6zDHCl/LP0KdrkLjz70MpEyMUcRu0V9SJzFZOo/KdsxbO4IR6YCydRi/0u/kwHT5FdKscyMeghcKDdQDw9qWGtr1cnIT55owjBhJDEM1vM3uT83Z1jnXV+c4VNNs7clgLwLKPopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gA88ksg5zpDBRJILZfzWIP/l123al7qxPT+vhTmXLA=;
 b=HtdCdpF15WWGSyCNWrN2BTD0ecByemyViwcGMu2bCWdq+RwtOGbSTG/G9iQfHjxv1GEvEtIXQrRwC3Wm/dEkknRk9ys44gis9pbwYXqtMA6V46/L6d5CPuP5AEk16yCjX2favs8pALb0rdzPxWyIbcTsMY223mSBQZyRlciMlQJic5WFAJHDr4CbeSvuZC4jZXBiLPh8S5kENSLsC2n9wi/LaJ74BNZDYbsXk4n9H826oZ276lUhOdLxFjZtUmf9xWrJOzsMQNHuUmzdT2kcfSBvKNsxnjp3BcYn/x6IFqgB7dGxpxKYxeK3B9y+hPqSltWjWJw0Ge84lsGstUjEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gA88ksg5zpDBRJILZfzWIP/l123al7qxPT+vhTmXLA=;
 b=H9b8x/Iw33whv5Q6VUXRw603x7tG6RW5kzZK8e77o8rP9nop9qDR/PR5fTCpiUfu/v4og9DtmM3SP/PN3pfdo14a6SrhDr8oRtJNBW8XyLTtiNRZRwY7zoUoX3Pv7T1cmjaKVtxlA3CcOFPHt9hZ4joY2eLJgVkQUeTK3SidIkQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:11 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:11 +0000
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
Subject: [RFC v1 188/256] cl8k: add temperature.c
Date:   Thu, 17 Jun 2021 16:01:15 +0000
Message-Id: <20210617160223.160998-189-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b5efe1-93ef-4e46-65bb-08d931a9cde1
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260C92CE9256AAC8BF6DA12F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+BuCR/DwDaz6Tv0BwjkQzB5uoXFhVn8WjcLjnjKxYPRyi6ry6unniawcV9VqFDaIi0nHeF5Nf9eMkxZZA3h3vjmX0kOp+ovrDM2egWQjxhru01XEuE8Y6nOwwsv6QCZkkBOHM8I212fy6++9HabtdWsbLSg8VwprMv9z06ITY78QFjaYmTmitFkz6Jcl/Jmn1l2/A1a7dqfgMVcjHZNwVPfmYhhrad+jEsjw45Oi2Rj+fW9sjB1XmfAQ4BiFBUBti1UQfH8ZejFs6iDzjHNB6Yx1nU9MRNOMyGgQ5ve0vtgAllHVN7d5Cb8M/fL2XWiqgdHCJBQS2BlKvJKVQewwncpeXFeFy12ldz8nAfpmbzwTGKCyYvQGD+5k1+Lh0vwzTqpnf8Ux/P/bF8AiQmsXN7/MPBAmEWFzKHpLwwgzE2mPeSpncWub6ZIz8SQpPPCxJCvhdEocivYTbFpqaY4fvPvOCIfZXlCzrABUqcOmQ6yk6FG/wWtDsY+IesYA52wWl3kW0Jrd7W1A1KmgBSXahKSpuDNn6qg1LjtFKpS3hoinK3pdYNPMLp3WYQ4ZgYznLQQV4TlRo5GXTCRJWqDWHDHSqBGNBA62BGxsuGmnKSyfG4YwjCvvF2RfvcyX8yIpSE0x9iMYF4nam6qQjVBkLIRUMYSkFR6FMxbsWg8Ll6dFi4WucTM3ziosbuTkgPfoSpnIGt9dcWTGK5NDkTOeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(45080400002)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YWCoz/RgsqR0cbLbO++GkruD4H2dWdE2ZOH/P4LKs5qM79lyV7uLbFwniBFE?=
 =?us-ascii?Q?yY9RbXt6FPgaehAhj5Ero+a+kTZ7ZPDhMiuvnN00b40AQnHlSMOf0v3lL5eG?=
 =?us-ascii?Q?PZQITy2QaxpSpjco5P9jQSjzimWxf0zn7Z5SmPeuTcueob+agYHU2mLDrJJk?=
 =?us-ascii?Q?BsEjir8UmVloGiBvSr5YaeW9pe1hwIZO4t5lQ+YGAZ9QaAaLa/NKB665UnnW?=
 =?us-ascii?Q?iVNqWWuRRJ4LugDyQrDJJ6fqEDGkGfqu3/H8+UxxbCRsFc9qJeF7s0V0oOZa?=
 =?us-ascii?Q?xWkinUYzKIHyduLgNgmILas5YIO9XGeMFsQLY+OCdQAlTopw+bqYHrt/4TkG?=
 =?us-ascii?Q?WXkLT9wHJARuem5+7OqFVu2GUqh+T3WQg+xydhi9Kngmpg01XqlhY+6z7smF?=
 =?us-ascii?Q?Z83oFFI07k2U0lqX4O2hNZUXp0CnP5j5WgNfH60ku4uXrc1a7CpJACuTmoSG?=
 =?us-ascii?Q?d22x78h8Y8wbnyrFe5guB+uOqi6NNpFINuZLGtdbbZ6NsCQKUr7dNDspXleV?=
 =?us-ascii?Q?hzcQwRBpn2ahQQ0UfiLTCSfHMhInorWZE65AQYEThceAuyi2Epu3YNaS2iX7?=
 =?us-ascii?Q?LmTAG+E3kwRfMXzFYPsCuGjHSLm8CpbDNXnpF1ZvMWeCw7cF4zTBwvR6VDrr?=
 =?us-ascii?Q?wS/9RWnEdFfezZVcP8KCd/w8GsCAX39suplTGXJaWFyhue20s7rM36MtbG4M?=
 =?us-ascii?Q?zLq9WNRif2aLw2M0/6ZIuxTZ8nN0/5pPkKNpRyx/hilUDQzPYc8PP5dhG+ys?=
 =?us-ascii?Q?ZudyCjbXRUvUZG8bshZ6sEIs0IEkpfRfWeRBonTDvfLw5UuufPBcdwmSx3RU?=
 =?us-ascii?Q?TaiQxliP3wp4oR3v5XDKWKrxVuIs6Qz3qmE2d6GnVk8OO1F2IQZiNC+w5KQ0?=
 =?us-ascii?Q?kANjBmlnMTsp3A/fe4ZMesN2tu2i7ksu8nYdNKFVe7TEN9h9S0NI6RK9/PYv?=
 =?us-ascii?Q?xfOG8xnLBRzIun5XUsoDPL7vezlVR82aZ7QxM5ESEqyuEXPcTwknC2NW7pWd?=
 =?us-ascii?Q?qmFfDAKdwl+ZbLNJv5USsUMWDj232iHo1ruSH6XhOxAzDH0IoGmVl/6bgYWj?=
 =?us-ascii?Q?ob5XhogjQBQDb2TKjqtIO/3Yrn539SaKuEwphjHGB6yPE4AioZ3NSS0BCP6c?=
 =?us-ascii?Q?7b/wLO0GIJKAMI/kSDwdCKiXF3wwvJFENMy+x4su9IrFTQZkuuAX3ExlpusN?=
 =?us-ascii?Q?bKlZfQDqcwgvAHttZ3qd0mlEKwgDZznJiLIiBx11HEY0DtD4Ef1i2jONQ9WL?=
 =?us-ascii?Q?GVLa13GKWULghCQWTELsNj3C58+VclvxOpFKstVuSkNkKxyByall6A4pR6DV?=
 =?us-ascii?Q?+3UfUu1hquZ/KpVU3EnnJquK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5efe1-93ef-4e46-65bb-08d931a9cde1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:02.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjhyGTIR+TDnLnebLZSWLf48ri3gPDrKE4br2lCjPmRXGkOlqgICm2JJNUbq8hn5mR7o/X7WZZPaEhPdbklRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/temperature.c    | 858 ++++++++++++++++++
 1 file changed, 858 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.c

diff --git a/drivers/net/wireless/celeno/cl8k/temperature.c b/drivers/net/w=
ireless/celeno/cl8k/temperature.c
new file mode 100644
index 000000000000..1fde1acfe386
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/temperature.c
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/kthread.h>
+#include "temperature.h"
+#include "radio.h"
+#include "utils/math.h"
+#include "utils/utils.h"
+#include "calib.h"
+#include "chip.h"
+#include "e2p.h"
+#include "channel.h"
+#include "power.h"
+#include "fw/msg_tx.h"
+
+#define TEMP_PROTECT_STATE_STR(delta) \
+       ((delta) =3D=3D TEMP_PROTECT_OFF ? "DISABLE" : \
+       ((delta) =3D=3D TEMP_PROTECT_INTERNAL ? "INTERNAL" : \
+       ((delta) =3D=3D TEMP_PROTECT_EXTERNAL ? "EXTERNAL" : \
+       ((delta) =3D=3D TEMP_PROTECT_DIFF ? "DIFF" : "UNKNOWN"))))
+
+#define TEMP_DIFF_INVALID 0x7F
+
+#define TEMPERATURE_MIN 0
+#define TEMPERATURE_MAX 127
+
+#define DUTY_CYCLE_MAX  100
+#define DUTY_CYCLE_MIN  20
+#define DUTY_CYCLE_STEP 20
+
+static int cl_temperature_read_fw(struct cl_hw *cl_hw, enum cl_temp_mode d=
esired_temp_mode,
+                                 u16 *raw_bits)
+{
+       u8 retval =3D 0;
+       struct mm_anamon_read_cfm *cfm;
+
+       if (cl_msg_tx_anamon_read(cl_hw, ANAMON_MODE_TEMPERATURE, desired_t=
emp_mode, 0) !=3D 0) {
+               cl_dbg_err(cl_hw, "cl_msg_tx_anamon_read failed\n");
+               cl_msg_tx_free_cfm_params(cl_hw, MM_ANAMON_READ_CFM);
+               return -ENODATA;
+       }
+
+       cfm =3D (struct mm_anamon_read_cfm *)(cl_hw->msg_cfm_params[MM_ANAM=
ON_READ_CFM]);
+
+       if (!cfm)
+               return -ENOMSG;
+
+       retval =3D cfm->retval;
+       *raw_bits =3D ((le16_to_cpu(cfm->raw_bits_data_0) + le16_to_cpu(cfm=
->raw_bits_data_1)) / 2);
+       cl_msg_tx_free_cfm_params(cl_hw, MM_ANAMON_READ_CFM);
+
+       return retval ? 0 : -EILSEQ;
+}
+
+static u16 cl_adc_to_mv(u16 adc)
+{
+       return (adc * 1800) >> 12;
+}
+
+static s16 cl_raw_bits_to_temperature(u16 raw_bits, enum cl_temp_mode desi=
red_temp_mode)
+{
+       s16 adcmv =3D cl_adc_to_mv(raw_bits);
+
+       /* Calculation of external thermistor */
+       if (desired_temp_mode =3D=3D TEMP_MODE_EXTERNAL) {
+
+               /*
+                * External-temperature calculation:
+                * Ext_tmp =3D -169 * adcv ^ 3 + 342 * adcv ^ 2 - 316 * adc=
v + 139
+                *
+                * Ext_tmp =3D -169 * (adcmv / 1000) ^ 3 +
+                *           342 * (adcmv / 1000) ^ 2 -
+                *           316 * (adcmv / 1000) +
+                *           139
+                *
+                * Ext_tmp =3D (-169 * adcmv ^ 3 +
+                *            342000 * adcmv ^ 2 -
+                *            316000000 * adcmv +
+                *            139000000000) / 1000000000
+                */
+               return (s16)div_s64(-169UL * adcmv * adcmv * adcmv +
+                                   342000UL * adcmv * adcmv -
+                                   316000000UL * adcmv +
+                                   139000000000UL,
+                                   1000000000);
+       }
+
+       /* Calculation of internal thermistor - ADCmv * slope - 163 (slope=
=3D0.290) */
+       if (desired_temp_mode =3D=3D TEMP_MODE_INTERNAL)
+               return ((adcmv * 29) / 100) - 163;
+
+       return 0;
+}
+
+void cl_temperature_set_power_offset(struct cl_hw *cl_hw, s8 power_offset)
+{
+       s8 total_pwr_offset[MAX_ANTENNAS] =3D {0};
+       u8 chan_idx =3D cl_channel_to_index(cl_hw, cl_hw->channel);
+       int i =3D 0;
+
+       cl_hw->temp_comp_db.power_offset =3D power_offset;
+
+       if (chan_idx =3D=3D INVALID_CHAN_IDX)
+               goto out;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               total_pwr_offset[i] =3D
+                       (cl_hw->tx_pow_info[chan_idx][i].offset + POWER_OFF=
SET_RES * power_offset);
+
+out:
+       cl_msg_tx_set_ant_pwr_offset(cl_hw, total_pwr_offset);
+}
+
+static void cl_temperature_comp_tcv(struct cl_chip *chip, struct cl_hw *cl=
_hw, s16 temp_internal)
+{
+       struct cl_temp_comp_db *temp_comp_db =3D &cl_hw->temp_comp_db;
+       s8 new_power_offset =3D 0;
+
+       /* Accumulate temperature delta */
+       temp_comp_db->acc_temp_delta +=3D (temp_internal - temp_comp_db->ca=
lib_temperature);
+
+       /* Check if it is time to make a new decision */
+       if ((chip->temperature.comp_iterations % CL_TEMP_COMP_ITERATIONS) !=
=3D 0)
+               return;
+
+       /* Average the temperature delta over the last CL_TEMP_COMP_ITERATI=
ONS samples */
+       temp_comp_db->avg_temp_delta =3D DIV_ROUND_CLOSEST(temp_comp_db->ac=
c_temp_delta,
+                                                        CL_TEMP_COMP_ITERA=
TIONS);
+
+       /* Reset accumulated temp delta */
+       temp_comp_db->acc_temp_delta =3D 0;
+
+       new_power_offset =3D (s8)DIV_ROUND_CLOSEST(temp_comp_db->avg_temp_d=
elta *
+                                                cl_hw->conf->ce_temp_comp_=
slope, 100);
+
+       if (temp_comp_db->power_offset =3D=3D new_power_offset)
+               return;
+
+       cl_dbg_trace(cl_hw, "calib_temperature %d, avg_temp_delta %d, power=
_offset %d\n",
+                    temp_comp_db->calib_temperature,
+                    temp_comp_db->avg_temp_delta,
+                    new_power_offset);
+
+       cl_temperature_set_power_offset(cl_hw, new_power_offset);
+}
+
+static void cl_temperature_comp(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+       struct cl_temperature *temperature =3D &chip->temperature;
+       s16 temp_internal =3D 0;
+
+       if (!chip->conf->ce_temp_comp_en)
+               return;
+
+       temp_internal =3D cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL);
+       temperature->comp_iterations++;
+
+       cl_dbg_chip_trace(chip, "comp_iterations =3D %u, temp_internal =3D =
%d\n",
+                         (temperature->comp_iterations % CL_TEMP_COMP_ITER=
ATIONS), temp_internal);
+
+       if (cl_chip_is_tcv0_enabled(chip))
+               cl_temperature_comp_tcv(chip, chip->cl_hw_tcv0, temp_intern=
al);
+
+       if (cl_chip_is_tcv1_enabled(chip))
+               cl_temperature_comp_tcv(chip, chip->cl_hw_tcv1, temp_intern=
al);
+}
+
+static void cl_temperature_tx_duty_cycle(struct cl_chip *chip, u8 duty_cyc=
le)
+{
+       u16 periodic_tx_time_on =3D chip->conf->ce_temp_protect_tx_period_m=
s * duty_cycle / 100;
+       u16 periodic_tx_time_off =3D chip->conf->ce_temp_protect_tx_period_=
ms - periodic_tx_time_on;
+
+       if (cl_chip_is_tcv0_enabled(chip))
+               cl_msg_tx_start_periodic_tx_time(chip->cl_hw_tcv0,
+                                                periodic_tx_time_off, peri=
odic_tx_time_on);
+
+       if (cl_chip_is_tcv1_enabled(chip))
+               cl_msg_tx_start_periodic_tx_time(chip->cl_hw_tcv1,
+                                                periodic_tx_time_off, peri=
odic_tx_time_on);
+}
+
+static void cl_temperature_protect_radio_off(struct cl_chip *chip, s16 tem=
p_avg)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       if (temp_protect_db->force_radio_off)
+               return;
+
+       cl_radio_off_chip(chip);
+       temp_protect_db->force_radio_off =3D true;
+       cl_dbg_chip_verbose(chip, "temperature [%d] >=3D radio off threshol=
d [%d] --> radio off!\n",
+                           temp_avg, conf->ce_temp_protect_radio_off_th);
+}
+
+static void cl_temperature_protect_radio_on(struct cl_chip *chip, s16 temp=
_avg)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       struct cl_chip_conf *conf =3D chip->conf;
+       s16 temp_thr =3D conf->ce_temp_protect_radio_off_th - CL_TEMP_PROTE=
CT_RADIO_OFF_HYST;
+
+       if (temp_avg >=3D temp_thr)
+               return;
+
+       cl_radio_on_chip(chip);
+       temp_protect_db->force_radio_off =3D false;
+       cl_dbg_chip_verbose(chip, "temperature [%d] < radio off threshold -=
 hysteresis [%d] "
+                                 "--> radio on!\n",
+                           temp_avg, temp_thr);
+}
+
+static void cl_temperature_protect_dec_duty_cycle(struct cl_chip *chip, s1=
6 temp_avg)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       if (temp_protect_db->duty_cycle =3D=3D DUTY_CYCLE_MIN)
+               return;
+
+       temp_protect_db->duty_cycle -=3D DUTY_CYCLE_STEP;
+       cl_temperature_tx_duty_cycle(chip, temp_protect_db->duty_cycle);
+       cl_dbg_chip_warn(chip,
+                        "temperature [%d] > protect_th_max [%d] --> decrea=
se duty cycle [%u]!\n",
+                        temp_avg, conf->ce_temp_protect_th_max, temp_prote=
ct_db->duty_cycle);
+}
+
+static void cl_temperature_protect_inc_duty_cycle(struct cl_chip *chip, s1=
6 temp_avg)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       if (temp_protect_db->duty_cycle =3D=3D DUTY_CYCLE_MAX)
+               return;
+
+       temp_protect_db->duty_cycle +=3D DUTY_CYCLE_STEP;
+       cl_temperature_tx_duty_cycle(chip, temp_protect_db->duty_cycle);
+       cl_dbg_chip_warn(chip,
+                        "temperature [%d] < protect_th_min [%d] --> increa=
se duty cycle [%u]!\n",
+                        temp_avg, conf->ce_temp_protect_th_min, temp_prote=
ct_db->duty_cycle);
+}
+
+static void cl_temperature_protect_decision(struct cl_chip *chip, s16 temp=
_avg)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       /* Test mode - force test_mode_duty_cycle */
+       if (unlikely(temp_protect_db->test_mode_duty_cycle !=3D DUTY_CYCLE_=
MAX)) {
+               cl_temperature_tx_duty_cycle(chip, temp_protect_db->test_mo=
de_duty_cycle);
+               return;
+       }
+
+       /* Temperature protection logic:
+        *
+        * If the temperature is greater or equal to the radio off threshol=
d
+        * then set the radio off.
+        * If the temperature is below the (radio off threshold - hysteresi=
s [10])
+        * then set the radio on again.
+        *
+        * Any time the temperature is greater than the max threshold then =
we
+        * decrease the duty cycle.
+        * Any time the temperature is below the min threshold then we incr=
ease
+        * the duty cycle.
+        */
+       if (temp_avg >=3D conf->ce_temp_protect_radio_off_th) {
+               cl_temperature_protect_radio_off(chip, temp_avg);
+               return;
+       }
+
+       if (temp_protect_db->force_radio_off) {
+               cl_temperature_protect_radio_on(chip, temp_avg);
+               return;
+       }
+
+       if (temp_avg > conf->ce_temp_protect_th_max) {
+               cl_temperature_protect_dec_duty_cycle(chip, temp_avg);
+               return;
+       }
+
+       if (temp_avg < chip->conf->ce_temp_protect_th_min) {
+               cl_temperature_protect_inc_duty_cycle(chip, temp_avg);
+               return;
+       }
+}
+
+static s16 cl_temperature_avg_protect(struct cl_temp_protect_db *temp_prot=
ect_db)
+{
+       /* Calculate average of last_samples */
+       u8 i;
+       s32 temp_avg =3D 0;
+
+       for (i =3D 0; i < CL_TEMP_PROTECT_NUM_SAMPLES; i++)
+               temp_avg +=3D temp_protect_db->last_samples[i];
+
+       return (s16)(temp_avg / CL_TEMP_PROTECT_NUM_SAMPLES);
+}
+
+static void cl_temperature_protect_handle_read(struct cl_chip *chip, s16 t=
emp)
+{
+       struct cl_temp_protect_db *temp_protect_db =3D &chip->temperature.p=
rotect_db;
+       unsigned long curr_time =3D jiffies_to_msecs(jiffies);
+       unsigned long delta_time =3D CL_TIME_DIFF(curr_time, temp_protect_d=
b->last_timestamp);
+
+       /* Add current read */
+       temp_protect_db->last_samples[temp_protect_db->curr_idx] =3D temp;
+       temp_protect_db->curr_idx =3D (temp_protect_db->curr_idx + 1) % CL_=
TEMP_PROTECT_NUM_SAMPLES;
+
+       if (delta_time >=3D CL_TEMP_PROTECT_INTERVAL_MS) {
+               s16 temp_avg =3D cl_temperature_avg_protect(temp_protect_db=
);
+
+               cl_dbg_chip_trace(chip, "temp_avg =3D %d, delta_time =3D %l=
u\n", temp_avg, delta_time);
+               cl_temperature_protect_decision(chip, temp_avg);
+               temp_protect_db->last_timestamp =3D curr_time;
+       }
+}
+
+static void cl_temperature_protect(struct cl_chip *chip, struct cl_hw *cl_=
hw)
+{
+       s16 protect_temp =3D 0;
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       switch (conf->ce_temp_protect_en) {
+       case TEMP_PROTECT_OFF:
+               return;
+       case TEMP_PROTECT_INTERNAL:
+               protect_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTER=
NAL) +
+                       conf->ce_temp_protect_delta;
+               break;
+       case TEMP_PROTECT_EXTERNAL:
+               protect_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_EXTER=
NAL) +
+                       conf->ce_temp_protect_delta;
+               break;
+       case TEMP_PROTECT_DIFF:
+               protect_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTER=
NAL) -
+                       chip->temperature.diff_internal_external + conf->ce=
_temp_protect_delta;
+               break;
+       }
+
+       cl_temperature_protect_handle_read(chip, protect_temp);
+}
+
+static int cl_temperature_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "temp usage:\n"
+                "Temperature compensation:\n"
+                "-a : Print the temperature compensation configuration\n"
+                "-b : Set temperature compensation on/off [0:Dis,1:En]\n"
+                "-c : Set temperature compensation slope "
+                       "[3 digit number without a point] "
+                       "example: '109'=3D>1.09, '76'=3D>0.76\n"
+                "Temperature protect:\n"
+                "-k : Print temperature protection configuration\n"
+                "-l : Print temperature protect current status\n"
+                "-m : Set test mode [0 - 100, 100 =3D disable]\n"
+                "Temperature general:\n"
+                "-u : Update temperature diff\n"
+                "-v : Read temperature [0:internal, 1:external, "
+                       "2:internal+delta, 3=3Dexternal+delta, "
+                       "4=3Dinternal-diff+delta]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_temperature_protect_print_config(struct cl_hw *cl_hw)
+{
+       struct cl_chip_conf *conf =3D cl_hw->chip->conf;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Temperature protect configuration:\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_en           : %s\n",
+                   TEMP_PROTECT_STATE_STR(conf->ce_temp_protect_en));
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_delta        : %3d [Celsius]\n",
+                   conf->ce_temp_protect_delta);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_th_max       : %3d [Celsius]\n",
+                   conf->ce_temp_protect_th_max);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_th_min       : %3d [Celsius]\n",
+                   conf->ce_temp_protect_th_min);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_radio_off_th : %3d [Celsius]\n",
+                   conf->ce_temp_protect_radio_off_th);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "ce_temp_protect_tx_period_ms : %5u [ms]\n",
+                   conf->ce_temp_protect_tx_period_ms);
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_temperature_protect_print_status(struct cl_hw *cl_hw)
+{
+       struct cl_temp_protect_db *protect_db =3D
+                                       &cl_hw->chip->temperature.protect_d=
b;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Temperature protect status:\n"
+                   "Force radio off      =3D %u\n",
+                   protect_db->force_radio_off);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Duty cycle           =3D %u\n",
+                   protect_db->duty_cycle);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Test mode duty cycle =3D %u\n",
+                   protect_db->test_mode_duty_cycle);
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_temperature_protect_test_mode_set(struct cl_chip *chip, u8 =
duty_cycle)
+{
+       chip->temperature.protect_db.test_mode_duty_cycle =3D duty_cycle;
+
+       if (duty_cycle =3D=3D DUTY_CYCLE_MAX)
+               pr_debug("Disable temp protection test mode\n");
+       else
+               pr_debug("Enable temp protection test mode [%u]\n", duty_cy=
cle);
+}
+
+static void cl_temperature_comp_comp_slope_set(struct cl_hw *cl_hw, s8 slo=
pe)
+{
+       cl_hw->conf->ce_temp_comp_slope =3D slope;
+
+       pr_debug("Temperature compensation slope: %d.%02d\n", slope / 100, =
slope % 100);
+}
+
+static int cl_e2p_read_temp_diff(struct cl_chip *chip, s8 *temp_diff)
+{
+       /* Read temp_diff from eeprom */
+       return cl_e2p_read(chip, temp_diff, SIZE_GEN_TEMP_DIFF, ADDR_GEN_TE=
MP_DIFF);
+}
+
+static int cl_e2p_write_temp_diff(struct cl_chip *chip, s8 temp_diff)
+{
+       /* Writing temp_diff to eeprom */
+       return cl_e2p_write(chip, (u8 *)&temp_diff, SIZE_GEN_TEMP_DIFF, ADD=
R_GEN_TEMP_DIFF);
+}
+
+static int cl_temperature_diff_update(struct cl_hw *cl_hw)
+{
+       s8 temp_diff =3D cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL) -
+               cl_temperature_read(cl_hw, TEMP_MODE_EXTERNAL);
+
+       if (cl_e2p_write_temp_diff(cl_hw->chip, temp_diff)) {
+               cl_dbg_err(cl_hw, "Error occurred while writing temperature=
 diff to EEPROM.\n");
+               return -1;
+       }
+
+       cl_hw->chip->temperature.diff_internal_external =3D temp_diff;
+       return 0;
+}
+
+static void cl_temperature_comp_enable(struct cl_chip *chip, s32 enable)
+{
+       if (enable) {
+               cl_dbg_chip_verbose(chip, "enable\n");
+               chip->conf->ce_temp_comp_en =3D true;
+       } else {
+               cl_dbg_chip_verbose(chip, "disable\n");
+               chip->conf->ce_temp_comp_en =3D false;
+
+               if (cl_chip_is_tcv0_enabled(chip))
+                       cl_temperature_set_power_offset(chip->cl_hw_tcv0, 0=
);
+
+               if (cl_chip_is_tcv1_enabled(chip))
+                       cl_temperature_set_power_offset(chip->cl_hw_tcv1, 0=
);
+       }
+}
+
+static int cl_temperature_kthread(void *arg)
+{
+       struct cl_chip *chip =3D (struct cl_chip *)arg;
+       struct cl_hw *cl_hw =3D NULL;
+       unsigned long timeout =3D msecs_to_jiffies(CL_TEMPERATURE_TIMER_INT=
ERVAL_MS);
+
+       while (true) {
+               cl_hw =3D cl_chip_is_tcv0_enabled(chip) ? chip->cl_hw_tcv0 =
: chip->cl_hw_tcv1;
+
+               if (cl_hw &&
+                   !chip->conf->ce_production_mode &&
+                   test_bit(CL_DEV_STARTED, &cl_hw->drv_flags)) {
+                       cl_temperature_comp(chip, cl_hw);
+                       cl_temperature_protect(chip, cl_hw);
+               }
+
+               if (wait_event_timeout(chip->temperature.wait_q, kthread_sh=
ould_stop(), timeout)) {
+                       cl_dbg_chip_trace(chip, "exit temperature kthread\n=
");
+                       return 0;
+               }
+       }
+}
+
+static void cl_temperature_recovery_protect(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (chip->conf->ce_temp_protect_en !=3D TEMP_PROTECT_OFF) {
+               u8 duty_cycle =3D chip->temperature.protect_db.duty_cycle;
+
+               if (duty_cycle < DUTY_CYCLE_MAX) {
+                       u16 periodic_tx_time_on =3D
+                               chip->conf->ce_temp_protect_tx_period_ms * =
duty_cycle / 100;
+                       u16 periodic_tx_time_off =3D
+                               chip->conf->ce_temp_protect_tx_period_ms - =
periodic_tx_time_on;
+
+                       cl_msg_tx_start_periodic_tx_time(cl_hw, periodic_tx=
_time_off,
+                                                        periodic_tx_time_o=
n);
+               }
+       }
+}
+
+static void cl_temperature_recovery_comp(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       s8 power_offset =3D cl_hw->temp_comp_db.power_offset;
+
+       if (!chip->conf->ce_temp_comp_en)
+               return;
+
+       if (power_offset)
+               cl_temperature_set_power_offset(cl_hw, power_offset);
+}
+
+void cl_temperature_init(struct cl_chip *chip)
+{
+       struct cl_temperature *temperature =3D &chip->temperature;
+       struct cl_temp_protect_db *temp_protect_db =3D &temperature->protec=
t_db;
+       unsigned long curr_time_ms =3D jiffies_to_msecs(jiffies);
+
+       temperature->kthread =3D kthread_run(cl_temperature_kthread,
+                                          chip,
+                                          "cl_temperature_kthread_%u",
+                                          chip->idx);
+       if (IS_ERR(temperature->kthread)) {
+               cl_dbg_chip_err(chip, "Failed to create temperature kthread=
\n");
+               temperature->kthread =3D NULL;
+       }
+
+       init_waitqueue_head(&temperature->wait_q);
+
+       mutex_init(&temperature->mutex);
+       temperature->internal_last =3D UNCALIBRATED_TEMPERATURE;
+       temperature->internal_read_timestamp =3D curr_time_ms;
+       temperature->external_last =3D UNCALIBRATED_TEMPERATURE;
+       temperature->external_read_timestamp =3D curr_time_ms;
+
+       /* Temp_protect_db init */
+       temp_protect_db->duty_cycle =3D DUTY_CYCLE_MAX;
+       temp_protect_db->test_mode_duty_cycle =3D DUTY_CYCLE_MAX;
+       temp_protect_db->last_timestamp =3D curr_time_ms;
+}
+
+void cl_temperature_close(struct cl_chip *chip)
+{
+       struct cl_temperature *temperature =3D &chip->temperature;
+
+       if (temperature->kthread) {
+               cl_dbg_chip_trace(chip, "stopping temperature kthread\n");
+               if (kthread_stop(temperature->kthread) !=3D -EINTR)
+                       wake_up(&temperature->wait_q);
+
+               temperature->kthread =3D NULL;
+       }
+}
+
+s16 cl_temperature_get_internal(struct cl_hw *cl_hw)
+{
+       return cl_hw->chip->temperature.internal_last;
+}
+
+s8 cl_temperature_read(struct cl_hw *cl_hw, enum cl_temp_mode mode)
+{
+       u16 raw_bits =3D 0;
+       s16 temp_val =3D 0;
+       unsigned long curr_time =3D jiffies_to_msecs(jiffies);
+       unsigned long diff_time =3D 0;
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_temperature *temperature =3D &chip->temperature;
+
+       mutex_lock(&temperature->mutex);
+
+       switch (mode) {
+       case TEMP_MODE_INTERNAL:
+               diff_time =3D CL_TIME_DIFF(curr_time, temperature->internal=
_read_timestamp);
+               if (diff_time <=3D CL_TEMPERATURE_UPDATE_INTERVAL_MS) {
+                       temp_val =3D temperature->internal_last;
+                       cl_dbg_chip_trace(chip, "Return last internal tempe=
rature %d\n", temp_val);
+                       goto read_out;
+               }
+               break;
+       case TEMP_MODE_EXTERNAL:
+               diff_time =3D CL_TIME_DIFF(curr_time, temperature->external=
_read_timestamp);
+               if (diff_time <=3D CL_TEMPERATURE_UPDATE_INTERVAL_MS) {
+                       temp_val =3D temperature->external_last;
+                       cl_dbg_chip_trace(chip, "Return last external tempe=
rature %d\n", temp_val);
+                       goto read_out;
+               }
+               break;
+       default:
+               cl_dbg_chip_err(chip, "Invalid temperature mode %d\n", mode=
);
+               goto read_err;
+       }
+
+       if (cl_temperature_read_fw(cl_hw, mode, &raw_bits)) {
+               cl_dbg_chip_err(chip, "Temperature read failed\n");
+               goto read_err;
+       }
+
+       temp_val =3D cl_raw_bits_to_temperature(raw_bits, mode);
+
+       if (temp_val > TEMPERATURE_MAX || temp_val < TEMPERATURE_MIN) {
+               cl_dbg_chip_err(chip, "Invalid temperature value %d\n", tem=
p_val);
+               goto read_err;
+       }
+
+       /* Update temperature read db */
+       if (mode =3D=3D TEMP_MODE_INTERNAL) {
+               temperature->internal_last =3D temp_val;
+               temperature->internal_read_timestamp =3D jiffies_to_msecs(j=
iffies);
+               cl_dbg_chip_trace(chip, "Read and save internal temperature=
 %d\n", temp_val);
+       } else {
+               temperature->external_last =3D temp_val;
+               temperature->external_read_timestamp =3D jiffies_to_msecs(j=
iffies);
+               cl_dbg_chip_trace(chip, "Read and save external temperature=
 %d\n", temp_val);
+       }
+
+read_out:
+       mutex_unlock(&temperature->mutex);
+       return temp_val;
+
+read_err:
+       /* If temperature read failed return the last valid value */
+       mutex_unlock(&temperature->mutex);
+
+       return (mode =3D=3D TEMP_MODE_INTERNAL) ?
+               temperature->internal_last : temperature->external_last;
+}
+
+static int cl_temperature_comp_print_config(struct cl_hw *cl_hw)
+{
+       struct cl_temp_comp_db *temp_comp_db =3D &cl_hw->temp_comp_db;
+       s8 temp_comp_slope =3D cl_hw->conf->ce_temp_comp_slope;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Internal temperature: %d\n",
+                   cl_hw->chip->temperature.internal_last);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Calib temperature:    %d\n",
+                   temp_comp_db->calib_temperature);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Delta temperature:    %d\n",
+                   temp_comp_db->avg_temp_delta);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Slope:                %d.%02d\n\n",
+                   temp_comp_slope / 100, temp_comp_slope % 100);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Power offset:         %d\n",
+                   temp_comp_db->power_offset);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_temperature_ret(struct cl_hw *cl_hw, u8 param)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       s8 curr_temp =3D 0;
+       char reply_str[5] =3D {0};
+       u16 reply_strlen =3D 0;
+
+       switch (param) {
+       case 0: /* Internal temp only */
+               curr_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL=
);
+               cl_dbg_chip_trace(chip, "%d\n", curr_temp);
+               break;
+       case 1: /* External temp only */
+               curr_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_EXTERNAL=
);
+               cl_dbg_chip_trace(chip, "%d\n", curr_temp);
+               break;
+       case 2: /* Internal temp + delta */
+               curr_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL=
) +
+                       chip->conf->ce_temp_protect_delta;
+               cl_dbg_chip_trace(chip, "Internal + Delta =3D %d\n", curr_t=
emp);
+               break;
+       case 3: /* External temp + delta */
+               curr_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_EXTERNAL=
) +
+                       chip->conf->ce_temp_protect_delta;
+               cl_dbg_chip_trace(chip, "External + Delta =3D %d\n", curr_t=
emp);
+               break;
+       case 4: /* Internal temp - temp_diff + delta */
+               curr_temp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL=
) -
+                       chip->temperature.diff_internal_external +
+                       chip->conf->ce_temp_protect_delta;
+               cl_dbg_chip_trace(chip, "Actual temperature: Internal - Dif=
f + Delta =3D %d\n",
+                                 curr_temp);
+               break;
+       default:
+               cl_dbg_chip_err(chip, "Invalid argument! must be between 0 =
and 4.\n");
+               return 0;
+       }
+
+       reply_strlen =3D snprintf(&reply_str[0], sizeof(reply_str), "%d", c=
urr_temp);
+       return cl_vendor_reply(cl_hw, reply_str, reply_strlen);
+}
+
+int cl_temperature_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       s32 *params =3D cli_params->params;
+
+       switch (cli_params->option) {
+               /* Temperature compenation */
+       case 'a':
+               if (cli_params->num_params !=3D 0)
+                       goto err_num_params;
+
+               return cl_temperature_comp_print_config(cl_hw);
+       case 'b':
+               if (cli_params->num_params !=3D 1)
+                       goto err_num_params;
+
+               cl_temperature_comp_enable(cl_hw->chip, params[0]);
+               break;
+       case 'c':
+               if (cli_params->num_params !=3D 1)
+                       goto err_num_params;
+
+               cl_temperature_comp_comp_slope_set(cl_hw, params[0]);
+               break;
+               /* Temperature protect */
+       case 'k':
+               return cl_temperature_protect_print_config(cl_hw);
+       case 'l':
+               return cl_temperature_protect_print_status(cl_hw);
+       case 'm':
+               if (cli_params->num_params !=3D 1)
+                       goto err_num_params;
+
+               cl_temperature_protect_test_mode_set(cl_hw->chip, params[0]=
);
+               break;
+               /* Temperature general */
+       case 'u':
+               if (cl_temperature_diff_update(cl_hw))
+                       return -1;
+               break;
+       case 'v':
+               if (cli_params->num_params !=3D 1)
+                       goto err_num_params;
+               cl_temperature_ret(cl_hw, params[0]);
+               break;
+               /* Help */
+       case '?':
+               return cl_temperature_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               break;
+       }
+
+       return 0;
+
+err_num_params:
+       cl_dbg_err(cl_hw, "Wrong number of arguments\n");
+       return 0;
+}
+
+void cl_temperature_recovery(struct cl_hw *cl_hw)
+{
+       cl_temperature_recovery_protect(cl_hw);
+       cl_temperature_recovery_comp(cl_hw);
+}
+
+bool cl_temperature_protect_did_reduce_duty_cycle(struct cl_hw *cl_hw)
+{
+       return cl_hw->chip->temperature.protect_db.duty_cycle < DUTY_CYCLE_=
MAX;
+}
+
+int cl_temperature_diff_e2p_read(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_temperature *temperature =3D &chip->temperature;
+
+       if (cl_e2p_read_temp_diff(chip, &temperature->diff_internal_externa=
l) ||
+           temperature->diff_internal_external =3D=3D TEMP_DIFF_INVALID) {
+               if (cl_temperature_diff_update(cl_hw))
+                       return -1;
+
+               cl_dbg_chip_verbose(chip, "Temperature difference: Internal=
 - External =3D %d\n",
+                                   temperature->diff_internal_external);
+       }
+
+       return 0;
+}
+
+s16 cl_temperature_calib_calc(struct cl_hw *cl_hw, u16 raw_bits)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       s16 temperature =3D cl_raw_bits_to_temperature(raw_bits, TEMP_MODE_=
INTERNAL) +
+               chip->conf->ce_temp_protect_delta;
+
+       if (temperature >=3D TEMPERATURE_MIN && temperature <=3D TEMPERATUR=
E_MAX)
+               return temperature;
+
+       cl_dbg_chip_err(chip, "Invalid temperature =3D %d\n", temperature);
+
+       return (chip->temperature.internal_last + chip->conf->ce_temp_prote=
ct_delta);
+}
+
+void cl_temperature_comp_update_calib(struct cl_hw *cl_hw)
+{
+       u8 chan_idx =3D cl_channel_to_index(cl_hw, cl_hw->channel);
+       u8 ant;
+       s16 total_temp =3D 0;
+       struct cl_tx_power_info *info =3D NULL;
+
+       if (unlikely(chan_idx =3D=3D INVALID_CHAN_IDX)) {
+               cl_dbg_err(cl_hw, "Unsupported frequency %u\n", cl_hw->cent=
er_freq);
+               return;
+       }
+
+       info =3D &cl_hw->tx_pow_info[chan_idx][0];
+
+       /* Sum up the temperature of all phys */
+       for (ant =3D 0; ant < cl_hw->num_antennas; ant++)
+               total_temp +=3D info[ant].temperature;
+
+       /* Average the total temperature and update chan_params */
+       cl_hw->temp_comp_db.calib_temperature =3D DIV_ROUND_CLOSEST(total_t=
emp, cl_hw->num_antennas);
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

