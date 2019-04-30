Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6518106D6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 12:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfEAKM5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 06:12:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34747 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEAKMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 06:12:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id s7so12421791ljh.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 03:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ioGPC5F7kySeobmuzWBh6iE9/oKQDUZgPGo93PVH0jQ=;
        b=BsGtiS2FoYo/0e7ORxkInfsqIs86JM1Gk9mceUNFZr38Ro+KoZwK0lYPmAsDH+xsti
         emicngNgP/ExxddSBHvah/k0J0izVf/2g39RoXD73PGKqlsqGbe3Fm6EgpEcu/LYvCf6
         2MNmtnsYrT6BJdPua2CUY63+eJCQeS5XsnNBgcMG7OT2YtQmbTpBs3yUJAPK+/ujjS82
         uvc1mNRph5kaJZ41S+rfZms2owXLNQoo2jmgB+dBDzGbT8qxpIOqBSn+lQ5p9YAqA0+w
         23Qfdrz2P/1L8oxKO0UwyB/CebHsdklyGvIIboCwr7DjeygFKU0Y6Qxbiofq02b+il8o
         yBrA==
X-Gm-Message-State: APjAAAWlryPxTCSnbkuYYysvPSdbGWunmk7R3Pnpf7acakWJqiMrAxpP
        ZtO6DqJmvQfS9UtlC9aw3SiHTtZzY1c=
X-Google-Smtp-Source: APXvYqzB5hQdBlAoZeR0itfmJnETBTWladOgJ+jZTG7V91oV82uNg5XMqc3KmWikaNDo0zoQ5XUosw==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr38849623ljl.7.1556705572672;
        Wed, 01 May 2019 03:12:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id z17sm7997581lja.26.2019.05.01.03.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 03:12:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 002071804A3; Tue, 30 Apr 2019 09:49:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>,
        johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: Re: [PATCH] mac80211: fix possible deadlock in TX path
In-Reply-To: <20190427204155.14211-1-erik.stromdahl@gmail.com>
References: <20190427204155.14211-1-erik.stromdahl@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Apr 2019 09:49:29 +0200
Message-ID: <87k1fcnd9y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

> This patch fixes a possible deadlock when updating the TX statistics
> (when calling into ieee80211_tx_stats()) from ieee80211_tx_dequeue().

So is this the fix for the issue with TX scheduling you reported
earlier? :)

-Toke
