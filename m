Return-Path: <linux-wireless+bounces-22286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9313AA589F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 01:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9927A372D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BD225A59;
	Wed, 30 Apr 2025 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qRmgYC/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2034545
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055372; cv=none; b=cutlY75QTXHjRYLAzquBaK/74dO87SoAr21VGJtFLMn48FNa55l/VO3V4CWBPEJwU5lmi2VgByoHaqSE3H3DdlVNsTBvcn4JLsriOHXc1BCJ+MCH3bM577fTz2AfR/sXLHOL8E4bEK+UpBskzJ5r99IUtMscWk3Qm22TqNHKbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055372; c=relaxed/simple;
	bh=k4t0bhckYKkxRmUQo5Vr/y11/rGryXPcCdR3/A/iYGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgaARbYkkUc7O6ubpy2g8QhXoGN8GxeMAFUveB5RK/27l5cWHCC+QLy860ELLgF7rh+ieMco4I8Q7lCqbrEMv5tgHF7iyrwXiz7D2OxU1wEI4bnmu+kV36HYw5pg8fqvGpC4MFgV646fWvdS8mqY4TO2ejE5MLx/urp+6fibfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qRmgYC/o; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.112])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DDE4E600BB;
	Wed, 30 Apr 2025 23:22:42 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D31ED9C0081;
	Wed, 30 Apr 2025 23:22:40 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E99A813C2B0;
	Wed, 30 Apr 2025 16:22:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E99A813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746055360;
	bh=k4t0bhckYKkxRmUQo5Vr/y11/rGryXPcCdR3/A/iYGY=;
	h=From:To:Cc:Subject:Date:From;
	b=qRmgYC/o/w7u9oy6OJN4jrpG0aoKuMQo11Kmef1JbkIzWzzMqbZniBDzKrvhNnB2k
	 RGvKY9o9hYEVEDr8T/Ix65W8vGcV4NUX80u2xHPnjLFTEMdLSA6rMbwsEChaEnXugg
	 xWhuiw5cqpYAZet1yY1/MgPm3sN20T6j203ARpLM=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH mt76 v2 0/4] wifi: mt76: mt7996: rx filter fixes and improvements.
Date: Wed, 30 Apr 2025 16:22:21 -0700
Message-ID: <20250430232225.3943242-1-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1746055362-lMnVaXfx0_cS
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746055362;lMnVaXfx0_cS;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

The previous series introduced a compiler warning in the first patch,
due to an unused return value. This series fixes that.

v2:
- Catch and return error value from mt7996_init_radio_phy_debugfs.

Rory Little (4):
  wifi: mt76: mt7996: Add per-radio phy debugfs directories.
  wifi: mt76: mt7996: Add debugfs file for rxfilter.
  wifi: mt76: mt7996: Refactor of rx filter logic.
  wifi: mt76: mt7996: Allow monitor enable if phy is already running.

 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  78 +++++++++++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 125 +++++++++---------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   9 +-
 3 files changed, 151 insertions(+), 61 deletions(-)

-- 
2.45.2


