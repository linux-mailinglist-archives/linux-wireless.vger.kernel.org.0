Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C198065AE1A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjABI3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 03:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjABI3D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 03:29:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3811223
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 00:29:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w1so13581981wrt.8
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jan 2023 00:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14VVxKr6BXixpCLj3St1aTaL7CH8SHLvndLzSdzqHe0=;
        b=fnvk9LyX2KX17UfsQ1iXatnGH+aQEHamYOhssyFakDZ1HiRgRWtsQGOlMF/RK1ry/U
         GZ0U80sqlGJGHCPf0bOwyEVU581qj5NuWABzGBi6fXh2Nn/J1Xke0qRz5HyUBG48sExo
         hNO481Z9mzQvtHkNOE2eALiKkfftOyv1IItE8ZCMs6oaxPT7rRgAtqIVPfDkV9Y2iKuj
         kkNsyjPq5QUKgzpTlHZaZUZfZbYl3BeqMmRtRmYdVmKoEHto90SLeOM4WhICaHxghKwO
         8aEeES/eDtbiaO5rYD1nttvgBEgceXHixBXKQyN4FkIsHCX0gaJyuVJ9tTnhYq5JfyOm
         6Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14VVxKr6BXixpCLj3St1aTaL7CH8SHLvndLzSdzqHe0=;
        b=mmIa8xRQy5f1Oxr+eFX8+lLpZTRAoMKA+/erDnkMEkgvIFrW+Vao7OKT19o2XUdfqd
         3RF2HR11U2u3uEwNypYjcLNQyvojKduV00JGw41WR48sf+xVp9FlvzoD2ivOJ4oGaBUI
         6DDw1tgI7efQXQkjlthvl/ZRBc3lJj680Sb0+9mJGd2tZEPPZva0Qm6473Ax2h4AAQja
         UJ6/1CMrH9PRnknhscHMgIRwExiD4yc+LwyhsbkUfTFQ4eZSDCEddsj2x3wMEeyF3Tg7
         PN5zW4WAGvPWTKuO3caLM0QKYpvQEuVNDbbvYUubqYz4+qrlTy3xamuF5/lFCtA2W9R4
         6dpw==
X-Gm-Message-State: AFqh2kr5LEFSFUDAfIInAllGlaDz1X+4X2PvWugDLt+lmJZkA4pzPgBK
        oO3q2O6Sk4SjSry2VASaEx1ArA==
X-Google-Smtp-Source: AMrXdXs7LUCcSQ15KkpFP/JPTdg5E95dSy1iQ4KnXrOXSffAGXilpeW1NxxRxZFRDqYjjQgSUsTLWQ==
X-Received: by 2002:adf:ed51:0:b0:242:659f:9411 with SMTP id u17-20020adfed51000000b00242659f9411mr29246659wro.9.1672648139238;
        Mon, 02 Jan 2023 00:28:59 -0800 (PST)
Received: from [192.168.178.20] (213.211.137.251.static.edpnet.net. [213.211.137.251])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d664e000000b0027f4a7efc54sm19370120wrw.15.2023.01.02.00.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:28:58 -0800 (PST)
Message-ID: <03b57a68-e28b-52c1-ba26-f6766cf9fa33@mind.be>
Date:   Mon, 2 Jan 2023 09:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 1/1] iw: add support for retrieving keys
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20220822074318.291949-1-raphael.melotte@mind.be>
 <20220822074318.291949-2-raphael.melotte@mind.be>
 <a0ae817f24ee6bd2485cd8c722f4cc9cafb1e3f3.camel@sipsolutions.net>
Content-Language: en-US
From:   =?UTF-8?B?UmFwaGHDq2wgTcOpbG90dGU=?= <raphael.melotte@mind.be>
In-Reply-To: <a0ae817f24ee6bd2485cd8c722f4cc9cafb1e3f3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/22 14:37, Johannes Berg wrote:
> The examples don't seem to match the docs:

Indeed.. I'll fix it.

> and maybe you should switch pairwise/mac addr since it's not required
> for pairwise == false I guess? or maybe let you specify the key type
> instead, so you can retrieve other kinds of keys?

I was actually thinking about removing the pairwise flag entirely.

Since the kernel currently only allows to retrieve pairwise or
group keys (AFAICT), I was thinking it could be easier to use the
presence of the MAC address to differentiate between the key
types.

> 
> and this seems like it could have some error return in the else or
> something?

Indeed, I'll add it.

> 
> Otherwise seems fine to me, any particular reason you sent it as RFC?

I thought there might have been a specific reason why it was not
there yet, and I also wasn't sure about 'NL80211_KEY_*' vs
'NL80211_ATTR_KEY_*'.

I'll send a v2 addressing the comments above.

Thanks for the review!

Raphaël
