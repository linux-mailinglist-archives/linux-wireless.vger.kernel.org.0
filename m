Return-Path: <linux-wireless+bounces-26061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B375AB16CFA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 09:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F393AFF81
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22ED29E0FB;
	Thu, 31 Jul 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhXCq8gw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6629E0F0;
	Thu, 31 Jul 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948721; cv=none; b=P4JV4Ap8VdVu+jAFWD5eB7oIQqFVQbX0W3jv4Qk9Fk0NtIdPJNhKqAc5E0SvAt1RiFxuxkkiwSqI+bQsHwyeUQ3u9hY2Fz/yLm/omVuIpuVcUe4C6sr+jOqSvBhkZ+6buZp14yNoRthGS6+AbSUsnD7NZDHj3HVLbJaghEiLgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948721; c=relaxed/simple;
	bh=8svsTmKtJ9G1QaSrCBTxc9ZilHPA5msRxxvCdLX8hiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4WO5IQS4KaG04RTeiP2yU57cBoB4DHB/S6wvAlVmGG6srgre0WZ6gJYYO/oWvdoCd/hPe9Wr0cVxEckLuNgnz7oHDBWukURzlcMP+2GTLVBJdAjUzkIwubq8VrxdYTlj+wnnSO4E5sVZOmzXnqEoloVPwf4yu7ZO5F8WJDE1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhXCq8gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B17AC4CEEF;
	Thu, 31 Jul 2025 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948721;
	bh=8svsTmKtJ9G1QaSrCBTxc9ZilHPA5msRxxvCdLX8hiA=;
	h=From:To:Cc:Subject:Date:From;
	b=LhXCq8gwVenk5Qkc5PcViXVqGbkyMj1CQO4v3RlqvNZdRy+fxRj+sUjzosLHwAvGu
	 /8HwcskdmlQgMdTbtyxnutKvxLK0FLYqWmSwOGOnJlVRUa+MC1wT8A96ieB+5MkMyS
	 Mmtog+xGpTWn6v/PmnG2cp4EDmYqKKpLgHvOjd6E1u7maMDwL8E621wl37yYkfiRoE
	 m27pdCf+uAwvFydgr1v97b4KOtnSsyspxqsgyH/iRwnvzaByXd9jvhJWnUCYXHWp5Q
	 MNk9EYHrcNB8UTmw+Ea5ulyvfT0fah1NgR3rJ9TZv7NovSH+e/usMTOIoo2FiQn4x0
	 tvZmQ1ge8ay0A==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Rosen Penev <rosenp@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wireless: rt2x00: fix CRC_CCITT dependency
Date: Thu, 31 Jul 2025 09:58:33 +0200
Message-Id: <20250731075837.1969136-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing this driver on Arm platforms shows a link failure
when the CRC functions are not part of the kernel:

x86_64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_check_firmware':
rt2800lib.c:(.text+0x20e5): undefined reference to `crc_ccitt'

Move the select statement to the correct Kconfig symbol to match
the call site.

Fixes: 311b05e235cf ("wifi: rt2x00: add COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d66fc839c3ce..17f063fc0b57 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -66,7 +66,6 @@ config RT2800PCI
 	select RT2X00_LIB_PCI
 	select RT2X00_LIB_FIRMWARE
 	select RT2X00_LIB_CRYPTO
-	select CRC_CCITT
 	select EEPROM_93CX6
 	help
 	  This adds support for rt27xx/rt28xx/rt30xx wireless chipset family.
@@ -142,7 +141,6 @@ config RT2800USB
 	select RT2X00_LIB_USB
 	select RT2X00_LIB_FIRMWARE
 	select RT2X00_LIB_CRYPTO
-	select CRC_CCITT
 	help
 	  This adds support for rt27xx/rt28xx/rt30xx wireless chipset family.
 	  Supported chips: RT2770, RT2870 & RT3070, RT3071 & RT3072
@@ -217,6 +215,7 @@ config RT2800SOC
 
 config RT2800_LIB
 	tristate
+	select CRC_CCITT
 
 config RT2800_LIB_MMIO
 	tristate
-- 
2.39.5


