Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE962B9B6A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgKSTU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 14:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgKSTU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 14:20:57 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4100C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 11:20:56 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m143so7549795oig.7
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYiWAA3LgHVsZoxh6C876qDcBmjIQV3sgz0n1BOWoYo=;
        b=QEoytVRc08esZgrtVj7ByRb1Sg4mzI0VLkGfZcL0Svzs4mr69Ik06aZmbYI2UpSh4S
         YuVkEQK/H/09nHrIn4HdeTFcmWrET9XW4cw8ae+HPs0QlgFVwDCms4tZr1sWBaZn560N
         kAE4HorNaz7LjQQ+GPx6MY9aGpneUDWum4LE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYiWAA3LgHVsZoxh6C876qDcBmjIQV3sgz0n1BOWoYo=;
        b=oAP2Yx97BWTuDHhR7ZM1uJ+wiYnjprp7fFJCUZ8Unhv+rwCDNT27fuOCtPfabFLaBg
         tSLSU+T5QQpGjrhqP0Szj8SWzqRYFWCPuldcG4SvDjQTacxZv0+I3rcnuyZ/2k2O/HDz
         gJAAgLWbP+EJa5Hzjxja5dcVRJOm71FScfbPHqRDO6itMjHiFDTkkBZZZBjFzd6rwtZ3
         /99VBmprjbNkAi33Zfb2DacWVVZ5Y3mUYyZt74FtthQtIQ+p44LkwVG+/K2jsGv8Q+lU
         8NNggAQr9MdTERGDBFv4Hbg+5o/NVI1uKmPJMu4QR8h15qZGRgZxjDhsiiIrZDKmZUtg
         Qbzw==
X-Gm-Message-State: AOAM533ADiVX3SJKrQwNyndD2jljdOHFm+apd85LTZMeiJbM64uu+iUc
        oiseSPeAPnAZkT8JzzJSMhFqMCi4aYpGng==
X-Google-Smtp-Source: ABdhPJy/nPHTd1vS4T0cBVL93MPaLI0gPj40Z86xBBN1p4SHb9c1FlfrSp4vU2+FM03R4pVqCOCreA==
X-Received: by 2002:aca:47c7:: with SMTP id u190mr3946438oia.68.1605813655190;
        Thu, 19 Nov 2020 11:20:55 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id s9sm51228otb.6.2020.11.19.11.20.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 11:20:53 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id c80so7603005oib.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 11:20:53 -0800 (PST)
X-Received: by 2002:aca:750d:: with SMTP id q13mr3986829oic.77.1605813652821;
 Thu, 19 Nov 2020 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118033936.3667788-1-briannorris@chromium.org> <DM5PR12MB1801E9BD703DB5E6381CF602D9E00@DM5PR12MB1801.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1801E9BD703DB5E6381CF602D9E00@DM5PR12MB1801.namprd12.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 19 Nov 2020 11:20:39 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNoVq6JBsoEHHsXT0Aps=SgLw4f0W8EMCbkp78vcNCLxw@mail.gmail.com>
Message-ID: <CA+ASDXNoVq6JBsoEHHsXT0Aps=SgLw4f0W8EMCbkp78vcNCLxw@mail.gmail.com>
Subject: Re: [PATCH 0/4] iw: add HE capabilities scan parsing
To:     David Poole <dpoole@cradlepoint.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 19, 2020 at 7:06 AM David Poole <dpoole@cradlepoint.com> wrote:
> I'll be happy to help test!

You're more than welcome to :) Feel free to reply back here with
positive or negative feedback. (And if positive, might as well make
that a "Tested-by: Your Name <your@email.tld>".) I have more HE
clients than APs, so I only have limited test coverage for the "scan"
part.

Brian
