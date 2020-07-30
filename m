Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9082334B9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgG3OrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3OrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:47:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A1C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:47:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19q5-00DaXj-R5; Thu, 30 Jul 2020 16:47:21 +0200
Message-ID: <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/2] mac80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 16:47:21 +0200
In-Reply-To: <20200618050427.5891-3-alokad@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
         <20200618050427.5891-3-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-06-17 at 22:04 -0700, Aloka Dixit wrote:

> +++ b/net/mac80211/cfg.c
> @@ -837,6 +837,33 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
>  	return 0;
>  }
>  
> +static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
> +					struct cfg80211_fils_discovery *params)
> +{
> +	struct fils_discovery_data *new, *old = NULL;
> +	struct ieee80211_fils_discovery *fd;
> +
> +	fd = &sdata->vif.bss_conf.fils_discovery;
> +	fd->min_interval = params->min_interval;
> +	fd->max_interval = params->max_interval;
> +
> +	if (!params->tmpl || !params->tmpl_len) /* Optional template */
> +		return 0;

Now I'm even more confused. If the template is optional, then if it's
not given it doesn't mean *everything* should be ignored, does it?

What would be the point of that? OTOH, if the template isn't there, what
would you do?

But it still doesn't make sense - if no template means you shouldn't do
anything then that doesn't mean the template should be optional, that
just means userspace shouldn't even put the NL80211_ATTR_FILS_DISCOVERY
attribute when it doesn't want anything to be done?

So it seems to me that something doesn't match. Either the template is
truly optional and then this shouldn't just return success, or the
template isn't actually optional?

> +	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery);
> +	if (err < 0) {
> +		ieee80211_vif_release_channel(sdata);
> +		return err;

Is there no goto label for this error case?

> +struct fils_discovery_data {
> +	struct rcu_head rcu_head;
> +	int len;
> +	u8 data[0];

please use [] not [0].

> +struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
> +						  struct ieee80211_vif *vif)
> +{
> +	struct sk_buff *skb = NULL;
> +	struct fils_discovery_data *tmpl = NULL;
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +
> +	if (sdata->vif.type != NL80211_IFTYPE_AP)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	tmpl = rcu_dereference(sdata->u.ap.fils_discovery);
> +	if (!tmpl) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	skb = dev_alloc_skb(tmpl->len);
> +	if (skb)
> +		skb_put_data(skb, tmpl->data, tmpl->len);

You should consider the headroom that the driver may have requested.

johannes


