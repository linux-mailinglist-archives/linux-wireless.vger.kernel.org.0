Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1B6B707E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 08:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCMHzo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCMHzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 03:55:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314652F4F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:53:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t25-20020a252d19000000b00b341ad1b626so6902724ybt.19
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678694022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XV2q27+WLDL4yB3jbKiPFzkFK6bHorAt5xnGXFkFXUk=;
        b=dVRBU4O82UHwnt5Y30B3ZHB6/G/EaO8yJcvCP/uADO+q7i0BEcL/Xkls48N3uYj6ll
         ffciX0Q6wkh6UZzNa177AjOY4axJzWSvAyBVaYaJH0ThCzlsABXzcOk0oFbiImvvH4PV
         vcNCWwX2mnUNQa0RckyJzbG4o3U9ij50LTwFD0+06lX9qZc3OBceMOWUdetHs2u45uHt
         tlJoTDDULsa96A362cdw07VpDTJHM2DihyxJT19WdnW49Kt61mz5U/kkAM0RN/jfMv7D
         rDBGTLPbxqd2ek/gUDKRzdviT84/O7CDLs+ZAGOPHZpOCYRBkAKnhN+I+iJ8FW+8eXRJ
         SN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XV2q27+WLDL4yB3jbKiPFzkFK6bHorAt5xnGXFkFXUk=;
        b=fCbNil4IHM/R8SB+cYIX5NQwhvh2dYi2omQj5jXKmZgC6+IXPVJf9utGzL/TSACS82
         UgkRauW1YJIkq4a4NSl/o7kqbv1J1HtDhRB1wb67Kzn6e2SayPYP3D4VdFNOo9oFAEdt
         eWAeBmsZxQY6+C4v55091zPooq0840RF5iSJ8PlGzRg/8VeWq5T2ryZnNTpLFyeqyDHu
         F/9yrHTBoFqFr+kE9jYk+poTzSv1wO6VGBCTJtq/5RvTWVz2Le/jU4iiVE1aViAzznXE
         D7Qm+zYEGOZoHR6QdDD6VjGTiconDpAC7GSW4HzcOlwo6tDSYlkPAerwuvkm0T6tDtc4
         nnZg==
X-Gm-Message-State: AO0yUKWpfiKdoZzlna+T3YW4z/+GJfwsw/kxH5lopBdhUPD8XqXiwrYT
        j5ETv5TYdnis4wXoN9VGtwFx24Z6l4k=
X-Google-Smtp-Source: AK7set+EPcMnjhQBsGHddOUYCe833wPSx4+V/NsKsO42wJTQSuTB+oXT9gmM6Npq4UbeC+UHQ8QGDtKgF7Y=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a05:6902:282:b0:a02:a3a6:7a67 with SMTP id
 v2-20020a056902028200b00a02a3a67a67mr20646725ybh.11.1678694022104; Mon, 13
 Mar 2023 00:53:42 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:53:23 +0000
In-Reply-To: <20230313075326.3594869-1-jaewan@google.com>
Mime-Version: 1.0
References: <20230313075326.3594869-1-jaewan@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230313075326.3594869-3-jaewan@google.com>
Subject: [PATCH v9 2/5] wifi: nl80211: make nl80211_send_chandef non-static
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
2.40.0.rc1.284.g88254d51c5-goog

