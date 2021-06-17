Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC883AB918
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhFQQM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:27 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:48736
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233943AbhFQQLX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USBg7fj6eqDy56dm/6jqlFMobtJMcGkxjUPhA6i5gFivfBmm22iRTzSJaLj/IsbFPQnAWZB3lHPktigh95I80TaxHVtuNmb4NRmeaLSsDXrnZAS5MwT31ZTkiGtZaSuchfCGMq3JEcmLj8pDd22KMoXR8haSUwOfajr949rYkv76SAypxwNw87BZ2UYyPkKmMVzLWgRjVuAR9cC5tgRlqpPCLOTMoa5e6Na2i9Wz6aDt5ek4YVddI1bpJSO/lHPeq+N7vAJzxB8aRvNwrG/L0wLJ0vdjsjU2H59z3oQ++2Zk4nqZHhk3HIqcX0S3twApywaKaKAxXjOOfC0uoDuj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG08x7DVOj4aEC7A63/3ufvNtczDFQzg/w/HBu55rEA=;
 b=JU1X8k7IMPuGJ5m6uvLo3L1UiwQVgsWF+XxOb7yP/glCoei/42mjETxYl+NO5Jbu+XDwswLDCf/6dcVF/BvJ/lAC+1Yip507uXmbd8ol6GjJX1bgG0nzN++zHigbo8o/ngg3/UNMI8aWUF1BXn+rC3awLStMbDEsCJNUBzb8a9Htr3ieJv0CrqnNdpBm9ZjewDT5VwfpSqztBvwbajGyP1KlNHzZYoF0XzysNJ8HoIjtr7hZKjIK/w78vt0ss1Vh48doC9aQZ1tqW/Bb9E6OSxShgZqe0hQDBLWGQn7/HbfGZ7cdHzzbZOkIhfj/FUAmMVcLwUkCkQXsgRG+xjD/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG08x7DVOj4aEC7A63/3ufvNtczDFQzg/w/HBu55rEA=;
 b=HFlT+7d10m+lnNK6xrxX4i65slEpj1pneJgR24Gt648oaEWIC5QK4Dzl0W43HFQd1+RZCIGPgojdxUPvsea7qlRDEhS2IfyA3wV6pcaYYvduxAcosca6QJRZ1o2xM+dyxRbYQeztrRinz8qCjHR0hrsn2jWe8fhRMeBMEFPulJE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:33 +0000
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
Subject: [RFC v1 244/256] cl8k: add wrs/wrs_api.h
Date:   Thu, 17 Jun 2021 16:02:11 +0000
Message-Id: <20210617160223.160998-245-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4935f893-b3fa-4245-acdd-08d931a9f42e
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB097867EE0F9880516EEF50EAF60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNgA9DFsMonNKSVObK3ikwiHEow4iLUDoLvUp8N9dfyoChBjvCALnh1bcpreoZPQ5cQBgUm4keBBeEQAsPZFULkjdhcz+2wj/xizxaI/YfhGKjpVXziLDAKeoigFlVmgIf+MTKYSmSgtegXYkh9oEbYe1Fy2oDLUS5xhDcSNYZbVg0gb5KoyEqnuHR8Fi6PMW18pNnZHCahiSQl1NA+MqZ7pqCZMyQHINwjzXdmTtEtrmI0ArHFxG/QFQF922pzmTEbGHqm9X/TXeqy+IcgBDAkPT2vNxiS7smEH7wfypDBV2H8P4ARELEC4JIEyohEFUs01vK7+WH9JSH6srOMiQa118AahPXS6/YojNMOl9BNvnlb12Umh/BWzARwmpFIkyKAMDCGrrG/+F9qOXMSlYoMqi+KiZbSCi2PmCdF1V32k09PXFZ5mZGioGnV3rTn45m15VNHRAipXeIYrJ8AgBRyBei04hXs+5gj/JL5Gu019+4Ah6uZHZ09uaEpCn0IVbkz11SZmryNn0/7fSuzSRaMUFijv31fpsVQWWewmHcWx066xqURxQP/afs4bwT1/HMIFq2AN9sLzoA0DjAePYyBWs3cYnfXX7roKuDymyenbjKRqOXfVXaJ/iUkVkf+psv7+EpfnBm/AqfVvMmQl3HlKF6XKHK6D4xYo2D57dd1ua97TNzc+3tWit1F5UPcnzgBh/SMlUTZ2HcIS7mqJgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(6666004)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zQ5IF+64S7vN2G/s+SRxLt3EzM81UaeVgDU1pydzSge3eFxmLxExcHeStuj?=
 =?us-ascii?Q?tLq8bmgCcb6doItqx+GEiIOLdzVeI1EevrK+G7KmyctYdvDAMowdDii5Ru4r?=
 =?us-ascii?Q?4bS627o9CpSmAa5Xi4jz2tVhPbJnOMTOVGYJd/uGEH6ei9zqq72eucRbHiek?=
 =?us-ascii?Q?9+wZAYWJG1XFt0duHsVe23+R6bzS9Z9r/6VfN7zl1GoR63TwhCNBDY//n2oz?=
 =?us-ascii?Q?62f3bUDCsMK1CTWDEghXfN2gs4Ae2uvnHercR0miROKkf+8FFmuyTeKiq/aV?=
 =?us-ascii?Q?ANfmQqd5o8rsPtPFPXgqPqJjZ9aNl53etcsWRLZ0YBEtZ6sgF1OtRhEFbCTR?=
 =?us-ascii?Q?ehd+FtQHCI1eo//bmEmQSlT/oyP78XPB53XezScCejCHp0SgRmMXDOI45bJ7?=
 =?us-ascii?Q?TpimZQmdlqxmyTxf0kR9kCuOmKxTvRJ2frOa5LOcXRdLsAOx4gZG0tuC0IaO?=
 =?us-ascii?Q?/wRyoncWJF0wcL8kfi0QW4Q1PvYRpUd5fYoyiNMiCE6KqxeNoIRVWn8BYVXe?=
 =?us-ascii?Q?QRAYYQ95scJGgBdBfZsAgbfVuhbGhcDa5Uo9Q23/61BojrXYmlnEjjx4ff6p?=
 =?us-ascii?Q?ZnlelsBPoyjvst4X3ia1blN3vgIBSfCOkvSrnBtUQ8t+j7vC5Y2uPkB05hnT?=
 =?us-ascii?Q?RfoWMclvMsHK3z1mMiG3f/dIRud8/DcqGMywblyhzTctDqY5JrXgkMcWUtZH?=
 =?us-ascii?Q?Qc25tLtqxu1Yq/qO1jPLwVRkXdu4Tt5GLXGBolNQulRP9hdasPF2FOYvBoEF?=
 =?us-ascii?Q?LvbFl1n/vlyVyv0dFKL38tYjqisarclkXz0fTNyiLM/Z2lgxvfimmLsoVjbO?=
 =?us-ascii?Q?udtUvUOQzoSO6uR0K1lczVFOA8jjAm5cp0vyv4wYEg3G5v8tHR6KEML5215j?=
 =?us-ascii?Q?vzqSJvusoAQWpvgZVRyWikWKG/Z+oYCBnCHgc65xsFuGnYDeKH9IjiNo7m61?=
 =?us-ascii?Q?+RalowPK83tY8uvawOzJHciJ5O1FhhOy6xpiUP7QNQgwyu7+WwrOi/fr8tDi?=
 =?us-ascii?Q?jSDzBQf9WpndCEaFKawSRmgbay+zGIX3X7AUs9N4kkMLfFt0YK4vuBF2OhJ6?=
 =?us-ascii?Q?dNtZIcr1NGLLbVHU30cZf5JF09gwbYkZcr8JFhlm+X2zy8LnRI200chOLb70?=
 =?us-ascii?Q?dDvsjBYkCuX5rpShokApVX6/6mdXoGt3oq5+KccYMGrVqruAKw5tAOFmciY6?=
 =?us-ascii?Q?7EvxuoKkjM8DBsVoj+hiXl4xerfPuu29SDncwl9nAW+I/uTzrMgkGzloyDe6?=
 =?us-ascii?Q?YoRYIBDQPQzgRf5hto+ViDlZPazw2aADpQ5LpjkJDfkZ0pu5Gd+YOQXWaW1Z?=
 =?us-ascii?Q?pVqKB8CJgBTUJOsuBczeu5EO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4935f893-b3fa-4245-acdd-08d931a9f42e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:06.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrKYaMBbzfHBF5cbm2g5UYPtGfuyU4nKIHdpw09yGeVwb18RdITzgyNM2LVMEFwiWoHyPBm8UFMCt0Mwuk+YIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_api.h    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_api.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_api.h b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_api.h
