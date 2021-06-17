Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD33AB894
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhFQQJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:03 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:25895
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233621AbhFQQID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkuKe6vl0wjc0330TZEiF+vk/cuPcKRI6FAvpEFdCXoVLl5Rl7tE3FbY1nfNrWWuZ+oxObpW5cllaBDjNyvoV9i03Bh0upNpnHyuqh+5bQOyFtWHoaSt9eybzDrfUmOg/R0PPqR+OMJqYJWe4AhpV6V/g94ovEVAFhcXfxPBSKQXygEk/9Pxcouj9bcYZcyr6xbifWGLWJY3pQ50i0JzQ2JR6lavFBN5ekf2dEPufU7+Imf8YIyW6WouEpAotNjdsTGqcuAtni7FynEPprkQxCV/29L3l5raPJjbO14vhNoW32rMBhCuKDYT0cTSWVO4t6pT6y+UgwVC7GpYHXWrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq9zXmb7IoTdl+nt3+IMpbclxIPbURWjYzwgYbuoX7U=;
 b=LU4P5Vg7Ko8AS4K7m4YRZ9ZUkME13ebO9kQTMFdqe7y1gZ6cPYYLwdmb2W0ZmpEa2QAUf9H50B1bSerBU0wR7JgR1285SElVO77jvSG1ge4bHrWVfbddn66Q9v7rH8ANFrlI2ZHKD92n6laXyYc44+tWYI1KD13HBA+szNDD63Vc/O84NmZ/gIw2LqxTehospRr/Un0ySiJvDzrz7Akf1WpdS84XVCghfp6FD2JKNbw9t/LIrd5gvEcsD2frPnkjSMnucMwpqp1IbgNgodI67eraaRvvcgxlJCP09qHAvvTJ08umn6orB8WFgTLBDa7oTAjcJ5+K0DNPQyuPYBPj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq9zXmb7IoTdl+nt3+IMpbclxIPbURWjYzwgYbuoX7U=;
 b=scEkPbYg2eQ/ucCW92DbDqiD6A4N3D9U4yDmfNoIAKaUsmU/a5mlgw0G58+dM91IMnXOz/hkjPUvvwSVfjh5AjARKK0griSGvPfrUdLsz3cVVdMWExuD4+4lmR6BZ0YgZIdEMqWPd15rwFmPeTE+4CaupNJao/nKTuHuYA62yw0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:46 +0000
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
Subject: [RFC v1 129/256] cl8k: add phy/phy_common_lut.c
Date:   Thu, 17 Jun 2021 16:00:16 +0000
Message-Id: <20210617160223.160998-130-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5a40ef-a878-4d7d-2479-08d931a9a669
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059DB5E50911C7845A70D3BF60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vq9wxatBD/N3vH4F3OnoFMfalPTCCrdRKyWJo5TmBS5nl2BecC1ihBWlBqxPP2pvGh+l7vwrSW64qrxPJzIHPWm5ivmv1FB++vI+3at21pO7pN8/kXqJVL9rvgPBynVaQTY4iKtYNdXKBEGXipDHv0ZQFiSICg5z+5ref0xLDshxYpOPsdrfUI/X5adC2qT3P8XvksMZGYgfWDU4azlernSnNL6GUXjXBnJdKEBUjcsYlCG2JPFGBjJywzmBCWR6Z5oxSjfUP6tsvkLITJ3Ix5hkzhytUCSm0YB/O7iSsWFt2B0dADY8+PFHVJyXC3/Adv3kNGk9ePHFEdbd2yHlnvUwjs/0u0jynPwNEo/i48kHcaFSXLBIyDn0Rjpb5asgDLnG+LoRwqkwoyVmyVs3X2LggLXJzbSXoMprjiiyGqrP7AauOdalJeaduHaaU1Yc/6DDhAvCZFokqdLdv2rCoaDQCmMS349eoK5Ub0u7tMHHbowuER+T/59npG0gSvTeHDO5pSuT07fhqY5PlP1zQIBVoQbAY7G9O8Hm94OkmqGJgrbGlhIHWejqU9o7nH4/W/4KSn9SCC4KZwmRwSxGz2zvU9XV5SSEAtwOeihBcPSQBB4ZZo2YzADKvR/veccMddjnefKx0cStAHalc/8+47wXU1dg388N0w+AP/owAHLvsmDaGlNMU3Q1Z1KZEVbdG7VT8xi90O8hpRs18KQrSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q60bTg4SFSwnFWx9nRpjKij6c4kxtT7XBx+GwscBzvBYL/UY/rVl9o9mwamY?=
 =?us-ascii?Q?fEmCyXFxFYl/pu4iKhU36OyDE1mEnv/JBDikDX5/0McXHkEuEif3v3miiwD/?=
 =?us-ascii?Q?Gttyg/fb+8jtAHBjGUkd4mnzKY9eFhgI0bduwASJeJTFdgwwvhWPBETrb+mr?=
 =?us-ascii?Q?jwrNhBmfk1Tfkpup1zZIUVMxOmaOutS10yWfb9VQg1waqtPGg9H+9h6FJhO9?=
 =?us-ascii?Q?Be04qf/D64VlBqRfnpITLJ6japnWGvCe6/fva0us/clyX35f7NGR3S6rqqY+?=
 =?us-ascii?Q?Ki09ueLVF1Mtu+iw8GQaknuDVU/MtTtAgGp5yHbfTa2YoAb3E7EuPsrU1y58?=
 =?us-ascii?Q?1ZrFwygXhctYfnJx02s33XgiMixxeSvFA6+2GuAPsyEm0nHdADhKgm9gGeSL?=
 =?us-ascii?Q?wlxnXix2+l26L32i7yHRPIKp2qQvVfsRXqlj63qlNzIvq5GIo/NkxnG5fcEA?=
 =?us-ascii?Q?i1PrH2tCKHtRpzukpZW1QVBCJ0ItVjMrLfbqX8OVB2OOTTP+h7sN9IpoEoOo?=
 =?us-ascii?Q?Cc/S2JV/OoqzZgUtcQQETjGaxRQ4GA8MY1tkL1Y6fOugFx9bJkzS6A5vPkUI?=
 =?us-ascii?Q?fNHXVT1K49uaat3IKUfsJx01lmrJkBUjtXTH/nedtuLXr1enyRXk99KwICAF?=
 =?us-ascii?Q?MKBn6+O/GphYCO4Ker+oeQ22/K9QFRJh3/bApHS5ywR6VYmejMtdihxxbC2B?=
 =?us-ascii?Q?9/7Ewv9FDPdgFtSktu2IS7fhHBuQJOZVhQjoBLznJCJLvk4YX0gO2B1kcpOb?=
 =?us-ascii?Q?X0oXRaTKjy6ifLPsCyxtuLHeHYFcwoA85Ziz0g0pUKzAU/H5GWyA7ILQqsBT?=
 =?us-ascii?Q?VbEf49SFUSaDvOWRz8ScpxIOsNsqiNypo2AlFup4imQaTMMemj5ndhbClbOJ?=
 =?us-ascii?Q?dng27AaCkscs3x18Ufw4Rco8p3r6hxIHERGG2LXZoTxuY8LK0x9J/6EyiWQn?=
 =?us-ascii?Q?T8B0ygOVULWal5AJF0Bl31aeWR7xrZW5B4W73aQGs3a7Dzm9jUdRo3KR4arW?=
 =?us-ascii?Q?fAvymeMFmrfefmhMLGxNkybtdo1s+961QhIiaOkRXS3WhEb+7aEtZtOQlrc/?=
 =?us-ascii?Q?DHNTApPF+ldeIHizZMrOsvgV9MvbzY+OgcODBKBaSh7IjWp3PcO223e3SlMY?=
 =?us-ascii?Q?XCSeL5zx+MTzbo1s9bUA0351cFJGzscsFhPfuRtPiAEd0Pk8ZXQFgx/YP+Ku?=
 =?us-ascii?Q?ebPngUzow9D+nSx/JvIOwUQDqbsWh09bimZOkd6HGFj/v4bO56T9gdXDH0LW?=
 =?us-ascii?Q?ZSg4CuUShkSTP29g8bGDvvsN4mEFDpo33yAYv0Sz3oFBoPJ3vBnuJA4L/ZHF?=
 =?us-ascii?Q?gG6SplZtMP0lcFJeUEuJyLnK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a40ef-a878-4d7d-2479-08d931a9a669
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:56.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hT2HoKeT5EnEyalpCVGqPoFAEOaUUCpLPtTusSbYR6KRYWhiSMeuHWNb8putB8mJ2J9ugc6vXXLnhBYb2k3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/phy/phy_common_lut.c | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.c

