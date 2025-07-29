Return-Path: <linux-wireless+bounces-26044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4030B1502E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A1179195
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329EA293B63;
	Tue, 29 Jul 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Keg0jCtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EA293B5A;
	Tue, 29 Jul 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802969; cv=none; b=gQ40IlKSYSOYCTVFAnIN3TWNRKey8/g6BSXE7EO7PQY1VZdYr45XM5DSZ4qQnhegsHo9M4cb2171OYnVg5Ge0DVSi/rHJmeKG/hIRA7fJLeztnQ9DqvMejaYUeO4DH3pW0giTviXFfZRsNoyVVybRbK3qlRowGrj7PdvkXDfxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802969; c=relaxed/simple;
	bh=4BPEAfBs2HDQWDziJ0BtleRUDaRqmEd894j5fAAT2qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpG7KX2lVydY9k7w89hBj/N3b/PUrDdSuS5KWep/zXNNsCJnZePZHQnnLIr5d3nK4GeGt3M3xhVqWN97uqizyNYsdjnpoOKaqAYkTSs9rV8pM2C2yiNEad9xSWoFKMRMqVCO878n/IfXfVOhQeuI9izJqET3BwkJC2jDbbjTFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Keg0jCtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4A7C4CEEF;
	Tue, 29 Jul 2025 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802968;
	bh=4BPEAfBs2HDQWDziJ0BtleRUDaRqmEd894j5fAAT2qQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Keg0jCtjOfGpZYsB6aE/MpjVQc+UDe3v2berqUEq6LBg1aiWH1r2LL3wK2CzacBDl
	 RZSCtz3ipuFHeAH9o7Hf0GakIAG8P4qnGkbvaUt86jj21RgkMiU/vK/9cyv2THjqqE
	 UosDXZNO0oJcgfDn9xkimErPst8FIErjuiMBdol3iTXE8qV3wOPB6vzm8kufThbqi8
	 YzI7kGHIahXl5y9znRdwYhki5dG3nd+UJ22wGtApnQv9ZvzudmcDVovMvA/E3poqpT
	 hG4WjtZhoYZK679bMDYerI0l+G2HW4RrAW60xoRK4evO7pBfWFOtOzse6maWQ67E8g
	 ku+p7BeHVuXCA==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Rosen Penev <rosenp@gmail.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rt2800: select CONFIG_RT2X00_LIB as needed
Date: Tue, 29 Jul 2025 17:29:21 +0200
Message-Id: <20250729152924.2462423-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The rt2800 specific code requires the more general library code:

ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
ERROR: modpost: "rt2x00lib_dmastart" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
ERROR: modpost: "rt2x00lib_dmadone" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
ERROR: modpost: "rt2x00lib_rxdone" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
ERROR: modpost: "rt2x00lib_txdone_nomatch" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
ERROR: modpost: "rt2x00lib_txdone" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
ERROR: modpost: "rt2x00lib_get_bssidx" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
ERROR: modpost: "rt2x00mac_conf_tx" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
ERROR: modpost: "rt2x00lib_txdone_noinfo" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!

Select the symbol to avoid this build failure.

Fixes: 7f6109086c9e ("wifi: rt2800: move 2x00soc to 2800soc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index 4d98b7723c56..d66fc839c3ce 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -225,6 +225,7 @@ config RT2800_LIB_MMIO
 
 config RT2X00_LIB_MMIO
 	tristate
+	select RT2X00_LIB
 
 config RT2X00_LIB_PCI
 	tristate
-- 
2.39.5


