Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17ED3F83BF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbhHZIaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHZIaD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:30:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05695C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ChWPK7ox2IYbPXxDUF/DiOKMbfiJndJaeviCuolqwVE=;
        t=1629966557; x=1631176157; b=lcV3LLQECc81ntahHXyr0dJ3gu2ZkDk1bN2qLKmKaEgRjbK
        LkaEBskW5WDK7mCANrF95Nyp6ukmkD8Pzi6JgATx4PJkr7NyNKY7jN1zQTU9vQftDZNLqS5v4ogoR
        cn7FJdBQNOS2VBpMq9IyP83aXWnJwBlJzb2p71+ygSddhGcsaXH+ko3B3YviP/LYxI5bI8FeElaRN
        93FJs//DBdoVW3jWp8u9CVeT+h6ia+q9B/cD8TiR/BdU7ZsjrgK0rA0LmEEhPO+zz/30btyuhKSOp
        T+AjzYq1y6hYb/sLjEafY3qe8aaeJM6RWMoRCSqxTMf2+gTMWnVdigIbLajn3M3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAl6-00G4rR-ET; Thu, 26 Aug 2021 10:29:12 +0200
Message-ID: <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:29:11 +0200
In-Reply-To: <20210820122041.12157-9-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-20 at 08:20 -0400, Wen Gong wrote:
> 
>  	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
>  		const struct cfg80211_bss_ies *ies;
> +		struct ieee80211_bss_conf *bss_conf;

am I missing where you set this?

> +		if (is_6ghz) {
> +			struct ieee802_11_elems elems;

This is pretty big, not sure we want it on the stack (causes warnings
for me in build). Also, if we're doing this anyway, then we can change
the code above (perhaps as a separate patch) to not do
cfg80211_find_ext_ie() but rather take it out of the parsed.

> +			u8 i, j = 0;
> +
> +			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,

(line too long)

> +					       NULL, NULL);
> +
> +			if (elems.pwr_constr_elem)
> +				bss_conf->pwr_reduction = *elems.pwr_constr_elem;

before using it?

> +
> +			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
> +				     ARRAY_SIZE(elems.tx_pwr_env));
> +
> +			for (i = 0; i < elems.tx_pwr_env_num; i++) {
> +				if (elems.tx_pwr_env_len[i] >
> +				    sizeof(bss_conf->tx_pwr_env[j]))
> +					continue;

I did that in the parsing itself.

> +
> +				bss_conf->tx_pwr_env_num++;
> +				memcpy(&bss_conf->tx_pwr_env[j], elems.tx_pwr_env[i],
> +				       elems.tx_pwr_env_len[i]);

You're never resetting any of this for the next connection (if it's not
6 GHz for example, or doesn't have any data) - should probably memset
all the new members to 0 before the "if (is_6ghz)" or so?

johannes

