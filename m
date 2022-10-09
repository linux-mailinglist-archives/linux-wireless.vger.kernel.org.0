Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF665F8D2E
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJISem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJISek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 14:34:40 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77F931090
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 11:34:38 -0700 (PDT)
Message-ID: <e9f0e3fb-3259-3d5b-de80-2a7a579a4440@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665340475;
        bh=fI6wQ+FA1E4E3KhPfyZQv2kPo/es3UI+ZVkVvM0iBWA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UoUOTNIYeQYeuJMFPn6QvIlE7mVo5+mbjTHY1HaNCIWslOKO8wZ7unAGTy2ztBiLI
         IaBUildcm5409H1c1Q8+0qpEgwjdUhwSFNoXRNbha+tf1NGM5rceLJSofTK7XsOSuD
         D60+ptnuaoFhuk967cptuATM9BzcdFRbb1wLYbRk=
Date:   Sun, 9 Oct 2022 20:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/3] wifi: mac80211: add internal handler for
 wake_tx_queue
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@kernel.org
References: <20221009163040.25637-1-alexander@wetzel-home.de>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <20221009163040.25637-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Changes compared to V1:
>   - broken out the new wake_tx_queue handler as exported function
>   - update drivers to provide wake_tx_queue instead handling it internally
>   - Minor docu updates
>   - Some sentences of the edited docu were referring to wrong netif
>     functions. Fixed that with the edit, too.
>   - added a comment explaining why we call ieee80211_next_txq()
>   - removed now pointless checks for sta.txq
> 

Forgot to mention one change:
skb_get_hash() is now always called. I moved it into 
ieee80211_select_queue() to address the issue Toke had with outright 
dropping it in v1.

Alexander

