Return-Path: <linux-wireless+bounces-27435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66342B7D2FE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68891897A6C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DB30596D;
	Wed, 17 Sep 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NliYEzO/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA8283FEF;
	Wed, 17 Sep 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102805; cv=none; b=jQHbG1O5iLPCcf6KLOux2z7fwV3+SFinWw4lyXs0ZllP1FgCej3v6UkU3PdvX0ZU2Gw/leq+vuucwaVlSt1CNbTbc5h8JNB9ErTaXr0mzRnIew3QHS0MoNPebLhFA0jITdX2QJUa+uSrnFkGMg/EX97jDYh5bHo8nbttdD08aC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102805; c=relaxed/simple;
	bh=04RUhDtsNHW/idcs5E03/2KpFyCpCKqHNU4yIjWx++0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kal8D2JTgt34nAOlcBRxSmxz0yqqVAaJ5ijsOy0f4yEsj4AZ5h5qBinKcePi+r9VtkZ1WN1F/DYgE0ZHZmOGscPQAr0O1Tw0XbrDK37GiwuBUa0ZZTAS5fi0BKGCZjAc/AyB+F8lb5CXDkFy53CGhgiStuPKcCg6vfM62pm2UZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NliYEzO/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 31F1140762F3;
	Wed, 17 Sep 2025 09:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 31F1140762F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758102800;
	bh=rtoUIEmycsvIuomoMH6MpqBeiL5mhgUiNGos4Wd1cbM=;
	h=From:To:Cc:Subject:Date:From;
	b=NliYEzO/1E9H/T0+zsEVm2LUtatadqnWQ57U2nkTT2KD7Qn2m/qkNrk3olfVUv9Ov
	 dXX61DoEBhCFmDOkfxglGAx1w95x4QpD8zzvWB7t/+0BY7PhtgM61MYvS9mRZ1ZQ89
	 UIBu9oqoLESClsNifm6DByFPJrfwf1jwEutDb0K0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v4 0/4] wifi: fixes for rtw89
Date: Wed, 17 Sep 2025 12:52:51 +0300
Message-ID: <20250917095302.2908617-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4: - drop USB patch to handle that in a separate series
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
  wifi: rtw89: fix tx_wait initialization race
  wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
  wifi: rtw89: avoid circular locking dependency in ser_state_run()

 drivers/net/wireless/realtek/rtw89/core.c | 61 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h | 36 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.c  |  5 +-
 drivers/net/wireless/realtek/rtw89/ser.c  |  5 +-
 4 files changed, 82 insertions(+), 25 deletions(-)

-- 
2.51.0


