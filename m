Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074A59AECD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Aug 2022 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiHTPFn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Aug 2022 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbiHTPFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Aug 2022 11:05:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75066A70
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 08:05:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso7401408pjj.4
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=wJiqYxQAmcuewB1QtI9+3lYVIMp5Vhig6FuH/TrLgJo=;
        b=nqD1TFU3gIVb8KqaYS0lrZo++7n52HXZlDnPBJIBC5cXd5XfS3L+4KocFLjYDpoEzC
         MOFzPBemr8G8xVDKXJoqL4h2ZcPPhKp5BAPebiVOiBDLW+WVJXwLrMPfVZDfaKTcYIYD
         7J/ni+8+9hD+YmfOa0qXcTpvZksIUVJIbGdSkBTxgEgNd21W9Ab/N89dNqTOjRLPrJFc
         irVWkEaj0Pmx6vVaAv1D2IgHWSHynt7AUb/HckZ2nAbErV8CGbcXj3sUootcTph8+QZA
         5Cgf8fMnN6MYrpiini//tG09oPaOn1CQspVcveramwPQqTJzrqOOWqqlmtv9NT97uhl3
         wMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=wJiqYxQAmcuewB1QtI9+3lYVIMp5Vhig6FuH/TrLgJo=;
        b=XOeMv6SWFcRNthleXBE9N0jRU49mvm9w2titXDPYKi3rOgdlL8SiEFxlXIywDj4HFn
         iKU+9YE1K32WEjBHUQRHegRuu6AroV+CG8eZrhq4lZcBR6uRgHdCFmwT+Lu5N0KGhjZn
         qfMHSByzW9kwrEbdiuPLwViRRXx5nIsZKaH2OFVyEfxry3tqcJe4JWBKKphXHd9N++F3
         pG6eD0ISNfMfJLlQvTirlEo9yesQy1maEjBKtK+J1LEajZ86khGI9v6Eb3lTNRI49QRx
         +rPR3yuadeNrcMcK5DmTHMWzi0mhQqXAW8Kp5I+hv7yYWmQbWQ4sRqbGrq0hlgHM3BG2
         OrCQ==
X-Gm-Message-State: ACgBeo24E93wOptkwwcB7WxQed4ySKfCasVVuI5Tekw/VX8B7BkFOGuI
        EgxW9Wdw6H9uSaSyQFQo2kpsH0hclXVQZtXtk3PQbiRTb/+uvQ==
X-Google-Smtp-Source: AA6agR4MtsCAX9sOmfiYYVNfOOEShUP5aIWQmSoD9XLYcxMbs59gYD2sio3MmZ/MaCtbvEAsU5UmY6iB7HrVbwYUK/Q=
X-Received: by 2002:a17:902:7689:b0:170:8b17:37f4 with SMTP id
 m9-20020a170902768900b001708b1737f4mr12521737pll.42.1661007936932; Sat, 20
 Aug 2022 08:05:36 -0700 (PDT)
MIME-Version: 1.0
From:   bommy985 <turkenlurken@gmail.com>
Date:   Sat, 20 Aug 2022 22:06:12 -0500
Message-ID: <CAPwNHCEkdnXbp+EdJ0+e6AbwLy=fBiSnzHDwmOBezwMUd1dzfw@mail.gmail.com>
Subject: wifi problem
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a laptop with a rtw8852be wifi card, and i was using your
driver to get wifi on my system, come an update, I was required to
redo the installation in order to have it again. however, when doing
sudo make install,
make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
cp: cannot stat 'rtl8852au*.bin': No such file or directory

 this is the only logging that is produced, doing sudo make install -B
when i do a B flag
[bommy@bommy-laptop rtw8852be]$ sudo make install -B
make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
 CC [M]  /home/bommy/rtw8852be/core.o
 CC [M]  /home/bommy/rtw8852be/mac80211.o
 CC [M]  /home/bommy/rtw8852be/mac.o
 CC [M]  /home/bommy/rtw8852be/phy.o
 CC [M]  /home/bommy/rtw8852be/fw.o
 CC [M]  /home/bommy/rtw8852be/cam.o
 CC [M]  /home/bommy/rtw8852be/efuse.o
 CC [M]  /home/bommy/rtw8852be/regd.o
 CC [M]  /home/bommy/rtw8852be/sar.o
 CC [M]  /home/bommy/rtw8852be/coex.o
 CC [M]  /home/bommy/rtw8852be/ps.o
 CC [M]  /home/bommy/rtw8852be/debug.o
 CC [M]  /home/bommy/rtw8852be/ser.o
 LD [M]  /home/bommy/rtw8852be/rtw89core.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_table.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk_table.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852a.o
 CC [M]  /home/bommy/rtw8852be/rtw8852ae.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852ae.o
 CC [M]  /home/bommy/rtw8852be/pci.o
 LD [M]  /home/bommy/rtw8852be/rtw89pci.o
