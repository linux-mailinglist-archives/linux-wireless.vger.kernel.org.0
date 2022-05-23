Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E784D531771
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiEWQ1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiEWQ1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 12:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC661606;
        Mon, 23 May 2022 09:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C01366141C;
        Mon, 23 May 2022 16:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0FC385A9;
        Mon, 23 May 2022 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653323227;
        bh=AceUDYcGZJujlBPQTsaPOLIBVpDb2ttCqdo8Gc2wbpg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OczRcIlhRq9MmST6+7Ld/zRiClrljK/6d7LVqUyi7elESniY7wnINSDQxxJDUqv+8
         0GEXPQrLif397SY1Q7O4DqeHpb5WNxF7iZrDDVUch6WJplTp68xAUqFcMVnFRCaaRg
         MgiX4ilOq7Zgl0+eveavVHwD7hcpPgO0U1tmv3o/SvcvDFFGsW3cGR/VIZAK77CFlb
         msy9drIlWm9gBmIdxOqnk2HOJHQnv9xY9yhLotFStB7wxUUrcW87TOtFxf+CxKq3mJ
         xfc99CQPy3PsUA1RPxAs2IZK+5XB9FOGBd3nSDQ8AZGm6rn9JKtK7i2H/4XvKwDdyF
         xTH7+Bi8Hg2+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     duoming@zju.edu.cn, linux-wireless@vger.kernel.org,
        amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
References: <20220523052810.24767-1-duoming@zju.edu.cn>
        <YosqUjCYioGh3kBW@kroah.com>
        <41a266af.2abb6.180efa8594d.Coremail.duoming@zju.edu.cn>
        <87r14kzdqz.fsf@kernel.org> <YouPEdlNbU2ea1Cx@kroah.com>
Date:   Mon, 23 May 2022 19:27:00 +0300
In-Reply-To: <YouPEdlNbU2ea1Cx@kroah.com> (Greg KH's message of "Mon, 23 May
        2022 15:41:37 +0200")
Message-ID: <87ilpwz02z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, May 23, 2022 at 02:31:48PM +0300, Kalle Valo wrote:
>> (adding Johannes)
>> 
>> duoming@zju.edu.cn writes:
>> 
>> >> > --- a/lib/kobject.c
>> >> > +++ b/lib/kobject.c
>> >> > @@ -254,7 +254,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
>> >> >  	if (kobj->name && !fmt)
>> >> >  		return 0;
>> >> >  
>> >> > -	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
>> >> > +	s = kvasprintf_const(GFP_ATOMIC, fmt, vargs);
>> >> >  	if (!s)
>> >> >  		return -ENOMEM;
>> >> >  
>> >> > @@ -267,7 +267,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
>> >> >  	if (strchr(s, '/')) {
>> >> >  		char *t;
>> >> >  
>> >> > -		t = kstrdup(s, GFP_KERNEL);
>> >> > +		t = kstrdup(s, GFP_ATOMIC);
>> >> >  		kfree_const(s);
>> >> >  		if (!t)
>> >> >  			return -ENOMEM;
>> >> 
>> >> Please no, you are hurting the whole kernel because of one odd user.
>> >> Please do not make these calls under atomic context.
>> >
>> > Thanks for your time and suggestions. I will remove the gfp_t
>> > parameter of dev_coredumpv in order to show it could not be used in
>> > atomic context.
>> 
>> In a way it would be nice to be able to call dev_coredump from atomic
>> contexts, though I don't know how practical it actually is.
>
> Dumping core information from atomic context feels very very wrong to
> me.
>
> Why not just not do that?

I was wondering why dev_coredumpm() has the gfp parameter in the first
place. But yeah, removing gfp from devcoredump API altogether sounds
like the best thing to do.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
