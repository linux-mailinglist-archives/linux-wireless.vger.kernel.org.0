Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595AD3AB849
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhFQQGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:18 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:17172
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231947AbhFQQGC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK3AFbuixRwJ93bSV3Ksrxpy9N6kxOijBzU3OdRJJHhTgm+ut7N6BKMbFg60HDQK+ixg7hPYfXNH+Si3Iam/vJft+virGt3yEehvcHFeIQ5s42ZiFcFvOPRhwO5mzRbroBkq1RCiApcO1yqIcxHbBIOm2/egmt/YYM5WQXPLAXFrpw40gHTKQ3lWWYiDXuLeuxopeCZ8ZrTVrFPDXtjNEmEBBrcfwJurkxMAToFn6LQHCujind5qnRX0DAsA9QSOOavmrkUcUPa2pkKdEXf73YDG7BqEDSNnz5LH2EH74vd4VQFRzjAoUnZMGiJrTNIQpi8miSp+J0idSUD+18m9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePHmk7qqJlVUm1gVQxB5Hwl6UNntbFcyftb7y3F2fy8=;
 b=cQ07scLp7Isrw+B8J/4RxDrgjePwZ+LprZIoGewmaWf1IEJ8s7YSekS50HZciTy1RAVgigZot8uO5aVDBHkr2oCgLGSK694KGWMyKXWOV7J4XbRJq2gllTdAS6jL3sNdUObRvm6oK9MXDZMydAMAQPYMKKhAJQOGUvjwCqVo78TjK2SgGAW9o5sXbhkc+jXlZDx55ux7rKb+yFJ5FrYd//3nKoxgpfz+iMBSE+Bnc/4s+2CXltYIcNDdRLwmtjr2S/KkrrrIQ50sG/QG7uOhF6qCHIpQrnJwuY0r24UIUR8WpO8yN9OuA8NL0IzeqO58zJ3LyVC2wddxx+HGu5uHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePHmk7qqJlVUm1gVQxB5Hwl6UNntbFcyftb7y3F2fy8=;
 b=iBx4XEuuVjLlVbqSK30+skMuCIAtN+k3s//kB+F3ReUPWIfXidnn/096/tDpmiz0kP3C+st5THNpN+PE7uJ+hKF53XlB4LS3VR7AS5aqZNOojS96yvkSbKywQTwyre7zQ59eMn1ONofuyL+bnjN4DIhKUYcjGZrEq3VmmAedQ58=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:43 +0000
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
Subject: [RFC v1 045/256] cl8k: add chip_config.h
Date:   Thu, 17 Jun 2021 15:58:52 +0000
Message-Id: <20210617160223.160998-46-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b474cfdb-8960-42e1-cc4e-08d931a96f1b
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234CD4C49E7D90BF68C448FF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrtwcoZat1tytEyethQVusfKfP2freDblH8YBu2f3Cj7M9qoCdPC+5Bx7tovoIYfUvGqYJkrrVevEtiU9/4n9dO+AmmGqUijzYYiA6PIFlTzl9N5+6ugUGiH+vI0hFZskPszZ8wYB0HHNTHzwW3d04BpxcZk3SKq4TTahDJm03JF0F5zdo/SGSIOEFcY3DV4HNAKqehGHzizFIDy95KpIOlwcN6+7e+ikqv0cJJxewOXBYsmk3wAPRyugtfS2MT6vyplUMYNf6g8zH5hoegUoLCU4sDuXzpoldbfr71AxVJMuAqyZcSk4fApD42DccKhP+wOuH3tBE2uhTCsSMFq2EPoSF3eSoKUEoDK+tyhtshSFC0xhSujBhPnBvwq/1opJJHwmADPyf8asFlUAQFXSk93xKYgirmG4VFnnBBQXGNA6AvICqP/6HhZgcHKLFdelv4p4aC5Nu562buNKZoPcx04+0Gzer0FckhTMr/hboxKL5ULtlswV3QUfrtz9CCUitKw7x0rWujJ4mC0Wmw+lcdQQ422DG+MpMh+tBupI6ZMuOVFUCHBjZXpsD3n/lUhqI4UGtXyVTO7I5tlOLi1QHNJS5/aPRLPlcGJw3v8tyL6dqBHX0By7tnSr0pDKhc2bHbLBR5iEvjCuaq4LyclgIAzJGx+og9jcpGxGKp/RGQc/cYeujOpQtjXpbXgmnkZUoa+R/37dA4ErgQmAVhU+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvMOvLWao5TFuBT9kpVpPQxrV/gNoRsb1Wy/Bd7/T4f/GXB9646yDf9Azefl?=
 =?us-ascii?Q?g9ir2W7uqC6Hd55uFnY4pWgnIH9VQ34x8Nh3gBMEopjjgoGH8fZifsAnBzfx?=
 =?us-ascii?Q?HtyTfFKjG8ylNXm2UCQv6gJOVn7HoeWP746jGKvis0FbKT5AR0UFrXr+3GXq?=
 =?us-ascii?Q?W0TiIpNDyv0pDcjz7r0JnJpD5Jri2JAItm0a4v7akrdaKmd6/gBXRSXVgCta?=
 =?us-ascii?Q?MCWhfbOA8tQbmBY3dIg+EQWrzINfusUAMOGngM07txo4QyRUT+MSg2Vy5rDZ?=
 =?us-ascii?Q?oV67SjjqJvqxnwH+mFJIQ07B+y5IxVCrrjcPScY09cfogx5SsJq4G2jyRm/r?=
 =?us-ascii?Q?V9q/BA46SnmnbNsMBaJiYYVBMLDMAZMqc97WO3hdlx0dHKGPYT63t3qePy9f?=
 =?us-ascii?Q?L0iW0LiHX3QLzKiwJVPmhSJ2p5UXA6nQaNNKdIvceK3wVVhaDPfPt0zEWU1s?=
 =?us-ascii?Q?tAR9cx4hsMs5fnL1Ls59Xtm48SBGTvkfBydhpFVzZlcmLO5yadwlXmw/lWrd?=
 =?us-ascii?Q?USecyqZeP86T2idH/MexTk0tNcUTkDS/V5mJeuvlFLbjw92LYpf3vSs8jN5M?=
 =?us-ascii?Q?Oi7nTABLQF03FvaE5AVGq3sijbPeiHtw4tyNuVLfYHyr4Wsjw+90fd5MJF25?=
 =?us-ascii?Q?AjJT0NWt6SGyNvxVPQ9aWRASDMw+EqdmbRKufZo0z3xyDGgNMb8HBMiPIkrZ?=
 =?us-ascii?Q?dpi5t7Qdeb634ClVU6a2puNm/YlmTBL/M5zDm5WWK77ODr36aumaeDTDsE8A?=
 =?us-ascii?Q?+Ojoe8UwMPdzn6WL+3eqiy2oClQqCKcBAD9JRaV+GB2TqpuhfljUbtUITxRH?=
 =?us-ascii?Q?5ponGR2tsS9wx4DInjMtJoRB9bmFibYg69IuORMqIzKQC/ufPqiwb0uyvi86?=
 =?us-ascii?Q?4mpVJRoaVdBkIjdl0p0q+IaZDHqFUKYQsewx6q8qYT047tdG8ezfPyXnF5U9?=
 =?us-ascii?Q?S5lVt0MXqcDuhnTullvMfaFSbZEKu9u1KNxd3I+lJJdFBt0pEpeZ2Lmj7ejs?=
 =?us-ascii?Q?FftNFfsO3d4ThvuNYjiM6BxBmpVYarMGFbhVcW4ZIfh12N2aqQaSZW7jlVyK?=
 =?us-ascii?Q?sUbl4asf9QyWNPoYOyyHLDtKARk98Zs7FQZ8CqQU1GQMWO6bksuk9lZ/TGbV?=
 =?us-ascii?Q?t5/g0cQJpNtCa0QVdRqtcuUArUTo1RwH0Rqp/A5Qjn55Fs+qNR4u38ycUmjd?=
 =?us-ascii?Q?ZlL0JAHKR0687sQRXwIYLNahXovaD0fHpjHBjQ9ZmHj16DgQRNGwaXUVrUV+?=
 =?us-ascii?Q?KF63oAyP0TNp4wsrZ6EI1Q/stZxyl//xvWky0QJeZPdqhnQ5aGwR/jZol5Ds?=
 =?us-ascii?Q?LRmSfCNj2PT6xsuRGF9k9z5F?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b474cfdb-8960-42e1-cc4e-08d931a96f1b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:23.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JGpWaqHWBXmCqEPObLj/WuMM4IiGvUPlAUBQ7QvLjUJPctj/UPzsTXMn14YYjaBl7GnYSs0Z/x5QYENjvTU4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/chip_config.h    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip_config.h

