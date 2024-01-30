Return-Path: <linux-wireless+bounces-2826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F08427C6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A701F2782F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676067CF2D;
	Tue, 30 Jan 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbNSro1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E296D1A8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627759; cv=none; b=WgiCIkU8U/3UQZYBL8nM7f5HvRdA0F1Yf6pLBJxsRlJcDvzGqEflnAKn1YL6RjoE2TaX/RlC0kUqTgl3699FRYLnmxdcB1xTH0OYtfO4vC2IqSLff0lQfCdnBGcwoQ6g/SlIWXNRX2ZEdn2qJnQlNc+q/bnIOzzUeQKMo7Z3jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627759; c=relaxed/simple;
	bh=86vRnQqRdAbUlaaLNIjmhKVJ3wUiUzByXT0xpvlGWgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxvldg/ljZe7FDespchz2ur3/B6RPnTe3b8q1RbGFMVMz1WkLtGSf4EG9Z1j9KeZpuTZmAvitIPlnYNQLe9TxS9yPutnTcXkYneVGDoGxLkgbV4MCwFF6UAMw9nH36Pw0hxnQnBpM1bd2VINRFJNaJhiJrSDb/w5DfVnnBC+CWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbNSro1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B6C43394;
	Tue, 30 Jan 2024 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627758;
	bh=86vRnQqRdAbUlaaLNIjmhKVJ3wUiUzByXT0xpvlGWgw=;
	h=From:To:Cc:Subject:Date:From;
	b=YbNSro1KELtitIhduPDSK0X4uBmYW+BH5OUVXgthz3dZ7z1JQOFjle9g5Kab+ujkx
	 IYZIGeP2q/iNibmKNJeOfDDpN1D/Xh0MxLFwmTYydi37URw7gFfz6hGrxRpGWJiobB
	 vg9mhGwlbRGQjyc0ZFIE4CKvnXDdEKYw9DB/m8fzA8N8FWYrdwG7yAF9FEnzWklPIp
	 x/ukVMFflDTVP3WBUWfCldrHFTnq3FeFFKsznhq1cLLVt9YqtA2MiGB+ZRfRJDVr4F
	 fczookTbaqOqoI9vkFjR0nfj8Up9ewckYlPUapFdlbmUJfmhLNigPlN+fLb2LpSVDC
	 Jd8hYZ4PAz1dA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: xl@wp.pl
Subject: [PATCH 0/4] wifi: drivers: fix some sparse warnings
Date: Tue, 30 Jan 2024 17:15:52 +0200
Message-Id: <20240130151556.2315951-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to reduce our sparse warnings, end goal is that wireless drivers would
be sparse warning free.

Kalle Valo (4):
  wifi: zd1211rw: remove __nocast from zd_addr_t
  wifi: rsi: fix restricted __le32 degrades to integer sparse warnings
  wifi: cw1200: fix __le16 sparse warnings
  wifi: rt2x00: fix __le32 sparse warnings

 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 15 +++++++++++----
 drivers/net/wireless/rsi/rsi_91x_usb.c         | 12 ++++++------
 drivers/net/wireless/st/cw1200/cw1200_spi.c    |  6 ------
 drivers/net/wireless/zydas/zd1211rw/zd_def.h   |  2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)


base-commit: 28b3df1fe6ba2cb439ba109f095aa841fef3a54f
-- 
2.39.2


