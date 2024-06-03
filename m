Return-Path: <linux-wireless+bounces-8412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E038D7E44
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086AEB23CE5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54419811E0;
	Mon,  3 Jun 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OP4bcj5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A025FB95
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406152; cv=none; b=GmvkqLdueqtcq4KqpYlVN3+/Aw2sziZom4Cu4qw/mvWQcBftQbVZChmBomVzp/KR/XMoj+OFaXLMZmPQ1Rr+ZQGToCR/FMNAmu30HNyEyAHurYFcY4igvaFpVJ8JyyJje5zwStMDZ3lvPwKXW0SLw2eLftHPDQxkLbFCpFkxl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406152; c=relaxed/simple;
	bh=juVl4ZS6gVuhwW1IQQEKZM1dFRzL13hPFkXy9YvTkLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAiqDu0gCIQ5L0rx5otd1R9uLdU0VIVpHlytGU5DOxB3k2l3OzSaaGS73m3dyimsfkY6Ex8gk51XYT+9CZiL9TT3H20noI+dwkrbnWAy4NQ2I8kdVtOZp0xGW33odRO5BPJKiNZgJOso+ct8LMBekFt/iZC/Y4oYQjim0h2AoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OP4bcj5R; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=biXZIWD1v9hTZV
	Kd+qm0AHfD0kwBeNtZ397Rf7lcyC4=; b=OP4bcj5RoXfNjl8GPh3Khtnfrfzu5S
	2QsIL40M5PIr88oN1/isY8//G5RKCNgAhYgucx+9QEhBaWgOuippevPmHqXXjraE
	/OJk8qFlP2ggcDCYLWktNqWS+xz1pWxZIMF1ZiPwjjSs7rL4FwU7FntDBWqPlcd4
	WPH5xfhmGxZ48/Q64J9lHwI/oqtfjUqzyDdIP2YJUPjz7R6wCq52Yw1rHA4duWZX
	zVyE/T/+9y+mJnSiDlDCqigDIWajYW77nIXTINX+5uw3aQEvbrX3ld82CM4xIQ/D
	pw+HdhlhdlUiyqq0WvvBg1opzwcNKxZdAQ5suf+joYnbZYklmIUdF3ng==
Received: (qmail 1899198 invoked from network); 3 Jun 2024 11:15:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:45 +0200
X-UD-Smtp-Session: l3s3148p1@9Rsxx/gZ6oUgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	ath11k@lists.infradead.org,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	Christian Lamparter <chunkeey@googlemail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 0/6] net: use 'time_left' instead of 'timeout' with wait_*() functions
Date: Mon,  3 Jun 2024 11:15:33 +0200
Message-ID: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.


Wolfram Sang (6):
  wifi: ath11k: use 'time_left' variable with wait_event_timeout()
  wifi: brcmfmac: use 'time_left' variable with wait_event_timeout()
  wifi: mac80211: use 'time_left' variable with
    wait_for_completion_timeout()
  wifi: p54: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  wifi: rtw89: use 'time_left' variable with
    wait_for_completion_timeout()
  wifi: zd1211rw: use 'time_left' variable with
    wait_for_completion_timeout()

 drivers/net/wireless/ath/ath11k/qmi.c         | 20 +++++++++----------
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 10 +++++-----
 drivers/net/wireless/intersil/p54/fwio.c      |  6 +++---
 drivers/net/wireless/intersil/p54/p54pci.c    |  8 ++++----
 drivers/net/wireless/intersil/p54/p54spi.c    | 10 +++++-----
 drivers/net/wireless/marvell/mwl8k.c          | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/core.c     |  6 +++---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c  |  8 ++++----
 8 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.43.0


