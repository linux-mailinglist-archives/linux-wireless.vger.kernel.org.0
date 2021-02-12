Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264BD319B7D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBLIt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 03:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBLIt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 03:49:28 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D0C061756
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 00:48:48 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAU86-001mGd-CJ; Fri, 12 Feb 2021 09:48:46 +0100
Message-ID: <0f45b43c5a2dd4d0d2839487540611994ec10feb.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 09:48:45 +0100
In-Reply-To: <1607468044-31789-2-git-send-email-msinada@codeaurora.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
         <1607468044-31789-2-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +void ieee80211_update_muedca_params(struct ieee80211_hw *hw,
> +				    struct ieee80211_mu_edca_param_set
> +				    *params, gfp_t gfp)
> +{
> +	struct ieee80211_local *local = hw_to_local(hw);
> +
> +	trace_api_update_muedca_params(local, params);
> +
> +	cfg80211_update_muedca_params_event(local->hw.wiphy, params, gfp);
> +}
> +EXPORT_SYMBOL(ieee80211_update_muedca_params);
> 

I see no reason to have this trivial wrapper.

johannes

