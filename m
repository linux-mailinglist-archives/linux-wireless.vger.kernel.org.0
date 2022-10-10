Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C750F5F9DB4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiJJLhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiJJLhs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 07:37:48 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70C726EF28
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 04:37:46 -0700 (PDT)
Message-ID: <3d908846-4795-7020-d573-6450138544f1@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665401864;
        bh=450CBCN1kbhVXZLzde71GWFDVe3CGs1mtD9Kj4U4yYA=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=oZ4TL0J9dUeF1XzJ8f7VLKjNtb75O+0obqZmf5lQ4HNxEKhlGxP4F0X9R5Rvvekud
         MZoabSc1PtF07idpKdIbz9ahZGspGK0F/GR8pws0xD6Hu5rZKmyEgzA5XFFTTdUSmX
         sSZVyc+ow22eQ/sEKDROkGFKSVPQhTzNSitCDNiQ=
Date:   Mon, 10 Oct 2022 13:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/3] wifi: mac80211: add internal handler for
 wake_tx_queue
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20221009163040.25637-1-alexander@wetzel-home.de>
 <a510188243f0080e470245ab95bd4976a5b0e923.camel@sipsolutions.net>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <a510188243f0080e470245ab95bd4976a5b0e923.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.10.22 10:49, Johannes Berg wrote:
> On Sun, 2022-10-09 at 18:30 +0200, Alexander Wetzel wrote:
>>
>> While there is obvious something wrong with ieee80211_build_preq_ies() for
>> hwsim, that's unrelated to what we are doing here. (Multiple tests
>> trigger the WARN_ON() in ieee80211_get_he_6ghz_capa().)
>>
> 
> Yeah, something is strange there, I never saw that but I feel like I
> should have?
> 
> I _think_ it might be fixed by
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=b650009fcb701ea99aa133bbe18dbfc5305ddf1a

Yes, that was it. I don't get any warnings with that patch applied.

Alexander

