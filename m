Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578D91BCFCD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD1WUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 18:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726312AbgD1WUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 18:20:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A31C03C1AC
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 15:20:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so256lff.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NGUFVMaVJhOlQPVDeQqDYjLnmYP8D7gYIDTRJ9LvSI=;
        b=lzTd0TaIq1KesCPfL/QSi2v1Vi7DR5BGW+qYAtwnGEcUxmBehc87bgxXzmWv6sC+PO
         DmWl2zP8V2JCVTichy4sQh2IT6fT/xXItHXyJR1RA16ocol0vfDrO4D9iCU/nVrKlqoh
         HZ2upU4LRgmn+Wo6aixl2V+2QE5E5lOkrD8yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NGUFVMaVJhOlQPVDeQqDYjLnmYP8D7gYIDTRJ9LvSI=;
        b=mZn/aCcsXbV2nYTNO129QRplkTq5NaZoCe5UYpkX/FjjKWI5SlCrTLVSnoKQ7ersmv
         kgmfetQSyMfnSfy9zNFRbvLfusE0XVGcCKrUz+Tq2mxQCL4PcAXWs/06UnE50Z7kO5Yc
         AxczW2w5uxA1Mu7FAVdVBKhZZOLClv81PF6wpWD5saEaWpo0CtnSX2iU2KYUuFFsLQtQ
         ZcbHmh3OE83kMj0Ybn6L8aGwWyw8bSY8NJpNYM8y00PBoCJphmhdiE7nHCWk0Sge6FPO
         5lQMa0YXdLUVbegUFilhhKemQHRf5QbZzwLIBPkMKtXL/2cMcGb7Fy69vmMnxpBJCZL+
         Aefw==
X-Gm-Message-State: AGi0PuZK25PzuryRAjJcL/1Dipw6f5/BOrIHfpRK1o8rOxb2qRgXRLIy
        sJ074UMpdoT4ZBLWPeHoPm9ieD2iZdQ=
X-Google-Smtp-Source: APiQypLADwLDO7eADme+YsAmh/BzkngvO8C31u4RAmo1KsREWspPKF6gDd/+a5+Pv3fNgtirM5JR/A==
X-Received: by 2002:a19:f611:: with SMTP id x17mr20910537lfe.51.1588112399334;
        Tue, 28 Apr 2020 15:19:59 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i18sm545561lfo.57.2020.04.28.15.19.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 15:19:59 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e25so537618ljg.5
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 15:19:58 -0700 (PDT)
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr18110100lja.280.1588112398087;
 Tue, 28 Apr 2020 15:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ASDXMghcm-g8uWr2rJOmAOkYocWGCvXKtqs171TQ52DZXmPw@mail.gmail.com>
 <875zdpjwry.fsf@tynnyri.adurom.net>
In-Reply-To: <875zdpjwry.fsf@tynnyri.adurom.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 28 Apr 2020 15:19:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPG2c0TvD9Hu+nurKRbQ17ObmuQmz15GbeZ+nuOm2-=HA@mail.gmail.com>
Message-ID: <CA+ASDXPG2c0TvD9Hu+nurKRbQ17ObmuQmz15GbeZ+nuOm2-=HA@mail.gmail.com>
Subject: Re: bugzilla.kernel.org / networking_wireless@kernel-bugs.osdl.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 23, 2020 at 10:09 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > Does anybody actually triage/manage the Wireless component on
> > bugzilla.kernel.org?
> > https://bugzilla.kernel.org/describecomponents.cgi?product=Networking
>
> To my knowledge only iwlwifi folks follow bugzilla, not much else. I
> certainly don't have time for it.

Ack, that was my understanding. (And even there, iwlwifi folks haven't
been doing it that promptly, because one of the bugs that spurred me
here was in iwlwifi -- it was reported several times there, including
with a bisection and patch, but that went nowhere, until Intel popped
out an identical bugfix a month later.) Anyway I'm not really asking
you to, but I would like to avoid it being a /dev/null bucket somehow.

> I think there should be a big fat
> warning that it's not the recommended way to report bugs, just so that
> people don't have false expectations.

Yeah, that would be nice, and I'm pretty sure other subsystems have
similar (non)expectation. In fact, there _are_ notes about this
already, but they're not big and fat, and they're not included
directly in the bugzilla "report a bug" interface:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html#identify-who-to-notify

Anyway, in absence of that, I do plan to at least keep some ear open,
in case it ends up catching obvious issues.

> > It's ostensibly managed by networking_wireless@kernel-bugs.osdl.org,
> > but I get the impression that list (and really, the entire domain...)
> > has been dead for a long time.

BTW, I've learned that this dead domain is actually intentional:
https://korg.wiki.kernel.org/userdoc/bugzilla#real_assignees_vs_virtual_assignees

> > [1] I guess I'd have to ask kernel.org admins?
>
> Yeah, I suppose helpdesk@kernel.org can help with that.

Done.

Brian
