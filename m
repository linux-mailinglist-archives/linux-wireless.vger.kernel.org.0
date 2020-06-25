Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D151209BB2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbgFYJFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389473AbgFYJFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 05:05:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26EC061573
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 02:05:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joNok-00Bmu1-16; Thu, 25 Jun 2020 11:05:10 +0200
Message-ID: <27f5d57bb70dae41e59808cd66931f21a362d3b6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] mac80211: skip mpath lookup also for control
 port tx
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 25 Jun 2020 11:04:54 +0200
In-Reply-To: <20200617082637.22670-2-markus.theil@tu-ilmenau.de>
References: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
         <20200617082637.22670-2-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied (at least tentatively, haven't run all the tests yet), but

> @@ -3933,6 +3933,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>  	struct ieee80211_local *local = sdata->local;
>  	struct sta_info *sta;
>  	struct sk_buff *next;
> +	u32 ctrl_flags_adapted;

I removed this - the loop can only process fragments of the same frame
that should all be handled the same.
 
> -	if (proto == sdata->control_port_protocol)
> -		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
> +	if (proto == sdata->control_port_protocol) {
> +		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO |
> +			      IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
> +	}

And this doesn't need braces.

johannes

