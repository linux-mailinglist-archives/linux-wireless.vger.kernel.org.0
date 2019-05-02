Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6284E121D7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBSYN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 14:24:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37823 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 14:24:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so2613557lfh.4
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2019 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+j627VNtYu9oTIOSNUI61HYi4gX8hdlesITEjnAgcc=;
        b=e2DXXOcnaOQdTc8G1Ffgclt3BIrHSiZK7pNjYbYL9UkogyY3SqnJPWabSYkyrgT8vi
         7/koh8Vd4xDT198WPDBmWETwJcTq/GcpJWUwGYVL6/tf5fZ0lShHtXph0xhxN45HQRFm
         VTbhoP2SaZbfKTL0rRc0EK+gnJfsVt6Rx4v1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+j627VNtYu9oTIOSNUI61HYi4gX8hdlesITEjnAgcc=;
        b=iQZ/PjbzfGGo9oqKAbFLzSfgcpTGi8EaSUO9Kya8FsLBw6SR9S4/k0Wc14VfQMw6Ku
         x7FhwfeblZ1ZabhzgnySI/FnKUPVbcOF/3D5cDzB8U+Y4yIxRsRRRWPn7nHTrAIikq90
         3bEIYS9NGIrCtaUtVZiZtG1iltY0EOI5DQPOFEnbWo+xOaJiJhteqFeIq4jwNYxNUWt6
         08m+wWnsZcYGYc/ONtOoQCdz4TKu/X21r7+EjgIdFz/FZknDLRgZJ7u/ZlxXp5mWD27K
         XPflzsY5Z5JSU1AgKvIYFK+oXOiy8I9XrSppPH8z2HKFBQn/LgqXNmQ313pqfNwqE+2Y
         Bh1Q==
X-Gm-Message-State: APjAAAUiidxbcOenU0G1D/Fh4s596I0bHTpAjYFLD7t1Hz28elsvqetu
        v+fBqf1iGPMvvbhraeNSTWTlSi3L5Pg=
X-Google-Smtp-Source: APXvYqyjJtDc3GqJU9D+P3ykebLuMM/4sa9ENESdmefZARyg5jy/H2xW6fRW3mMUstCSGl+KvmBkNQ==
X-Received: by 2002:ac2:4205:: with SMTP id y5mr2733434lfh.15.1556821450485;
        Thu, 02 May 2019 11:24:10 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j27sm9554951lfk.97.2019.05.02.11.24.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:24:09 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id e18so3090431lja.5
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2019 11:24:08 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr2673440lja.68.1556821448424;
 Thu, 02 May 2019 11:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <1555653004-1795-5-git-send-email-yhchuang@realtek.com> <87bm0npsp7.fsf@kamboji.qca.qualcomm.com>
 <04c534eb-af32-adfc-62bb-90d83526af1a@lwfinger.net> <87a7g6ni31.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87a7g6ni31.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 2 May 2019 11:23:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPB3_uhg4dkoQBk+33E0kFay_BnHXKyudyhvorePuH2qA@mail.gmail.com>
Message-ID: <CA+ASDXPB3_uhg4dkoQBk+33E0kFay_BnHXKyudyhvorePuH2qA@mail.gmail.com>
Subject: Re: [PATCH v9 04/14] rtw88: trx files
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Pkshih <pkshih@realtek.com>, Andy Huang <tehuang@realtek.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 1, 2019 at 11:30 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> My comment was about handling firmware commands and events as a byte
> array, not about bitfields. So that instead of accessing 'index + 1' and
> 'index + 4' you should create a proper struct for the command and access
> it using 'cmd->foo' and 'cmd->bar'. Sure, bitfields you still need to
> access using FIELD_GET() or similar but having a struct for commands is
> a lot cleaner approach. And most upstream drivers do this: ath10k,
> ath6kl, iwlwifi, p54 and whatnot.

I think I pushed Tony away from the bitfields (he was using a struct
plus some ugly bitfields / #ifdefs pre-v8), and he ended up with this
(in v8). I noted on the v8 cover letter that one can still use a
struct, but just avoid using bitfields -- so you would still have 'u8'
and '__le32' fields (or similar), and do the right le32_to_cpu()
accessors (sparse will help you) plus FIELD_GET() (for any necessary
bitfields).

Brian
