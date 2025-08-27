Return-Path: <linux-wireless+bounces-26700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFBB381FB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A41D360BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B822D2486;
	Wed, 27 Aug 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dScKtqKy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110A36D;
	Wed, 27 Aug 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296751; cv=none; b=hQjfI1m433Q4RBVS2qC3YjayebqsRdaRduuP5nfx30xyDpu1ZOMb3GqDpYVmSdYictJPcrqX3ER4/WZE7TRZpQnmi7YZcMLYyTyK4CUq4Ns+3hn4R/QnXN5qMevzPeaS5Wr6cqCJ/sxS4412KlyahsLG5Yt58UvJww8EmxGE3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296751; c=relaxed/simple;
	bh=7E4a4GzpPjW7/FpaJ1H8vDNBJxrlwJc/Hj4acZE89oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHRDi92VSTHjj1C2XdgRcP98XvdGVYzY7X54UiZc0r0X24Z3eJfI7GfGXN5TASLqLL8zz9LbBoqlpur4/X83THJBtDN/Mg4sRI4x/MMNDlxfPtgpDrPC2ZAETlgXyjzl3H/+OYizJrA9WAxLr6lKjGr6wfJFSjBWJ/EwgR5t7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dScKtqKy; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id F089E406B369;
	Wed, 27 Aug 2025 12:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F089E406B369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756296396;
	bh=/gA22ldtxshW49IcS4YUPTSM4DWOpcWELFtKZT++Qds=;
	h=From:To:Cc:Subject:Date:From;
	b=dScKtqKyqSWA7ROBjwbyxRUdw7j3q2CyuNJVI/hIKD23qSmwUUWXX7Jrr7ph9TbRd
	 7hQjMvyqsIOibMYxv02zXvxsjTPiKXqhaCFs/JBWVGSVSjprA+gLld4fsa4+/dfdUA
	 pSufv+Brtu0JfHiqtO2wBsaVsfVG6qt/OsTWi9qU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v2 0/4] fixes for rtw89
Date: Wed, 27 Aug 2025 15:05:13 +0300
Message-ID: <20250827120603.723548-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: - rework fix for use-after-free in rtw89_core_tx_kick_off_and_wait() (Zong-Zhe)
    - add patches 2/4 and 3/4 for another issues discovered while reworking
    - use rtw tree instead of rtw-next

v1: https://lore.kernel.org/linux-wireless/20250820141441.106156-1-pchelkin@ispras.ru/  

Fedor Pchelkin (4):
  wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
  wifi: rtw89: fix tx_wait initialization race
  wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
  wifi: rtw89: avoid circular locking dependency in ser_state_run()

 drivers/net/wireless/realtek/rtw89/core.c | 82 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h | 22 +++---
 drivers/net/wireless/realtek/rtw89/pci.c  |  9 ++-
 drivers/net/wireless/realtek/rtw89/ser.c  |  3 +-
 4 files changed, 77 insertions(+), 39 deletions(-)

-- 
2.50.1


