Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5A120175
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 10:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLPJtq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 04:49:46 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42374 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLPJtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 04:49:46 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ign0Z-001Bus-QJ; Mon, 16 Dec 2019 10:49:43 +0100
Message-ID: <c4b44147e00a8c86931f680d8ea4825cebb4a524.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/7] mac80211: add a struct for holding BSS color
 settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Mon, 16 Dec 2019 10:49:42 +0100
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-13 at 16:57 +0100, John Crispin wrote:
> Right now we only track the actual color but not the other bits contained
> within the he_oper field. Fix this by creating a new struct to hold all
> of the info.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/cfg80211.h | 15 +++++++++++++++
>  include/net/mac80211.h |  2 ++
>  2 files changed, 17 insertions(+)

I think you should drop this patch and put the cfg80211 and mac80211
update into the second and third patch of this series, respectively. It
doesn't make much sense to add some unused structs.

> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 8140c4837122..e395ef48af83 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -259,6 +259,19 @@ struct ieee80211_he_obss_pd {

It looks like I didn't see that previously for that one,

> + * struct ieee80211_he_bss_color - AP settings for BSS coloring

but I'd kinda prefer this be called cfg80211_... since it's not part of
ieee80211.h with all the over-the-air struct definitions. I'm sure we
have some non-over-the-air things that are called ieee80211_*, but ...

johannes

