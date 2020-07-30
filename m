Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295A52330E3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG3LYe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG3LYe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 07:24:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D4C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:24:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k16fo-00DUSW-9m; Thu, 30 Jul 2020 13:24:32 +0200
Message-ID: <f6daeb86f2cf83f57785e08b86fecfdf6410de46.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: save he oper info in bss config for AP and
 mesh
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 13:24:16 +0200
In-Reply-To: <20200715030937.25290-1-pradeepc@codeaurora.org> (sfid-20200715_050947_264568_478AF07B)
References: <20200715030937.25290-1-pradeepc@codeaurora.org>
         (sfid-20200715_050947_264568_478AF07B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please always capitalize acronyms. I might let you get away with a
lower-case "BSS" since that doesn't actually *mean* anything, but "he"
is actually an English word...

Anyway, since you haven't paid attention to the robot, I'll drop this
one way or the other.

Also,

> -u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
> +u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef,
> +			       struct ieee80211_sub_if_data *sdata)
>  {
>  	struct ieee80211_he_operation *he_oper;
>  	struct ieee80211_he_6ghz_oper *he_6ghz_op;
> @@ -3056,6 +3057,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
>  	he_oper = (struct ieee80211_he_operation *)pos;
>  	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
>  
> +	sdata->vif.bss_conf.he_oper.params = he_oper_params;

I think these changes are inappropriate. This is a helper function to
build something, not to store the data. Please change the callers
instead.

johannes

