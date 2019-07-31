Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E77BE01
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfGaKIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:08:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaKIg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:08:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72B9860734; Wed, 31 Jul 2019 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564567716;
        bh=tyXhWVWCnnQ7q59ZKItSqdjCqoU7pywvbQ/iseFdC7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nWuP/cVaKx55K0647kmr1nlZS1PHVcStTYgBxRNgYJ87MahvxHHoFDpCtw0/O2hMB
         jNNqQKVN2kazN+3UgI50FWhgJaFqRK8WjZguI3Vi8NY3WVZMdBI9BWb5kVk/+MkYr9
         APWkLsx2bj6fnmMzNrVhphgmC0uRmEQVAJveXwbg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D9CF9602F1;
        Wed, 31 Jul 2019 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564567715;
        bh=tyXhWVWCnnQ7q59ZKItSqdjCqoU7pywvbQ/iseFdC7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sy1kiXQFoAytiu0JkGcHZe6YhaRphnPqDok+ty6Pdhmpa331DRqEewa5GwKsxqso3
         UmsvkUxXc12L2hLLOAH8O3KE/igcvP/lSeBJqiDsoTY7Lrjf+lmrC1Nx6zqa05IG3Y
         wFuD/V4Ogee90blptPKv9Mn5JLlUf0aFrIsd03dk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Jul 2019 15:38:35 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCHv6 5/9] nl80211: Add netlink attribute to configure TID
 specific tx rate
In-Reply-To: <20190711125442.unlaqjl5nnqgsbod@bars>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-6-git-send-email-tamizhr@codeaurora.org>
 <20190711125442.unlaqjl5nnqgsbod@bars>
Message-ID: <e306b921ab10228a40eb1958de8e6173@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-11 18:24, Sergey Matyukevich wrote:
>> Introduce NL80211_TID_ATTR_CONFIG_TX_RATES in nl80211_tid_attr_config
>> to accept data TID specific TX bitrate configuration
>> through NL80211_CMD_SET_TID_CONFIG command. TID for which the
>> this configuration is to be applied is passed in
>> NL80211_TID_ATTR_CONFIG_TID attribute. TX bitrate mask values passed
>> in NL80211_ATTR_TX_RATES attribute and 
>> NL80211_TID_ATTR_CONFIG_TX_RATES
>> attribute will have types of the TX rate should be applied.
>> When the user-space wants this configuration peer specific
>> rather than being applied for all the connected stations,
>> MAC address of the peer can be passed in NL80211_ATTR_MAC attribute.
>> 
>> Driver supporting this feature should advertise
>> NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK and supporting per-STA 
>> data TID
>> TX bitrate configuration should advertise
>> NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK.
>> 
>> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
> 
> ...
> 
>>         if (info->attrs[NL80211_ATTR_TX_RATES]) {
>> -               err = nl80211_parse_tx_bitrate_mask(info, 
>> &params.beacon_rate);
>> +               err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
>> +                                                   
>> NL80211_ATTR_TX_RATES,
>> +                                                   
>> &params.beacon_rate);
>>                 if (err)
>>                         return err;
>> 
> 
> Could you please clarify this change of nl80211_parse_tx_bitrate_mask 
> arguments.
> Unless I missing something, the appropriate change for
> nl80211_parse_tx_bitrate_mask
> is not included into this patch set.

Yeah. These arguments are missed in the function definition place:( I 
will fix this rebase issue in next version.

Thanks,
Tamizh.
