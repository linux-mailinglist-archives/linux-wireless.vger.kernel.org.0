Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212154E5A50
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 22:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiCWVEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiCWVEa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 17:04:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ECE1F3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 14:02:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so2358973pfk.12
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=QGOHZ5HFyKMOKsZ2gNrbln3zxkPT2vOyc+o5ab8nIpw=;
        b=ZhjR4WFjn4gI+Drg/5Q9K80ZcRdELOded+Fk5UtO7pq/T1oq5O1Oz8tWiiqu0Cv3sP
         pnzwH+DMzE7t55Z0hMaicFFj+c8QB+VU5nQoWMt5EH2zIs+aXk2oxZYitPxMXgghMads
         NofZDT8/PESxCdQQPicIjPtQRrP+fqXxHXB1AyAl7mpVrUotSBhu9fXBIgilwaiGl9Ak
         AtGDRpSfEp0SYRK6SkQICzQ1IshnKRWu4SQ5VTySyazrHWWW1V9wgsVPZ9BTYvy2alLv
         QZYpyp7sa34G+LqMsx9NNOvMv6xbUst+xrlGJ9L29C7v4Y2fu/qQUZjwYNsqPjvWDj0U
         Cl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QGOHZ5HFyKMOKsZ2gNrbln3zxkPT2vOyc+o5ab8nIpw=;
        b=J9+9QUvIf/sh7HaHphL9UF5G7o3/y70x+QW13xhTzhQEqvjPx8NWBeNfb8QR/XKpL8
         OCx6+oKhGPLlNwES1uJDm3PhOM1SjsAoMG5CyGxHNAJr6GVEGlKUg7gOjJQfufj20rMW
         nyIOuO/mjiUylPGbckgq603roiiWn6Ut9BKhUm5TxKhEeD4bTArL9A9qPbenytnxr1Tj
         xTdy05o4LZonjShj4OY3A80LGiQCFwekR8aEFErGK5vPvujgU5Mhx9te8qknWrPei9QW
         Ja8UE9f660vt2P/sMLPRZ5mWJNYGbM4eCi8rat021izD5MU1vdjnE+RipfFTKis2QnYF
         uOJw==
X-Gm-Message-State: AOAM530hOA6eL3jbFqDJWOOvl6AUav81d+YT0Qw31dcLl+vZzGmdFNp9
        39Q1Bl7pkQUE5cVQdJGNMVI=
X-Google-Smtp-Source: ABdhPJxgETGPBTCfKRNO9Ql6I0cr7gerPvEH2B5Nv4pxwjo29NB5XUrWcyAMjwJq2/xlE/PsFUwcLg==
X-Received: by 2002:a63:6802:0:b0:37c:6bc1:f602 with SMTP id d2-20020a636802000000b0037c6bc1f602mr1408088pgc.128.1648069379289;
        Wed, 23 Mar 2022 14:02:59 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f7a2f18e61sm752014pfv.137.2022.03.23.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:02:58 -0700 (PDT)
Message-ID: <260e581ad38850276177bb4dde011de251cff1d5.camel@gmail.com>
Subject: Re: poor beacon/scan reliability with mac80211_hwsim
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 14:02:58 -0700
In-Reply-To: <9e3f1db524321ac33a4aa79341e4e8165eb99189.camel@sipsolutions.net>
References: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
         <a2c1706527d11312b504f8d445bcbba7738f9c8c.camel@sipsolutions.net>
         <545f0fb3be911c4bed6a0dc81b0679a9824fe6c9.camel@gmail.com>
         <9e3f1db524321ac33a4aa79341e4e8165eb99189.camel@sipsolutions.net>
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

> Well I should have said time-travel=inf-cpu, which is really the mode
> I'd use for testing (and we have time-travel=ext of course for use
> with
> multiple VMs).
> 
> In this case it simulates infinite CPU speed! Thus time only passes
> if
> it passes *explicitly*. So a timeout of 30ms will only fire after
> something else has slept 30ms, or nothing is actually doing anything
> at
> all of course. The amount of time it takes the CPU to do the jump out
> to
> userspace/wmediumd, come back, copy the frame, etc. is all completely
> irrelevant in this case. It's just "sleep 30ms" and all the necessary
> CPU expenditure is not accounted at all.

Sounds magical :) I'll have to look into this again. 

> 
> johannes


