Return-Path: <linux-wireless+bounces-338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD48025E4
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54927280DAD
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D3171A4;
	Sun,  3 Dec 2023 17:12:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F50FD
	for <linux-wireless@vger.kernel.org>; Sun,  3 Dec 2023 09:12:08 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b892926906so2815303b6e.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 Dec 2023 09:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701623527; x=1702228327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnOA559cJsD74+jDbOxr5NeqaYT/3Or+g749X6dWlG8=;
        b=npeegZC4Zvb7hYVFK7yw06ti5bLYZC+ZIV3WlqHIOKzBSwv3NZxmEUZikpQYL4GACa
         5nXmUdttuJxHdFyxjzKQFBEcCOsZBjKSGp2C1MaZVTvleSQTSVhlfcwa/iC877o74/xH
         PfnNOgPVetADuQgAlwnsJzuQFdwx7t3+OO8vbXh4nshoK4LCrbebx3q9EbWF43X280G/
         +gZDeeF/011JH5uYBz9Af4jjlOBi61znB3YvvDY3kTs9/p9NeEqjZvpaH5+7hF+JvnhS
         3ewUjYd4rr3GzdUoPKPLpoUtENtdf25wmsKomfMFe25wWD7iWHgSPmslQjoQpW+mUfK/
         RUPA==
X-Gm-Message-State: AOJu0YykOEdDVZaYa5as7qiZBaHODRT7RMr4i2t4tGCW0ptirhwGDYvf
	3YcGYlNTGJ0kDBgyZ0zZOhO7dUctF4Z3LkA+2fzlYw2U9Yj+
X-Google-Smtp-Source: AGHT+IH3w+druH4uU8r+K5NJ9qcpom8kNoVM9v6ZZSeyWL37VhQJ0+itbXF4vhBXyRu7Z4vNSKIwSHKDrjDQp8ZxDNH4icrTItQ3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:2b15:0:b0:3b8:b1e3:c576 with SMTP id
 i21-20020aca2b15000000b003b8b1e3c576mr1312744oik.5.1701623527802; Sun, 03 Dec
 2023 09:12:07 -0800 (PST)
Date: Sun, 03 Dec 2023 09:12:07 -0800
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea98f3060b9e19c3@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From: syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, emmanuel.grumbach@intel.com, 
	gregory.greenman@intel.com, jiri@nvidia.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot suspects this issue was fixed by commit:

commit 88717def36f7b19f12d6ad6644e73bf91cf86375
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Wed Sep 13 11:56:51 2023 +0000

    wifi: iwlwifi: mvm: add a debug print when we get a BAR

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161d9230e80000
start commit:   d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: iwlwifi: mvm: add a debug print when we get a BAR

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

