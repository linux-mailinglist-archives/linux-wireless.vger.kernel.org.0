Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9A18CE38
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCTM6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 08:58:46 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45788 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCTM6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jFHEX-00ArxK-Dx; Fri, 20 Mar 2020 13:58:41 +0100
Message-ID: <d54ca54a2a7801b796393be3f5414f7a657773b4.camel@sipsolutions.net>
Subject: Re: 4addr NDP in HE mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>,
        'Luca Coelho' <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org, shaul.triebitz@intel.com
Date:   Fri, 20 Mar 2020 13:58:40 +0100
In-Reply-To: <006501d5e621$f21f3b60$d65db220$@codeaurora.org> (sfid-20200218_070924_650739_B62973D0)
References: <006501d5e621$f21f3b60$d65db220$@codeaurora.org>
         (sfid-20200218_070924_650739_B62973D0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-02-18 at 11:39 +0530, Sathishkumar Muruganandam wrote:

> Since ieee80211_send_4addr_nullfunc() is only called for successful
> association of 4addr STA, shall we allow below case alone for HE ?
> 
> static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
>                                     struct cfg80211_bss *cbss,
>                                     struct ieee80211_mgmt *mgmt, size_t len,
>                                     struct ieee802_11_elems *elems)
> {
> ..
>   /*
>          * If we're using 4-addr mode, let the AP know that we're
>          * doing so, so that it can create the STA VLAN on its side
>          */
>         if (ifmgd->use_4addr)
>                 ieee80211_send_4addr_nullfunc(local, sdata);
> ..
> 
> Whether this 4addr NDP in HE mode will affect any UL-MIMO from the 4addr STA
> ? Please comment.

Off the top of my head, I don't know. Adding Shaul who might have an
idea.

Shaul, basically the NDP is used here to initialize the 4-addr
connection as such, and if the connection is HE capable we drop it. Can
you remind me what exactly the issue with NDP in HE was, and do you know
how that'd be affected by 4-addr NDPs?

Thanks,
johannes

