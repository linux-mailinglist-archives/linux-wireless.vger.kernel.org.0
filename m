Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694C7867C2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbfHHRPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 13:15:48 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34128 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfHHRPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 13:15:48 -0400
Received: by mail-lj1-f174.google.com with SMTP id p17so89634771ljg.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOoJKzz8+HsFpsbiURgQ+oEv7KEhI/kLsc3IPOygbh4=;
        b=nZKbJHRdS3B3hSJ52iM/I/Au2Gb1YFcz+a15UT2nQlvjBiHVrSRKYZ51kFnj5X2Ce6
         CSHTjofQu4+kEq8gPQ4henUqlALGuRvZnXNAqbxWRH9g0O+iAWTNkJHdxP7KItHmMXC2
         8qCesHRrihs69ZUNFZzQdD5jhvlDV4Fa9ZgxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOoJKzz8+HsFpsbiURgQ+oEv7KEhI/kLsc3IPOygbh4=;
        b=I9QAXa5lCg7n3zoZotAvZycKapThPjOygfEJD70k39NrZTrfqGRvxC12U7hwRdshZK
         aIlfF4HSG1kW3I7Aot4rI9vhrgYLdfN3DYa8pn1Sy8Sx7kzKekqUe/nv+NlIapG9coFI
         Alah21N1TPvWy80BYxau1hWz3YDto/9LL5F4V1lqglV3w9RQ2HRDACO8jQu2QY0zUBdS
         1BMSwQ54KVJIllX7rbnMnfkSUbmC2xPg2n9Vy7CgGIXplpzA8oBqnBsZ4XURnx052odp
         zLh3Oyh6hBzKjXT+BliS4pxvmyMETv/yk54rL0pAazUjt4xdL+ljHRFUFRqPUUcuMdjD
         Obmg==
X-Gm-Message-State: APjAAAW4T2/B6e41TEa3Fyx4jA0bkLCf5pyqEjEDsbOIZqm33fVoyvf2
        tah1vd/9rWafhNQTwcAXAJYbQRLG4A0=
X-Google-Smtp-Source: APXvYqws2CiH4IeGLJosN+AvqFITooYnMU28gIIIWu7elCypL4hg+LovFsASPcS/XSsAf51lV5UmkQ==
X-Received: by 2002:a2e:5d92:: with SMTP id v18mr8992050lje.9.1565284545979;
        Thu, 08 Aug 2019 10:15:45 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e26sm19013482ljl.33.2019.08.08.10.15.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 10:15:45 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id b17so67427474lff.7
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 10:15:44 -0700 (PDT)
X-Received: by 2002:a05:6512:70:: with SMTP id i16mr9807995lfo.26.1565284544177;
 Thu, 08 Aug 2019 10:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com> <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
In-Reply-To: <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 8 Aug 2019 10:15:32 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
Message-ID: <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>, j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Jouni

I forgot this was dangling:

On Mon, Apr 8, 2019 at 12:52 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> So I guess you'd have to figure out what operations the drivers need to
> support then? I'm not even sure how wpa_s would handle this for SME
> offload devices.

I'm not intimately familiar with FT, but it looks like the only thing
wpa_supplicant is asking for is NL80211_CMD_UPDATE_FT_IES. I see
exactly one driver that implements this, but there's no flag for it.
Well, I guess we could just run the command and look for EOPNOTSUPP...

Jouni also claims [1] that there are plenty of out-of-tree non-SME
drivers that support FT. Android drivers may not be directly relevant
to upstream, but this topic does affect our ability to use
wpa_supplicant generically.

Brian

[1] http://lists.infradead.org/pipermail/hostap/2019-April/039951.html
