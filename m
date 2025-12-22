Return-Path: <linux-wireless+bounces-30038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ADCD4821
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F121630057C7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E021FBEA6;
	Mon, 22 Dec 2025 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pjT/Ynq7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29718DB35;
	Mon, 22 Dec 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766366589; cv=none; b=jU/ML8T0eeehSfrgNs048fSURcDobWd50ruv0xmK49umimTaG/OE6i6CbYO7MkyVPSZpHecv6qjOYurEhFs0mMv1wM1fz1fB94MnaeFqe47zhccewH74dR6l7evaET0VDa95NFeVMTPZUdJx8kFFOON6gZjDEDB+eu4xCz4PIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766366589; c=relaxed/simple;
	bh=XelR5Aboip2n+emOIwsc/yMYcvSRQb2j2oqTN68cWJY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=LDSDw4gAKCJwR188w9XSQzvMZwHxMvRumMXTvA1bEzSvH2amNd2S4FFNnh8PmcnBUPrl7wRYWOQOD10z/7TsrYpXToBEFnAMFAsGxAjQYIn6ZZMhDCoQanenhSLzhTSzzTADHPOP7/TROq3SET53xvxoQVSEGXVfPPSZ2GiCM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pjT/Ynq7; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1766366573; bh=XelR5Aboip2n+emOIwsc/yMYcvSRQb2j2oqTN68cWJY=;
	h=From:To:Cc:Subject:Date;
	b=pjT/Ynq7Rqs2mPAQnl7PjKBu+C6LfdBbJW7Kdk5gNQ2NyY5s+L1OYy3IB2Z9/950Z
	 OVOPRxsH8SdDD/9RCVR7oGHpCjSToL52ITH22mukELDy+loon5N6d8Faqp5GmEkKor
	 aAXfFoGDyKRtpIsVvln8AGD3ICyO2gWg3TnzHbRI=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.19.144])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5B220CC5; Mon, 22 Dec 2025 09:22:50 +0800
X-QQ-mid: xmsmtpt1766366570thv2cw3dq
Message-ID: <tencent_3BA74A77EF2AD7EDD9A776C6A58EC0EAAD09@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlvUOVDqBTeRL8Tp7IZgI2hNO3bNyDML9oCikkwvv8Dmx/A3Vrc+
	 0PNFkIySsNPQAS82r9KN6ly075AdnWKeE7S/7oH53N2rmjaMJi8KLJ3rQ0IbZG5gdY4YYBuyyDQj
	 nGtSPs8wgbfEXOKFMODTVn0halsdatpUH3WXZOR+eq7v+D2eapM+bqcU2dRaUl9fcZZvaC3pV12E
	 jE4uVV8tf/8TGBp1bim/EzOTRD8+vWoCwEKH5GBF1MFsJ2nZfqIWNyopaVqfZuYW2Vr6Asn422Kn
	 40LweFCCuWst4HbNUJRaUIsYEKAHAVA2+4AOx1nMugXyjHMoXca0IdD3dfr99tDskpGL27FDU6rG
	 aQgBXXv10sWEJxC61UeCIFwrP3NBCjL5mVsDWV1wousV5LK3mhXXvBzixMnSSfggTpvJwzCmNpc6
	 D0ySG0E9CdletVm/7OYryRx36VeuAQAvsgYdC0YgrFiwp14ZYTa4ecjnxF3ROBqE4CWKfAbt45mS
	 Yneej2Q59sBZkLBcdvGurSBMcIHowx6hq6NKOjWqdylfCe4o4rrsOkTAy3PI/EE6wUVJY9UWARTl
	 LCLZGMz2PBHtCuU5aOQspoeyuKfofO0KnfaFTdAIB5dlQXV5aY+S2AkyjhnIr+WeDfSSqRTHkWm6
	 SdURRTqHFR2V5VHN5XJJTIpo589kVaMS0sCqq6uL76pZJRnykUtnhrx5HjfJxyFObsYmZh78YqrF
	 g3UJ0/PQuTFCp86ewCpFOr7ALvOV1IAyQJdyWw2s9rFzUanaNYYIWKrZKPUY2EslcmVmIADnqW2g
	 8Vmkx5NxbQN6BFHxbm/UXyPquEirHZHQgNrPQwaoDwPnHFSmmfGaOSHenGyrRpfKgpeOcf36OkIb
	 /x5XbXyDGmaDdnex9OEi/BshA5ctB6SJeEkz1MU3P0sBDYfdrLLvxG9mSli9bIkTi99qAPXrIwfD
	 wNBoTQyt7md5z1w1hw9sC37NhAKBov
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: cjz <guagua210311@qq.com>
To: linux-staging@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changjunzheng <guagua210311@qq.com>
Subject: [PATCH v4 0/3] rtl8723bs: Optimize error counting logic (remove global variable)
Date: Mon, 22 Dec 2025 09:22:45 +0800
X-OQ-MSGID: <20251222012248.26568-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series optimizes the IO error counting logic of the rtl8723bs wireless
driver by removing the unnecessary global variable and adopting local error
counting. The series is split into logical patches (per Greg KH's review comment)
to ensure each patch fulfills a single, clear purpose, which greatly improves
reviewability and future maintainability.

Patch Breakdown:
1. 0001: Add independent rtw_check_continual_io_error function (single responsibility, includes old function cleanup)
2. 0002: Use local error_count in sd_read32/sd_write32 (eliminate global dependency)
3. 0003: Remove redundant global continual_io_error variable (clean up struct)

Changelog from v3 to v4:
- Split the monolithic v3 patch into logical, single-purpose patches
- Fixed all coding style errors (trailing spaces, missing assignment spaces, indentation, blank line alignment)
- Added detailed, purpose-driven commit messages for each patch
- Added version changelog as required by kernel documentation
- Added this cover letter to explain the entire patch series
- Optimized the new check function to remove redundant ternary expression (more concise kernel style)

Thank you for your time and review!

Signed-off-by: changjunzheng <guagua210311@qq.com>
---


