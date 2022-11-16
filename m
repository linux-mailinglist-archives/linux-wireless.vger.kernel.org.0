Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218F62B108
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiKPCIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 21:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPCIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 21:08:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA215F8E
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o7so15249748pjj.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FfwAArrJtllZNErLo7qsFDrMs2eM0OvaCtZlTHCnGM=;
        b=ehRSiLU0TqoRPvXMalMKNo1U/fR1uKLNSi55quDK3wyVP3GzMW1TpCtVA/EocHeY4E
         pXsBHGghmG5KUzej9pZf3wK4LVM140U7khStP6zgJNO4ET9Yr4meYwt4xct+7Ekhzm9F
         rF1r8UYA4lN0XbjfiqWnaJtafLQdte+iXt/A+lEPh8GgY3C1S84kyP0K1QNEyiZniEfp
         N7QoOVhBjsvRhAvbmiVUjItg1/ZyucKomfQR47Ubuu4Qm9Nx8V2OhwjQwlAwVsctsd/Q
         QW9NvxNnw2AjoVZnu6EwCg6ZO1876yNA+dzrFA5rSW+Ok48qJvX2bI8NA6D8qB8Dwv3M
         enGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FfwAArrJtllZNErLo7qsFDrMs2eM0OvaCtZlTHCnGM=;
        b=K9QwB9mprAQqaqNdR+nP9j47FW9wNfluBsda5yW24MHQD+fZFMPAR+v3Htc86lGdzn
         fngsRNYn2o2jKuF8WhagzZiourbWic4t/Wf5/fwCooP5xTApVknmQse/5NTvWpUUP8G1
         V/5mylhRs0tLwOWv/9lankvRiMLzdvm6wPo5LAWCwYMpuS8P4r0xiJiafIttPAFhq4MR
         MoZnTkvm3mTlAj1h2iVZyso3f1BOcGDl61z72t8KYmkM+yek0d8cjq1hjle1hGjUs6br
         SWqRMBC9sI6pVs0U6aUoD96M3EiW8yiVIQZkNTvyTvMtxU2js/RZpUunypOPW7HO96Ue
         LSYw==
X-Gm-Message-State: ANoB5pmfR+GrwGbW2KxEEe2reTZNSNSDOw3ONLXkWP4oHnxlu+qbuIZp
        3saC5ye0ExjypUIBVe+yEAufBQ==
X-Google-Smtp-Source: AA0mqf5nW8GUFMc9dtQtMmj58VHP5/ycUlirtgDRb7dOjNICfCdpdZF68ReTD66GZYuAk+ZzNgj+YA==
X-Received: by 2002:a17:90b:3e8b:b0:212:c6f4:fa5 with SMTP id rj11-20020a17090b3e8b00b00212c6f40fa5mr1382421pjb.49.1668564528899;
        Tue, 15 Nov 2022 18:08:48 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm9379231pfg.167.2022.11.15.18.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:08:48 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v3 3/4] wifi: nl80211: update attributes netlink for S1G short beacon
Date:   Wed, 16 Nov 2022 15:06:59 +1300
Message-Id: <20221116020700.3907453-3-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
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

Add short beacon period, head and tail attributes for user
configuration

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/nl80211.c       | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..04bd39ee9d1d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2751,6 +2751,11 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: S1G short beacon period in TUs.
+ * @NL80211_ATTR_SHORT_BEACON_HEAD: portion of the short beacon before the TIM IE.
+ * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the short beacon after the TIM.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3280,6 +3285,10 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+	NL80211_ATTR_SHORT_BEACON_HEAD,
+	NL80211_ATTR_SHORT_BEACON_TAIL,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4963,6 +4972,7 @@ enum nl80211_bss_scan_width {
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
  * @NL80211_BSS_MLD_ADDR: MLD address of this BSS if connected to it.
+ * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4990,6 +5000,7 @@ enum nl80211_bss {
 	NL80211_BSS_FREQUENCY_OFFSET,
 	NL80211_BSS_MLO_LINK_ID,
 	NL80211_BSS_MLD_ADDR,
+	NL80211_BSS_SHORT_BEACON_PERIOD,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 148f66edb015..fca6e223c2c7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -231,12 +231,18 @@ static int validate_beacon_head(const struct nlattr *attr,
 	const struct ieee80211_mgmt *mgmt = (void *)data;
 	unsigned int fixedlen, hdrlen;
 	bool s1g_bcn;
+	bool s1g_short_bcn;
 
 	if (len < offsetofend(typeof(*mgmt), frame_control))
 		goto err;
 
 	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
-	if (s1g_bcn) {
+	s1g_short_bcn = ieee80211_is_s1g_short_beacon(mgmt->frame_control);
+	if (s1g_short_bcn) {
+		fixedlen = offsetof(struct ieee80211_ext,
+				    u.s1g_short_beacon.variable);
+		hdrlen = offsetof(struct ieee80211_ext, u.s1g_short_beacon);
+	} else if (s1g_bcn) {
 		fixedlen = offsetof(struct ieee80211_ext,
 				    u.s1g_beacon.variable);
 		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
@@ -805,6 +811,14 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = { .type = NLA_U16 },
+	[NL80211_ATTR_SHORT_BEACON_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head,
+				       IEEE80211_MAX_DATA_LEN),
+	[NL80211_ATTR_SHORT_BEACON_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
+				       IEEE80211_MAX_DATA_LEN),
+
 };
 
 /* policy for the key attributes */
@@ -5440,6 +5454,18 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		haveinfo = true;
 	}
 
+	if (attrs[NL80211_ATTR_SHORT_BEACON_HEAD]) {
+		bcn->short_head = nla_data(attrs[NL80211_ATTR_SHORT_BEACON_HEAD]);
+		bcn->short_head_len = nla_len(attrs[NL80211_ATTR_SHORT_BEACON_HEAD]);
+		haveinfo = true;
+	}
+
+	if (attrs[NL80211_ATTR_SHORT_BEACON_TAIL]) {
+		bcn->short_tail = nla_data(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		bcn->short_tail_len = nla_len(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		haveinfo = true;
+	}
+
 	if (!haveinfo)
 		return -EINVAL;
 
@@ -5804,6 +5830,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

