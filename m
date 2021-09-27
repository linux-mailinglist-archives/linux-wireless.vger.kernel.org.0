Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95D419315
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhI0L3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhI0L3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 07:29:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FFC061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Nz+y2JP7TwcTL0tlwgIA9WmBtkgmcv08htMspl3Amhw=;
        t=1632742077; x=1633951677; b=uV4o7oDLMzRWIgP3wWFweEbOhVFwn8RgYQkn/PbJX5wF2mW
        KqIOa8ppAPEwP7UZw2/dC9yPz8+rqXi8fDTGsFzlBgUGI0YqNx34pcPXGqybhuw2W8poQWL+yHGLL
        G43lRM1ag61A1Twih0ecDBEgEkhfYPR37ui6ddXKo1zkBgeY/KVDp29VbsTPQlGeGWUyD/3x11EEQ
        3Jqtofzpw/cRdnMno11DWBXJY7uQrrQW0GEf5ZZZ4Xvw5qSmXtud7y2VFEyHkdOTDRA6w8/jdHISu
        0XcQcRg0UgmqvBGN8Ev8mxAfFMSNl+ZmB1MatkvIO+HTgMae7xVZ9mIu0cNFqBcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUonY-00COei-Ni;
        Mon, 27 Sep 2021 13:27:52 +0200
Message-ID: <a4e56dbbe88771456bcf3051a0891d66d5e34fd4.camel@sipsolutions.net>
Subject: Re: [PATCH v4 4/6] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 27 Sep 2021 13:27:51 +0200
In-Reply-To: <20210924100052.32029-5-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
         <20210924100052.32029-5-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-09-24 at 06:00 -0400, Wen Gong wrote:
> The power spectral density(psd) of regulatory rule should be take
> effect to the channels. This patch is to save the values to the
> channel which has psd value.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  net/wireless/reg.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index df87c7f3a049..8f765befb9bc 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -1590,6 +1590,8 @@ static u32 map_regdom_flags(u32 rd_flags)
>  		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
>  	if (rd_flags & NL80211_RRF_NO_HE)
>  		channel_flags |= IEEE80211_CHAN_NO_HE;
> +	if (rd_flags & NL80211_RRF_PSD)
> +		channel_flags |= IEEE80211_CHAN_PSD;

I went to go squash this with patch 3 and took a closer look, and then I
realized you're doing this weird.

Please when you resend also squash this - it's a bit weird to read in
two patches.

However, I think this is missing a lot of things - we already talked
about the regulatory database, and while that'd be nice, I guess I
conceded that you don't really have to do it now.

However, for visibility reasons, I *really* think you need to add
nl80211 attributes for all of this data - when the regdomain is dumped
in nl80211_put_regdom() you would have the flag now (it dumps the value
of reg_rule->flags in NL80211_ATTR_REG_RULE_FLAGS), but you didn't add
the value of reg_rule->psd which you've added.

Similarly, you're not adding the PSD flag nor the PSD value for the
*channel* in nl80211_msg_put_channel(), both of which I think you should
have for visibility into what's going on in the kernel/driver.

I've applied all the other patches, so please just resend 3 and 4,
squashed into a single patch, with the fixes.

johannes

