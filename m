Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C54E595A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiCWTrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31058BE1C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:45:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k6so2540081plg.12
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=+t9TtPNODMLFR1Zb3Enjo1evHmtSbfolTfN3QB79Ybo=;
        b=h0sY61F7Dj2BB2ci7tb0nho4jLTCvR5GMAXiydTwt2G94d3qw/ozhkMHJpfn+JH9hG
         zlZout4wh+A/9nX5LCIaq9D85vzqA4tzIZWyG9Ngid0qcKt94cgt1qJ5U4pcsmINNNAt
         +T0kHuiCWZkpoU1YiTxab6YxEOQqevDRaRljaWw5GnNaojFD6Z/KGE39s+jXcuwgNOeT
         vzKIEjyxjW9yhM3hRuWUrhg1OpodvDaqrCYlkXfFPWlcEd4b6GsnteNlHwAhmtfR1P44
         EuI1JPy5hFubHRyGf+JlbSKMOKP/I9Vlp9lxqK2Xiymap4zao25QF2J3OJKiacUhsOwM
         MgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+t9TtPNODMLFR1Zb3Enjo1evHmtSbfolTfN3QB79Ybo=;
        b=6WoCadcnQPSzCnXOxfij4PbIUdG3nlpSLucotunvaeqBDIulJ3zIc5V3S5rxKVQPbK
         Gt14J3EYE4P62MNTCmtt+acpPNcjyiEJ5henjzBD+Nmzu95CuLJXl6tEChNnza+GQjS4
         Zs4Y90dcGspWq9jDL4L86NWfL2iwqtmyapNEOllYUOudR9ROUSOvh3b5oQcCiuEEv7M0
         wV3a4AE63bo63eEvACj3Lyq5M+AwvoXkT27hvxN9yBXRVAs9oEtAmHU80CEqmQrADi5/
         LlcYP8lzpRlowYawUvwcNnOy4D8cxdCov+K6+vOPL3hR15YQW0cdD0s1XWEMan4mD6po
         5WtQ==
X-Gm-Message-State: AOAM532ozP+bGbuDYgTD62s2CmsFkuhcS5xNo/XMFe52GRdVHLKnlrPF
        FyGy8CV0wgjUpbvEapHJSzTFthU3Tpc=
X-Google-Smtp-Source: ABdhPJxXUuqaGerOkL6/fm/05938b13iNMF5vI9Pfckvz3I8os/JbQxf3yft0EytPYKOVkzRlL+tZw==
X-Received: by 2002:a17:90b:4d8c:b0:1c7:61ce:b706 with SMTP id oj12-20020a17090b4d8c00b001c761ceb706mr1458037pjb.211.1648064743254;
        Wed, 23 Mar 2022 12:45:43 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id o17-20020a639a11000000b0038160e4a2f7sm559631pge.48.2022.03.23.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:42 -0700 (PDT)
Message-ID: <545f0fb3be911c4bed6a0dc81b0679a9824fe6c9.camel@gmail.com>
Subject: Re: poor beacon/scan reliability with mac80211_hwsim
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 12:45:42 -0700
In-Reply-To: <a2c1706527d11312b504f8d445bcbba7738f9c8c.camel@sipsolutions.net>
References: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
         <a2c1706527d11312b504f8d445bcbba7738f9c8c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Wed, 2022-03-23 at 19:50 +0100, Johannes Berg wrote:
> Hi James,
> 
> > We use mac80211_hwsim and our own 'hwsim' daemon to test conditions
> > like poor signal strength or dropped frames. For quite a while
> > we've
> > noticed very poor reliability related to scanning when
> > HWSIM_CMD_REGISTER is used to process frames. Scan results are just
> > empty.
> > 
> > We've put in some work arounds like only registering for tests that
> > absolutely need it and repeatedly scanning until the expected
> > network
> > is found, but there are cases where this is not possible.
> > 
> > I'm hoping for some ideas on how to actually fix this problem
> > rather
> > than continue trying to come up with workarounds. I have tried
> > removing
> > any frame processing (just an empty function) and noticed the
> > problem
> > still occurs, basically just calling HWSIM_CMD_REGISTER causes
> > these
> > problems.
> > 
> > I will admit this seems to happen more on slower systems, like
> > inside a
> > virtual machine environment, or in tests which create more than
> > just a
> > few radios (like ~5-6+) so it does seem like
> > mac80211_hwsim/wmediumd
> > processing the frame is just taking too long for beacons.
> > 
> 
> That sounds like it's just scheduling? HWSIM_CMD_REGISTER makes all
> the
> frames go through the wmediumd (or whatever other tool you use),
> including the beacons - which makes sense, but there's scheduling
> overhead. Also probe requests/probe responses will go through, and we
> only wait for a limited time on each channel for a response/beacon.
> 
> Though I'm surprised the overhead and all is enough to make the jump
> out
> to userspace and back take 30+ milliseconds (which is the smallest
> possible dwell time if you have hwsim hw-scan enabled, otherwise it's
> slightly larger).

Yeah I'm surprised as well. I haven't _proven_ this is the case but its
really all I can think of for why scan results are missing. I don't
think hw-scan is being used, we don't set ATTR_USE_SCANCTX or
ATTR_CHANNELS so I guess this is the best case scenario for dwell time,
hmm.

> 
> Maybe, since beacons are sent periodically, and perhaps we can assume
> the overhead is always similar, then you could do passive scanning?
> 
> No good answers to this, I guess ...
> 
> Though if you can run tests under UML/time-travel that would get rid
> of
> this problem ;-)

Yeah this has been in the back of my mind for a while since it could
also speed stuff not having to wait for timeouts.

But with respect to this issue how could UML fix it? Pause time to
allow the scheduler to catch up?

> 
> johannes


