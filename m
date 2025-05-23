Return-Path: <linux-wireless+bounces-23360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48565AC225D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5C81C03A31
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82EC235044;
	Fri, 23 May 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv8aG7c7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C509229B32;
	Fri, 23 May 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002224; cv=none; b=n/B6fNjjYzw7EHdVu0hSxCTrj91sXnWCSnkoBdsCagXgv2rqAidrRf4s6Av9g1FNIwQbaIkNusQLfhTYrsFLfN1McYiPbK+sXDUMde7rAbsZ3t4A1Hoi/ydlqjqBUwgQ0ZqERdJOeRTvR0Fa6wJ11OLyYEbHt0f/lARezJflw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002224; c=relaxed/simple;
	bh=bz2djVncpNc0DiJPtokPpTKmCkuEuHVaKhUrA06xafw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZrTfAr9qsV/62vTv5MQFiOT4eMmeMuutTIZKQDS9SkBD9IAwIctQfSxUlRy31taC1olynJY+onDov4818Bp17svEHsJaU5LDyiPfTS9GtiG2j4Xj4OQtqHk6XRsnjubeJ9R07PH5aV1aPe4k3IdO7mMLP8L8LcznTg4N92qXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv8aG7c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1DFC4CEE9;
	Fri, 23 May 2025 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748002224;
	bh=bz2djVncpNc0DiJPtokPpTKmCkuEuHVaKhUrA06xafw=;
	h=From:To:Cc:Subject:Date:From;
	b=Tv8aG7c7/KJAJOwZISMsIY2GpGXFhlVQcoQZ+XirjyNW4x2ECzZaDpSHMiL+vFBB3
	 KaYi8X9P+SGrL+V+VWUC669K5p2CSEuGiZFIWuyL/ueq+s2F6KJWKWO/a6YFfQ0c4b
	 4MG6QYYP+Cab+rzi2l8YH8ApE4uoPRqkiI89DhUfhwKoWmjbVChK7dyOR2nyJ2sFh0
	 /ZGRxivRN7X6UofdmGr6z9s1R3z0GEcBVvzBV/YVoK7xcwetlveiZ2XwYHEkcglqeU
	 yoFdT/YdTp5ujwEBBMhPi0hkiVGKOn7rxEtgsnQr93WGbQmY285RjLlsUjcRFU0JGC
	 IjSAj9Q5XbZWw==
From: Arnd Bergmann <arnd@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: fix iwlmld-test link failure
Date: Fri, 23 May 2025 14:10:14 +0200
Message-Id: <20250523121019.2196490-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

If the driver is built-in but the test is in a loadable module, the symbols
are not exported, resulting in a link failure:

ERROR: modpost: "iwl_get_cmd_string" [drivers/net/wireless/intel/iwlwifi/mld/tests/iwlmld-tests.ko] undefined!
ERROR: modpost: "__iwl_dbg" [drivers/net/wireless/intel/iwlwifi/mld/tests/iwlmld-tests.ko] undefined!

Enable CONFIG_IWLWIFI_OPMODE_MODULAR in this configuration, to
make those symbols visible.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 82f577da1a8b..153a8368b412 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -97,6 +97,7 @@ config IWLWIFI_OPMODE_MODULAR
 	default y if IWLDVM=m
 	default y if IWLMVM=m
 	default y if IWLMLD=m
+	default y if IWLWIFI_KUNIT_TESTS=m
 
 comment "WARNING: iwlwifi is useless without IWLDVM or IWLMVM or IWLMLD"
 	depends on IWLDVM=n && IWLMVM=n && IWLMLD=n
-- 
2.39.5


