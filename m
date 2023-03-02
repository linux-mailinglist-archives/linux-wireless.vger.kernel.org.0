Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3706A85C6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 17:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCBQDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBQD3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 11:03:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273418B33
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 08:03:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaa701aso316367707b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 08:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyTUdnNvjlSXrE9Kg/YR8WzgRJx0XjIVyXbmHCyAEw4=;
        b=NsSMk1fz/8llD6nvhDaBCiI3w+rn6L8PZdp7ZE3FTRqEIPk+ZdELA4hptxYTolkXop
         zczliQ3gRtlxYAt1cPtZGaUUWLGO8JtP8g72jx4jy3C4kyhWwHonq02fDOZFVmVtNKDr
         7YbDb/Znu8ISfpDkDjDJGscAtmAtTuGQlOxZ36ZpqA8lYJ+M+ixCcFOj48bUrIhKqjYp
         H+MMdZkZQqFY3omizfQFFcTPPPlrTYHnICgpDgzbCJ9Cmsw0BuYDPf8AjnPJxeUHb29+
         zil7p7EryjzwTEyWbFSASH9oLziCQYwZuqWfXO3NP3PfZQSNwrUKXvo703cnN5WqQfFs
         Ce3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyTUdnNvjlSXrE9Kg/YR8WzgRJx0XjIVyXbmHCyAEw4=;
        b=HNxReu3yPzjXGZcAAXnO9p1NxWCT9n9D2zBivtmFdDK5Qz2enmHcZeaqkKTLACpmot
         /yJxFMD0KLENdB0hPDzFG9vh9jXNqCZkEOr83QWn36irHcsdVKweRmjmBMbHzg8FOLEX
         lgoVdTZygoLhaSVnyPcar0+ftV2PLQuTKonsDUTYOo+Ig9VmRXMrzR7Lv/b6TjYC3wSt
         0ONr+NJgosvXITp+kylFwPOvpfBYwHK/Z0pzQr/QyFdq/GaXeCBZMb6lgJEqO0uSJd01
         exIk2OSOzszbYe+eQk+OsgbJcmBKetazVrx7Q85023kiD3Y1jDSpUU6JOxLBUdHVml6n
         Bdmw==
X-Gm-Message-State: AO0yUKUAVDbhb2sQQiAHXhXcqDMFQPKYU0agvzsOElaT162K5LvPWI+D
        qJv0ZAilw03I/GAyDBGZCC7PznOSAyw=
X-Google-Smtp-Source: AK7set9nEFrwTcHZqdi1ssJMuZPy81qYZgcAPXHhcEHIGgwLIczbbc8sP5q81TiH5Wqt+GPMCrJzWU5NHeU=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a05:6902:101:b0:a4e:4575:f3ec with SMTP id
 o1-20020a056902010100b00a4e4575f3ecmr4841329ybh.0.1677773005908; Thu, 02 Mar
 2023 08:03:25 -0800 (PST)
Date:   Thu,  2 Mar 2023 16:03:07 +0000
In-Reply-To: <20230302160310.923349-1-jaewan@google.com>
Mime-Version: 1.0
References: <20230302160310.923349-1-jaewan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302160310.923349-3-jaewan@google.com>
Subject: [PATCH v8 2/5] wifi: nl80211: make nl80211_send_chandef non-static
From:   Jaewan Kim <jaewan@google.com>
To:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@android.com, adelva@google.com,
        Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Expose nl80211_send_chandef functionality for mac80211_hwsim or vendor
netlink can use it where needed.

Signed-off-by: Jaewan Kim <jaewan@google.com>
---
V8: Initial commit (split from other change)
---
 include/net/cfg80211.h | 9 +++++++++
 net/wireless/nl80211.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f115b2550309..bcce8e9e2aba 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -938,6 +938,15 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 				  const struct cfg80211_chan_def *chandef,
 				  enum nl80211_iftype iftype);
 
+/**
+ * nl80211_send_chandef - sends the channel definition.
+ * @msg: the msg to send channel definition
+ * @chandef: the channel definition to check
+ *
+ * Returns: 0 if sent the channel definition to msg, < 0 on error
+ **/
+int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *chandef);
+
 /**
  * ieee80211_chanwidth_rate_flags - return rate flags for channel width
  * @width: the channel width of the channel
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..1fd9e6545225 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3756,8 +3756,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	return result;
 }
 
-static int nl80211_send_chandef(struct sk_buff *msg,
-				const struct cfg80211_chan_def *chandef)
+int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *chandef)
 {
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
 		return -EINVAL;
@@ -3788,6 +3787,7 @@ static int nl80211_send_chandef(struct sk_buff *msg,
 		return -ENOBUFS;
 	return 0;
 }
+EXPORT_SYMBOL(nl80211_send_chandef);
 
 static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
 			      struct cfg80211_registered_device *rdev,
-- 
2.39.2.722.g9855ee24e9-goog

