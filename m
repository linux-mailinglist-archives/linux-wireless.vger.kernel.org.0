Return-Path: <linux-wireless+bounces-11591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF8955EA7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 21:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095141F204E0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE9149E0E;
	Sun, 18 Aug 2024 19:19:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA32136E0E
	for <linux-wireless@vger.kernel.org>; Sun, 18 Aug 2024 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724008744; cv=none; b=E5lmVFMllt0QORPljXZXYbK1ULOiMhOB52PZQ2nsta4q+LBw3nN4krrMlHUcHI1t9wbdYYyIKbwF4096vbUWhmhGtSVGseWv8YHBcwwqIOtgPdrkyCbPv88oXYndpFlR912vlLCYOKbQbIRFfLLadbuzC8Xtm40i5PyV09eLESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724008744; c=relaxed/simple;
	bh=V6+i9ZHd86Jftzv7iEO/OGkHm+A4Id6bY7y6jhrHVBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qfX8x4ZYCBMNpZX8SShOLZDGWz9iZoNPxw2NIlj5FuacwLPd6Pvjp+GRMurnRZf3pjTYtpkkzmA09u9/xGwjwF6YXGuzBjUMVmfSl84BHwBN8yhKIo3ZLuupbeBVZIqWpfUWxJC6M5/xxPeqHxzv51XngLeb5KFVoo70GagaNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d10b6da2dso36223495ab.0
        for <linux-wireless@vger.kernel.org>; Sun, 18 Aug 2024 12:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724008742; x=1724613542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOn7k/gf92spm8LI+iLgdIYChmze6niofBQwCBXRuGE=;
        b=a6ksMUqI9oPSKWTAH9qGRH9/fNPuaNIgwB+KsZMS0iUkDl8iifoFIhhTvrRvQt8F4f
         9JqlbiEiGA0HOCEAHsmV8KmXl8pQNP2cbEAjk6acm36CotR8RaQ98A3vZAmb5NiQZoJy
         5/M/44Vhgl+2Hi7yC1RrWqlNbtBaElYwGttILZNPIJRNBLxN63mS9UpYCnHVN/BuJP8H
         ZlokFXW2tBDrWLuZQTXfjbPvIQeBkPCVn9knUNh2tYvVIshb6zIM9RfEgPQciIA2vPUx
         Eff3y4frlw5k1YBR++T1Ty51ytcl5I9zhdR5b349OSHLF/C7j3I66cg7a7bseVaU9e47
         fDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXYzkoJsEdCHjedFX0ldPQcaQdQFwKh2gUobp3dEZAo42umsxRq7w00Ie2thK3ldVDdPHGro6SmhnfUYQ71qXR5+nvYWEI8ny7N2lQa2EI=
X-Gm-Message-State: AOJu0Ywr65QaV3gYKMahBTAy4hRzx6p1zOnt5tvEdNMwDMDM5H5A9A5w
	qQtzmOX3cTvufMiPpfUP5Zwf63j0WtvG4XaDjfCG8g+7KE5MxXiojxLywTvlfcF3syGBzumCY69
	n1to9WUm4tEZflo/qiZn8958WFRIXoA/8KMj3wn3+tWYk9WTneW9l3HM=
X-Google-Smtp-Source: AGHT+IEet1fM8+b3ovFLzqGlZdbvkZDwMB2WRcSgR9DQgyJRsVgqllfm0eD++outR/I0JQiH4ZYqp+gTlF5cvJ7CXE5gZrbqTXyY
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39d26c36cfamr8712765ab.0.1724008742349; Sun, 18 Aug 2024
 12:19:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 12:19:02 -0700
In-Reply-To: <000000000000612f290618eee3e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad7bab061ffa109d@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_bss_color_notify
From: syzbot <syzbot+d073f255508305ccb3fd@syzkaller.appspotmail.com>
To: angelogioacchino.delregno@collabora.com, davem@davemloft.net, 
	edumazet@google.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, matthias.bgg@gmail.com, 
	michael-cy.lee@mediatek.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4044b23781104801f70c4a4ec3ca090730a161c5
Author: Michael-CY Lee <michael-cy.lee@mediatek.com>
Date:   Fri Jul 5 07:43:46 2024 +0000

    wifi: mac80211: do not check BSS color collision in certain cases

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130f62dd980000
start commit:   f6f25eebe05f Merge branch 'wangxun-fixes'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=bddb81daac38d475
dashboard link: https://syzkaller.appspot.com/bug?extid=d073f255508305ccb3fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f9ec92980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1595fa84980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: do not check BSS color collision in certain cases

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

