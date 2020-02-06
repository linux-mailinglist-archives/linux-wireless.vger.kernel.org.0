Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574531542A7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 12:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBFLIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 06:08:17 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:40365 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFLIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 06:08:17 -0500
Received: by mail-io1-f52.google.com with SMTP id x1so5838232iop.7
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2020 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NfptxjaStYrkEGbe/gRNZpHFhG9VdM3zlMBB+L7NlbA=;
        b=aK8mQQ7N+LiJWLXTB/ZA59FCckRgTP4BbvZu4evNDbQGA17KBO0giVjoWUVliHUT5a
         O5uNgGcZoAmN3Se46pbzkLoSp8yRcSnENkHIbIznwlciVY1pvnXn2aYqbUXiSOUfF4OH
         nPQJCjFU/GNbYH1LK8TUC10J2a58HP19eYb1H2M5Qpt2urrLiqgcRKfpYxrcDyV0RmSg
         eT/9P0kG2JMkkAORDyNRw6ecST2VzertnOcf/iUYAnuULIDTvgUbIS1QKuMjhSW81a63
         2QojjiwkfJMvHhnzCfRwY5M2IOXsFVT53nBz9geMZA0pt8JDMTixpiiXPHvXfQs8LzT9
         yrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NfptxjaStYrkEGbe/gRNZpHFhG9VdM3zlMBB+L7NlbA=;
        b=rOlRNnIBy0flKWqcqB+4CwZDKsgzIVZ7zLMZvsKRDDOkAA1GfFNCiQHtSsF/4xsqR8
         K3GUHuyyXmBB+k2vH/aiShpgZMF6++aDRtVlxW85ysgnRorVXN+xWCQIC95sINpLaCqA
         5ykL7qXWaaz22lprE26DlCXb1nnEZXdmgxwxFlGj2XeeYiZ3DhET3P0bb350zrofsTDS
         6DK3LlgrSiRjYhDH01tD2F9sEjoP3VVmxrPRpT3Af1FJWOBq0QarXDVkyap5ezHfCk5b
         dzwPtSZUcyjcS8MWnwKL5doZkKQjwkZ9MFlJau/r1QaOnBQBzH42n6igfR3Khy1oqZG2
         5MHg==
X-Gm-Message-State: APjAAAVTbSdDIFciLiAZ1mELw/q/w6/2pdKBJ+0swbP3cNJl40VNQDL+
        4Eicl7XqHmZWvi7f5SS125jRrT+BzWbMg5CHBOC6inwo17w=
X-Google-Smtp-Source: APXvYqyzOO9WVp758wGEQcI1wbuos++1VVWc+oNjIIEznjeZySIEQETSf6AvpR9MVNacQLny6yiqQMn90P+GQrNI1dI=
X-Received: by 2002:a02:6055:: with SMTP id d21mr34700826jaf.21.1580987296827;
 Thu, 06 Feb 2020 03:08:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Thu, 6 Feb 2020 03:08:16 -0800 (PST)
In-Reply-To: <20200204081435.zhzqtsnrcgkzhpdw@beryllium.lan>
References: <CAA=hcWQuz9QTvbRJgFXBbYrB9RBmWajCJ=oD49DyEaLw91t2bQ@mail.gmail.com>
 <20200204081435.zhzqtsnrcgkzhpdw@beryllium.lan>
From:   JH <jupiter.hce@gmail.com>
Date:   Thu, 6 Feb 2020 22:08:16 +1100
Message-ID: <CAA=hcWQ780vCx8KkNPqgmtbzxqZbrGnZx6zghr0PAwhG3o4hng@mail.gmail.com>
Subject: Re: Failed to can wifi Invalid Sched_scan parameters
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Daniel,

On 2/4/20, Daniel Wagner <wagi@monom.org> wrote:
> The 'Invalid Sched_scan parameters' indicates, wpa_supplicant is
> providing the wrong parameters. Best thing is to monitor between
> wpa_supplicant and kernel the netlink messages. iwmon is an excellent
> tool for this.

Thanks for the tip, I did not realize that connman is actually heavily
relied on wpa_supplicant, if I restarted wpa_supplicant, most of time
it popped up mwifiex_sdio messages, then the WiFi could be up:

$ systemctl restart wpa_supplicant
[  371.617417] mwifiex_sdio mmc0:0001:1: info: 2
[  371.647545] mwifiex_sdio mmc0:0001:1: info: associated to bssid 34:08:04:12:y
[  371.726667] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
[  371.772758] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2

But sometime when I restated wpa_supplicant, that message did not
come, the WiFi network was still down.

How is mwifiex_sdio related to wpa_supplicant?

Why it is nondeterministic, sometime restart wpa_supplicant could
bring mwifiex_sdio and WiFi up, something it couldn't?

I think mwifiex_sdio is the lowest layer to interact to WiFi modem, in
which circumstance it could bring WiFi modem up and in which
circumstance it couldn't?

That is far too unstable, I always thought I could rely on connman for
WiFi connection stability, but it seems that beyond connman capacity,
so what I can do when the WiFi is not up when restart wpa_supplicant
could not fix it?

Thank you very much Daniel.

Kind regards,

- jh
