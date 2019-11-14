Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F4FD129
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 23:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKNWvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 17:51:44 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35166 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWvo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 17:51:44 -0500
Received: by mail-ot1-f54.google.com with SMTP id n19so2591089otk.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TPgz0rUKVntORJhLPj9xR8L0iEI2kaJ+YyJ/86/30+g=;
        b=BhHQz63KkM1O5peMOee7i1hdDiaxgUINFALCt6oUZjfcFlgX2hDR6+ZqTOkd3P25DQ
         zUCDaiGEr6K/paa0poxmvcR0N37kGpD9+8d8fUNjJdPmM81hsUnHvsP3HcN4cZWlLnxi
         jVxUZW351PpO7GIakKU9JscyiQB8xmuO3AvrXT36v4fKTE9vjryGaSCRyW8u5ThXcBrK
         6piXdWyF2zuxruoyK1WATSDX6U9xsIEVwCNorby5/eEe0e9NciF+F1PFP2S0F0EZvtMP
         jmj15rHqMEtjFH3uQMNxrdZRokFeI4pKaO0wp6v6vihNESIzVQcEiIoFTnS7S0moXzRp
         9IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TPgz0rUKVntORJhLPj9xR8L0iEI2kaJ+YyJ/86/30+g=;
        b=tq2eOMaupbymQT/tEVyvEXaUraeMO1OBet2OW9DChhvcjzXkA+3CiW3vBuTKCrTzii
         a2KoGv2WX6+1Kp3LH7R4yP4fTpyyBMkHSPJJmgZxRaBz6xNl6rsjiDYm+w7hjt4iLxOh
         9tUvEzOOH8qPEFo7sX8gxF/bmCsv3xMysqKZQhC3dyfqC7jUM7BSX+5DF514worEhU3q
         t53ufo+Z7K9s6sHnR5cW2t3vIHw2NAi2SN6N3qCMvJM7r3+Ph9hRqlm0DcbI9yXtw7+8
         ShRuuYjy2zLbM/64HpIiR3vYrVZYwiUjeuFZrdY3alGb1efz83B01iQAROBwqURiFg2J
         Kc7w==
X-Gm-Message-State: APjAAAXfUBPeLRUCHAZBkTE1hY6z88GLA2XzOF3J27fR9qmRRNOZGuwt
        u/PjwK5gT43HfcrXkchX4K3ZxxALurZSplc5rB+w6mqJ
X-Google-Smtp-Source: APXvYqyUf/J5GFd0uKAH5+8Z7iDnWI7ZQpfLRL07Voy8JpEWeRw/6jSumTqHl7jeZ+JlNshIhIlSlFUeKtWejWeCowY=
X-Received: by 2002:a9d:68c9:: with SMTP id i9mr3162445oto.265.1573771901939;
 Thu, 14 Nov 2019 14:51:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Thu, 14 Nov 2019 14:51:41 -0800 (PST)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 14 Nov 2019 23:51:41 +0100
Message-ID: <CAKR_QVLaRKOc0OapvhppCZzYYO+w8h8t+B1amiWGGEiH6FmnjQ@mail.gmail.com>
Subject: [BUG] ath10k: CPU scaling related performance issue
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

network topology:
80211g uplink - 30Mbps is brought into litebeam-5AC that is running AP
(WDS) mode on 5GHz radio. client device is a laptop (dualcore 2.4GHz)
running QCA9880 card on ubuntu 10.04 with kernel 4.9.

description:
booting ubuntu defaults to performance governor (personal
modification), opening speedtest.net upon boot and measuring
throughput gets me about 25Mbps download speed.
setting lowest CPU scaling freq of both cores (600MHz) and repeating
the speedtest gets about 29-30Mbps in download. i have verified these
speed differences while downloading several iso files.

confirmation:
identical results have been observed on a live booted ubuntu 19.10
identical results have been observed on ubuntu 10.04, but using
ethernet connection from archer c7 that was connected in client mode
to litebeam5

ruled out so far:
-using regular AP-STA instead of APWDS-STAWDS interfaces does not change a thing
-switching to Ben's CT driver and firmware had no impact, the bug is
present with it too
-using different card QCA9862/QCA9880 behavior is the same
