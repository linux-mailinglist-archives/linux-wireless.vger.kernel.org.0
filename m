Return-Path: <linux-wireless+bounces-13952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19A99DF5E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B7E282BA2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826A189914;
	Tue, 15 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B40733ld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214122AE94;
	Tue, 15 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977541; cv=none; b=YH4A8YsncCBuffQzbhVZZsKn3IqCyhHS3LMycIjk24Gd9kfjmej7MQ/iA6vyxe3vKeSCRepNEUFyWSkK9YfjpHJOXvPjCb+LV+I3k3exGBe+EhMHAbkXDrtX9DDNR3/oQz0qT5Tp+IjLUditJrDaRwpxO+XGvrExxasu2VE1Suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977541; c=relaxed/simple;
	bh=SlZbFeD1eNDdEMFeXSby0hbrplRRAREzdJpNPkxdOCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZEFn82fWfnzUCI0VGpLUjvZykYo63UiH7GJztId/YdTH2ipmT0wuQwiQP+ujzRel31rGpClATD4RfpMUZfDhn+Pk3ZUj/0Rf7MagJhy36p1y4b2HppBvhqtM2OcrZbPiDZ4DIHvYgDlfP78Z8XhBif7d6LJTc6NhiCkHUYmuuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B40733ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F20C4CECD;
	Tue, 15 Oct 2024 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728977540;
	bh=SlZbFeD1eNDdEMFeXSby0hbrplRRAREzdJpNPkxdOCk=;
	h=From:To:Cc:Subject:Date:From;
	b=B40733ldjuqIAGfcEaodWjR/BSE+YKfpSXxu4/N6RkZVY5SQuefwcT6iW5bCRYjW5
	 ZegMjknp0JPaHx8a0YGVm5gSWbnxFgoThNnoQ2XQ/BW0YN6/eHo03KVLFRU5gME03w
	 KQ3G+mN2CTlUvcAoZfGiyh2UmYamlAeftndz/Pz4FmpmCaP+0gk62WUboenL74YeJU
	 XnEC6xAePK6oKxf5+nrYL4r9jdEM9dO6whxd6w2RaxxPfs2GmymnlWfKTySoJfYbJc
	 ukY9Ea0jax9YWQA1qdILSogQQ5/iL4I1C69Pgdw4eH5/Q9MTb9OIfVx2FfEVXOap2r
	 rSPWI5xZwMlEg==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ipw2x00/lib80211: select ARC4 helper
Date: Tue, 15 Oct 2024 07:32:12 +0000
Message-Id: <20241015073216.9443-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The lib80211 code uses arc4 crypto helpers that can be
disabled:

ERROR: modpost: "arc4_setkey" [drivers/net/wireless/intel/ipw2x00/libipw.ko] undefined!
ERROR: modpost: "arc4_crypt" [drivers/net/wireless/intel/ipw2x00/libipw.ko] undefined!

Select the library from Kconfig to ensure this can be called.

Fixes: 02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 into libipw")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index 5e98be664d38..98a17c941100 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -6,6 +6,7 @@
 config IPW2100
 	tristate "Intel PRO/Wireless 2100 Network Connection"
 	depends on PCI && CFG80211
+	select CRYPTO_LIB_ARC4
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
-- 
2.39.5


