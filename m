Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECBB3AB86A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhFQQH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:59 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:62080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231559AbhFQQHX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+BceLuENAo34FcbcLoTUlxXN2pSBsYUswtIj5F3BdHRGz4R7DhJ20vAeM8xolUQYDEozqGX8FtKRxNWTNGotjQ46PN4gtHB/pqQuFC+knrp/XOUYCa/rfxUaKDdsBT8jTyqzdhD+xyjEReVaTBGDz1ZETHKpVo99VtjPNJfzzGq2XKyQO83pr+VYxCIt0NgX9UWYeFMtzlbBiMC1fdGLrN8+8EEy1f4bRt9W8jWGuhS35mY9PJP+l5BUVaVLKYcQmgZ35t7EEkBEetdS7e+WQ5sqt5z81MZl4+a4jSEWA405SR9cMyMpeszJ5/c2yHNQIbvLw3TIGc/MMcRMGuS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl6JxYhmqbp3u5CCWpGW+uUeAQzKLLI1FyiAFS27b6Y=;
 b=B/ntojuf6MYk2ZajsWc4TKMkQd0GKdBUhAWrKjySNVElk2mKpjSyV7JuFApphK5N12Rlke/9qdTDOL+ags+vlEBn7UtwwzlEenCsPW2zIzw+CSSH/F6KTtuSKPcLdI8JXwEVwBk6QXINgKrZ9dq7Qy9sRAhFL9bdf7ZfBzKcaA7B+OdOCR8pfgV3puO7w3U1agsauB6uj/xiG89nJGisBbXpE/LWslSg2vbzScbDOOBr0isuJ4Qlj/HX3dKBQkHoDaf0TbTugdc/TEbOfoEZF2FYv2Ue6IGAfDKRCX5pFRCwNJ9Qn/y5NtM9XpQIeSi3ti6Xj2Vu2rc2vDz0FXFf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl6JxYhmqbp3u5CCWpGW+uUeAQzKLLI1FyiAFS27b6Y=;
 b=w4sEFBdQRzTPiiYroxY9cLBnN/Ric+69rr3nf3aslkIJK8P/L6UqdQOqlZNoOUkI5Kq8nE9dFw5WdZmTd5RFsqjnsH1eGXD5y4VREuJJmnSaURK6D6PhGffGphqXvKuJOki3EG9KPJyekaWdarPJZncaghWr1H3EhC4/E4YpmWQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:07 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:07 +0000
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
Subject: [RFC v1 107/256] cl8k: add mac_addr.c
Date:   Thu, 17 Jun 2021 15:59:54 +0000
Message-Id: <20210617160223.160998-108-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 772691f1-2c04-4729-8623-08d931a99829
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB040269D72DCC29FD4B5069E0F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifSzfGMHI0YO8Jp4chRo0xFsXex6Cwu4lp9MH/zkMe8InvwWOWYxPYrjjUGOeWRwYZ7nz8LIg2mfn4OPt7drRwMiMisgVQyTN0KGj1Zf0DkBG0Ouf0O+Ix0mnWiAUwaLXD0lIelJVOmP0Y5LWUBPRFl8ZGAWSKhmUQBfeAl9zL/BeIWz7L37Q3NvNWoo25WwGLRajxLCkHDWMhe/lLLKPkppJ12XO70rxz89NDdmBMTflT1TfD6vaTMUYkd4r8/ebw6UVFjKFsltfKH/zOW7LV+/9wQiq4L9C9nJ+9E5MGS2zedWLm6QbH6HeqhOVpsT3zx6rNt6TAes3z7v3LXx4xNzBpPYJs1gT+1o4I0kVMPEXc3q9sSGJreZgfaQ3vRtfk/Pe2rLjDV5wmErdjCXa1IGX9Eu3Mw8HtOofn0iev9KaZbGN8Wtj1ux0XPxwcfeg91V7hKceX1yEL4z9/HxSnmCSIT/xjgWp/GH3ntcJKDye84C/IYDJuu9SlO/1hRGtEBtIKwjiZjemb0NPJGWQEFu57LYpgFpnsTFqWBNIPK3M9BgUdjPYuehuI9IDH4wIUGte4BtqdZ5QUQNzEouAMjRXFf+yj2tndT7ieo2ia5bLT3CejTYHyLV3p3yulnmKDt0P4ONGuVLuEvQqQJA98029nf3x3wgm80/x3h9lw9dMExhuvMCuT2r6pXHTjTshVOrflxLsEXNOSa7DXCx4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(30864003)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcqA/cDDiOyJl3Dzsi7VD5FOYIMaf4lm7jf5ioTkr6cZ4cr2ttY4TjDSux7M?=
 =?us-ascii?Q?jG0ChufHPpIJfdfQdO1Yvj0oWGqsPdUV1dpOAiDTZgxd0+ImnYkcwHDauZYR?=
 =?us-ascii?Q?sBgPLFajDbVjOMtti1aMAZT1qTE9GSK8lg+ZEuGby+4+tN9ClMXgl4uXxYvL?=
 =?us-ascii?Q?g9CdA0Q+1nz2yzJZBS/WCkX+1aIN7lM4VhVdQPoI/WebjAo2w/RKmjc0BQJP?=
 =?us-ascii?Q?B4QyVnVohNTVxd1S4Qi5jLMlOmjEycAlOmsQMDJlvUIhypG6l9iPSWc2h7Xu?=
 =?us-ascii?Q?lkOj1XZJHiB23+7gcyhsL8yXGahVYxFVc3q628lEtLO58+nboiw9PssSHzG7?=
 =?us-ascii?Q?f69h6Wq9gzZDfyo2MTX1VLHBI09n3Z6XRKXizp9zG+PPhabT9uThtOK/1S4B?=
 =?us-ascii?Q?aqxJMbs7kKzfECFo3cHJT/OXQgO9fx+BQtp9Bu4I+EzkHecg+LAdPjzlPq18?=
 =?us-ascii?Q?WyS51q58/zPNtHHflTb32z0p2Hu++pQJJTZEp6H3jyd95Ppgbbj/uKxCSVkF?=
 =?us-ascii?Q?C0iRXnfV2OirdO5pxPnF2S46DSkUliBIS1YVDtfwTQUXXxZcf2iMyXCqCMA5?=
 =?us-ascii?Q?vqwguBoRuenw7HmocycR5TBTJqSMQMnC9nqIAbJtPWr+mw9nClD3gp+W3QOL?=
 =?us-ascii?Q?i3SCfySWLT4DOAh7WdhD1cUK4jDDwCYcrZB2tBiDCpw/07xCideIlLDH5VYN?=
 =?us-ascii?Q?f9N9TC3A2x2/bpAS3pCRHB3+KCRIM8584qT3sZp4POzNc0SpGv44aI0b3WSH?=
 =?us-ascii?Q?D8hKVQh+aNkb8bZdeh3xWu5oxAFyD0qB8VVRaLYExOrzD9NoinSqc0wehevv?=
 =?us-ascii?Q?GtcZoGV+cw7Gx/18MbgeMeu+ZyaAzpaf5msatD0BK+G+vc/BUl2QvYJFrTlW?=
 =?us-ascii?Q?D8XK6vfkrGRduflzdZqeZFYGgzvdf4j9zKNlPPwKUJmGleldTN5pRqloNvP6?=
 =?us-ascii?Q?Q6HdEaj4CKM4BUPqC1DFt3eyqBrYOhPDW9hQRACYoG3aon4SPBWK7N3HnlCx?=
 =?us-ascii?Q?0sP2yyqQuvl/ELLh3n+2MmcFquTix6ss3nxQ2nhHFZJBdQVuKmmmgnXNh7NT?=
 =?us-ascii?Q?ZPfun66r5aSoMg4QY2nPAUaQ8imRqS+Zi2nMQY/X3tzxLAwKy0IVDxQ4TS3s?=
 =?us-ascii?Q?CJO9pmqlqusepR9Xwlxjgdy2pyF9XbLZvjeNOp5cmW5SIFNGUnVBywgb0lNA?=
 =?us-ascii?Q?5+K638HQcyaniVTbZqz17Ukeg+BP7NHM0Fgxh+RxDW2Lm05m+/BvjsHIYG52?=
 =?us-ascii?Q?Mi7VvFkXulZm663p7NlOUY323p+LemletJtmpmam59DZvJ+4gtjUTOnPNdDz?=
 =?us-ascii?Q?iHb+gBIFbETDNknOn10jrOfY?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772691f1-2c04-4729-8623-08d931a99829
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:32.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW7HelxPmMD4scFUYh7W1P2wl91MnzTx4l8xemi2poarB6IgJImPkX1sPRqC31yNYglcZBxNqjomTM6vSfBcUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mac_addr.c | 331 ++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.c

