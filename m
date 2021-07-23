Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423593D37CE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGWI5f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhGWI5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:57:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FFCC061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eUVyJTsXca/APXODLERsMKrpqSYREs/lN68WW+NlIgk=;
        t=1627033088; x=1628242688; b=AW6j+6cfN8El4MxcoiUNv4Rm6nZL5gGTRCxcBZtCDqAJhI8
        4V/gbNDTV5AOoMypmigCCDaFWjOfHBtTBC2S4QLkHLZRZCVp7a4T3x72XZszhUMUCuBSUnaeNgs79
        OifehwbmZ36HhSGr3M+Ouhgn2Qs51SsU205aWacAyB7w95riDdAWaBFrDuSE9WoZUEwvlPWRu7m+X
        D+75eBjV92mqP3G5Mu7whcT60Xt9IZ2eD4XlW3o4TJpCZ25sshrcDAvzKj4RCBNfC5W+plvvrs3M0
        elVylFSRS33LzIOPRw35z29BbeBtkDe4s1IqDsb/h2l2Vwdu4p+eZBxmoFAlI5Zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6raW-000UP2-Rq; Fri, 23 Jul 2021 11:38:03 +0200
Message-ID: <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:38:02 +0200
In-Reply-To: <20210517201932.8860-10-wgong@codeaurora.org> (sfid-20210517_222034_029448_A9A89D57)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-10-wgong@codeaurora.org>
         (sfid-20210517_222034_029448_A9A89D57)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
> 
> +		if (is_6ghz) {
> +			struct ieee802_11_elems elems;
> +			struct ieee80211_bss_conf *bss_conf;
> +			u8 i, n;
> +
> +			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,
> +					       NULL, NULL);
> +			bss_conf = &sdata->vif.bss_conf;
> +			bss_conf->pwr_reduction = 0;
> +			if (elems.pwr_constr_elem)
> +				bss_conf->pwr_reduction = *elems.pwr_constr_elem;
> +
> +			memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
> +			bss_conf->tx_pwr_env_num = elems.tx_pwr_env_num;
> +			n = min_t(u8, elems.tx_pwr_env_num,
> +				  ARRAY_SIZE(elems.tx_pwr_env));

If anything, that min_t would make sense only if you were actually using
ARRAY_SIZE(bss_conf->tx_pwr_env), but like this it's quite pointless,
just checking again if the element parsing was internally consistent?

I'd probably remove it and throw in a

	BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
                     ARRAY_SIZE(elems.tx_pwr_env));

instead.

> +			for (i = 0; i < n; i++)
> +				memcpy(&bss_conf->tx_pwr_env[i], elems.tx_pwr_env[i],
> +				       elems.tx_pwr_env_len[i]);

You also never validated that the element wasn't too long!


If you connect to 6 Ghz with this, and then again to another AP that
doesn't, you'll have it stuck at the old values. You need to reset at
some point (during disconnect).

And then two more questions:

1) Could this information change? Should we track it in beacons?

2) Should we at least check it again from the protected beacon or such
after association, so we don't blindly trust the probe response or
beacon (received during scan, not validated) at least when BIGTK is in
use?

johannes

