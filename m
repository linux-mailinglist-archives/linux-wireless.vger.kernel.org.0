Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAF394151
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhE1KsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 06:48:18 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:38570 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236170AbhE1KsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 06:48:17 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D67D889C8;
        Fri, 28 May 2021 03:46:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D67D889C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1622198802;
        bh=Zw0jEQhCQ7WPd1T8DnlcrjRRkKDIDNlohFb+UWsqnn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lVi7YGb6rX6KEWlOB8oNJi7N0+56AgflHACPxOwN5P2KQPCIPIJufb2zMn/5BpUEg
         WeBaQ1VK+Hx9cuQzR7WrL7F4BDae9KcTyssY0IiDFU2b6zaNZXLDrKPkeh1YAKCprV
         CsGsfM+vhNO0+dUVsJNxvgq3LOnosgc02V7rP05k=
Received: from [10.230.41.88] (unknown [10.230.41.88])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id E27451874BE;
        Fri, 28 May 2021 03:46:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] mac80211: add rate control support for encap
 offload
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <2176023d8f13d82d093452e1c105609396c30622.1622164961.git.ryder.lee@mediatek.com>
 <d447c18f07fe3dc7092f5502de3e35e6b7ae69e1.1622164961.git.ryder.lee@mediatek.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <489e6d51-c3f0-452d-ab63-ba83bba7ec02@broadcom.com>
Date:   Fri, 28 May 2021 12:46:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d447c18f07fe3dc7092f5502de3e35e6b7ae69e1.1622164961.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/28/2021 8:05 AM, Ryder Lee wrote:
> The software rate control cannot deal with encap offload, so fix it.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> change since v2 - none
> ---
>   net/mac80211/ieee80211_i.h |  9 +++++++++
>   net/mac80211/rate.c        |  9 ++-------
>   net/mac80211/tx.c          | 18 ++++++++++++++----
>   3 files changed, 25 insertions(+), 11 deletions(-)

[...]

> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index d3016c3a3069..0a4bc9e08637 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c

[...]

> @@ -729,7 +730,8 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
>   		 "%s: Dropped data frame as no usable bitrate found while "
>   		 "scanning and associated. Target station: "
>   		 "%pM on %d GHz band\n",
> -		 tx->sdata->name, hdr->addr1,
> +		 tx->sdata->name,
> +		 encap ? ((struct ethhdr *)hdr)->h_dest : hdr->addr1,
>   		 info->band ? 5 : 2))

Not related to this change, but I guess the band can also be 6 these days.

Regards,
Arend