diff --git a/drivers/net/wireless/celeno/cl8k/mac_addr.c b/drivers/net/wire=
less/celeno/cl8k/mac_addr.c
new file mode 100644
index 000000000000..eeb3ce294111
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac_addr.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "mac_addr.h"
+#include "utils/utils.h"
+#include "chip.h"
+
+static int set_mask_addr_without_zeroing_bits(struct cl_hw *cl_hw, u64 mac=
64, u8 bss_num,
+                                             u8 first_mask_bit, u8 *mask_a=
ddr)
+{
+       u64 mask =3D mac64;
+       s8 idx =3D 0;
+
+       mask >>=3D first_mask_bit;
+       mask +=3D (bss_num - 1);
+
+       /*
+        * After the following line the mask will contain the changed
+        * bits between the first BSS MAC and the last BSS MAC
+        */
+       mask ^=3D (mac64 >> first_mask_bit);
+
+       /* Find leftmost set bit */
+       for (idx =3D 47 - first_mask_bit; (idx >=3D 0) && (!(mask & (1ULL <=
< idx))); idx--)
+               ;
+
+       if (idx < 0) {
+               cl_dbg_err(cl_hw, "Invalid mask (mac=3D0x%02llx, first_mask=
_bit=3D%u, bss_num=3D%u)\n",
+                          mac64, first_mask_bit, bss_num);
+               mask =3D 0;
+               eth_zero_addr(mask_addr);
+
+               return -1;
+       }
+
+       mask =3D (1ULL << idx);
+       mask |=3D (mask - 1);
+       mask <<=3D first_mask_bit;
+
+       for (idx =3D 0; idx < ETH_ALEN; idx++) {
+               u8 shift =3D (8 * (ETH_ALEN - 1 - idx));
+
+               mask_addr[idx] =3D (mask & ((u64)0xff << shift)) >> shift;
+       }
+
+       return 0;
+}
+
+static int mask_mac_by_bss_num(struct cl_hw *cl_hw, u8 *mac_addr, u8 *mask=
_addr,
+                              bool use_lam, bool random_mac)
+{
+       u8 bss_num =3D cl_hw->conf->ce_bss_num;
+       u8 first_mask_bit =3D cl_hw->chip->conf->ce_first_mask_bit;
+       u8 i;
+       /* Determine the bits necessary to cover the number of BSSIDs. */
+       u8 num_bits_to_mask[MAX_BSS_NUM * 2 + 1] =3D {
+               0, 0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4
+       };
+       u8 mask_size =3D 0;
+       u8 byte_num =3D ETH_ALEN - 1 - (first_mask_bit / 8);
+       u8 bit_in_byte =3D first_mask_bit % 8; /* Referring to the index of=
 the bit */
+
+       if ((first_mask_bit + num_bits_to_mask[bss_num]) > (ETH_ALEN * 8)) =
{
+               pr_err("Invalid combination of first_mask_bit + bss_num. "
+                      "must be lower than 48 bit in total\n");
+               return -1;
+       }
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               mask_size =3D num_bits_to_mask[bss_num - 1];
+       } else {
+               u64 mac64 =3D ether_addr_to_u64(mac_addr);
+               u8 tcv0_bss_num =3D cl_hw->chip->cl_hw_tcv0->conf->ce_bss_n=
um;
+               u8 bit_mask =3D (1 << num_bits_to_mask[bss_num + tcv0_bss_n=
um - 1]) - 1;
+
+               /*
+                * If we need to zero bits due to lack of room for the MAC =
addresses
+                * of all BSSs of TCV1, then the mask is the number of zero=
ed bits
+                */
+               if (((u64)bit_mask - ((mac64 >> first_mask_bit) & (u64)bit_=
mask) + 1) < bss_num) {
+                       mask_size =3D num_bits_to_mask[bss_num + tcv0_bss_n=
um - 1];
+               } else {
+                       /*
+                        * Otherwise the mask is the different bits between=
 the
+                        * addresses of the first and the last BSSs
+                        */
+                       set_mask_addr_without_zeroing_bits(cl_hw, mac64, bs=
s_num,
+                                                          first_mask_bit, =
mask_addr);
+                       return 0;
+               }
+       }
+
+       /* Build mac and mask addr */
+       for (i =3D 0; i < mask_size; i++) {
+               /*
+                * Build mask - Convert to "1" the relevant bits in the mas=
k
+                * addr in order to support the desired number of BSSIDs
+                */
+               mask_addr[byte_num] |=3D (0x01 << bit_in_byte);
+
+               /*
+                * Build mac -convert to "0" the relevant bits in the mac a=
ddr
+                * in order to support the desired number of BSSIDs
+                */
+               if (random_mac && !use_lam)
+                       mac_addr[byte_num] &=3D ~(0x01 << bit_in_byte);
+
+               bit_in_byte++;
+
+               /* Support cases where the mask bits are not at the same by=
te. */
+               if (bit_in_byte =3D=3D 8) {
+                       byte_num--;
+                       bit_in_byte =3D 0;
+               }
+       }
+
+       if (use_lam) {
+               /* Mask LAM bit (Locally Administered Mac) */
+               if (cl_hw_is_tcv0(cl_hw))
+                       mask_addr[0] |=3D 0x02;
+       } else {
+               /*
+                * When not using LAM we do not zero the MAC address of the=
 second BSS,
+                * so the mask (the modified bits between the first and las=
t BSS) depends
+                * on initial MAC
+                */
+               u64 mac64 =3D ether_addr_to_u64(mac_addr);
+
+               set_mask_addr_without_zeroing_bits(cl_hw, mac64, bss_num,
+                                                  first_mask_bit, mask_add=
r);
+       }
+
+       return 0;
+}
+
+#define MAC_FILTER_BITS 4
+#define MAC_FILTER_MASK ((1 << MAC_FILTER_BITS) - 1)
+
+static bool is_valid_mac_addr(u64 mac64, u8 first_mask_bit, u8 bss_num)
+{
+       u8 mac_bits =3D (mac64 >> first_mask_bit) & MAC_FILTER_MASK;
+       u8 mac_diff =3D 0;
+       u8 i;
+
+       for (i =3D 0; i < bss_num; i++) {
+               mac_diff |=3D mac_bits;
+               mac_bits++;
+       }
+
+       return hweight8(mac_diff) <=3D MAC_FILTER_BITS;
+}
+
+static int cl_mac_addr_set_addresses(struct cl_hw *cl_hw, bool use_lam,
+                                    u8 *mask_addr)
+{
+       u8 first_mask_bit =3D cl_hw->chip->conf->ce_first_mask_bit;
+       int i =3D 0;
+       u8 bss_num =3D cl_hw->conf->ce_bss_num;
+       u64 mac64 =3D ether_addr_to_u64(cl_hw->hw->wiphy->perm_addr);
+       u64 mask64 =3D 0;
+       u8 new_addr[ETH_ALEN] =3D {0};
+
+       if (!use_lam && !is_valid_mac_addr(mac64, first_mask_bit, bss_num))=
 {
+               cl_dbg_err(cl_hw,
+                          "perm_addr %pM is invalid for bss_num %d without=
 LAM\n",
+                          cl_hw->hw->wiphy->perm_addr, bss_num);
+               return -1;
+       }
+
+       cl_mac_addr_copy(cl_hw->addresses[i].addr,
+                        cl_hw->hw->wiphy->perm_addr);
+       for (i =3D 1; i < bss_num; i++) {
+               u8 *prev_addr =3D cl_hw->addresses[i - 1].addr;
+
+               if (use_lam) {
+                       mac64 =3D ether_addr_to_u64(prev_addr);
+                       mask64 =3D ether_addr_to_u64(mask_addr);
+                       if (cl_hw_is_tcv0(cl_hw)) {
+                               if (i =3D=3D 1)
+                                       mac64 &=3D ~mask64;
+                               else
+                                       mac64 +=3D 1 << first_mask_bit;
+                               u64_to_ether_addr(mac64, new_addr);
+                               new_addr[0] |=3D 0x02;
+                       } else {
+                               if ((mac64 & mask64) =3D=3D mask64)
+                                       mac64 &=3D ~mask64;
+                               else
+                                       mac64 +=3D 1 << first_mask_bit;
+                               u64_to_ether_addr(mac64, new_addr);
+                       }
+                       cl_mac_addr_copy(cl_hw->addresses[i].addr, new_addr=
);
+               } else {
+                       mac64 =3D ether_addr_to_u64(prev_addr);
+                       mac64 +=3D 1 << first_mask_bit;
+                       u64_to_ether_addr(mac64, cl_hw->addresses[i].addr);
+               }
+       }
+       cl_hw->n_addresses =3D bss_num;
+
+       return 0;
+}
+
+int cl_mac_addr_set_tcv0(struct cl_hw *cl_hw, u8 *dflt_mac, u8 *dflt_mask,=
 bool *random_mac)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (!cl_mac_addr_is_zero(chip->conf->ce_phys_mac_addr)) {
+               /* Read MAC from NVRAM file */
+               cl_mac_addr_copy(dflt_mac, chip->conf->ce_phys_mac_addr);
+               cl_dbg_verbose(cl_hw, "Read MAC address from NVRAM [%pM]\n"=
, dflt_mac);
+       } else {
+               /* Read MAC from EEPROM */
+               if (chip->eeprom_read_block(chip, ADDR_GEN_MAC_ADDR,
+                                           ETH_ALEN, dflt_mac) !=3D ETH_AL=
EN) {
+                       CL_DBG_ERROR(cl_hw, "Error reading MAC address from=
 EEPROM\n");
+                       return -1;
+               }
+
+               cl_dbg_verbose(cl_hw, "Read MAC address from EEPROM [%pM]\n=
", dflt_mac);
+       }
+
+       /* Test if the new mac address is 00:00:00:00:00:00 or ff:ff:ff:ff:=
ff:ff */
+       if (cl_mac_addr_is_zero(dflt_mac) || cl_mac_addr_is_broadcast(dflt_=
mac)) {
+               /* Set celeno oui */
+               dflt_mac[0] =3D 0x00;
+               dflt_mac[1] =3D 0x1c;
+               dflt_mac[2] =3D 0x51;
+               get_random_bytes(&dflt_mac[3], 3);
+               cl_dbg_verbose(cl_hw, "Random MAC address [%pM]\n", dflt_ma=
c);
+               *random_mac =3D true;
+       }
+
+       return 0;
+}
+
+void cl_mac_addr_set_tcv1(struct cl_hw *cl_hw, u8 *dflt_mac, u8 *dflt_mask=
)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       u8 tcv0_bss_num =3D cl_hw_tcv0->conf->ce_bss_num;
+       u8 first_mask_bit =3D chip->conf->ce_first_mask_bit;
+       u64 mac64;
+       u8 idx;
+       u8 bss_num =3D cl_hw->conf->ce_bss_num;
+       u8 bit_mask[MAX_BSS_NUM + 1] =3D {0x0, 0x0, 0x1, 0x3, 0x3, 0x7, 0x7=
, 0x7, 0x7};
+
+       mac64 =3D ether_addr_to_u64(cl_hw_tcv0->hw->wiphy->perm_addr);
+
+       if (chip->conf->ce_lam_enable) {
+               /* Find the first address of TCV1 */
+               if (tcv0_bss_num =3D=3D 1) {
+                       /*
+                        * For tcv0 bss num =3D 1, we have to zero the nece=
ssary bits
+                        * since it hasn't been done in TCV0
+                        */
+                       mac64 &=3D ~((u64)bit_mask[bss_num] << first_mask_b=
it);
+               } else {
+                       u8 total_bss_to_mask =3D bss_num + tcv0_bss_num - 1=
;
+
+                       mac64 &=3D ~((u64)bit_mask[tcv0_bss_num - 1] << fir=
st_mask_bit);
+                       /*
+                        * Get the first MAC address of TCV1 by incrementin=
g the MAC
+                        * address of the last BSS of TCV0.
+                        * After the instruction below mac64 will hold the =
MAC of TCV0's
+                        * last BSS.
+                        */
+                       mac64 +=3D ((u64)(tcv0_bss_num - 2) << first_mask_b=
it);
+                       /*
+                        * If there is no more room for another address in =
TCV0's mask
+                        * address then we have to zero bits else increment=
 the last
+                        * address of TCV0
+                        */
+                       if (((mac64 >> first_mask_bit) & (u64)bit_mask[tota=
l_bss_to_mask]) =3D=3D
+                           (u64)bit_mask[total_bss_to_mask])
+                               mac64 &=3D ~((u64)bit_mask[total_bss_to_mas=
k] << first_mask_bit);
+                       else
+                               mac64 +=3D (1ULL << first_mask_bit);
+               }
+
+               /* Enable LAM bit */
+               mac64 +=3D (0x2ULL << 40);
+       } else {
+               mac64 +=3D ((u64)tcv0_bss_num << first_mask_bit);
+       }
+
+       for (idx =3D 0; idx < ETH_ALEN; idx++) {
+               u8 shift =3D (8 * (ETH_ALEN - 1 - idx));
+
+               dflt_mac[idx] =3D (mac64 & ((u64)0xFF << shift)) >> shift;
+       }
+}
+
+int cl_mac_addr_set(struct cl_hw *cl_hw)
+{
+       bool random_mac =3D false;
+       u8 dflt_mac[ETH_ALEN] =3D {0, 28, 81, 81, 81, 81};
+       u8 dflt_mask[ETH_ALEN] =3D {0};
+       bool use_lam =3D cl_hw->chip->conf->ce_lam_enable;
+       struct wiphy *wiphy =3D cl_hw->hw->wiphy;
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               if (cl_mac_addr_set_tcv0(cl_hw, dflt_mac, dflt_mask, &rando=
m_mac))
+                       return -1;
+       } else {
+               cl_mac_addr_set_tcv1(cl_hw, dflt_mac, dflt_mask);
+       }
+
+       /* For single BSS mask should be 0 */
+       if (cl_hw->conf->ce_bss_num > 1)
+               if (mask_mac_by_bss_num(cl_hw, dflt_mac, dflt_mask, use_lam=
, random_mac))
+                       return -1;
+
+       /* Permanent address MAC (the MAC of the first BSS) */
+       SET_IEEE80211_PERM_ADDR(cl_hw->hw, dflt_mac);
+
+       /*
+        * MAX_BSS_NUM must be power of 2
+        * mac80211 doesn't handle non-contiguous masks
+        */
+       if (!WARN_ON(MAX_BSS_NUM & (MAX_BSS_NUM - 1)))
+               cl_mac_addr_array_to_nxmac(dflt_mask, &cl_hw->mask_low, &cl=
_hw->mask_hi);
+
+       if (cl_mac_addr_set_addresses(cl_hw, use_lam, dflt_mask))
+               return -1;
+
+       wiphy->addresses =3D cl_hw->addresses;
+       wiphy->n_addresses =3D cl_hw->n_addresses;
+
+       return 0;
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

