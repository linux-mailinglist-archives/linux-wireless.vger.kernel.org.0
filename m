Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1A66DE5F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjAQNGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjAQNGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:06:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741C32E5F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:06:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so4775882wml.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Npy3U/eZWyM9T/Kmww/ZrXNueAspTQ1LP+2PKf6yneo=;
        b=RFtslpJ7KRKn2bYGTbtJextn+UGM4mtNrMhRWixO2pfaCdIvTTXXGA38dxc+SYJHHl
         xXmAHg0T2kqWM22T/k2AXwb87xaMw+SPA6cWkEvZF8CGMtw/j0y6quZY/VMPZuP5CG5E
         YWGvuS0KTkZcrmfCvTMEhxqBNO5VY0l5BUah0E37Cz/a0xVrVAICgNxNM8Uv5KFSPMS4
         Z60H4tYn7mGUygxYSSBcwQLfOV9Eh/tCm8Snm4pCSC53AtPPqsoyhwqrD5+3LU4ypRYQ
         WzZ5uQ24GehGDSjXei+MkSwaP0bMIL+P6pDLzObBxUwS79niJ99SAUgBAOWmoNGmkcOJ
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Npy3U/eZWyM9T/Kmww/ZrXNueAspTQ1LP+2PKf6yneo=;
        b=Gh2Z+b4c5XnloZPCXGV1g2hRfrxmwqg2DEldGtEGiajxkt8eH5EV/1y3ckKcFpnhFe
         pLqIr4+VuE6xYBtx5ypfZaRDSX8KTAi95LdIjuMTX7+lzPc0n+nYKPTK0qRiAbrUKB21
         VBxuUxCy0b5xuy5gNQY+rkF5V4sDv2SnknK1r0BeVQvRkN2riXCqcra2bGRhXsmDFdvM
         nIRDZDqgVPqCOepeNUxdUARRRo6h8vl8KQLdQO8gkS1aSWLuKpw96yqbaGR4kbafEaez
         8XcbtHwOhD9V/qIECAa0VIEprdLjW5q8XjnqOn+ZgRS0ExDA653i2qKl0t3EbPzkKxjx
         iGpQ==
X-Gm-Message-State: AFqh2koimNC2OVo6xj3hrYnDoaEiADd/E5qZcXcBSCyUVROwV4TOWg65
        TeLltIpWE4n95tBXOtYMr7GzQ8i3zN7Vc1pe+D1Sfw==
X-Google-Smtp-Source: AMrXdXvsLUtQeT2KROa0BenoYzT46G87UjLYkCB2o4dJPV5189ihVusp8v/w7FWcour9HN319fS+iPpC6rIMDSA2bLU=
X-Received: by 2002:a05:600c:1d97:b0:3da:f53b:9b9f with SMTP id
 p23-20020a05600c1d9700b003daf53b9b9fmr119654wms.101.1673960793363; Tue, 17
 Jan 2023 05:06:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
 <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com>
In-Reply-To: <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 17 Jan 2023 13:06:22 +0000
Message-ID: <CAHbf0-FzLyQeWN0ii2-2TqMg+5ptVsaoAjqrNe4ceXG_MtNeqA@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     nbd@nbd.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org,
        sujuan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 17 Jan 2023 at 05:43, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Jan 17, 2023 at 5:33 AM Mike Lothian <mike@fireburn.co.uk> wrote:
> >
> > Hi
> >
> > I'm struggling to find these patches on Patchwork, or apply the saved
> > raw patches to rc4
> >
> > If I'm missing them, would you mind posting the link
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20230113105848.34642-3-nbd@nbd.name/
>
> --
> Best Regards,
> Mike Gavrilov.

I can confirm this fixes things for me, thanks
