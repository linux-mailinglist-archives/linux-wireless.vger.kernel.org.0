Return-Path: <linux-wireless+bounces-17089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD095A01BC3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 21:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88AF3A2D61
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77014B956;
	Sun,  5 Jan 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="QPN19M5T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CD8F6C;
	Sun,  5 Jan 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736108729; cv=none; b=ApJq4MwQg/lTNo6d9fXUZ/FuZj6SV1KycIIJDWSepuz8ktOKrJmL0mnShJL7gkF6UkEt6DmNxpW8xlxyBNCntUxtBmIjHw2Yope8+mTlhlG9dGuyTj6jdHACALVEzp1i6C2skhtbCJjAtDF2uLF0VmjsdRaXL/3spcTsePYr5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736108729; c=relaxed/simple;
	bh=Hq2gKvA1CqesACN6IikgyuFGQvWRYxrMBEyLT1x635g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEZfwaPb1vM00qe3Ahwsp+VkEk35X47cWWvD5innJ0JhnpFhh9mvexDelftOn/ufE8Ds/IbL9GAM1VZ/wtWzw+uhIVa8ShRcaVS0Pvpt50A4qviYRaa2oDQHmWqZJXrjzLlVgZHQdfisNAeW9FrB493Oh3rP9F4AfcXAtTuoJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=QPN19M5T; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736108716; bh=Hq2gKvA1CqesACN6IikgyuFGQvWRYxrMBEyLT1x635g=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=QPN19M5TazT5dYLJxXI/ac4snosyMAltEvKL/xccWR0ZKlNbrpDdw96PJbm6pyJrO
	 3jmfmY4Xmh5/aFBwHe2g5Q2u1Vj6BgVSHABOKENtsl/JweNodsfhQGCCqSgGghI4qw
	 sU26QHlB7jzErhLOkke7L2cCtp+gJ77L14xOoNJcGMsxMLBTMMo198YaVo6eOcJ9Ag
	 uLEaxnAWTQIeXhyR1HF/Gm8V/Y6760PYl914QTi0Lvn7vMwdWSqaCpuvPqh8ViJjCX
	 +W8Bt7kjOVFWPPBtTuLZEeDKYNF62FlVqZH4+3oYoC0Lwl7+wlnKKH6sttsnm34qHS
	 IGaZaf3MH154w==
To: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 ath9k_hif_usb_firmware_cb (3)
In-Reply-To: <676092c8.050a0220.37aaf.013e.GAE@google.com>
References: <676092c8.050a0220.37aaf.013e.GAE@google.com>
Date: Sun, 05 Jan 2025 21:25:16 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cyh16mab.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com> writes:

> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    78d4f34e2115 Linux 6.13-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d10b44580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c532525a32eb57d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166cb4f8580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/297b40bb0993/disk-78d4f34e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e3ec807b99e0/vmlinux-78d4f34e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/226a54b87ab2/bzImage-78d4f34e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com

#syz test

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index fe9abe8cd268..1cdc723fe4f5 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1153,17 +1153,9 @@ static void ath9k_hif_usb_dev_deinit(struct hif_device_usb *hif_dev)
 static void ath9k_hif_usb_firmware_fail(struct hif_device_usb *hif_dev)
 {
 	struct device *dev = &hif_dev->udev->dev;
-	struct device *parent = dev->parent;
 
 	complete_all(&hif_dev->fw_done);
-
-	if (parent)
-		device_lock(parent);
-
 	device_release_driver(dev);
-
-	if (parent)
-		device_unlock(parent);
 }
 
 static void ath9k_hif_usb_firmware_cb(const struct firmware *fw, void *context);

