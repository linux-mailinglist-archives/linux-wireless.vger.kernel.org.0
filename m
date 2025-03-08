Return-Path: <linux-wireless+bounces-20025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCAA57995
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99DA172946
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144C31991CF;
	Sat,  8 Mar 2025 09:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F67BE4F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427164; cv=none; b=O30do908CB1Ao7USlqn8NrPjbPFDmEcHXkvuBBrxlCcls8OC+PfA03QBcQX7ezSFlv4ARF+uhFbyMoVQDgj3Huw5E2c3jmKLTcEfDPm3WhJY4N9jlVkD/SugypKs/FwGR4pWtPSGZBmDzdfRZWhxoYgpz6ERtYHT4v5C7ZwhZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427164; c=relaxed/simple;
	bh=FVlLejdFDbutlkTC1Y2NNLbITDrvuNqRxT+XMWiQ0dY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XpNU6kPSTgWXk452HVaJpuefzGURmPPf8bxN9NLBMhMpQn7X0MUrmKTWZs6MWd+KwU5wiv+VuYSvv947/U3Xyn0BmfhrrtMmJFZ/+tCAJOtoDkDmrzHiKh093vSICtrAVMN+3xYGXV2ENRMg5x5zHDRdO3imgsjtFet4bU5qHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85aec8c9633so524183339f.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Mar 2025 01:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741427161; x=1742031961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfAMxlt7hl4XrwSsiM1sMw4spJ1nfH3roCq3hk1GYYM=;
        b=NXkDNh80+m5eDRMNPj7edkq2xPcmhyFyTH6hYqQatJC5q1fjNB5cAHYf3eZqPSVXcz
         vWbxIUEnbS2/RnHclFekfhDCIc4jO83wCdMIMBOHVoCMi/j3bvS66koERZHpZ6PTNUpj
         yHcArkKM2LKcSEro3srTx+RzgrKRKBXOVdCIPyBNt57jbm1m4yYojrN0i89kmbwyfWlb
         E7enThJN9lR50iTZLR/K72E8hzWg2G5X+TWJ7007h3TD8dOMFCLMnxnWjR18elISQOI/
         00Zb3P9Yt9HqtCAG0O809+PfIODNZ6wrn3Fh3r3fiA5MmhGQfVO2D7yjuINyjinHu689
         VMjA==
X-Forwarded-Encrypted: i=1; AJvYcCUts85Ai7TNCTaA02GNO45b0sflsKkLz7O/YxtPFJu8bcpR4I0uzWDznPRDxLBsYH2NIjSk8Idz/oyIMM8Srg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/HXYAdQaPn+kCu3F4ec7+Ond4qiIYmr3jMiUvpxS4E6Xgpla
	0bm9x0ZpDADGubBYNRtAFoQ/vp5rXnHpkFsiYbq+KiWW4b1Quz4CSFVdIza/UEUrbuPlhgLTXM/
	eHl9lCMyeifo3idLIB+J+zNr9PD8PI+wlqqVmmlJwg704BIhPMKJnWK0=
X-Google-Smtp-Source: AGHT+IHvMAYa79194kZw/IW34l/QUa46VgEuUlYlL9gdZcDd8ttqdUVAXZ3b263TFEj87ZhuXJ63fOR+Blft5SPVzovxf1cuCVe+
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3d4418a5d9cmr72973195ab.8.1741427161648; Sat, 08 Mar 2025
 01:46:01 -0800 (PST)
Date: Sat, 08 Mar 2025 01:46:01 -0800
In-Reply-To: <67012223.050a0220.49194.04be.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc11d9.050a0220.24a339.0090.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in regdb_fw_cb (2)
From: syzbot <syzbot+aff8125319e0457b4a25@syzkaller.appspotmail.com>
To: bsegall@google.com, davem@davemloft.net, dietmar.eggemann@arm.com, 
	edumazet@google.com, johannes@sipsolutions.net, juri.lelli@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d29878580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b5201b91035a876
dashboard link: https://syzkaller.appspot.com/bug?extid=aff8125319e0457b4a25
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1561539f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

