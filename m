Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E76220E8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKIAiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKIAiW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:38:22 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89DF327
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:38:21 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y13so15254502pfp.7
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qOLqzDQ0leWDK0S599u/0XvplBF43BD27gReNL8w/k=;
        b=R3cKBsfFh3KrVU3SYxB4tcpFsxBLfSRemjgV6+JL3gLUprCseBipvq3GlLE+V9DdWU
         S0xOmLarqge686WvPVDEHAtZRilVRxmaru2eHRJxzarT0dbcaL0M5O/NqGrYUN8jxten
         T2F5UTDO7Uif/DAlQZcTiti2fvw8thciq1aWs7AefykE2hcGU/kIbXGfEOQZ/X+PVu39
         kDajZrOuafCy7wzGhp+hSX51Nl0/PWMfj1KhUujZYdxV0x179wkgc3gisAMuDE/Ml0NM
         U0TkhUCoDnhXB5SD3ltK9kPwcoShByH6Nrhk1q+/g2NYsaGY3hqE1FSTqXxS7j1a7tOJ
         qGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qOLqzDQ0leWDK0S599u/0XvplBF43BD27gReNL8w/k=;
        b=4RI9oolwScS08Rh9cVgPQoqp1cucHFEpNindFzk9QsWR4T8DV6FtpP+ukjJJS6bGzQ
         Dy67JvHD5AA6uoOhYdAyzl5NXKrOW3YC4YXU1+zXLPEX1wAMdysS0hPJHsU+x8T4E8Iv
         Cwf3IRJWzfFXoA53i5R3D9WoACB02/aDYUd0DD4nsK8roLNsQhqfeYt6TT6y97urkncx
         O8fxb5hJcCD6kvHuj69OMqSp19Yk6MgTgwMv98WRVtLQgJ1iaaI/Vvt9lV66w63F6wWU
         xAZlspELM7sWuq+2lyBYC1uLct+RE+CMnGDmNqYrYQMdotmQRcTPqKTR73jXhk40Yy07
         UZAw==
X-Gm-Message-State: ACrzQf3GgDDTBs1bwKS2jwzh4iDzL4Sy2PpM1fEf78DkswAT7tUCuh4r
        +Ii2y2g+d8T60/yDC+clJ5ERmXIx4QKW1w==
X-Google-Smtp-Source: AMsMyM7tjPyoFAsAhI+DUXzLnZdTZyXme2wIXHi2gjrgRcx4sQCqPTuDGhaDgOx/LbqcJqMV8VM04A==
X-Received: by 2002:a63:2364:0:b0:46f:5de2:30d1 with SMTP id u36-20020a632364000000b0046f5de230d1mr49421855pgm.304.1667954301435;
        Tue, 08 Nov 2022 16:38:21 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001714c36a6e7sm7502726plf.284.2022.11.08.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:38:20 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2 3/4] wifi: nl80211: update attributes netlink for S1G short beacon
Date:   Wed,  9 Nov 2022 13:37:26 +1300
Message-Id: <20221109003727.614882-3-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109003727.614882-1-gilad.itzkovitch@morsemicro.com>
References: <20221109003727.614882-1-gilad.itzkovitch@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Add short beacon period and tail attributes for user configuration

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..ef6318012965 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2751,6 +2751,10 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: S1G short beacon period in TUs.
+ * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the short beacon after the TIM.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3280,6 +3284,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+	NL80211_ATTR_SHORT_BEACON_TAIL,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4963,6 +4970,7 @@ enum nl80211_bss_scan_width {
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
  * @NL80211_BSS_MLD_ADDR: MLD address of this BSS if connected to it.
+ * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4990,6 +4998,7 @@ enum nl80211_bss {
 	NL80211_BSS_FREQUENCY_OFFSET,
 	NL80211_BSS_MLO_LINK_ID,
 	NL80211_BSS_MLD_ADDR,
+	NL80211_BSS_SHORT_BEACON_PERIOD,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 148f66edb015..6a8b1e935d58 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = { .type = NLA_U16 },
+	[NL80211_ATTR_SHORT_BEACON_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
+				       IEEE80211_MAX_DATA_LEN),
+
 };
 
 /* policy for the key attributes */
@@ -5440,6 +5445,12 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		haveinfo = true;
 	}
 
+	if (attrs[NL80211_ATTR_SHORT_BEACON_TAIL]) {
+		bcn->short_tail = nla_data(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		bcn->short_tail_len = nla_len(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		haveinfo = true;
+	}
+
 	if (!haveinfo)
 		return -EINVAL;
 
@@ -5804,6 +5815,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
 	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
+	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
+		params->short_beacon_period =
+			nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]) == 0 ?
+				1 : nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
 
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params->beacon_interval);
-- 
2.34.1

