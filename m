Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF246731A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 09:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379121AbhLCIMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 03:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351103AbhLCIMA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 03:12:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091AC06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Bd+CBI+rwfqV6PWnqG4nfx1zEIIehYAYXfIYAzAyHoE=;
        t=1638518916; x=1639728516; b=terBg66k4pEtfM/4lJWQbhvrGJRZSuFROuMIOU3yWE/wybn
        43ZIWIzOFjgUY2beP6EoEDcvB2DS0Npv2zQOSp+m1MRktgVnCKBjIxtODF5oRD/gdlke8rwy6YmFy
        J7k+1aOxv8A1j9gsjl2ewwwpVVZzMK3Mda4WzhRM7QaGAYox5Ek8Xa9THwX6GSumS4WPG3tZ+i6yu
        e770/dgR6TYmXSv1mMgzy4PWTEJKog2yUk9LIbPnTbj3nzfuOFS/cl2rEsX33jdkoigt/UHpx89PL
        QvDG1Wcykg1nmtChgLEiWYomtsnKK9HdlroLJgi9Vi1AvZ0fqwxtbdS30KGfOGkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mt3cP-006Gg1-Tf;
        Fri, 03 Dec 2021 09:08:34 +0100
Message-ID: <3a4fc4398a5dfe03933de8d695a8b605d700a94b.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: disable BSS color collision detection in case
 of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Date:   Fri, 03 Dec 2021 09:08:32 +0100
In-Reply-To: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
References: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-12-03 at 10:11 +0530, Rameshkumar Sundaram wrote:
> 
> +++ b/net/mac80211/cfg.c
> @@ -995,6 +995,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
>  	struct beacon_data *new, *old;
>  	int new_head_len, new_tail_len;
>  	int size, err;
> +	const u8 *cap;
> +	struct ieee80211_he_operation *he_oper = NULL;
>  	u32 changed = BSS_CHANGED_BEACON;
>  
>  	old = sdata_dereference(sdata->u.ap.beacon, sdata);
> @@ -1082,6 +1084,27 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
>  		changed |= BSS_CHANGED_FTM_RESPONDER;
>  	}
>  
> +	if (sdata->vif.bss_conf.he_support) {
> +		cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION,
> +					   params->tail, params->tail_len);
> +		if (cap && cap[1] >= sizeof(*he_oper) + 1)
> +			he_oper = (void *)(cap + 3);
> 

I'm not sure I like this mechanism - in ieee80211_start_ap() we
explicitly take it from the parameters given via nl80211, so it feels
the same should be true here. Why isn't it done that way?

(And if we decide it should be this way then you should be using a new
"const struct element *cap" instead of "const u8 *cap", with the better
helpers functions etc.)

johannes
