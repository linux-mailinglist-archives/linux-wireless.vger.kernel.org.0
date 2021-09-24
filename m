Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325341701F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbhIXKPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245422AbhIXKPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:15:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC2AC061574
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PSDjjqFEK8yvy3cpVLa1oXndjT4ON15AUe4vO91EleE=;
        t=1632478423; x=1633688023; b=aQcyQZjs949Ms/LrXP6PG9QzXh1Oku3G7sLit6DMMo59ppu
        HwGb9mvh7WPUVOZ5yDc/eG5h8X/1wv+j047+zbykWi+L9/SJaLTD8gsgnPqanvsb1wTJQJiI++nY4
        H18ix5GB2uuUUzT26DOPG6zJnQNkNyyafyp2Wwzb6/d/r8z3SXaFlOnOr36QcO6K9S3K2xLkoEf1G
        PvT0e6pUXP+xLrpirYrxt4C7AusiTawfk44qPj2D3fVlEfSlmuvnPVLz7yuQT5bGdCCohv4GDR1dj
        qUdJotg1lp8KahrBbEGoGUMRxK3dkgC8FvrKAaPtPHFisnC6kkb4f+F82DBqvhcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTiD3-00B9Fh-Iu;
        Fri, 24 Sep 2021 12:13:37 +0200
Message-ID: <b02735cc844c9ba2222d23a7e6ad112a82a36891.camel@sipsolutions.net>
Subject: Re: [PATCH v4 5/6] mac80211: use ieee802_11_parse_elems() to find
 ies instead of ieee80211_bss_get_ie()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Sep 2021 12:13:36 +0200
In-Reply-To: <20210924100052.32029-6-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
         <20210924100052.32029-6-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Taking a brief look before lunch,

>  	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
>  		const u8 *ht_oper_ie, *ht_cap_ie;
>  
> 
> 
> 
> -		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
> +		ht_oper_ie = elems->ht_operation ?
> +			((const u8 *)elems->ht_operation) - 2 :
> +			NULL;
>  		if (ht_oper_ie && ht_oper_ie[1] >= sizeof(*ht_oper))
>  			ht_oper = (void *)(ht_oper_ie + 2);

Can't we drop these checks, and simply do

ht_oper = elems->ht_operation?

After all, ieee802_11_parse_elems() should already be doing the
necessary length checks? We just didn't have that with
ieee80211_bss_get_ie().

> -		ht_cap_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_CAPABILITY);
> +		ht_cap_ie = elems->ht_cap_elem ?
> +			((const u8 *)elems->ht_cap_elem) - 2 :
> +			NULL;
>  		if (ht_cap_ie && ht_cap_ie[1] >= sizeof(*ht_cap))
>  			ht_cap = (void *)(ht_cap_ie + 2);

Likewise for all the others.

johannes

