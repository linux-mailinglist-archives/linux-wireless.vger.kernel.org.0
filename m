Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880829AC1E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899928AbgJ0Mbf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 08:31:35 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38897 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411742AbgJ0Mbf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 08:31:35 -0400
Received: by mail-il1-f196.google.com with SMTP id p16so1326578ilq.5
        for <linux-wireless@vger.kernel.org>; Tue, 27 Oct 2020 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NX3aMd8nOxmdYv1FMvBjyoMjhVdlhBSOsPMwKR/CR38=;
        b=BNIE5eBYuI7rcpMZ7Fc8fXqliKjnQxcjorZNJL1u/wBpIhZBPNm/oj2C1C6ZdxZGqP
         uAYGC/mtPEyUM4jNLBnAm4jxr4genpcgGd/TQ/ERBwsmskt1N17w//1kmUAuHUDUnICN
         NTh72+99x21FAoc2Rb5wYJc0zP7/BuMc6mdP6YIeVMTXUp09DbbKqxyiR0QbSxt9Uh9M
         PDmkAegg3yxK47MX7sNkSW2kPFFGSzm9nBayI2anXHD4KkqoCRkjPLjI9snUHdRjVihA
         3vXx/MIX6pic4UTKz+mgxXOAbcTQne8C0eTtk/Ce5Xpl2con9KqsduAuDGrmvbvUEpCw
         056w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NX3aMd8nOxmdYv1FMvBjyoMjhVdlhBSOsPMwKR/CR38=;
        b=lXTXXf7bq/hrchWflTcI1ahh5AWdxRxZjdkPm/5VNuX+1uHBNDccvH3mFAAVEBv/NW
         l4oJkU2Fuou+PuIZnG2HOvVXr08o7ZGdMKLcRjMPRaPzOsAQh72ObFsyD6hn+niOAO7M
         OGb7OSLZ2Hak8LSXhg7dOuqFx1Qd0EsEq7hruxBXhXpn3F+mXAFBRjMxXnyxfQN5kYgu
         4RICbwjUWugrqU+xzCiMadL/bdnYYafaFtRAVYL7//Y7Y50cx456FOM+qrZkS0dtd9p0
         aS3OE8jic49cxtDCALnLz7K4Mv1RmxAsIf/DAZmGAiJZ4uqEsbeqG+JgpIYFmI6C7USZ
         DjbQ==
X-Gm-Message-State: AOAM530Pz9yaR6/cpMhxY0BSnEgfhP6lg0QrDFKXkwgRfLlQMTWnu4JM
        9MFeLY8SNnpZUXhEk+o6ldF9dDfTJE5hB168bfrwPA==
X-Google-Smtp-Source: ABdhPJwb/TNwFu+jrjo/IlYtjsGVcMMEoaPtXivWlxQC5lx3nfvrKZa3AsaqBYz1meb28HW+GVasVy0wuSu9kPRfM0A=
X-Received: by 2002:a92:6504:: with SMTP id z4mr1446561ilb.282.1603801894156;
 Tue, 27 Oct 2020 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201026150851.528148-1-aleksandrnogikh@gmail.com>
 <20201026150851.528148-3-aleksandrnogikh@gmail.com> <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
In-Reply-To: <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 27 Oct 2020 15:31:23 +0300
Message-ID: <CANp29Y7WOFZ-YWV84BucHvFRg628He+NDsGqCZfdsn_crwVW2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: add kcov handle to skb extensions
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 26, 2020 at 7:57 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
[...]
> If the handle does not need to be set if zero, why then set it if the
> skb has extensions?

The point of that condition is to avoid unnecessary allocations of skb exte=
nsion
objects. At the same time, one would expect skb_get_kcov_handle to return t=
he
latest value that was set via skb_set_kcov_handle. So if a buffer already h=
as a
non-zero kcov_handle and skb_set_kcov_handle is called to set it to zero, i=
t
should be set to zero.

> skb_ext_add and skb_ext_find are not defined unless CONFIG_SKB_EXTENSIONS=
.
>
> Perhaps CONFIG_KCOV should be made to select that?

Yes, thank you for pointing it out. I=E2=80=99ll fix it in the next version=
.
