Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86584BFEFB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfI0GRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 02:17:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbfI0GRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 02:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569565065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMwLuG/tW+DjOqFLBzWHnWxR2HD7Z3GFkOJ5/ZWsufY=;
        b=KavpKGNqtxhNyq3oQe8/+sHm1MryRNoRUDFd6Tdn+t2UP48kd2MsolvJboEz+qfDHABhXQ
        QeqeEV9yc9Kuwe0DHw23i6Rl1KUawvj29dYScxW1Zv8s0ULACA6mTZqZo2wRhnTuYDc6rI
        y5cWiQ0W5E8mgDu9K6r1KDfQWnQy41w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-23s1Ji84OsmnAtof1Xud7Q-1; Fri, 27 Sep 2019 02:17:41 -0400
Received: by mail-ed1-f71.google.com with SMTP id y66so963542ede.16
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 23:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CMwLuG/tW+DjOqFLBzWHnWxR2HD7Z3GFkOJ5/ZWsufY=;
        b=YTdy8IEvZ8YObp4O5mwWNwsq0kr/STxlM4iIhGsuUHO7Bb8OyfB8cKFbREI07vYobM
         Pnf1GiOd8PT+vCNPCevO/U1h8JKRwhUKHfB4LUulesJq1Os3qdEtmPogjzY7GPvurJcS
         dZYPXLSss/AWtj/r7Iyge79u85V9/k08O1ZLg5B2Ggyvr5d1yYRSbVJAeLg5s1AYWlRb
         do1yZ2QOG46OscV4VwEyAuqt2fdNksYA5B79oJBGRcvRlGVdhn69NqLDA8uOM196siWx
         JtPbeyML6dH2sNmyCAMakeU6BqNJel8zhCnJ+TjuKHoMaZpHuLWAS5hccATwp3rJGxus
         Qlxw==
X-Gm-Message-State: APjAAAX6wplPY88KSIyZNwW46W2NT90FKV3AGTrOWdGmwO67KUrZ27Pq
        CJqgO1ZnPEW0nhPzr/3743+VtYQ+96J0gNt86d2vAhrqrW8qoS1uddClJnTOgAhLVt5RqDFOjn5
        qXwitEtVTqUXqfIEXixPoNkEIT6s=
X-Received: by 2002:a17:906:3281:: with SMTP id 1mr6397284ejw.181.1569565060553;
        Thu, 26 Sep 2019 23:17:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxL9brEKHSoDGjIfTuvuHxI0UHuZGMZsfxvL1MYv9chvMywqKPjMMiy9Gv6IQOr+YydUDUrVA==
X-Received: by 2002:a17:906:3281:: with SMTP id 1mr6397273ejw.181.1569565060339;
        Thu, 26 Sep 2019 23:17:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id j1sm460397ejc.13.2019.09.26.23.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 23:17:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 04DFF18063D; Fri, 27 Sep 2019 08:17:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Miaoqing Pan <miaoqing@codeaurora.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: Re: [PATCH] mac80211: fix txq null pointer dereference
In-Reply-To: <1569549796-8223-1-git-send-email-miaoqing@codeaurora.org>
References: <1569549796-8223-1-git-send-email-miaoqing@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 08:17:38 +0200
Message-ID: <87mueq1cvx.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 23s1Ji84OsmnAtof1Xud7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> writes:

> If the interface type is P2P_DEVICE or NAN, read the file of
> '/sys/kernel/debug/ieee80211/phyx/netdev:wlanx/aqm' will get a
> NULL pointer dereference. As for those interface type, the
> pointer sdata->vif.txq is NULL.

Heh. Oops!

> Unable to handle kernel NULL pointer dereference at virtual address 00000=
011
> CPU: 1 PID: 30936 Comm: cat Not tainted 4.14.104 #1
> task: ffffffc0337e4880 task.stack: ffffff800cd20000
> PC is at ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
> LR is at ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
> pc : [<ffffff8000b7cd00>] lr : [<ffffff8000b7cd00>] pstate: 60000145
> sp : ffffff800cd23bb0
> x29: ffffff800cd23c00 x28: ffffffc0337e4880
> x27: ffffff8008a04000 x26: 0000000000000003
> x25: 000000000000018e x24: ffffff80090f9d30
> x23: ffffffc034b62000 x22: 0000000000000000
> x21: ffffffc0335008e0 x20: ffffff800cd23c10
> x19: 00000000000000c8 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffff80081ef454
> x15: 0000000000000000 x14: 00000000f45c1d27
> x13: 00000000ffab6710 x12: 0000000000000003
> x11: 0000000000000006 x10: 0000000000000000
> x9 : 0000000000000001 x8 : ffffffc0337e4880
> x7 : 0000000000000003 x6 : 00000000f4498000
> x5 : 0000000000000000 x4 : ffffff8000b7cccc
> x3 : ffffff800cd23e80 x2 : 00000000000000c8
> x1 : ffffff800cd23c10 x0 : ffffffc0335008e0
> Process cat (pid: 30936, stack limit =3D 0xffffff800cd20000)
> [Call trace:
> Exception stack(0xffffff800cd23a70 to 0xffffff800cd23bb0)
> 3a60:                                   ffffffc0335008e0 ffffff800cd23c10
> 3a80: 00000000000000c8 ffffff800cd23e80 ffffff8000b7cccc 0000000000000000
> 3aa0: 00000000f4498000 0000000000000003 ffffffc0337e4880 0000000000000001
> 3ac0: 0000000000000000 0000000000000006 0000000000000003 00000000ffab6710
> 3ae0: 00000000f45c1d27 0000000000000000 ffffff80081ef454 0000000000000000
> 3b00: 0000000000000000 00000000000000c8 ffffff800cd23c10 ffffffc0335008e0
> 3b20: 0000000000000000 ffffffc034b62000 ffffff80090f9d30 000000000000018e
> 3b40: 0000000000000003 ffffff8008a04000 ffffffc0337e4880 ffffff800cd23c00
> 3b60: ffffff8000b7cd00 ffffff800cd23bb0 ffffff8000b7cd00 0000000060000145
> 3b80: ffffff800cd23ba0 ffffff80088e16e4 0000007fffffffff ffffff800cd23c40
> 3ba0: ffffff800cd23c00 ffffff8000b7cd00
> [<ffffff8000b7cd00>] ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
> [<ffffff8000b7c414>] ieee80211_if_read+0x60/0xbc [mac80211]
> [<ffffff8000b7ccc4>] ieee80211_if_read_aqm+0x28/0x30 [mac80211]
> [<ffffff80082eff94>] full_proxy_read+0x2c/0x48
> [<ffffff80081eef00>] __vfs_read+0x2c/0xd4
> [<ffffff80081ef084>] vfs_read+0x8c/0x108
> [<ffffff80081ef494>] SyS_read+0x40/0x7c
>
> Tested HW: QCA9984
> Tested FW: 10.4-3.10-00047
>
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

