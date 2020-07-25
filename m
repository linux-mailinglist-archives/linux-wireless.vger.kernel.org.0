Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9022D988
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jul 2020 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGYTOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jul 2020 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGYTOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jul 2020 15:14:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC565C08C5C0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jul 2020 12:14:38 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jzPcy-00AoHr-16; Sat, 25 Jul 2020 21:14:36 +0200
Message-ID: <c1b2a6583245560952db0cde3e3d6ff9db4cbd5a.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: add a function for running rx without passing
 skbs to the stack
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Sat, 25 Jul 2020 21:14:19 +0200
In-Reply-To: <20200725185554.17346-1-nbd@nbd.name>
References: <20200725185554.17346-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
> +		       struct sk_buff *skb, struct napi_struct *napi)
> +{
> +	struct sk_buff_head list;
> +
> +	__skb_queue_head_init(&list);
> +
> +	/*
> +	 * key references and virtual interfaces are protected using RCU
> +	 * and this requires that we are in a read-side RCU section during
> +	 * receive processing
> +	 */
> +	rcu_read_lock();
> +	ieee80211_rx_list(hw, pubsta, skb, &list);
> +	rcu_read_unlock();
> +
> +	while ((skb = __skb_dequeue(&list)) != NULL)

I'd drop the != NULL, but no strong feelings :)

> +		if (napi)
> +			napi_gro_receive(napi, skb);
> +		else
> +			netif_receive_skb(skb);

Nit: I'd prefer braces on the loop, just makes it nicer to read IMHO.

OTOH, the !napi case should use netif_receive_skb_list(), no?

Given the discussion, it also seems a bit odd to add more work for NAPI
poll where we process one by one ... But I see why you did that, and I
guess it's not actually that much more work.

johannes

