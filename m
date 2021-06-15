Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283033A8319
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFOOoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 10:44:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhFOOod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 10:44:33 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCKO4-1m2TwT2tHu-009Qet; Tue, 15 Jun 2021 16:42:23 +0200
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20201129153055.1971298-1-luca@coelho.fi>
 <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
Message-ID: <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
Date:   Tue, 15 Jun 2021 16:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oqaWP9lyG64KMV174V5ceL48pUbF5DHVhBUG+6JzwQ0mMfR76kB
 pJCvCg+oXD1eVVk1A/UPp3/G1uj+P6AgIxk7Le8n7uzao0XJte2tHhERIbTA0sdxcmFDvJ7
 537TyANe+JcYROdjOoBBcSgpGSuFzcdjJWJQDHLD53ezTrmnx3h4tpfgPmoO91gAPzoZHJb
 xgE4y8v5B6qErBlkhy9ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9GPsCaF3kAM=:NJgKcbj0b3PvNSsNKhpgbL
 Qc0V9TjSmxKqHbQER8SuG1wMl9DHx2xwLIBJhC+AEifeagQqxkKXawbkYiLgotoBvFhZ7fnOf
 9uyZKXmWgDwK0kU1hGV/hogVmfAm89ibaXM80Qp4dvq1344F+N6r2O0nOpdYuls54Am0ZPpVE
 EQHMHj44VMxpLilfSrOh/hvoK3EUcNsPjafTfanuGqkN6qpJG+5+tnz4EuTUVAX8QbMNa/Y9e
 ZCg2cL9Gsh8O9RWBERziNI3S7tXcJ0ttH5uy1wqxxvGv1B8xFG0Z8VcrM/museSS/9Fcx9ot5
 5Y3FZAI5I+wVmkMCdYFA8Ma+9xZoDpgWO90i8+uKMBrvXq58rjBBAuBNVMcCtTvWiGgPldesM
 2lJNkI44SV0Q4qm1RCX9jtwBUog6fgT9cePwpm9KwPGZre9A+s4OMJGltGfZi5WqX7cetlabB
 +JK6CWJgt5kkCR37+WRhNEEKBt2vAoP0KQy3TPvAnaLdLa47ZrM1CyAjejDQIYva2pHze2yW9
 x+TFjpPaV4sLAIOIjxQ901GBq2ASTzz7J2dNWE6JefL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29/11/2020 16:30, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> When custom regulatory was set, only the channels setting was updated, but
> the regulatory domain was not saved. Fix it by saving it.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>   net/wireless/reg.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index a04fdfb35f07..094492b62f8a 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -2547,6 +2547,7 @@ static void handle_band_custom(struct wiphy *wiphy,
>   void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>   				   const struct ieee80211_regdomain *regd)
>   {
> +	const struct ieee80211_regdomain *new_regd, *tmp;
>   	enum nl80211_band band;
>   	unsigned int bands_set = 0;
>   
> @@ -2566,6 +2567,13 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>   	 * on your device's supported bands.
>   	 */
>   	WARN_ON(!bands_set);
> +	new_regd = reg_copy_regd(regd);
> +	if (IS_ERR(new_regd))
> +		return;
> +
> +	tmp = get_wiphy_regdom(wiphy);
> +	rcu_assign_pointer(wiphy->regd, new_regd);
> +	rcu_free_regdom(tmp);
>   }
>   EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
>   
> 

Hello,

This patch somehow appears to break ath9k's eeprom hints and restrict it to the 
world regulatory domain on v5.12.10.

ath9k calls wiphy_apply_custom_regulatory() with its own kind of world 
regulatory domain, before it decodes hints from the eeprom and uses 
regulatory_hint() to request a specific alpha2.

With this patch, applying the hint fails because wiphy->regd is already set.
If i revert this patch, ath9k works again.
