Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0D3AB897
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhFQQJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:07 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:64480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229887AbhFQQIE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqcV8oIHjUw2ZaWBOqlwZ3AMSjm27Wy4zYDs7yjEAl0vBZGXsxXR59ikZuJyNJCesZqOtSE+DGCZdIGFe5sK12Vq4pS5ESzKBWOkqMXGlDHNUB0oDsNrwS2kek18tyMNJW9yaOe74rSD07S3eVJOs8aFRNc7BCEb1pf16HipYKEISQmRSY96S9YhqI6XFFXDkDn/JZYpo9h+x3zawPtLeJ2qPQ8kisfsOHof0m27dAkPz64N2bASaFduvDgiSA6jz8NXSpDoJKBN5lFxwprwdHd5lsmExo5R4hOn5Hzm++hLFYw/DY7dzqHYUIFUO81wD7zT238x/cBwtYlGWcGhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7GxUjyVSKRB3T9Jz0l2e05mJwcScmezLW9VAr0NSTU=;
 b=FNoeXKn5PPlhJmdTLK4jh0Pqc1+L2wZeZOB0TmcK8juYNTRy+TGcZ0vicZunTTsEtpAGjsJzn0XIHb3c0TFRcbwKnkUp9+OWriTSoDoaa4O4mmAQVXIJRoOWGBhgpNvSt6oZ9sT91X6ogYa8+Ndm8GWJ+Fq+UIypU7y7qh/eVD6B9GFQ7ll3NHgNdS74xaVuftmvAf1GPxy674+iph8AoUqLMqZPQ+ZZwmtQgABS0gZUZt6qNLqcYpKVSQbg88deBuoA0FhZb7Ssklf3JqlblPRFYj9WINd17w14n+G7BezBbFl1mLLWAE4MbHsZRgL4HUjMUrd5vjLm7oti3u4QPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7GxUjyVSKRB3T9Jz0l2e05mJwcScmezLW9VAr0NSTU=;
 b=P5m6T2n4i9c3xcgsHXCk2JTsWdD1nJ24hJzkL6pB8LU6DW+zVbDbaL1c1Xjaeatth+J7kfgSgc7iZNe1iZJUUOReVbSdcQ0+UbRF8brgmyThiXW95g9db7kHfLLwJ5nrROKlmoyuXA+KyYNB3Um8j9xnmuTE0e1xHNwEF/oEpCo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:09 +0000
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
Subject: [RFC v1 113/256] cl8k: add mib.c
Date:   Thu, 17 Jun 2021 16:00:00 +0000
Message-Id: <20210617160223.160998-114-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7e0d40-0710-4e00-e848-08d931a99c00
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB040215C9E18C275B64AC0D14F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRWcXAf9uu9tlxPYpFttzHs9oSHFx0oM9PfmiKLAjJPzPT3I0FQ8fH+xubXhzRRfqeQYHgQ6P0o0B0fJv3U4/P2KNBSj59LBTgaJ/v6P+X6HL5AhxmpxiHnqNrTAHT/Lqu1I4a8oT5F3nKwhry58ZLFeFtDEsrE2JHCIY3PTE3SN/czdiEjgR6F03CEzjqD5pftOHVGqF9YUFrog9hI27ykri1QSLP0Oog0PBZz5+O8bQm7dx/TSL04fOUNYINwRe8nqV/2zLrqsmxGtzJQOQjSlFriUGPnZVy8KZfrdop8G1ekUKoJc2DaFUlxc6f8ARPePj57EYMOg86quoBpONnRztOOYPw1dTIVgEGTeJn4hqXcKOEvs/io29TGAAPzAFi653WuB5Y7NlzBkqnHdcFKCXjHt8cbeGXw1u69xfFH0TzKjBDazItGOk4NkmNdscxzWEmh/gXd2ysujoFiSQQ5b+9ADxiLHD+73ScDA0z0UIlTMyyFIxb4tzQoP/M7rQJy0vbHEKWZcOwfvf7p2BbeL9BNlG16ndpnPM/tJMAgTy3WXQ2m5ewntKU39HjNo3Q0UyhgzmOR8u/xGSuutpf/+qjvC1kjmAetWJKCONuC31HlhGymxcb/mYvXd7lHQX58kFjdf/kz2lxEZq8c1ZbhdFElyrFB1/LvERp8B5d7ziZidFpOgWBs8m+8GLPPbO0FwM9Np1JdMcfySsZ77bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(30864003)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6iEEqoM2bElpVMFc5lCW9PP/9pQFgZkERQtsZZBUzVOL71FRG2IaQKqYAeY?=
 =?us-ascii?Q?SDz+SaMcXeR9MNl295lFITIC8gCMZ4ufBhJNMAlE25GthEm4Dhv+LaPZ8Q8V?=
 =?us-ascii?Q?1OBi0bxctaS13iJNdLLxLlOUh3268C39tqOHTWmelXRO/dC4X8iAIpAfgj7I?=
 =?us-ascii?Q?bA3Pk0pEUxIMBFI4CstRIRGqb5ahNJLJRrVpHrtHdrV07rAjxbSuMNUAjNRP?=
 =?us-ascii?Q?nXv+HFKMPpe+aAtXb6XMcUIMomRtaC2XfZwSFSJgeQmzspNkIvIfhcWjwet0?=
 =?us-ascii?Q?Sf9TkfXQ549rbr0mEHObji9IICsGY/QP4ve14d6t8KM7evaMZJFU7KHrSdBF?=
 =?us-ascii?Q?OR0Zw1v4AYSk8l1b4GKJwEvY0QxRsNQAk79TgWiRpIc+bBtDUD2I4q9YvfCX?=
 =?us-ascii?Q?yDYpbXAHXYj7RLxyf5eKQTwwNLfhU5VG61FQJGCOjbuGVvFnDOhl2WEyVYMr?=
 =?us-ascii?Q?iaYsumFlSZcXaY78hjj3uZkqcGa80i4Q99nTdF2I+x+gK+8zN4eA074a0OlL?=
 =?us-ascii?Q?HMJRwCZqOLuZUCd7MYX1LRGX2XvNO0syp1YdcDP3Fne5dRYQ9EpG2A4LVGjj?=
 =?us-ascii?Q?/8qjFSwoAeJohT4tmSHV5C0L/z/xCaR729GdPQEY8J4i+i3OOPSq8gh+99gq?=
 =?us-ascii?Q?ZLE6zlZsbI+qSjpVM9X2b1RklrANK/mBt3IeJ5wRFaOoskvERe+xhsgn7KB6?=
 =?us-ascii?Q?7YVzTDpiDom5EssFIJ8IWY9TI4Dn/XnrGvoRbi7kjdSyugGJ2FzUoOnWIHc3?=
 =?us-ascii?Q?Kn7kQdhbDegDfO9o3Fx25mzFNa0YTw27+KwXc8ZXPFwpRf/uaz4GzLeqFyrp?=
 =?us-ascii?Q?Vf8uWrlG5k/RBIxOx5uK2OImN56APmEYO76SI+r6/xoUneL4QrUcKR/pFhSk?=
 =?us-ascii?Q?K8mP6ZLgnlppOKK5aLSaht7I1q5EJbc2vRs4zrj4zcvUytWleC6pQjCivl/l?=
 =?us-ascii?Q?vKPOnqdrOZq/Hnn6sUt0g3DbCdyq12MFz7VEw/mmS1g0MxOGUY2Rahe3HE/H?=
 =?us-ascii?Q?qcRqjAE3pU200D6f3phpBLePM70CzCPZ6EZjMQCCjgjj4u7OuGHcaeauRGGG?=
 =?us-ascii?Q?DybgVAsi911rMqK/ad4TKASG7xnKAJbqBbyZ80o79nhDQ/ndsU0p81e/gT5O?=
 =?us-ascii?Q?lcq6w8Y0XkeANWEpFam2nF8gsaAkp7XDcsCFcIrXNaFnkOovObczBZ3I64Gx?=
 =?us-ascii?Q?ToZUS1TePWOayzCRZ00JB+8mR21aO/P2sbSErtyXqYQhBW/VETvYrheixZAG?=
 =?us-ascii?Q?59RpZnNH370wzlwdxaNw4dQLx6Q3rU//4I/xfthO4F7GnC7aLDSFmP8/A6n0?=
 =?us-ascii?Q?6rNJB5FT6LkS5sPWfTVRkdN3?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e0d40-0710-4e00-e848-08d931a99c00
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:38.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIEiP9lhLCczHLtygNjx8Ma3wPddeUsmVUZpKclHNrxUBcLhx9f8Ydd4iWavSu6DO/vhcieN2yPkawLrNErgvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mib.c | 437 +++++++++++++++++++++++++
 1 file changed, 437 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mib.c

