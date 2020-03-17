Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D627E1879D0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 07:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgCQGoY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 02:44:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44207 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQGoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 02:44:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id h16so16521589qtr.11;
        Mon, 16 Mar 2020 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:mime-version:content-transfer-encoding:subject:to
         :cc:from:message-id;
        bh=ph9fyE0SWu0xZFEH+fgvMrU3nNtxfu7Osd78b8BPiNY=;
        b=P9XeRZ6gwJvqFqDm5APBDXa3Yw98WWOd5QGkmMY69hXOlnFZw4FoI9674flQgqRAOo
         vql7grG1mYf6rXCG7lchWiuu/bus/Lev9uWo3b6QdaP9Vm+ZdxWf26OIETEcWCIsyG1E
         qdvXwDu9l4DYB5xyR3u1HmBNFIHq5L5hi8zwr3d25tKu5+a+V0/fqKWpmEyD8vThLay7
         GMVZ7dJKBU3EZOYduOLVKxMkezO7MMhOTDWFRirZFMZKieq/HzfzP3Z2PV4eitQTAWre
         S4ExrbNR0jZWopdIblq7EDuucStZc5n7KfQVb/1k76O6bGImSpmRryWauimQfhnh0tQT
         3j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ph9fyE0SWu0xZFEH+fgvMrU3nNtxfu7Osd78b8BPiNY=;
        b=AFmu1MpEiu5T44X1FfshWdAXj4RSijE4MBk/+s2RvYWWSzVB91xsteoO50pP5/IIJW
         Zs20aK6iK73V3qhWFnd5J0eiItVuggw0DGW39zQRWhtPHP6MVtMm6DDSCfcyT0+gXA3Y
         TcRrX+mghDe6R08EoB1Hz0NK+Zrxo2dqVYTQvNUwBd/aYI9qLblu8IppApZTsFkOQeK3
         YUQj1u9E2Kk7NoSXUIAJWP1CTntNh7iMRG+TquIQXRWmb5TJkGs6tRjocMwGU+2/uTdQ
         y/uX/BlX+yOkdHKuZTtJp6MiJeYFa6QRAd8+Pwzuvzwe2oJB7sJG7ZOG5tKgrGSlSzEW
         ku5Q==
X-Gm-Message-State: ANhLgQ1RNsHMFRfa/5p121FhY7nV31ynnnfYFaoc2Dopv2njTxemy5Xv
        EndRuPdS7HbskUxi4TsFD3nHEwWi
X-Google-Smtp-Source: ADFU+vs5iIaqoa01bd9w1Y4eUDVqQG1Yw7+xBYcLyuISPn+UgbHmOxqhBipUq/tpTVW2VQAIYe989A==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr3977129qti.228.1584427462949;
        Mon, 16 Mar 2020 23:44:22 -0700 (PDT)
Received: from [192.168.1.171] (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id x37sm1618311qtc.90.2020.03.16.23.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 23:44:22 -0700 (PDT)
Date:   Tue, 17 Mar 2020 02:44:21 -0400
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: PROBLEM: 5.6.0-rc6 + Realtek RTL8188CUS wifi dongle: 8051 reset failed! 
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
CC:     kernel list <linux-kernel@vger.kernel.org>
From:   AC <achirvasub@gmail.com>
Message-ID: <C9F34A4B-E3F3-4D7A-B870-058C8D4871B9@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am on Debian 10=2E3 stable i386, running a custom-compiled kernel (I comp=
ile weekly, when new rc releases drop)=2E

I keep the following USB wifi dongle connected to this machine:

ID 050d:1102 Belkin Components F7D1102 N150/Surf Micro Wireless Adapter v1=
000 [Realtek RTL8188CUS]


---

The problem:=20

As of 5=2E6=2E0-rc6, booting up with the dongle connected returns a number=
 of dmesg complaints:

--- cut here ---

[    9=2E448337] rtl8192cu: MAC auto ON okay!          [    9=2E579025] rt=
l8192cu: Tx queue select: 0x05      [   10=2E475308] rtl8192c_common: Polli=
ng FW ready fail! REG_MCUFWDL:0x00030006=2E                            [   =
10=2E478213] rtl8192c_common: Firmware is not ready to run!                =
                             [   10=2E960093] rtl8192cu: 8051 reset failed!=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
                                     [   10=2E971027] rtl8192cu: MAC auto O=
N okay!          [   11=2E101691] rtl8192cu: Tx queue select: 0x05

--- end ---

Occasionally, this results in a timeout while trying to reach network=2Eta=
rget (systemd)=2E=20

Afterwards, there's endless dmesg noise Re: rtl8192cu:

--- cut here ---

[11391=2E204555] rtl8192cu: Tx queue select: 0x05      [11707=2E050480] rt=
l8192cu: MAC auto ON okay!          [11707=2E181118] rtl8192cu: Tx queue se=
lect: 0x05      [12023=2E057056] rtl8192cu: MAC auto ON okay!          [120=
23=2E187727] rtl8192cu: Tx queue select: 0x05
[12339=2E060183] rtl8192cu: MAC auto ON okay!          [12339=2E199316] rt=
l8192cu: Tx queue select: 0x05      [12655=2E054140] rtl8192cu: MAC auto ON=
 okay!          [12655=2E184789] rtl8192cu: Tx queue select: 0x05      [129=
71=2E053948] rtl8192cu: MAC auto ON okay!          [12971=2E184600] rtl8192=
cu: Tx queue select: 0x05      [13287=2E062712] rtl8192cu: MAC auto ON okay=
!          [13287=2E193363] rtl8192cu: Tx queue select: 0x05      [13603=2E=
065987] rtl8192cu: MAC auto ON okay!          [13603=2E196641] rtl8192cu: T=
x queue select: 0x05      [13919=2E066617] rtl8192cu: MAC auto ON okay!    =
      [13919=2E197270] rtl8192cu: Tx queue select: 0x05      [14235=2E06062=
1] rtl8192cu: MAC auto ON okay!          [14235=2E191277] rtl8192cu: Tx que=
ue select: 0x05      [14551=2E055104] rtl8192cu: MAC auto ON okay!         =
 [14551=2E185741] rtl8192cu: Tx queue select: 0x05      [14867=2E051799] rt=
l8192cu: MAC auto ON okay!          [14867=2E182451] rtl8192cu: Tx queue se=
lect: 0x05      [14878=2E855070] perf: interrupt took too long (7897 > 7896=
), lowering kernel=2Eperf_event_max_sample_rate to 25250

--- end ---

There are large swaths of this in dmesg=2E

