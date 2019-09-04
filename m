Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3519A923C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbfIDTN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 15:13:56 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43451 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbfIDTN4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 15:13:56 -0400
Received: by mail-pg1-f173.google.com with SMTP id u72so7560457pgb.10
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kF3FzIWsLVS9pUmY8wzedNzcdZsn/YCj7K+cUlJYVus=;
        b=C7rUjgUrlYDOoA47wlcvCIOTYKdqfyJQGnJ2BbdY+mMO8KyyQLEmrQClpaha/1M1m/
         xLlj/Y/0h+EusdCWvFVwN6ipZn1UrTB9KigvE6yxWNZBMVZh0HbuXtiYgLb6nLemJvan
         ZH4mAIYxo3sFlxBJsdiNcXcmD8oaNK2UEuQtmR5+AooX16v5cL23/w9y/PnrXKeEl5d0
         W72aFPmLl8NGSG5m3dhfik3BgFugEvRfQXn3P6OHiIgtwlTP3heZfAVB/7/Py/D6rHqp
         nmtkxUa7jq9UyNn0ISRb6FO2ftH/B3er/06jLpEVv7wC/TSNCAw9yw8f+0svRONkK2kr
         KN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kF3FzIWsLVS9pUmY8wzedNzcdZsn/YCj7K+cUlJYVus=;
        b=mBjqru/nu1uIalOAs+Bh3yodCe8bL4SqFvNqUdjIpdJYckN3f5bYPt7aeaVZHdXHb1
         X2RB4bocx1n19q4XDx+liXAmLoNQEEt7aWcoq3sbSYKHF4CkKS6nB4v22Mfzhwh6TBSm
         bLMWbTeWUAyvqmg27ok0B+If0pCkmRUH9XI8QksjBo5MThn8OYZ6QozRVctAoVEWi+YJ
         6CfCngbuH4E7LtXtkB59AA7W1aC7NujE2yQR2dXXd27lC8aNuRRDZ4foX5p6Rsp9tMNg
         nt6cyQT/NpyX4UxcWJ0htQ+glRP5Qz/j2Q5OxbiTtBzZOBdFM9A/xHSYrpQDsKwtznU8
         V1HQ==
X-Gm-Message-State: APjAAAUF48x3jOv1MmweBYIvxHwyGBcNl5A2XrTwRLDES3Dav2roEx7m
        azOJJj4H8yGv2EXlBuxMeRUykAHbhYw=
X-Google-Smtp-Source: APXvYqwwFx8OGH8FklmqMi892PI3kWfGgcHC76A0j+JiAu28kc5Voxjr3F2le6r98lMTk35rAG9Xmg==
X-Received: by 2002:aa7:800c:: with SMTP id j12mr45859606pfi.255.1567624435158;
        Wed, 04 Sep 2019 12:13:55 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u7sm18849727pgr.94.2019.09.04.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:54 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/4] nl80211: Add LIVE_ADDR_CHANGE feature
Date:   Wed,  4 Sep 2019 12:11:52 -0700
Message-Id: <20190904191155.28056-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904191155.28056-1-prestwoj@gmail.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new feature bit signifying that the wireless hardware supports
changing the mac address while the underlying net_device is UP.  Note
that this is slightly different from IFF_LIVE_ADDR_CHANGE as additional
restrictions might be imposed by the hardware.  Typical restrictions
are:
	- No connection is active on this interface, e.g. carrier is off
	- No scan is in progress
	- No offchannel operation is in progress
---
 include/uapi/linux/nl80211.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bf7c4222f512..0ceb945a08fb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5481,6 +5481,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_LIVE_ADDR_CHANGE: Device can perform a MAC address
+ *	change without having to bring the underlying network device down
+ *	first.  For example, in station mode this can be used to vary the
+ *	origin MAC address prior to a connection to a new AP for privacy
+ *	or other reasons.  Note that certain driver specific restrictions
+ *	might apply, e.g. no scans in progress, no offchannel operations
+ *	in progress, and no active connections.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5526,6 +5534,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_LIVE_ADDRESS_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.17.1

