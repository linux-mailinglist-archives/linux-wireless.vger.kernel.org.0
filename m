Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68649FD23
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiA1Pvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:51:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50978 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbiA1Pvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:51:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83A83B80D61
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CB6C340E0;
        Fri, 28 Jan 2022 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385099;
        bh=/+ThMN1cPXjGMO8KDGah4scTyLbIbR/sO1EpN6eyiNw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XlVpdNF5guO5RJFQJrWnB8aIJFyfpm8qXq5Q7w8ebpCJqwKIdnC5YwkbucPVmNHsH
         3WRNcW4vzwnrXfaQxJBsw99XIleW5JM81Tlvs7e0M+Ev5h1EX+W3nD0S5EdZ2SkiPr
         gWWmbPTUzl7RDQRpdzF7buXND4lmHifG0EtiXIgfh6gUmEzAgms/43gt6psdiAYYJO
         7CjLvVb6rut6+Bt31JFjJcF9E+NdoMJim3imzIKqQurvXijGlU5N/i84P8LCCpIc2k
         CfuwQNA1YufIYqUGx0+9Sbi3pFFxxlrQOnpaHsXATh5qqTjvjMha7RPYSZA0mOrRsU
         vLvPzm6jZiE9Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
References: <20220107034239.22002-1-pkshih@realtek.com>
        <20220107034239.22002-14-pkshih@realtek.com>
Date:   Fri, 28 Jan 2022 17:51:33 +0200
In-Reply-To: <20220107034239.22002-14-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 7 Jan 2022 11:42:33 +0800")
Message-ID: <874k5ng8oq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Fill mac_id and self_role depends on the operation mode.
>
> In AP mode, echo connected station has an unique mac_id, and each vif also
> has one mac_id to represent itself.
>
> The self_role is assigned to vif if the operation mode is decided, and
> RTW89_SELF_ROLE_AP_CLIENT is assigned to the connected STA in AP mode,
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c  | 8 ++++++--
>  drivers/net/wireless/realtek/rtw89/fw.h  | 1 +
>  drivers/net/wireless/realtek/rtw89/mac.c | 4 ++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> index 5209813275676..4641aadea0386 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -993,9 +993,13 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
>  #define H2C_ROLE_MAINTAIN_LEN 4
>  int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
>  			       struct rtw89_vif *rtwvif,
> +			       struct rtw89_sta *rtwsta,
>  			       enum rtw89_upd_mode upd_mode)
>  {
>  	struct sk_buff *skb;
> +	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
> +	u8 self_role = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta ?
> +		       RTW89_SELF_ROLE_AP_CLIENT : rtwvif->self_role;

It seems you like '?' operator more than I do, and it's ok to use in
simple cases. But the latter statement is not really readable, something
like this is so much easier to read:

if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta)
    self_role = RTW89_SELF_ROLE_AP_CLIENT
else
    self_role = rtwvif->self_role;

But should there a parenthesis around the == operator? I cannot now
recall what's the preference in the kernel, can someone help on that?

Maybe I also move check for rtwsta first?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
