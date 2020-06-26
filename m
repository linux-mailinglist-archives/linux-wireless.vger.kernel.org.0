Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC420BBEA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgFZVwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgFZVwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:52:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95ACC03E97A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:52:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q198so10211547qka.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unTEhFHTPIbe69CpCLwt1ix5Kgyr/d1f6HtKXpl1zVQ=;
        b=bNJ3J2626dcj69quM6yIyJ6MDt61F5nRnomPfXI/9wvRiEcIh5VGqtrUwOfPHmh39Q
         wm59l3bU1u+8zjjCjnZ+tyhqA/gzflvF0Hp73htdfyq7i02qplu2MRwWENZJ9i5r1AQy
         ttj9Pe+eDkjFUa+AxZ4WwkVaN/bHsJo6fFmx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unTEhFHTPIbe69CpCLwt1ix5Kgyr/d1f6HtKXpl1zVQ=;
        b=RMqhH1w/jn5qul73RUmi8TjVmeNvglA/ZpYUnmzKagM95wwvXU/b+2qyFIjAesFM0Q
         eYLEzl8hUcR1h58Qw0jt1OvgyaRe97s94hsODpsAPr2MpzGZ+L48zocerddf+FWIYMG9
         Zc4WYZ8JyVRhTfyBCk3/McV6JG0oqN9wBWVabtzr5zujc5+u7RIs3MDfKxJ9AdZ91rdI
         OQd7B9l7vD0agouQmpxqNcxBZhOWcxiMMSqNGTGk9A1GHOknUtW5Lsj+uWnVeFwtJ08N
         oXmt8cWj6LunUA9A3AoIxh0yROx4bV7g68b6aL9MNSMYH/4VRhXgDUrDVvMNlZXMyRRa
         2QBg==
X-Gm-Message-State: AOAM532uN6Qb5FM8hF/UxUph7j/djH6eumOSJvv+f9xi/fe6NHDpvodi
        f6ikU0sEO7CX19EeoYcHvNoMNBiuIEU=
X-Google-Smtp-Source: ABdhPJxt8IFcQ+E2exzvBnOqafvMGDFH5USPpICblmtypTGb8IG/nVlHRa3utoyjtOU5lRo+cNAXyw==
X-Received: by 2002:a37:4f8b:: with SMTP id d133mr3091123qkb.348.1593208363298;
        Fri, 26 Jun 2020 14:52:43 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id x3sm9407281qkd.62.2020.06.26.14.52.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:52:42 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id t7so5161279qvl.8
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:52:42 -0700 (PDT)
X-Received: by 2002:a0c:c607:: with SMTP id v7mr5210062qvi.84.1593208361576;
 Fri, 26 Jun 2020 14:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com> <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
In-Reply-To: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 26 Jun 2020 14:52:30 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Message-ID: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 26, 2020 at 2:49 PM Doug Anderson <dianders@chromium.org> wrote:
> I should also note that, while I'm not terribly familiar with Kalle's
> workflow, I would have expected to see him in the "To:" list.  I've
> added him, but it's possible he'll need you to repost the patch with
> him in the "To:" list.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address
https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches

Patchwork is his patch queue, so I don't think you need to address him directly.

Brian
