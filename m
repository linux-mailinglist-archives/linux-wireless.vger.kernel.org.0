Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E896FFF86
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 06:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjELEGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 00:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 00:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716DE2
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 21:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A40164EED
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 04:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38364C433D2;
        Fri, 12 May 2023 04:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683864381;
        bh=ZenAXuk85BLF9QfhqeAKss5Dc208nfw0dw945rZtVAI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oksvC1fE3y+hm3RTUqqYksjkqIP0DXFJBo1VxUa4AARnudKoo31ulg/zxJmvVAhoo
         lqdDZdkffi93VKGZgKlpG0OS1mVv7nZIIVGuXFYNiM6XqNVyEcNQ4IYoQ44cMSub51
         UcQyoeEQKBaUA2bzywRbjyJ3db+OKVSBbL02eVeVODo7zermhXdGtgKeBjxN5NfW2L
         99IwVUYKpUAyTmUmQbVwwevXTA+46G+Zk51bNBzK5Wp5CjIRcJtLXtlYwBj/spMl17
         Qp6JXT7uMYaKlPCVcW4ABtV4OwFaEtWig8lSbWR/7/JuhHNf1w9n/usIHol+RXbWRr
         keSuFjOErh2zA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: exclude wireless drivers from netdev
References: <20230511160310.979113-1-kuba@kernel.org>
        <d505bf5bbcd0f13a37f9c8465667e355ce20bc26.camel@sipsolutions.net>
Date:   Fri, 12 May 2023 07:06:15 +0300
In-Reply-To: <d505bf5bbcd0f13a37f9c8465667e355ce20bc26.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 11 May 2023 18:38:37 +0200")
Message-ID: <87y1lumbwo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2023-05-11 at 09:03 -0700, Jakub Kicinski wrote:
>> It seems that we mostly get netdev CCed on wireless patches
>> which are written by people who don't know any better and
>> CC everything that get_maintainers spits out. Rather than
>> patches which indeed could benefit from general networking
>> review.
>> 
>> Marking them down in patchwork as Awaiting Upstream is
>> a bit tedious.
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> CC: kvalo@kernel.org
>> CC: johannes@sipsolutions.net
>> CC: linux-wireless@vger.kernel.org
>> 
>> Is this okay with everyone?
>> 
>
> Yeah, makes sense.
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

I didn't even know about 'X', a very good idea:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
