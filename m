Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17E741970C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhI0PDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhI0PDR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 11:03:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C1C061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AmafM7oTsaSvRec3LgbJaU361CT7WRh5EiFpJgFNI7I=;
        t=1632754899; x=1633964499; b=vXN8v55bZ4RLVVAkUyhI8rW0DUzLtkKB3Ut4VvgYz4nCKN8
        1GU9PSuNR8Xz8CR76yDSzsScYYR/ppz4hFSch2ZCUd4fTYN3pjQJ/y+LbKrKz5dxUbj39gVosR+QY
        ELtmeZDrh2qBLeP3vbJd0myr5AGp7vzOM/kXcf4gHY+BuCn97itzVf+fzjwWccZoSiP9hnf3h/ziW
        8vFcyGp+iIjiPZfo33DOBuPfYOmOaqZTaMd1KcxOp21/hXGcI15x9wRulhmVf7dtODSlcrqWIm0Qp
        2sGdaJsIjcbBO0oEHkWUiLW909kP0NsuMPy9s44q5hWWaEXYu9eulKYG8qJQncHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUs8L-00CTDL-PA;
        Mon, 27 Sep 2021 17:01:33 +0200
Message-ID: <f300c9d2aae4b9b0e654f8a1e26c6e64beef7132.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix incorrect nss config
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thiraviyam Mariyappan <tmariyap@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 27 Sep 2021 17:01:32 +0200
In-Reply-To: <1632750104-1722-1-git-send-email-tmariyap@codeaurora.org>
References: <1632750104-1722-1-git-send-email-tmariyap@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-09-27 at 19:11 +0530, Thiraviyam Mariyappan wrote:
> In HE capabilities, HE-MCS Rx map field filled with value 0x3 for all eight
> spatial streams if txrx chains configured as incorrect value.
> This patch changes configure at least single spatial stream for HE-MCS
> 0 to 7 in all supported channel widths if nss configured as incorrect
> value.
> 
> Signed-off-by: Thiraviyam Mariyappan <tmariyap@codeaurora.org>
> ---
>  net/mac80211/he.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mac80211/he.c b/net/mac80211/he.c
> index c05af70..ee113ff5 100644
> --- a/net/mac80211/he.c
> +++ b/net/mac80211/he.c
> @@ -151,6 +151,13 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
>  		       &he_cap_ie[sizeof(he_cap->he_cap_elem) + mcs_nss_size],
>  		       he_ppe_size);
>  
> 
> +	if (he_cap->he_mcs_nss_supp.rx_mcs_80 == cpu_to_le16(0xFFFF)) {
> +		he_cap->has_he = false;
> +		sdata_info(sdata, "Ignoring HE IE from %pM due to incorrect rx_mcs_80\n",
> +			   sta->addr);
> +		return;
> +	}

Like so many other workarounds, this should probably come with a comment
as to _why_ we're doing this, ideally including the model/firmware
version ...

johannes

