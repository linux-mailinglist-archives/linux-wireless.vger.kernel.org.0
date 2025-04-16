Return-Path: <linux-wireless+bounces-21572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B2EA8ACB2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869923BE4CD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F821A2622;
	Wed, 16 Apr 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="SmT9KYJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BC1A264A
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763304; cv=none; b=dB3Bh8ni7mqfla9LCd8pA8Nqh16AN/zY1MvqVQLfZ/5S878skGMtZzQjaGAnpeRaXmoIxDqHYk21SqKGCZ8e9SW3uuMURgULaJygQf39rGxpSGcQxwb+ZDkLgZo/vmIe4WvE9Y7WLah7x34zu4ShWSLlf86vmOPpOf3UyB96yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763304; c=relaxed/simple;
	bh=rZCPnU/K9gRO0BBSPj8pQfpTzCYaebtUYCasbW5j5Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvNaHApHxlfuvS8ZVwILdWfelYAA/UKgFofqPHrgF4FwhlHGNQrVIhulVVD0hxlbR4Bgn7+jkwg1T0f5oPshlucAbOmk+JixqBAgCB7dXU8yMRk9HD1Q24+J5FP0Xgnz3SgoOUDjJjG1Rdz9BVRzGIxYGFfTZGNjVRQGERdt+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=SmT9KYJw; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.207])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3E31B600ED;
	Wed, 16 Apr 2025 00:28:22 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7C75CC00A5;
	Wed, 16 Apr 2025 00:28:17 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3FF0213C2B0;
	Tue, 15 Apr 2025 17:28:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3FF0213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744763295;
	bh=rZCPnU/K9gRO0BBSPj8pQfpTzCYaebtUYCasbW5j5Y8=;
	h=From:To:Cc:Subject:Date:From;
	b=SmT9KYJwNA4UJpWqPBp8uZfd9DXwKEak6u/ccX/XOsFpEs6mWR1zCoYrsdtmQ6kEO
	 B5cZnveSTlBeusvMdscuG38Q80bVx8jhCeXz2Uc4yBQUiS7ZPe3N0YL1El8vMERc7Z
	 OZ6APx84+naV3pylmLP9fvcKQhRaSGTyzjZH7Vu4=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 0/4] wifi: mt76: mt7996: rx filter fixes and improvements.
Date: Tue, 15 Apr 2025 17:26:13 -0700
Message-ID: <20250416002617.1328286-1-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744763302-I0KCLAyKr8-O
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1744763302;I0KCLAyKr8-O;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

Current rx filter logic can end up in different states depending on the
order of interfaces added to the phy. These patches are primarily aimed at
fixing that issue, as well as refactoring the logic to prevent issues like
that from happening in the future.

The first two patches add per-radio-phy debugfs files for debugging the
rxfilter member. The third contains the main refactor, and the fourth
fixes another issue related to the order in which interfaces are added to
the phy.

Rory Little (4):
  wifi: mt76: mt7996: Add per-radio phy debugfs directories.
  wifi: mt76: mt7996: Add debugfs file for rxfilter.
  wifi: mt76: mt7996: Refactor of rx filter logic.
  wifi: mt76: mt7996: Allow monitor enable if phy is already running.

 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  74 +++++++++++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 125 +++++++++---------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   9 +-
 3 files changed, 147 insertions(+), 61 deletions(-)

-- 
2.48.1


