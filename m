Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49A7859F6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjHWODR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHWODQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185ACF3;
        Wed, 23 Aug 2023 07:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D1462FD8;
        Wed, 23 Aug 2023 14:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05592C433C9;
        Wed, 23 Aug 2023 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692799393;
        bh=h0orCZ3m4TEkoobEWxWZajTOV5CdUJY9mXV/Km4wZnI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GHW5AXiQ4Eb2p+GmPTvDfmvgQDiJx7bblESo6DFEBHpkw8KU3HEJP91QP6zk95GSu
         MupalcPdnnJF2bRSgvMX1LvFgYEKt9WI0KtfORZXQg+i7CLjyqA2A7H0Wbmy755kVC
         aKPrLIclTc6c9ySfUdDQfdHou1d5ONs6TDNL8+ToMSK5nHhD3AqQmh9JAc9YMF3p1u
         wFdRAey8y75n4FeTC5iwhhxwhKLZq9RHlRIMpLj53pdM15CSfmDt9xkLkTC+yQveRL
         5o86ch0l4K+H8Riip26erFt6I7fmhHaCt3GCyeOfsAtP0kjRcHcnSnhRnXpI7JmP6z
         KVUPDGnFZOD3A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] ath11k: Don't drop tx_status when peer cannot be
 found
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org>
References: <20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169279938984.1241462.11542216603364310073.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:03:11 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> When a station idles for a long time, hostapd will try to send a QoS Null
> frame to the station as "poll". NL80211_CMD_PROBE_CLIENT is used for this
> purpose. And the skb will be added to ack_status_frame - waiting for a
> completion via ieee80211_report_ack_skb().
> 
> But when the peer was already removed before the tx_complete arrives, the
> peer will be missing. And when using dev_kfree_skb_any (instead of going
> through mac80211), the entry will stay inside ack_status_frames. This IDR
> will therefore run full after 8K request were generated for such clients.
> At this point, the access point will then just stall and not allow any new
> clients because idr_alloc() for ack_status_frame will fail.
> 
> ieee80211_free_txskb() on the other hand will (when required) call
> ieee80211_report_ack_skb() and make sure that (when required) remove the
> entry from the ack_status_frame.
> 
> Tested-on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
> Fixes: 94739d45c388 ("ath11k: switch to using ieee80211_tx_status_ext()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

400ece6c7f34 wifi: ath11k: Don't drop tx_status when peer cannot be found
29d15589f084 wifi: ath11k: Cleanup mac80211 references on failure during tx_complete

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

