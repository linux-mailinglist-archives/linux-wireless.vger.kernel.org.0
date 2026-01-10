Return-Path: <linux-wireless+bounces-30628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439BD0D2DD
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 08:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2977300ACA9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A01EB5E1;
	Sat, 10 Jan 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="A9M5ZSY/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602401F0E2E;
	Sat, 10 Jan 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768031636; cv=none; b=dw55+uRvpy18mqtoLalKeiQOlx5U+rifuCa6XPoSC2kUmcuhxeFliyvzh/Q4h44rcIs5xAtrma29gqkPmNWilo4uMCxfkiOHSKdW2r3gGAcS5+6z2PLVUn0HlzM5gAic7g9X0yXTYVpPD8kfRYxVjCHdZ6JkARfuk0YJ/igs0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768031636; c=relaxed/simple;
	bh=pfzPB+pL+Vaucy9gfsAdG3O1/Ykt1J2u6vdmWdLKYeE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kb56rUsSOskql5lUiwoHfS7MV68V628f10MeizdQGTRlKimL1pNE3fUip+y+bWX5UnQ38mHvMaEz5mN3D9TMyZDS+UyJSK5ujWmtOY0z6sy21lIIsQDwub3wh+GhuoXjOX09Pkzp3LR7JeSI0/gGkII5AA1Cw5nVM1Xz87LN8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=A9M5ZSY/; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768031632; bh=pfzPB+pL+Vaucy9gfsAdG3O1/Ykt1J2u6vdmWdLKYeE=;
	h=From:To:Cc:Subject:Date;
	b=A9M5ZSY/YSbZr82z/29XIUxymV3FiIcVAQXd+de4ZlkXMvUN6FiknzhFs2nf/SKmn
	 aXuS9tYW6mhRuUyuJqPumtsLs5xZqIihjE5Fy4B2LRoe4OIGWtnQQowG7QnqaHdsW1
	 iXE/vINFvV2RF9LJRq0I1RnyX9zMlYF/uifsElDc=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.75.164])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id D71818CB; Sat, 10 Jan 2026 15:53:49 +0800
X-QQ-mid: xmsmtpt1768031629tv2e7j7ox
Message-ID: <tencent_B133BBCA4EA4D43FD897B55AE9EE9DEBFA06@qq.com>
X-QQ-XMAILINFO: MEx+xBdGVwfVNU1qYpjYUZy3FKdNSL6ZOz65TmWBhhXxV7iYsKXBhXJDvprKRE
	 plTU5tbrYQ/c3MB8iUD7gGztYZFUxH/1M5mLAJbYt/wifFBPz66i/cMlf1S7YoMPZwOXY6mn7paE
	 Bml/DpGw131PGxw5lhEmz0A+yZlsThLvsgwBECHC3VDSVU8quTwXdq0qzYmVZMCT+N41zAQdEkg0
	 QKGEnqEJ2XQwlaEGSPdzpuXL5VdJ7odrA8v/q7rYgMs/PCneMRnBOFFe3MgLiuEBaoj597jbyovy
	 G7gOVMOW8HKwXKV2piVkiQq/a/Lqc33IGaCJJpyJaTL6LMw0k/UyQtNruc/7Bo8VG97MoNki3DTk
	 r5yDXonIbsYejRp3WnfNa3D96Xi4+WvJ2y6MahoUc+6GgvJtCmNCFRLKB+8w9HFDcHTqTc6yuqeE
	 pAGsXK0+M8bCgaD6ent7dV75OMxx0QeUnzJ1ZC8y0TT2IwlHWltAaPoMuNLRGTnm8IUgA/rSfMsF
	 LyZ+FE4DbWw6zWuIMFNNy/Tsi0WZFXzKAWWswH5juDgYy7juc0FfWl3R8Nz+HZfLlyZEJv6d9Bv+
	 4jv7P95UOiK9cgkaPlopD1aouQNwjEtMFyemutBXnShBkjFZxE0wxS061FYrAG4EcLu349bFHqrC
	 OrJ2kS1n3aU6MmXTmZ+cc4Qbq7MI8jEjlipmxUCZQMOesTcTNkJWbetjdd2t1ppAF/ZZgXLrfP2W
	 SNKcmkMZBf0zTdUPyLD18+ChRCgq85hsvChHUNE6vmRkVoOTbSE9h7Kt1jWSsX99BdO7ioCyHw2t
	 6IIMGniWftkum3mJvQ+ZhlBbEO+qbjlFtKlllxmzmo6BDUaSKEp96l8/IK9P9z6nv3JmJeTfmaj+
	 fmQwVSIc8J+3WRSO6J+xkfUmJhywEcBvq+RBYJmLF9x/EOyBy9qE02Cbhb+eQrGdENuzGXQQ8e4B
	 hlCp+PXJ6EjIqKVvvvD68zyD/xMHbetUc/sKtqCBSakn4IfPi5S5K7q6FOX3ftAvslgbpHhB7gDU
	 PzQyP3yvYdRweDHKEY4RjsuPAqtYUnqf6uXvHRbg39m6AjcJWhLZ8R0r3d2tA=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: cjz <guagua210311@qq.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	changjunzheng <guagua210311@qq.com>
Subject: Re: [PING] [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and replace global io error var
Date: Sat, 10 Jan 2026 15:53:47 +0800
X-OQ-MSGID: <20260110075347.4883-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

I'm glad to inform you that I have just successfully resent the complete v4 patch series (with "RESEND" tag) directly to your mailbox (gregkh@linuxfoundation.org), since the original linux-staging@vger.kernel.org address was bounced.

The patch series optimizes the rtl8723bs driver by:
1. Removing redundant atomic_t operations on continual_io_error (no concurrency scenario, atomic ops are unnecessary);
2. Replacing the global continual_io_error variable with local error_count in SDIO functions;
3. Cleaning up unused old functions related to io error counting.

Thank you very much for your time and patience! I look forward to your review comments.

Best regards,
changjunzheng
Signed-off-by: changjunzheng <guagua210311@qq.com>


