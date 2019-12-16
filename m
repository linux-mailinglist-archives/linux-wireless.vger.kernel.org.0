Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6110120190
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 10:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLPJ4D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 04:56:03 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42522 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLPJ4D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:03 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ign6f-001Chw-7W; Mon, 16 Dec 2019 10:56:01 +0100
Message-ID: <a67dd924ebb638a8ba2b742a07fd3d1db34732ce.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/7] nl80211: add handling for BSS color
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Mon, 16 Dec 2019 10:56:00 +0100
In-Reply-To: <20191213155802.25491-2-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
         <20191213155802.25491-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +/**
> + * enum nl80211_bss_color_attributes - BSS Color attributes
> + * @__NL80211_HE_BSS_COLOR_ATTR_INVALID: Invalid
> + *
> + * @NL80211_HE_BSS_COLOR: the current BSS Color.
> + * @NL80211_HE_BSS_COLOR_DISABLED: is BSS coloring disabled.
> + * @NL80211_HE_BSS_COLOR_PARTIAL: the AID equation to be used..

It makes the names somewhat awkwardly long, but I think _ATTR should be
included here like the invalid/last/max, to make clear it's not the
color itself or something like that?

> +static const struct nla_policy
> +he_bss_color_policy[NL80211_HE_BSS_COLOR_ATTR_MAX + 1] = {

I didn't realize this before and really thought about it only because I
saw the one for the nl80211_policy in the context now, but I guess this
should have a strict start type like below:

>  	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },

though in this case we can probably do

	[0] = { .strict_start_type = 0 },

to indicate that all these should be treated strictly.


Also, not directly related to any code, can't the BSS color change, and
thus you need a method to update it?

johannes

