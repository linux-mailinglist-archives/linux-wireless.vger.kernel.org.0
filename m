Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4DB5A742
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1W7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 18:59:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38314 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfF1W7F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 18:59:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so7486668ljg.5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2019 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hxr737kZawIDdGnBRfezwRYZfPo+N/0q3w7Fxi9l4A=;
        b=VF6Qdhuv7A1bSXPlb3IW1+FrjzPu/5kLqJR8Bz3t4QYSsRmFGPpUKtjDK+76denozn
         16FGNec6EkruICXjbpFZ9+3J36uau6xjWzLCfmQ1pkX2GY6gfKFgHUUoAsIpsrM4gUfb
         2J1/qNcGNldERB23rgLKXTx1gg+Ws1OyBf04k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hxr737kZawIDdGnBRfezwRYZfPo+N/0q3w7Fxi9l4A=;
        b=b4rqujL6Z1rTIssbktVnmK4KX6r5Mxk7BXHILb5DXgt7/YwPzmweBh7jBFVR8ESHfC
         uzoDnhMfZ9WSbdVbDmyyg4VA5bjqXQDg7wirfq1rSNXEoPPFBdHK4h0lf6tpfMrK4teU
         5Qgfr1GmLqNnLV2nBA9Jy5svvc7tr3EMLgiUxBAGM9zW5KfSJD/DxrlnZk6bpQwf+lKG
         MpCwi/qjO0FEHmUTIhFJ5X1P4dY0+8fr8ASiaiOP7u1SLGrwIXWMFTdZgLcFjQuei20x
         b7m2+X4Pv59I/Q5ALqLRuFXpkHeuT3UdjOE8EoNmdjtXgLasdHGVbL+gbmP1D/SLbRGO
         sxkA==
X-Gm-Message-State: APjAAAUFbILzxd9fpVPILSNW3LAp012Di4RGKLAB2vmdTENoC8pi3BKf
        MmgS/WQbIqdj6/xisxIZsJ4fX2Qb+vk=
X-Google-Smtp-Source: APXvYqxan1K9pspRwwPFiWSFzj2wMLjizmxIvxaYChLzdKtr8IuhVZpttQSajFdS64o4b+qzDsvxGQ==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr7673851lja.230.1561762742698;
        Fri, 28 Jun 2019 15:59:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y5sm1112320ljj.5.2019.06.28.15.59.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 15:59:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k18so7461184ljc.11
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2019 15:59:01 -0700 (PDT)
X-Received: by 2002:a2e:9758:: with SMTP id f24mr7644626ljj.58.1561762740673;
 Fri, 28 Jun 2019 15:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190627003616.20767-1-sashal@kernel.org> <20190627003616.20767-14-sashal@kernel.org>
In-Reply-To: <20190627003616.20767-14-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 28 Jun 2019 15:58:49 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com>
Message-ID: <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 14/60] mwifiex: Abort at too short BSS
 descriptor element
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 26, 2019 at 5:49 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Takashi Iwai <tiwai@suse.de>
>
> [ Upstream commit 685c9b7750bfacd6fc1db50d86579980593b7869 ]
>
> Currently mwifiex_update_bss_desc_with_ie() implicitly assumes that
> the source descriptor entries contain the enough size for each type
> and performs copying without checking the source size.  This may lead
> to read over boundary.
>
> Fix this by putting the source size check in appropriate places.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

For the record, this fixup is still aiming for 5.2, correcting some
potential mistakes in this patch:

63d7ef36103d mwifiex: Don't abort on small, spec-compliant vendor IEs

So you might want to hold off a bit, and grab them both.

Brian
