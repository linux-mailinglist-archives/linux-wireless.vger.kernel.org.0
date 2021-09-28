Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A041AC3D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhI1Juw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbhI1Juv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 05:50:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D1C061575
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gVygL8NWJazG9U8eKs4sk0YYTq98BZMRtdV7MwVt3GI=;
        t=1632822552; x=1634032152; b=vcVyXDaET6o35qRC1M7YuKVP/lSkT+yAldpzheooYvXUKVq
        THFWuyR/+ebD8KzHjmYi6mX3rUzOcyodWsSdII508zhql+tyqDRaZGAiN+RnecC28MSei2xEbyxMS
        5fHyRZpo3b8mXcUsecWCtdLmCwuvpct+20nscCTs+ApZB0KGPQUAmfmGflkDerz7KntYkMntJkeXa
        zZfUQJREeeIz+J+tVfbpQyPRc66S5fg9ONycNtA3CBRLap1ToVzR03AUcCk9MDzG+GApoOLEopYuj
        nYyY2VIEpLmDJV5+eBGua8NrXy6UtsxGsugLXYsTdUVkubb6o8ZPNw2YYrg2dMkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mV9ja-00Cp06-RO;
        Tue, 28 Sep 2021 11:49:10 +0200
Message-ID: <90a894c9b8e38faaf5f324bd7ed390bb1abaf9c5.camel@sipsolutions.net>
Subject: Re: [PATCH v12 4/4] mac80211: MBSSID channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Tue, 28 Sep 2021 11:49:10 +0200
In-Reply-To: <20210916025437.29138-5-alokad@codeaurora.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
         <20210916025437.29138-5-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-15 at 19:54 -0700, Aloka Dixit wrote:
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 23fa0bb49be2..88fbed46e1bc 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -3271,8 +3271,19 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
>  {
>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>  
> 
> 
> 
> -	ieee80211_queue_work(&sdata->local->hw,
> -			     &sdata->csa_finalize_work);
> +	if (vif->mbssid_tx_vif == vif) {
> +		struct ieee80211_sub_if_data *child, *tmp;
> +
> +		list_for_each_entry_safe(child, tmp,
> +					 &sdata->local->interfaces, list)

I don't see any reason to believe that this list iteration should be
safe?

johannes


