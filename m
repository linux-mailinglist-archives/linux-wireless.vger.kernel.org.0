Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77F22FEA28
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAUMfB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 07:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbhAUMdd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 07:33:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E24C061575
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 04:32:52 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2Z8s-009XIP-Sx; Thu, 21 Jan 2021 13:32:50 +0100
Message-ID: <92dcf0de488a7b72280a20fb9c01fe6c99f8f96b.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: enable QoS support for nl80211 ctrl port
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 21 Jan 2021 13:32:50 +0100
In-Reply-To: <20201212104826.5868-1-markus.theil@tu-ilmenau.de>
References: <20201212104826.5868-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Seems reasonable to me, all in all, but

> @@ -3934,7 +3932,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>  	if (IS_ERR(sta))
>  		sta = NULL;
> 
> -	if (local->ops->wake_tx_queue) {
> +	if (local->ops->wake_tx_queue ||
> +	    skb->protocol == sdata->control_port_protocol) {
>  		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
>  		skb_set_queue_mapping(skb, queue);
>  		skb_get_hash(skb);

I don't understand this part.

Why not do the necessary setup in ieee80211_tx_control_port(), instead
of potentially overwriting it for EAPOL-over-AF_PACKET frames here?

johannes


