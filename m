Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E03AB905
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhFQQL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:58 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:23879
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233665AbhFQQKn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEVy1t7h1x6f9AkeWJO2le9B9UUYPQLLjFQjDXeJ4X99p7ZyksPT2ea10M7NWuNRIMvNDJMJu/ig7LV2TzMgCIDCiNfly38wsgd2XjwgNYVMn2fwue1Ohjhwsgq/q0eacBTl+8LgQjXxRFVPKzdHAkYE0KRdca0EZCF2s1OvUIVL2WnQyjVSq5wuodtIfa+o0f1C1ghAHK6712uKu3+EgCzUfYhTrTLfLPPjpmlS3SNA0L5H/NdIYJHG9kzk9ofyAtKmH1bNlTYlKVeklvIjYab+LiCKD0NH02Y4uGBNQD+8xYQHJh1mJ3T7G1n9gzECe1nPBirnEI1Tm6NnM6L50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35un+rNf+NOEcOR9Hcc+B0bQXkRMA2UIw2ITW3J8fbQ=;
 b=Z57RsY+5kffQGC/Z0VI7kHIC2lenLyeCnCytA6HH2mR8NDM7tuYIcljw9OcSIgV/8229qY7Wri0O1nz9ljBCqMYX2gU9W7oMFbPFu9ac96D/95dbHHnxTP5YR/MClb/oCbKVd3WsGJuipDlsptb1Ltv+wG/J+lRl9rd5Uxr20N7lYgqeyUOgZCx6spbxzdcRapuUs+UUXE/L8a6YCoeNv2gfmUvCLyhVLy9I+WYajiPB9QuSUXt/SmTO/mudM5qB9NgKZl7ieoIdC+0CfsTTk37jdaNcHKzEe1lYyP23CSGGqfvODOxmozetshpjz68AsaopjrZGnz0I0NAeGWVB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35un+rNf+NOEcOR9Hcc+B0bQXkRMA2UIw2ITW3J8fbQ=;
 b=dJzy4+x+NYbRo3If3IabUIDmPs6wqcKAwCB0bXxnUv08hCo0gSMYruSjDAMmolG59EMHqyW5kl12nAiHnj+uIBGuRTD/7mcQDYv37LqcZkUqM3FMCVgRQy8/8Uo7EWXxvDS5z2HQugp4AcVWWAf7/Qnm2qpgjHioleWwoT1urxU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:54 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:54 +0000
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
Subject: [RFC v1 223/256] cl8k: add utils/ip.h
Date:   Thu, 17 Jun 2021 16:01:50 +0000
Message-Id: <20210617160223.160998-224-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff5074a-cd1d-44c3-356f-08d931a9e656
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04528482275F946FB73EFC63F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R45BBXE9u8LOejuHnqfRHuvkMPFCpNqClBXCtw4y7ncfNC9YOA4Juews2fi8vqAmNSxOU9PVyzdrQqG/j8dj6Tr1anNibu2WuA0e0SqKMoYBsCWt3NcKrGnbQBIh4cWGexXeABZ5JZber+GBbOgw58/pcy0s2Vbyfu92i3Am1ONJDheJ5up5EpA5nGg94dpu0ySAl4h/L6u6/EMzQyEOrTl7RasLtzkajRRCb6NomaaM+FPfazzXRNwoOzGUk1lQFW8CPNU7Il9mt/ZXLrIvr8PQVF0VzSuK41lyiSsrxcQo4JkAJUrYblwqFb63oO9KP3TRTolwWX2WX3aqYJ9JuoG9HKtpBWtW7vmqCn3xfBMtYHjfGgFvprnL6IW77YlbxO+KFHqlw7Pv15QpNWRbtvWXYXSX0vYIvjUeInGEtO8LZ5oliTJj67mfCZ8JxOe5jC0TGlLXyk9pxbDNqi7SP/TcrCBZdRf9dVWZ4eEvFEyvqGeEYIvsmJhXcK7i3jnONBDZ66iN8NbTBTXUTd9k0AjZyIuaFoYhoSBkl22CQd9KxvmPYLGWHn7/uXmUXCb1IRK7JQWJ3m/ff3L2+qFxW95AC6GbtEP2djMlntC7Ogt+XGzX2mrdEMjBXPYQyUpaqbaOF69FOZoTxyfbSWzFe9SZgT7VEIjpLdcFv+qWAEOB/CW2eWGIcEM+FC1S7RTmn8psXtk2oeE0cr55kJUjYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ge206SKfNTAPVERYYmsvuwofN1MiRlipTCe5AY/ccGcGqnvbnuQLIEyWsKx3?=
 =?us-ascii?Q?BBZ35JP+tA8nzgmjFb7puZbwYysDQOZIqvMy3bGv3KYA59b2EokOkguGzsp5?=
 =?us-ascii?Q?rA6CnJK55lOuJK5yJZE14Kn1qiYJuoBxpPz/9D2FxJ0b+PxSDt5nhbbhrxJ4?=
 =?us-ascii?Q?at1gX7UudF6NDmiXWg3Ocv8gw3NouBwobprOL0dQhoU8gD+Lc15zE45lZj/E?=
 =?us-ascii?Q?tGKNZI2KTn6MaGWq9IVAM0JdI8Q5C4eF7BqrpPPLs+1vlzsrsJCkfp7GzprF?=
 =?us-ascii?Q?sgJT23KTdQ+nTYQcGlLaDvbOYqHXEka8LvwrnYza2hyLMd9bsoQcnVdhCJwX?=
 =?us-ascii?Q?a62aR8c+cjDUjN5R14QbNPHaeMM4vB747aSuHKemx6SQuo91qiFhpDbhFxYM?=
 =?us-ascii?Q?2xNVmTP8syTOpczZGaZej463vEnC/O5wFAOJcMbVEveocWGWl8HAi3WV3cYA?=
 =?us-ascii?Q?aS1zozGKSOCyBAqBGC7t3XpOqpDYqPReVnY0JlTvHsY+fJDLglredPHzdsaS?=
 =?us-ascii?Q?1O1VWhxIjHC5fa3eYnvj2Tpe2lKEZbzS79mJM6iEc+6jkq0ONuCiuUlFRL1o?=
 =?us-ascii?Q?F8R/qjbHcSOX/ad4Jzz0hC193w2HjeBJoYbQ3iBzFCl9ip6UkKzAFWazG5zM?=
 =?us-ascii?Q?C7Z3zz10MyEwh3ei6zFpkxn5LLrX6icIFFpZ/lmmugOw0lbKh3lrcK+GeYjH?=
 =?us-ascii?Q?TWtJrUM9D103zE/WZjVWVExCqWKkRHC8dWB1zyNpn6KxXJ8fcZvv8I4Xv929?=
 =?us-ascii?Q?nGfHhQNXN6AYSFASFIHy7VxB/iOtLoOJ58BU7lyL+JEXn4n5ETDH0kXv1XHr?=
 =?us-ascii?Q?EiQZPI2xx3W/HBI08ummMdk77kATx0v9wuqanKSjjhbjCuR0NmwEuIgHx3yN?=
 =?us-ascii?Q?xvBjO5/tsfF3y2SwUq7TjnfHq4WCtQwNuVIbHtSJBQ6sba14wKfknjEnnOXA?=
 =?us-ascii?Q?p5KrEgSn9hHOCpazDHIhD4fFx7O7XKQx4D9B+7MctRIrMZMKs+SBavPygEyj?=
 =?us-ascii?Q?fwFtOGCktGRgykwfZCHuEFFcgbZJsgRwDNWAoDhkKwBjU+WrP8vWEnaZ/DsQ?=
 =?us-ascii?Q?TZA1H3Tryg2E2jmTkNfCpZoZg8VGxmVYsqIZ2IElhQkTcHgP6updRO9iNSup?=
 =?us-ascii?Q?hhOWPhzyRMI0uPc4k3IT7ua9e+3U7iNoCS13B34Cm+Je/AzMMtxhxww6dpjE?=
 =?us-ascii?Q?+bQ5hSt3YZ5NTfV7Fc/ZDxtSesG0shUhGb+AkLy7rClv1uzr+JJaY9NMq+J5?=
 =?us-ascii?Q?x5xlnNT/VZw9CzS8yFe5py8ESVp2t2pBG1B/sGYgFFtsu/IS6wbduZNZiFO2?=
 =?us-ascii?Q?qMCRPGQFFI/hDK3CaOSEGsBC?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff5074a-cd1d-44c3-356f-08d931a9e656
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:43.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyvovXk5nkw2cLRl0mmwrY7ESKnLkS+IrUjesJf6KyyrvIVpdu33jkt1OS48hJFL6nY2aC5jQg1eN7ZX5ciNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils/ip.h | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/ip.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/ip.h b/drivers/net/wire=
less/celeno/cl8k/utils/ip.h
new file mode 100644
index 000000000000..93aa9fcc2384
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/ip.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_IP_H
+#define CL_IP_H
+
+#include <linux/version.h>
+#include <linux/skbuff.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/if_vlan.h>
+#include <linux/netdevice.h>
+#include <linux/igmp.h>
+#include <asm/unaligned.h>
+
+/* Check if a packet has specific LLC fields e.g. DSAP, SSAP and Control *=
/
+#define PKT_HAS_LLC_HDR(a) ((a[0] =3D=3D 0xAA) && (a[1] =3D=3D 0xAA) && (a=
[2] =3D=3D 0x03))
+#define LENGTH_LLC 3
+#define LENGTH_SSNAP 5
+
+/* Multiply by 4 because IHL is number of 32-bit words */
+#define IPV4_HDR_LEN(ihl) ((ihl) << 2)
+#define TCP_ACK_MAX_LEN 100
+
+bool set_network_header_if_proto(struct sk_buff *skb, u16 protocol);
+bool is_ipv4_packet(struct sk_buff *skb);
+bool is_ipv6_packet(struct sk_buff *skb);
+bool is_ssdp_packet(struct sk_buff *skb);
+bool is_mdns_packet(const u8 *dest_mac);
+bool is_ipv4_service_multicast_packet(struct sk_buff *skb);
+bool is_ipv6_service_multicast_packet(struct sk_buff *skb);
+bool is_tcp_ack(struct sk_buff *skb, bool *syn_rst_push);
+
+static inline unsigned short get_ether_type(int offset, unsigned char *src=
_buf)
+{
+       unsigned short type_len =3D *(unsigned short *)(src_buf + offset);
+
+       return htons(type_len);
+}
+
+static inline bool cl_ip_addr_parse_str(const u8 *str, u8 *addr)
+{
+       return (sscanf(str,
+                      "%hhd.%hhd.%hhd.%hhd",
+                      &addr[0],
+                      &addr[1],
+                      &addr[2],
+                      &addr[3]) =3D=3D 4);
+}
+
+#endif /* CL_IP_H */
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

