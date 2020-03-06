Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9305A17B950
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 10:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgCFJdS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 04:33:18 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39867 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgCFJdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 04:33:18 -0500
Received: by mail-qk1-f181.google.com with SMTP id e16so1676279qkl.6
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2020 01:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+JNtpLKu01gCOGwBjcIZewBDPsTdLHzqOPX71dA5c0o=;
        b=uKC4FuZ20nlHAVd9PyQuaVN5ok3+D3tTEcPntK+DvIzByU8RDF8Cn0QtVyknoDBkH2
         EONsnK1ZUQ8gHDGbj7U43CBBmizbXhhT0VvERK04JUhFGcNWClaqIdfApeT+RPaz2Apl
         lTRwWflOMbIx1dBGRu4SASfw8YQC4LYZeFK7TUQ8sPnnsu5jCIamIdSMOpHGGCcWgHHE
         CddhYay4sg2NWT98XM+ZOpVYQsOlyWalnSphrDyRaO8O8/U0TCIyAGUFk2W2Ojs34mzq
         UPdY0RsroIA3/YPXJg/1GGlpUK29Xemsrc/9nq7MZ9AibePebHX/Zrz9DK8XArkS+tzB
         qrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+JNtpLKu01gCOGwBjcIZewBDPsTdLHzqOPX71dA5c0o=;
        b=IRvOyR3mWJA+zKaqq5slWmKtH5d8Md79rzsZrVbnSvyu/a5KZBwYG1dFeok2J2MLr9
         Q50o5A+1bT8f2JX39aShONvF4mrtkApx8YteEXJG9VPkYfBJgXwob2jp7x2VJVQQIRO+
         /3I1p4S9Nb4y9nyusinFc+XLPOnssdA11n6Jra+xEDtWuMQcMFG46YcoA49/+sRSBsVQ
         JFwlMh7S/f0zAO9f68fSeoc9bR+hsEcozk1xJBofofbHo5vH6hp7vfb5QYucDyBYZfIL
         1axL9TSS1EK6g/Txg9xGg+DLm8kRHXASif83XKk0XxeMYktlLjCD5I/Fy+USzZNTDuud
         uaxg==
X-Gm-Message-State: ANhLgQ1bbV2qvkNNigCK4y+j5r/ckl3TxznR4tLEJH027M1IloZ5x8Sj
        I9rT13wvYFM2PzCLbFCbX/PiXNsrh8NPlLS5g4A=
X-Google-Smtp-Source: ADFU+vssX5LCwvt4idD6h/8T7GtUIOAJzpB6oviihnPZO6OGZMmBOqEIFlRQTlNXWBdyIcBigG250LXPM0EBHOh+CNI=
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr2127933qki.254.1583487197403;
 Fri, 06 Mar 2020 01:33:17 -0800 (PST)
MIME-Version: 1.0
From:   Equipe Soft <equipe.soft.isere@gmail.com>
Date:   Fri, 6 Mar 2020 10:33:06 +0100
Message-ID: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
Subject: Is iwlwifi-9260-th-b0-jf-b0-46.ucode a debug firmware?
To:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
we are using backport-iwlwifi core45 drivers and latest AC9260
firmware binary blob:
latest firmware available in Intel iwlwifi firmware fork:
https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=4bebf45872a9818a17e2079118500030a8fa377a
2019-11-28 iwlwifi: update FWs to core47-142 release

At runtime, we noticed these log traces:
iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
iwlwifi 0000:01:00.0: Found debug configuration: 0
iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
So it seems that it is a debug firmware...

Q0) can you please confirm that we can safely use this debug firmware
in our product ?
Q1) is debug mode deliberately enabled in newer firmware or is it an
error (maybe like forgotten to disable it) ?
Q2) is there an impact on performance with this debug firmware ? WiFi
speed/throughput may be reduced or not ?
Q3) moreover, can you please confirm whether or not WoWLAN (aka
Wake-on-WLAN) is working with this debug firmware ?
Q4) is WoWLAN working with any AC9260 firmware version ? and any
iwlwifi driver version ?

Thanks for your help,

@team
