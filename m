Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B183B1E40
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFWQFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWQFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 12:05:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4BC061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 09:03:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lw5LK-00AcSW-NX; Wed, 23 Jun 2021 18:03:10 +0200
Message-ID: <1d8645c19faf4c7aa759d8af3d4dfd993049daf4.camel@sipsolutions.net>
Subject: Re: [PATCH v10 4/4] mac80211: CSA on non-transmitting interfaces
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Wed, 23 Jun 2021 18:03:09 +0200
In-Reply-To: <20210426190534.12667-5-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
         <20210426190534.12667-5-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-26 at 12:05 -0700, Aloka Dixit wrote:
> 
> +	if (sdata->vif.mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
> +		struct ieee80211_sub_if_data *child;
> +
> +		wiphy_unlock(sdata->local->hw.wiphy);
> +		mutex_lock(&sdata->local->iflist_mtx);
> +		list_for_each_entry(child, &sdata->local->interfaces, list)
> +			if (child->vif.mbssid.parent == vif &&
> +			    ieee80211_sdata_running(child))
> +				ieee80211_queue_work(&child->local->hw,
> +						     &child->csa_finalize_work);
> +		mutex_unlock(&sdata->local->iflist_mtx);
> +		wiphy_lock(sdata->local->hw.wiphy);

Same here wrt. locking, but for queueing work it shouldn't matter?

johannes

