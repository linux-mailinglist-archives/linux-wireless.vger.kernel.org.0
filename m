Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9836C8A9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhD0Pc2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhD0Pc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 11:32:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B293C06175F
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 08:31:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 124so13316002lff.5
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRPmVW+l8hNmuKSneUNYdhg6EPkPkT9qOMTPIVf8vaQ=;
        b=WvECQx1Lb6QUA9eLy2mj3gWKTvRi2qlDxWJvxkBthHBDfZ1k6fJ+CL1hGO00/dVrWw
         wPIWvoBw+wlYADN0Me7iKLqFSjyRkWlX93t/vKXur51a404hExsx0Fi9/arh1Zx8jWgw
         RyXZ+PeJ9wrOnOw1TFy8SXg+p4uruoka+RSxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRPmVW+l8hNmuKSneUNYdhg6EPkPkT9qOMTPIVf8vaQ=;
        b=l+I9O26+5MG7TR8jqmZn5VXl70YZxHL2BmQNQ76MBIYUrDlI/asOKjEs4ck98SDdYB
         ji5/IHyH53Gn4c9JDSj7cxHrqOUqjJ44htTV+Be+qE6Iyz5u+O4quiMu26bMH1evcpsB
         fqeWz/q6GDBnd8XxP8cjCIgTExc5BJQGIjuY20MLwneITfU5BkHB51QlWjdRCCT/xCoY
         OdusagDFyj/2HkbZQZotXo/VH5s5Wy3G2M3CDKEYQT9ZeR9vkOyqI8qNB8Xe86BL6of9
         k1sZpS+/ta/KkvWx49VQb1INkS0iMjPOOyvb8TAPEdE2R9+D3Y5eC7qbnBYlMZ7NaV6+
         LuOg==
X-Gm-Message-State: AOAM532md69xzkSiY5dFrcxfDE5MPOC34txa1ocLyR1pAjkKySgiPB33
        EuYz5/q2FAkyTaVpbJ4lpsp36cseINFfqXzc
X-Google-Smtp-Source: ABdhPJynF+yFz0J2VGU1297g/fz0kFvVWeQOVqKeFtG11k7EkoDqGlhbRdb9bM3VgmU0/Lwd1x9m1g==
X-Received: by 2002:a05:6512:22c2:: with SMTP id g2mr17334333lfu.535.1619537501302;
        Tue, 27 Apr 2021 08:31:41 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 14sm49918lfy.305.2021.04.27.08.31.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j4so54877697lfp.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr16619989lfu.201.1619537500295;
 Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210427114946.aa0879857e8f.I846942fa5fc6ec92cda98f663df323240c49893a@changeid>
 <4ae9835c535db4f9c0c78f1615f16d56c7083640.camel@sipsolutions.net>
In-Reply-To: <4ae9835c535db4f9c0c78f1615f16d56c7083640.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 08:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsCHfM2XY_0sbXjFKwS5Zzi76w_cErQHg=yAyPKZYuLA@mail.gmail.com>
Message-ID: <CAHk-=whsCHfM2XY_0sbXjFKwS5Zzi76w_cErQHg=yAyPKZYuLA@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: fix locking in netlink owner interface destruction
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 27, 2021 at 2:59 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Though then again, I'm not sure I have a good pathway into the tree
> right now (pre rc1), so if you want to throw it in sooner that's fine
> too.

Ok, applied with Harald's tested-by added.

Thanks,
           Linus
