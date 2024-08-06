Return-Path: <linux-wireless+bounces-10981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C29486AB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 02:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E28E1C22238
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97E4A29;
	Tue,  6 Aug 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="VeHjL0cF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D71878
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904885; cv=none; b=YByxaB3AXGUNS6lE5gbyo/jOoRfPXKviFzOLJPpS60S6u80gsiLO61THpB+odUehXbx2OHCz7b6eUTlC6N+AizRLzVMNOjSuckW+KdnZbG83UqGhF6vSOZuKTOi4DpDnoobeRWzanS/fEkUijxe/6McJPY8KQzd64e62R47PFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904885; c=relaxed/simple;
	bh=MCC7v63D2Q7YN8F536lsvnAg7o8HrHj4djTgSw2npbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c1Kw6+3GMNuzh5HyaCKONvSAZ/Pm2SIoXYYHKQPiuR8qftDvyeTWWqMQmAyBSDjFsSg/qq+vPVJugQxbBUkBENaHc1PXrdWAZbhpzU+wCZPFp+OBJF3LVYo8w0vm2IsQJEb1IeAL3WgMOeNQIuL46UcOPTYll4LunV6WCj6Ii7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=VeHjL0cF; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 01D0F2A394A
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 00:41:23 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 03B621C007A;
	Tue,  6 Aug 2024 00:41:14 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 782FA13C2B0;
	Mon,  5 Aug 2024 17:41:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 782FA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722904874;
	bh=MCC7v63D2Q7YN8F536lsvnAg7o8HrHj4djTgSw2npbw=;
	h=From:To:Cc:Subject:Date:From;
	b=VeHjL0cFgmXREdscXvC04ONUSp7I4VYasUxvV4WeACiOGlYXH+7op80abYN0Ec94H
	 SHfC5htOY64r9t09RhQyWHa0+l3lC1MPnt7hGzaKsTQgXCacPVrRVh0BKreXECo6d2
	 MeAJ2bdhIvGNsU299bOvP6d+KxWmPQa8ywPQAMrI=
From: Rory Little <rory@candelatech.com>
To: kvalo@kernel.org,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 0/2] wifi: ath10k: Fixed locking bug when setting bitrates.
Date: Mon,  5 Aug 2024 17:40:22 -0700
Message-Id: <20240806004024.2014080-1-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1722904876-Qq9zoWu7DW3Y
X-MDID-O:
 us5;ut7;1722904876;Qq9zoWu7DW3Y;<rory@candelatech.com>;9989741adba0574bb335b9e9d00002fb

We have noticed our kernel locking up when attempting to set bitrates in the
ath10k. The fault appears to be the sleep calls from sending a wmi command
while an RCU read lock is held. The RCU lock seems unnecessary in this case, as
we are already holding the wiphy mutex at that point.

We have introduced an iterator for this event - when the wiphy mutex is held and
an RCU lock is unnecessary - and used this iterator in the bitrate mask clearing
logic.

Rory Little (2):
  wifi: mac80211: Add non-atomic station iterator.
  wifi: ath10k: Removed atomic iteration in bitrate mask clear.

 drivers/net/wireless/ath/ath10k/mac.c |  6 +++---
 include/net/mac80211.h                | 18 ++++++++++++++++
 net/mac80211/util.c                   | 30 +++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

-- 
2.34.1


