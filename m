Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAB5AAC1C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiIBKK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiIBKKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 06:10:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39DC12C3
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 03:09:32 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11ee4649dfcso3613408fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yzl0ZrHrtS0bnPSG44eioa1iLSYXF3Tc3C5yrNYDd80=;
        b=C9C/+LEIemsC8vbeTwp0NyDtpc8NYyTf1ueQFHLcBF/nGBvMl7n1n+Hgh0h23iJ5ws
         0KjenkMCI+pCnoUayZVTpyae9/Qgxd2MVeI6HLLnd1GgC8rQEwCv998H5bNaXqstp6Q/
         SPTHk+uQxp24Fr6AYA9ihMvEPEkuKAIkQTaQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yzl0ZrHrtS0bnPSG44eioa1iLSYXF3Tc3C5yrNYDd80=;
        b=C2Ojf5u3FXU5TJU1qRt7vlyO2nWpFJJN+76WKR388pCqTfyVnjCzP1AsD/C9LSVzNc
         m+6LNPdRZBg5c0NoDDMRFuQFdiOtKChhCgcn6AwxdWW2mtoWQ2RJOmQj83R7SWeWR7sa
         kn5aSUycge6MwQS5JaQe8CDZ3htZfRLqtD86QJ8NTRqyVL6Pf42WzKGSiBEeX0Ubg730
         mNb8SdvD9MAAHNj6EIDGOAF14bz+lW0x23qYr8Ce3NuuoAEidz3oJ0jaw0z6XD2NAkdI
         xbpGoUbyq36aE+Ardx3J8SwIKULX3zxiijE/zDkiGop1QXugpD5V0wBg3l5J0AP71kdV
         hvVQ==
X-Gm-Message-State: ACgBeo2qkzaUpwrYGbu94PkxvjLIO5rVBlpP3FhxmPqVwRWycqOGc50v
        DvtcRxO2FTqKobD37ilQBuV89ns1pMgnRAPEzGwK4w==
X-Google-Smtp-Source: AA6agR62NTLZlvXvfpgnWEonZFEoCEvniVFzFhXbD/r7tKrVgYGr7Jii8BwiW9R1IlNtpeBkBxg7nPZGPoJKNavAslI=
X-Received: by 2002:a05:6870:4347:b0:10e:d8ab:deb2 with SMTP id
 x7-20020a056870434700b0010ed8abdeb2mr1810265oah.146.1662113371092; Fri, 02
 Sep 2022 03:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
 <c177e3cc-ae69-b8c8-bb72-be85b2262149@quicinc.com> <ce01865907335ee597d204eb3cc8caea6b6326c2.camel@sipsolutions.net>
 <CAMLe8U9Stc7YewmobnC0m9-+dWn7YUFY5OrqmM-CkMcOtHADkw@mail.gmail.com>
In-Reply-To: <CAMLe8U9Stc7YewmobnC0m9-+dWn7YUFY5OrqmM-CkMcOtHADkw@mail.gmail.com>
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Date:   Fri, 2 Sep 2022 15:39:20 +0530
Message-ID: <CAMLe8U--x06mAUcgrV7RWR7WUKkN+Q=19YVtHNtG7YyfhBpSHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org,
        Jithu Jance <jithu.jance@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes, Jeff,

I have published the version2 with the above points mentioned.
[PATCHv2,1/1] cfg80211: Update Transition Disable policy during port
authorization

On Tue, Aug 30, 2022 at 2:46 PM Vinayak Yadawad
<vinayak.yadawad@broadcom.com> wrote:
>
> Hi Jeff, Johannes,
>
> From your points we understand, we need a length variable and the
> td_bitmap value.
>
> As per the spec
> https://www.wi-fi.org/download.php?file=/sites/default/files/private/WPA3_Specification_v3.0.pdf(
> Table 4. Transition Disable KDE format),
> we do have variable length of the bitmap. So we could
> 1. Add 2 arguments
> 2. One would be for the length of td_bitmap.
> 3. The second argument would be an u8 bitmap array depending on length
> of bitmap.
> Accordingly checks can be added to indicate/ignore the indication of
> bitmap to upper layer.
> Also the driver can update these fields as length 0 and array NULL in
> case no value to be updated by the driver.
>
> On Mon, Aug 29, 2022 at 3:22 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > On Fri, 2022-08-26 at 08:48 -0700, Jeff Johnson wrote:
> > >
> > > > @@ -3268,6 +3270,7 @@ enum nl80211_attrs {
> > > >
> > > >     NL80211_ATTR_TX_HW_TIMESTAMP,
> > > >     NL80211_ATTR_RX_HW_TIMESTAMP,
> > > > +   NL80211_ATTR_TD_BITMAP,
> > > >
> > > >     /* add attributes here, update the policy in nl80211.c */
> > >
> > > Johannes, do you want the policy updated even thought this is
> > > driver->userspace and hence the policy is never applied to it?
> >
> > Yeah in a sense, it doesn't really matter... I think not updating is
> > fine, then it will likely even be rejected, at least in any new
> > commands.
> >
> > > >             struct {
> > > >                     u8 bssid[ETH_ALEN];
> > > > +                   s16 td_bitmap;
> > >
> > > I know you are using -1 as an indication that the bitmap is not used,
> > > but using signed with a bitmap seems strange since bitops can be
> > > affected by sign extension. Just something that set off my Spider-Sense.
> >
> > Yeah true ... maybe a separate validity bool would've been better?
> > dunno.
> >
> > johannes
> >
