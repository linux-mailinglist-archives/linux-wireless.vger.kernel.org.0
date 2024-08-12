Return-Path: <linux-wireless+bounces-11311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C930594EE2C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63900B222B8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE817C228;
	Mon, 12 Aug 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="WmDWBO9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FC17D354;
	Mon, 12 Aug 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469484; cv=none; b=fWO+vSVaqwwpXQP1SNtljIlZ/YVkATlr8qian423BjyL+SNUNaiQdvAOaC0TJ9F7EvC4caQzRypui9AeJnpWKqEN1po2GiqMVAh3EOxUVCpJ01BmKIzD9KsFkY8FdUwbT0WVpV8xX4ZXybhpQwjXtbemA6XkPj8UE4+HSL0DiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469484; c=relaxed/simple;
	bh=rX4ph7FDXyoa+nmXEYzH7RjdqurTlOhvOAg2rhHAoG8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2w7iWGtKY3Oc6cCz+dCwftLdUiyGaUV8qIoWKLvGFXa9gRjnU2GlkzFcvRvaxJ+54ondvLXptK6VR3mKjyW+Qcpf3P8dwOtMuHJeE0N3pR1ABjygEWYUNiP/5BCLZDcBzACf5+YK19G79U1sIlpcsc2RW9Eicc2rp3GFFUbSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=WmDWBO9l; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1723469469; bh=rX4ph7FDXyoa+nmXEYzH7RjdqurTlOhvOAg2rhHAoG8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WmDWBO9lXsbpU2zqI3wAtFQCgnFmRgfRijubiYK2IifDEsAahPOahV4GPL3/9O4L6
	 7KgGufm3X/BLjUyH7nBcpX5aIHQBs7ujBFz9ts+/4RAsUHb6qBlGEPmfzH9nEMnVFE
	 CvjrlF7iBwP64+Gc7rA+DOcWAXxte6yalL3POSYid2h6BDJjaFMwnXoq8Dicb+FIM4
	 5NK+2OFKCRTf5bB+xF9Xk17uFamT3W1M8Tz4VGbPfXLo25HQiGYwRiLDH9o8CGssMh
	 mHOMEFaVfoUQPC6REUrzfzbJSYn/Hb1N5aWAK56aleNaIohU2BFqNFNEPxhAnwOFN5
	 dMz6Yh6TldzUQ==
To: syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com>,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in skb_trim (2)
In-Reply-To: <000000000000d830f0061f503c6a@google.com>
References: <000000000000d830f0061f503c6a@google.com>
Date: Mon, 12 Aug 2024 15:31:09 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttfpx3z6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13eb467d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
> dashboard link: https://syzkaller.appspot.com/bug?extid=98afa303be379af6cdb2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/49d96e53e1c4/disk-b446a2da.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f05350d128a7/vmlinux-b446a2da.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/805c7d86a2db/bzImage-b446a2da.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com

#syz test

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 0c7841f95228..f77cb743ca06 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -755,7 +755,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
                goto free_skb;
        default:
                skb_reset_tail_pointer(skb);
-               skb_trim(skb, 0);
+               __skb_trim(skb, 0);
 
                goto resubmit;
        }