diff --git a/drivers/net/wireless/celeno/cl8k/mib.c b/drivers/net/wireless/=
celeno/cl8k/mib.c
new file mode 100644
index 000000000000..946043dddd5d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mib.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "mib.h"
+#include "reg/reg_access.h"
+
+#define NUM_OF_MIB_COUNTERS 254
+#define MIB_REG_OFFSET 0x800
+
+static void init_mib_counter_arr(char *mib_counter_names_arr[NUM_OF_MIB_CO=
UNTERS])
+{
+       /*
+        * MIB element to count the number of unencrypted frames that have =
been
+        * discarded
+        */
+       mib_counter_names_arr[0] =3D "dot11_wep_excluded_count";
+
+       /* MIB element to count the receive FCS errors */
+       mib_counter_names_arr[1] =3D "dot11_fcs_error_count";
+       /*
+        * MIB element to count the number of PHY Errors reported during a
+        * receive transaction.
+        */
+       mib_counter_names_arr[2] =3D "nx_rx_phy_error_count";
+       /*
+        * MIB element to count the number of times the receive FIFO has
+        * overflowed
+        */
+       mib_counter_names_arr[3] =3D "nx_rx_Discard_RHD";
+       /*
+        * MIB element to count the number of times underrun has occurred o=
n the
+        * transmit side
+        */
+       mib_counter_names_arr[4] =3D "nx_tx_underrun_count";
+
+       /* MIB element to count unicast transmitted MPDU */
+       mib_counter_names_arr[5] =3D "nx_qos_utransmitted_mpdu_count[0]";
+       mib_counter_names_arr[6] =3D "nx_qos_utransmitted_mpdu_count[1]";
+       mib_counter_names_arr[7] =3D "nx_qos_utransmitted_mpdu_count[2]";
+       mib_counter_names_arr[8] =3D "nx_qos_utransmitted_mpdu_count[3]";
+       mib_counter_names_arr[9] =3D "nx_qos_utransmitted_mpdu_count[4]";
+       mib_counter_names_arr[10] =3D "nx_qos_utransmitted_mpdu_count[5]";
+       mib_counter_names_arr[11] =3D "nx_qos_utransmitted_mpdu_count[6]";
+       mib_counter_names_arr[12] =3D "nx_qos_utransmitted_mpdu_count[7]";
+       /* MIB element to count group addressed transmitted MPDU */
+       mib_counter_names_arr[13] =3D "nx_qos_gtransmitted_mpdu_count[0]";
+       mib_counter_names_arr[14] =3D "nx_qos_gtransmitted_mpdu_count[1]";
+       mib_counter_names_arr[15] =3D "nx_qos_gtransmitted_mpdu_count[2]";
+       mib_counter_names_arr[16] =3D "nx_qos_gtransmitted_mpdu_count[3]";
+       mib_counter_names_arr[17] =3D "nx_qos_gtransmitted_mpdu_count[4]";
+       mib_counter_names_arr[18] =3D "nx_qos_gtransmitted_mpdu_count[5]";
+       mib_counter_names_arr[19] =3D "nx_qos_gtransmitted_mpdu_count[6]";
+       mib_counter_names_arr[20] =3D "nx_qos_gtransmitted_mpdu_count[7]";
+       /*
+        * MIB element to count the number of MSDUs or MMPDUs discarded
+        * because of retry-limit reached
+        */
+       mib_counter_names_arr[21] =3D "dot11_qos_failed_count[0]";
+       mib_counter_names_arr[22] =3D "dot11_qos_failed_count[1]";
+       mib_counter_names_arr[23] =3D "dot11_qos_failed_count[2]";
+       mib_counter_names_arr[24] =3D "dot11_qos_failed_count[3]";
+       mib_counter_names_arr[25] =3D "dot11_qos_failed_count[4]";
+       mib_counter_names_arr[26] =3D "dot11_qos_failed_count[5]";
+       mib_counter_names_arr[27] =3D "dot11_qos_failed_count[6]";
+       mib_counter_names_arr[28] =3D "dot11_qos_failed_count[7]";
+       /*
+        * MIB element to count number of unfragmented MSDU's or MMPDU's
+        * transmitted successfully after 1 or more transmission
+        */
+       mib_counter_names_arr[29] =3D "dot11_qos_retry_count[0]";
+       mib_counter_names_arr[30] =3D "dot11_qos_retry_count[1]";
+       mib_counter_names_arr[31] =3D "dot11_qos_retry_count[2]";
+       mib_counter_names_arr[32] =3D "dot11_qos_retry_count[3]";
+       mib_counter_names_arr[33] =3D "dot11_qos_retry_count[4]";
+       mib_counter_names_arr[34] =3D "dot11_qos_retry_count[5]";
+       mib_counter_names_arr[35] =3D "dot11_qos_retry_count[6]";
+       mib_counter_names_arr[36] =3D "dot11_qos_retry_count[7]";
+       /* MIB element to count number of successful RTS Frame transmission=
 */
+       mib_counter_names_arr[37] =3D "dot11_qos_rts_success_count[0]";
+       mib_counter_names_arr[38] =3D "dot11_qos_rts_success_count[1]";
+       mib_counter_names_arr[39] =3D "dot11_qos_rts_success_count[2]";
+       mib_counter_names_arr[40] =3D "dot11_qos_rts_success_count[3]";
+       mib_counter_names_arr[41] =3D "dot11_qos_rts_success_count[4]";
+       mib_counter_names_arr[42] =3D "dot11_qos_rts_success_count[5]";
+       mib_counter_names_arr[43] =3D "dot11_qos_rts_success_count[6]";
+       mib_counter_names_arr[44] =3D "dot11_qos_rts_success_count[7]";
+       /* MIB element to count number of unsuccessful RTS Frame transmissi=
on */
+       mib_counter_names_arr[45] =3D "dot11_qos_rts_failure_count[0]";
+       mib_counter_names_arr[46] =3D "dot11_qos_rts_failure_count[1]";
+       mib_counter_names_arr[47] =3D "dot11_qos_rts_failure_count[2]";
+       mib_counter_names_arr[48] =3D "dot11_qos_rts_failure_count[3]";
+       mib_counter_names_arr[49] =3D "dot11_qos_rts_failure_count[4]";
+       mib_counter_names_arr[50] =3D "dot11_qos_rts_failure_count[5]";
+       mib_counter_names_arr[51] =3D "dot11_qos_rts_failure_count[6]";
+       mib_counter_names_arr[52] =3D "dot11_qos_rts_failure_count[7]";
+       /* MIB element to count number of MPDU's not received ACK */
+       mib_counter_names_arr[53] =3D "nx_qos_ack_failure_count[0]";
+       mib_counter_names_arr[54] =3D "nx_qos_ack_failure_count[1]";
+       mib_counter_names_arr[55] =3D "nx_qos_ack_failure_count[2]";
+       mib_counter_names_arr[56] =3D "nx_qos_ack_failure_count[3]";
+       mib_counter_names_arr[57] =3D "nx_qos_ack_failure_count[4]";
+       mib_counter_names_arr[58] =3D "nx_qos_ack_failure_count[5]";
+       mib_counter_names_arr[59] =3D "nx_qos_ack_failure_count[6]";
+       mib_counter_names_arr[60] =3D "nx_qos_ack_failure_count[7]";
+       /* MIB element to count number of unicast MPDU's received successfu=
lly */
+       mib_counter_names_arr[61] =3D "nx_qos_ureceived_mpdu_count[0]";
+       mib_counter_names_arr[62] =3D "nx_qos_ureceived_mpdu_count[1]";
+       mib_counter_names_arr[63] =3D "nx_qos_ureceived_mpdu_count[2]";
+       mib_counter_names_arr[64] =3D "nx_qos_ureceived_mpdu_count[3]";
+       mib_counter_names_arr[65] =3D "nx_qos_ureceived_mpdu_count[4]";
+       mib_counter_names_arr[66] =3D "nx_qos_ureceived_mpdu_count[5]";
+       mib_counter_names_arr[67] =3D "nx_qos_ureceived_mpdu_count[6]";
+       mib_counter_names_arr[68] =3D "nx_qos_ureceived_mpdu_count[7]";
+       /*
+        * MIB element to count number of group addressed MPDU's received
+        * successfully
+        */
+       mib_counter_names_arr[69] =3D "nx_qos_greceived_mpdu_count[0]";
+       mib_counter_names_arr[70] =3D "nx_qos_greceived_mpdu_count[1]";
+       mib_counter_names_arr[71] =3D "nx_qos_greceived_mpdu_count[2]";
+       mib_counter_names_arr[72] =3D "nx_qos_greceived_mpdu_count[3]";
+       mib_counter_names_arr[73] =3D "nx_qos_greceived_mpdu_count[4]";
+       mib_counter_names_arr[74] =3D "nx_qos_greceived_mpdu_count[5]";
+       mib_counter_names_arr[75] =3D "nx_qos_greceived_mpdu_count[6]";
+       mib_counter_names_arr[76] =3D "nx_qos_greceived_mpdu_count[7]";
+       /*
+        * MIB element to count the number of unicast MPDUs not destined to
+        * this device received successfully.
+        */
+       mib_counter_names_arr[77] =3D "nx_qos_ureceived_other_mpdu[0]";
+       mib_counter_names_arr[78] =3D "nx_qos_ureceived_other_mpdu[1]";
+       mib_counter_names_arr[79] =3D "nx_qos_ureceived_other_mpdu[2]";
+       mib_counter_names_arr[80] =3D "nx_qos_ureceived_other_mpdu[3]";
+       mib_counter_names_arr[81] =3D "nx_qos_ureceived_other_mpdu[4]";
+       mib_counter_names_arr[82] =3D "nx_qos_ureceived_other_mpdu[5]";
+       mib_counter_names_arr[83] =3D "nx_qos_ureceived_other_mpdu[6]";
+       mib_counter_names_arr[84] =3D "nx_qos_ureceived_other_mpdu[7]";
+       /*
+        * MIB element to count the number of MPDUs received with retry bit
+        * set
+        */
+       mib_counter_names_arr[85] =3D "dot11_qos_retries_received_count[0]"=
;
+       mib_counter_names_arr[86] =3D "dot11_qos_retries_received_count[1]"=
;
+       mib_counter_names_arr[87] =3D "dot11_qos_retries_received_count[2]"=
;
+       mib_counter_names_arr[88] =3D "dot11_qos_retries_received_count[3]"=
;
+       mib_counter_names_arr[89] =3D "dot11_qos_retries_received_count[4]"=
;
+       mib_counter_names_arr[90] =3D "dot11_qos_retries_received_count[5]"=
;
+       mib_counter_names_arr[91] =3D "dot11_qos_retries_received_count[6]"=
;
+       mib_counter_names_arr[92] =3D "dot11_qos_retries_received_count[7]"=
;
+       /*
+        * MIB element to count the number of unicast A-MSDUs that were
+        * transmitted successfully
+        */
+       mib_counter_names_arr[93] =3D "nx_utransmitted_amsdu_count[0]";
+       mib_counter_names_arr[94] =3D "nx_utransmitted_amsdu_count[1]";
+       mib_counter_names_arr[95] =3D "nx_utransmitted_amsdu_count[2]";
+       mib_counter_names_arr[96] =3D "nx_utransmitted_amsdu_count[3]";
+       mib_counter_names_arr[97] =3D "nx_utransmitted_amsdu_count[4]";
+       mib_counter_names_arr[98] =3D "nx_utransmitted_amsdu_count[5]";
+       mib_counter_names_arr[99] =3D "nx_utransmitted_amsdu_count[6]";
+       mib_counter_names_arr[100] =3D "nx_utransmitted_amsdu_count[7]";
+       /*
+        * MIB element to count the number of group-addressed A-MSDUs that =
were
+        * transmitted successfully
+        */
+       mib_counter_names_arr[101] =3D "nx_gtransmitted_amsdu_count[0]";
+       mib_counter_names_arr[102] =3D "nx_gtransmitted_amsdu_count[1]";
+       mib_counter_names_arr[103] =3D "nx_gtransmitted_amsdu_count[2]";
+       mib_counter_names_arr[104] =3D "nx_gtransmitted_amsdu_count[3]";
+       mib_counter_names_arr[105] =3D "nx_gtransmitted_amsdu_count[4]";
+       mib_counter_names_arr[106] =3D "nx_gtransmitted_amsdu_count[5]";
+       mib_counter_names_arr[107] =3D "nx_gtransmitted_amsdu_count[6]";
+       mib_counter_names_arr[108] =3D "nx_gtransmitted_amsdu_count[7]";
+       /*
+        * MIB element to count number of AMSDU's discarded because of retr=
y
+        * limit reached
+        */
+       mib_counter_names_arr[109] =3D "dot11_failed_amsdu_count[0]";
+       mib_counter_names_arr[110] =3D "dot11_failed_amsdu_count[1]";
+       mib_counter_names_arr[111] =3D "dot11_failed_amsdu_count[2]";
+       mib_counter_names_arr[112] =3D "dot11_failed_amsdu_count[3]";
+       mib_counter_names_arr[113] =3D "dot11_failed_amsdu_count[4]";
+       mib_counter_names_arr[114] =3D "dot11_failed_amsdu_count[5]";
+       mib_counter_names_arr[115] =3D "dot11_failed_amsdu_count[6]";
+       mib_counter_names_arr[116] =3D "dot11_failed_amsdu_count[7]";
+       /*
+        * MIB element to count number of A-MSDU's transmitted successfully
+        * with retry
+        */
+       mib_counter_names_arr[117] =3D "dot11_retry_amsdu_count[0]";
+       mib_counter_names_arr[118] =3D "dot11_retry_amsdu_count[1]";
+       mib_counter_names_arr[119] =3D "dot11_retry_amsdu_count[2]";
+       mib_counter_names_arr[120] =3D "dot11_retry_amsdu_count[3]";
+       mib_counter_names_arr[121] =3D "dot11_retry_amsdu_count[4]";
+       mib_counter_names_arr[122] =3D "dot11_retry_amsdu_count[5]";
+       mib_counter_names_arr[123] =3D "dot11_retry_amsdu_count[6]";
+       mib_counter_names_arr[124] =3D "dot11_retry_amsdu_count[7]";
+       /*
+        * MIB element to count number of bytes of an A-MSDU that was
+        * transmitted successfully
+        */
+       mib_counter_names_arr[125] =3D "dot11_transmitted_octets_in_amsdu[0=
]";
+       mib_counter_names_arr[126] =3D "dot11_transmitted_octets_in_amsdu[1=
]";
+       mib_counter_names_arr[127] =3D "dot11_transmitted_octets_in_amsdu[2=
]";
+       mib_counter_names_arr[128] =3D "dot11_transmitted_octets_in_amsdu[3=
]";
+       mib_counter_names_arr[129] =3D "dot11_transmitted_octets_in_amsdu[4=
]";
+       mib_counter_names_arr[130] =3D "dot11_transmitted_octets_in_amsdu[5=
]";
+       mib_counter_names_arr[131] =3D "dot11_transmitted_octets_in_amsdu[6=
]";
+       mib_counter_names_arr[132] =3D "dot11_transmitted_octets_in_amsdu[7=
]";
+       /*
+        * MIB element to counts the number of A-MSDUs that did not receive=
 an
+        * ACK frame successfully in response
+        */
+       mib_counter_names_arr[133] =3D "dot11_amsdu_ack_failure_count[0]";
+       mib_counter_names_arr[134] =3D "dot11_amsdu_ack_failure_count[1]";
+       mib_counter_names_arr[135] =3D "dot11_amsdu_ack_failure_count[2]";
+       mib_counter_names_arr[136] =3D "dot11_amsdu_ack_failure_count[3]";
+       mib_counter_names_arr[137] =3D "dot11_amsdu_ack_failure_count[4]";
+       mib_counter_names_arr[138] =3D "dot11_amsdu_ack_failure_count[5]";
+       mib_counter_names_arr[139] =3D "dot11_amsdu_ack_failure_count[6]";
+       mib_counter_names_arr[140] =3D "dot11_amsdu_ack_failure_count[7]";
+       /*
+        * MIB element to count number of unicast A-MSDUs received
+        * successfully
+        */
+       mib_counter_names_arr[141] =3D "nx_ureceived_amsdu_count[0]";
+       mib_counter_names_arr[142] =3D "nx_ureceived_amsdu_count[1]";
+       mib_counter_names_arr[143] =3D "nx_ureceived_amsdu_count[2]";
+       mib_counter_names_arr[144] =3D "nx_ureceived_amsdu_count[3]";
+       mib_counter_names_arr[145] =3D "nx_ureceived_amsdu_count[4]";
+       mib_counter_names_arr[146] =3D "nx_ureceived_amsdu_count[5]";
+       mib_counter_names_arr[147] =3D "nx_ureceived_amsdu_count[6]";
+       mib_counter_names_arr[148] =3D "nx_ureceived_amsdu_count[7]";
+       /*
+        * MIB element to count number of group addressed A-MSDUs received
+        * successfully
+        */
+       mib_counter_names_arr[149] =3D "nx_greceived_amsdu_count[0]";
+       mib_counter_names_arr[150] =3D "nx_greceived_amsdu_count[1]";
+       mib_counter_names_arr[151] =3D "nx_greceived_amsdu_count[2]";
+       mib_counter_names_arr[152] =3D "nx_greceived_amsdu_count[3]";
+       mib_counter_names_arr[153] =3D "nx_greceived_amsdu_count[4]";
+       mib_counter_names_arr[154] =3D "nx_greceived_amsdu_count[5]";
+       mib_counter_names_arr[155] =3D "nx_greceived_amsdu_count[6]";
+       mib_counter_names_arr[156] =3D "nx_greceived_amsdu_count[7]";
+       /*
+        * MIB element to count number of unicast A-MSDUs not destined to
+        * this device received successfully
+        */
+       mib_counter_names_arr[157] =3D "nx_ureceived_other_amsdu[0]";
+       mib_counter_names_arr[158] =3D "nx_ureceived_other_amsdu[1]";
+       mib_counter_names_arr[159] =3D "nx_ureceived_other_amsdu[2]";
+       mib_counter_names_arr[160] =3D "nx_ureceived_other_amsdu[3]";
+       mib_counter_names_arr[161] =3D "nx_ureceived_other_amsdu[4]";
+       mib_counter_names_arr[162] =3D "nx_ureceived_other_amsdu[5]";
+       mib_counter_names_arr[163] =3D "nx_ureceived_other_amsdu[6]";
+       mib_counter_names_arr[164] =3D "nx_ureceived_other_amsdu[7]";
+       /* MIB element to count number of bytes in an A-MSDU is received */
+       mib_counter_names_arr[165] =3D "dot11_received_octets_in_amsdu_coun=
t[0]";
+       mib_counter_names_arr[166] =3D "dot11_received_octets_in_amsdu_coun=
t[1]";
+       mib_counter_names_arr[167] =3D "dot11_received_octets_in_amsdu_coun=
t[2]";
+       mib_counter_names_arr[168] =3D "dot11_received_octets_in_amsdu_coun=
t[3]";
+       mib_counter_names_arr[169] =3D "dot11_received_octets_in_amsdu_coun=
t[4]";
+       mib_counter_names_arr[170] =3D "dot11_received_octets_in_amsdu_coun=
t[5]";
+       mib_counter_names_arr[171] =3D "dot11_received_octets_in_amsdu_coun=
t[6]";
+       mib_counter_names_arr[172] =3D "dot11_received_octets_in_amsdu_coun=
t[7]";
+       /* Reserved */
+       mib_counter_names_arr[173] =3D "reserved";
+       mib_counter_names_arr[174] =3D "reserved";
+       mib_counter_names_arr[175] =3D "reserved";
+
+       mib_counter_names_arr[176] =3D "dot11_beamforming_frame_count";
+       mib_counter_names_arr[177] =3D "beamforming_received_frame_count";
+       mib_counter_names_arr[178] =3D "su_bfr_transmitted_count";
+       mib_counter_names_arr[179] =3D "mu_bfr_transmitted_count";
+       mib_counter_names_arr[180] =3D "bfr_received_count";
+       mib_counter_names_arr[181] =3D "mu_received_frame_count";
+       mib_counter_names_arr[182] =3D "respSetByFW";
+       mib_counter_names_arr[183] =3D "respForcedByFW";
+       mib_counter_names_arr[184] =3D "respForcedByHW";
+       mib_counter_names_arr[185] =3D "respForcedByHW";
+       mib_counter_names_arr[186] =3D "rxUnexpectedFrameTypeInAmpdu";
+       mib_counter_names_arr[187] =3D "rxMultiTid";
+       mib_counter_names_arr[188] =3D "ksrMissQosDataInAmpdu";
+       mib_counter_names_arr[189] =3D "ksrMissMultiTid";
+       mib_counter_names_arr[190] =3D "ksrMissQosDataInAmpduHeTB";
+       mib_counter_names_arr[191] =3D "rxUnassociatedMgmtInHeTB";
+       mib_counter_names_arr[192] =3D "HtpFailedMeduimCheckCount";
+       mib_counter_names_arr[193] =3D "mibRxErrorVector[0]";
+       mib_counter_names_arr[194] =3D "mibRxErrorVector[1]";
+       mib_counter_names_arr[195] =3D "mibRxErrorVector[2]";
+       mib_counter_names_arr[196] =3D "mibRxErrorVector[3]";
+       mib_counter_names_arr[197] =3D "mibRxErrorVector[4]";
+       mib_counter_names_arr[198] =3D "mibRxErrorVector[5]";
+       mib_counter_names_arr[199] =3D "mibRxErrorVector[6]";
+       mib_counter_names_arr[200] =3D "mibRxErrorVector[7]";
+       mib_counter_names_arr[201] =3D "mibRxErrorVector[8]";
+       mib_counter_names_arr[202] =3D "mibRxErrorVector[9]";
+       mib_counter_names_arr[203] =3D "mibRxErrorVector[10]";
+
+       /* MIB element to count number of A-MPDUs transmitted successfully =
*/
+       mib_counter_names_arr[204] =3D "dot11_transmitted_ampdu_count";
+       /* MIB element to count number of MPDUs transmitted in an A-MPDU */
+       mib_counter_names_arr[205] =3D "dot11_transmitted_mpdus_in_ampdu_co=
unt";
+       /* MIB element to count the number of bytes in a transmitted A-MPDU=
 */
