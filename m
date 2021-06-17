Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE873AB92B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFQQNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:12 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:58683
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhFQQL6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Soreib1y/w6xZySGPa09z2gMbWXnTVGQwkqetc38i1J6i4Ve9nfztzD+ykSkmlm/Vew8bv92NPFEz0KPs8FMA2SD4rec2KFtBRwv4nU3A5f3iE6uKsMXUCCwLhAuepdzSPypsdzt0AIfTMUUL4yKMsBjR49lY+/VLmGjQcPEvbPcqxZZ/A+hMUZOt8iWkJWaog3+rI65nJi55adkqfEH51zV3QVNBHAg0p4BBHPUiVayJjJG0flCsUS/ffjTvHheRXeniNqO3IJ9k0l8A89Rp+RiDHB/q+AJYw9VWbCr6FwdXnYefqSDe1G58lVYfBaVUffYALsnj4NxYzqB+5hnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQJ0VlmHdLUvZqa6cXjcuYrVfaAY45zjiGWSdSHRA6s=;
 b=guNK/KaD4beZrRjy0NyDKCWh1H5ObycjZ1b2IjkUEq4gU5XQ9xxE7GPR2plUZTESbOiAFT/6hP7aArn6liacahKQf4D2picXvd1ydM2LncOD6eVNrsgTFXC8uS2jC+XSKcUec93g7JH16vbaxdP7aRx5NrrdMA8MYI9MzyhEedZtSVTLClxiK45X3eD5c2CL9cvfJZxHB8/5ST9kJ5kY+TFHlLNRpCEY5Qu+sryR5miF7xjMtLsx4prZWynmEVwCN3hh2oKiF/uBZx5gTIRWO1HiKx8cfZ9hUJDHfufyy0FdWRvDNLi3HEed7iSgSkFtZE5MqparILiio/119h7nuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQJ0VlmHdLUvZqa6cXjcuYrVfaAY45zjiGWSdSHRA6s=;
 b=CMi/9UfHJg3KfKnEOQGKA0geyx9ery8PCm4GnnnmB94mv+424nAuBmwR4sIpirycMDiuseHjBvBG4bEN0oro2eRVQ5hu7T6n/seH2gaAJlo1r30cGsdAaVDmJqjay5iOiSzjWPpxSfpY+nRAF8RBnGjHXtRNmCqPUWqKkmwgSYg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:52 +0000
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
Subject: [RFC v1 217/256] cl8k: add tx/tx_inject.h
Date:   Thu, 17 Jun 2021 16:01:44 +0000
Message-Id: <20210617160223.160998-218-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad0d104-3d88-41c4-68e6-08d931a9e1e3
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329FE5B9C3D0C9FF8022A8AF60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oNf77qXLtpmZpZOGObF551aoe4W0LzuoOZKa3JtQmf/3VpwGcC9gBOSB8tNpPyJjXuKvr3JqXIv68EfzVTZaVycEQCIvJuYUT9rQRpruxEjJQjgO65/PuujkDjmJrWxxzKkSIrwf9ul7t/LGrQhhtFds56vk4volZCHaf0BTQMuHASocmrzpgCjXIjO/D3WrvsYZ/L5SvCpP0aTNUIoMu+EvJdkEMDwGkfI6TpD9ZrxbXtNzhQbeiFKheel4n4GSCcz2uAw0SIuDfbGk9IDCyd2H2SgKo2lZ3miuhQxUk2AdGrGtY98kYkbArS2wz533CO1KLygXTlnpWRkRqNOCBPkvS2VhrELpFBURF4Flo/yXFNeMnrTsqn8j0WMhm1RVsQc5c6qaBrw6Ovt2JS80+cyUOqUIEEdGIKnmsA/bBRAIXYt/MBrKNXREvx+rfKnx5YiQ9XzEXxjK2xWyAaDRLp3ZHhnb2LBfMjgg7QI4SJHOWeg999EYOL5EMKSlmiLa0B1rC3eTJUd3nEbC0H4ru+7wtO8PYWyFWZu+5JtXMabXHI9cWljzDLstnZNvqqrLTlnAgNJJkqEu6SZVtA2L8t/g9yTj1QTTT6x86vZU/2v9PA6dSpCfCEZ1NpApMf8MYQlCOYkiqqIj/yTJql5Kj0nhc62EZRYReLQjBeKMtkLIn+CuypjkG9PA8Xfky9fWD5kicFg0jvmfnbzW0lGlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpLQXvdSq6IMBM2tqnjaI8UAdmYYdggtWfnn3xJ43X+fv6mE9XSsScZ3zC6j?=
 =?us-ascii?Q?oyjACem++YqlW942jrP5EzY8PpU39lypc+FFq/S1e682Aao0Xk0ANIrDcxFG?=
 =?us-ascii?Q?f1G/+03YH8afPCwNdGnr5dQWJkUqeLsJpuvwQDvjbq3rR0L54/oNSS0yLoGY?=
 =?us-ascii?Q?yzgv9z15/y4Tip8PYifn6Y2ixyZ4YYmKmd7+Km9teNZX9zKBIa+gMr0OCU2x?=
 =?us-ascii?Q?z/9WSb92QD/MRPVl2327QONO9ZKgEZNJo3XL449+zyMXauIWLUOrggx/ANT0?=
 =?us-ascii?Q?7LPGVaUh78Qe4Sf4hHY7uz0axDeberU5l7/VDDGrAZUiaxUdpdjan/5rA3+P?=
 =?us-ascii?Q?AcWuAHsVc6tlvw/AyVm5MbWOqxrcJcu1+PaJT4v5OjvmybEUGL2adep4xs6A?=
 =?us-ascii?Q?EWFhSbG6j51Htw9QV9KZA+v1Owqu1M4vULoubRV1Zvn2mUo8m/3WUF+Hf7l+?=
 =?us-ascii?Q?SMvaB8YjTNw3Y67cyKra0nIbjfj1DKcDV45mqCHRXWz0FuoG0MkdSkF7xnUL?=
 =?us-ascii?Q?OgkySrEt/Uab70rzf2EsebyFRgrBQlsrioyQQS26xonK+LTseMtZwAFrUROd?=
 =?us-ascii?Q?wfvQ8E8ocC3P1mUKdi0pSZjZBgcmeO6yj2jMcZGQDqeBhpfUhHdxxv5iLj6e?=
 =?us-ascii?Q?X/shJ0scNet/zfI2c48CmQrN72DgF3xgezeoi2bGVY44MlxPyd/23xIYyFIg?=
 =?us-ascii?Q?XfHChbn5jvG3GYNypIIR8hHM4mc3KbP9aqZE1C6jAvIEVgPyS9DbteaweTEr?=
 =?us-ascii?Q?kkO73XHhDvtU/uFYf9OFcxRV4CGQCXVstNoZfmA+hKfP9V5XWmRqorDLJGO/?=
 =?us-ascii?Q?RTaRuebIuxLNuliLQrAVTpIrWMVkVk27F9MzhpbVigvvrOvxc9l+wPsRk/cw?=
 =?us-ascii?Q?bCKahzSTduTx4kL5zJ+5iA3fTe1YMnj0E8l0BNApuFp7yVZETJiQCH873Ukx?=
 =?us-ascii?Q?VS5kTVQ2N+LYR41+zuB1EHgKcnXIc44J4DOSgU+4aSeemJUvtmrwmIMT9JKs?=
 =?us-ascii?Q?Bdv/0SvIafgBOs2KwK/5wzaaCYYejVPIkN15rQmqaZCMHTI5kntRhY231tPR?=
 =?us-ascii?Q?0iNNn438AcV2xXl5w97dpnqK9WVqEfFtMv0Bvj+vxo1cckgImvbFiZCy0Rbc?=
 =?us-ascii?Q?EwCr6X1AsgPJa0G05COQLioRI8rWAqw+u0wguNJItNl47T6glDSfN+JAO7zQ?=
 =?us-ascii?Q?5ChUT99kgeuOB0v9+gLY0CdKq157WYbpZLigdXA/Nf4NO7GDJ1v1TkITnCEu?=
 =?us-ascii?Q?u/kfdXGyfxJeFosMr5UFYMvCKpsUuup6GKbO7zzNW1Ut2+n9yYWrF9uM4zMi?=
 =?us-ascii?Q?M8zlepBi+AIrqAiWRAa5GuF2?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad0d104-3d88-41c4-68e6-08d931a9e1e3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:36.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPcKqw2ApAh6wWZYHaqIiWtOCyjC63xe2GWRV/AjqfgdHcWxArdgFEERDIVmlWE1nrBs+vVU4m24nSK3yM4Lvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_inject.h   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_inject.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_inject.h b/drivers/net/=