WARNING: Symbol version dump "Module.symvers" is missing.
        Modules may not have dependencies or modversions.
        You may get many unresolved symbol warnings.
 MODPOST /home/bommy/rtw8852be/Module.symvers
 CC [M]  /home/bommy/rtw8852be/rtw89core.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw89core.ko
 BTF [M] /home/bommy/rtw8852be/rtw89core.ko
 CC [M]  /home/bommy/rtw8852be/rtw89pci.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw89pci.ko
 BTF [M] /home/bommy/rtw8852be/rtw89pci.ko
 CC [M]  /home/bommy/rtw8852be/rtw_8852a.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852a.ko
 BTF [M] /home/bommy/rtw8852be/rtw_8852a.ko
 CC [M]  /home/bommy/rtw8852be/rtw_8852ae.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852ae.ko
 BTF [M] /home/bommy/rtw8852be/rtw_8852ae.ko
make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'
cp: cannot stat 'rtl8852au*.bin': No such file or directory

this is produced


it should be noted that when trying to modprobe it
[bommy@bommy-laptop rtw8852be]$ sudo modprobe -v 8852be
insmod /lib/modules/5.19.2-arch1-1/kernel/drivers/net/wireless/8852be.ko
modprobe: ERROR: could not insert '8852be': Exec format error
[bommy@bommy-laptop rtw8852be]$ ^C
this is produced

it should be noted that no errors are seen in the make process
[bommy@bommy-laptop rtw8852be]$ make
make -C /lib/modules/5.19.2-arch1-1/build M=/home/bommy/rtw8852be modules
make[1]: Entering directory '/usr/lib/modules/5.19.2-arch1-1/build'
 CC [M]  /home/bommy/rtw8852be/core.o
 CC [M]  /home/bommy/rtw8852be/mac80211.o
 CC [M]  /home/bommy/rtw8852be/mac.o
 CC [M]  /home/bommy/rtw8852be/phy.o
 CC [M]  /home/bommy/rtw8852be/fw.o
 CC [M]  /home/bommy/rtw8852be/cam.o
 CC [M]  /home/bommy/rtw8852be/efuse.o
 CC [M]  /home/bommy/rtw8852be/regd.o
 CC [M]  /home/bommy/rtw8852be/sar.o
 CC [M]  /home/bommy/rtw8852be/coex.o
 CC [M]  /home/bommy/rtw8852be/ps.o
 CC [M]  /home/bommy/rtw8852be/debug.o
 CC [M]  /home/bommy/rtw8852be/ser.o
 LD [M]  /home/bommy/rtw8852be/rtw89core.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_table.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk.o
 CC [M]  /home/bommy/rtw8852be/rtw8852a_rfk_table.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852a.o
 CC [M]  /home/bommy/rtw8852be/rtw8852ae.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852ae.o
 CC [M]  /home/bommy/rtw8852be/pci.o
 LD [M]  /home/bommy/rtw8852be/rtw89pci.o
 MODPOST /home/bommy/rtw8852be/Module.symvers
 CC [M]  /home/bommy/rtw8852be/rtw89core.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw89core.ko
 BTF [M] /home/bommy/rtw8852be/rtw89core.ko
 CC [M]  /home/bommy/rtw8852be/rtw89pci.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw89pci.ko
 BTF [M] /home/bommy/rtw8852be/rtw89pci.ko
 CC [M]  /home/bommy/rtw8852be/rtw_8852a.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852a.ko
 BTF [M] /home/bommy/rtw8852be/rtw_8852a.ko
 CC [M]  /home/bommy/rtw8852be/rtw_8852ae.mod.o
 LD [M]  /home/bommy/rtw8852be/rtw_8852ae.ko
 BTF [M] /home/bommy/rtw8852be/rtw_8852ae.ko
make[1]: Leaving directory '/usr/lib/modules/5.19.2-arch1-1/build'

 this log is produced, which dosent look like errors on my end, but
interpret that as
you will


please fix this...or lead me somewhere where i can, i use this laptop
for school where i cant carry an ethernet cable around...
thanks for driver
bommy
