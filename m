Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6305E3AB90D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhFQQMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:09 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:65046
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233872AbhFQQLD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti2BcYxGYCWsm++VcmPRk6fU/Gwf+Y5lb8WC2W53XeoUIVGUQeGvg9uooPEG1DAHbhRKb2lYbUZt7QdEMQI9Ab3cyY64SmQndNZRfTa0vNZNx36qPz9M3ZrJZXK3jrEkWtknnDeT0YTMqGf4KKdFuvGTiuEcJOaL6JS0nJPnngpFIq5ndTGx08gV2Oa0RGjeLEb5IiKDyEqGI2T+Ahc8UQfBYjCmsJIiR015jLu1vTlauL7JmqvB5tRlGKBEiTRlwzvveY4fA+29HHxQKvrzU/2G8+v3/oLXHPzIhPZkY3VAC0zzTqI1T81WlRvhaQWPGUKuvSfgomktRDUPE0/86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUDJ9G8pXMZH6dZzxgP7xCvxZrtiAoPP+A5nRmCPEP8=;
 b=DbPrYDeECA/FFmUL70ixRhQ4By5oeBbKqQdc28cX9wkr7rHvZG3nRa+vi2xDJJHCbgr2FM7a5OrLwyPmT5cvRc8pgv2XLP8b5ODRgAKaeEZBg8n5Hk5Xo0dZcNqxWDK6SmeMrX+ZFmdRAZIKOesvecWXDVwGRN5NVkg7kB6ICcZavibrtjS775MDh3NmRz6DcMVlt2O5mAxGNvcXJiKPeOFjHyRkbduSGxWH92j/NGNBpxqQMWhZ3Cl+z2+0eL5p9aKPzAMRqJVQ9RFGLkf3MioH/imCQlVuOFmO3WMYMGqrmYZ6xPZUyNqA0tDw9DRwgruRJ52mn4w/tepqsdoKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUDJ9G8pXMZH6dZzxgP7xCvxZrtiAoPP+A5nRmCPEP8=;
 b=d6C3IPLEB0bDyvp1fZiVauCKiWI/YJEthRoVxvrIQ0LCXE2xPzNnh714VRO9E9Eai6+DpELAMpbYVV3mSyMwak5UdrVYw/2ASoqt+1pQ8Fjc6CAQMkTw/7jia/gZJyaE9vya2axPFnqdxjR0xVCRvnZg7t8JBgkSJ96RieEC9NE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:51 +0000
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
Subject: [RFC v1 214/256] cl8k: add tx/tx_amsdu.c
Date:   Thu, 17 Jun 2021 16:01:41 +0000
Message-Id: <20210617160223.160998-215-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ccf497-8557-4646-6d06-08d931a9df9b
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329EEB2E9CC963F54044E24F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKlqoQFmRuLADF/vK1mB6skXKQIbekt+E8+aJaGotnpOQiQ7rKhqhYybQi73IeaxmSyext3nWy7m0dVdOZyHX68Q6qKdxCYluXU+PCYd8zeSu1mQFb3WvupD2RQ+F/wzGJEIFFrjzmqB1QGtPwC6k1zHDGUUTMh/H4Rn6WALJwr7Ny8r4B2NvD1noSy193jsbLwa4aFIsH/SHXTum95EnZluBvrey8cqZgpnVnzWqupCUX955QlBXANH1VDlQUo1ruEMHcJ/tUDkB3MmcnVETA9edj1Bl6+whpCT8YIB6g1Ci94dDPjj5Pw0JHycRK0eAz6Vj+hDd/oGvemZK9Ab9zaoopK3ovwD7N706figP44NIFRk1EvtUNJfpAGgDWWllqpRLQE++Ejp1ehwE1GsrL/QRuE0AbyCFNOIXlmZZ5OL8JRGV/aQXvZi5ZWu7HN4SxbkxDFTJ8YdfVaN5PBRykFGEe9FB0/FvyPCOWMrifm2aeAV90UxopY+TxTWC9OMLOuNOUY/4DbcRge4mUyMc3z8zdwDK04lFWNn+ui814pgSZpAYBfxyFEJwRci0fHpRagFNNtUTUvamVfI/BAqEBFl9zfac66KwdXhrvyBR8xcAXIxtipAfE3/fYWG+tEOyHI8MVIHXLaGxfzMl5lt/Fn2ktcGQfiGn/GzwSi0FY1pRZDrXGv0ZC1AqEUPOSpjSTh5mrMZcMBB/l7Mda6YhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(30864003)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycTZFryDbphplNvN/81gqmj9xIpUU2XzIH57TuiaJQpuqUHh3Ag9Fuqt6fWp?=
 =?us-ascii?Q?GdP+QZa9ho2YmknUC6Q+yxo4/zUnoARc4td1CLXg8bWDIGGb7D42VlCubuKb?=
 =?us-ascii?Q?hxiRNCUm6xyk5FpLutuQfhW6Ig7fc5vRlRiZfT0rodpWghGYx0HD1lw3Jlu3?=
 =?us-ascii?Q?fscExJbSnZhNU/waGCkp7TsjYCJvb0/sDxOmw/slqLiWLUhax6jzVVNMVfY+?=
 =?us-ascii?Q?bTuO444h2vXmkQZtrENGbyzhh9mIGnMhy6/1m8WWvffNyBI2uhcIMVs1/aD1?=
 =?us-ascii?Q?9f/0/QZDQTF13bwdaDfDS8xGbxf44C7V/B5E2MsCinEduslDKTATjZlB6E5I?=
 =?us-ascii?Q?fswW6VroMYjJUoYTzxla+6jD57aaKUaZhHsOg0MGycgMpADAGxCqPjg6sJFY?=
 =?us-ascii?Q?E1njLSUcqPeKiQvh1WNSY35Zvxh1v14WwsN/AMybSaoDeQMMVdJ4MHJD7ZXN?=
 =?us-ascii?Q?IHjGYUvooh8t3Bm8t9jt8XbuxdpxKS9en7+Rt2c8QqC+yygN3KWWu+q5iFIf?=
 =?us-ascii?Q?xsJz6ciN1y2ZgFTgimdlSUbJ8FWR+Arhixm9xB9R8Uh482OCX/W/xbbgBqSa?=
 =?us-ascii?Q?fyEcMh9QuyyNGiVZDBJ3NBG7pdycF8K7KtLMuUSINJmyxSXc7TWWeRZZ7NYF?=
 =?us-ascii?Q?2+DBi08RIgJzhC9hyxXk/oIitj0sUpBo7Ce40xfbG2stym+LGel1IjmeZdz+?=
 =?us-ascii?Q?aK8HUPJ2AHHKPicTXZZjALmHNWKBRYWq+g2mbEu5r5v4JDJw/uuW7/ecMLJm?=
 =?us-ascii?Q?ovTrP3xOcsJR7HFTdP2W0vq6OqoQ3hLPmENARY6pXBStEV1i44AVP3JPQoYk?=
 =?us-ascii?Q?nodmw5vw9UKDacHu5BDzgmZTt+mO+nQCuXGK0yjlvbP7WO2QhP3gmweS3jlZ?=
 =?us-ascii?Q?I7ZUsuvevIV8G2uEgqeA0mSnwLuEb6cUen7iOXJOQYMYKFBepKy+doVOtrRD?=
 =?us-ascii?Q?39WQv5HS7QmXWYSGyKa8v2xpxVlsFRjuXy6FvpaZAsuRTCcHfYhblGAeBel2?=
 =?us-ascii?Q?tIA7sdTp21PVvMsSK+m/GZmd/JYSCfvmmfzfl4s12lh6XBHZu2IHh0WpVBso?=
 =?us-ascii?Q?UGnV8igrA2n2L+scnudUYMd5bt8gqmnm9eMmLgzTRi/KIgs9w/i/wvbjT2eG?=
 =?us-ascii?Q?rLij2FubNw3KulzIahPYVMnoawzVZQ8N/sO+PVoIy8gwzDni2PkAsGJK7nF5?=
 =?us-ascii?Q?xsz1kf7u/dVppFPV8j9obAKNH7M6SBD2T+tMpyr3iZXK4OsjpyXUt+Yx5IUi?=
 =?us-ascii?Q?bPQKBwdywsUW+nbfVFMXribRdeQ9tKWBIv2E46koojF1S9ttwCOxAcfUb9EH?=
 =?us-ascii?Q?jvzIfzvZ2LNwxe1cXFnbo7oM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ccf497-8557-4646-6d06-08d931a9df9b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:32.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZWcl6bAi3a2j6K+nWl9kC5kyugeCAV1oPwKd/ubTE3mIOeerYutuHpQ0/COVlhNcHFRZMvFsvP3gzj9v0dncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_amsdu.c    | 483 ++++++++++++++++++
 1 file changed, 483 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.c b/drivers/net/w=
