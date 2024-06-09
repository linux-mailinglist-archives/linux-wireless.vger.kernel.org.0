Return-Path: <linux-wireless+bounces-8721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CC9014E4
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 10:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD21F21774
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB281C68F;
	Sun,  9 Jun 2024 08:10:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CD18C3D
	for <linux-wireless@vger.kernel.org>; Sun,  9 Jun 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717920605; cv=none; b=CKXdzuV98XiW5p9aUBzoNICHgcF5UlyLTb3om4PWDU+JaTzdlcV0SCmffJLhWgD7jMkHyqN9/HHDmfQRrLc5xh6tshyp1Bum46gujholtC+LIqyqYZwUui/6zEF4waeMprzHBH7b456JkQ0+3PsmeFszO4YpvubZ3Hzvu2MxlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717920605; c=relaxed/simple;
	bh=GS9aZJ+LvBwTLtq/qNJhQCSTx+jEOzzxkyfkjOGKc3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MvzKUhdq+CGJwBCNvugKHobjftmV36lbWDssWjSnWlNvWMblSW8f54og0gJv4pt8oYSI4kdwh1uDG0rKQFQLgRDVESEbv43b0O23QkKNAOB9ZvHQSqW3zq3itcwT3GlHf6C0jMhV2+9GbAfkF3zt4ZTLXACgnnuvdlnn4LpImAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb69c65e9aso201314539f.3
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2024 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717920603; x=1718525403;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNJralV27Phiz3+/bwDTU9IpTrdPF0Y6Sddk9Gzyfpg=;
        b=la16sfS0SOdmdABUs0jERLQbA5jzED++JF4xGMNyE07Cvm6rgLXW6p+AI7I/Gjy0cc
         qxGHg8kcYJ87PogmibCNvMBHD6rRgNEE8t7I95w033DXp7qPaZKYqHGgeVjP7kT05m84
         CCOkiPTDwIH5COrHVicmfoCAyHMEdbspr7J7mOstVBc0Hxf+0kj7LYlNuPZ/xf2+KlhH
         5sUdmrR3FOhLyFHbsS76c7NBem+FY3ePqeCgLcpf2b4NpIV1z6yiz9QqvT7e3zLcjyyb
         qnYnGhqGhS2MnWiPtxGuW0O0mfO42A+c83nBuGkegH7rJVAHcV1IVxGwnPzMo5WY7shL
         xwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUacklzYa7bAAansIXDP4M9ZJZuCSnljfokY1M2cjLCWikAa/wshfWIcSpkwKXkfrOFwrxdjqCbgUY6RwX53Kvp7SnsJLRkFOaYlxdzICQ=
X-Gm-Message-State: AOJu0Yylhq7myq7TIHRrY6BRA6L/Dr9I8PuOvwA4aAzEpuSC1B/qavCU
	m9qV84jWVvHLvHkdz5gx2l/9xQnBgGxzXrutqKPxcnTuZUFC+LIuC2zoBigIxpcQiu7xdnk6GlM
	vRuNv04F8fqsbdbnYnb2dh/wIlcGAure6VTJXaEYmLXv61OMePL6s9U8=
X-Google-Smtp-Source: AGHT+IEy9eOLWJpA4i/hRidAbGKrxF/9TU6K0IRIrcf+HYaBTgTEqoKqcY/Zmj140g39ubNQ0I2CaTEli8UDwsRi4WZw+p8n0Arx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:13c9:b0fa with SMTP id
 8926c6da1cb9f-4b913c9b5b5mr7429173.2.1717920603137; Sun, 09 Jun 2024 01:10:03
 -0700 (PDT)
Date: Sun, 09 Jun 2024 01:10:03 -0700
In-Reply-To: <0000000000002a48dd05c506e7cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d7aac061a708fa3@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] divide error in ath9k_htc_swba
From: syzbot <syzbot+90d241d7661ca2493f0b@syzkaller.appspotmail.com>
To: ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org, 
	kvalo@codeaurora.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paskripkin@gmail.com, 
	quic_kvalo@quicinc.com, syzkaller-bugs@googlegroups.com, toke@redhat.com, 
	toke@toke.dk, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit 24355fcb0d4cbcb6ddda262596558e8cfba70f11
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Date:   Fri Jan 26 14:02:17 2024 +0000

    wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is compl=
ete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D155ade029800=
00
start commit:   e8b767f5e040 Merge tag 'for-linus-5.18-rc1' of git://git.k.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da28aee0add07943=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D90d241d7661ca2493=
f0b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D130fa98770000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12f2d26b700000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is=
 complete

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

