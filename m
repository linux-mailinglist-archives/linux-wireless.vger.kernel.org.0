Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709705E561F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIUWLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIUWLI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 18:11:08 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F504A7AA1
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 15:11:03 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j7so8276004vsr.13
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S4N2t14LaO9r3kjmjtHNWAAQ7SKHk2zZy0Milsgj27g=;
        b=d3tpnH2K8GfdyI0rrWOsR4Miq6x1LDFNnh2AuhQhxjBXEqGXz1/LEtBBSdBANBDpR1
         ftKTlr7uiYw0tDETT3Jo1NZSwhd2JcObaOiz48WsXK00qs0NUvhzQs4v7g4wYs6BPVk3
         60SzCmgS4NFcm72IucPLVHgh830y7xkFnyYe9hCnP94lbgZFF12TFkX4fvS9yyQa2Iy5
         IZY3Sh0SzX/RzBdGo0Ja+GEaptTE38u2wrr5sI7/T1MPAxlsPOom+5PiPBiKJ+yUvuef
         QNpZCdE3KXl5xLmRa0i5eejDhpwIfYL5kpGCMBcuAEGDBZ0diEzNK10bCT2d6Ofsujuu
         FmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S4N2t14LaO9r3kjmjtHNWAAQ7SKHk2zZy0Milsgj27g=;
        b=T5PvgcRYKhQM2jUuwj6XpzNklvU+VzuRTBKYSEB1yMfT22gxfaIaXMjrCmUpr2RgxE
         frmeEUpzfT+XMh+R9li/sJ4N4R0miaVsgIZ/McFmspQQBBtymWs7AdzZPcKG/IXisV7g
         jTiGhgKnfMh52YSn8KwYQs+QadWuhvfI9CLjDuYZqNKou8h/LbU1ixkJHGrbtoIgrnRo
         bRPejGmxZJzarVGSlRRiSIjZCxR2stHP9Dfv39zwjL71HwBFNPNRJDX/BKfNpCL1Bc2/
         TOIRrcIv3sn5Hbnpv/BRqzqR4Sj+Vul/gwzNyLG3O9w+C6pKR+MqUHbl8TKz67gTjJe8
         4ORw==
X-Gm-Message-State: ACrzQf1OIs1Q8XgdmpV/vOfRZSNSykwuXF87Bc3nP7MBZqopsPethsJC
        /4Xwcot/X1blLAxZfacsCSKF0OQbFJOld3m2nSC+Gypsc8gpgA==
X-Google-Smtp-Source: AMsMyM4yqgGFH9oB6acU8QlzEwjZhCZuiPqprXJUZBOA1U9nPjFeYMKuPSeC0J3jOAwG0NVVN1mLHf6vlR7So/e3el4=
X-Received: by 2002:a67:dc98:0:b0:398:c70f:9357 with SMTP id
 g24-20020a67dc98000000b00398c70f9357mr116933vsk.76.1663798261988; Wed, 21 Sep
 2022 15:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
 <20220906044812.7609-2-kieran.frewen@morsemicro.com> <33a46d12583b540a921f6ce96065c9a177bd044d.camel@sipsolutions.net>
In-Reply-To: <33a46d12583b540a921f6ce96065c9a177bd044d.camel@sipsolutions.net>
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 22 Sep 2022 10:10:51 +1200
Message-ID: <CAKHj3qTuYn344Z8Lvvc2gOvbrdkXxdy6a2UXjPv9MGbP8n1qKQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] cfg80211: regulatory: extend regulatory support
 for S1G
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 6, 2022 at 9:36 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
> > Extend the S1G regulatory information to support all regulatory
> > domains. An reg_s1g.h file is included containing structs with key
> > regulatory class information. These structs were required to ensure
> > the right combination of information was available to a series of
> > functions which support the mapping between frequencies, bandwidths,
> > and channels.
> >
>
> Hm. Isn't this type of thing something we'd usually want to keep in the
> regulatory database to be able to update it? Who says JP will always
> stick to their restrictive scheme, for example.
>
> johannes

Yes I agree that this information would be best stored in the
regulatory database.
Especially in respect to maintaining a single up-to-date source of knowledge.
I have done a bit of investigation into what information we would
require in order
to maintain the same level of functionality. I think at the very least
we would have to
add the base frequency to what already exists in the regulatory
database. By adding
this we would maintain the ability to map from S1G channels to frequencies. We
would, however, lose the ability to specify exact bandwidths for a
certain frequency
as is the current behaviour in reg_rule_to_chan_bw_flags() and would
likely have to
change the S1G bandwidth flags to not permit certain bandwidths on a
channel, e.g.
 IEEE80211_CHAN_NO_2MHZ as opposed to flagging a single allowed bandwidth.

I do wonder that if we do add a base frequency to the regulatory database are we
straying from just maintaining information which permits or prevents operation
in a regulatory domain for a specific frequency and starting to
include information
that the kernel is relying on for mapping from one field to another, e.g.
ieee80211_channel_to_freq_khz().

Kieran