ireless/celeno/cl8k/tx/tx_amsdu.c
new file mode 100644
index 000000000000..688f2af15e4a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/tx_amsdu.h"
+#include "tx/tx.h"
+#include "utils/math.h"
+#include "chip.h"
+#include "tx/tx_queue.h"
+#include "band.h"
+#include "def.h"
+#include "key.h"
+#include "utils/ip.h"
+#include "wrs/wrs_api.h"
+
+#define CL_AMSDU_HDR_LEN 14
+
+static bool cl_tx_amsdu_is_sw(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                             struct sk_buff *skb, u16 pkt_len)
+{
+       bool syn_rst_push =3D false;
+       bool tcp_ack =3D false;
+
+       if (cl_hw->conf->ci_tx_sw_amsdu_max_packets <=3D 1)
+               return false;
+
+       tcp_ack =3D is_tcp_ack(skb, &syn_rst_push);
+
+       if (!tcp_ack || syn_rst_push)
+               return false;
+
+       if ((cl_wrs_api_get_sta_data_rate(cl_sta) * cl_sta->ampdu_min_spaci=
ng) <=3D
+           (pkt_len << 3))
+               return false;
+
+       return true;
+}
+
+static int cl_tx_amsdu_anchor_set(struct cl_hw *cl_hw, struct cl_sta *cl_s=
ta,
+                                 struct sk_buff *skb, u8 tid)
+{
+       /*
+        * Packet length calculation in HW -
+        * Add 802.11 header (maximum possible size) instead if 802.3
+        * Add AMSDU header
+        * Add RFC1042 header (according to ether-type)
+        * Add IV and ICV (if there is encryption)
+        */
+       struct cl_amsdu_ctrl *amsdu_anchor =3D &cl_sta->amsdu_anchor[tid];
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+       u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
+       u16 pkt_len =3D skb->len + CL_WLAN_HEADER_MAX_SIZE;
+
+       if (key_conf)
+               pkt_len +=3D (key_conf->iv_len + key_conf->icv_len);
+
+       if (ethertype >=3D ETH_P_802_3_MIN)
+               pkt_len +=3D sizeof(rfc1042_header);
+
+       amsdu_anchor->rem_len =3D amsdu_anchor->max_len - pkt_len;
+       amsdu_anchor->packet_cnt =3D 1;
+       amsdu_anchor->is_sw_amsdu =3D cl_tx_amsdu_is_sw(cl_hw, cl_sta, skb,=
 pkt_len);
+
+       return CL_AMSDU_ANCHOR_SET;
+}
+
+static void cl_tx_amsdu_anchor_umacdesc_update(struct txdesc *txdesc, u8 i=
dx,
+                                              u16 len, dma_addr_t dma_addr=
,
+                                              bool is_padding)
+{
+       struct lmacapi *umacdesc =3D &txdesc->umacdesc;
+
+       umacdesc->packet_len[idx] =3D cpu_to_le16(len);
+       umacdesc->packet_addr[idx] =3D cpu_to_le32(dma_addr);
+       txdesc->host_info.packet_cnt++;
+
+       /* Update padding bit of current msdu sub-frame */
+       if (is_padding)
+               txdesc->host_info.host_padding |=3D BIT(idx);
+}
+
+static void _cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw,
+                                        struct sk_buff *skb,
+                                        struct cl_sta *cl_sta,
+                                        u8 tid)
+{
+       struct ieee80211_tx_info *tx_info;
+
+       tx_info =3D IEEE80211_SKB_CB(skb);
+       tx_info->flags &=3D ~IEEE80211_TX_CTL_AMPDU;
+       tx_info->control.flags &=3D ~IEEE80211_TX_CTRL_AMSDU;
+
+       if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, tid) =3D=3D 0) {
+               cl_hw->tx_packet_cntr.transfer.agg_to_single++;
+               cl_tx_single(cl_hw, cl_sta, skb, false, false);
+       }
+}
+
+static void cl_tx_amsdu_set_sw_sub_amsdu_hdr(struct sk_buff *skb)
+{
+       u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
+       int rfc1042_len =3D 0;
+       void *data;
+       struct ethhdr *amsdu_hdr;
+
+       if (ethertype >=3D ETH_P_802_3_MIN)
+               rfc1042_len =3D sizeof(rfc1042_header);
+
+       data =3D skb_push(skb, rfc1042_len + 2);
+       memmove(data, data + rfc1042_len + 2, 2 * ETH_ALEN);
+
+       amsdu_hdr =3D (struct ethhdr *)data;
+       amsdu_hdr->h_proto =3D cpu_to_be16(skb->len - ETH_HLEN);
+
+       memcpy(data + ETH_HLEN, rfc1042_header, rfc1042_len);
+}
+
+static int cl_tx_amsdu_add_sw_amsdu_hdr(struct cl_hw *cl_hw,
+                                       struct cl_amsdu_ctrl *amsdu_anchor)
+{
+       struct cl_sw_txhdr *anchor_sw_txhdr =3D amsdu_anchor->sw_txhdr;
+       struct sk_buff *skb =3D anchor_sw_txhdr->skb;
+       struct cl_sta *cl_sta =3D anchor_sw_txhdr->cl_sta;
+       struct ieee80211_hdr hdr;
+       u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
+       u16 hdrlen =3D cl_tx_prepare_wlan_hdr(cl_hw, cl_sta, skb, &hdr);
+       int rfc1042_len =3D 0;
+       int head_need =3D 0;
+       u8 enc_len =3D cl_key_get_cipher_len(skb);
+       u16 qos_ctrl =3D anchor_sw_txhdr->tid | IEEE80211_QOS_CTL_A_MSDU_PR=
ESENT;
+
+       if (!hdrlen)
+               return -EINVAL;
+
+       if (ethertype >=3D ETH_P_802_3_MIN)
+               rfc1042_len =3D sizeof(rfc1042_header);
+
+       amsdu_anchor->hdrlen =3D hdrlen;
+       head_need =3D hdrlen + enc_len + rfc1042_len - skb_headroom(skb);
+       if (head_need > 0) {
+               head_need =3D ((head_need + 3) & ~3);
+               if (pskb_expand_head(skb, head_need, 0, GFP_ATOMIC))
+                       return -ENOMEM;
+       }
+
+       cl_tx_amsdu_set_sw_sub_amsdu_hdr(skb);
+
+       skb_push(skb, hdrlen + enc_len);
+       memcpy(skb->data, &hdr, hdrlen - 2);
+       memcpy(skb->data + hdrlen - 2, &qos_ctrl, 2);
+       skb_reset_mac_header(skb);
+       anchor_sw_txhdr->txdesc.e2w_natt_param.hdr_conv_enable =3D false;
+       anchor_sw_txhdr->hdr80211 =3D (struct ieee80211_hdr *)skb->data;
+
+       return 0;
+}
+
+static int cl_tx_amsdu_sw_aggregate(struct cl_hw *cl_hw,
+                                   struct cl_amsdu_ctrl *amsdu_anchor,
+                                   struct sk_buff *skb)
+{
+       struct cl_sw_txhdr *anchor_sw_txhdr =3D amsdu_anchor->sw_txhdr;
+       struct sk_buff *anchor_skb =3D anchor_sw_txhdr->skb;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(anchor_skb);
+       struct ieee80211_key_conf *key_conf =3D tx_info->control.hw_key;
+       u16 total_frame_len =3D 0;
+       struct cl_tx_queue *tx_queue =3D anchor_sw_txhdr->tx_queue;
+       int head_pad =3D 0;
+       int sub_pad =3D 0;
+       bool syn_rst_push =3D false;
+       bool tcp_ack =3D is_tcp_ack(skb, &syn_rst_push);
+
+       /* Worst case: rfc1042(6) + ET(2) + pad(2) =3D 10 */
+       if (!tcp_ack ||
+           (skb_tailroom(anchor_skb) < (skb->len + 10))) {
+               if (tx_queue->num_packets =3D=3D 1)
+                       cl_txq_sched(cl_hw, tx_queue);
+               cl_tx_amsdu_anchor_init(amsdu_anchor);
+               return cl_tx_amsdu_anchor_set(cl_hw, anchor_sw_txhdr->cl_st=
a,
+                                             skb, anchor_sw_txhdr->tid);
+       }
+
+       if (amsdu_anchor->packet_cnt =3D=3D 1 &&
+           cl_tx_amsdu_add_sw_amsdu_hdr(cl_hw, amsdu_anchor))
+               return CL_AMSDU_FAILED;
+
+       cl_tx_amsdu_set_sw_sub_amsdu_hdr(skb);
+       sub_pad =3D CL_SKB_DATA_ALIGN_PADS(anchor_skb->len -
+                                        amsdu_anchor->hdrlen);
+       memset(skb_push(skb, sub_pad), 0, sub_pad);
+       memcpy(skb_put(anchor_skb, skb->len), skb->data, skb->len);
+
+       kfree_skb(skb);
+       amsdu_anchor->packet_cnt++;
+       anchor_sw_txhdr->sw_amsdu_packet_cnt++;
+       head_pad =3D CL_SKB_DATA_ALIGN_PADS(anchor_skb->data);
+
+       if (head_pad) {
+               anchor_sw_txhdr->map_len =3D anchor_skb->len + head_pad;
+               anchor_sw_txhdr->txdesc.host_info.host_padding |=3D BIT(0);
+       } else {
+               anchor_sw_txhdr->map_len =3D anchor_skb->len;
+               anchor_sw_txhdr->txdesc.host_info.host_padding =3D 0;
+       }
+
+       total_frame_len =3D anchor_skb->len;
+       if (key_conf)
+               total_frame_len +=3D key_conf->icv_len;
+
+       anchor_sw_txhdr->txdesc.umacdesc.packet_len[0] =3D cpu_to_le16(tota=
l_frame_len);
+
+       if (amsdu_anchor->packet_cnt =3D=3D cl_hw->conf->ci_tx_sw_amsdu_max=
_packets ||
+           syn_rst_push) {
+               if (tx_queue->num_packets =3D=3D 1)
+                       cl_txq_sched(cl_hw, tx_queue);
+               cl_tx_amsdu_anchor_init(amsdu_anchor);
+       }
+
+       return CL_AMSDU_SUB_FRAME_SET;
+}
+
+void cl_tx_amsdu_anchor_init(struct cl_amsdu_ctrl *amsdu_anchor)
+{
+       amsdu_anchor->rem_len =3D amsdu_anchor->max_len;
+       amsdu_anchor->sw_txhdr =3D NULL;
+       amsdu_anchor->packet_cnt =3D 0;
+       amsdu_anchor->is_sw_amsdu =3D false;
+}
+
+void cl_tx_amsdu_anchor_reset(struct cl_amsdu_ctrl *amsdu_anchor)
+{
+       amsdu_anchor->sw_txhdr =3D NULL;
+       amsdu_anchor->rem_len =3D 0;
+       amsdu_anchor->max_len =3D 0;
+       amsdu_anchor->packet_cnt =3D 0;
+       amsdu_anchor->is_sw_amsdu =3D false;
+}
+
+void cl_tx_amsdu_set_max_len(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u=
8 tid)
+{
+       struct ieee80211_sta_vht_cap *vht_cap =3D &cl_sta->stainfo->sta.vht=
_cap;
+       struct cl_amsdu_ctrl *amsdu_anchor =3D &cl_sta->amsdu_anchor[tid];
+       u32 length =3D U32_MAX;
+
+       amsdu_anchor->max_len =3D 3839;
+
+       if (cl_band_is_6g(cl_hw)) {
+               u16 capa =3D cl_sta->stainfo->sta.he_6ghz_capa.capa;
+
+               length =3D (capa & IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN) >>
+                       HE_6GHZ_CAP_MAX_MPDU_LEN_OFFSET;
+       } else if (vht_cap->vht_supported) {
+               length =3D vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK;
+       }
+
+       switch (length) {
+       case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
+               amsdu_anchor->max_len =3D 3895;
+               break;
+       case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
+               amsdu_anchor->max_len =3D 7991;
+               break;
+       case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
+               amsdu_anchor->max_len =3D 11454;
+               break;
+       default:
+               break;
+       }
+
+       amsdu_anchor->rem_len =3D amsdu_anchor->max_len;
+
+       cl_dbg_trace(cl_hw, "AMSDU supported - sta_idx=3D%u, max_len=3D%d\n=
",
+                    cl_sta->sta_idx, amsdu_anchor->max_len);
+}
+
+void cl_tx_amsdu_first_sub_frame(struct cl_sw_txhdr *sw_txhdr, struct cl_s=
ta *cl_sta,
+                                struct sk_buff *skb, u8 tid)
+{
+       /* Set the anchor sw_txhdr */
+       cl_sta->amsdu_anchor[tid].sw_txhdr =3D sw_txhdr;
+
+       INIT_LIST_HEAD(&sw_txhdr->amsdu_txhdr.list);
+       sw_txhdr->amsdu_txhdr.skb =3D skb;
+}
+
+void cl_tx_amsdu_flush_sub_frames(struct cl_hw *cl_hw, struct cl_sw_txhdr =
*sw_txhdr)
+{
+       struct cl_amsdu_txhdr *amsdu_txhdr =3D NULL, *tmp =3D NULL;
+       struct sk_buff *sub_skb =3D NULL;
+
+       /* Free mid & last AMSDU sub frames */
+       list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.l=
ist, list) {
+               sub_skb =3D amsdu_txhdr->skb;
+               list_del(&amsdu_txhdr->list);
+
+               dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+                                (size_t)sub_skb->len, DMA_TO_DEVICE);
+               kfree_skb(sub_skb);
+               cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+               cl_hw->tx_packet_cntr.drop.queue_flush++;
+       }
+
+       /* Free first AMSDU sub frame */
+       kfree_skb(sw_txhdr->skb);
+       cl_sw_txhdr_free(cl_hw, sw_txhdr);
+}
+
+void cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw, struct cl_sw_txhdr *=
sw_txhdr)
+{
+       /*
+        * Transfer all skbs in sw_txhdr to a temporary list, free sw_txhdr=
,
+        * and then push the temporary list to the single path.
+        */
+       struct cl_amsdu_txhdr *amsdu_txhdr, *tmp;
+       struct sk_buff *skb;
+       struct cl_sta *cl_sta =3D sw_txhdr->cl_sta;
+       u8 tid =3D sw_txhdr->tid;
+
+       /* Transfer first AMSDU sub frame */
+       _cl_tx_amsdu_transfer_single(cl_hw, sw_txhdr->skb, cl_sta, tid);
+
+       /* Transfer mid & last AMSDU sub frames */
+       list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.l=
ist, list) {
+               skb =3D amsdu_txhdr->skb;
+
+               list_del(&amsdu_txhdr->list);
+               dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+                                (size_t)skb->len, DMA_TO_DEVICE);
+               cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+
+               _cl_tx_amsdu_transfer_single(cl_hw, skb, cl_sta, tid);
+       }
+}
+
+int cl_tx_amsdu_set(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_=
buff *skb, u8 tid)
+{
+       struct cl_amsdu_ctrl *amsdu_anchor =3D &cl_sta->amsdu_anchor[tid];
+       struct cl_sw_txhdr *anchor_sw_txhdr =3D amsdu_anchor->sw_txhdr;
+       u16 packet_len =3D skb->len;
+       u8 packet_cnt;
+       bool is_mesh =3D ieee80211_vif_is_mesh(cl_sta->cl_vif->vif);
+
+       /* Check if anchor exist */
+       if (!anchor_sw_txhdr) {
+               /* Sanity check - skb len < amsdu_max_len */
+               if (unlikely(packet_len > amsdu_anchor->max_len) || is_mesh=
)
+                       return CL_AMSDU_SKIP;
+               else
+                       return cl_tx_amsdu_anchor_set(cl_hw, cl_sta, skb, t=
id);
+       }
+
+       if (amsdu_anchor->is_sw_amsdu)
+               return cl_tx_amsdu_sw_aggregate(cl_hw, amsdu_anchor, skb);
+
+       /*
+        * 1. Check if there is enough space in AMSDU
+        * 2. Check if A-MSDU packet count is less than maximum.
+        */
+       packet_cnt =3D amsdu_anchor->packet_cnt;
+
+       if (amsdu_anchor->rem_len > packet_len &&
+           packet_cnt < cl_hw->txamsdu_en &&
+           !is_mesh) {
+               struct cl_amsdu_txhdr *amsdu_txhdr =3D NULL;
+               u8 hdr_pads =3D CL_SKB_DATA_ALIGN_PADS(skb->data);
+               u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
+               u16 total_packet_len =3D packet_len + hdr_pads;
+               u16 curr_amsdu_len =3D amsdu_anchor->max_len - amsdu_anchor=
->rem_len;
+               dma_addr_t dma_addr;
+               /*
+                * High number of MSDUs in AMSDU can cause underrun in the
+                * E2W module.
+                * Therefore, host is required to set Num MSDU in AMSDU usi=
ng
+                * the following rules
+                *
+                * AMSDU Length      AMSDU agg size
+                * len  < 4*256      3 or less
+                * len >=3D 4*256      4 or less
+                * len >=3D 5*256      5 or less
+                * len >=3D 6*256      6 or less
+                * len >=3D 7*256      7 or less
+                * len >=3D 8*256      8 or less
+                */
+               u16 new_amsdu_len =3D curr_amsdu_len + packet_len;
+
+               if (ethertype >=3D ETH_P_802_3_MIN)
+                       total_packet_len +=3D sizeof(rfc1042_header);
+
+               if (packet_cnt >=3D CL_AMSDU_MIN_AGG_SIZE)
+                       if (new_amsdu_len < ((packet_cnt + 1) * CL_AMSDU_CO=
NST_LEN))
+                               return cl_tx_amsdu_anchor_set(cl_hw, cl_sta=
, skb, tid);
+
+               amsdu_txhdr =3D kmem_cache_alloc(cl_hw->amsdu_txhdr_cache, =
GFP_ATOMIC);
+               if (unlikely(!amsdu_txhdr)) {
+                       kfree_skb(skb);
+                       cl_dbg_err(cl_hw, "Failed to alloc amsdu txhdr\n");
+                       cl_hw->tx_packet_cntr.drop.amsdu_alloc_fail++;
+                       return CL_AMSDU_FAILED;
+               }
+
+               amsdu_txhdr->skb =3D skb;
+               list_add_tail(&amsdu_txhdr->list, &anchor_sw_txhdr->amsdu_t=
xhdr.list);
+
+               /* Update anchor fields */
+               amsdu_anchor->rem_len -=3D total_packet_len;
+               amsdu_anchor->packet_cnt++;
+
+               /* Get DMA address for skb */
+               dma_addr =3D dma_map_single(cl_hw->chip->dev, (u8 *)skb->da=
ta - hdr_pads,
+                                         packet_len + hdr_pads, DMA_TO_DEV=
ICE);
+               if (WARN_ON(dma_mapping_error(cl_hw->chip->dev, dma_addr)))=
 {
+                       kfree_skb(skb);
+                       cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+                       cl_dbg_err(cl_hw, "dma_mapping_error\n");
+                       cl_hw->tx_packet_cntr.drop.amsdu_dma_map_err++;
+                       return CL_AMSDU_FAILED;
+               }
+
+               /* Add AMSDU HDR len of the first packet */
+               if (amsdu_anchor->packet_cnt =3D=3D 2)
+                       total_packet_len +=3D CL_AMSDU_HDR_LEN;
+
+               amsdu_txhdr->dma_addr =3D dma_addr;
+
+               /* Update sw_txhdr packet_len, packet_addr, packet_cnt fiel=
ds */
+               cl_tx_amsdu_anchor_umacdesc_update(&anchor_sw_txhdr->txdesc=
, packet_cnt,
+                                                  packet_len, dma_addr, hd=
r_pads);
+
+               /* If we reached max AMSDU payload count, mark anchor as NU=
LL */
+               if (amsdu_anchor->packet_cnt >=3D cl_hw->txamsdu_en)
+                       cl_tx_amsdu_anchor_init(amsdu_anchor);
+
+               return CL_AMSDU_SUB_FRAME_SET;
+       }
+       /* Not enough space remain, set new anchor length is ok */
+       if (unlikely(packet_len > amsdu_anchor->max_len) || is_mesh) {
+               cl_tx_amsdu_anchor_init(amsdu_anchor);
+               return CL_AMSDU_SKIP;
+       } else {
+               return cl_tx_amsdu_anchor_set(cl_hw, cl_sta, skb, tid);
+       }
+}
+
+void cl_tx_amsdu_unset(struct cl_sw_txhdr *sw_txhdr)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+
+       tx_info->control.flags &=3D ~IEEE80211_TX_CTRL_AMSDU;
+
+       sw_txhdr->txdesc.e2w_txhdr_param.qos_ctrl &=3D
+                               ~cpu_to_le16(IEEE80211_QOS_CTL_A_MSDU_PRESE=
NT);
+}
+
+int cl_tx_amsdu_txhdr_init(struct cl_hw *cl_hw)
+{
+       char amsdu_txhdr_cache_name[MODULE_NAME_LEN + 32] =3D {0};
+
+       snprintf(amsdu_txhdr_cache_name, sizeof(amsdu_txhdr_cache_name),
+                "%s_amsdu_txhdr_cache", THIS_MODULE->name);
+
+       cl_hw->amsdu_txhdr_cache =3D kmem_cache_create(amsdu_txhdr_cache_na=
me,
+                                                    sizeof(struct cl_amsdu=
_txhdr),
+                                                    0,
+                                                    (SLAB_HWCACHE_ALIGN | =
SLAB_PANIC),
+                                                    NULL);
+
+       if (!cl_hw->amsdu_txhdr_cache) {
+               cl_dbg_err(cl_hw, "amsdu_txhdr_cache NULL\n");
+               return -1;
+       }
+
+       return 0;
+}
+
+void cl_tx_amsdu_txhdr_deinit(struct cl_hw *cl_hw)
+{
+       kmem_cache_destroy(cl_hw->amsdu_txhdr_cache);
+}
+
+void cl_tx_amsdu_txhdr_free(struct cl_hw *cl_hw, struct cl_amsdu_txhdr *am=
sdu_txhdr)
+{
+       kmem_cache_free(cl_hw->amsdu_txhdr_cache, amsdu_txhdr);
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

