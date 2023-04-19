Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F76E722F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 06:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjDSEUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 00:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDSEUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 00:20:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764146B8
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 21:20:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a68f2345c5so19605075ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1681878021; x=1684470021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCDWxk5E2Ms0oRhA7jUYf1O0TdFfpzDkfLBMkDnBGpM=;
        b=hdWOO5jBzoYljq4hiphDtz3lU5kqzi8W4Lt0FcwgmxrMfRov3KRk/gJrwLBdhtvUMl
         7/OtakNsmYkG49kHj1Alwxe4jFZNoZwn+I9EmFQRCkp+uWYuk6tpdGBxtHHK78TNXmPU
         EGrjneDdDyA4ZL9XvQlGbJow8PCLWP+jWPCj61OF4p7NDDHenge9W2jGwUEj6C5+fAPE
         uh6o2ht1Z2wbWTnxC5u9kZnYnjwlrpCgoGA0dL9Le807gmkd0xJnQRevopVPJn9qcQWz
         78Q31yDBiuFYxRIyf6uewaK1AKisBX1j/DQxpLKyAGa4K2cZrd/Bjg/R9wXjIAhbDrhx
         squA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681878021; x=1684470021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCDWxk5E2Ms0oRhA7jUYf1O0TdFfpzDkfLBMkDnBGpM=;
        b=P6Tv+tXUqeIa84L3F6Xyyg/wPD4GBvAMqCfEaaGwXeBNSsITz7f4x/UsIEA+9rsuUb
         NR2ilNvv9uLlI4bRkLFSYUCnEa3o8Iq9CUreGDSAvcsMkCesx5n0ODyYEdNenjpky0AF
         oI5QEiMoMLsZSwitYqR27i50DZgz1W7YDo/JYZ7koQxQK1nZKhm/X+CTWeKSorOd1hW7
         iYE3nR816d9gsAcRvea5g+QcHbRZ9COOXiWLNTUEE0EvEK7SUhgmxbIu5oFZ/4GxfVFt
         zTjYM4RuVRA7isWMVrFvu20stQDgSLlPpOAitGsVfrHKNSuJTxEHwX9rbBkbSwpf5OYf
         806w==
X-Gm-Message-State: AAQBX9cfRJcPnchoxS7tsaz9fgnF80pYLKdwbK/0WfMm/0d3oraeRyr5
        35fql0LNlEAdpp9nHIudYWXERscmroHyDjh8vHU=
X-Google-Smtp-Source: AKy350ZGEnMu30B0vozMqnMW2hx5NTeUkJJsIJ/t0yjWcZhQqNDJ6tBcdqSn/KwEF+Xwrgfw4Dmh8Q==
X-Received: by 2002:a17:902:d503:b0:1a6:87d8:b8fb with SMTP id b3-20020a170902d50300b001a687d8b8fbmr4729056plg.2.1681878021613;
        Tue, 18 Apr 2023 21:20:21 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902b68d00b001a633a9322dsm10380256pls.212.2023.04.18.21.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:20:21 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: mac80211: support ieee80211_ext format
Date:   Wed, 19 Apr 2023 16:20:09 +1200
Message-Id: <20230419042009.1058020-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Ensure S1G beacons use the new ieee80211_ext format when required.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/rx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index db3451f5f2fb..74027486a6b9 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5048,6 +5048,15 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct sta_info *sta;
 	int link_id = -1;
+	const u8 *addr;
+
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		struct ieee80211_ext *ext_hdr = (struct ieee80211_ext *)skb->data;
+
+		addr = ext_hdr->u.s1g_beacon.sa;
+	} else {
+		addr = hdr->addr2;
+	}
 
 	/*
 	 * Look up link station first, in case there's a
@@ -5055,14 +5064,14 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	 * is identical to the MLD address, that way we'll
 	 * have the link information if needed.
 	 */
-	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
+	link_sta = link_sta_info_get_bss(rx->sdata, addr);
 	if (link_sta) {
 		sta = link_sta->sta;
 		link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		sta = sta_info_get_bss(rx->sdata, addr);
 		if (status->link_valid)
 			link_id = status->link_id;
 	}
@@ -5102,7 +5111,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
 
-	if (ieee80211_is_mgmt(fc)) {
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_ext(fc)) {
 		/* drop frame if too short for header */
 		if (skb->len < ieee80211_hdrlen(fc))
 			err = -ENOBUFS;

base-commit: 9ae708f00161e1d789268fa9cc05bf6bec2af474
-- 
2.34.1

