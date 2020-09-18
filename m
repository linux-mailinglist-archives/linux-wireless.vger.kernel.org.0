Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4647270370
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRReq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRRep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 13:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3831C0613CE
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 10:34:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJKHS-006OZo-MX; Fri, 18 Sep 2020 19:34:42 +0200
Message-ID: <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com, emmanuel.grumbach@intel.com,
        linuxwifi@intel.com
Date:   Fri, 18 Sep 2020 19:34:41 +0200
In-Reply-To: <20200918171301.6942-1-alexander@wetzel-home.de> (sfid-20200918_192059_393491_AE270348)
References: <20200918171301.6942-1-alexander@wetzel-home.de>
         (sfid-20200918_192059_393491_AE270348)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-18 at 19:13 +0200, Alexander Wetzel wrote:
> 
> +		/* GCMP and 256 bit CCMP keys the key can't be copied into the
> +		 * MPDU struct ieee80211_tx_info. We therefore must flush the
> +		 * queues to ensure there are no MPDUs left which are referring
> +		 * to the outgoing key.
> +		 */
> +		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
> +		    (key->cipher == WLAN_CIPHER_SUITE_GCMP ||
> +		     key->cipher == WLAN_CIPHER_SUITE_GCMP_256 ||
> +		     key->cipher == WLAN_CIPHER_SUITE_CCMP_256)) {
> +			ieee80211_stop_queues(hw);
> +			iwl_mvm_mac_flush(hw, vif, 0, true);
> +			ieee80211_wake_queues(hw);
> +		}

Shouldn't the wake be after installing the new key? Otherwise new frames
can race and be there again?

johannes

