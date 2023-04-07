Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33E76DB5FC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 23:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDGV7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDGV7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 17:59:20 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 14:59:19 PDT
Received: from stone.woods.net (stone.woods.net [74.50.54.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777675FF0
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 14:59:19 -0700 (PDT)
Received: from sneaky (66.29.179.130.static.utbb.net [66.29.179.130])
        by stone.woods.net (Postfix) with ESMTPSA id 6E350841D;
        Fri,  7 Apr 2023 21:52:31 +0000 (UTC)
Date:   Fri, 7 Apr 2023 15:52:29 -0600
From:   Aaron Dewell <aaron.dewell@woods.net>
To:     James <bjlockie@lockie.ca>
Cc:     "=?utf-8?Q?linux-wireless=40vger.kernel.org?=" 
        <linux-wireless@vger.kernel.org>
Message-ID: <E582DF8E-7FC2-4E6D-B076-A0A5F75308E0@getmailspring.com>
In-Reply-To: <13DCAA8A-77E2-4BB1-94C8-9E57B382D60A@getmailspring.com>
References: <13DCAA8A-77E2-4BB1-94C8-9E57B382D60A@getmailspring.com>
Subject: Re: ax204/Intel NUC13 i9
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Apr 7 2023, at 3:41 pm, Aaron Dewell <acd@woods.net> wrote:

>  
> On Apr 7 2023, at 3:08 pm, James <bjlockie@lockie.ca> wrote:
>  
>>   
>> On 2023-04-07 15:28, Aaron Dewell wrote:
>>> Hi all,
>>>   
>>> I've just received the new NUC13 and it's quite nice. However, the
>>> wireless chip appears to be too new to have mainline support.  To that
>>> end, I've been ... messing with it.  :)
>>>   
>>> I believe the marketing term is an AX204.  I know for certain it's
>>> 0x7AF0 0x1692.  I am using kernel source 6.3-rc4 and attempting to
>>> add a
>>> line to iwlwifi/pcie/drv.c that looks like this:
>>>   
>>> IWL_DEV_INFO(0x7AF0, 0x1692, something?, iwl_ax204_name),
>>>   
>>> I have looked at:
>>> https://www.intel.com/content/www/us/en/support/articles/000005511/wireless.html￼
>>> However, this product isn't listed.
>>>   
>>> I know I'm missing the "something?" above and possibly on the wrong path
>>> on other things.  I've had a couple of guesses that didn't work out
>>> (stabbing in the dark), so asking here.  Any assistance appreciated!
>>>   
>>> Thanks!
>>>   
>>> 00:14.3 Network controller [0280]: Intel Corporation Alder Lake-S PCH
>>> CNVi WiFi [8086:7af0] (rev 11)
>>>          Subsystem: Rivet Networks Alder Lake-S PCH CNVi WiFi [1a56:1692]
>>   
>>   
>> Intel bought Rivet Networks in 2020.
>>   
>> The card should be supported:
>>   
>> https://www.intel.ca/content/www/ca/en/support/articles/000088040/wireless.html
>>   
>> Have you installed the Intel wireless drivers?
>>   
>> I think Intel drivers are in kernel but they should be installed by
>> most   
>> distros.
>  
> It's Debian Bookworm (testing) which comes with 6.1.20, however, the
> card is not recognized, thus why I started messing with it.  I tried the
> latest Xanmod kernel as well before I started diving into source in
> 6.3-rc4 (which also didn't recognize the card as shipped). I couldn't
> find any reference to the PCI ID in the source either, which made sense
> as to why it wouldn't be recognized.

Here are the errors from the shipping Debian kernel (unmodified):

[    2.664162] Intel(R) Wireless WiFi driver for Linux
[    2.664207] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    2.667274] AVX2 version of gcm_enc/dec engaged.
[    2.667327] AES CTR mode by8 optimization enabled
[    2.668601] iwlwifi: No config found for PCI dev 7af0/1692,
rev=0x430, rfid=0x3010d000
[    2.668628] iwlwifi: probe of 0000:00:14.3 failed with error -22

