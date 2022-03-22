Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0504E48C0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 22:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiCVWAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 18:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCVWAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 18:00:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F30DE9F
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 14:58:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n15so16649202plh.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQQUwUChUI+UNOQvroFKyGR8hGBqXCWrhiXQx8Vdu0A=;
        b=EkhfK2odb6PaVisGY57GieNJ949W48/7LJ3bgmhszUfLcL5pHP9NjtM7ExaU7Y6iiv
         edgp79c4eMa8S/r+RFQOMCjdN30A8si+vRYutVQeQgWU/FIBVFd5xEDZDSoUcmqvSWFP
         SqgGiWHXQ1cHA6MsBUNjIIZ8flNlo7UbuMa979gd35CkzgMyIrEeN26Y4XeB3DCPC8eu
         86rJ7j1FUKxCj/1+D6/r3Ym8nRYNiCXWJEb0yRE6GF43R8oj6jnlyUqSb3CoGBIz56Se
         LUh0a7FD6T7yWzuJtv9VLj6q9RKcKaFxUAjdWUe1rOg6jc2vJ+lq9nHOx4/hebCTFf0x
         MhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQQUwUChUI+UNOQvroFKyGR8hGBqXCWrhiXQx8Vdu0A=;
        b=WoDSplFt99qXoZNT92T1H1+f6y2JZR15KNXYY38ETF4iNfnUhJEznca72t9hsDFqhZ
         4NehKYKmxnR2k32yd2IShfv4TL8lEYMdkfGCtQ76stXZFdHoFsxDvFHWs8mtPFF0eP5n
         Qbw58YCgDUoltYSwHwjatKvMw1X6p+6X+Dn3i4Hklze9ZrLyrN/BhFq2/EXkJFv+Pe/X
         gR8bOmiVomYmEjOjp/z8WHoAhaEwWxKg3wqgURol+tfl4ViS5RNpqao3cL3dLdZND4cH
         ySxMwvbCvJqONr6GDY6HzwESy3QnVAJpe+A3lBlm1cliBX+Lw05yEkS6IYN9v37bR3yq
         s/yw==
X-Gm-Message-State: AOAM533HMNlqf6ElZMHj+j2eB85F7iUnYIV7DjMRiY/mry9/zY9SuDO4
        V/g5jWC93mLJPSqXlD2Q+2iQIQ==
X-Google-Smtp-Source: ABdhPJwCv2hwHzZFAvk+ET76Tfb1tATMwQl0OFXw0oZV0MlBD3NU478SmL8IAo79LVcEAFxUekc5EA==
X-Received: by 2002:a17:90b:38c7:b0:1c7:6afb:fac6 with SMTP id nn7-20020a17090b38c700b001c76afbfac6mr4489140pjb.198.1647986329290;
        Tue, 22 Mar 2022 14:58:49 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id y24-20020a056a00181800b004fac7d687easm399357pfa.66.2022.03.22.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:58:48 -0700 (PDT)
Date:   Tue, 22 Mar 2022 21:58:45 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
Message-ID: <YjpGlRvcg72zNo8s@google.com>
References: <0000000000009e9b7105da6d1779@google.com>
 <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
 <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/22/2022, Jeff Johnson wrote:
> On 3/21/2022 1:07 PM, Johannes Berg wrote:
> [..snip..]
> 
> > > I'm not an networking expert. So my main question is if I'm allowed to take
> > > the RTNL lock inside the nl80211_vendor_cmd callbacks?
> > 
> > Evidently, you're not. It's interesting though, it used to be that we
> > called these with the RTNL held, now we don't, and the driver you're
> > using somehow "got fixed" to take it, but whoever fixed it didn't take
> > into account that this is not possible?
> 
> On this point I just want to remind that prior to the locking change that a
> driver would specify on a per-vendor command basis whether or not it wanted
> the rtnl_lock to be held via NL80211_FLAG_NEED_RTNL. I'm guessing for the
> command in question the driver did not set this flag since the driver wanted
> to explicitly take the lock itself, otherwise it would have deadlocked on
> itself with the 5.10 kernel.
> 
> /jeff

On the 5.10 kernel, the core kernel sets NL80211_FLAG_NEED_RTNL as part of
the internal_flags for NL80211_CMD_VENDOR:

net/wireless/nl80211.c:
   {
      .cmd = NL80211_CMD_VENDOR,
      .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
      .doit = nl80211_vendor_cmd,
      .dumpit = nl80211_vendor_cmd_dump,
      .flags = GENL_UNS_ADMIN_PERM,
      .internal_flags = NL80211_FLAG_NEED_WIPHY |
              NL80211_FLAG_NEED_RTNL |
              NL80211_FLAG_CLEAR_SKB,
   },

So the 5.10 version of this driver doesn't need to directly call rtnl_lock()
within the vendor command doit() functions since pre_doit() handles the RTNL
locking.

It would be nice if nl80211_vendor_cmd() could support taking the RTNL lock if
requested via the vendor flags. That would require moving the wiphy lock to
nl80211_vendor_cmds() so that it could take the RTNL and wiphy lock in the
correct order. Is that something you'd be open to Johannes?

--Will
