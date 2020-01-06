Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D997E131B3A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgAFWUM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 17:20:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42930 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFWUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 17:20:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so37408166lfl.9
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 14:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=psNd5SDAxN8kmAqWfEDCIqtkY8hu3ItV7K5NPbyFLwo=;
        b=Nqy04B5+6dW3Vz2MsI7XBcQMGyo0gV428StwyUU65pBtZz+pJitCs4KMuNaXC7utwB
         XvFtBp4aU2G/cBue+xWQADJkOZhy6EsOFROTz7lFtYMs3ShZVIQ7PXzJac0RJRwg+jH8
         hVDXJMLEyiKZqGvGa+gztbROKIG8ekkL3M7iHR1Ex87EC+TNSDTgjSnv1MVCVrToBsu8
         rpgzUkAnnSgnYhfe0oe6RkHnBDEP8/chMvLd/gdvzN6OsoAWwH2UapnaVAOJJ8zbASRp
         SLJGIZKORZ2Cv2wUyEUWG7WoKAy1ZREeINeciKwINHtTkPyvPLV7yHdqrsQNJuKAxlhF
         kTlw==
X-Gm-Message-State: APjAAAWiLPciqw3NCwGDokDO9gFExZBXAnNf/DdjIAaVVV+ruZwuEEqu
        C75lGoNUhjm7TWPIMgBbCGotjybfq5Sv92K75UU=
X-Google-Smtp-Source: APXvYqy3vSWY4JvLwRKAiXT5YpGZiRCalqahNGOENEH6jPpVI90YArjvmaPMsfnwQXHy4HeZF83HNDZHWSawY1bAqXo=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr55159530lfp.162.1578349210465;
 Mon, 06 Jan 2020 14:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20191222172423.131033-1-toke@redhat.com> <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net>
 <87r20ck3x9.fsf@toke.dk> <CAJnXXoiyWKSLHqMzMcSzHBM-HhfYtcURW1hYd-3Yf7K00NTqgQ@mail.gmail.com>
 <87mub0k2cd.fsf@toke.dk>
In-Reply-To: <87mub0k2cd.fsf@toke.dk>
From:   John Yates <john@yates-sheets.org>
Date:   Mon, 6 Jan 2020 17:19:58 -0500
Message-ID: <CAJnXXogQCKQSLT+8_NnEfFd7MLc0=YxShvb4hY2Y+BDJjybQTg@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v5] mac80211: Switch to a virtual
 time-based airtime scheduler
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kan Yan <kyan@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 6, 2020 at 10:54 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> Yeah, we'd be doing the accumulation in 64bit values in any case; we're
> talking about mainly multiplication here (the whole point of the
> reciprocal stuff is to get the division out of the fast path). So how
> big of an impact is one (or two) extra 64-bit multiplications going to
> have on a 32bit platform?

Top line: usually replacing 64 bit divide with multiply is a massive win.

Many platforms make (32 bits * 32 bits) -> 64 bits quite cheap:
- x86 has this as a single instruction: eax * edx -> eax:edx
- arm has much the same, plus a variant that tacks ona  64 bit accumulation!
- mips leaves the 64 bit product in a dedicated register; retrieval
requires 2 instructions
- ppc, being more "RISCy", has two instruction: mullo and mulhi
(performs multiply twice!)

Best case is when the compiler can recognize a 64 bit multiply as really

  widen_32_to_64(left) x widen_32_to_64(right) -> 64_bit_product

In such a case only one of the above multiply cases is necessary.  Otherwise
one tends to get multiple partial products and double width additions.  Still,
better than nearly any flavor of 64 bit divide.

/john
