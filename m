Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131633D82C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhCPPvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbhCPPvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 11:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50056C06174A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 08:51:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMByH-00GzXj-Rk; Tue, 16 Mar 2021 16:51:01 +0100
Message-ID: <e38a1ff5efbe5532a97310c053b50c6ce5ef027e.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix low throughput due to invalid addba
 extension
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Govindaraj <gsamin@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Tue, 16 Mar 2021 16:51:00 +0100
In-Reply-To: <1615909674-13412-1-git-send-email-gsamin@codeaurora.org>
References: <1615909674-13412-1-git-send-email-gsamin@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-03-16 at 21:17 +0530, Govindaraj wrote:
> Addba request action frame received with the extension element from
> certain 11ac stations,
> 

Please indicate which so we have a record of who's shipping broken junk.

> but the cmd id and length not matching to addba
> extension and it failing in element parsing.

> Due to this, addba request
> not acknowledged and aggregation not started which is causing low
> throughput. Hence validating the cmd id before processing addba extension.

>  	ies_len = len - offsetof(struct ieee80211_mgmt,
>  				 u.action.u.addba_req.variable);
> -	if (ies_len) {
> +	if (ies_len &&
> +	    mgmt->u.action.u.addba_req.variable[0] == WLAN_EID_ADDBA_EXT) {
>  		ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
>                                  ies_len, true, &elems, mgmt->bssid, NULL);
>  		if (elems.parse_error)

So we get into parse_error without this?

What are they putting there instead?

johannes

