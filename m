Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA45ADEA1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIFEtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIFEtA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C465544
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso13785652pjk.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xs9rQoFSztjp512nGA2Dk3P/aPtDkMwSvLthvC06sgk=;
        b=NYDTw5TSgMRjtIO8n3oMEG4JnMnrHTcyI+Hj/cq94XVGeg/lytvSyLCcC8O1puQ5x1
         PB8MiWtFrbPwNEqg06icJ5dwa3EGyrCHdtPno+j6sP2n9rzgQzNtUw7FizkMQ879pqKH
         zqSHSKHT/21sFGSfktqKk04bJKy4N14l1C9+oqZ/C+uxRVIgJ5/2Z4S0UPSHxSx2vA2j
         KZA8iejNG37hd74f8Vs/wFkMuLevA+4MtPCVzPs8hipl7Mz6fLTdhV2f/weTBOvmL7rK
         nS+fo1N89CMO01JZ3Cu7IG8WEmGeO4UnGLUzcQYzE/QhLL9Cn3Zq+fS2BmIAhUKDPnf0
         DLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xs9rQoFSztjp512nGA2Dk3P/aPtDkMwSvLthvC06sgk=;
        b=njnAFgYrO5wZzrqlALbaZa1xRGtgn2B/0aB4Eg2lJ3MAJtlCOwDdREUKonsGGPO8Iy
         78rNLKA8qfZkR+l+EYzcksaaCWtwmS27Itq3n1dLqbgYvc3Z8sifRfo2oB2P9r5Y9Bca
         yO9fNM7ASDiV0j1D/6q8vyl60b8DkpuzjdQsSZzmDl2j/NhFFWC6AKLeCCtVhDOb1Tph
         FAKy3wcVwA6usteH8uDJpSTfgRI3xaJVzzFMvCsSsytb15QnYHP1JHHsRYb6m9zlJ5Hd
         eKj8flf0X833bxVj1+rqzZKXHkJmc1QcOEFwdVqovRAjpNHvYIn/ezyVm3jJR1asyJov
         zn9A==
X-Gm-Message-State: ACgBeo2UhmmTmJRMLfNE3SNXCwGpgBA7iOIUq1Ai2cQR7y6CDDVFgMtX
        vpT3skOsLKzWixfnJintLG8Xlg==
X-Google-Smtp-Source: AA6agR59JVA0u46HHh2vZEu7CGV2jCE/wo1idw9kywRXZqoVJbnGRhrwT6Mlk4FVwt2iSlGkHVycXg==
X-Received: by 2002:a17:902:e947:b0:170:d739:8cbe with SMTP id b7-20020a170902e94700b00170d7398cbemr53421730pll.141.1662439734927;
        Mon, 05 Sep 2022 21:48:54 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:54 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 04/12] nl80211: support setting S1G short beacon period
Date:   Tue,  6 Sep 2022 16:48:04 +1200
Message-Id: <20220906044812.7609-5-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
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
2.34.1

