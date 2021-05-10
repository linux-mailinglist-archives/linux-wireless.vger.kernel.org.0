Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F7377AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 06:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhEJER6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 00:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhEJER6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 00:17:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEF7C061573
        for <linux-wireless@vger.kernel.org>; Sun,  9 May 2021 21:16:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c17so12732948pfn.6
        for <linux-wireless@vger.kernel.org>; Sun, 09 May 2021 21:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTerZRGKeQCfH6TL4AouuTqXMWKe0PPg8qnOakbVp7s=;
        b=RDgggXQPCF1gm3g6z3puQaCoINBUWbN4UUJJIRcTkfDR72eLFz3ff3FHC9OZLhxSVw
         fCf9hfSrTrYRak4xXonLFiFvJ9/PoR5uTJ4NBMaIXiL+MpmmIeZ/wuW5M4vupYh1lraf
         3YpVMV72QQl1KZckUsBG4e7fL6ma94aMyH9rbD5lrcPUA04JHK13qpyS4w2DuwYo2JZ0
         1na7OzEAgjYrNlKDOhs7jacNAnGsisvMpb/QOhorhIkS7rmjOKWinKFsq3zm3+mnYhjn
         oZEgW1OAo1ni9c4MCvwJ+SNT+5IvmZHqVrLSFzNY5BUqRt+iExAde+jyToqn9/MWiLKY
         Dwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTerZRGKeQCfH6TL4AouuTqXMWKe0PPg8qnOakbVp7s=;
        b=cI5TUtGwwZfRwdEE1YmM0NtQEZdhglShcs5ozjbEeSO3bny1sMQtuQgJkcmjLXKXCs
         4+LkUG3lxu/aivoWBHScNR/SyEZKBXrqB27PEPlWBgH7Nd67zHGyVUm1z3Av7WD4JuNo
         IV1S2HY+HKDXBtVxHOclIvHvJJWeDOMFoKCO83C4w3sJPeVFv/Z2A6vrJDhJbJPtx4c7
         Y/nnuXewefTG63Llphf1hH1WKJZSpL8HdW14cFWzt0u/2Gfx2S2S6LbvYeqMc8+MbFZS
         1/tt7ztnNY5TBMrVbEuzZ4bOq+Halprp5ZpNe05GhMffgiK8OHV9e8kxf9LODRlFbKtS
         dG/Q==
X-Gm-Message-State: AOAM530mK873NERzcKf7LJSQ+s9mFViU2JRLb5xi4D0Cvs5VCGvS7r7p
        ZLpenIE2US/eyYwRsmQqQ+w=
X-Google-Smtp-Source: ABdhPJz2KU4qrrcMjwDUPyCQzfS6SGdHpW3tZhtLQ+HeoivHMuwyqphUkt2Y6ObwQ+aAlwGoSfn62Q==
X-Received: by 2002:a62:79c3:0:b029:28e:a874:4e1e with SMTP id u186-20020a6279c30000b029028ea8744e1emr23161892pfc.3.1620620213625;
        Sun, 09 May 2021 21:16:53 -0700 (PDT)
Received: from nuc.. ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id g84sm10003510pfb.198.2021.05.09.21.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:16:53 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>,
        syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com
Subject: [PATCH] net: mac80211: fix hard-coding of length check on skb->len in ieee80211_scan_rx()
Date:   Mon, 10 May 2021 12:16:49 +0800
Message-Id: <20210510041649.589754-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace hard-coding with compile-time constants for header length
check on skb->len. This skb->len will be checked again further down the
callstack in cfg80211_inform_bss_frame_data() in net/wireless/scan.c
(which has a proper length check with WARN_ON()). If the kernel is
configure to panic_on_warn(), the insuffient check of skb->len in
ieee80211_scan_rx() causes kernel crash in
cfg80211_inform_bss_frame_data().

Bug reported by syzbot:
https://syzkaller.appspot.com/bug?id=183869c2f25b1c8692e381d8fcd69771a99221cc

Reported-by: syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---

This patch has passed syzbot testing.

 net/mac80211/scan.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index d4cc9ac2d703..562eda13e802 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -251,13 +251,21 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
+	size_t min_hdr_len = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
+
+	if (!ieee80211_is_probe_resp(mgmt->frame_control) &&
+			!ieee80211_is_beacon(mgmt->frame_control) &&
+			!ieee80211_is_s1g_beacon(mgmt->frame_control))
+		return;
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		if (skb->len < 15)
-			return;
-	} else if (skb->len < 24 ||
-		 (!ieee80211_is_probe_resp(mgmt->frame_control) &&
-		  !ieee80211_is_beacon(mgmt->frame_control)))
+		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_short_beacon.variable);
+		else
+			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
+	}
+
+	if (skb->len < min_hdr_len)
 		return;
 
 	sdata1 = rcu_dereference(local->scan_sdata);
-- 
2.30.2

