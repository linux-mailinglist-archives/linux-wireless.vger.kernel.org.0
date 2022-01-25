Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7C49B606
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jan 2022 15:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578484AbiAYOTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578211AbiAYORF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 09:17:05 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E202C06173B
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 06:17:03 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id hu2so25271592qvb.8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcwrY98PeaNjLrLBVr1+i4LjDqsWDo4k0IbHruqFyc0=;
        b=CoRqXYU89a2tD0HilRDXsf3ao2j3UrxRd0eGwsVuE6RXaKI1Xl+q/WK2cfLiV2kuHJ
         M5On0lkWIRTHuOxSHwfIlzQyTTUDB8h5BOnE59gLXAqJQHEXGGILpI1zBLroXZU43jol
         zT0QKubLS3IPcfTGoKKFi6PYj4gKEa5KjoqNFSCwYoNrL2rXwkS2wfNPrKSrykkR8MaO
         rdohEsrRanZUzguLIKii9g5Xkh822RTboAnQ7pcoqffIt7NY/NeFEJ5Fii4wtX6cpAsr
         XiyvPLtI/8aA3kb9cfSWMuA7WEQQP4LzF+FaJr/lbrLa4hKaYPKQ1KMXWE96z92Q0KI6
         hUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcwrY98PeaNjLrLBVr1+i4LjDqsWDo4k0IbHruqFyc0=;
        b=f3h2kpWMWI/0zH21XXm/JdEiI7vp4tctkPse+pLF3siWCTX+Uo5ZmShEZT/27ZpnlA
         ouGdmx6EeJdV0ugtcBgs+N6GXHQj9/cmsouf1ahoABPwK4Xyf0PQueLIHGg3tnSeRIjd
         U6eKnLDS31oEDIrHyRrdyXnlTMnG1lu1Z6eLXfKc4mnBeU/s2JgE468r3PnMqaeHrE4l
         AmX9dsfVb4A9Db7xCf18UIMm7pJqjckKvEgTQ7TYzE0A/rKo2WEmKoCFZKTSp1lS4Z4v
         8Tnr0URHtBq2jFKH2AUlpXiPk3nwbxn3SehLwZa8x6jkGq1FwxY84u2fHclAU2doNeCa
         I2Gg==
X-Gm-Message-State: AOAM533uZqqgGXUVE1iNj9RNT8P6SVyodjJLjgM9YQY35oFOPBTl9419
        0xcJPlT5atnCj62my6SUal9tvuWuvIzmJ31Jy9aCpQ==
X-Google-Smtp-Source: ABdhPJwB/Yz/dvSFqh8Csk93geedfR/oi+I8iXdNHEmIRWDzYS7BkYHepDA2DJ8o9bJmXZ0v0OIxQiawf/n1sWOfM6k=
X-Received: by 2002:ad4:5aa2:: with SMTP id u2mr8745370qvg.42.1643120222389;
 Tue, 25 Jan 2022 06:17:02 -0800 (PST)
MIME-Version: 1.0
References: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org> <20220120095622.1938-1-mike@fireburn.co.uk>
In-Reply-To: <20220120095622.1938-1-mike@fireburn.co.uk>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 25 Jan 2022 14:16:51 +0000
Message-ID: <CAHbf0-HLCcgZfbKdWQ-kX+QbRGJsEHCEDnG=NZ5QF71aTeDMGg@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
To:     khalid@gonehiking.org
Cc:     Deren.Wu@mediatek.com, Eddie.Chen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Eric.Liang@mediatek.com,
        Leon.Yen@mediatek.com, Mark-YW.Chen@mediatek.com,
        Soul.Huang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, YN.Chen@mediatek.com,
        abhishekpandit@google.com, ch.yeh@mediatek.com,
        frankgor@google.com, jemele@google.com, jenhao.yang@mediatek.com,
        jsiuda@google.com, km.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name, posh.sun@mediatek.com,
        robin.chiu@mediatek.com, sean.wang@mediatek.com,
        shawnku@google.com, steve.lee@mediatek.com, ted.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 20 Jan 2022 at 09:56, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I get a BUG and the kernel resuses to boot with this patch when mt76 is compiled into the kernel
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214557
>
> I don't see this issue when mt76 is compiled as a module
>
> My .config is at https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
>
> Let me know if you'd like any more info
>
> Cheers
>
> Mike

The bug I was hitting was due to a different change introduced in rc1,
with that reverted your patches work great

Though I am seeing lots of these messages from the bluetooth device:

Bluetooth: hci0: unexpected event 0xff length: 5 > 0

I'll bisect that next

Thanks

Mike
