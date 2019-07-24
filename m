Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB61723BB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfGXBc3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 21:32:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGXBc2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 21:32:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFCB5AEEA5EBA150532A;
        Wed, 24 Jul 2019 09:32:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 09:32:24 +0800
Subject: Re: [net-next] mwifiex: use eth_broadcast_addr() to assign broadcast
 address
To:     <amitkarwar@gmail.com>, <nishants@marvell.com>,
        <gbhat@marvell.com>, <huxinming820@gmail.com>,
        <kvalo@codeaurora.org>
References: <20190710072524.65953-1-maowenan@huawei.com>
CC:     <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <609fa4ae-7210-7758-c8ff-1b06492356e1@huawei.com>
Date:   Wed, 24 Jul 2019 09:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190710072524.65953-1-maowenan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gentle ping...

On 2019/7/10 15:25, Mao Wenan wrote:
> This patch is to use eth_broadcast_addr() to assign broadcast address
> insetad of memcpy().
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
> index 18e654d..0931304 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -731,7 +731,6 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
>  				    u16 status_code, struct sk_buff *skb)
>  {
>  	struct ieee80211_mgmt *mgmt;
> -	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  	int ret;
>  	u16 capab;
>  	struct ieee80211_ht_cap *ht_cap;
> @@ -765,7 +764,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
>  		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
>  			sizeof(mgmt->u.action.u.tdls_discover_resp));
>  		/* init address 4 */
> -		memcpy(pos, bc_addr, ETH_ALEN);
> +		eth_broadcast_addr(pos);
>  
>  		ret = mwifiex_tdls_append_rates_ie(priv, skb);
>  		if (ret) {
> 

