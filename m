Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4584A2621D5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIHVSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgIHVSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71889C061795
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kRvlgwC7WmL7REspef/PiIzLVev5Ne8T8dDlvb70gjc=; b=QUoHttnTJ/xXF0T7yqacilPNel
        5iSZfZlE/k1nA/0osZxF2l3Na8Xojtefesq7hTLaNvd6Ozu4uB+NjKOgW/DVb0JBybvDqEGqpv+t/
        ijGauRSzP1Y1eAqYwiXfYRturDVR2TovHCfrMdqkRq9aav/xl/HE2Dj6xrZXPpqo5GVU=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl03-0002Cx-2s
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/11] mt76: mt7915: fix HE BSS info
Date:   Tue,  8 Sep 2020 23:17:51 +0200
Message-Id: <20200908211756.15998-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

he_pe_duration and he_rts_thres have the same unit as the fields in the HE
operation IE

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dad44a447d11..8ea200601878 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -936,11 +936,11 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_he *)tlv;
-	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext * 4;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
 	if (!he->he_pe_duration)
 		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
 
-	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th * 32);
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
 	if (!he->he_rts_thres)
 		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
 
-- 
2.28.0

