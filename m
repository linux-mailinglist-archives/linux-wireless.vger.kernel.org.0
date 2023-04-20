Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD16E8E55
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjDTJhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjDTJg5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:57 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 02:36:43 PDT
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DE359A
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1681983040; bh=NA/k4um9rHRfY4bXrpGgru77EhrVPivd3J33GG3aYO8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 dfQWKSyLbiFxFFfiyCSOTc+96FhB867UzFmywXVCGYQAvVF5Wy3jsswdm1/pT+CrquqvHOjj/oW5ILFEatXcAg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1681983040; bh=NA/k4um9rHRfY4bXrpGgru77EhrVPivd3J33GG3aYO8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 eTzbK3XI2yNAXpPtpV92UuACqXjdd0YO9AXVkQvQoeQ2gNTNcBdRdD2JWmLg/VlLn+HTpp4ODRgf/rHoLrir8fbuM7mLKXsnoBjd1ToipSxQRKmssKJFdcZbUZSONnnz4CgeCuRJfh2aLrsv51qOkynPaAoPv2ZD7GyrepP1Dz8=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 20 Apr 2023 09:30:40 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 20 Apr
 2023 11:30:39 +0200
Message-ID: <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
Date:   Thu, 20 Apr 2023 11:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Karthik M <quic_karm@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
 <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
X-Enigmail-Draft-Status: N02210
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: E863240B04B14804C3219B25F24F284C1B09F1985DBA2AEEE7B5932F10C236F32000:8
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> 
> This still seems really non-intuitive to me.
> 
> It seems to me this is down to the special "0 means init" behaviour,
> that you don't want, because your values actually fluctate between 0 and
> 100, and you can actually legitimately reach 0 with a lot of successes.
> 
> But to me it's really non-intuitive, if not counter-intuitive, to say
> "oh yeah my values are 0 to 100 inclusive, but I can't ever deal with
> reaching 0 because then I jump to 100 immediately". That doesn't make
> much sense to me?
> 
> I mean, I guess I can see where this patch makes some sense like from a
> code point of view, this is sort of the minimal code change you could
> make to make the existing code work, but ... I'd argue you're optimising
> to the wrong metric here, "minimal code changes to fix the bug" should
> normally not be your metric, it should be "code changes that make this
> clearer and avoid the problem", or something like that?
> 
> Anyway I guess that's all a long-winded way of saying that I don't
> really agree with this change.
> 
> To me, basically, I see two ways to solve this:
> 
> 1) we have DECLARE_EWMA_ZERO_VALID() or something like that which
>     *doesn't* treat 0 as an uninitialized value, and either has a
>     separate "not initialized yet" bit (but that's iffy storage wise),
>     or simply has another argument to _init() for the initial value or
>     so.
> 
> 2) you don't just don't use 0 and 100 but say 1 and 100, that results in
>     basically the same behaviour, but avoids the special 0.
> 
> johannes

I also ran into that problem in the past, and reviewing it again with a 
college, I think, this is a real bug in the EWMA implementation. I try 
to provide a proper patch in the next days, but actually the EWMA 
handles the internal value zero, always like in the initialization, 
which is wrong, e.g., for positive/negative averaged values.

A quick research shows, this bug is since the first implementation of 
the ewma in the code ...

kind regards

Benjamin

