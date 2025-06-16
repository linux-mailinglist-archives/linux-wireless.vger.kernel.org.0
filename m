Return-Path: <linux-wireless+bounces-24154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9640CADB2DD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C76F188584F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3CF1B21BF;
	Mon, 16 Jun 2025 14:02:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF64322A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082526; cv=none; b=OsR4yNlkl5h8L4I98QxMdvMm12Z67NO5+GxQsXck09yYtY47A9dYMf1XnoGSfxpbJKszmGqZcJhTBpDtHYQJ/1LX6BH1tUef0l0xRas0wQOlkImkLDpiZl9z4MruIQvpO107hvmpR7k+5WKBRfEaDWps2twYhZTntJhChtsR+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082526; c=relaxed/simple;
	bh=9Frd9UQMYa2OG19Y+kMjlScCyG9EWPILgIPZGhBUXm4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GpdVGhctxBz1EehZg0I+Tz5x2ZigB+067nt/0n517MR5omAxdQnbtVH5tyQ8YEb149SyTgfL0dqDXCMFdMGgE07Wpk07Zt0r+Q/4/s2G28g9/WewOWHnGCR/6y2Obus6w+ZWPfWdOy16lMmwnjPOj3arNZXjAf+jymDoyZGHLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3de121edd59so37212605ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 07:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082524; x=1750687324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qndo+tNttlxMX4JwaGZKdYBVzqCp+i70QHeH3a/wrs=;
        b=syg4hTfH4yudWaSu1GtuSqjfR3uwnQ5Aqu1AJ9epRMs4BXK1DkwRRxWJIQYqYbwf5b
         wDr2WjH/WFjjsObQUJzuqSvm6EF8dknxJMfsFAtqaS7FOD6eaXndpyTZ+3b/jiNxIb1m
         1QwbP1XtekBcRmW98FuMBNVqOtk7srqeXyj+PbRRtMJm7IrQPPGJmpUymDBFqsMvu+LI
         y7Sf7pF4s1Yb5jpl//n6oWLkpyiFu0lbJF8Q+U4xJA7ENyXYey5BHnKQ6yoQSqiuQFbr
         tNw0gHicXRURCmVsmOjdw/Av14BfXaoyhHxA9oJWF34xZUCshrEqWInHJFFZ/QXjUbzb
         WHew==
X-Forwarded-Encrypted: i=1; AJvYcCUqB26CNQwGWY4IcELk6TG6fqDtb9vBroZOVEGHshkX2FT611WjMnzmomL0HJSDQK3nn54E9QdID2k1AnRD4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1KkRvT36iakRiOufnF+SSZaTZc5Jisz0m3oi8HW8SP9FvUEo
	1eG0+uJ85vsinZAguLQCRwJO/GMKszVPXwOd2/hBJ2CGREFXjngsO8sTi9fTrPrfObFdyihqpQi
	mzOU/DVcDvJIhF7S6gyaDTBD+8I9raWA1oj2ip4ZFphH/oqp1tQEfHXzsN7A=
X-Google-Smtp-Source: AGHT+IE+i/5C9z8oae7v58+hVVY/xTx/4TA4WLh3i3xXc+QBTZMa3Pw0c2LNbdaPYnmXt29bZrLwzmrEHJ/UtW6rrU5izXgtUlEh
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3dd:cacb:b88d with SMTP id
 e9e14a558f8ab-3de07cd3553mr103624495ab.14.1750082523961; Mon, 16 Jun 2025
 07:02:03 -0700 (PDT)
Date: Mon, 16 Jun 2025 07:02:03 -0700
In-Reply-To: <20250616154041.f0a3109dfa90.I47444d63c72a0bd58d2e2b67bb99e1fea37eec6f@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685023db.050a0220.4562c.0005.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (4)
From: syzbot <syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/mac80211/rx.c:4436:8: error: call to undeclared function 'ether_addr_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]


Tested on:

commit:         e04c78d8 Linux 6.16-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
dashboard link: https://syzkaller.appspot.com/bug?extid=8b512026a7ec10dcbdd9
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14150370580000


