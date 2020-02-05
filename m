Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74D153BAA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBEXKP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:10:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37105 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:10:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so1500508plz.4
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2020 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL80NuY6Vf0FAXOCp6bQHHqsmb4imTQt+pzHjrZVNIw=;
        b=c91QRnAGdAIMgJumd6Ttpu/6GhmRr58WzAY77df2bMCpKpTZA0hzfIiztjivuRyjEC
         ROwlVuaG0z8kNHEqz+DDDXlN9e+WvDxMAA2bm/WMheWCP+ROLpcVeUfi/D2qeOsV8yg+
         tW9cRs3hELe4U/6dtacIrT+rDKGEGcqDbtbHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL80NuY6Vf0FAXOCp6bQHHqsmb4imTQt+pzHjrZVNIw=;
        b=kYjSePyw/YSI+MmpLlLADeEwnIr3WtVC8bKYrUXCJlbkBneYwFYqZr0gxHwxRJtK+B
         qOMGGcoBRFxx6C6UD1w4AJQhVqaHtTRAL08h19rCeQAkFBdi+lbTntr5GsGweyAHliWd
         Zr3FZvrvDJ5wCcJyFLRVesmJBL4Sc865Hy0J+AQ9OiSoeac1FU4muSDrQvA6TeHRWFHL
         +/gM2+8xykv7zG5zQp9ByPOPGjZkU04ke4XL5KPYZ6DLo+sUkC6XyPc1NnWHTqmqH8J2
         d8fJI+IT++NVEdHXsLZXRk0MPZKrM8bopUAupGadihjqKF7HvVQPVwUQ4r1zjXQ64sV4
         /Qiw==
X-Gm-Message-State: APjAAAUOQLDRHsrNxLFbKU+RIYYV384HToUMJEwe+L6OkNL6qVlofm2W
        PlUZeorhlaOzkhX3VVqXjW8IBg==
X-Google-Smtp-Source: APXvYqzakOpdkvxuYOgvk6L1wnyGPVd5tj72oJq9l7/8UiIOWj5iLSHzO0JRYdU+Utu9mMEI2iFajg==
X-Received: by 2002:a17:90a:ba98:: with SMTP id t24mr670019pjr.12.1580944213751;
        Wed, 05 Feb 2020 15:10:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id t63sm567963pfb.70.2020.02.05.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 15:10:13 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] iw: pull in CHAN_NO_HE nl80211.h definitions
Date:   Wed,  5 Feb 2020 15:10:00 -0800
Message-Id: <20200205231001.132595-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205231001.132595-1-briannorris@chromium.org>
References: <20200205231001.132595-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From:
https://patchwork.kernel.org/patch/11343173/
https://lkml.kernel.org/linux-wireless/20200121081213.733757-1-luca@coelho.fi

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 nl80211.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/nl80211.h b/nl80211.h
index 809ef9165684..d996bac97e9d 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -3587,6 +3587,8 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_WMM: this channel has wmm limitations.
  *	This is a nested attribute that contains the wmm limitation per AC.
  *	(see &enum nl80211_wmm_rule)
+ * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3616,6 +3618,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_20MHZ,
 	NL80211_FREQUENCY_ATTR_NO_10MHZ,
 	NL80211_FREQUENCY_ATTR_WMM,
+	NL80211_FREQUENCY_ATTR_NO_HE,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -3813,6 +3816,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_HT40PLUS: channels can't be used in HT40+ operation
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
+ * @NL80211_RRF_NO_HE: HE operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -3830,6 +3834,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_HT40PLUS		= 1<<14,
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
+	NL80211_RRF_NO_HE		= 1<<17,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
-- 
2.25.0.341.g760bfbb309-goog

