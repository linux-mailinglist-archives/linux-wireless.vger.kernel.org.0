Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A717C9190
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjJMXui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjJMXug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:50:36 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0154C9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:50:31 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c65a8aaa0dso3474655a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697241031; x=1697845831;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVucjE2yjEUScH3CxBlb1yDLAQs8UXrP8jjUHECcl9E=;
        b=WwwkhNrif8Q8TtvJoqSUz7Nwa8n307Q7XgVmrCOtCtk4+EPtyYedXIFbhfuV9ZRKEy
         Ram1yGZgYsaLSHS47PpFqqG9IpgX9HvpLJYL/7rMtFfBwqAzxY2QI9KIffO7jmLP2WYu
         dyfO/HUwIjrnGQ/THyNQqHDPttKW/VT7Al20ewLVSSb/TUEDEg80W9pUlmPZbA7HjedJ
         wOVAD8iatNMtpyIoR0SlMuT1k5GhNHOF0DT3yo2CJ3/yYZbaa40hnH3Ny5iwL+XZWRwj
         49Oi7VRYXzV6DpKUnNFiCh27p4NMFMaxRBE3frWmrSiahlHSw39dMUO/nTtEGVojDYTb
         8Ybg==
X-Gm-Message-State: AOJu0YzR0Zf46QPuYudV09NuRVR++heIGEymniTRyBfPydwUYszbgLWK
        wXSt1sgM7/32qfObNQKJ2f2pSngceZgousPXtvhT7T/0izmW
X-Google-Smtp-Source: AGHT+IE3mNXgUnbffBl6NSf5U/f6BkF5zcp3zWCtahDMEOqUgDVEwA664Ic/SJhZmaojLteaqQnARfehrtWV0EEV2R2SYULgmyRN
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9881:b0:1dc:e729:66f7 with SMTP id
 eg1-20020a056870988100b001dce72966f7mr9518941oab.8.1697241031086; Fri, 13 Oct
 2023 16:50:31 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:50:31 -0700
In-Reply-To: <0000000000006a3d0d060785f027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c19b400607a1b88c@google.com>
Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From:   syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
To:     SHA-cyfmac-dev-list@infineon.com, ajay.kathat@microchip.com,
        amitkarwar@gmail.com, aspriel@gmail.com,
        brcm80211-dev-list.pdl@broadcom.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, franky.lin@broadcom.com,
        ganapathi017@gmail.com, geomatsi@gmail.com,
        gregkh@linuxfoundation.org, hante.meuleman@broadcom.com,
        huxinming820@gmail.com, imitsyanko@quantenna.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@kernel.org,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        sharvari.harisangam@nxp.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit 7b0a0e3c3a88260b6fcb017e49f198463aa62ed1
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Apr 14 14:50:57 2022 +0000

    wifi: cfg80211: do some rework towards MLO link APIs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fdd89d680000
start commit:   ce583d5fb9d3 Merge tag 'for-v6.6-rc2' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1003d89d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fdd89d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a58e5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170cf875680000

Reported-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com
Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
