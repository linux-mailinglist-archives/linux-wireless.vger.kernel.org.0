Return-Path: <linux-wireless+bounces-27527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C02B8B480
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E249A80C39
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C342BE02C;
	Fri, 19 Sep 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="MvwD/OCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278235942;
	Fri, 19 Sep 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316173; cv=none; b=UStCgUe/mKMS0UpimXkgPvwlPc5mSdW8m5domDxqDcLdEuzOSwtqdQG6lzqMrp0/ZE/6XjcDBmVCr82GMS+ctXyPa21wAmcxF1cNicRdewEVMuok15LcbY3Fwh44Rb5Lqg8E2T8GkeMfi5+MTKfQtBh6a7xJpXC0UyvLpFp4mpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316173; c=relaxed/simple;
	bh=O0ZXsbd6AYMKjKrHkcKQIn23yqwianTGxtTIdCG0AwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qw4LUFwvGKx7NThR5F0do5EFf62vyFntiOdr+yMMi6eUxSiguvA2FdUnqbvxta4/NFhgBZOG7vZRI/PJNCV6KhWZxeStruT7Z1TlmmMzPJ+83yfNwXI0uwMVuILZ5j6JXPHrUT/KKpfHhKDLPRaY6siB5E/FB57Lk+kl3W8Csts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=MvwD/OCS; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 82D3140762F1;
	Fri, 19 Sep 2025 21:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 82D3140762F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758316160;
	bh=25wki7cvcxiB7hRlRKZdhsz2xMqyXfX0d8XKeEcmigU=;
	h=From:To:Cc:Subject:Date:From;
	b=MvwD/OCSxcTfIMdm8G7XTtW0a+15Zf6i1cqYxXPYABAxXmNkDN6LXcQkIFXSA2S5D
	 +RsBGxBLrALtBlAFNsHzTSU/G/O1ba8khHvD+s/BPuGJoJoRVIuuW23YQkXDs44aYn
	 7ieyl4yUzRxXK2mfYnRaGKcQwEwQ240rtpNYC/Og=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 0/4] wifi: fixes for rtw89
Date: Sat, 20 Sep 2025 00:08:46 +0300
Message-ID: <20250919210852.823912-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5: - respin at 'rtw-next' (series applies to 'rtw' as well, just in case)
    - further changelog below --- in the patches

v4: https://lore.kernel.org/linux-wireless/20250917095302.2908617-1-pchelkin@ispras.ru/
    - drop USB patch to handle that in a separate series
    - further changelog below --- in the patches

v3: https://lore.kernel.org/linux-wireless/20250828211245.178843-1-pchelkin@ispras.ru/
    - further improvements for fix for use-after-free in
      rtw89_core_tx_kick_off_and_wait(), see changelog below --- in the patch
    - add patch 3/5 for USB case

v2: https://lore.kernel.org/linux-wireless/20250827120603.723548-1-pchelkin@ispras.ru/
    - rework fix for use-after-free in rtw89_core_tx_kick_off_and_wait() (Zong-Zhe)
    - add patches 2/4 and 3/4 for another issues discovered while reworking
    - use rtw tree instead of rtw-next

v1: https://lore.kernel.org/linux-wireless/20250820141441.106156-1-pchelkin@ispras.ru/

Fedor Pchelkin (4):
  wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
  wifi: rtw89: avoid possible TX wait initialization race
  wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
  wifi: rtw89: avoid circular locking dependency in ser_state_run()

 drivers/net/wireless/realtek/rtw89/core.c | 66 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/core.h | 38 +++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.c  |  5 +-
 drivers/net/wireless/realtek/rtw89/ser.c  |  5 +-
 4 files changed, 85 insertions(+), 29 deletions(-)

-- 
2.51.0


