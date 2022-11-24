Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1934636F79
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 01:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKXAyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 19:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiKXAyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 19:54:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC7105A8F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 16:53:44 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q1so251742pgl.11
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 16:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GfTCse8XYngiz75Ilzq49p0/fIYRMTNz8KCTOEerGs=;
        b=vUgZxkSnjmr9xnQYtkxj4PdN7iQRwQGhtj/Z1GEFiJRB5pNBS4TPKUDFsv3vbWbZ/M
         CXD654nAyFNCLBeiju/KzM3saWBYIBwVsBBXQwJqQer8EHJuNf5FK7rUfpX2r50ZftwR
         q8YV9t0FTxEY91axpAoIB05NY4+zOa/gEP2aNWGbx52mh1+Jum0/dcolyM+SXs1f4qgq
         Seb80wGWhHO5yW7l/D6L/kdZ/Dqze9CcQWi/mhDULu+SZ8TZcQbV6zRDRGfJclFfoQ19
         TEBxLjBtbEr83V9aSAO0KadjYWH1+BvN1TwEeqQ6KWdr4Uf/20VsjN4Xi2oSLu5st6nv
         j+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GfTCse8XYngiz75Ilzq49p0/fIYRMTNz8KCTOEerGs=;
        b=ijgE6Eov0OMIdUsq4NOKcMs8kgv1l0qSSoBebKRcXuB7btF2AsLSa5xkRpBRoQdHzk
         an9cgFjsYAkWFDDSzr7KTT5CRBngEhLML8In1Yk8CkxpSYYRmK2NC/OX56WBlVA9jFp3
         Yu8m8Hm5i57Ya2m4Z1Dzd8Qwp/EgvxmWZHeLmXgpzJma/XSuQHmnerohQ28HE1O/XtiK
         P9gxIDkeoCS9XS+64/zXYEjGYgD7lmOWK8M/jMDQ3G7YfCbQEaj3yLPEMqJaQn20AeuH
         WtVFhVQEdoEDLu13C5DMRNHAvTJO05JMPsxqT4RxZztnn6+x7n+D3COIf5LyXmigOhna
         GHtQ==
X-Gm-Message-State: ANoB5plVCveMfzJVbCH/+X8061ys45onvrPjVE+q/6ai4nSWcFJ9ogWh
        Qy9nmOSiyfFxhHiDTEUgAuwHD0LsYTZLuA==
X-Google-Smtp-Source: AA0mqf51mBQZijzzr+3YgzC8p2miEItvgPNK6foloBwHCatW7WWEHtEEnMFz+0EqIpSWiRK0k7RLmg==
X-Received: by 2002:a63:1206:0:b0:43c:76f4:c666 with SMTP id h6-20020a631206000000b0043c76f4c666mr13252789pgl.90.1669251224248;
        Wed, 23 Nov 2022 16:53:44 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090aad8200b00217ce8a9178sm1976473pjq.57.2022.11.23.16.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:53:43 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v3] wifi: ieee80211: Fix for Rx fragmented action frames
Date:   Thu, 24 Nov 2022 13:53:36 +1300
Message-Id: <20221124005336.1618411-1-gilad.itzkovitch@morsemicro.com>
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
index c28c6fbf786e..4e992d9a7b61 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4215,7 +4215,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
 			return false;
-		if (ieee80211_is_robust_mgmt_frame(skb) && !rx->sta)
+		if (ieee80211_is_first_frag(hdr->seq_ctrl) &&
+		    ieee80211_is_robust_mgmt_frame(skb) && !rx->sta)
 			return false;
 		if (multicast)
 			return true;

base-commit: 015d1787f3d9911a5431b54d840bf5042167ba98
-- 
2.25.1

