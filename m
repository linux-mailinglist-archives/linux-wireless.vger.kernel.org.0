Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E33AB871
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFQQIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:09 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230052AbhFQQHa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckZc/781DCOrFqqE0jIIKuHZmSMojbiei7F80DJWtkPFhbd/3srIb8htRcszO7Nkrykl+AC/U5kMBvhjXw7q4Br3q3nuOKSXhOuv+pT6Da7CICRPRMOJjBqKEcHKOXKIDTGL7sw434cta/UdgPA64upIv3fa1fsfppePmVBX4F4SAX4CCsdwvPjFnMexlddecOXK9NvwxkJnSnT+VSAflTwFQAtzfJSaFRYNJbrJGGV/42swN9Glgi8tB7ATZhWKv3/zsxDSgM6hEdNE27J9f75QrhiJ1z+A8IxbHGmiRSRPjWpF4EtdWwQ6dcQnVPI+xoo3vjHSrmTNP7Dgf6EaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etfMNZmWCpFrEeMEcPNt+/idVZPHJsMhDht15wTmW1k=;
 b=anK0O9eyFRFThI26mUTk6fak8adqYh1D6hg+1rLnnGUgXzU/z972dlVdN+psfBJya8+sxfkTj1n0DnH1GD1zV9wvtkeMTw69/HN9542DBoGXMQw/E8hlBSYYUch1uwT/fepZgB8WHHFTpN6IGdjEnqXgJfaaFs2Nz9tLki0qvEt81Equnv+ijgmslad0igZc7CyA3nwzDldix13lLNpI1FzzVqgc6mN3IjywtcB9GsEHv4sxkieM6fvTUktFpmekqc8e97q1mXn529nOoMQFLW/t5tT5Os2qUOtPF8CYBAxX/b9Dmau4nfyvvA7hCvQt7Cz7KqVRU2NmZXhTLV8tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etfMNZmWCpFrEeMEcPNt+/idVZPHJsMhDht15wTmW1k=;
 b=oVvwACEB2FCllHM75w02z2HoTtE1tp+IYtxQyfUFfHsVj/eyx/z+EfatWrwgfxQPEd99lWGmMlXw3aj083v4i6i8HctEXWUAll0yn07mdae2IKPo3pW/oOKQp0Ivp3b2XPuGlLMi1Y+GQvUyU6YPuhrnrcFcOxq0wP1Hriztivc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:01 +0000
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
Subject: [RFC v1 095/256] cl8k: add fw/msg_rx.h
Date:   Thu, 17 Jun 2021 15:59:42 +0000
Message-Id: <20210617160223.160998-96-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e31bb0-570f-4b77-b69c-08d931a98ff8
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887F34E661CB9D8DBF0A195F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8h9CdDd0MoHJVZ6whu4uWAl/xlZYkENXPz459eufU+tgoldyy9Kct2v87t2xinJHOx+SWqpCCcErrthlUIBBsO+elLkeF/13nKBYx0jIH7TtLv7jVp6/xTR9bV334mbRPev89kx8GXmBwj2ORXyR832759QAYaaM/iKr1XKnH8ivYNFvJpv0G2RRAY5bGlvSzfcmF6Hzb803qgXDpeN2v4LmF+ge0NQdgc9nDqTNNSwfBJAyxxGZ5+Vw08G8PAI4yYIOts/FLty23j9FYsLiLBOOK+hjf7KbXSsKC2167n13E6zZgeHbnRLJVHxe+vI75s+/Xa1X4gpMoi/WF+Esomwy2P8JCZx4umT+xWbR6/KpCIpVB70EvdxlKlkhXpkfn79zCHGEyTbtbz2F4kuxIVJ5854Nb6a8FbHFRU6MiWH8UqErvxo/kLNms7CKvze30dZd7RaH9g4W8+KIi4owu49CUjpYH5H7wAZMwX1ESXvLvRbtrSXFrHwEjUuVBBSrXa0t0vkzYcq8GKHrniG13XdPs8BtpiqCTbqnohN3qbd0oXZU2mHQJevyHWMMd/ssNYxuH06bHX4IAohK0Ul3MN51HfXgw1IhV7GzqDDCGtvnyh3O+5J80OkxapwpdSiz6URwOOmfJAPBDOJD2CVlrqpKC0A9b9+bYnTIgvG5IAfwTLSwile/uUmpi3lxo/W07LAYYYpsOWTNsWu+ezFNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RU5YKSgpkRemBCnnOU31ZD1AgkuXvyTKPNGLkyC913r7UXoVht18DsWI+NLC?=
 =?us-ascii?Q?ObsGBtL7VGpOLH9UlQEaA+mGxPxJz0vwOfNET/odgyqcpODFbmtdmqhPItQa?=
 =?us-ascii?Q?8OsLTXdwd0kQonImP0i8l+hBafquOqB6ILOuPgPbCzyNUBEGz2UeYXT73IiZ?=
 =?us-ascii?Q?OwyAhLoMoccnQCz0Aa4UEuXcJ4WG9CXOqrMW5RtWtghPZXD+OXPjOvWxTyZo?=
 =?us-ascii?Q?AhgE3EMd0UvBhJtC1B7BQxJ4ZdC17ggkn6MOSh2XTO6hy34bCqsrGvsZ1isp?=
 =?us-ascii?Q?Ut1ato+XIXRQBOU9Bb89ZcS08Vv3DKSlynP91dr9Wp3Z2/QtqmelhfKRuQou?=
 =?us-ascii?Q?0AEmYq5cS4wncqEohFnig8yyurin3OmjTUw2oTmnB4mMJj0h2sq1OeiUytfo?=
 =?us-ascii?Q?pSjyKYfsBb46Pu37rw+GggU0yZOSyZIfFW1w9220muQ6VmguajJMKxSh7mm+?=
 =?us-ascii?Q?SKBMjFbWktKizCbgN+dIdMYVlZT/DDh/qJ6G6u/R4noQRMPu1VhJurlwATw2?=
 =?us-ascii?Q?wMXfowjBluO2n/NE7LJ+lufzLkzqMQXfIChdJiychKo5FOUVGdpFeeqIagtb?=
 =?us-ascii?Q?D1uW2oYsT9SoYyQeHjWD6pK7rxW5lfphk0F/+wIVleZpzVBkga0Bp4KlI3Q8?=
 =?us-ascii?Q?rNncXWD12TR7t01ZS0AgLnXHoxUYGxSxkJ22WFJT3c/v4XNt6YZF1YdtLqAg?=
 =?us-ascii?Q?BWV3qwe1pwsDrkkwcvZaqicj0TXF7JtmL72KGUUyAyqaPwcFIpQVK501A2F/?=
 =?us-ascii?Q?LZ7+sq+l1e8nqMUOd8235PVCqKzcpNlNQowDKfyI6YViyCLOKtdwL83kXnDo?=
 =?us-ascii?Q?d4QWO+ZOqK2wBqG218vuP7yH9re8xAcJBQZsBeokC8xc1QoUJN3qV4QTBvbu?=
 =?us-ascii?Q?zV8kyvxIPsB5lUCxT+3IWBQ2MfUSHewlej2I9B7sbuMayVN6LIajOh5NQU8W?=
 =?us-ascii?Q?JelTAhxueK6F1hbMQ/u6xzwOClLipOsGcriN37y6vFz2KwtTujKsARe1V26C?=
 =?us-ascii?Q?tD5Uix23fQ6rfRtKzYvgN6JbqrbgQyrTYF7kEuS9BfDz1wVM2veQ47pRAV28?=
 =?us-ascii?Q?Xv2RC4R90r9rq4gX8FEcy9M7Vr2oq+oHo322Ni0R3LNcRQuVRq8s2g9y6vaH?=
 =?us-ascii?Q?Er0/dC8Va/JTBxYsx0SzAKfAxCmqHnHY2gMSoBf+H7BMxn9U3vkCSCEzGHPD?=
 =?us-ascii?Q?cyRy8H6sWEfVbgyUWcIb8X83eF+OJZdE6OYaoCMxrkjhzHL/tLT1LwXzkPW+?=
 =?us-ascii?Q?BOHvcUKtoZr1BRGl9dgp9j/5T5A2dFAm9bFUUv2IR3k8qIYpy84gibpRsNWc?=
 =?us-ascii?Q?ZcWSvqmC/Mm0QfxiRBlnf1zZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e31bb0-570f-4b77-b69c-08d931a98ff8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:18.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FSphe0JAjSfXjST2VPv9H7NBymBqDey92pkYp9MDFGDJTElQHcy0eTjdBO9f6UNFiu/RgS11teFU24hwnrs+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_rx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_rx.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_rx.h b/drivers/net/wir=
eless/celeno/cl8k/fw/msg_rx.h
new file mode 100644
index 000000000000..14d971e81db9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_rx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MSG_RX_H
+#define CL_MSG_RX_H
+
+void cl_msg_rx_tasklet(unsigned long data);
+void cl_msg_rx_flush_all(struct cl_hw *cl_hw);
+
+#endif /* CL_MSG_RX_H */
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

