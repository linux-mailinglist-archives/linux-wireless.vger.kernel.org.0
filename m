Return-Path: <linux-wireless+bounces-10838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CE9454F2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 01:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33DD1F23F16
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F814D6ED;
	Thu,  1 Aug 2024 23:39:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C414D294
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555545; cv=none; b=gZAbheJrvUVcVMaS2XDW6Ds4T2bXBh+FKihx2XGUcrrnjSQMqTcJ5UDrg9W4GpQfqndf5GPCnp2cHXHZtnmG9iUOnJFoIKOgvCIpN7oABWrcuHi744aMpc5g4u2FYGCyCojHpi4oijDYlvAqf8M4M/etcxkmj9LUtFYL4Cs1xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555545; c=relaxed/simple;
	bh=UmmXi35nfuScAHUEeIJwGppaSmZBoW8i5FyJvfJEzhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EnVzE6VAb9vt/shJBCzHo2cvJgmgcbTxFqhA8CmW78SPwawcGZR+QyHkGI0QdPve5wApnGr+zaLiJMxlMs0xevvzYV6UpnY8fgxJCqEPndbE38J5zEjGN0D5b+2ezH1r0owsuT/JZYRTGWZXv7xcD4+OKQcSc94uEvD8RBLb3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa44764bbso842546039f.3
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555543; x=1723160343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODcuns1LudBlqI4V0K87ttGH2rAEsrJeBiRSk4hIkus=;
        b=SoV4MGoxl66mTg+Kn0sC6tNQLQjVS5S1gZ/cVU8NQk7UN3Tq70QYolEbOEeSWgLzZ8
         xbc5mnArD7X/rFrYaN6bX8W8nWifQ+Iqpf5h6qVwdA1LWq7k9PtEgtdo8WGu3vPDuRke
         mwrlQ4D6mogn4mp1RzgJjlPQ02BOVIefwhIl+YGXDXQleMCPzVBCmy39LeCxjR74856E
         zyssMo8GlFXfPecmPMp05CJ3fXYUrSIrjitKGX9XkwPom7WK5WxEWnJHpfgPwnD7axZ8
         rxAtXUzvDBf36p5NwDgPdDVItZ1ea9YDYCRrUdb87PoWM12R57SFnM6xunx4hjmoagfa
         QXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxI/nmPq6Kj2N65w5t4ImrhH2oWpxaOkK+/BqjmRv6FjNepJ/jJBv95qTFjGJqzAcSJrPRKFersGwxez/9NoMNOCHO7QK0Dy/8tAqJupk=
X-Gm-Message-State: AOJu0YwlWvHd16zCJ2LAEWhUyj7+F1ePX2kZ59847ZsyvcOTOOYYFVAL
	ME/dVO1ysVK2NwqZ5/PsoNNwA8jSH76PXegB7Og9IzuGcS4WvqV1uYT7mECPFU+pDAYrC5aTIzy
	smi9pquSTVhlvgq9Em4iBO04XeJ6Mu5BXLnuTKuZGULIHb5yXDyjY8pY=
X-Google-Smtp-Source: AGHT+IG8TxilfBblIK7ewxLG6HE/mrHKCIseSqawEomYlhrUYVYyt4OhOTyyY0tgYhO72VI3qfqc9z4ejv5s988bgf3cBNUSPSDA
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3788:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4c8d56f8d03mr60315173.6.1722555543269; Thu, 01 Aug 2024
 16:39:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 16:39:03 -0700
In-Reply-To: <000000000000839d4d060a0fab97@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000434672061ea7b797@google.com>
Subject: Re: [v6.1] WARNING in ieee80211_check_rate_mask
From: syzbot <syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
	johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	patches@lists.linux.dev, sashal@kernel.org, skhan@linuxfoundation.org, 
	stable-commits@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-lts-bugs@googlegroups.com, vincenzo.mezzela@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue could be fixed by backporting the following commit:

commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28
git tree: upstream
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Feb 24 09:52:19 2023 +0000

    wifi: mac80211: check basic rates validity

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d0b26d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59059e181681c079
dashboard link: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122bb7a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dfa479180000


Please keep in mind that other backports might be required as well.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

