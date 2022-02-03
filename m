Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5814A808D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiBCInG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:43:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51398 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBCInF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72F55B832B7
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 08:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7ABC340E4;
        Thu,  3 Feb 2022 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643877783;
        bh=raJ5v7BVcPmMDwmIa7nhFcmWNNb+U3YYIVTVBEqfUvU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ml2GzfT6d9KcwwptFpEy5SoKAt6gv+NaQ8nFKrHTCWSMmyL2LNOTHRUCCjpmSzfXx
         /I9MTuRL+UcWZiOm/ByRmBekotNC36jbX5x9IktrOqPwJz2jCGJzmWhNZMC1Nqkw7f
         FgFDVPvn3gVElWLUN/npg1l+2ljHw05ROG106aw+Cw3PX0FNYa7Uo79WuFHvgxlH6Z
         Jxd2lGO0KJW3me0A+/Jj1LRh17h+DsB9csuXebvH3dGGJXN3ByEVGIuGUPBriybSF1
         C3JwKYWeemgPgf4PwQxeQq1xSjgRz3xenyGcXBAUXY2wU4aUmUxPcRJMJ4vjiNLwhc
         XiAq1jPq2jAOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
References: <20220107034239.22002-1-pkshih@realtek.com>
        <20220107034239.22002-14-pkshih@realtek.com>
        <874k5ng8oq.fsf@kernel.org>
        <97e80d86f5b925a0b2337d15c56e88d3808b6efe.camel@realtek.com>
Date:   Thu, 03 Feb 2022 10:42:59 +0200
In-Reply-To: <97e80d86f5b925a0b2337d15c56e88d3808b6efe.camel@realtek.com>
        (Pkshih's message of "Sat, 29 Jan 2022 03:36:14 +0000")
Message-ID: <877daccpd8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Fri, 2022-01-28 at 17:51 +0200, Kalle Valo wrote:
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > Fill mac_id and self_role depends on the operation mode.
>> > 
>> > In AP mode, echo connected station has an unique mac_id, and each vif also
>> > has one mac_id to represent itself.
>> > 
>> > The self_role is assigned to vif if the operation mode is decided, and
>> > RTW89_SELF_ROLE_AP_CLIENT is assigned to the connected STA in AP mode,
>> > 
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> > ---
>> >  drivers/net/wireless/realtek/rtw89/fw.c  | 8 ++++++--
>> >  drivers/net/wireless/realtek/rtw89/fw.h  | 1 +
>> >  drivers/net/wireless/realtek/rtw89/mac.c | 4 ++--
>> >  3 files changed, 9 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
>> > index 5209813275676..4641aadea0386 100644
>> > --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> > +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> > @@ -993,9 +993,13 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
>> >  #define H2C_ROLE_MAINTAIN_LEN 4
>> >  int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
>> >  			       struct rtw89_vif *rtwvif,
>> > +			       struct rtw89_sta *rtwsta,
>> >  			       enum rtw89_upd_mode upd_mode)
>> >  {
>> >  	struct sk_buff *skb;
>> > +	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
>> > +	u8 self_role = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta ?
>> > +		       RTW89_SELF_ROLE_AP_CLIENT : rtwvif->self_role;
>> 
>> It seems you like '?' operator more than I do, and it's ok to use in
>> simple cases. But the latter statement is not really readable, something
>> like this is so much easier to read:
>> 
>> if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta)
>>     self_role = RTW89_SELF_ROLE_AP_CLIENT
>> else
>>     self_role = rtwvif->self_role;
>> 
>
> I use '?' to make code shorter, but your sugeestion would be eaiser to reviewer.
> I will send v2 after the Lunar New Year.

Happy New Year :)

>> But should there a parenthesis around the == operator? I cannot now
>> recall what's the preference in the kernel, can someone help on that?
>
> The checkpatch will warn this if we add parenthesis, so preence is not to
> use parenthesis.
>
> CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'rtwvif->net_type ==
> RTW89_NET_TYPE_AP_MODE'
> #9: FILE: fw.c:1004:
> +	if ((rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) && rtwsta)

Ok, I need to remember that :)

>> Maybe I also move check for rtwsta first?
>> 
>
> The full logic is 
>
> if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
>     if (rtwsta)
>         self_role = RTW89_SELF_ROLE_AP_CLIENT
>     else
>         self_role = rtwvif->self_role;
> } else {
>     self_role = rtwvif->self_role;
> }
>
> And, the meaning of 'rtwsta' here is to indicate we are going to setup 
> a connected station that connects to this AP, but not check if the
> pointer is NULL. To emphasis the case is only existing in AP_MODE,
> I prefer to check net_type ahead. Or, this full logic is preferred?

I don't know what others think, but I find this full logic style most
readable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
