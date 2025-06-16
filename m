Return-Path: <linux-wireless+bounces-24156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A079ADB5C0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A60B7A4FB9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276D267721;
	Mon, 16 Jun 2025 15:45:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECE264614
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088705; cv=none; b=DXSjWcOt+J684oy5FaUPSYouM42yJmOdnYPYPXWg8arfpoEIEZyAqXU1kKoSiR4+zVmVl8jGd7rjXyomH07DVRgJKZsMBGUsIr6qlMNNoVzvtFUK/3njnXMq6j7ErXbzpaw1PI6Vqdw2sDEVTBmzHCW5y99iPyXuliR8Jvxg5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088705; c=relaxed/simple;
	bh=9nMPTz5bGSvEG/i14uqwmCghT1xa4I+arwdr3+h7liY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LT5L+8DZWSRDR+bwPn5sZRzZqUFJ7lZirJa1SNGvgWeXaVC52xWJH2LpUA8Rf4NXJoCkHfA6d43uEyHq/KM5yri0SJnWhgD34PyaCmQDA/23Jh4oZ4yZPoTAqnCFeQl0g1D+0FBDtWWgdkZ+LisFjIKaWcs/9GZ23G0KQPoXEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8730ca8143eso537413239f.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088703; x=1750693503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D//4398RMDH1nIHk/V9PjnlZFD7Aah0HXh4rxQDfP8=;
        b=Aqf2RDaOrGNfT1CUMUC0uxl8FP3w38q1mjReN3QNYnU1AXFne1Kelk48HEZfHSWRS2
         JE4akLSaw439SbhwFHzQxGrww3lPyNKWqXs9OZuoMGEc+X1dQzwB7NvRr8ai1m4he842
         rV6JIk2NU4w8V1IJPLZ1B0lQg9i7jpXSvbUS4Ze9RvkaFf66AFwnNjAkzM1KZKoRqRgq
         S67qf9jEpZ6qUAaG9sb/KHVfXym+ELr1qMJcMYNJEP1cPLg+TxZ+je7DgQ6UCiyKp4Cy
         s4r4Of4UAJgbV8icwpI0imkyOcwznORH3QOTJ582U58fdfgyr81aNkOrEUoLraQRFPCE
         nkrg==
X-Forwarded-Encrypted: i=1; AJvYcCW812xaAPh8k8luK+OTUGKPxKHB3sbEA07AbYCW0ndiAJCh1oOleeUX2bdvMz+AtXJouTYW5l2Qiw9C/WBbIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0z/bTNRiHriYdwfRzpbbVyzwsxZPwVSud5AZcRunVASW+lEv
	/p3sel6ouNOnsLPyxYmy2TvuFefR2zcMrnyS49lPt/tr28nYYPM8j/bmxdqHb9QfLHGtXquvPCq
	YYKCZKy1CTRBsLxCPVMMSIYzNEEqkPLqrILCVbJgOyY3PVwwa1fUn6D6+jls=
X-Google-Smtp-Source: AGHT+IHng+hQD9vqG0pg0/vbuhmvOeBxFo2e47QfXWmQZg3xxh49WSTlGo5kedlBCd/FmhBkLYXzZ15O9ROPuAlr0FL++MT2ZMrZ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d350:0:b0:3de:12ce:d832 with SMTP id
 e9e14a558f8ab-3de12cedba8mr46919425ab.10.1750088702920; Mon, 16 Jun 2025
 08:45:02 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:45:02 -0700
In-Reply-To: <20250616171838.7433379cab5d.I47444d63c72a0bd58d2e2b67bb99e1fea37eec6f@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68503bfe.050a0220.4562c.0008.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (4)
From: syzbot <syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Tested-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com

Tested on:

commit:         e04c78d8 Linux 6.16-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5ee82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f72e140c622500d
dashboard link: https://syzkaller.appspot.com/bug?extid=8b512026a7ec10dcbdd9
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ae15d4580000

Note: testing is done by a robot and is best-effort only.

