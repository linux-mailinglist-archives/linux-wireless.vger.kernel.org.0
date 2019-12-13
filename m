Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809CF11E12C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMJwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:52:37 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45356 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJwh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:52:37 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifhch-009drg-7w; Fri, 13 Dec 2019 10:52:35 +0100
Message-ID: <a98188cd784e009c10b699a99ce61d9a9b4e17d2.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] mac80211_hwsim: set rx_status mactime/flag for
 wmediumd path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Dec 2019 10:52:33 +0100
In-Reply-To: <20191122171401.8788-2-prestwoj@gmail.com> (sfid-20191122_181703_706598_214135C2)
References: <20191122171401.8788-1-prestwoj@gmail.com>
         <20191122171401.8788-2-prestwoj@gmail.com>
         (sfid-20191122_181703_706598_214135C2)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 09:14 -0800, James Prestwood wrote:
> This patch sets the required rx_status mactime and flags in order for
> the parent TSF value to be calculated and sent to userspace. This is
> already done elsewhere, but this patch allows this to work for the
> wmediumd code path.
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> ---
>  drivers/net/wireless/mac80211_hwsim.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
> index e9bc599481d4..01b2ac9707cc 100644
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -3238,6 +3238,8 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
>  	int frame_data_len;
>  	void *frame_data;
>  	struct sk_buff *skb = NULL;
> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb_2->data;
> +	u64 now;
>  
>  	if (!info->attrs[HWSIM_ATTR_ADDR_RECEIVER] ||
>  	    !info->attrs[HWSIM_ATTR_FRAME] ||
> @@ -3300,6 +3302,18 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
>  	rx_status.rate_idx = nla_get_u32(info->attrs[HWSIM_ATTR_RX_RATE]);
>  	rx_status.signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
>  
> +	if (ieee80211_is_beacon(hdr->frame_control) ||
> +	    ieee80211_is_probe_resp(hdr->frame_control)) {
> +		rx_status.boottime_ns = ktime_get_boottime_ns();
> +		now = data2->abs_bcn_ts;

I'm pretty sure this should be data, not data2, like in the other code
paths?

Also, please rebase - I already did the boottime_ns before overlapping
your change, so you can also get rid of the 'hdr' variable.

johannes


