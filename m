Return-Path: <linux-wireless+bounces-29771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D35FCC0B91
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 04:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F30301B484
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF751E3DED;
	Tue, 16 Dec 2025 03:33:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F61D90DD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855985; cv=none; b=satAwM9YHwvC+Wqgb7y6dlWINHwqneryIMFirDdFDRpipjBItYOJyUUs1Mp7EQCC/7XibxI2gbbW2ze//rPOYhipClLwBOx6zopBP4sxxZD9sqBvw4N+Uf8p25rithj2pGMNCPJVhQcDqHEh13e2Lxqn04ziP3DIehpDP7AmRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855985; c=relaxed/simple;
	bh=q8GfxMu+gkL4UZqtErhl2nhXb69IchPEij0OfmV1h7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h8KTUadJn11RwJAGUKtPz9juEdDuba1saOWSzh1PNXSbS8PtOk9Qy0pOxsa1m7BPcq1BU9OR6/E7HJQzYENi4zHbgtWHkSLnkSpkX2PDsZcCv4MR/gcTdasIFYNaBxbUqu1R46UzoAzhveiE/U+IIl1cV/TaCY/81ZstCuS1SaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b31ec93e7so7649796eaf.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 19:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765855983; x=1766460783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiZt2J4mwWA/bjQnkQCKEI8lAKBGG+H01b1dJMY8/gI=;
        b=Q6iThaqff3WIWLr1GStk1s0YCn0l21Gqwx/RcGPEKKAdjjOs7uX/gJX+O3wFoLc7SK
         qg0qt1aNWs+g0MoCd35fCG5KN79TxVZeUi7aiy6HhLRM+wenoaonfoD9ppOhUsRm/SOr
         f4kHgwbYiOG4QRjHZeFUO9HYfp0c0x2KFiUoDgv9PqOMlqEsSNhNSOptMQfHcl+dMcgE
         ik265ijkhe5JOg5zxaimU4dJkZzHw60cxgmjbLFsmy010U0pjqMBTS6LI+gx9dHwn0fU
         ePltanpCa/p7MmBd6pZ6yONwvlZU1FOFP0GYHQx4g7AADudek1jUPkpDtbx/+VEmRVot
         inqw==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZYHH6+797MYh2/BrRtWnlT3LI1bRvKgHVIyorT0udi77l7eZFTo6vQjWwmGmrkYkO4n63YFvbj2Il97JNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTKuIhEKnZ3encUZSKB1MvhCjr8+BNO7rS9KKJGyGiXuANCVM
	RwKou8luwiQGrrdcKEP6rpxOtj9cPeNMCW09jzRTIIHClMZAOAXHIongWPDXW6XPgsQ/JHbFBZl
	1Oa8XHjkWGtKsOZg0zvqFrw3reJeZI7a+4wqEjWxrzj8HqfehLtoY6dECC9U=
X-Google-Smtp-Source: AGHT+IF5odtYrwu68ZW3BLPzGhuSIHUuwh4dXBk10cbMge33wddAQdVdsfk642X0qj0kDWvr6MY9DTom6LvHcL6dxaBry+fyKOBZ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b95:b0:659:9a49:8efe with SMTP id
 006d021491bc7-65b4511f7e0mr5381976eaf.15.1765855983235; Mon, 15 Dec 2025
 19:33:03 -0800 (PST)
Date: Mon, 15 Dec 2025 19:33:03 -0800
In-Reply-To: <CAF3JpA4Yk03Zeju9Y4MMSS0ynAP+qrk1fXiu_CGV1G+ffC-NiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta (2)
From: syzbot <syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Tested-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com

Tested on:

commit:         8f0b4cce Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112b29b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e765d013fc99c
dashboard link: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108cad92580000

Note: testing is done by a robot and is best-effort only.

