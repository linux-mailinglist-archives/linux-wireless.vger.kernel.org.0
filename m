Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893E1DC967
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgEUJHu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgEUJHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:07:50 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CFC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:07:50 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id w65so3589591vsw.11
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBFl+AT7rMy9k5RY9HxyJOSNZnoxzsmczmjQr0Kwl80=;
        b=KnolGB7+mDs6ffMRAkF7yF0t7ONpzOaVq0baceSx0OKYSzqUbxfEj1vIIPq623OEzg
         3BI65h7eqIlRiGboHx/yX2/U2D9egUMwISR6SmYQDjZCtaCOHKrtK9+udB03HlHI2JHQ
         N/zDVcWHxdvSV5Gdhe8adgrQCfRj7dW4lhLMWa03PhdJ0icAt8smUl9+nNeUdNiUgIg1
         INBc1Piw7ZFnTqO6muw8xNBSdA7OSq5agn23cUGoWSnoPnDCd0ohR8Fh4Wg6vDSzNSEN
         MHGPAIpzbZt3WFLeUihmkoS4PymaDla0dOC9KcT/twtYjAlNcFdFyEDjGe3vGadhQ4/k
         ul+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBFl+AT7rMy9k5RY9HxyJOSNZnoxzsmczmjQr0Kwl80=;
        b=oMFeoc6J8+Pw7EVE1vtmGSo6u9QltXjlhZidUOE9gtbktqBas/q1IkVR1AV2rDy5/H
         Mc5aA8lV4rqEVdCP7fnh7I7p2msKC4N5fYHQo4eTXk+g9ge7tQVFfb4gp+5694MyDz3V
         9hUVeCHmLFSOd0JbaTJOMDYBF1RI9bU6gitOBGxGtSQL/q/x3+UM6fTQIerbD8BMJXfY
         mYO15ATkBxPC222BhbuMYENFHIOohe5A9LactG3ZVihVRypvkLNcsOPmKnNYge2wfBXr
         AieRZNZ5sNnxSObKcrpkXpA5BYnXOwbK+nHXgFXsjLlK7XEK+S+R1tV1XUa4D8I6JSoF
         PVxg==
X-Gm-Message-State: AOAM5328rBPOQelStO7UzOQM2yL3iIpOQhfLbiJY9eprK+wsTMyGymrp
        bF4NwiUEIqoOhp+byWIbkUD1UBiEYQN5I7qvSJzNqmQ5jr7P
X-Google-Smtp-Source: ABdhPJwlnqG6GbAPmAkCOsNNeHPgBXELXKv+jW+i4X5t/s+icPUk4V0vn+xwqfn/cXpx0rMuiz66G89h26aQFpmj56o=
X-Received: by 2002:a05:6102:22f7:: with SMTP id b23mr6030820vsh.172.1590052069591;
 Thu, 21 May 2020 02:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
In-Reply-To: <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 10:07:38 +0100
Message-ID: <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi again, Larry,

On Thu, 21 May 2020 at 09:35, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> With that said, I'm going to try your patch, but I'm 95 % confident
> the result will be the same.

Well, I'm glad I was wrong. :) With your second patch, not only MFP is
working in WPA2, but also WPA3. And iw list shows all the cyphers as
supported.
I suggest removing the printk altogether or at least demote it to
b43dbg (b43 seems to have its own printk wrappers). In any case, feel
free to add my

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks a lot,
Rui
