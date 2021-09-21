Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD14130C6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhIUJfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhIUJfR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 05:35:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF4C061574;
        Tue, 21 Sep 2021 02:33:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id m9so18313320qtk.4;
        Tue, 21 Sep 2021 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2m1Y4N/BOq+NqKJAMkY8dVs35ufagp3rh/2SLlxO+yw=;
        b=PHqsCADRSnOOcmzAkr+sEQMCLGbN6VZc1gM0oI7OJsgtOvY5WQYYYxlrqYGX0GiKl2
         FDF5oCs6w152XcOmjHAClUVqVjI/atVK/ARcOKeA2/j+iVcEJsyEJLNwxGcpyitBaprd
         KasbQB4N0io4XOLP/nPl94fErZjCbcM6EzVV6LSlRwYfcQO1oFbHfw4ulhaD79m/31IC
         ra90bqEy4zM6Qj0gE1llMur1x/z2BouQZFBg541fibW03D/KNzbosklc0VqWstpeEkUI
         F/ylRVLCX3ExzjOWrRyWYd/g0sfbU38ocPi2eZu0GPJsYFhjnuNbqQxVj/doxi/QjFkf
         VE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2m1Y4N/BOq+NqKJAMkY8dVs35ufagp3rh/2SLlxO+yw=;
        b=Fq6oFsUi1EDVW4ZcVS1wLP130rtemoSe4dkxNmHl1zdHKng/2Y6xvko2sB35MKSivK
         87TaC+rqEne0cYFZk/5v0gB8PXOENABM9vV4mf0B4DPKTRrnmu0tK+8rw9dMzPKICLUy
         pr9SRCR1neD/v3fE/qYf1dce6I++SWnOT9qEWrErNpaC0yC2Cda+iIZzxJWL9dbtGKXo
         O4ymZ64BwUt2wW56ifCWCp7q+G9yKrzu4JDzmGnEE75g0HnEDN4d+wi7VH1RFG2ooph5
         9zTKFcU8ziVCQGebxLyoSH4PyFumYCtm153uISC5cyEwzWR3l+04K7kL6tPP6PM5etQo
         7gvQ==
X-Gm-Message-State: AOAM531egHI7zFlgO1HqGmyd/Q+RRFxhtQ0elJNFbNqqM0hTpEHB8ere
        0Q4t3axhhyUbzM4cY0WZqtG1ztl2Nw6GuxA89njdLrNG42I=
X-Google-Smtp-Source: ABdhPJxkrhzzmtEyZMOlnDUiZF/m3C/32JSMlWjQS9o8UIh8brMmCw7E2k59uh4d5i8w5/QYaDopDetp4a++cb19Ba4=
X-Received: by 2002:a05:622a:394:: with SMTP id j20mr27110940qtx.196.1632216828040;
 Tue, 21 Sep 2021 02:33:48 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 21 Sep 2021 14:33:37 +0500
Message-ID: <CABXGCsODP8ze_mvzfJKcRYxuS-esVgHXAvDXS5KN3xFUN6bWgA@mail.gmail.com>
Subject: [Bug] Driver mt7921e cause computer reboot.
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        objelf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks.
Driver mt7921e causes computer reboot.
Yesterday I buyed laptop ASUS ROG Strix G15 Advantage Edition G513
G513QY-HQ007. First thing, I installed my favorite Linux distribution
there. Everything would be fine, but after setting up Wi-Fi, the
laptop began to reboot infinitely. Moreover, at the next boot, the
reboot occurs before the login screen appears.
I interrupted this infinite reboot loop after disabling Wi-Fi in the BIOS.
In the kernel log, if looked via journalctl, then nothing suspicious is visible.
I would still like Wi-Fi to work too. Could you help me with this?


kernel log: https://pastebin.com/tdn9jbMy
lspci: https://pastebin.com/eD8scBSP
lsusb: https://pastebin.com/SW9EUt8u

-- 
Best Regards,
Mike Gavrilov.
