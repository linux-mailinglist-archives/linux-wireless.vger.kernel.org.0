Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B886203221
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 10:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgFVIdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFVIdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 04:33:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB2C061794
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 01:33:48 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jnHti-009xWU-1D; Mon, 22 Jun 2020 10:33:46 +0200
Message-ID: <537bd31e3dcef148fcc934969c782e0f0c40d711.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix control port tx status check
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, j@w1.fi
Date:   Mon, 22 Jun 2020 10:33:40 +0200
In-Reply-To: <20200622083054.102643-1-markus.theil@tu-ilmenau.de>
References: <20200622083054.102643-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-06-22 at 10:30 +0200, Markus Theil wrote:
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  net/mac80211/status.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index 7b1bacac39c6..88c826645903 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -639,11 +639,22 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
>  		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
>  		struct ieee80211_sub_if_data *sdata;
>  		struct ieee80211_hdr *hdr = (void *)skb->data;
> +		u16 ethertype = 0xffff;
> +
> +		if (skb->protocol == cpu_to_be16(ETH_P_802_3) && skb->len >= 14)
> +			ethertype = (skb->data[12] << 8) | skb->data[13];

Might be nicer to extract that as __be16 immediately?

johannes


