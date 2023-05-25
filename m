Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B37114DE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbjEYSk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbjEYSjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:39:42 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CB1FE8
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 11:37:18 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-19a427d7b57so28019fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685039764; x=1687631764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MPRMv2BbAXw3JCr94JUtC+i8vOm9V/mqY4t3JD4+MMQ=;
        b=S9xx0MJil1AJDkBLuQbQoInfkxElg9NUw6ZLcKvgcBoSRCskS1AEjsQnDoWAGgdBGf
         uIJiCtkFdFn4iH6XCqzMA/bBtwlhlGRvslLYht//CJflMB1WmYhYqAzI7AO0zO0I5ukI
         1yocp9MbziCv4m1Uny5QBJi+HaXjmTZLFR4VFdAqhqXoUrMa+gVvZzLBWCxBLORTw6+7
         ucRsX3Ra/MhoCo0IU64sUinj9JK7gQ7ZS1rj1iC0OaFnENpiYltHGE9Lio2Dnj+Ac/dd
         sPLOExNwUGGuB5CsWKGw5S2u0wOrWNent/wQuqi8qU33d5SbHWstIOWjJ7LjoUUFLUEC
         +0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039764; x=1687631764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPRMv2BbAXw3JCr94JUtC+i8vOm9V/mqY4t3JD4+MMQ=;
        b=CcL4QIVtt2ijilLqjfXiqynggI6VAjMZE9yeWef6aML13W4caF6s2moz+tJzDw22GH
         W333m75Imp0VsMYjTIkaujb56A5l5FVr6LfFuhA29JvWWgd7P4/tpHVwwnOnzw2SZOmC
         FTGpklu0slfJDynaznwLsF1wo8ro6SECFh4WhuFaSjmQ3/OxyP8jkRcRh3Nn1utepzmZ
         dnZQjYZD5MHNvsP/uqPMLH2qocd0qbbRuQI22k+FEWGbOGlknVDwA7yfEtfKsH6iQa/G
         ewWviMTED6wVpzSFS73S+FFGHq7HO8XPotFwyLNk9W+hbRb8zEMdV9TWTXBIDGFtAKe2
         nu0A==
X-Gm-Message-State: AC+VfDx7KlP7+vhcs2Oi5+ILqzUOH5R9JwCiHLr/2wNLfVnmGRkNtrSF
        Vo+iQbkltIfcYyEyQ6TN0YTzhTCaLjE=
X-Google-Smtp-Source: ACHHUZ61qJdnT1eXSZ9jrCc2T5M7EaYChObNsMqR1EWbDSFfYJlcidpC96uQQv2Uz3sGZ6t4i8GIXw==
X-Received: by 2002:a05:6871:455:b0:187:87e3:1247 with SMTP id e21-20020a056871045500b0018787e31247mr1791890oag.43.1685039763644;
        Thu, 25 May 2023 11:36:03 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z24-20020a9d7a58000000b006adc6abf66dsm921862otm.6.2023.05.25.11.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 11:36:03 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6d635666-4973-b498-f67b-64762dbbd768@lwfinger.net>
Date:   Thu, 25 May 2023 13:36:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Question about power save
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
 <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/25/23 13:05, Johannes Berg wrote:
> Yeah, I think I saw the report, but I'm travelling and didn't have that
> much time to reply.

Johannes,

The rtw88 drivers are definitely setting both SUPPORTS_PS and 
SUPPORTS_DYNAMIC_PS. It seems that there is a bug somewhere is those drivers.

In my repo, I will remove the SUPPORTS_DYNAMIC_PS, which will solve the problem 
raised in the GitHub issue. That will give me time to find that bug.

Thanks,

Larry


