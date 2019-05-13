Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C621B536
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfEMLqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:46:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34216 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfEMLqt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:46:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so409360wma.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=MQMtcXPbWQFD7gNVoU802mYFs0P70ei96xJMVgcVxUw=;
        b=nDXaPbwxR8NZNqdJj5hOmZzxGI/E3QaiqmVUza5jqgFzLvWWWP5Jyqxx8nY7k/nbMR
         1cOmMs3eQ/IGeq5bcTkdnzztveqL4oJgZVCe8Izl2AjvT0Pb/Bk8q+NxwtkX3sbYLOqy
         x69UcmX1tgccZ8q99pO9q1HDHdiyJn3HyLJPNoG1sZWrD4NrVO398sWEOL5lUc5x5rGk
         hhJuVQUDL6DpGGkzOp9pxoeN+3mGUlqfdC/jZmva1rJdY0SikrkcgN3JmRhyNC7Eemu5
         nMk1I4dsw5hoGwlvD6NudD4nj7a3IXmbQI0mo0/Ujz0AH8HF7BfqRyGZSRnDqYFDnczU
         p+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=MQMtcXPbWQFD7gNVoU802mYFs0P70ei96xJMVgcVxUw=;
        b=QgVOrOqGztrmOYZBJpIYfEw/bMPrZo2T6y0sobKtCxyNCHT1Z+44jXT0umpb7OJf7E
         d2ayfF9u9qgsvr00RlvvcNnG1HEwH+RQzZxckogoZnuUW8ovKey/nf9esws2BsqSxcjY
         8iD6VzsFszN1OVvmWFUyHJVVwQZ5TvcsDu9i8qqKpPPIcEUodQgBGulrl140fd+ZaOrJ
         qDS6C1KQTojfqhGocSkLgQ05V75v+lV6U3bYNpah0q8NN93LltSGr2/8AsykVe66aQCe
         xsJehvPSDcTkiNvjuSwcyOchZxdg58qVAGWqRIzbwoczgQzuLbUA1wF5Wx7u5hRsf4XK
         81yw==
X-Gm-Message-State: APjAAAX2ZQ6sQUKPzVpVT/h2QSV0UTzb/sFlCLT9oGyZLGRQeRSqmnIO
        Z9ydbke7qAieJnVYCkLkMQQE5d+w3iH10zAsP0g=
X-Google-Smtp-Source: APXvYqz/F7P58lUrsX+UaqNuWE6awO8d2zMbjz3tSExHr29ZgcsqrZ4r8WZTxCPb9JRshP5ndvosPZh94xxhHMeYcWI=
X-Received: by 2002:a1c:f606:: with SMTP id w6mr14378897wmc.130.1557748006902;
 Mon, 13 May 2019 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com> <CA+icZUUu6NmQoKS-2x32Fz388Q_ahXyYzLLf5JNm=mZR+r-0kQ@mail.gmail.com>
In-Reply-To: <CA+icZUUu6NmQoKS-2x32Fz388Q_ahXyYzLLf5JNm=mZR+r-0kQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:46:36 +0200
Message-ID: <CA+icZUWgQQ-h+e=fvb+yheZRm5NuL=YGMmVSjEnAizKPtMqhvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 1:43 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
[...]

> root@iniza:~# nfctool --poll -d nfc0
> Start polling on nfc0 as initiator
>
> Targets found for nfc0
>   Tags: [ tag1 ]
>   Devices: [ ]
>

That "tag1" was my YubiKey after putting it on the NFC sticker on my
ThinkPad T470.

- Sedat -
