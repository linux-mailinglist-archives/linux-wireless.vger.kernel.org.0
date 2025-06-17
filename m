Return-Path: <linux-wireless+bounces-24205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF9ADC84D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7710179090
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749132C032C;
	Tue, 17 Jun 2025 10:31:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0C2206A6
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156266; cv=none; b=eOTWimNr5OrXBcu2vLwYqAzcaNbZqgW2EBPJtdsCDfEctqkVdNZlo79E1cg4wtT+ObgI02V6vCzbgm8uOfYw3AXyUvXPrMAkicLlyrbrdjFHuvzaTVs+crNcQ/+yRHhg1cYIO8z9u9aTaoHoP/cB2LO1E+zcjXLeG4LZ/XwggVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156266; c=relaxed/simple;
	bh=g3j+S1VBapVxiPUL7o+H6JKhvNpAWui6EQJTF9Q7XlE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wel5MGEhcL4HY+2xeJBAUJRPDt1/zwN6YTo4V4vysiWYW6l4D2zizofzXdou5cDodY7KNMRxCOz5wSKLw3TVDNbybk8NQFrh0ycJ5oqVAL0Tt5pEoC0hvnwg201sJFvIhchbf/v3Ds/VaIjMAFhzb9oZvHtEChfFASLmIDxwwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc4908c4dso60121395ab.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 03:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750156263; x=1750761063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHy2hEYdU/qTD2iAln9JcyILMuFwNh/oT4oFGiagJAo=;
        b=c1uxA5WjWnSxyAs8an5xw4xuMY0r/1Fdy0EodPwgJp0trAiQILXR4P+fba5JvVAEz5
         Y5fhb2H8JEJhwW19A8EygeNhBObZRzNLBEQlZgDtH9Q6Tsluu4APS6Jvt0OYokCQS9f1
         L4MBRcRYh79vtwAyrswFgBaXLwiqKSJVJCT4QQyGhAOjNxgGk4voo9/GnH09rLzK8rUa
         ROmRYcQj8KCWLUPpWwAOUgBy/HOyjiyzmsEm1NBdexcQaWDCaJHz7tv4NhK+gzfIbmPP
         N3BneqkKX9wcX8NcF6RllxaFI9tHIcVlGNklW6GJt3rXj6g/nzO3GW6Y5vBHoSgG4Ng6
         1vVw==
X-Forwarded-Encrypted: i=1; AJvYcCUEdtcB97SGHhExbmz+LvpBtMY4LPW9bgRio1ywA9tb6VG5dkOnaivp7EXXLDZW1Zz//haG4IRgqNIfgYEV+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmrde1bLLtZ1/0YVFrkx/IhqrJZcrf8c0+to+/Er/sabNXN6DA
	Bxz03OlXx8aDar47wIv5pWVG07eIE3UvnfI/clmCRB+Po+3aBxNkeHFoDNWSIxSRKZO/KSQ9aAE
	55hJ8zULMBJL3Y9Wl0+cRrHMrZTkgqEUE501PGKOrPAeJfLBem8CusktQY5k=
X-Google-Smtp-Source: AGHT+IFFFHE1MTvfh1Yrerz66o84Y4qKxQucMuai+gGwCPL9oG8Kd++CWN94kcGGwuF4moyMQL2PvQ4VChViyjUn80VnzA+cD4TZ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3dd:f338:6361 with SMTP id
 e9e14a558f8ab-3de07c5cba7mr142824055ab.6.1750156263075; Tue, 17 Jun 2025
 03:31:03 -0700 (PDT)
Date: Tue, 17 Jun 2025 03:31:03 -0700
In-Reply-To: <20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685143e7.a70a0220.395abc.0215.GAE@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] WARNING in ath6kl_bmi_get_target_info (2)
From: syzbot <syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com

Tested on:

commit:         9afe6529 Merge tag 'x86_urgent_for_6.16-rc3' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1008c50c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1383d853600dcee
dashboard link: https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17334370580000

Note: testing is done by a robot and is best-effort only.