+       mib_counter_names_arr[206] =3D "dot11_transmitted_octets_in_ampdu_c=
ount";
+       /* MIB element to count number of unicast A-MPDU's received */
+       mib_counter_names_arr[207] =3D "wnlu_ampdu_received_count";
+       /* MIB element to count number of group addressed A-MPDU's received=
 */
+       mib_counter_names_arr[208] =3D "nx_gampdu_received_count";
+       /*
+        * MIB element to count number of unicast A-MPDUs received not dest=
ined
+        * to this device
+        */
+       mib_counter_names_arr[209] =3D "nx_other_ampdu_received_count";
+       /* MIB element to count number of MPDUs received in an A-MPDU */
+       mib_counter_names_arr[210] =3D "dot11_mpdu_in_received_ampdu_count"=
;
+       /* MIB element to count number of bytes received in an A-MPDU */
+       mib_counter_names_arr[211] =3D "dot11_received_octets_in_ampdu_coun=
t";
+       /* MIB element to count number of CRC errors in MPDU delimeter of a=
nd A-MPDU */
+       mib_counter_names_arr[212] =3D "dot11_ampdu_delimiter_crc_error_cou=
nt";
+       /*
+        * MIB element to count number of implicit BAR frames that did not =
received
+        * BA frame successfully in response
+        */
+       mib_counter_names_arr[213] =3D "dot11_implicit_bar_failure_count";
+       /*
+        * MIB element to count number of explicit BAR frames that did not =
received
+        * BA frame successfully in response
+        */
+       mib_counter_names_arr[214] =3D "dot11_explicit_bar_failure_count";
+       mib_counter_names_arr[215] =3D "mibRxErrorVector[11]";
+       mib_counter_names_arr[216] =3D "mibRxErrorVector[12]";
+       mib_counter_names_arr[217] =3D "mibRxErrorVector[13]";
+       mib_counter_names_arr[218] =3D "mibRxErrorVector[14]";
+       mib_counter_names_arr[219] =3D "mibRxErrorVector[15]";
+       /* MIB element to count the number of frames transmitted at 20 MHz =
BW */
+       mib_counter_names_arr[220] =3D "dot11_20mhz_frame_transmitted_count=
";
+       /* MIB element to count the number of frames transmitted at 40 MHz =
BW */
+       mib_counter_names_arr[221] =3D "dot11_40mhz_frame_transmitted_count=
";
+       mib_counter_names_arr[222] =3D "dot11_80mhz_frame_transmitted_count=
";
+       mib_counter_names_arr[223] =3D "dot11_160mhz_frame_transmitted_coun=
t";
+       /* MIB element to count the number of frames received at 20 MHz BW =
*/
+       mib_counter_names_arr[224] =3D "dot11_20mhz_frame_received_count";
+       /* MIB element to count the number of frames received at 40 MHz BW =
*/
+       mib_counter_names_arr[225] =3D "dot11_40mhz_frame_received_count";
+       mib_counter_names_arr[226] =3D "dot11_80mhz_frame_received_count";
+       mib_counter_names_arr[227] =3D "dot11_160mhz_frame_received_count";
+       /* MIB element to count the number of attempts made to acquire a 40=
 MHz TXOP */
