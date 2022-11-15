Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1669F628F55
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 02:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiKOBeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 20:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiKOBeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 20:34:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97418B48D
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 17:34:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so11782333plb.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 17:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21oLvtAljwz7nLFKuEZf7kQGU4lzmRfwLDJwsEv1xeM=;
        b=JP1CuHX1QpupkIO5yucCRlfbj+q2C/BJX3l0j4pK3HHU5sALkOiuGYYHig4tPCbkC9
         Ybz73QjgUCkozXdECl0c5tzvUBT4g8a7bSp+5AjTzkfeEVyNHGUnfEDvIPFrfwYPz068
         Np+u7xi0f2/zNZ+TPwaMbsNpWneMl3WW7T7Wb4IrJC9ikkdI1IRBorFPIXj7hugupJPj
         4oAbs4k1oi2c5MJHJpQwSX3v5/grQjUKkTG8bMWOVIWvQgZG6L84dWusEb+Gliw4gC0U
         qFbEny9cHDE9J4TCeF7Es4y3bENJu7QcCdrKw8EHe1kV/+4Q0HdFB2jhBHRpYS5CifdU
         B7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21oLvtAljwz7nLFKuEZf7kQGU4lzmRfwLDJwsEv1xeM=;
        b=EjJo1/Vi1xyHYOi5JuteonytYsF1X+N3QRwPzAA/djQGQpHvHiRwKe2zEWdWbrIK0G
         4PruVNuiDb6OLA104/t1CH4yr8y4Rg0Yzup5h2/CjliR2wI5oESoiZdDHy6Qxq2IoYRY
         qBLb2u6Y2Fk/yqnV1oiR8n7HJdvnW6luMixSW1VpuCR7L9nnSoyHhO8tHbi+Q8oUZhPj
         uR79fd1hAoQ4f4QWr0WTwJu63L0ZkfOv44cnom2tTMCjeXC2LJC+1AV2O+kjGeLgR6+N
         2Msj83JL/gRZvWjXEWWDiiA0bVR59KdKmb2YVA0cFZamhpQuQGGtBFQXmdHhc1lnXrLx
         JDDg==
X-Gm-Message-State: ANoB5plbeFVaMgiHsPiErqoZKR3skDqhZ6sIfdlbxmxL9N/jznLVoAnD
        MAhlwtcqlW1iXxO1YmV75RO+hw==
X-Google-Smtp-Source: AA0mqf70tHADgPN+H8iMaVeFr8hck1xd5JBpvvxbocRv0W8KOM4060+Hy7brASBvCCO/XDxAzr+54Q==
X-Received: by 2002:a17:902:f708:b0:186:7b95:f773 with SMTP id h8-20020a170902f70800b001867b95f773mr1701377plo.152.1668476056234;
        Mon, 14 Nov 2022 17:34:16 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id 76-20020a62154f000000b0056c063dd4cfsm7419019pfv.66.2022.11.14.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:34:15 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: ieee80211: Fix for Rx fragmented action frames
Date:   Tue, 15 Nov 2022 14:34:09 +1300
Message-Id: <20221115013409.2716397-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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

The ieee80211_accept_frame() function performs a number of early checks
to decide whether or not further processing needs to be done on a frame.
One of those checks is the ieee80211_is_robust_mgmt_frame() function
which peeks into the frame payload. In some scenarios, e.g. DPP at S1G
data rates, action frames can get fragmented. Those fragmented action
frames can be marked as not a robust management frames when peeked, by
ieee80211_is_robust_mgmt_frame() function, into fragment other than the
first one as it does not include the required action frame category. In
this scenario there is no STA and so the fragmented frame will be dropped
later on in the process and will not reach the upper stack.

This change will only check if the frame is robust if it's the first
fragment. Invalid fragmented packets will be discarded later after
defragmentation is completed.

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c28c6fbf786e..94d2b8e90732 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4215,7 +4215,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
 			return false;
-		if (ieee80211_is_robust_mgmt_frame(skb) && !rx->sta)
+		if (ieee80211_is_first_frag(le16_to_cpu(hdr->seq_ctrl)) &&
+		    ieee80211_is_robust_mgmt_frame(skb) && !rx->sta)
 			return false;
 		if (multicast)
 			return true;

base-commit: 9ea570a33ee525751e3117e266626dd705adc39e
-- 
2.25.1

