Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA509381384
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 00:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhENWLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 18:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhENWLE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 18:11:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B0C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 15:09:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so708547pfn.6
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVEwKEdVLlVVJVxedoNBc4BWAXFfR9V6+rvEkmkqNqo=;
        b=lf/df1n6657u4+dZTrwF6xxCFyjzE5ovnQgCJaDGuK17YTXI0MQoYgqn2DBtrXTM9y
         6qmBCVv4NMVI9HnQMblrhm2Y8iWZpF12WPu40pq/Vru87pc9BbgDit95m2cv8C4RmXY5
         i6IBr1nP44ztPdfmUclXOAZkOG/tjzQ5koJ1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVEwKEdVLlVVJVxedoNBc4BWAXFfR9V6+rvEkmkqNqo=;
        b=tgpb1ffFVlbZOiMLrQjMfiTM4SLcdIzPoMMmIj7lg5D0VKSlcfoxyerzGVqgS9g+5G
         pemRiMfYXvOCS2uDp/p4O3cX1/YtWiMMCBzN40r7ANLTzat0rZl+T3dhebvdhI+TNysG
         a2Naw9WEyRJa48AeGrNL/OD3knXOPahi9/8gWukHrVOQYFYSyFV9TWS9uXirgMg1SCmh
         +5mPirV4uZhS+qwFWSKCweXV+h/ySP07v/u7L7Odg3QFccKf3sT7qcd6zh1huYYgLjQz
         JWKvTMyOa/fDS7l94SbiCGQ1jmjSlBb/L+FM26elBtvxPyzm6pqBNim1utn0vJ85ZMfL
         2bmw==
X-Gm-Message-State: AOAM531axcyG/M47DjsZnOIFdOBeK5lArwczUel0fXYZTbxoNsK0Txl3
        S6ddGs4/G3AK0DuTcIr+yyEutw==
X-Google-Smtp-Source: ABdhPJwq18GMShSHikNPymoScSOxvtF7YXVCscqGBVyyUnLW5CUGpxUPQ8en98R5qUf4KEmP5j2zxw==
X-Received: by 2002:a63:d64f:: with SMTP id d15mr48686658pgj.137.1621030191378;
        Fri, 14 May 2021 15:09:51 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id j4sm6446156pjm.10.2021.05.14.15.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 15:09:51 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     briannorris@chromium.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>, kuabhs@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] ath10k: remove unused variable in ath10k_htt_rx_h_frag_pn_check
Date:   Fri, 14 May 2021 22:07:42 +0000
Message-Id: <20210514220644.1.Iad576de95836b74aba80a5fc28d7131940eca190@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The local variable more_frags in ath10k_htt_rx_h_frag_pn_check is not
used. This patch is to remove that.

Fixes: a1166b2653db ("ath10k: add CCMP PN replay protection for fragmented
frames for PCIe")
Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 drivers/net/wireless/ath/ath10k/htt_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 7ffb5d5b2a70..adbaeb67eedf 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1787,7 +1787,6 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 	struct ath10k_peer *peer;
 	union htt_rx_pn_t *last_pn, new_pn = {0};
 	struct ieee80211_hdr *hdr;
-	bool more_frags;
 	u8 tid, frag_number;
 	u32 seq;
 
@@ -1805,7 +1804,6 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 
 	last_pn = &peer->frag_tids_last_pn[tid];
 	new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, offset, enctype);
-	more_frags = ieee80211_has_morefrags(hdr->frame_control);
 	frag_number = le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 	seq = (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 
-- 
2.31.1.751.gd2f1c929bd-goog

