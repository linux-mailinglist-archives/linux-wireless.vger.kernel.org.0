Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857359BA80
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiHVHo4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 03:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiHVHoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 03:44:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927B632C
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 00:44:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gi31so12972584ejc.5
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xE3O3gmdbSaLOzeWczgfxP1csbyjfh9vpvyX/L8Uyq0=;
        b=XnCBcCzadvp8TsmoLMtIXbpfmfM7LZUZYuyYaLs1tkBAPjZCieH5gxeSzF5t/QK2MW
         TmFB+Ij4+Fs7HXbhH3EVe54pgxCmAmI/TRBmj/oqG3wgzwuWCJp8U4tkwZOIn5FsUZP1
         QshRBD3wPwy8nc8v63/q80OEiXPnMR0hTiYGMemxvnwrVIvW1FDVDHs94SzeiNBtyB2A
         ffLqyFTgl9fVFi4pty4dECrTeoNcfBG3TgCM3a+QSfEQ7vrfQwaAEfYdZinZ7QlgBJp/
         /haONR4G/p+Fx4fWsSJk1Ke9/zwg8JFHIwfmXFsq0F3gej41PluWwu0sa2aU8EmMwdNU
         0ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xE3O3gmdbSaLOzeWczgfxP1csbyjfh9vpvyX/L8Uyq0=;
        b=nDbqk18hcZ1PLPGuKu5RRLl72t/1UEk0Ebiw2UxBjyXLyAqB2qpPldlLH2FdtDziSY
         PByrQxbY/SVTFJinPt1J+tC+nq+q+HbasicJBL+/ZmJ9cwTNnGnddTsFcY9NGZ7E0uwd
         9HU9CdAdkbcbhr7lVWMhcAQRneu0ym2h2/HQmdFaK3IhP6eueCszpH6WZpSPqDvTEw4E
         uPii2QVEfbc4dqpwVfYRcdEDI5bDLqTSB6KrqbQTLusSYOGo2nEoXOnyFhlytGdZ+rhJ
         95ZeZYGKljlNafzSm4k7D47AZ8d+tE92fyFMMLaducUB4KedWXBvEqi5KOJFvpCyspkw
         9tjQ==
X-Gm-Message-State: ACgBeo2rF7Yxte40GJUH2HyzcbC59zGNuDkuw3JV3k6P0Vt+wfcLlXdA
        wUkpMytmtlekgwO0rgXUCSVJSg==
X-Google-Smtp-Source: AA6agR40Ik2kvNRSbX1YRcJRnErDcejw2gWZpEtAUdHaocdR8yVISFAYSPggs2W3ig6+FiidRX0UNw==
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id di4-20020a170906730400b00730c3a8cd7amr11899595ejc.575.1661154262233;
        Mon, 22 Aug 2022 00:44:22 -0700 (PDT)
Received: from debian-hp-1.fritz.box (213.211.136.215.static.edpnet.net. [213.211.136.215])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709061f1500b0072eddcc807fsm5789771ejj.155.2022.08.22.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:44:21 -0700 (PDT)
From:   =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
Subject: [RFC PATCH 1/1] iw: add support for retrieving keys
Date:   Mon, 22 Aug 2022 09:43:18 +0200
Message-Id: <20220822074318.291949-2-raphael.melotte@mind.be>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822074318.291949-1-raphael.melotte@mind.be>
References: <20220822074318.291949-1-raphael.melotte@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For debugging purposes, it can be useful to be able to retrieve keys.

Add a "iw get key" command, to be able to retrieve keys when the key
index is known.

Example retrieving a pairwise key:
iw dev wlan0 get key 0 02:02:03:04:05:06

Example retrieving a group key:
iw dev wlan0 get key 1

Note that only the outer ATTR_KEY_DATA (and seq) is reported, the
nested KEY_DATA (and seq) within ATTR_KEY is not.

Signed-off-by: Raphaël Mélotte <raphael.melotte@mind.be>
---
 Makefile |  2 +-
 keys.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 keys.c

diff --git a/Makefile b/Makefile
index 33aaf6a..aa4ce7e 100644
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,7 @@ OBJS = iw.o genl.o event.o info.o phy.o \
 	mesh.o mpath.o mpp.o scan.o reg.o version.o \
 	reason.o status.o connect.o link.o offch.o ps.o cqm.o \
 	bitrate.o wowlan.o coalesce.o roc.o p2p.o vendor.o mgmt.o \
-	ap.o sha256.o nan.o bloom.o \
+	ap.o sha256.o nan.o bloom.o keys.o \
 	measurements.o ftm.o
 OBJS += sections.o
 
diff --git a/keys.c b/keys.c
new file mode 100644
index 0000000..3cb2950
--- /dev/null
+++ b/keys.c
@@ -0,0 +1,77 @@
+#include <errno.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include "nl80211.h"
+#include "iw.h"
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
+		argv++;
+		argc--;
+	}
+
+	/* mac */
+	if (argc) {
+		if (mac_addr_a2n(mac, argv[0]) == 0) {
+			NLA_PUT(msg, NL80211_ATTR_MAC, 6, mac);
+			argv++;
+			argc--;
+			nla_put_u32(msg, NL80211_ATTR_KEY_TYPE, NL80211_KEYTYPE_PAIRWISE);
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
+
+COMMAND(get, key, "",
+	NL80211_CMD_GET_KEY, 0, CIB_NETDEV, handle_get_key,
+	"<key index> <MAC address> <pairwise>\n");
-- 
2.37.1

