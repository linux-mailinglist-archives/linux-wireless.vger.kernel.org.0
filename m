Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0393AB89A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhFQQJO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:14 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:19069
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232814AbhFQQIH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDFYadmIiLfkRv0jfBtW9MJU2P1V+5qVzOWqdrMKu++XprPK0Q4uZxhYqQzuR7NUJ4O9raUl0SynHdq0MnoOAdQvCLGhb0f//Hq65YCcfsnn6rktcGcKYd+QqawH/2NAplJgIIxrf5/r1fG09w5Ljb8IlAu1W7X16cTdAiZVwZjtsLIDujLnWNhgvPVpfzJRL3DkZu2p1iU3yceafJbEHp2ssJezBWFkIf+kOgkDZLGb6IVru6K+G9+tm1ipm7qNehXUgilur5aCj08V65OmziFRQyRiwiohqRgokWzN6das6jMKbPDLKaR8CJCskbYFmdzPs8C4u4tDEmLbu9GlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsd/tWttEicSgL36ihpBifY0skpHjT6b8B6o0McvBhI=;
 b=W4Ni1dsc2F5jMWCMujCKq5APPhzVg1WkfbQz+uAYQXKmBZglgg7UbR969DQIawllfWorhGPiP1pYZ/HfmNtRdv4VboD9AW2y98icFozCXOOaeT+aukueq7weHeey9IkAjW89V10sWqss/yHo49Dgy3Tn0P/z8/r9X2oB9K2dhd60tBLvEoiUN8Cp+WZSrIMFfeJnrfMyd/vnaVjv0okLF+l9d0vQ8VfUrkGBGR6ND3/rOUNxFoHdXzENKKG8ekHy6dLLEHPk6XvMYQjfipUZUU/EXmSrcKbzJOuK7s7CATxjLS6gcRiXHbGP8nJcmN60F19fJ2LmyBGH8NjxUaQKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsd/tWttEicSgL36ihpBifY0skpHjT6b8B6o0McvBhI=;
 b=TgoupZ8gsN9d/HdMDJU6jtQtx+fwHprFyUHqM7LihCkpB8NsSFYszVzLNWneyrT43/lE+xnuDZ8RErbqA+TLHiEMQBy6uwSR6DtyfOz5thPz6ZEJxEY7mB68OTscyWT0PeQ8F2dcY9qQQbjTUKrT4tmr0JuxpRnnAGygR+1dbUk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:04 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:04 +0000
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
Subject: [RFC v1 101/256] cl8k: add hw_assert.h
Date:   Thu, 17 Jun 2021 15:59:48 +0000
Message-Id: <20210617160223.160998-102-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f5a8729-f2a4-48bb-53de-08d931a9943d
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08876D5160F1610511C70C42F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KM9xAyQea/QNDv4cKiGhlnPbUDCFNnTsATgA2XShuUaGmRKOAhGMMFzlYPgej8Kcwy8wsB4t8FBebbo+Dw6Dvs0KhpK5KcH50vPelfHSqa2ypHwIaNnq04CDGGJ0yGhoHqq6tgmUgCBRz7qwbmO35O/IxiDgLCbxh1fZeO+rWQFJbW8JoxysIKdVdmA6qEpV5tCvdBrOkWtDyqeE9SOlFaghL4BAmrbN1r2QFG/H+MrJtX+j5vhOj5j4gMCExagCD0tECLhGBnhOjoMYRGzLZUmdEKBLaJ0fH/xsnYq/DaWjz6LhI7AZl1xQTNFtDfklYldP55HVFCDY6c2nHMi3a51p8ez+1vgBwsC++iI3L5Hk/SYoJ4dmrKyrsIAui3Z+gJ4MKqqPIhDKXElHsrrPuvZ4h8K2wWf3oAvU5FQHfc54mQL+yM7pdyBqflYNJDcNkGb632rbGytoo5hmGy9RRGBY7ueGFa/oIMAacdma9BuGZYZV60jXMYCW8Dusvq6zYVQdPHHytJqasvZFNzdY72qfRZcpRM2tBwnHnOIhebOqyQoLUUlFqVEUIu+jMhE7QFhSPr3Ea7Sq1EXMInaswmcoGNkuG33AajCvkCRN9YCe59NJoinQ217UIEJ+RLAXWUuwoUKGi0jGgOfA64qpmLQlZzGZlQV/omaI1lBdqEI8oSTWddFX9TuBA7SBnzdW5CHzoCWQtLskwzdHQEpcxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v27mTIl31yTVOC2PBoc7oP4KQZbeHtRAGi/Gw5l0yqUsoGpq6jJsmIq60wyO?=
 =?us-ascii?Q?Zi1/U2dAjkZL/chSrhudkKhRKUvJmtMy5MjXRXPZslHB7WglI+xxgnYOvQ3P?=
 =?us-ascii?Q?v9/NFy3gwUlwkTzifTVviwas+5l7wb8mareTJL7q+j4xFt1FIrAfyYRHrJ70?=
 =?us-ascii?Q?KaXKBFlmhu5QtYtX6eAKqy0653qzW9JMEpEsQpQLbSvfKaQg7gtw1OMH7bsG?=
 =?us-ascii?Q?56ySEK4gJuudo/npPXzZTfFE2wloVqUc5VZ2RqxCE9U8fDDuOq0xV2fz+Bv8?=
 =?us-ascii?Q?DQpPImG3feQxCVaGs3WMPZlxZzme1RpnbMkWhBAxR6APMNnN3WYZ2/+OwV9W?=
 =?us-ascii?Q?PSi9RdJdiZXJJfFAxQNhZHaFs/NcwLMg0HzJczM6PljHCzmaDD8LvAtm9Rpw?=
 =?us-ascii?Q?QFgW1D1anUYM/IvRsSM3eGg4zVu4GvpBt8C37ug3iI8i0dfVnwAWIAhNvBfE?=
 =?us-ascii?Q?tmlqH0lHs9TbVrC8yyq+cllh5UjBVPeNpG2xlcFXKx2GCk9Wr6uEN79hynre?=
 =?us-ascii?Q?qELD8eL3CxPirQ7dk0BHbUOyzX4YxGPP+cVVYScG+qi44Z1yQhYnYEM3/oNV?=
 =?us-ascii?Q?7xB5A3IiaqQAGpWPa+ptwI2vMeVtvtuFtQZIKOKCYmGmp9rBHDChBrxtgjP8?=
 =?us-ascii?Q?RAbEYx6FWtmi75kqxUQlWaJ4GCtcWtUa7+JXLZoNZOd9MjOGArj54lUP01lC?=
 =?us-ascii?Q?skKj71wrdFSvBwDL+3H21RC7yujn6HEtA2jiPnkisypYFOsVHvX0XYRqlfgK?=
 =?us-ascii?Q?6rlPjGHsYRqbz0T3L6NuivGcfztaulII0JKssVWXNvsvPkoWCQi6Wpw15TEj?=
 =?us-ascii?Q?mthPY8rEYYhs/TQaWeFfv9N9aUnBPkBebq6EQJeuRIP+76sGt3mT9RbiEu2g?=
 =?us-ascii?Q?DQFiKJ/GYE4b+pUjOoBat6Sa1ZqXXkmaq/jInnALjmkhRN73ojJcAsWiL84n?=
 =?us-ascii?Q?wb8Tpsy7PkA037QVNSHMihLpaA8qRlontLyalFqZAiaUZvtcCmi2vyIE3cS5?=
 =?us-ascii?Q?lhmO5d9woosPDPkL8wlgj7n2ChiujVP6Ha+I7crTd4j4P2Q/G0VT5tBX14Pn?=
 =?us-ascii?Q?n3Z204APavrTRr+avlt9Nn3yfxQ1z2S2IeOEUKRh5oICRtBLWBJpnaqMuBqX?=
 =?us-ascii?Q?Qh+cyji6dkc368RiL692uwTycooWlIoSO+jz9SDmFBLOlmWtmMiegCR1oTjC?=
 =?us-ascii?Q?BilbGveLx405VxwZMUu2J5C9NpFEMuTO5cCJSsk5md72mXhkuGqnlg2esg97?=
 =?us-ascii?Q?kn6C5RDysNVtKC9Qo3QTYGSiINbfK/aQ83g9yK72dkSSPgRGL9vCbclp+6Ge?=
 =?us-ascii?Q?Idu2+ANR18xPohY96nMW9f6T?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5a8729-f2a4-48bb-53de-08d931a9943d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:25.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nnq68JtuwdOVpEk8aMlEeGE60GsHzR+MgF91/dLfV8HUFZlkSK/lRJSLEA66p3/nDmV8Fd2lNMryCxM08t8ifA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/hw_assert.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw_assert.h

diff --git a/drivers/net/wireless/celeno/cl8k/hw_assert.h b/drivers/net/wir=
eless/celeno/cl8k/hw_assert.h
new file mode 100644
index 000000000000..0033c2f5025f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw_assert.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_HW_ASSERT_H
+#define CL_HW_ASSERT_H
+
+#include "hw.h"
+
+void cl_hw_assert_info_init(struct cl_hw *cl_hw);
+void cl_hw_assert_print(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg);
+void cl_hw_assert_check(struct cl_hw *cl_hw);
+
+#endif /* CL_HW_ASSERT_H */
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

