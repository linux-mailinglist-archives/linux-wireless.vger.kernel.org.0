Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62656D25D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiGKBJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGKBJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C97A47D
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f11so2617781pgj.7
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWihvkUSKIGivzcP1YXtA/DPAqQK57hLC5nzlOA+jRM=;
        b=e08PkTGOJJ2e3R2jH2lGYGhDbeMmWyALvabgwED2WK3XUDvg1nkpodJg/m2uMYC6KR
         OjCTPUCyi1vereghSC3ONavx8cfONssU45z14vqARFttPcu8+Ud9dG3+5Qe5rltnITEi
         ImR5NKmo1JyTM4ftDDcJf0JuwHyaN7rvO3mkhtLwW2Jurm8ztz2Jw/edZmb4sFMiB0Lh
         JaWo1ow8I2QoAwZqY76jPp6z2yaPUEYwUzjsUx7S0kkt8wJIIWe51ctHK9ld6t8ag/G1
         pNNG7Puxd8PokBtSIaKPLhs++6sFXfYXFOr9ULGYM0zZiQC1GaDEHXquEtE9aN1gIvdq
         rIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWihvkUSKIGivzcP1YXtA/DPAqQK57hLC5nzlOA+jRM=;
        b=pUo5NI8Qy4E6yfK8cGKN9wjajRW2FguxeNi+AVruSa3KPmQVtCvGaFGDL+dAFe3vVI
         3rNqv0pXz2LoDjKpTtUd3xsCf5MezPIgs9klvfAEhw6y4B5wUi2biPqY+m3J63iGplXu
         ha+Dk6v3KPyJvbucbquJQqksyIqd4nIdFpNxUFwnxtMTPKK7YeVVqUyo/sdv0xB/Spfr
         viu4SjWxrpQBrg9ZxYaauamnPCdtVmf8iU1rRGHNt3OF2TQnlAYmeD9NQQne6rNUAiWL
         5hncQCC3d0wWCv/4oC/puZw+ABjPrGJ5Rzl5tZUnq/GMX+9A3bwPCM0D8AkzR2G1IJap
         +bVA==
X-Gm-Message-State: AJIora/iRClYCaUtnibuViN4HOIzS+nh2QDyI1VabAY6iDes5Rn24l9q
        p2Eu5h2X6kTkYJDm+ht2S4UWFQ==
X-Google-Smtp-Source: AGRyM1sWefQTvt/L95aFPWGO5MI4V+SqpjypcEoUm67ng2hltIPK/nxkocTA/gFmbnTm3DbBXbA3hA==
X-Received: by 2002:a63:86c2:0:b0:415:eb:d166 with SMTP id x185-20020a6386c2000000b0041500ebd166mr13268946pgd.124.1657501744199;
        Sun, 10 Jul 2022 18:09:04 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:03 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 04/12] nl80211: support setting S1G short beacon period
Date:   Mon, 11 Jul 2022 01:08:08 +0000
Message-Id: <20220711010816.45927-5-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the kernel able to send both short and long S1G beacons, include
the ability for setting the short beacon period.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 include/uapi/linux/nl80211.h | 6 ++++++
 net/wireless/nl80211.c       | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 89f64f46b98d..bd6e2cae1dd3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2694,6 +2694,8 @@ enum nl80211_commands {
  *	connection. Used with %NL80211_CMD_CONNECT. If this attribute is not
  *	included in NL80211_CMD_CONNECT drivers must not perform MLO connection.
  *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: S1G short beacon period in TUs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3214,6 +3216,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MLO_SUPPORT,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4890,6 +4894,7 @@ enum nl80211_bss_scan_width {
  *	Contains a nested array of signal strength attributes (u8, dBm),
  *	using the nesting index as the antenna number.
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
+ * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4915,6 +4920,7 @@ enum nl80211_bss {
 	NL80211_BSS_PARENT_BSSID,
 	NL80211_BSS_CHAIN_SIGNAL,
 	NL80211_BSS_FREQUENCY_OFFSET,
+	NL80211_BSS_SHORT_BEACON_PERIOD,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6a45801c783c..ab47e4130141 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -798,6 +798,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -5654,6 +5655,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
 	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
+	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
+		params->short_beacon_period =
+			nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
 
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params->beacon_interval);
-- 
2.25.1