wireless/celeno/cl8k/tx/tx_inject.h
new file mode 100644
index 000000000000..9f20c336985a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_inject.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TX_INJECT_H
+#define CL_TX_INJECT_H
+
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/debugfs.h>
+#include <linux/string.h>
+
+#include "hw.h"
+
+#define TX_INJECT_SINGLE_AC       AC_BE
+#define TX_INJECT_MAX_SKBS        8192
+#define TX_INJECT_SKB_LEN_MAX     4096
+#define TX_INJECT_SKB_LEN_MIN     16
+#define TX_INJECT_SKB_LEN_DEFAULT 1024
+
+extern int ce_tx_inject_real_sta;
+
+void cl_tx_inject_init(struct cl_hw *cl_hw);
+void cl_tx_inject_close(struct cl_hw *cl_hw);
+void cl_tx_inject_reset(struct cl_hw *cl_hw);
+void cl_tx_inject_start(struct cl_hw *cl_hw, u32 tx_cnt);
+void cl_tx_inject_start_continuous(struct cl_hw *cl_hw);
+void cl_tx_inject_stop(struct cl_hw *cl_hw);
+void cl_tx_inject_stop_in_recovery(struct cl_hw *cl_hw);
+void cl_tx_inject_stop_traffic(struct cl_hw *cl_hw);
+void cl_tx_inject_stop_ba_session(struct cl_hw *cl_hw, struct cl_sta *cl_s=
ta, u8 tid);
+bool cl_tx_inject_is_running(struct cl_hw *cl_hw);
+void cl_tx_inject_cfm(struct cl_hw *cl_hw);
+void cl_tx_inject_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_tx_inject_iface_remove(struct cl_hw *cl_hw, struct cl_vif *cl_vif)=
;
+int cl_tx_inject_set_length(struct cl_hw *cl_hw, u32 length);
+struct sk_buff *cl_tx_inject_alloc_skb(struct cl_hw *cl_hw, struct cl_sta =
*cl_sta);
+
+#endif /* CL_TX_INJECT_H */
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

