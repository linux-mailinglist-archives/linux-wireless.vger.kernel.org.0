Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6B1022FD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKSL2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 06:28:14 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44085 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKSL2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 06:28:13 -0500
Received: by mail-oi1-f175.google.com with SMTP id s71so18539692oih.11
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qZUkdERa19XKUHv80zulygyvcAoPf+8g3SFD9wVndiw=;
        b=BbkxAtojGMrSxzzQtT2l/irzAdSDy3jzSPOCo5u1jME2Ix1NSF0sWuHdZHoz0tbziJ
         TWc3loecKUK+HDBjyXl4Ms0jeNMdbp36ZJmoDnHfHLUNF+p4htT5zwLzKvzLDs0UeOjH
         11BEGqVN0a/3vWgYLtcDRGdKdVWVth6LvkhG6n9FIs+e0R0QOZUZ8CMCvQM/mjgPXV6Y
         YYFwjmjN55b3ygitYTtF+EMXTQm3ja7x0NDf9cAETc+qwK6AAJRIpKMh0UK4ylOVhFXa
         wdJ03hD8SkrBZwH4anS9y7s5Iq5jKigCCDRwPBuOuqz3m9FtKkixInkl+bDBhkoSHlHr
         VYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qZUkdERa19XKUHv80zulygyvcAoPf+8g3SFD9wVndiw=;
        b=rt3OcTvyZLGAmq3Ik+OMsrAk2n2SjXuAjslyA+TXJMCAzLsMn4bH+2LU7dSDTw/V9t
         9/vwbQpE/D97gmf+K2/Ge/aaNmDu4ocfLhyxQiwOFKA+uDGDyLSCw3joelZc0D10YN+Z
         F7CeHuQlsCa5s7S68IBsEHSbHH1XPwaq4dnmzK4/ZH0UiOUzr/qqueR/Wa8HsInYROD3
         3pJwo8YhVHiaQrwQ4A6xwI4LoNE4ln2kixwfgEPnXwMFm3WiJE2xF5I+Y248nCXrTp0l
         ccnyuEwfxnHC8EShXGm8SRcfV/byXK/jgGAtleiJ4YhZGfnhtwOJldaaOi0XHUU04Fqb
         AtpA==
X-Gm-Message-State: APjAAAWaZiUH/E/WPLU6gcTiqUhxvNXllIwgH7w2xICbJel1AfSVPAAZ
        EAezvUYiYDlAKAdZUSuokNGDWGnRxMRZ84yZgvtKjRd4
X-Google-Smtp-Source: APXvYqzoNhANHNLwQ8tXNr5IBkCINE4vq7zkLOvPJYexaypZ1nqJyMHEp2PZqcpwNfeIws5D4nVmgw0W5pHtmLZZlRQ=
X-Received: by 2002:a05:6808:d:: with SMTP id u13mr3661214oic.155.1574162892563;
 Tue, 19 Nov 2019 03:28:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Tue, 19 Nov 2019 03:28:12 -0800 (PST)
In-Reply-To: <CAKR_QVLaRKOc0OapvhppCZzYYO+w8h8t+B1amiWGGEiH6FmnjQ@mail.gmail.com>
References: <CAKR_QVLaRKOc0OapvhppCZzYYO+w8h8t+B1amiWGGEiH6FmnjQ@mail.gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 19 Nov 2019 12:28:12 +0100
Message-ID: <CAKR_QVKxoy+2Nt0SB42nm2Js-V4Cy8PdqEO3w2-xJUt7yR8bJQ@mail.gmail.com>
Subject: Re: [BUG] ath10k: CPU scaling related performance issue
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

quick update:

could not reproduce this on another machine; setting all cores to
lowest state (1.40GHz) and measuring at speedtest gives about 25Mbps
(ubuntu 19.10 live boot defaults), same rate is measured on win10 or
any other ubuntu version with ondemand governor

the machine this has been discovered on is compaq 6735b (it is running
turion x2 ZM87 CPU)
i can reproduce download results difference with ath10k card
connecting to an ath9k 2.4GHz AP directly (without litebeam as bridge)

one more thing discovered: while testing this on ISP's bandwidth test
site the dl speed increase was only reproducible when loading SSL
version of the site

On 14/11/2019, Tom Psyborg <pozega.tomislav@gmail.com> wrote:
> network topology:
> 80211g uplink - 30Mbps is brought into litebeam-5AC that is running AP
> (WDS) mode on 5GHz radio. client device is a laptop (dualcore 2.4GHz)
> running QCA9880 card on ubuntu 10.04 with kernel 4.9.
>
> description:
> booting ubuntu defaults to performance governor (personal
> modification), opening speedtest.net upon boot and measuring
> throughput gets me about 25Mbps download speed.
> setting lowest CPU scaling freq of both cores (600MHz) and repeating
> the speedtest gets about 29-30Mbps in download. i have verified these
> speed differences while downloading several iso files.
>
> confirmation:
> identical results have been observed on a live booted ubuntu 19.10
> identical results have been observed on ubuntu 10.04, but using
> ethernet connection from archer c7 that was connected in client mode
> to litebeam5
>
> ruled out so far:
> -using regular AP-STA instead of APWDS-STAWDS interfaces does not change a
> thing
> -switching to Ben's CT driver and firmware had no impact, the bug is
> present with it too
> -using different card QCA9862/QCA9880 behavior is the same
>
