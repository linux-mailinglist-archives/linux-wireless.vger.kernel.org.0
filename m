Return-Path: <linux-wireless+bounces-16695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574499FA0A9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 13:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A31886C76
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919F1F2C53;
	Sat, 21 Dec 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="lyyo/E/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D31E4A9;
	Sat, 21 Dec 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734785107; cv=none; b=EQrnG2LRyABxbe/pi2U/trV7ucERGfo5dAbHTqLKl8P4agpmMD3AKsCi+IYNKrS4/FPtlxo2qQcsNiT9NpL34Yx/AGrhqS504a5i9IO0lf0rdc4B2MmaMZWy9heFzB7qdsSmiHY6lZC2JZk7b/zn4L5O7OvXDdzKT+2b6zOW0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734785107; c=relaxed/simple;
	bh=U2Sd3WRzIrjobtH38oMkPibxftFFaoQ5yxt8mw9752k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4R7EFm4jJ1xVUmOeLTAVjS+uL+EhjBDpOyfpuQedQODWU0hWKDtv7E7JDh2C/dlkujEfk1ux90PSGjw1x6lGn/mrw8wvj4idsPlv94feKdM6ypDMdWheW3ugm7XQZPOCkOyrBp4SYAY/6fY54V05QdSvk/OFR8p6aULFojoNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=lyyo/E/x; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734785105; x=1766321105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U2Sd3WRzIrjobtH38oMkPibxftFFaoQ5yxt8mw9752k=;
  b=lyyo/E/xCff6V91UJEGVXO5v8s6Q7E40+x/m04uu8UvbsLrR8Wg0w3k4
   qrE46bHsv+geQV8UOel6uOWrEnTKA1h2EsuT/4WGR6ks0fIHITcvzbX47
   6z2lbFeEJqvgs2v2sEsAj8xblshVz+2EVglXenXjkyJaXdvp9Cr7wb60i
   M=;
X-CSE-ConnectionGUID: bPBh0LNqRkyQ2W9+r9C7lg==
X-CSE-MsgGUID: Fx1Vpl+sTSCsRIzKRefVvA==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28286103"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 13:45:03 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 4F4E42511;
	Sat, 21 Dec 2024 13:45:02 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/2] rt2x00,net/phy,neterion: Remove dead values
Date: Sat, 21 Dec 2024 13:39:31 +0100
Message-ID: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series clears out the Coverity-IDs 1525307, 1269173, & 1575053.

Thank you,

Ariel Otilibili (2):
  rt2x00: Remove unusued value
  net/phy,neterion: Remove dead values

 drivers/net/ethernet/neterion/s2io.c           | 2 --
 drivers/net/phy/nxp-c45-tja11xx-macsec.c       | 1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 6 ------
 3 files changed, 9 deletions(-)

-- 
2.47.1


