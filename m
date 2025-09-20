Return-Path: <linux-wireless+bounces-27533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC3B8BFD2
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F7F1BC6EF0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3621B9FD;
	Sat, 20 Sep 2025 05:32:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C986323
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758346378; cv=none; b=JXyB6KliPdKeJccerNiuO/BEk+bN5OKH77oVd1MQ/Mb0u5YCRqJEnfOBb6hf+fzJKppRV0RcaksTjLlVohq1AC0NS5A0KRoAToVBNCzSsxTd8SLn952IJndwglbj7/jaJlbVOt9fzcKamWd7l82KzKymkuXEYe37tGRm7fJVzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758346378; c=relaxed/simple;
	bh=xTeRPRtb/z82FGWD/vUPHRy2IHIbeXQf6bBU6bc+50M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MJsjSsFXusdDd8HjEv+97BpOlyWFNLNSihWqR8c5gRAZpPMcNizxDBNry6Pkh+bMNJWupqRTQDO2QKyouxA5oxtPeN9tThHc8xxSOiuTdcCzVOq63pQWoLn99Ll0Cp82/nrEi7WyUIwIUCclb2h1u14K8BlLu5vEozW9vx0rPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4240730201bso38363195ab.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 22:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758346376; x=1758951176;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX121JOP+S660ZNIzknKQnVvd/Z/UMYcJSi3DaS1HFY=;
        b=vDpk7FvEWVfb3gbm/1U47pZTl07iXFuU655X/G+ggCbAKFq0bvQ1u0oIFCTwRAI1Vl
         htfqFU/DGilDi1Qo73Az/zh3OnKCMJmVCUBSKayQqGOZVA52gOSdY3Vr0jrE6soKvfVX
         BzOlU7+M0xsLV9qDV9YekncvpxEYjdNC7VERyNtcTtIjx33XrAjaVUhxXdA0VTZd37tQ
         7Nt7kCZr/SnZu2efn0tSDwClJX+AzrNSMDYLrg6Nip9gWX78EOft+6oBp83vL9Oo181Y
         wy3IjwR9NQ/Uu0nLI6GTZvNtrclfmCyQ4soZ2seqbrNN4G3QJdduCVXo2GHhBdT+2gA/
         37wA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Go2w+2zJmBaVQxmpsOruQLGi0cGVkYuGwMNro/ivEJMb9lD6S9XCR8FqmfqPD5/C+osZDkgvDH2CdSz5Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4a//xs9Ki/4/aQOQsQiDAnCeDov9a6ENH6n0H8nPd8kradNZF
	qi+UOptTFJCkuIdrtUPv7EPBKGz/+K0iATnLXKciUcd4/2VBk3HOFgOKtTzOlmCZavi3U9dkRnG
	GFsxaMCHpWyxGE+1U0NgJ5HasGUiDEgi1dTgORvaFferPre4wYifVVGrbIC0=
X-Google-Smtp-Source: AGHT+IHhK4BnYrrwCEZIkw3iAnrm1xFmBEpN+VStYxwu7lVPH3kl9aQlZFRg9YSvloeaBEvkfIA9nTGbylEA6J0COoSho7qN9W+R
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-42481999d70mr77858665ab.26.1758346375960; Fri, 19 Sep 2025
 22:32:55 -0700 (PDT)
Date: Fri, 19 Sep 2025 22:32:55 -0700
In-Reply-To: <20250919122325.f0abcf092b9b.I04478fde87a79c7909f1cc4249430deaf71e8bd0@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce3c87.a00a0220.37dadf.0025.GAE@google.com>
Subject: [syzbot ci] Re: wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
From: syzbot ci <syzbot+cib69b4e10bd070489@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, 
	lachlan.hodges@morsemicro.com, linux-wireless@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
https://lore.kernel.org/all/20250919122325.f0abcf092b9b.I04478fde87a79c7909f1cc4249430deaf71e8bd0@changeid
* [PATCH wireless-next] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/56aae9dc-2280-4bc7-9761-a0d119923350

***

kernel build error

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f83ec76bf285bea5727f478a68b894f5543ca76e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/9c1d861d-4d4d-4c90-a946-8769043ca3e6/config

net/wireless/util.c:118:20: error: use of undeclared identifier 'IEEE80211_CHAN_1MHZ'
net/wireless/util.c:120:25: error: use of undeclared identifier 'IEEE80211_CHAN_2MHZ'
net/wireless/util.c:122:25: error: use of undeclared identifier 'IEEE80211_CHAN_4MHZ'
net/wireless/util.c:124:25: error: use of undeclared identifier 'IEEE80211_CHAN_8MHZ'
net/wireless/util.c:126:25: error: use of undeclared identifier 'IEEE80211_CHAN_16MHZ'
net/wireless/reg.c:1734:18: error: use of undeclared identifier 'IEEE80211_CHAN_1MHZ'
net/wireless/reg.c:1737:18: error: use of undeclared identifier 'IEEE80211_CHAN_2MHZ'
net/wireless/reg.c:1740:18: error: use of undeclared identifier 'IEEE80211_CHAN_4MHZ'
net/wireless/reg.c:1743:18: error: use of undeclared identifier 'IEEE80211_CHAN_8MHZ'
net/wireless/reg.c:1746:18: error: use of undeclared identifier 'IEEE80211_CHAN_16MHZ'

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

