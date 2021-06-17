Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9313AB8ED
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhFQQLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:15 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:65046
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232255AbhFQQKE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETqkrUwoCGIygnNks+BWJNJNTOy9FSRwt2tb/VyluREeKmqgLdjnBGxKwxACS1VrQqzVgMW9N1cYNrJ3do5RM8OTlrYsjwv59bs+yiOLT9drsBs3joyhUdQ+G0EoLy4aoBHKWlfldrZwEjzubfkw5R7I/nOLhfFfUrtKGheIAPvdRxFD8nVeAKO6Alah0K3bAD7fNsbNaSrJhHVuEKmVtXzbK/DdZDjay2Wu+t5d08GGZ4LQ7KZUw8fD4UzsIBmaH6N1qlVIpnsdGcwN9kGWPj7AiKjZaTNiGfgUWZADEHwuKjy1GCjyctXQHWwP21Jfy2mto2SUaJYDyK6V1PMoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQLjhgFhaAYMAivOopkZ9JG1JP/LDxIU+AslmoaiyDQ=;
 b=N3oHu2T47F8XIG6+rQ+1a4+Wx35Dj6Irqh7wqeq1tG1UFUcJEAOk7LJTzDNSXT8b0tOzn0B7KCHAbhXGn5+DM3bX0n6IpNRwPImKe6suiQmUX2AhLrEvtlSIOO6FU0p8Eit8XhOwj6thSULCTyZNadck9MOh8qfFIkFdVSKJKhwmD5VOeKgRrqDVW37PGIeeRRxmfl5Hroidmo0WxmDOVBHy4ZiHGfKFShZbqLJUABBeGiF/ncDWmKzjwdSnP1V3cdhvKTeuTX41w5QnE7QWjQhfsdmD2Vk+1YULOJnHX/L7ClBJAEupK2MSPiVcyJx5tBg3KdHh8auRp/GqITT3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQLjhgFhaAYMAivOopkZ9JG1JP/LDxIU+AslmoaiyDQ=;
 b=A05US+YZHrzDHO0B0LfBrcKr8/2tbhsu7ON21+kFby8V9+WaVK46ippozbZRQ1Ilc0jRvH4UEEHELXXt4+SWVFQfoNxin31ToYj5sVIY+rnDxZKxVbPm8L8z0CAFFcKNqXfo8WPSYAi005QJjQ8sCeT0bevOFcah/qeYkI3wj7Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:50 +0000
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
Subject: [RFC v1 211/256] cl8k: add tx/sw_txhdr.h
Date:   Thu, 17 Jun 2021 16:01:38 +0000
Message-Id: <20210617160223.160998-212-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef89f133-ed1f-461e-cc08-08d931a9dd00
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329E337B2B3C52C8697BB1DF60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mgsLlMfJXx/Hj0blycRdmTEAJKPh5fSN0NBcZJr5ycT0dCorwvWCMvFVzwh4hTj9uxoEBFa408/2oM0rV/t7zcVmGmkGdBKgcJG6ipCP92lV6epSaPXzNMyiqiGuSY9w7D5I/58LbHwGvqJO6PM5TebyNt7IjRGvYMVOrQFki+Ndh/TTv7795sPkjJWjKxQI1dE+tJ7I9/fnTXnH9XGDooWcXPolNq+H8VLRO/pUnVeMk7lZPSixZFQCbuKRmG5liEWHc1n4HM3NFFXKu89+XXKLG5RiU+8F/ggdOIqizc8P5RmwEOOK69CKtjHZimdLgBmkfedhdgMmw3qDfAkQJZK7p1vmOM4T0/mLR8f45vPtC3o/qTBAWKpJbFiFfsdaAHGzvspVp2nz063W4s0l6KQXimI9SQN4cidVnRoufCLIJNprA1dvrUZQrMBj6A1MDt4mQtWg5gPiS8btZgo6kzQeM1PUt87hGnwUvsj7NGapeeRJSAVPraM5z/ZN2ysbFUiwMqdTcDYsiJZGeSBHY+NAsVMrTtq+A0NQJ2Uy3XeSUfbsZganoYfqF/Rnm6iu1f6ccFYmnqybxuDijLK2jJm6m3fwhMjniE73EMeWiysOeTLutj062uw4PX6+/aVtUKwu7or764dpcg3YLwTNBq7H1UQInp1Di/hn7OINzv5frdiv/Gm0GhSQRgWAFwuZnWHYjPB6b3sfcnxXThFTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70giLZhyzvOIFibeAE0373NRjRA86W/lZiMYo3Bq09wCor3qS+yIdCWZK0Oz?=
 =?us-ascii?Q?2e1lNzGyTXY8JMe9omMaAsOpLwP+rrtH7OxUCvbiHRbg8bZN6tcXXTT6DMiK?=
 =?us-ascii?Q?KMApzFBwkFhBu9JMJTnk1KmWlkEhCQPItNgBwPV8IkwuaYcXFBZLgChHZWCQ?=
 =?us-ascii?Q?F0rQcC9l142u+OSeQZiAotfK2zHlfs3vpxe7Z6fzHaniWi2TBHNtMKZtZCZY?=
 =?us-ascii?Q?ZtOni4eVL4/qGOOXmITZqoRlvY0s9CulQMzAOjACA2tAR/6HJZhWM20Cwi2g?=
 =?us-ascii?Q?PIm8qIRykWVjqWp4C4/MQw4QuM8Do2sAiZuBTLn0Y0Fpr6/+dlnr1jI+6YCx?=
 =?us-ascii?Q?/28SQa92SCV8m0IOFVnyNKL8N7tbzoFh2nn0pJ5b4g64f80foKqZ1lZnB4e+?=
 =?us-ascii?Q?O4bDk/CVep791L0ulIXrvA4Tab6Fl03F6wT9f8e00bo6prme2VMnUaAVa1Lq?=
 =?us-ascii?Q?S7WuYELticEv75WIyCWXlfO5zoQ3CLGpgS07iEgcR9Vgvvugo8gc51GjmGqi?=
 =?us-ascii?Q?WXkfYNjxxVgQoNmw5SOFPuQKg6TzU5IgacWxkQQmBw3wguvgctMwNKy1duDO?=
 =?us-ascii?Q?vKI/fDjJLCT2GIIX0Yu0TxE0omKmw/w72SklTvjZBQHquYGXk6czyVZD4cC6?=
 =?us-ascii?Q?HVoI3ahqgzOJPYLt+YNRBmFpvuD9EugHpEiUV9uWd+WVDYXoHtQFsJuC+chm?=
 =?us-ascii?Q?Mz0p+Pc2QrMCj9eBIUkgGbGIfzsxdEEF9tEBFYY3n3uweNeVE+iuYQ3XOPZy?=
 =?us-ascii?Q?7ZSsnAlmrRR7p0THzFzZwpQ9h8Jj8WWn0Er/n6JCpA+fhMVTRXyXEuAODNLd?=
 =?us-ascii?Q?X/HNT+5AgCZykEkJxuWzzqmdo/6z2GW6sGuOVuehDAX0ZQ7b7/nz7HzmQ6S2?=
 =?us-ascii?Q?0H4vLdKgP+B57lAcmsZjUkG3jNiy0PVIgkPlCWavM3NXJqFE9RQcsN7ebsnc?=
 =?us-ascii?Q?zQoYgEuifU8XLUhoaPyud9+g4cK+r9bdvw6bnSeixnfsvstPqAkLx3nXlEEz?=
 =?us-ascii?Q?d4cAuLfwhCX1S8hFK5z17tAoi85KHTGHxrw/8EdqODTHC3XqDcJCi0Y3Znwm?=
 =?us-ascii?Q?YsEgspPGfMajbWBd/LdgqzHMpDr43EE6rYy6gYNBsgclLwtk9ieWUZjySGHy?=
 =?us-ascii?Q?eo2neFLoFVWnwBfXatCvFalS3tPVHwnUSLe9eC8G3MXkCnx6nf5WIxk7Sa2S?=
 =?us-ascii?Q?5ENRjRq3U7COzshAxyp2qUGY9d+yBJKhg/Lb+cutw7CU8AWEfdMYjgWaEGpv?=
 =?us-ascii?Q?zCun266QFTldInLNsQ0SX431SSKXSZN1cvniYwIxxwA098a80gbwR1aFIb3r?=
 =?us-ascii?Q?vkz8Yvdhs25jd3ZdyFXX+3Yh?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89f133-ed1f-461e-cc08-08d931a9dd00
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:27.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKIXTUjmR6stC4FJRRLW4tG6Z62UH6r3gRDkPXyW2YB+dQs0/L+R4ddy2Kk6IV/ajmnxZmo7Rxz60PY4MkDGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/sw_txhdr.h    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.h b/drivers/net/w=
ireless/celeno/cl8k/tx/sw_txhdr.h
new file mode 100644
index 000000000000..3374439b0de4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_SW_TXHDR_H
+#define CL_SW_TXHDR_H
+
+#include "utils/utils.h"
+#include "tx/tx_amsdu.h"
+
+struct cl_sw_txhdr {
+       struct list_head list_pool;
+       struct list_head tx_queue_list;
+       struct list_head cfm_list;
+       struct ieee80211_hdr *hdr80211;
+       struct cl_tx_queue *tx_queue;
+       struct cl_sta *cl_sta;
+       struct cl_vif *cl_vif;
+       struct cl_amsdu_txhdr amsdu_txhdr;
+       u8 hw_queue            : 3,
+          is_bcn              : 1,
+          tid                 : 4;
+       u8 ac                  : 2,
+          is_sw_amsdu         : 1,
+          sw_amsdu_packet_cnt : 4,
+          rsv                 : 1;
+       /*
+        * singles queue index used to push the txdesc to the ipc layer
+        * this issue solve race condition in which we
+        * CFM of packet that associated with disconnected STA and has inva=
lid
+        * cl_sta pointerinside this struct
+        */
+       u8 sta_idx;
+       __le16 fc;
+       struct sk_buff *skb;
+       struct txdesc txdesc;
+       size_t map_len;
+       u16 total_pkt_len;
+};
+
+int cl_sw_txhdr_init(struct cl_hw *cl_hw);
+void cl_sw_txhdr_deinit(struct cl_hw *cl_hw);
+struct cl_sw_txhdr *cl_sw_txhdr_alloc(struct cl_hw *cl_hw);
+void cl_sw_txhdr_free(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+
+#endif /* CL_SW_TXHDR_H */
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

