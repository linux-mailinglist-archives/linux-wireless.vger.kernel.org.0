Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F2C4501FC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKOKJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKOKJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:09:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F4C061746
        for <linux-wireless@vger.kernel.org>; Mon, 15 Nov 2021 02:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h3CghpS4THPfvA+RWJNDA0/YctDKeZ4byMEXxSecqXc=;
        t=1636970809; x=1638180409; b=PbSJUVjestyvq2v9c3T82k/GTY8gjvXI2p+HrI4geMBbOVw
        Tv6JnDw/btwYMh8o41TL5iWLBm0F06z8NUrEcTO23JmNKCKKLtq8o7SbZKBxLem3lL2hkdfHlKCRH
        pUG5H1TX5kguVqheq7C3IBPW1JaxxLlRwFEvg/CjX0J8Pkg9QGDVojNfzlIAdToTorV7XwjtI7M1t
        w2KPS9WkoTkOL3Qk6R3OkGT/FUPnVzMSIxgSzRAWb5j/E4vJFZqeA89qpqGozNur71jnxarBI6aFS
        kcaAl7hBPJrGh58/6q33M8ZvJ6Ort6hr9weXW2WxGx6NPjqFZgh9uKc8aH/m8OrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mmYsy-00FXoZ-84;
        Mon, 15 Nov 2021 11:06:48 +0100
Message-ID: <2d3ef764f006af12216c663b7a0f532741a04dd6.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix a memory leak where sta_info is not freed
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ahmed Zaki <anzaki@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 15 Nov 2021 11:06:47 +0100
In-Reply-To: <20211002145329.3125293-1-anzaki@gmail.com>
References: <20211002145329.3125293-1-anzaki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-10-02 at 08:53 -0600, Ahmed Zaki wrote:
> 
> +++ b/net/mac80211/sta_info.c
> @@ -640,12 +640,14 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
>  
>  	/* check if STA exists already */
>  	if (sta_info_get_bss(sdata, sta->sta.addr)) {
> +		sta_info_free(local, sta);
>  		err = -EEXIST;
>  		goto out_err;
>  	}
>  
>  	sinfo = kzalloc(sizeof(struct station_info), GFP_KERNEL);
>  	if (!sinfo) {
> +		sta_info_free(local, sta);
>  		err = -ENOMEM;
>  		goto out_err;
>  	}

We already have a "out_drop_sta", that calls cleanup_single_sta(), so
shouldn't we just add a label there ("out_free_sta") just before
cleanup_single_sta() and then we don't need the extra call?

johannes
