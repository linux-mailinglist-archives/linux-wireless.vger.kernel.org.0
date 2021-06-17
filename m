Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F013AB8F8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhFQQLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:30 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:60643
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhFQQKM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usnny0jZgJ+2Jw+b8iQZk902sodwkhmPvLK7A2V2QyZwKqnNXykEBk6khvU94aCQ3mv3VVO5KzKiMJnju3+FKZ0sH5CBXWYELtPeq1BXqhQVelmvLGGtuYUtWzuEadTPp4Ya0jPo8vOVPM6DrOaCj0HXi8qfd31VwJfGFVh86N+V5ghLinRblwR33lxiZUDcj3iwQcNpL29bQPBW9E4J3Z5WT4l3y9eJVkJjrf6rrYhj81Tru56eHjOYSaHWaYSGmmn5KZjUV2EZfKgD76qtgGNsvzcSJQj13/BbE9YfBu3lyQM4mHmRsf+uJX+eCbsLn5bPIeggdms8xIOc4LmZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUnunK+aZeSmhy2EuP5BxB+z9b8cJoezc0c3ac/9XT4=;
 b=V3fEanBX9CV98CCao8cEowI/widctLJfX2KUHUbOWxQN6NyXAtrMgkmhSqhowgS+7Gj4SgvlDX9rsCvxb3Smvul10ox6LKvYokU1MxHvg3jY2PfhL7y3I1jbtgXqKzHlupl2IQX/pcDFpSLOkCmpIBX4rqhuMkECcL0X9FJ/k5HIv+rU+j6hPaLdKmSOLe2MTMMJcTEh+nkKmS6Fd7zuAFpsyliADhXeBY2GFFmljvVzdf2LsTOMOug+U36w0mfbj1/o014E3SWW0eyptiV6FEHcRMSLng1fApTw63uTLhdTh4abcfV6k8n74/UtA3Vkoiz9t6943DxDpJKgh/wVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUnunK+aZeSmhy2EuP5BxB+z9b8cJoezc0c3ac/9XT4=;
 b=q8se4VBCEWgoTwaQ7ygGNmp5QjZl+i4kzTzIvi7RvKPM3PgP+hpdnvv4+hygYz35R3TukFmD+cpIiI/bjSeaPtsVHLvdlJ0CkbNUOtxk5r2SP28z7Lr+B0hgZThjaCrPJeiHGVJH/ucLRlR5jLb+oF3yDgKRqyZzd7MuEGuFVQM=
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
Subject: [RFC v1 222/256] cl8k: add utils/ip.c
Date:   Thu, 17 Jun 2021 16:01:49 +0000
Message-Id: <20210617160223.160998-223-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7e5eda-488e-4516-0bbb-08d931a9e5b3
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04526BFF9BD7639CC627FA8FF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHGY+JHie1g4qUxPDu8jo0gch6sM2a9UvCN9L7JzPO2hBYudQhyfYS66I90Rnt+cfFMo3bNYRZ9DQzolUQZpWf9aK3+opH++M5/+rgpTk6U2pQcXjv0Ah3sXW4qfhXS97tS+2fP9qtE/oCrTjKdI1dJyAqo3MGaYy7+gq1UJkYEWRt6r4BSzoFCzPQ7ZoxQFIspxmZmZzVQtaGEsfyV9MbrE+F8aRLafeo5mI1kB/xdBQ6lPLb+gBK5pQCiPAHYVOy2NtNstyvohEWf3Pk0Nm0eoMj46B+rHQhrUQ7mMkWCox3z9u2fKsoONuQ7tPo7KZOQV1WlB8lHVGaFGvzUjj5eSadcgGnz7+E11s3TTadY03m5sba7Sxr4atzp7S9oOFr41Uocybq4x+jqKdDdBCuMXVj7XQq2IC7krwQx7/ngiDnj7mVPYSN9q2R1BnUnk5jrU1tlx+VUBTnO2fX1xQGi8F14Fjws1FM5S0+pfIioC1nr5gyweLcocCjr6j7LNODwhun6l47GjuUyX4jTCWIoAjvWxdvhP0/ZUrkcgnVZB5Xto4rHwvnxUlyMbxzitUaWVf1WnKBtqvKW1503oKzpEOFgyCRIm55SSnGmVmv09Ew24W78qLYdkkHCyFZuJ35w4B4zkmvepN4aN7fWxnigUJ/XCnrdrlKD0SFFmJLAtF/m5cpB6+pa88KB/ZBGOzPMrY0qRj/fcjnKjD0VtWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w86lOYrVOG/KIaTCGCUH6WmSbUe6E7ZZ403kpIiwrgs215hIcWfcpFU+8m8n?=
 =?us-ascii?Q?xDUh2U7kOspvB7ILrE/k3ZPdhPuT2ZoMN4suCH4rE7U9TMmXppb6AovsSzdr?=
 =?us-ascii?Q?QOPnsH/kK+HRjlzSzAYx7mgrtXGlm8C2Hl7CTA5ez+SF0cZnzdpL4xROSDJP?=
 =?us-ascii?Q?SU8F3CmTyieI5EwUwJMOy/nP7A87b3SjyUMRTamNB/jemDl/MqcpzGqEMxo7?=
 =?us-ascii?Q?LyNMmMvO0nugC6XQnRwqdvZAld4NdTJwFxJKAHT9r2OxxmSElKrQEMhZp5Xt?=
 =?us-ascii?Q?7tMm0jBu/JOdm9Gtv0vapuZjWOemVkxGqfp9FfccLi3MfqMRt0opElxjynQH?=
 =?us-ascii?Q?pkXF/0PA+E+HVnab/CyKPmW/QQQlmVD2rp6Gqmbl+puhx9Ir/WSSu+rEqybK?=
 =?us-ascii?Q?cFpy5HMcDSuNhtO2FR5Qug0cHbGUHnFV5o+ZPdRBMY7XFgHbYoV/vSxmhuDL?=
 =?us-ascii?Q?t0IICaNO4xcozsP7n6WY+Bbua8Uhoc1mcBpRbc4vglyH8lyQ8CJKZ++w48nG?=
 =?us-ascii?Q?D0ytPLT2WnMSDgBc8TImZZpYcTuqPpdRkDj5ubRsVPPGqlMLey0D32kGgYus?=
 =?us-ascii?Q?27yUBoORj72IoyDR+IU07ReC6SzFqLo77l0YdxnUBCwonpVVgPM9rnFlaJF9?=
 =?us-ascii?Q?6yu6AUBLoRa6Ohcltb16W/xH2yLzg+hMiflWOg184J4H9QES85T5en7eGV9i?=
 =?us-ascii?Q?2GnOePgtjX3pCWXTWWbx/WG+oOk6x+mDfBwzkeBJErdnnSPQUbwd/VEK7QIr?=
 =?us-ascii?Q?VdPL0fA73Z5ZwyXGNSJ1tXsS170Yr5rLvhQozysw+QwWE8czK+pVlWwLZsw+?=
 =?us-ascii?Q?3uvGyKbowkvMKSUkKtHnEAhuZkJ/2kJVb87haEuP764tU/Y9TxPaF2ZScDGt?=
 =?us-ascii?Q?nzmGNRhOSorpTAkWwSoQaNMjaB/KBpc/DKKJ1QrLB62oBzUXuJGEGGEv5qui?=
 =?us-ascii?Q?v1fA94QDz3rF1Rv5/i5wE/AyH7KYkj8Ksnm37sVfPhgjaUiGS+T1YFedT6yk?=
 =?us-ascii?Q?IxbZaeJ/OaNaSXl8KQIf1PQ7+8nUSiHc63qh0BTHcPVR/sU2SJinlnfyPd7N?=
 =?us-ascii?Q?6lcpe1KG1kL2ON8jnXREpL9LBLZR8eg0fL6XLKTUFpV/WK1GnQPNCySfSHKd?=
 =?us-ascii?Q?Em/4Rsfq3X5jzOGpr0+t6CH5jsKNQDi64hiwxxP6zM4Iycb8b+v/F9vlfMXU?=
 =?us-ascii?Q?Besu/QkNaKyXOfpZ0eh6DMfhzsehp7xQZbBhQxhSDHBSCrxLuUm6/Af7DaCZ?=
 =?us-ascii?Q?u/zn9hE7GdqvAk7ERLJKNBu6KqfINB0cAyoY25mXRHZ1E2tvvtGBs9KiA6RE?=
 =?us-ascii?Q?2hYETHoBKokfGJLpkzWPBDZp?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7e5eda-488e-4516-0bbb-08d931a9e5b3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:42.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnkD3KVXUTx3h60/CA/3zV/Iwmr8Fov1odeRLU7DSYxwmZggo3OAUIHrSUw7bpVaW3A/ro9c7Nx6huXkIGicqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils/ip.c | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/ip.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils/ip.c b/drivers/net/wire=
