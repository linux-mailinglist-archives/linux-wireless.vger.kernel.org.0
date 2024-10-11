Return-Path: <linux-wireless+bounces-13878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CA99A097
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 11:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C6A1C214C3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BE020C496;
	Fri, 11 Oct 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cmziwtxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2620C48E
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640709; cv=none; b=Qyq9noUgDDMHiROEoUNBPdFV4aF+ohimr8cjPvXw3kVetAUCMgRPzJUeijKLiDa99eHT/OK2mvMACtqzyUaFiNiWloZ0arg5Q8ZDuT10Y5a8AgUwzUA7r/OwGP4sC3PLdj5xi22PK/lWAcpVOHg2pDO8HCYE1txEOE64Y3vMRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640709; c=relaxed/simple;
	bh=4ETrZkIrYVcQQ2uX1rbeobJQKL3K8t9cNKvUNNxZnbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6a924V/MNvQbxl9f+aB8MrPwhhqqMo917XBCBu2I950yEniIgzY/gv7D5ZOVXx+s1OmthncrnmvVvbweEtvv6crEU1tMEw6Q09lSRUy4AQgxVrLWlhSHaqONGa7edCg1MQ3oLivuuw5aiVeYqbBvR959AHnxveL8iiYZckJ8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cmziwtxK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=j173g5YCrbcqHKX2R3q17EFpkjtx+qsipWkl74Krhek=; t=1728640708; x=1729850308; 
	b=cmziwtxKpQh2QRUuktcNNz60Vw28iU+2O+P0vZN8o3u3UlQqlWCq5iMlKafaGbQotrvmLCuzStY
	wq0BN/j+YdVQpW0KlrkmqyE7tUJPpuU/y84Lyq1IeAg2u/Rz4Nx5vt/P+pMC/en+imry5KvCAI/Nm
	lDOvGzQyrsmAX1IU8hw8uyZFg/vRkLuQfatn08L+MtHNbpVonrCs0/6hZfGsSINJoEPBRKlnlSmsW
	SsQxbEzYKabzO1iHZNhZtg+nKEaqAAZ2rnkTCYK4Nb8Fk3kA7X7NRqlvvk/YUCMJpnwqOrHa41a+c
	MBpvEq3RG7SL58RgJTvm/y7A6ZjR9bWW2EVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szCPf-000000076GS-0K5c;
	Fri, 11 Oct 2024 11:58:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: ipw: select CRYPTO_LIB_ARC4
Date: Fri, 11 Oct 2024 11:58:20 +0200
Message-ID: <20241011115820.070c468b271d.Iac76e81b5cd9a5b949b8c154381128e8131d581d@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the WEP/TKIP code having moved to libipw, it now
needs to select CRYPTO_LIB_ARC4 to have the dependency,
and I forgot to move that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410111727.FxATs8Yj-lkp@intel.com/
Fixes: 02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 into libipw")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index 5e98be664d38..b92df91adb3a 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -155,6 +155,7 @@ config LIBIPW
 	select WIRELESS_EXT
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
+	select CRYPTO_LIB_ARC4
 	select CRC32
 	help
 	This option enables the hardware independent IEEE 802.11
-- 
2.47.0


