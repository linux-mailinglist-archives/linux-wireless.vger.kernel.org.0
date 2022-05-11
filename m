Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7A522B5B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 06:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiEKElp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 00:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiEKElg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 00:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0F6B03E
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 21:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E401B82013
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 04:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03009C385DB;
        Wed, 11 May 2022 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652244092;
        bh=wPetpvpmXglh7SVFtEWh8pbnlApf9kJM1ighISf3zHY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rJI7fV0HXYMMA38PtDVT0cFF7kHaY5XJCma0j4vMUCctC27dWMZFzohRI9bVWsy46
         VjPPKAC33F6AwqeYQGMQZohKg0LaBOftb9i4YUAOWmWwGm4W0kytfQg9FvQWmcwOYs
         843dxqnLHbj1nrGzjo6FfPpeaghpU1O/9T9f3c0FFtjhCPiJczhsb1eiWqbvV8YLuC
         L5aE77UjEk2sDxhZ9NAxhANG+IN2GgJyjuisMELssxBId2SURpJTv+1P5JkWDHZfJQ
         tfGTqN3p1rC1kDREuPSIoiariWHAMvvR9K983Bw7FBiMIj1JxHsaVJhSP70x/dkdPV
         +wB0MhI2S/UFQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH 3/5] wilc1000: fix crash observed in AP mode with cfg80211_register_netdevice()
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
        <20220504161924.2146601-3-ajay.kathat@microchip.com>
        <87pmkmylex.fsf@kernel.org>
        <aeafb6e2-d294-475b-1c43-1f90bf8d5114@microchip.com>
        <57cb3e2f1ba75aec472ca5cfdcd8fc3c7ffffeb0.camel@sipsolutions.net>
        <112580fc-4394-f6f2-2b85-b385ba4714b2@microchip.com>
Date:   Wed, 11 May 2022 07:41:28 +0300
In-Reply-To: <112580fc-4394-f6f2-2b85-b385ba4714b2@microchip.com> (Ajay
        Kathat's message of "Tue, 10 May 2022 09:55:16 +0000")
Message-ID: <87h75wy93b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> On 10/05/22 01:14, Johannes Berg wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Mon, 2022-05-09 at 13:49 +0000, Ajay.Kathat@microchip.com wrote:
>>> As I understand, in WILC "ieee80211_ptr" is used for the station/AP
>>> interface but not to configure the monitor interface which gets
>>> additionally added in AP mode. In AP mode, for an interface( wlan0 ), an
>>> additional monitor interface( mon.wlan0 ) gets created. A netdevice is
>>> register for monitor interface(mon.wlan0) to transmit/receive frames
>>> from/to hostapd. That interface doesn't explicitly set up
>>> 'ieee80211_ptr' because the original interface(wlan0) uses it, so using
>>> "cfg80211_register/unregister" API's for mon.wlan0 interfaces fails.
>> Btw, this probably should just be removed in favour of using the nl80211
>> based APIs for hostapd ...
>>
>> But I think as a quick bugfix goes this is fine, but it'd be better to
>> remove this and either allow hostapd to create the interface with the
>> proper ieee80211_ptr, or to just use the nl80211-based TX/RX.
>
>
> Thanks Johannes. Yes, this patch would help to make the AP mode work.
> I will check on using nl80211 based APIs for hostapd but might take some 
> time to change.

Ok, I'll take this as a quick fix but please switch to using proper
interfaces.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