new file mode 100644
index 000000000000..016d606633a0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_api.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_API_H
+#define CL_WRS_API_H
+
+#include "hw.h"
+#include "vif.h"
+
+/* Driver --> WRS */
+void cl_wrs_api_init(struct cl_hw *cl_hw);
+void cl_wrs_api_close(struct cl_hw *cl_hw);
+void cl_wrs_api_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+void cl_wrs_api_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_wrs_api_bss_set_bw(struct cl_hw *cl_hw, u8 bw);
+void cl_wrs_api_bw_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta,=
 u8 bw);
+void cl_wrs_api_nss_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta=
, u8 nss);
+void cl_wrs_api_recovery(struct cl_hw *cl_hw);
+void cl_wrs_api_beamforming_sync(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a);
+void cl_wrs_api_quick_down_check(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a,
+                                struct cl_wrs_params *wrs_params);
+void cl_wrs_api_rate_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                         struct cl_wrs_params *wrs_params);
+bool cl_wrs_api_up_mcs1(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                       struct cl_wrs_params *wrs_params);
+void cl_wrs_api_set_smps_mode(struct cl_hw *cl_hw, struct ieee80211_sta *s=
ta, const u8 bw);
+u16 cl_wrs_api_get_sta_data_rate(struct cl_sta *cl_sta);
+int cl_wrs_api_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_=
params *cli_params);
+
+#endif /* CL_WRS_API_H */
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

