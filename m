Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5A403378
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 06:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhIHExY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 00:53:24 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:60480 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIHExY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 00:53:24 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2021 00:53:23 EDT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 9A5C820D6C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 13:43:56 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id v18-20020a17090abb9200b001977b4087bcso535385pjr.7
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 21:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ndB6OnC/DWNYeSD9UQ4w6E+f8Jh1zitlZ7V2qrI4OOc=;
        b=ps7ldvUgKps1Z46Q5D0qBPiUmbdnhR7ePtLHl5J8PQuSPmWKt7YwdOxCIyOqdRtsb8
         uWIXasOBRjHoO4XTLOhm5ss7RX4W3j1+uen7HZasNfhJgdYmAdOLTak4PAyRRSKR4w69
         /xpgKWGRfxURizCMGnI/B49pG8qvXxIhZfUut3Uq6c1T0O8p4HwK3WlROdZ/IxT+RQyu
         X9yhVroJx0o13r4rVohCl60rNEBMQrwaM2ib+VvxgaoP544QfxeOiqwoG/9u0SZ836+H
         SAnXvw34iRBiJd9ToJ/EitwiXTqh6/eC5721LFmy0oYc3q9dlg4PxMunZYy8/hybuLJ7
         aKPQ==
X-Gm-Message-State: AOAM531GPYEV96IkXN+Ut3ohHemPptiTM6DRVK7uT7RWadic/GDZwGYa
        xIPpjw9DpHL2wlxsXDaqOnczNYLs2SsbJLOIe51YOYxTKDdbp0J9EQXJZeoCkhAQvSbPUVoLmbc
        61YizoAjplp1gIujh7vP+mpR1kiem
X-Received: by 2002:a63:720d:: with SMTP id n13mr1818353pgc.470.1631076235588;
        Tue, 07 Sep 2021 21:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypg23POAzBzzGu0TAq3M3FNbVHQxEqadwrpSN4emz8WYHOxGzmg9ZyZXA0Ya9AkvB5nibmDw==
X-Received: by 2002:a63:720d:: with SMTP id n13mr1818332pgc.470.1631076235314;
        Tue, 07 Sep 2021 21:43:55 -0700 (PDT)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id cp17sm574464pjb.3.2021.09.07.21.43.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 21:43:54 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mNpRB-00EI59-Ly; Wed, 08 Sep 2021 13:43:53 +0900
Date:   Wed, 8 Sep 2021 13:43:43 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: mwifiex cmd timeout on one pci variant
Message-ID: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This is probably more a question for the maker.. But maybe someone will
know.
I've got a mwifiex M.2 pci module that won't take any wifi command and
hang right away (dmesg below). Bluetooth through serial works.


Context:
I've got a board with an i.MX8MP chip, and three different marvell W8997
M.2 modules -- one from laird which works fine, and two from azurewave
which are labeled exactly the same AW-CM276MA 2276MA PCIE-UART except
one works and not the other.
The inscription on the chip itself are slightly different, one saying
it's a W8997-M1216 from marvell (works) and the other having AW-CM276NF
azurewave mark. The electronics around are also different.

I could say it's just a bad chip, but I've actually got two of each
(samples) which act the same... And I've tried it in another device
where it works with the same kernel/firmware, so there must be something
wrong on the board as well as the wifi card works elsewhere.


Anyway, if someone knows how to get around to debugging this, I'd
appreciate a pointer! I can't see anything wrong with the tools I have
here.
If nothing else, I can't read /sys/class/devcoredump/devcd*/data that I
saw Amitkumar Karwar request somewhere else, so just deciphering this
would be great help.


