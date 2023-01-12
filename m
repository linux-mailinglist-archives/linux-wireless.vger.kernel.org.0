Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432EA667221
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjALM0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 07:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjALM02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 07:26:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291EDF5C
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 04:26:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vm8so44340894ejc.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/LhSJWdVZlvQfQaNC9rzUpRhz1tywLm8YHQ9yO+mN4=;
        b=OKKxvcr18z/AmHH6P6s5993lLAC3+nM0yjsE7J/dgShbBIrt18M76f1+GKY7R0rsWy
         lqD64ZNq8+/gt3yU04QngpYFFuROCOVTSe5+f0+ymYhc3hjSnp6ibENQiLlW6Opn4gh8
         I+V80PvMI1Li0cEk2MDdu3o1ZlBxsEDgPgnrF2IMVjgmnSFVg5sIMNlSWxeK6bukjUjk
         oXbnnIeYZTh0BfpM8JQJJEWofsFuQDwxIOIyxOT2WkBFGTLCIEvDtD6XCNP5EEJeRAQF
         PxpBi7bG8MOsBg6Vxi0/dNo4fiBWlNcp9qlgQCeNoBJkbF8CGTQkdchWvZxAainUJqua
         Thdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/LhSJWdVZlvQfQaNC9rzUpRhz1tywLm8YHQ9yO+mN4=;
        b=mPFV8l9Hm9cUuf6FznbbHO61yrAMwG/0cPct/Q59VLLpnlYb/cf+YfnFbbyWma/+Fn
         a36fmOvX28FEody0A+FaRPF7xi/rWcVpHIKuFrBAY0qWTLWlR88QsoyOm4SgprAI9kPf
         zkeDQ51IKEVT/sYeymAP+Ep5CN+Zr7wLfei7NgFSGH2LDnIvYBKm9+1bHiixbVU194Ey
         SjpNbGJhcljP9PwpVY8y0M/Iiby+BussYqnIWMsHMXlOd9HeeSYizAMy5V4ux+KYUIWd
         igC+asZVnln+4KoFl95NR22Px4qWUIxjVFm1ydo8olT9EKdAt5iYYi7eU9/3YpRLGqx6
         IV+A==
X-Gm-Message-State: AFqh2kohHDXKpoSgeQeE54t2mhdx3syVaJNGY4/Uq/hq9FzpPWL0aPda
        Cxqp71Sg1Gn/U9wauKwVYVPhow==
X-Google-Smtp-Source: AMrXdXuQ7BKfC73WpUZngqD9MOJ0D4b7XtWr8z2ZUI9IVi5aHALUq5o3gC6bsX89POBNNpCTKNTtOQ==
X-Received: by 2002:a17:907:8c0c:b0:7fd:f1b5:7fd5 with SMTP id ta12-20020a1709078c0c00b007fdf1b57fd5mr68954774ejc.19.1673526385715;
        Thu, 12 Jan 2023 04:26:25 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm7359499ejh.0.2023.01.12.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:26:25 -0800 (PST)
From:   =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
Subject: [PATCH v3 1/1] iw: add support for retrieving keys
Date:   Thu, 12 Jan 2023 13:25:25 +0100
Message-Id: <20230112122525.2257298-1-raphael.melotte@mind.be>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230102111213.77129-1-raphael.melotte@mind.be>
References: <20230102111213.77129-1-raphael.melotte@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For debugging purposes, it can be useful to be able to retrieve keys.

Add a "iw key get" command, to be able to retrieve keys when the key
index is known. A new "key" section is also introduced, in preparation
for future key-related commands.

Example retrieving a pairwise key:
iw dev wlan0 key get 0 02:02:03:04:05:06

Example retrieving a group key:
iw dev wlan0 key get 1

Note that only the outer ATTR_KEY_DATA (and seq) is reported, the
nested KEY_DATA (and seq) within ATTR_KEY is not.

Signed-off-by: Raphaël Mélotte <raphael.melotte@mind.be>
---
Changes v2 -> v3:
  - Check parsing of index.
  - Move pairwise type before argv++ and add line break.

Changes v1 -> v2:
  - Introduce a 'key' section and update commit message
  - Fix documentation (and remove pairwise flag)
  - Return error when MAC is invalid
  - Rebase on master
 keys.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 keys.c

diff --git a/keys.c b/keys.c
new file mode 100644
index 0000000..65aa426
--- /dev/null
+++ b/keys.c
@@ -0,0 +1,83 @@
+#include <errno.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include "nl80211.h"
+#include "iw.h"
+
+SECTION(key);
+
+static int print_keys(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL80211_ATTR_MAX + 1];
+
+	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!tb[NL80211_ATTR_KEY_IDX]) {
+		fprintf(stderr, "KEY_IDX missing!\n");
+		return NL_SKIP;
+	}
+
+	if (!tb[NL80211_ATTR_KEY_DATA]) {
+		fprintf(stderr, "ATTR_KEY_DATA missing!\n");
+		return NL_SKIP;
+	}
+
+	iw_hexdump("Key", nla_data(tb[NL80211_ATTR_KEY_DATA]),
+		   nla_len(tb[NL80211_ATTR_KEY_DATA]));
+
+	if (!tb[NL80211_ATTR_KEY_SEQ]) {
+		fprintf(stderr, "ATTR_KEY_SEQ missing!\n");
+		return NL_SKIP;
+	}
+
+	iw_hexdump("Key seq", nla_data(tb[NL80211_ATTR_KEY_SEQ]),
+		   nla_len(tb[NL80211_ATTR_KEY_SEQ]));
+
+	return NL_OK;
+}
+
+static int handle_get_key(struct nl80211_state *state,
+			  struct nl_msg *msg, int argc, char **argv,
+			  enum id_input id)
+{
+	char *end;
+	unsigned char mac[6];
+
+	/* key index */
+	if (argc) {
+		nla_put_u8(msg, NL80211_ATTR_KEY_IDX, strtoul(argv[0], &end, 10));
+		if (*end != '\0')
+			return -EINVAL;
+		argv++;
+		argc--;
+	}
+
+	/* mac */
+	if (argc) {
+		if (mac_addr_a2n(mac, argv[0]) == 0) {
+			NLA_PUT(msg, NL80211_ATTR_MAC, 6, mac);
+			nla_put_u32(msg, NL80211_ATTR_KEY_TYPE,
+				    NL80211_KEYTYPE_PAIRWISE);
+			argv++;
+			argc--;
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		nla_put_u32(msg, NL80211_ATTR_KEY_TYPE, NL80211_KEYTYPE_GROUP);
+	}
+
+	register_handler(print_keys, NULL);
+	return 0;
+
+ nla_put_failure:
+	return -ENOSPC;
+}
+COMMAND(key, get, "<key index> <MAC address>",
+	NL80211_CMD_GET_KEY, 0, CIB_NETDEV, handle_get_key,
+	"Retrieve a key and key sequence.\n");
-- 
2.38.1

