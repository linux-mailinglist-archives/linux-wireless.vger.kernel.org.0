Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553F764DEB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGJVM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 17:12:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33442 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfGJVM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 17:12:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so2596617lfc.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2019 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwvajVWMIb62q8wACGYhWs29kEXd/GDO5w+T3eFYJVQ=;
        b=ix9E8oHqVOHHI7+NbnlUqfsJnN4HBLwyr0Jn9m3Tpk6LEOunHnYze3vGWP8/aAN+JQ
         o8Xb6a4lS1X88VxaIJw7qDyL2rtrdl8yPiVKxFJVDlBDzUn/5GBcvnogmRiipUUSaZ2A
         y62oVYOH++N07WuupIrdvk0x7owfObLe29Q5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwvajVWMIb62q8wACGYhWs29kEXd/GDO5w+T3eFYJVQ=;
        b=JZOwgrmbG4K1SSZl8xkDieFY2nAyQFR8p0pN7rh4dXqcmkmRnTRwfN8B5Rz2Bx060R
         RVhIRIyGjbRsVp9fqGzWQlzORrubFi3hM/kg0qUgZ9Ie6NVwsXniymkIc9x3JwrV22jX
         Cm1uKj6hq3Em5gdzormnnKTCIU2RTNGLAWH587rzKd36E3NrSge/IsdHwUpcKtTPKh0e
         Xh15Bj8XTgmmZz34InhUoHWBq0jm/CdZ7fPN9oMsUezXRhKlaZibd8iRiVz7NOZKfBsR
         7wbISnUN55UZMEZRZSSOZ4zWV8GMONYorksIAG/NqmaPMTkhcAL+TWhij4nF1nl3u8e8
         cj3w==
X-Gm-Message-State: APjAAAWYZ+X+bXSB2S4PFOFF8CdGVG/WivlKb9nIuY1FZ7hHwMx2Suzb
        jab540YC3s1XUqf/Y9e9YwTzm8RzxFg=
X-Google-Smtp-Source: APXvYqwMCrFYJ6E+XMGCTsuULfq3obJit/KkjwMbad+KMgITlP/NvaPoGRoAAh58Lio0bpFU8PME2g==
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr14819848lfn.131.1562793146670;
        Wed, 10 Jul 2019 14:12:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y18sm637278ljh.1.2019.07.10.14.12.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 14:12:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id s19so2553858lfb.9
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2019 14:12:25 -0700 (PDT)
X-Received: by 2002:a19:6519:: with SMTP id z25mr6190697lfb.42.1562793144979;
 Wed, 10 Jul 2019 14:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190627003616.20767-1-sashal@kernel.org> <20190627003616.20767-14-sashal@kernel.org>
 <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com> <20190710145112.GX10104@sasha-vm>
In-Reply-To: <20190710145112.GX10104@sasha-vm>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 10 Jul 2019 14:12:12 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPseNZkud1vu9zaRH-vA0rJq8D_t6pFG1LTPQtdr8_eVA@mail.gmail.com>
Message-ID: <CA+ASDXPseNZkud1vu9zaRH-vA0rJq8D_t6pFG1LTPQtdr8_eVA@mail.gmail.com>
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

On Wed, Jul 10, 2019 at 7:51 AM Sasha Levin <sashal@kernel.org> wrote:
> I see that 63d7ef36103d didn't make it into 5.2, so I'll just drop this
> for now.

Yeah, I think it's stuck at net/master. Presumably it'll get into
5.3-rc somewhere.

Brian
