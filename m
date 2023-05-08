Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94A6FA63F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjEHKSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjEHKRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 06:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB6D04D;
        Mon,  8 May 2023 03:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59327624E3;
        Mon,  8 May 2023 10:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464ABC433EF;
        Mon,  8 May 2023 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541058;
        bh=VcVr4HRav66u8ZpAo9LD0FoqBN0HlX52IbJUdRpdA3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFzLzFjuY2C57YW22SpejTYohrt+YvL6XWMUzbeAa2wmlMmPOaVr8IdIGpeZwHMKc
         sxMlYx/Yr9iHu7PvuUZj87Lu2qzGEO8ncC6q6+vrbI9VJZSJY0Ijtny12h9fzwM/Fm
         tlYgsK7xSIif8u2TFHCb7Ea3KE/ZOrMLSt2MkZr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.1 601/611] wifi: ath11k: synchronize ath11k_mac_he_gi_to_nl80211_he_gi()s return type
Date:   Mon,  8 May 2023 11:47:23 +0200
Message-Id: <20230508094441.433673192@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit dd1c2322694522f674c874f5fa02ac5ae39135dd upstream.

ath11k_mac_he_gi_to_nl80211_he_gi() generates a valid warning with gcc-13:
  drivers/net/wireless/ath/ath11k/mac.c:321:20: error: conflicting types for 'ath11k_mac_he_gi_to_nl80211_he_gi' due to enum/integer mismatch; have 'enum nl80211_he_gi(u8)'
  drivers/net/wireless/ath/ath11k/mac.h:166:5: note: previous declaration of 'ath11k_mac_he_gi_to_nl80211_he_gi' with type 'u32(u8)'

I.e. the type of the return value ath11k_mac_he_gi_to_nl80211_he_gi() in
the declaration is u32, while the definition spells enum nl80211_he_gi.
Synchronize them to the latter.

Cc: Martin Liska <mliska@suse.cz>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20221031114341.10377-1-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/mac.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -163,7 +163,7 @@ void ath11k_mac_drain_tx(struct ath11k *
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
-u32 ath11k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
+enum nl80211_he_gi ath11k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
 enum nl80211_he_ru_alloc ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy);
 enum nl80211_he_ru_alloc ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);


