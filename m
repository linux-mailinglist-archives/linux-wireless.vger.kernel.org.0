Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1495BA1B6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIOUGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIOUGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 16:06:32 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C2C11445
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 13:06:31 -0700 (PDT)
Message-ID: <0b342479-d04a-a45e-d63b-73eec5a1fb40@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1663272390;
        bh=o7pMeYcMjjffyMsphdFRR/kql+yXELOaqNXTPk8EYKY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=P8LF1CVad9w/hqnj7qZC38PJpX/i5q0WWsM88UcqbWSvOpG8xMkl9As926CboTRXr
         x6Uaz/l/7DA5tqPiOm9vacsO9wCdUT9rzlMVgnYGI9X6yz5ZPX697GtaZmyHgWKTnG
         RLWSmjQxGB1hB+jjJprgpBOzjVYf5fnugG+v+p9c=
Date:   Thu, 15 Sep 2022 22:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
 <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
 <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
In-Reply-To: <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> I've got some doubts that my fix is correct...
> While it fixes the problem in my tests it looks like we'll need another 
> queue restart to get the queues working again.
> 
> After all IEEE80211_TXQ_STOP_NETIF_TX will not be cleared when it has 
> been set by __ieee80211_stop_queue().
> 
> I'll update the patch and skip setting vif.txqs_stopped when 
> SDATA_STATE_RUNNING is not set. Not having IEEE80211_TXQ_STOP_NETIF_TX 
> set looks harmless, having it set when it should less problematic...

Scratch that: The patch should be ok as it is: 
IEEE80211_TXQ_STOP_NETIF_TX is not set on stop, the patch should be ok 
as it is.

Sorry for the noise.

Alexander

