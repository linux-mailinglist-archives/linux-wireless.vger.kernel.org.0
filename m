Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEB672599
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjARRyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 12:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjARRyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 12:54:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D556EEC
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 09:54:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so35149808pjb.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2E2FnU/NM/qjtySe8MZiv5YI3I3qG9fAGQsUETP5Zk=;
        b=S2jq0vj77NvlQjz0rvuNqUr91t92eH1B7AvAp7jX+N1w+UsdsZh7vajPtaQV9T9pn5
         4aBO85lErr65bEjQORvuTdLuDquFDyGml+tRuWwzT/f02TVwvUCztS3jF//FLKcQHb2G
         JEWGTq0Pnj47eaz0cTzLMicD/wRkPDk6Oes6QpPoNyQikewxw2+KDvEq5wr7LXGYuZgC
         JKbqbWmuX37Vc+6ajWK0k3BW9ze9y4nSxcqZDY7/Mk8IKwO9kk2FQ0ttf+H8CQBuMsmw
         NmVIFtjaP23EX4relmt6JWVx8wc0aNUQxW3ziWBTDoj6Z6fNQ6aDpuzMAEOh6GLXUehe
         lNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2E2FnU/NM/qjtySe8MZiv5YI3I3qG9fAGQsUETP5Zk=;
        b=6s2YJqhPdmeAQ6ZPE4aSoiTuJCViJ9v5tL2gvk6O70kKZqg66wobHEpHxEzPzn2qvb
         DiPvKF2gm3gdvYfCspaq7v4ZGc8K+2Ie2NZTua3KWZOrJEQLVMVfuCIX8Y1Iu7/C3u5G
         68w/QoHOXSalXhEGzzFL/1rIu7jyWmYTRceUIGDa5zKpj8+Fjz/KWuDAd2rwX1YnHDC/
         C0eCbZ0+LefjLLUfYJYkyK/T9q7+cuk419dVJbcc/bsfpR0KBBYS+rBh/TbdhdMv+ADR
         PmV+S1T4wBqrQJhrSx8X/gw2WwYBl3qw7Cx72/eBPMGvgXATKOsLDrEvWE8Ll+VcDMsf
         vX6Q==
X-Gm-Message-State: AFqh2krTZvkswTZqN+ZQpoTLoshXJIw9xsCp2qwVcfZo9/9vS9DgFygU
        maE5D1flh0KkGDjoqs4x74XzF6h4+nU=
X-Google-Smtp-Source: AMrXdXuq5ApJF1YZZ/V46aD1M5O3bBDUHHYxRsNirQy+6KNeShmG7ZLfHI6CUZ6rdfXcuhVmjnP8Og==
X-Received: by 2002:a17:90a:134d:b0:223:f60e:87b5 with SMTP id y13-20020a17090a134d00b00223f60e87b5mr29869120pjf.20.1674064478736;
        Wed, 18 Jan 2023 09:54:38 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0020ae09e9724sm1618428pjt.53.2023.01.18.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:54:37 -0800 (PST)
Message-ID: <52746d84e1961ee6cb896a8f23d6857774945014.camel@gmail.com>
Subject: Re: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 09:54:37 -0800
In-Reply-To: <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
References: <20221025203443.410121-1-prestwoj@gmail.com>
         <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-01-18 at 17:06 +0100, Johannes Berg wrote:
> Oh I guess I should read the cover letter too ...
> 
> On Tue, 2022-10-25 at 13:34 -0700, James Prestwood wrote:
> > A user reported some behavior where IWD hangs expecting another
> > event
> > to come and it never does. This was due to the firmware (iwlwifi)
> > timing out after authentication and calling __ieee80211_disconnect
> > which essentially does nothing if not associated. The problem here
> > is userspace expects some event to come after authenticating
> > whether
> > it be an association, disconnect, death etc.
> > 
> 
> Basically I don't understand why userspace expects some event. It
> asked
> for authentication, and you got it. That's all. I don't see userspace
> asking for association, or anything else, so what would it be waiting
> for?

I should have explained this better. I dug up the old thread from the
original report and IIRC this is the sequence of events:

1. Begin reassociation to new BSS via CMD_CONNECT. This results in the
kernel sending many events to remove the current BSS in favor of the
new one:

2. Receive DEL_STATION, DEAUTHENTICATE, DISCONNECT, NEW_STATION

3. Then a CMD_AUTHENTICATE, with a success status.

4. At this point the firmware decides its not gonna continue and calls
__ieee80211_disconnect which is a no-op when not associated. We assumed
either CMD_ASSOCIATE or CMD_CONNECT will come after CMD_AUTHENTICATE,
or a CMD_DEAUTH if there was a problem.

I will say, we do see a CMD_DEL_STATION event here which we never
processed in this case. But again, I would expect a CMD_DEAUTHENTICATE
since we successfully authenticated, right?

Thanks,
James


> 
> johannes


