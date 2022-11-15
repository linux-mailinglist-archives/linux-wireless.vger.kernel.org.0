Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944AC628F75
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 02:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKOBp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 20:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiKOBp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 20:45:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF1175A4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 17:45:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so12470030pjl.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 17:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7o5L5dcqApbBitmcE85yYj+UyaMI0XcF0GEAVXPsU9E=;
        b=YPBVT1s0+3PuQWSkHb0QnwgKrCELMfow9x9xz4G4lxhmzwW+MW3hs8du1i6PbyKqfs
         SMzC8NPOguVo+Y/AG8WaDiQT1BCcSH+mwM9sxoGaWfPDmguJeDPKpQgJryDkh/5ChLJS
         C4h1JCAmSlfYjShMhE6JRhTYPb2PKTDy9xYd3ybFdk8543qdH9rUyBUvovPqIE0aTzDn
         reX/3ZhJ3Y1IitHivMUjpl283B+txl25Lig/tj+9YAIc+TXvw2NiSVMlPKe2RVMC2z7j
         YY2a5Ch9YVxG3jPKOj5ZwdXeIXV6C9zXnV/X+fnWh62ruS+pydLqK9xsLMBpowpjv0sK
         UjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o5L5dcqApbBitmcE85yYj+UyaMI0XcF0GEAVXPsU9E=;
        b=xjLxYtO/WXoUOECaJUsAKOkBiljcMngbbfAYQsQpukNYpT+xLp3KIGYwiNdPEQEOwT
         5GXq9iTdO6zOnAsSZKYvTEl16UeoKpkXY2+hCcXyBsb1hIK7GOWq4U2FnZoZhVrIeBN0
         RPJBWjPX6pNEGXQklq63HzYOvVyPntxSZetR0ozDNZWxrHxyxtZdoaUnx0JEkb3zu7e4
         jQpCpPdm97CeskUV4I2vkHuThFb1gwRuOnv+r3MdirZKaI78RpRTHHR+u4VnKx5nQI6F
         vM0paFgAxazkuWp8eY7WMXU0IHrz9d0F3KfqvgezJVNkeS3aW7hdBY+V16njTze/LpTL
         6Pxw==
X-Gm-Message-State: ANoB5pmHLhrSToADgTE3KH+DWFZaWtGf5XhHEKKU/yrwUnpPeqKg8hgm
        Y8vxeT9c6gwkFWqq6qluHsYOlKdA0Tx9mw==
X-Google-Smtp-Source: AA0mqf7cjhmOB2Yz5ribQdMmdinTMHw+B/rSLPVKvDC3KLeONwAF8PAM4zlDWCgFAcBdL8ygktiPvQ==
X-Received: by 2002:a17:90a:db4c:b0:216:bd62:8e69 with SMTP id u12-20020a17090adb4c00b00216bd628e69mr15604508pjx.205.1668476756283;
        Mon, 14 Nov 2022 17:45:56 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b00186e2b3e12fsm8194256pld.261.2022.11.14.17.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:45:55 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2] wifi: ieee80211: Fix for Rx fragmented action frames
Date:   Tue, 15 Nov 2022 14:45:19 +1300
Message-Id: <20221115014519.2718154-1-gilad.itzkovitch@morsemicro.com>
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
One of those checks is the ieee80211_is_robust_mgmt_frame() function.
It requires to peek into the frame payload, but because defragmentation
does not occur until later on in the receive path, this peek is invalid
for any fragment other than the first one. Also, in this scenario there
is no STA and so the fragmented frame will be dropped later on in the
process and will not reach the upper stack. This can happen with large
action frames at low rates, for example, we see issues with DPP on S1G.

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

