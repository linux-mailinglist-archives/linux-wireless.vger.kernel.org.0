Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85746D29
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 02:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFOAUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 20:20:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46531 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFOAUL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 20:20:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so3994571ljg.13
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAjnaDPWtHFKikoiM/VnGjn67LKsaMlMOH3NfKh6xrA=;
        b=VKxIRyVWBj7DCikyQglckws1mX0lG7WFGFl+3pdxwCqLDT1FJxFlHvm/Q1KQAPg07/
         ZD9AAIf9OgbyRcW3sOJpsmFXhnR3GAbJXV+9/4/ic/ETCCeXE3T0hGph8tH8+gDuTFj+
         7sUvqQ0IKAjcvTW8awgj7p1vGJa80SpjLhA7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAjnaDPWtHFKikoiM/VnGjn67LKsaMlMOH3NfKh6xrA=;
        b=hz1zCxi460jW0YSlPQsf6eXZd5mAbT1J2lz1t0MlNOF8f2CGjyGCSMazuDLZrhumEJ
         b9nc0tO1AutN4UdelNOYbi/ksrih7OZy/oJDCSEu7B3dtoFEs0+HpY0DpvrukE27dnzG
         oAMCRwJf/cQQqh5k9M7oKPNzZ+9NCPsE53I8d7mOHCGJfSjBYT0n0eGCP3o0VZPubfmV
         8BYCAW/JgYiXm8mBsQeUu7tvMP0D4eYnP7hb5jLADWfmrM8DfLrjAdwxhqv4NLEGDHMq
         Z61Ukcsj6LluZ3bWwRNefpdwFzGVBNok40Jg8fzWaMBWdfxpaIuzLXgcTldonp3w4xF0
         +x/A==
X-Gm-Message-State: APjAAAUah73HOpT+geGLJb6VunECz+0elicSN49lBwiVTXOExF/4Yvlt
        rkf8O4KnUFHIPSqpQbnOuvO68iZ25WU=
X-Google-Smtp-Source: APXvYqyRhDa/k19v50TeoklOHPRbQ9KG9CkoSVUmS5r9pu4QufqxswN8EIIyJ5+lLSHPfpYdk8tLcg==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr33084037ljg.33.1560558009031;
        Fri, 14 Jun 2019 17:20:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y6sm826946ljj.20.2019.06.14.17.20.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 17:20:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a25so2844295lfg.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 17:20:07 -0700 (PDT)
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr15984142lfp.44.1560558007274;
 Fri, 14 Jun 2019 17:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190529125220.17066-1-tiwai@suse.de> <20190529125220.17066-3-tiwai@suse.de>
 <20190613174938.GA260350@google.com>
In-Reply-To: <20190613174938.GA260350@google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 14 Jun 2019 17:19:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOsDgne-Kc=d_RsiNzkBa7OZpXW-JA4+XV9Z+dfOS4j6A@mail.gmail.com>
Message-ID: <CA+ASDXOsDgne-Kc=d_RsiNzkBa7OZpXW-JA4+XV9Z+dfOS4j6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mwifiex: Abort at too short BSS descriptor element
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, huangwen@venustech.com.cn,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Jun 13, 2019 at 10:49 AM Brian Norris <briannorris@chromium.org> wrote:
> "element_len + 2" would be much more readable as "total_ie_len". (Same for
> several other usages in this patch.) I can send such a patch myself as a
> follow-up I suppose.
[...]
> It seems like we should only be validating the standard pieces (e.g., up to the
> length/OUI), and only after an appropriate OUI match, *then* validating the rest of
> the vendor element (the pieces we'll use later).

So I just decided to send some patches myself, for both of my notes:

[PATCH 5.2 1/2] mwifiex: Don't abort on small, spec-compliant vendor IEs
https://patchwork.kernel.org/patch/10996895/

[PATCH 2/2] mwifiex: use 'total_ie_len' in mwifiex_update_bss_desc_with_ie()
https://patchwork.kernel.org/patch/10996893/

I'd appreciate your review.

Regards,
Brian
