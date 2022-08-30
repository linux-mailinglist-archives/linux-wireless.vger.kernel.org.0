Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717C5A5942
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiH3CUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH3CUu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA57E013
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f4so9362594pgc.12
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=94HBYAbisDAuvh8wguvjigNQ4uVcXLkynJD9kKl9mlw=;
        b=haGMmpEt2yZhM7gvv9GZ7Fukx1Bw4xm1msoG3P05iocWzITjq1d9sEYw9b9O7Ntbst
         fADkgDUGNuwQ5K5jSJrEFjx/9Bz7Ty4ba3++evOH8MTY4xDyiYQq4dm5NwoeX35ch5QJ
         3zPCJ/6PxqWM7xu0Or36wpuG2rafxmpLQ7uMuV1W6sDki/PJF23vTUgJc6L8U+ZRN+ng
         pZnwSZdTwkU6B/sSe1/8QFx+S4X1vwpbv4udGbhXcSQeS03TOsOv8W39ev3bRUB6w5SA
         0nvvTxz4LCBeTxBYhpwAwUFa3Z3fCQ+Oz+JVAy79EkKBEOxh+IvooVzzcMw9h0lgfyqP
         romg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=94HBYAbisDAuvh8wguvjigNQ4uVcXLkynJD9kKl9mlw=;
        b=xJsK8fvTrjZv+xOIG5A2asprdA7U7dg5JsKxQP9X9nKI6nS5euaPKsK7EbKruhN5Dr
         ON/BXaExJmZkHJJD2qEqVbti/wMFKdL0Hb2cYFnYNPSr3lekqdzSQe8tZ4kEl43Hi3js
         3tb2e/hc97hcMnleE6jewFI/YKFdrsaSIlBOuhYtLfDsY0i+UlJzYvkqzfvETXm2YKxv
         +Q4sJ5OopYo0oMBWa5Ikl7SxE6N6ct3LhxVV1t10EFf6tIRogzUqbhLAMKGWngDtHOLF
         2DQq1vSzB1GM2JZbC394+fHd4JS97xkBz/x3VsfM3uOGrNsPWlQkfnX9NlRqPBduLAOi
         yr0Q==
X-Gm-Message-State: ACgBeo3mCBPYzbkDITNGcopPOvug1TEOi0ybnMzjDaTxu92tEwu6dO8n
        DAHCnGoGoViDwAcDbSdba/JsuQ==
X-Google-Smtp-Source: AA6agR4t6FdWu/c3d9cpdtEiMOAGhN9MvvipD096JHc/STq54DFJbWesQe1r9jiaZMDUSKhbrxUyjw==
X-Received: by 2002:a65:6ccf:0:b0:42b:20e8:5b8a with SMTP id g15-20020a656ccf000000b0042b20e85b8amr15653911pgw.500.1661826049491;
        Mon, 29 Aug 2022 19:20:49 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:49 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 04/12] nl80211: support setting S1G short beacon period
Date:   Tue, 30 Aug 2022 02:20:09 +0000
Message-Id: <20220830022017.51017-5-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
---
 include/uapi/linux/nl80211.h | 7 +++++++
 net/wireless/nl80211.c       | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ffb7c573e299..7daa2ce1cb57 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2741,6 +2741,9 @@ enum nl80211_commands {
  *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
  *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
  *	the incoming frame RX timestamp.
+ *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: S1G short beacon period in TUs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3269,6 +3272,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_TX_HW_TIMESTAMP,
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4951,6 +4956,7 @@ enum nl80211_bss_scan_width {
  *	using the nesting index as the antenna number.
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
+ * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4977,6 +4983,7 @@ enum nl80211_bss {
 	NL80211_BSS_CHAIN_SIGNAL,
 	NL80211_BSS_FREQUENCY_OFFSET,
 	NL80211_BSS_MLO_LINK_ID,
+	NL80211_BSS_SHORT_BEACON_PERIOD,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..5e9aaa8c0d7d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -5711,6 +5712,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