less/celeno/cl8k/utils/ip.c
new file mode 100644
index 000000000000..798119bca294
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/ip.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "utils/ip.h"
+
+/* Chromecast" 239.255.255.250 */
+#define MCAST_CHROMECAST_ADDR htonl(0xEFFFFFFAL)
+
+/*
+ * Local-group multicast address | internetwork multicast address =3D
+ *   =3D 224.0.0.0/24 | 224.0.1.0/24 =3D 224.0.0.0/23
+ */
+#define MCAST_IP_SERVICE_MASK __constant_htonl(0xFFFFFE00UL)
+
+static __be16 get_eth_proto(struct sk_buff *skb)
+{
+       if (!skb->mac_header)
+               skb_reset_mac_header(skb);
+
+       if (eth_hdr(skb)->h_proto =3D=3D htons(ETH_P_8021Q))
+               return vlan_eth_hdr(skb)->h_vlan_encapsulated_proto;
+       else
+               return eth_hdr(skb)->h_proto;
+}
+
+bool set_network_header_if_proto(struct sk_buff *skb, u16 protocol)
+{
+       if (get_eth_proto(skb) =3D=3D htons(protocol)) {
+               const bool has_vlan_header =3D eth_hdr(skb)->h_proto =3D=3D=
 htons(ETH_P_8021Q);
+               const size_t h_offset =3D
+                       (eth_hdr(skb) =3D=3D (struct ethhdr *)(skb->data)) =
? ETH_HLEN : 0;
+
+               skb_set_network_header(skb, h_offset + ((has_vlan_header) ?=
 VLAN_HLEN : 0));
+
+               return true;
+       }
+
+       return false;
+}
+
+bool is_ipv4_packet(struct sk_buff *skb)
+{
+       return set_network_header_if_proto(skb, ETH_P_IP) &&
+              (ip_hdr(skb)->ihl >=3D 5) &&
+              (ip_hdr(skb)->version =3D=3D IPVERSION);
+}
+
+bool is_ipv6_packet(struct sk_buff *skb)
+{
+       return set_network_header_if_proto(skb, ETH_P_IPV6) &&
+              (ipv6_hdr(skb)->version =3D=3D 6);
+}
+
+bool is_ssdp_packet(struct sk_buff *skb)
+{
+       bool status =3D false;
+
+       if (get_unaligned((const u32 *)&ip_hdr(skb)->daddr) =3D=3D MCAST_CH=
ROMECAST_ADDR)
+               status =3D true;
+
+       return status;
+}
+
+bool is_mdns_packet(const u8 *dest_mac)
+{
+       /*
+        * Multicast DNS packets should be sent as multicast, since no IGMP
+        * registration is performed on them
+        */
+       u8 mdns_mac[] =3D {0x01, 0x00, 0x5e, 0x00, 0x00};
+
+       if (!memcmp(dest_mac, mdns_mac, 5) && (dest_mac[5] =3D=3D 0xfb || d=
est_mac[5] =3D=3D 0xfc))
+               return true;
+
+       return false;
+}
+
+bool is_ipv4_service_multicast_packet(struct sk_buff *skb)
+{
+       /* Check if sk_buff contains IGMP packet, addressed to 224.0.0.0/23=
 */
+       return ((IGMP_LOCAL_GROUP =3D=3D (ip_hdr(skb)->daddr & MCAST_IP_SER=
VICE_MASK)) &&
+               (IPPROTO_IGMP !=3D ip_hdr(skb)->protocol || IGMP_ALL_HOSTS =
=3D=3D ip_hdr(skb)->daddr));
+}
+
+bool is_ipv6_service_multicast_packet(struct sk_buff *skb)
+{
+       /* Check if sk_buff contains ICMP packet, or addressed to ff02::/16=
 */
+       const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
+       u8 protocol =3D ip6h->nexthdr;
+
+       /* If hop-by-hop option header, get the first u8 field from this he=
ader */
+       if (protocol =3D=3D IPPROTO_HOPOPTS)
+               protocol =3D ((const struct ipv6_hopopt_hdr *)(ip6h + 1))->=
nexthdr;
+
+       return (((ip6h->daddr.s6_addr[0] =3D=3D 0xff) &&
+                (ip6h->daddr.s6_addr[1] =3D=3D 0x02)) ||
+               (protocol =3D=3D IPPROTO_ICMPV6));
+}
+
+bool is_tcp_ack(struct sk_buff *skb, bool *syn_rst_push)
+{
+       if (skb->len > TCP_ACK_MAX_LEN)
+               goto out;
+
+       if (is_ipv4_packet(skb)) {
+               struct iphdr *iphdr =3D ip_hdr(skb);
+
+               if (iphdr->protocol =3D=3D IPPROTO_TCP) {
+                       struct tcphdr *tcp_hdr =3D (struct tcphdr *)
+                                                ((char *)iphdr +
+                                                 IPV4_HDR_LEN(iphdr->ihl))=
;
+                       u16 data_size =3D ntohs(iphdr->tot_len) -
+                                       IPV4_HDR_LEN(iphdr->ihl) -
+                                       (tcp_hdr->doff * 4);
+
+                       *syn_rst_push =3D tcp_hdr->syn || tcp_hdr->rst || t=
cp_hdr->psh;
+
+                       return (data_size =3D=3D 0);
+               }
+       } else if (is_ipv6_packet(skb)) {
+               struct ipv6hdr *ipv6hdr =3D ipv6_hdr(skb);
+
+               if (ipv6hdr->nexthdr =3D=3D IPPROTO_TCP) {
+                       struct tcphdr *tcp_hdr =3D (struct tcphdr *)
+                                                ((char *)ipv6hdr +
+                                                sizeof(struct ipv6hdr));
+                       u16 data_size =3D ntohs(ipv6hdr->payload_len) -
+                                       (tcp_hdr->doff * 4);
+
+                       *syn_rst_push =3D tcp_hdr->syn || tcp_hdr->rst || t=
cp_hdr->psh;
+
+                       return (data_size =3D=3D 0);
+               }
+       }
+
+out:
+       *syn_rst_push =3D false;
+       return false;
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