diff --git a/drivers/net/wireless/celeno/cl8k/chip_config.h b/drivers/net/w=
ireless/celeno/cl8k/chip_config.h
new file mode 100644
index 000000000000..2cfa20522e0d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip_config.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CHIP_CONFIG_H
+#define CL_CHIP_CONFIG_H
+
+#include "def.h"
+#include "utils/string.h"
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define CC_MAX_LEN 3 /* 2 characters + null */
+#define FW_MAX_NAME 32
+
+struct cl_chip_conf {
+       bool ce_tcv_enabled[TCV_MAX];
+       s8 ce_lmac[FW_MAX_NAME];
+       s8 ce_smac[FW_MAX_NAME];
+       s8 ce_umac[FW_MAX_NAME];
+       s32 ce_irq_smp_affinity;
+       u8 ce_eeprom_mode;
+       bool ce_production_mode;
+       bool ci_pci_msi_enable;
+       u8 ci_dma_lli_max_chan[TCV_MAX];
+       s8 ce_country_code[CC_MAX_LEN];
+       s8 ce_ela_mode[STR_LEN_64B];
+       u8 ci_phy_dev;
+       s8 ce_debug_level;
+       u8 ce_host_pci_gen_ver;
+       bool ce_temp_comp_en;
+       u8 ce_temp_protect_en;
+       s8 ce_temp_protect_delta;
+       s16 ce_temp_protect_th_max;
+       s16 ce_temp_protect_th_min;
+       u16 ce_temp_protect_tx_period_ms;
+       s16 ce_temp_protect_radio_off_th;
+       u8 ce_phys_mac_addr[ETH_ALEN];
+       bool ce_lam_enable;
+       u8 ce_first_mask_bit;
+       bool ci_no_capture_noise_sleep;
+       u8 ci_dcoc_mv_thr[CHNL_BW_MAX];
+       s8 ci_lolc_db_thr;
+       s8 ci_iq_db_thr;
+       bool ci_rx_resched_tasklet;
+       u32 ci_rx_skb_max;
+       bool ce_calib_scan_en;
+
+       /* New NVRAM parameters must be added to cl_chip_config_print() */
+};
+
+struct cl_chip;
+
+int cl_chip_config_read(struct cl_chip *chip);
+int cl_chip_config_set(struct cl_chip *chip, char *buf, loff_t size);
+void cl_chip_config_dealloc(struct cl_chip *chip);
+void cl_chip_config_print(struct cl_chip *chip);
+
+#endif /* CL_CHIP_CONFIG_H */
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

