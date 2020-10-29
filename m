Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7673629F282
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 18:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgJ2RFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgJ2RFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 13:05:15 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2ACC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 10:05:15 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f4so1917269vsk.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPCxo8dZVoPntUDqM2K1mljtNcAGM6ErEoqv5xxnH0E=;
        b=GgNxjbKiB0mMhC0k0NjJxuIk4xp6/uBwunh+BV5axtlic73wSrFYm6DTwllRXhN2fB
         qp0kLs07xY68okdCMuHAU02Y2Dozue63p6bEo93wqPSHnr+abrKlwbmVKHDGK2jAekkZ
         DaZ+Jwt/y7jWMNa9bFN1iYTPZzPJv3ELgoMUB7EccDCVV7Ftp3KLpBxxZoG8a2VR8/Rd
         r0U9EyBT1WZzrLj3Y0VvngbS6rmE7dWLcTDn0PPtLELLWPVhx36XxSj0zxs7LudSm2+l
         VbmU0/lmAPTj++H/QJdPcP7RjiEG8qXsd+/AngGr/yXddjYIkSC6f7q5NK1cxbEa1IEH
         R+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPCxo8dZVoPntUDqM2K1mljtNcAGM6ErEoqv5xxnH0E=;
        b=S3wxhRxIoo/7DnVvP46nW2AYjIBhjiD4GutAiXc4CZmeV2TFcWVyOmj3baMwtHkthh
         azfVPacMXYq1nxdnKQtORVZJ2rTkrAogpx9StPupNL1Gl/L6r+UrUFAzdCRwJfAcY/AD
         IAG+2tCyXt7+s1KPpFYi94YWpFvuoAuWynEUpIPv5MyF8BUrkMrWar1PSa1H/j/6oM7d
         tkf5wQ3pYpaaAdOxJ0YVPYFH7DWEu4+L8jKVSMtoq88olyhmYp6tVxp4J1FGeTL2DXiN
         Mao36WYwHWFSHRqW08s410J1OLaJeTKLgeqgILBqYhc+JjELYpco8A+sYWfniqsXhy+x
         4oDw==
X-Gm-Message-State: AOAM5338z/lTSKKJIplUk18TEj9xk5GHs7wYdjILV09gS+zMdtL6I0bA
        Pjk3pAXIBFY5UsobZvxL32ELQjoGQio=
X-Google-Smtp-Source: ABdhPJxCj9ltfo+a8A1cnQKp8AzNg2CosRCFdtk85QyOBpmwJR4LjOpcMgj87Z0hZxcDfF3Tbwg2BQ==
X-Received: by 2002:a67:2f16:: with SMTP id v22mr4337149vsv.15.1603991113708;
        Thu, 29 Oct 2020 10:05:13 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id r126sm407904vke.27.2020.10.29.10.05.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 10:05:12 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id e3so1912116vsr.8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 10:05:12 -0700 (PDT)
X-Received: by 2002:a67:f88e:: with SMTP id h14mr3250923vso.22.1603991111738;
 Thu, 29 Oct 2020 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-3-kitakar@gmail.com>
 <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
In-Reply-To: <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 29 Oct 2020 13:04:34 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdayk_YwH2F_k4HYsYPCn_u-k_qdowHpMJUHvLXrvdZ7g@mail.gmail.com>
Message-ID: <CA+FuTSdayk_YwH2F_k4HYsYPCn_u-k_qdowHpMJUHvLXrvdZ7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mwifiex: add allow_ps_mode module parameter
To:     Brian Norris <briannorris@chromium.org>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 28, 2020 at 9:13 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Oct 28, 2020 at 2:56 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> >
> > To make the ps_mode (power_save) control easier, this commit adds a new
> > module parameter allow_ps_mode and set it false (disallowed) by default.

This sounds like some form of access control, not something that makes
power control "easier"? What exactly is the use case.

Also, module params in networking devices are discouraged.