dmesg looks like this on failure:
[  108.513028] mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func: Timeout cmd id = 0x10, act = 0x1
[  108.522388] mwifiex_pcie 0000:01:00.0: num_data_h2c_failure = 0
[  108.528310] mwifiex_pcie 0000:01:00.0: num_cmd_h2c_failure = 0
[  108.534143] mwifiex_pcie 0000:01:00.0: is_cmd_timedout = 1
[  108.539631] mwifiex_pcie 0000:01:00.0: num_tx_timeout = 0
[  108.545029] mwifiex_pcie 0000:01:00.0: last_cmd_index = 0
[  108.550431] mwifiex_pcie 0000:01:00.0: last_cmd_id: 10 00 28 00 16 00 cd 00 1e 00
[  108.557913] mwifiex_pcie 0000:01:00.0: last_cmd_act: 01 00 13 00 01 00 01 00 00 00
[  108.565484] mwifiex_pcie 0000:01:00.0: last_cmd_resp_index = 4
[  108.571318] mwifiex_pcie 0000:01:00.0: last_cmd_resp_id: df 80 28 80 16 80 cd 80 1e 80
[  108.579237] mwifiex_pcie 0000:01:00.0: last_event_index = 2
[  108.584810] mwifiex_pcie 0000:01:00.0: last_event: 00 00 0b 00 0a 00 00 00 00 00
[  108.592206] mwifiex_pcie 0000:01:00.0: data_sent=0 cmd_sent=1
[  108.597954] mwifiex_pcie 0000:01:00.0: ps_mode=1 ps_state=0
[  108.604085] mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump start===
[  108.613552] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p179) 
[  108.621748] mwifiex_pcie 0000:01:00.0: PCIE register dump start
[  108.627676] mwifiex_pcie 0000:01:00.0: pcie scratch register:
[  108.633441] mwifiex_pcie 0000:01:00.0: reg:0xcf0, value=0xfedcba00
               reg:0xcf8, value=0x8260049
               reg:0xcfc, value=0x1282820

[  108.648584] mwifiex_pcie 0000:01:00.0: PCIE register dump end
[  108.654411] mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump end===
[  108.661119] mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump start ==
[  110.560689] mwifiex_pcie 0000:01:00.0: cmd_wait_q terminated: -110
[  148.127107] mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump end ==
[  148.134552] mwifiex_pcie 0000:01:00.0: == mwifiex dump information to /sys/class/devcoredump start
[  148.143669] mwifiex_pcie 0000:01:00.0: == mwifiex dump information to /sys/class/devcoredump end
[  148.152485] mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
[  148.158915] mwifiex_pcie 0000:01:00.0: info: shutdown mwifiex...
[  148.165829] mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
[  148.443761] mwifiex_pcie 0000:01:00.0: info: dnld wifi firmware from 169340 bytes
[  149.511193] mwifiex_pcie 0000:01:00.0: info: FW download over, size 632240 bytes
[  150.163677] mwifiex_pcie 0000:01:00.0: WLAN FW is active
[  150.231583] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p179) 
[  150.239814] mwifiex_pcie 0000:01:00.0: driver_version = mwifiex 1.0 (16.68.1.p179) 

I tried with two different firmwares, full dmesg and data.txt are here:
hang on `ip link set mlan0 up`:
https://codewreck.org/tmp/16.68.1.p179-data.txt
https://codewreck.org/tmp/16.68.1.p179-dmesg

hang on `iw mlan0 scan` after successful link up:
https://codewreck.org/tmp/16.68.1.p179-2-data.txt
https://codewreck.org/tmp/16.68.1.p179-2-dmesg

other firmware (dmesg truncated to just timeout message):
https://codewreck.org/tmp/16.68.10.p16-data.txt
https://codewreck.org/tmp/16.68.10.p16-dmesg



Extra info:
 - it doesn't always fail at the same place, so this looks like a
tolerance problem? e.g. sometimes transmission works and sometimes
a message is garbled?

- on the working azurewave module I can keep the card maxed at ~300mbps
in or ~100mbps out without problem for a while with iperf so signals
can't be that bad...? Or that could just be wishful thinking!



Thanks,
-- 
Dominique Martinet
