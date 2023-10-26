Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426E97D862E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbjJZPtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJZPtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 11:49:22 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D8C196
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 08:49:20 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1CF7DA80063;
        Thu, 26 Oct 2023 15:49:18 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 922F113C2B0;
        Thu, 26 Oct 2023 08:49:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 922F113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698335357;
        bh=M2H0AFdd/kZ2Syc5TDFsxiHPTeBnwLDsAHa7dQc3N98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ar7ozGaSWdNzV8g/YqwaIxCcY1R1mS2avJNUkXz7NIthSDXI0aGTo5pIrPJiY2oEN
         fPvpUnsqGyu1bX01JZ8ZymbJIdzRPMEvFeO5Pt08NSpeFbPsmhFRAs5UzigXn57dJJ
         DtOiOoFy1TXtvE/XmlWnC+0IFGvDgDfGFBEGrdZk=
Message-ID: <2d3603c7-2377-4c0f-a46f-378214e41403@candelatech.com>
Date:   Thu, 26 Oct 2023 08:49:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression wireless-next: mt7921: update the channel usage when
 the regd domain changed
Content-Language: en-US
To:     =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= 
        <Mingyen.Hsieh@mediatek.com>
References: <2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com>
 <e0afaea7118b742d695fc0ef19e04ff0cb6a902f.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <e0afaea7118b742d695fc0ef19e04ff0cb6a902f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1698335358-TtHUBjz05NWG
X-MDID-O: us5;ut7;1698335358;TtHUBjz05NWG;<greearb@candelatech.com>;8f958617cfa0c472bf23b5b733da7b59
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/25/23 20:58, Deren Wu (武德仁) wrote:
> Hi Ben,
> 
> On Wed, 2023-10-25 at 09:05 -0700, Ben Greear wrote:
>> I noticed mt7922 radios would no longer enable 6e band in wireless-
>> next.
>> 
>> My test system has Intel radios and mt7922 radios in it.  I bisected
>> to the commit
>> below.  It looks like that patch can disable 6e based on regdom
>> change, but cannot
>> enable 6e again in case regdom changes back to something that
>> supports 6e.
>> 
>> Intel tri-band radios disable 6e by default, then enable it after
>> scanning
>> US regdom beacons.  Maybe that regdom changing by Intel helps break
>> the mt7922
>> with the below patch applied?
> 
> Thanks for the report. There is a capability check missed. Could you
> pleae help to check this patch? Let's make sure you run into the same
> problem.
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index 55baac70860b..a738ea95110e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -69,6 +69,9 @@ mt7921_regd_channel_update(struct wiphy *wiphy,
> struct mt792x_dev *dev)
>          struct ieee80211_channel *ch;
>          int i, cfreq;
> 
> +       if (!(dev->phy.chip_cap & MT792x_CHIP_CAP_CLC_EVT_EN))
> +               dev->phy.clc_chan_conf = 0xff;
> +
>          np = mt76_find_power_limits_node(mdev);
> 
>          sband = wiphy->bands[NL80211_BAND_5GHZ];

This fixed the problem in a quick test.

I'll add this to our tree and we'll do more testing on it...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


