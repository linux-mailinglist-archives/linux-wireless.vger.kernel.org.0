Return-Path: <linux-wireless+bounces-26476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F0B2DEF7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D47A626E68
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D1267F59;
	Wed, 20 Aug 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eSVkGv7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53322652A6;
	Wed, 20 Aug 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699301; cv=none; b=gXQL9MzoGtaeJGrhaYegmyA1ay+84Z9zUF2w2XoO7zYQjJMkA7dWvCihGxI4WyZKRSHKlurh+ZKgC5yxMLGOqIBE6SPU/iF8hJB83bAyMYLr6b0zAlk5Rz+2B1eRLCQeGbjqTqePvTqjCCRJ4ZW0TTRZ9rkh4zMawnGZq+eUJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699301; c=relaxed/simple;
	bh=rsxTjOzuGU8tq+hKC0tKVJ79OHi9uwuvxvDedKZGGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/ULX1z19oRhrg+81V/Q2B8wI8eLko3l79wtKWe7vJZm1M/x/Da9RZh8WxBsURY8d9aHi1YbNAvjTEfibjFe8lBITQ4+mDoMiO52pS6EO+ivgv7VLg1wdSap3CiLlJHuYG1+6Pn6LypgOoVLigWtujEU/I6S7ENATno7KHC3Vj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eSVkGv7u; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 351C84028386;
	Wed, 20 Aug 2025 14:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 351C84028386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755699294;
	bh=hgIX1iBclvwy7FW6szHuMilFwoBi/0i8pZrvYUbLHzc=;
	h=From:To:Cc:Subject:Date:From;
	b=eSVkGv7uCfcBeOIIEXL28EyHjt2swwYsTcCM4+dx7cbHbCg0miJe9bjEqEHzlb37J
	 FDUmWjl+T/k6E5OMhZGaDVo6G1W01Jc5TIN3IKyIoVLv7nssgD+qwOUEyBzBMBgIKX
	 AgbsvOKIXPalAafkhmSi4/YVBIdUDRzCXptPWVUE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 0/2] a couple of fixes for rtw89
Date: Wed, 20 Aug 2025 17:13:44 +0300
Message-ID: <20250820141441.106156-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here goes a couple of (random) fixes for issues with rtw89 driver observed
when tinkering with it on my side.

Fedor Pchelkin (2):
  wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
  wifi: rtw89: fix lockdep assertion in ser_state_run()

 drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 32 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++--
 drivers/net/wireless/realtek/rtw89/ser.c  |  3 +--
 4 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.50.1


