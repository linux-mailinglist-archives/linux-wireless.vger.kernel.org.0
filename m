Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA026FAC7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRKlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKlp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:41:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FEC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:41:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDpn-006CW7-Vj; Fri, 18 Sep 2020 12:41:44 +0200
Message-ID: <b18058078243f8b3dee0f8bc0b41e65d190fbeb8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/22] nl80211: support S1G capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:41:43 +0200
In-Reply-To: <20200831205600.21058-9-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-9-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> 
> +	NL80211_ATTR_S1G_CAPABILITY,
> +	NL80211_ATTR_S1G_CAPABILITY_MASK,
>  	/* add attributes here, update the policy in nl80211.c */

nit: keep a blank line?

>  	[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
>  		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
> +	[NL80211_ATTR_S1G_CAPABILITY] = { .len = NL80211_S1G_CAPABILITY_LEN },
> +	[NL80211_ATTR_S1G_CAPABILITY_MASK] = {
> +					.len = NL80211_S1G_CAPABILITY_LEN },

Please use the NLA_POLICY_EXACT_LEN() as in the line above, unless this
really was meant to be a *minimum* length, which I doubt?

johannes

