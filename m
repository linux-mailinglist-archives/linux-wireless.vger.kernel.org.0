Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4E2334B1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgG3OnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgG3OnR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:43:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71642C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:43:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19m6-00DaQa-Et; Thu, 30 Jul 2020 16:43:15 +0200
Message-ID: <c3dbcc3e4ee2d3596625e8c1226325180444a961.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/2] nl80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 16:43:13 +0200
In-Reply-To: <20200618050427.5891-2-alokad@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
         <20200618050427.5891-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-06-17 at 22:04 -0700, Aloka Dixit wrote:
> + * @NL80211_FILS_DISCOVERY_TMPL: Optional FILS discovery template.
> + *	It has contents of IEEE Std 802.11ai-2016 9.6.8.36 FILS discovery frame
> + *	(Figure 9-687a).

Is that

"It has (contents of ... FILS discovery frame) ..."

or

"It has contents of (... FILS discovery frame) ..."?

I mean, is that with or without headers? The wording doesn't seem
entirely clear to me.

OTOH, if it's with headers, how could it be optional? In fact, either
way, how is it optional?

> +static int nl80211_parse_fils_discovery(struct nlattr *attrs,
> +					struct cfg80211_ap_settings *params)
> +{
> +	struct nlattr *tmpl;
> +	struct nlattr *tb[NL80211_FILS_DISCOVERY_MAX + 1];
> +	int ret;
> +	struct cfg80211_fils_discovery *fd = &params->fils_discovery;
> +
> +	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_MAX, attrs,
> +			       fils_discovery_policy, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (!tb[NL80211_FILS_DISCOVERY_INT_MIN] ||
> +	    !tb[NL80211_FILS_DISCOVERY_INT_MAX])
> +		return -EINVAL;
> +
> +	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MIN]);
> +	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MAX]);
> +
> +	tmpl = tb[NL80211_FILS_DISCOVERY_TMPL];
> +	if (tmpl) {
> +		fd->tmpl = nla_data(tmpl);
> +		fd->tmpl_len = nla_len(tmpl);

And if it's with headers, it should have some kind of minimum length
too? You've only put a maximum length into the policy.

(Which reminds me I wanted to have an NLA_POLICY_RANGE(NLA_BINARY, min,
max) but haven't done that yet ...)

johannes

