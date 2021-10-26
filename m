Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1276843B82F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 19:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbhJZRd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhJZRdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 13:33:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0457C061745
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pfphubtXlVlvS9hX4ZJ7SgocMKfDYL4zV2zOpJgBDF0=;
        t=1635269461; x=1636479061; b=uoPmpMFsD9kdTMUFldqWgP8l/6b/gA+UW3yOjZC68P0DOiL
        rUjFoSSFACKJMMhQkEPxvipGLgkr63PLjt8yXd4s9Ha4bjr/TCK2Wgpa29uEX5/C0uyJCn/QrsznK
        H+JuK7xsI1pnoqsLIJzNDlZSxXvRqG+p7fmQMHBnsz8SWE99l8FIQYyFZnSI2ImudP8Q5csayxM8+
        HeN4bheKx8P8BfNt+ii0VTH68LOtX+NYgZECnsuNfvHypr0u+ZxGJZLfHFdlGqfN6c3PHd/nbLMYU
        I6UoIRhRZcjY5HVTLIKWlYtWz5E31l0oFIO97r64gU3R8+sVqMJS4db+PQBiqrSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mfQHr-007Ch8-Gg;
        Tue, 26 Oct 2021 19:30:59 +0200
Message-ID: <6c757e851f2cac76b0e63e10cc6aabe1839f07aa.camel@sipsolutions.net>
Subject: Re: [RFC v2] mac80211: fix rx blockack session race condition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 26 Oct 2021 19:30:58 +0200
In-Reply-To: <DB9PR01MB73541EC2ECFCEF6521B86AFFE4849@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
References: <DB9PR01MB73541EC2ECFCEF6521B86AFFE4849@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-26 at 14:19 +0000, Jean-Pierre TOSONI wrote:
> When used with ath10k, the following may happen:
> a) radio card firmware receives ADDBA-REQ from peer
> b) radio sends back ADDBA-RESP to peer and signals the ath10k driver
> c) ath10k calls back ieee80211_manage_rx_ba_offl() in mac80211
>    to signal rx ba offloading
> d) mac80211::agg-rx.c::ieee80211_manage_rx_ba_offl()
>   d1) sets a flag: sta->ampdu_mlme.tid_rx_manage_offl
>   d2) queues a call to ht.c::ieee80211_ba_session_work()
> e) ...scheduler runs...
> f) ht.c::ieee80211_ba_session_work() checks the flag, clears it
>    and sets up the rx ba session.
> 
> During (e), a fast peer may already have sent a BAREQ which is
> propagated to rx.c::ieee80211_rx_h_ctrl(). Since the session is not
> yet established, mac80211 sends back a DELBA to the peer, which can
> hang the BA session.
> 
> The phenomenon can be observed between two QCA988X fw 10.2.4 radios,
> using a loop of associate/arping from client to AP/disconnect. After
> a few thousand loops, arping does not get a response and a sniffer
> detects a DELBA action frame from the client, following an ADDBA.
> 
> Fix:
> 1) check the offload flag in addition to the check for a valid
>    aggregation session
> 2) surround the checks with the existing dedicated mutex, to avoid
>    interference from ieee80211_ba_session_work() during the check.
> 
> Note 1: there is another dubious DELBA generation in
> ieee80211_rx_reorder_ampdu(), where the same kind of fix should fit,
> but I did not fix it since I knew no easy way to test.
> 
> Note 2: this fix applies to wireless backports from 5.4-rc8.
> ---
> V2: remove debugging code leftovers, sorry for that
> 
> Index: b/net/mac80211/rx.c
> ===================================================================
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> Index: bp/net/mac80211/rx.c
> ===================================================================
> --- bp.orig/net/mac80211/rx.c
> +++ bp/net/mac80211/rx.c
> @@ -3008,11 +3008,18 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_
>  
> 
>  		tid = le16_to_cpu(bar_data.control) >> 12;
>  
> 
> +		mutex_lock(&rx->sta->ampdu_mlme.mtx);

You cannot take a mutex in this context.

johannes

