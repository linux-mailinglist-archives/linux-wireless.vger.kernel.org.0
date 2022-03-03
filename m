Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18614CC981
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiCCWze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 17:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiCCWzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 17:55:31 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5A2DF7
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 14:54:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id B194710FB7;
        Thu,  3 Mar 2022 22:54:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HbPdZCswDxCp; Thu,  3 Mar 2022 22:54:42 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 04 Mar 2022 00:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646348081; bh=3mVS+J+G6cZDzAsqcv2R5ouW8PV/U6R/T+sLY7znFUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOGDUkwZZLTFBn91A20ocZ9MIi034X1OARCyjB2CsjR8KaZw6nxw1RDwEbbkSR0SV
         EkZDH8DMPy3Hx4t7Z7UK2bwB8l/ApQ/ljhKKFi8w9uVIarRobCeLHAogAg/hLKZ0Oe
         u5it+QratGYS6GG72iGKKe1aZQjj/MIdm8zyV1E0LiTbEa8WvV5nttjzJrqwOMQFdD
         NOEVOoZ5gac6rOaJOvUni62KrOfzVcJqJYQt1GGwh9eJAZ/cUFGv/a2NVEEIBZSFtN
         4wdl+RgQUYDp4QIr31VOERnw4N2Ti8JN+vWNVXKWo2xTfWRF+69qV04ooROmNPODEI
         Iikwuqjy6vVHA==
Date:   Fri, 4 Mar 2022 00:54:39 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 6/9] DFS: introduce hostapd_dfs_request_channel_switch
 routine
Message-ID: <20220303225439.GD33342@w1.fi>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <c1bf7dc195281330e7108c533da5770adf479d84.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bf7dc195281330e7108c533da5770adf479d84.1640014128.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 04:48:21PM +0100, Lorenzo Bianconi wrote:
> This is a preliminary patch to add Channel Switch Announcement for
> background radar detection.

> diff --git a/src/ap/dfs.c b/src/ap/dfs.c
> @@ -940,6 +940,85 @@ int hostapd_is_dfs_chan_available(struct hostapd_iface *iface)
>  
> +static int hostapd_dfs_request_channel_switch(struct hostapd_iface *iface,

> +	struct hostapd_hw_modes *cmode = iface->current_mode;
> +	int ieee80211_mode = IEEE80211_MODE_AP, err, i;

That i needs to be unsigned int (like it was in the function from which
it was moved to here) to avoid a compiler warning.

> +	u8 new_vht_oper_chwidth;

> +	new_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);
> +	hostapd_set_oper_chwidth(iface->conf,
> +				 hostapd_get_oper_chwidth(iface->conf));

This looks quite strange.. hostapd_dfs_start_channel_switch() used
current_vht_oper_chwidth to store the current value from beginning of
the function and restored it at this location. The new version in this
helper function seems to something strange, or well, nothing. That does
not feel correct.

>  static int hostapd_dfs_start_channel_switch(struct hostapd_iface *iface)
>  {
> -	unsigned int i;

That's where i was unsigned..

> -	u8 current_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);

And that's where the current value is picked at the beginning of
hostapd_dfs_start_channel_switch().

> -	new_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);
> -	hostapd_set_oper_chwidth(iface->conf, current_vht_oper_chwidth);

And this looks quite different compared to what was in the new helper
function.

-- 
Jouni Malinen                                            PGP id EFC895FA
