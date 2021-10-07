Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5D424F95
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGI6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 04:58:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40558 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhJGI6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 04:58:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1978uRQP1003661, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1978uRQP1003661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Oct 2021 16:56:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 7 Oct 2021 16:56:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 7 Oct 2021
 16:56:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <cjhuang@codeaurora.org>,
        <kevin_yang@realtek.com>
Subject: [PATCH] iw: add set sar_specs command
Date:   Thu, 7 Oct 2021 16:56:15 +0800
Message-ID: <20211007085615.40399-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/07/2021 08:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzcgpFekyCAwNjo0MzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/07/2021 08:45:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166567 [Oct 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/07/2021 08:48:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add set sar_specs command

usage: iw <phy> set sar_specs <sar type> <range index:sar power>*
e.g.
iw phy0 set sar_specs 0 0:100 1:90 2:80...
where sar type should correspond to wiphy's sar_capa,
and range index should be valid in wiphy's sar_capa.

For now, kernel sar type supports only 0 (NL80211_SAR_TYPE_POWER)
which means that the sar power limitation is specified in 0.25dBm unit.

Cc: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 sar.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 sar.c

diff --git a/sar.c b/sar.c
new file mode 100644
index 0000000..5ab54ec
--- /dev/null
+++ b/sar.c
@@ -0,0 +1,71 @@
+#include <errno.h>
+#include <string.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "nl80211.h"
+#include "iw.h"
+
+static int set_sar_specs(struct nl80211_state *state,
+			 struct nl_msg *msg,
+			 int argc, char **argv,
+			 enum id_input id)
+{
+	struct nlattr *nl_sar, *nl_specs, *nl_sub;
+	enum nl80211_sar_type type;
+	__u32 idx;
+	__s32 pwr;
+	char *tmp;
+	int count, i;
+
+	if (argc <= 1)
+		return -EINVAL;
+
+	type = atoi(argv[0]);
+
+	nl_sar = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
+	if (!nl_sar)
+		goto nla_put_failure;
+
+	NLA_PUT_U32(msg, NL80211_SAR_ATTR_TYPE, type);
+
+	nl_specs = nla_nest_start(msg, NL80211_SAR_ATTR_SPECS);
+	if (!nl_specs)
+		goto nla_put_failure;
+
+	for (i = 1; i < argc; i++) {
+		tmp = strchr(argv[i], ':');
+		if (!tmp)
+			return -EINVAL;
+
+		if (tmp != strrchr(argv[i], ':'))
+			return -EINVAL;
+
+		count = sscanf(argv[i], "%u:%d", &idx, &pwr);
+		if (count != 2)
+			return -EINVAL;
+
+		nl_sub = nla_nest_start(msg, i - 1);
+		if (!nl_sub)
+			goto nla_put_failure;
+
+		NLA_PUT_U32(msg, NL80211_SAR_ATTR_SPECS_RANGE_INDEX, idx);
+		NLA_PUT_S32(msg, NL80211_SAR_ATTR_SPECS_POWER, pwr);
+
+		nla_nest_end(msg, nl_sub);
+	}
+
+	nla_nest_end(msg, nl_specs);
+	nla_nest_end(msg, nl_sar);
+
+	return 0;
+
+ nla_put_failure:
+	return -ENOBUFS;
+}
+
+COMMAND(set, sar_specs, "<sar type> <range index:sar power>*",
+	NL80211_CMD_SET_SAR_SPECS, 0, CIB_PHY, set_sar_specs,
+	"Set SAR specs corresponding to SAR capa of wiphy.");
-- 
2.25.1

