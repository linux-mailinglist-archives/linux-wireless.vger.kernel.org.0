Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61AB23A1B2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHCJVZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 05:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHCJVZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 05:21:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032AC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 02:21:25 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2Wep-00FbV1-OH; Mon, 03 Aug 2020 11:21:23 +0200
Message-ID: <af175aa6d9fb0c99489a4b1455910d79d6cddc34.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Add HE UL MU fixed rate setting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 03 Aug 2020 11:21:18 +0200
In-Reply-To: <1590705789-20910-1-git-send-email-msinada@codeaurora.org>
References: <1590705789-20910-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 15:43 -0700, Muna Sinada wrote:
> This patch adds nl80211 definitions, policies and parsing code required
> to pass HE UL MU fixed rate settings.

This seems to apply now, but doesn't compile. Also,

>  	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
>  						   NL80211_RATE_INFO_HE_1XLTF,
>  						   NL80211_RATE_INFO_HE_4XLTF),
> +	[NL80211_TXRATE_HE_UL] = {
> +		.type = NLA_EXACT_LEN,
> +		.len = sizeof(struct nl80211_txrate_he),
> +	},

Please modernize that (there's a macro).

> +		if (tb[NL80211_TXRATE_HE_UL] &&
> +		    !he_set_mcs_mask(info, sband,
> +				     nla_data(tb[NL80211_TXRATE_HE_UL]),
> +				     mask->control[band].he_ul_mcs))
> +			return -EINVAL;

And please add an netlink extack error message here.

johannes

