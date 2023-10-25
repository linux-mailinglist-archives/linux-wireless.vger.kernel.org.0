Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40027D71A2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJYQWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJYQWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 12:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774891
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 09:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45F2C433C7;
        Wed, 25 Oct 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698250927;
        bh=Q4J6Dffc3q5PWdgWmRB3IZ2LYtpt04/UvFaVkkyJyno=;
        h=From:To:Cc:Subject:Date:From;
        b=FOtbQR9dXqxXC+HsGXAsWb+9SDQB0Dxdpj3ZNLkhGQncx7+ACS2CLTNdHyV4xQ+9u
         K6EsShyjN5ARObfT6jC0oVPxw/ganpWUJdPT8uOOZlO5DaaKgUCyUoaDU7uqm690yP
         NVoQC1TCIdG3Zj4Yaz0rf5AYc7GHDZPlbkI9IPnNJjcjh/9wVnSGXZI2VzevauWsv/
         YT6NnuSmuM6/oOrCwu4SY7G9j/9pe3vShCRskBrMnN7JFksqGuxLnJmMj3xtTCv7tl
         uI+qWLCgE5F3ut2rWIbACXEc9hXWnsTXwnBPqDLsyaytfb4rT4gGd1BJMfhsEi8uDx
         64AXTjTMPOVqA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        Jakub Kicinski <kuba@kernel.org>, j.vosburgh@gmail.com,
        andy@greyhouse.net, dsahern@kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, johannes@sipsolutions.net,
        razor@blackwall.org, idosch@nvidia.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH net-next] netlink: make range pointers in policies const
Date:   Wed, 25 Oct 2023 09:22:04 -0700
Message-ID: <20231025162204.132528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

struct nla_policy is usually constant itself, but unless
we make the ranges inside constant we won't be able to
make range structs const. The ranges are not modified
by the core.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: j.vosburgh@gmail.com
CC: andy@greyhouse.net
CC: dsahern@kernel.org
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: vinicius.gomes@intel.com
CC: johannes@sipsolutions.net
CC: razor@blackwall.org
CC: idosch@nvidia.com
CC: linux-wireless@vger.kernel.org
---
 drivers/net/bonding/bond_netlink.c | 2 +-
 drivers/net/vxlan/vxlan_mdb.c      | 2 +-
 include/net/netlink.h              | 4 ++--
 net/ipv6/ioam6_iptunnel.c          | 2 +-
 net/sched/sch_fq.c                 | 2 +-
 net/sched/sch_fq_pie.c             | 2 +-
 net/sched/sch_qfq.c                | 2 +-
 net/sched/sch_taprio.c             | 2 +-
 net/wireless/nl80211.c             | 2 +-
 tools/net/ynl/ynl-gen-c.py         | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 27cbe148f0db..cfa74cf8bb1a 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -85,7 +85,7 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 }
 
 /* Limit the max delay range to 300s */
-static struct netlink_range_validation delay_range = {
+static const struct netlink_range_validation delay_range = {
 	.max = 300000,
 };
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 5e041622261a..3a21389658ce 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -311,7 +311,7 @@ vxlan_mdbe_src_list_pol[MDBE_SRC_LIST_MAX + 1] = {
 	[MDBE_SRC_LIST_ENTRY] = NLA_POLICY_NESTED(vxlan_mdbe_src_list_entry_pol),
 };
 
-static struct netlink_range_validation vni_range = {
+static const struct netlink_range_validation vni_range = {
 	.max = VXLAN_N_VID - 1,
 };
 
diff --git a/include/net/netlink.h b/include/net/netlink.h
index aba2b162a226..83bdf787aeee 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -360,8 +360,8 @@ struct nla_policy {
 		const u32 mask;
 		const char *reject_message;
 		const struct nla_policy *nested_policy;
-		struct netlink_range_validation *range;
-		struct netlink_range_validation_signed *range_signed;
+		const struct netlink_range_validation *range;
+		const struct netlink_range_validation_signed *range_signed;
 		struct {
 			s16 min, max;
 		};
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index f6f5b83dd954..7563f8c6aa87 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -46,7 +46,7 @@ struct ioam6_lwt {
 	struct ioam6_lwt_encap	tuninfo;
 };
 
-static struct netlink_range_validation freq_range = {
+static const struct netlink_range_validation freq_range = {
 	.min = IOAM6_IPTUNNEL_FREQ_MIN,
 	.max = IOAM6_IPTUNNEL_FREQ_MAX,
 };
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index bf9d00518a60..0fd18c344ab5 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -897,7 +897,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 	return 0;
 }
 
-static struct netlink_range_validation iq_range = {
+static const struct netlink_range_validation iq_range = {
 	.max = INT_MAX,
 };
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 68e6acd0f130..5b595773e59b 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -202,7 +202,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_CN;
 }
 
-static struct netlink_range_validation fq_pie_q_range = {
+static const struct netlink_range_validation fq_pie_q_range = {
 	.min = 1,
 	.max = 1 << 20,
 };
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 5598f8be18ae..28315166fe8e 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -213,7 +213,7 @@ static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 	return container_of(clc, struct qfq_class, common);
 }
 
-static struct netlink_range_validation lmax_range = {
+static const struct netlink_range_validation lmax_range = {
 	.min = QFQ_MIN_LMAX,
 	.max = QFQ_MAX_LMAX,
 };
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1cb5e41c0ec7..2e1949de4171 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1015,7 +1015,7 @@ static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 							      TC_FP_PREEMPTIBLE),
 };
 
-static struct netlink_range_validation_signed taprio_cycle_time_range = {
+static const struct netlink_range_validation_signed taprio_cycle_time_range = {
 	.min = 0,
 	.max = INT_MAX,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2650543dcebe..2f8353bf603c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -463,7 +463,7 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
-static struct netlink_range_validation nl80211_punct_bitmap_range = {
+static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
 };
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 0fee68863db4..31fd96f14fc0 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2038,7 +2038,7 @@ _C_KW = {
                 first = False
 
             sign = '' if attr.type[0] == 'u' else '_signed'
-            cw.block_start(line=f'struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
+            cw.block_start(line=f'static const struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
                 members.append(('min', attr.get_limit('min')))
-- 
2.41.0