diff --git a/drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.c b/driver=
s/net/wireless/celeno/cl8k/phy/phy_common_lut.c
new file mode 100644
index 000000000000..73a79f297718
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "phy_common_lut.h"
+#include "phy_athos_lut.h"
+#include "phy_olympus_lut.h"
+
+const struct common_lut_line *cl_phy_oly_get_lut_index(const struct common=
_lut_line *lut_table,
+                                                      const u16 lut_table_=
size, u16 freq)
+{
+       u16 frequency_idx;
+
+       /* Fine highest frequency in  lut table that is lower or equal freq=
 */
+       for (frequency_idx =3D 0;
+               frequency_idx < lut_table_size && lut_table[frequency_idx].=
frequency_q2 <=3D freq;
+               ++frequency_idx)
+               ;
+
+       if (frequency_idx)
+               frequency_idx--;
+
+       return &lut_table[frequency_idx];
+}
+
+void cl_phy_lut_2_lines_update(u16 freq,
+                              const struct common_lut_line *lut_table_60m,
+                              const u16 lut_table_60m_size,
+                              const struct common_lut_line *lut_table_40m,
+                              const u16 lut_table_40m_size,
+                              struct mm_mac_api_lut_line *api_lut_line)
+{
+       /* 1. configure the 40M xco lut table */
+       const struct common_lut_line *data_line =3D
+               cl_phy_oly_get_lut_index(lut_table_40m, lut_table_40m_size,=
 freq);
+
+       api_lut_line->rfic_specific.olympus_2_lines.xco_40M.freqmeastarg =
=3D
+               cpu_to_le32(data_line->freqmeastarg);
+       api_lut_line->rfic_specific.olympus_2_lines.xco_40M.nfrac =3D
+               cpu_to_le32(data_line->nfrac);
+       api_lut_line->rfic_specific.olympus_2_lines.xco_40M.nint =3D
+               data_line->nint;
+       api_lut_line->rfic_specific.olympus_2_lines.xco_40M.vcocalsel =3D
+               data_line->vcocalsel;
+
+       /* 2. configure the 60M xco lut table */
+       data_line =3D cl_phy_oly_get_lut_index(lut_table_60m, lut_table_60m=
_size, freq);
+       api_lut_line->rfic_specific.olympus_2_lines.xco_60M.freqmeastarg =
=3D
+               cpu_to_le32(data_line->freqmeastarg);
+       api_lut_line->rfic_specific.olympus_2_lines.xco_60M.nfrac =3D
+               cpu_to_le32(data_line->nfrac);
+       api_lut_line->rfic_specific.olympus_2_lines.xco_60M.nint =3D
+               data_line->nint;
+       api_lut_line->rfic_specific.olympus_2_lines.xco_60M.vcocalsel =3D
+               data_line->vcocalsel;
+
+       /* 3. set frequency */
+       api_lut_line->frequency_q2 =3D cpu_to_le16(freq);
+}
+
+void cl_phy_lut_3_lines_update(u16 freq,
+                              const struct common_lut_line *lut_table_60m_=
s1,
+                              const u16 lut_table_60m_s1_size,
+                              const struct common_lut_line *lut_table_60m_=
s0,
+                              const u16 lut_table_60m_s0_size,
+                              const struct common_lut_line *lut_table_40m,
+                              const u16 lut_table_40m_size,
+                              struct mm_mac_api_lut_line *api_lut_line)
+{
+       /* 1. configure the 40M xco lut table */
+       const struct common_lut_line *data_line =3D
+       cl_phy_oly_get_lut_index(lut_table_40m, lut_table_40m_size, freq);
+
+       api_lut_line->rfic_specific.olympus_3_lines.xco_40M.freqmeastarg =
=3D
+       cpu_to_le32(data_line->freqmeastarg);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_40M.nfrac =3D
+       cpu_to_le32(data_line->nfrac);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_40M.nint =3D
+       data_line->nint;
+       api_lut_line->rfic_specific.olympus_3_lines.xco_40M.vcocalsel =3D
+       data_line->vcocalsel;
+
+       /* 2. configure the 60M xco lut table , sxpfddesel=3D1*/
+       data_line =3D cl_phy_oly_get_lut_index(lut_table_60m_s1, lut_table_=
60m_s1_size, freq);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s1.freqmeastarg=
 =3D
+       cpu_to_le32(data_line->freqmeastarg);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s1.nfrac =3D
+       cpu_to_le32(data_line->nfrac);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s1.nint =3D
+       data_line->nint;
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s1.vcocalsel =
=3D
+       data_line->vcocalsel;
+
+       /* 3. configure the 60M xco lut table , sxpfddesel=3D0*/
+       data_line =3D cl_phy_oly_get_lut_index(lut_table_60m_s0, lut_table_=
60m_s0_size, freq);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s0.freqmeastarg=
 =3D
+       cpu_to_le32(data_line->freqmeastarg);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s0.nfrac =3D
+       cpu_to_le32(data_line->nfrac);
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s0.nint =3D
+       data_line->nint;
+       api_lut_line->rfic_specific.olympus_3_lines.xco_60M_s0.vcocalsel =
=3D
+       data_line->vcocalsel;
+
+       /* 4. set frequency */
+       api_lut_line->frequency_q2 =3D cpu_to_le16(freq);
+}
+
+void cl_phy_oly_lut_update(u8 nl_band, u16 freq,
+                          struct mm_mac_api_lut_line *api_lut_line)
+{
+       switch (nl_band) {
+       case NL80211_BAND_2GHZ:
+               cl_phy_lut_3_lines_update(freq,
+                                         olympus_lut_24g_60_mhz_s1,
+                                         OLYMPUS_LUT_CHAN_24G_MAX,
+                                         olympus_lut_24g_60_mhz_s0,
+                                         OLYMPUS_LUT_CHAN_24G_MAX,
+                                         olympus_lut_24g_40_mhz,
+                                         OLYMPUS_LUT_CHAN_24G_MAX,
+                                         api_lut_line);
+               break;
+       case NL80211_BAND_5GHZ:
+               cl_phy_lut_3_lines_update(freq,
+                                         olympus_lut_5g_60_mhz_s1,
+                                         OLYMPUS_LUT_CHAN_5G_MAX,
+                                         olympus_lut_5g_60_mhz_s0,
+                                         OLYMPUS_LUT_CHAN_5G_MAX,
+                                         olympus_lut_5g_40_mhz,
+                                         OLYMPUS_LUT_CHAN_5G_MAX,
+                                         api_lut_line);
+               break;
+       case NL80211_BAND_6GHZ:
+               cl_phy_lut_2_lines_update(freq,
+                                         athos_lut_6g_60_mhz, ATHOS_LUT_CH=
AN_6G_MAX,
+                                         athos_lut_6g_40_mhz, ATHOS_LUT_CH=
AN_6G_MAX,
+                                         api_lut_line);
+               break;
+       default:
+               /* If nl_band is not supported return zero's */
+               memset(api_lut_line, 0, sizeof(struct mm_mac_api_lut_line))=
;
+               api_lut_line->frequency_q2 =3D cpu_to_le16(freq);
+       }
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

