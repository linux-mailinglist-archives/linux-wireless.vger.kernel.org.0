Return-Path: <linux-wireless+bounces-25440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA2B05143
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 07:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499C64A6AC3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E82D3EDC;
	Tue, 15 Jul 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KTYrqkRE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD517C77;
	Tue, 15 Jul 2025 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558695; cv=none; b=u7CMMzmmsBxQxFXxdbyVKw0eDkdFkwqUe+ZFKhP9Zh+n0I7esbSCxTM/SwQg18zEHerz08++nwx5mxzJU9mHKMbLN1uUNWjgbU/KsvP3iONWypUHf5bd5RSL3xV3MMOPVNGeMpsJOrIKB5ieQEAeuybRM4fIZtQd8dydNgQHBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558695; c=relaxed/simple;
	bh=s/Dqm28+6crG6/gzftfktkgxOCW1+sxig7bCEYcd7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/8k5sUnD3bu9XbADOLycx1tIYSV4Q5Bk+jqjHwQCtfi0cC4LhNrsUOck6IRN7mFIzL4SrkatQ7uhOX932Y6TFjyJzVBjvzwpeX9Jr82rIpaLnjpbTc+GJ78EtRJaztbAbPA6l0jvWYD4etxmsZR/Ut5JeTYXlKrUz3mDfnT/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KTYrqkRE; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752558651;
	bh=uv2frqJmoPkRuUwQWvQxvEoYNkWHtPq5m+Pzp+qcrpw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KTYrqkREINUqs8IgY3U/3zE4sFhMpQmQNBenCF088PDAn7t22hMQby3+tUBlsOSsu
	 R/tW+GOQGcYuLWl3oZzlDOaUOPTmXJdu7g05vNY/PNPWBG2oHSS50TyV8PJkrzJRYu
	 YYeQEUMgSsBHoQPloqRpU04qUkFA4xNwQamvJ75c=
X-QQ-mid: zesmtpip3t1752558639tf674e097
X-QQ-Originating-IP: yYCG/tvQnBJ1/jRM0vHDh/yL71Kyn+I4eZmCz0NDYjU=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 13:50:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9200968222009094791
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: miriam.rachel.korenblit@intel.com,
	wangyuli@uniontech.com,
	johannes.berg@intel.com,
	akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	emmanuel.grumbach@intel.com,
	yanzhen@vivo.com,
	shenlichuan@vivo.com,
	yujiaoliang@vivo.com,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: [PATCH v2 0/2] wifi: iwlwifi: Fix typo "ransport"
Date: Tue, 15 Jul 2025 13:50:31 +0800
Message-ID: <949F0ED6008D554F+20250715055031.928947-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NSdGlEeiHj67Oiu1A4/vs1WDu18PWxk6FvSIdbkU+lwOa8sNzyHPTLUx
	6tGcbGRyBYZomY/bOxWg4d0n0btmPoYgWdDoJDKisRKzqygvmiG2wGp8T0wNvdXEXbo6PSN
	nnkbjgCivg8AhED9+M3IWCSSueW7HIQrrp7M7QWHxK46NbIcT5TCL8tQNJaL18xlA2/Fh5y
	S2I0WNJqe3iRmKgi43AjQLCbVGbEwAD03piAE4PpDRLayoRar4ZwvPQKzDi6BRzcn+vpw6g
	pcob/aWHSz1sjfIIJAhKob+xK5ysSnkleEkoO/BFgr5zRj/QHN9oE/QHTkoX7VOv/NOJoak
	AyaTFU8DQGnKDy67XFUwae2Y2aCuQEu8saO+4KI0PJThn4HYBnWA7u8iSD/fEZFOLWKdtTK
	zXlLkyvWuBjAUGRg1UR6bGYNQaKbgJROnxoS7zLxYSVgaPu42G1IegSs8BA99+s4MaZhlkp
	16rbq/m/kzoXJnN+HtWjbOW3SJCNYpHkVC+HUtM2gMgMQzMN9nVcZs9C6iwIcVzciSJW+lP
	y3m3b3dJ3M5dM8IpgBSCrwU3Nh0t+VgjnwyslTRf2ylz71FpqLF9xnB9f0oZPfT0bzoARg/
	n+qq/TE7CFLzvmvIXMy+0ApM6LqtQ1E3uu4XFOoiFCb7J98gCQAS8JogovPZoEOMQqQ7G8V
	lm+YclKE9mcpBPC8zYRFSJ8AARJt/kdZQIEKMnK0HyAQ5uj+wNWtPfbgE8XLBbzLlZzuUGQ
	LQdzkX3XipyxCJECKVPB+MR6fNX9ovBReUtM41y44pWf8R9eR4KcexhydsexKO6P/sA94i3
	EoG97zNbN24Ny5M3on58wH9NhzzQkQ7Bcb/1n2/uE/ma3IPbhPHJZ78S9gsh9Ukf4s83DjC
	hpOpgtlbbGt9ABnK4sSW/L1AWVnKiYEUcZnsCQTYUWUC8PkxectFjWE6pdp5vG51t3E4y+M
	qToJhqc+pMva/iz/RX5qF37HvIN9a7G9Tv+8HkCA4l4MJ9AvWrG6dvLdDe9oOns2BIzcFBe
	eumDtTFDqRNb6mhaH6/ZwnicAgxoROBLCj2x5H0uSW/edwQCqO5Fv6pBmnR8Zn3fqq5d0D+
	Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'ransport' in comments which
should be 'transport'.

This typo was not listed in scripts/spelling.txt, thus it was more
difficult to detect. Add it for convenience.

Link: https://lore.kernel.org/all/03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com/

WangYuli (2):
  wifi: iwlwifi: Fix typo "ransport"
  scripts/spelling.txt: Add ransport||transport to spelling.txt

 drivers/net/wireless/intel/iwlwifi/dvm/agn.h | 2 +-
 scripts/spelling.txt                         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.50.0


