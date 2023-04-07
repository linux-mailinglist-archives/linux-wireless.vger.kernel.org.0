Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53096DB5BD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 23:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDGVOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGVOy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 17:14:54 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 14:14:53 PDT
Received: from titan.fastwww.net (titan10.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D327AD32
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 14:14:52 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=wCz90RMmb3zCO7HGEux+dQ+S6FkaUSF0kh7ikKNezUsuyolAN9/d2PdqfkfFvexB3zhrwd/kC2Q4Hlu3rR1KkeM/ExYKWy99wHU3gSBYY2pTt5NF0kPIirO69tq7N8jZDJfMgFtyHGelL9FmqIktryK67FlMtgBaPMs/RY54HXEd5pB+UbSmen4zG26JVe0CTZGj2VcWfjlD1woq1+dJqtpGQA6w1bH9toRhfWHyPtAoOC1J9N53hItepe2nNn6sexSvAzO6p3gYLhIbJikS5x34QIS++5r5WIwvq/HEUyFlYDFbrK+LfCCXF2FYEmzlBUGuEJT+mua5EknXc3mPHw==;
  h=Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=message-id
        :date:mime-version:subject:to:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=H+TRVg7Bn
        AZxtEb01jRUejLQerM=; b=VRXIhCXBT8a1y2YXTDUy0BJBaTEhHwACmjD082yxd
        ORAtYOxb/lMB8P25SB2UnMmQjwBwa8/xDdUl7naL+MbZ9h+v4R7H4rhHo3z6G8o6
        5kMeauwPCFi6YQcrk05EDDiIep2rc9HpVXuvB08anGR/l8sw6eY+CEuo57CUsexw
        5mqBeN8wx1IdbdcFcjsi+/63Ec24NpvwUJ0ZskzocaXpuGaZTuupkP4EM+iapSXF
        AQWROHHQ3oqRt6WwdYHRlEqLppuR0XGhPwWbzeaeLphVJ2bbZo+5i24+YQwdvqzY
        cjrhwhVzTnj+Q+Lh7F5Q7jsdBpBKoXASd7SVypo+E1xjw==
Received: (qmail 13127 invoked by uid 108); 7 Apr 2023 21:08:12 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 7 Apr 2023 21:08:12 +0000
Received: from [192.168.68.73] ([98.124.53.137])
        by titan.fastwww.net with ESMTPSA
        id NV3qHDyGMGQiMwAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Fri, 07 Apr 2023 21:08:12 +0000
Message-ID: <b0af692c-6e0e-a91e-f13b-56cf947bd773@lockie.ca>
Date:   Fri, 7 Apr 2023 17:08:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: ax204/Intel NUC13 i9
To:     Aaron Dewell <acd@woods.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <EB711DC9-627E-4119-897E-2ABA23880F9F@getmailspring.com>
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
In-Reply-To: <EB711DC9-627E-4119-897E-2ABA23880F9F@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2023-04-07 15:28, Aaron Dewell wrote:
> Hi all,
>
> I've just received the new NUC13 and it's quite nice. However, the
> wireless chip appears to be too new to have mainline support.  To that
> end, I've been ... messing with it.  :)
>
> I believe the marketing term is an AX204.  I know for certain it's
> 0x7AF0 0x1692.  I am using kernel source 6.3-rc4 and attempting to add a
> line to iwlwifi/pcie/drv.c that looks like this:
>
> IWL_DEV_INFO(0x7AF0, 0x1692, something?, iwl_ax204_name),
>
> I have looked at:
> https://www.intel.com/content/www/us/en/support/articles/000005511/wireless.html￼
> However, this product isn't listed.
>
> I know I'm missing the "something?" above and possibly on the wrong path
> on other things.  I've had a couple of guesses that didn't work out
> (stabbing in the dark), so asking here.  Any assistance appreciated!
>
> Thanks!
>
> 00:14.3 Network controller [0280]: Intel Corporation Alder Lake-S PCH
> CNVi WiFi [8086:7af0] (rev 11)
>          Subsystem: Rivet Networks Alder Lake-S PCH CNVi WiFi [1a56:1692]


Intel bought Rivet Networks in 2020.

The card should be supported:

https://www.intel.ca/content/www/ca/en/support/articles/000088040/wireless.html

Have you installed the Intel wireless drivers?

I think Intel drivers are in kernel but they should be installed by most 
distros.


