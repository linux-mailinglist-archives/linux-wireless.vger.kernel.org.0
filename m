Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A293224A61E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSSmO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 14:42:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57217 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSSmI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 14:42:08 -0400
Received: by mail-io1-f71.google.com with SMTP id q20so14712535iod.23
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 11:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/Bc9IGKthyb4/4Equ8PDcO5t+DRavD5Kty3CCCxkvw=;
        b=rQGeLBHGvup86UtMXl4h/vnpT/LJKquo8q4lvtX24AtNQY6CZWX/dbJ7aZ/CdB3nmW
         Hm1xUxIsneFzkB0xiQ5X/HPUOm79CCF3OawBX+kFRTwyUycCU9u2gjrgVaaVrRDzyBLC
         GQcDmKAyfCUNOgNEOOuyNXMqTzhz5d6/iLtK/O2HIgzTLg/T4mXsd+8d5MUcDln0jhvu
         iXDGfwJ2ZvVsPJ4wQmxtub0a+sY6itMV3/PSAWENwr89znfUEptJeeQdpt9vKpAnpsAc
         tGRncmag+asE4vNpmnQ8xoTT+vdi5i5KjUlpZ1QP7JKe1OnhyhvVRlBnSVKshQeGsqMD
         MRcQ==
X-Gm-Message-State: AOAM533Bif1Sev13seADFj7eH1KXKXpqWAu0z/hnU22DnC0TI5VghlyW
        YYFlQVNOwzwBcyIE+ijaKORw+3t/ru2kEXg58/Hjb5kYK2HS
X-Google-Smtp-Source: ABdhPJxBnOT/Zs8AQMPWL8g/vwMMvZSe9QJsKh8x44da5tnVZga3SiM38KDJZgB6PtqMxFubNhPzkTmpJxSO7cgDTe17jRpUgh+y
MIME-Version: 1.0
X-Received: by 2002:a02:682:: with SMTP id 124mr26096197jav.110.1597862527633;
 Wed, 19 Aug 2020 11:42:07 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:42:07 -0700
In-Reply-To: <000000000000a7e38a05a997edb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c13f505ad3f5c42@google.com>
Subject: Re: WARNING in __cfg80211_connect_result
From:   syzbot <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, jason@zx2c4.com,
        johannes@sipsolutions.net, krzk@kernel.org, kuba@kernel.org,
        kvalo@codeaurora.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        shuah@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit e7096c131e5161fa3b8e52a650d7719d2857adfd
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Sun Dec 8 23:27:34 2019 +0000

    net: WireGuard secure network tunnel

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000
start commit:   e3ec1e8c net: eliminate meaningless memcpy to data in pskb..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dad8b1900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dad8b1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
dashboard link: https://syzkaller.appspot.com/bug?extid=cc4c0f394e2611edba66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d9de91900000

Reported-by: syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
