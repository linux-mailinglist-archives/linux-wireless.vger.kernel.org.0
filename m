Return-Path: <linux-wireless+bounces-14689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594939B53BD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 21:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5703287521
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDAF1DF967;
	Tue, 29 Oct 2024 20:32:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2120721D
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233925; cv=none; b=po9M62+rjNcrAte9uZ18Z7uBwTWPt2G3KbEvZFONgjEVDHLdXpHL4fiwIGKrsCzUXbf4ayuCshSMLds/Ut89asw7rFCvX3Vm3wprtCjUKQKbBnr945olv8n0Tfv1OAe0ZVMVuW8+FpCJ/AGDeCWFH2iokaa3rygwwug99d+ip4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233925; c=relaxed/simple;
	bh=+ucZND5jXPG6IF+RsGlmnHfSNTQet+yftUa81HCkFzo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PtMiO1fxOuy6XrZ5hQEZiw0rVH2hPK7DgolpTKh05pt9LaNQcmJv+vrA8TnRnBkkFC3dq8RGauhbXTYkR/EJG7slly/SsNz+lxHrC6HDBjBInoTSsgL64G0QadDWwvuD5sDLuDaASFaPJj0DuW7hHyoPBYwRy4uc/OpJkziaEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso55710295ab.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233922; x=1730838722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXeyHPxAZWU63IOD8dE86wBYbVBW54NU6tNTx9BtVeU=;
        b=ppdoqUYadQ36aqe+eolqu6TIGQdNylzdavjR3V8hTwaWb2BXCQf8kjKhOqOrym6Uku
         EcxkX8ewprcgG11sWBwIZpT0YEimXXpvlmjk9AdcaJybdkmMwQPw+OoAvCqzpNAdqVnZ
         w++5zy6Wfqqjn22YzbJYvht0Tf8oYwger5NTjaWjzmpIQcx6XrPS586+/jwgEnPb0/qT
         BnqR0QZlP/PsjMWYHOU4EVslDr7xVW4ezOf7lGjwXROSpRa92Mvg2mw3F3+f05Z2b+Qo
         5XBRDBiFZHt15BsoluIpG8X1scAp0RxJCddqX2YVSxVZ8tQzHbnEXglKa1vJiMJVnfSe
         Vzzg==
X-Forwarded-Encrypted: i=1; AJvYcCWBKz8+h7L1UKVf6xUXpyjXLRw/hD9hiYJukgw+lPlK5Cc7Nii4g4QdRiz5UlF1g4nLyg+EkloSLKX5GcD+wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyY5fUWqq3kGGVIj8WODwgPu6Qn1ej9wt4WqmH7QdQq7V9jBo
	9cLxuE8/eNkMmKBXBQyO5DPyN5lXuqAcWjo67a3ld5NEQbn0kk7fbZkxVYgsA5BRwQkgb/LdaYO
	PDa5iHfWyOpsjr1unXgK/2XERCgvqVccuOO4IMaUi8SeztkbdjXOcsT8=
X-Google-Smtp-Source: AGHT+IFPIChgNx3Wlye5TqtptBZLvqb3bek41OZ1ZZ4YWYBXoDgcq+Btr2G9uFmJzd4mWD9bZMgo2Jg8ozZZKJznffWBB4zGj0WL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a4ed3057c0mr107085245ab.22.1730233922598; Tue, 29 Oct 2024
 13:32:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:32:02 -0700
In-Reply-To: <671cedcb.050a0220.2b8c0f.01b1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67214642.050a0220.4735a.0262.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (3)
From: syzbot <syzbot+34463a129786910405dd@syzkaller.appspotmail.com>
To: clang-built-linux@googlegroups.com, davem@davemloft.net, 
	johannes.berg@intel.com, johannes@sipsolutions.net, kuba@kernel.org, 
	kvalo@codeaurora.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	ramonreisfontes@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 119aadf816f5373dc82ca4109d6d5b777e00475b
Author: Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Fri May 15 16:46:40 2020 +0000

    mac80211_hwsim: report the WIPHY_FLAG_SUPPORTS_5_10_MHZ capability

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170e3687980000
start commit:   b5abbf612092 Merge branch 'mptcp-sched-fix-some-lock-issues'
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148e3687980000
console output: https://syzkaller.appspot.com/x/log.txt?x=108e3687980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a76ebb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f0ee40580000

Reported-by: syzbot+34463a129786910405dd@syzkaller.appspotmail.com
Fixes: 119aadf816f5 ("mac80211_hwsim: report the WIPHY_FLAG_SUPPORTS_5_10_MHZ capability")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