+       mib_counter_names_arr[228] =3D "nx_failed_20mhz_txop";
+       mib_counter_names_arr[229] =3D "nx_succsessful_20mhz_txop";
+
+       mib_counter_names_arr[230] =3D "nx_failed_40mhz_txop";
+       mib_counter_names_arr[231] =3D "nx_succsessful_40mhz_txop";
+
+       mib_counter_names_arr[232] =3D "nx_failed_80mhz_txop";
+       mib_counter_names_arr[233] =3D "nx_succsessful_80mhz_txop";
+
+       mib_counter_names_arr[234] =3D "nx_failed_160mhz_txop";
+       mib_counter_names_arr[235] =3D "nx_succsessful_160mhz_txop";
+
+       mib_counter_names_arr[236] =3D "dynamic_bw_drop_count";
+       mib_counter_names_arr[237] =3D "static_bw_failed_count";
+
+       /* Reserved */
+       mib_counter_names_arr[238] =3D "reserved";
+       mib_counter_names_arr[239] =3D "reserved";
+
+       /* MIB element to count the number of times the dual CTS fails */
+       mib_counter_names_arr[240] =3D "dot11_dualcts_success_count";
+       /*
+        * MIB element to count the number of times the AP does not detect =
a collision
+        * PIFS after transmitting a STBC CTS frame
+        */
+       mib_counter_names_arr[241] =3D "dot11_stbc_cts_success_count";
+       /*
+        * MIB element to count the number of times the AP detects a collis=
ion PIFS after
+        * transmitting a STBC CTS frame
+        */
+       mib_counter_names_arr[242] =3D "dot11_stbc_cts_failure_count";
+       /*
+        * MIB element to count the number of times the AP does not detect =
a collision PIFS
+        * after transmitting a non-STBC CTS frame
+        */
+       mib_counter_names_arr[243] =3D "dot11_non_stbc_cts_success_count";
+       /*
+        * MIB element to count the number of times the AP detects a collis=
ion PIFS after
+        * transmitting a non-STBC CTS frame
+        */
+       mib_counter_names_arr[244] =3D "dot11_non_stbc_cts_failure_count";
+       mib_counter_names_arr[245] =3D "dot11_txund_discard_fcs_count";
+       mib_counter_names_arr[246] =3D "dot11_rx_ampdu_incorrect_received_c=
ount";
+       mib_counter_names_arr[247] =3D "cl_rx_class_match_count[0]";
+       mib_counter_names_arr[248] =3D "cl_rx_class_match_count[1]";
+       mib_counter_names_arr[249] =3D "cl_rx_class_match_count[2]";
+       mib_counter_names_arr[250] =3D "cl_rx_class_match_count[3]";
+       mib_counter_names_arr[251] =3D "cl_rx_class_match_count[4]";
+       mib_counter_names_arr[252] =3D "cl_rx_class_match_count[5]";
+       mib_counter_names_arr[253] =3D "dot11_rx_mpif_overflow_count";
+}
+
+void cl_mib_cntrs_dump(struct cl_hw *cl_hw)
+{
+       static char *mib_counter_names_arr[NUM_OF_MIB_COUNTERS];
+       int i =3D 0;
+       u32 mib_reg_addr =3D 0;
+       u32 mib_reg_val =3D 0;
+
+       init_mib_counter_arr(mib_counter_names_arr);
+
+       pr_debug("---------------------------------------------------------=
---\n");
+       pr_debug("Counter                                   Address  Value\=
n");
+       pr_debug("---------------------------------------------------------=
---\n");
+
+       for (i =3D 0; i < NUM_OF_MIB_COUNTERS; i++) {
+               /* Reserved registers */
+               if (i =3D=3D 173 || i =3D=3D 174 || i =3D=3D 175 || i =3D=
=3D 238 || i =3D=3D 239)
+                       continue;
+
+               mib_reg_addr =3D MIB_REG_OFFSET + (i * 4);
+               mib_reg_val =3D cl_mib_cntr_read(cl_hw, mib_reg_addr);
+
+               if (mib_reg_val =3D=3D 0)
+                       continue;
+
+               pr_debug("%-40s  0x%X    %u\n",
+                        mib_counter_names_arr[i], mib_reg_addr, mib_reg_va=
l);
+       }
+
+       pr_debug("---------------------------------------------------------=
---\n");
+}
+
+u32 cl_mib_cntr_read(struct cl_hw *cl_hw, u32 addr)
+{
+       return cl_reg_read(cl_hw, REG_MAC_HW_BASE_ADDR + addr);
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

