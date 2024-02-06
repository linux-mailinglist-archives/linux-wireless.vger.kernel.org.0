Return-Path: <linux-wireless+bounces-3220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9584B580
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA371B2309F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9B12EBD6;
	Tue,  6 Feb 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vmsZ4d7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1B1DA3F
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223567; cv=none; b=KWc4Pi3KerxduLIb7WrPM2ezhWdXE4zFX4TRYXRE2lIOeZWzL40E1uCUy5UlilKb+RGf3emTzhDKnsrIISHKqYh+Otxjyezg8T9WdEQelI1ZISeRMNMxQpTeEl9dAClUgfEUruPLaz6mgdn6nqVL6w4pTLPNKQVo48ESlYeSbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223567; c=relaxed/simple;
	bh=1M8LBqlqwxz2afTvM9+6Jb+2WDepFIW+iZKImqzRR5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IT3UA8157z3o147kr3kaVCCwObNT6gdkBSUJagHpDN43NaNG7onzwBZNmTL0rDoSEEg/t4SDK6kVehSMAN5xDy2ca0brAapORtQUezMEN0jpuyZWaq3RebJUPnHzWAxP/YlQISwqTKP6Aj2SpcJIpHlLiIRoGgLBOMA2vWcO/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vmsZ4d7L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FEKxQGrSmQdHea6fsEL9Xmij+BY0apRPvkyTXZcfKT8=;
	t=1707223563; x=1708433163; b=vmsZ4d7Ldcf1GmbqpON0HvJQuBcfhYJpovA5qzMn/xq2cKC
	0viaJoxxUsyEaZ3QLxGzE71gc7W3xkyaDONBYXr50+x6Dh0Vm7reNewx4AmL8S2GiKL6PfbNvsbo+
	dmZw11YgFNqAqDFhQLA+jpgRIx4R2LzPTrViP9/c2SlmhITZJFLTbU/sUbgTmqCMy3XTOl5CuZZ71
	9O+La1bmCzWfuh7cD2YUxRK5MU6ocHLuRRmet8AtZjdoj7jZccOeuPw3+kdSnrj0Ly08uS5pQryTA
	xzLd+mqqmH2y+DThAw5N0udmC0HTF/GceHwBJ4dlGLZi8WRWW7wcK0UYB0fyhCvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXKps-0000000Ehsl-3XDl;
	Tue, 06 Feb 2024 13:46:01 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211_hwsim: add missing kernel-doc
Date: Tue,  6 Feb 2024 13:45:56 +0100
Message-ID: <20240206134555.eb95c1dfc1f0.Ibaf8b3249d9de59358bf6503fe4a186d9ac6544d@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134555.6354b0ac8610.Ib90d3651834c556b73697388f59bd396a1f6f9b0@changeid>
References: <20240206134555.6354b0ac8610.Ib90d3651834c556b73697388f59bd396a1f6f9b0@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some kernel-doc is missing here, add it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index 4676cdaf4cfd..21b1afd83dc1 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -3,7 +3,7 @@
  * mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
- * Copyright (C) 2020, 2022-2023 Intel Corporation
+ * Copyright (C) 2020, 2022-2024 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_H
@@ -84,6 +84,8 @@ enum hwsim_tx_control_flags {
  * @HWSIM_CMD_START_PMSR: request to start peer measurement with the
  *	%HWSIM_ATTR_PMSR_REQUEST. Result will be sent back asynchronously
  *	with %HWSIM_CMD_REPORT_PMSR.
+ * @HWSIM_CMD_ABORT_PMSR: Abort previously started peer measurement.
+ * @HWSIM_CMD_REPORT_PMSR: Report peer measurement data.
  * @__HWSIM_CMD_MAX: enum limit
  */
 enum hwsim_commands {
@@ -298,6 +300,7 @@ enum hwsim_vqs {
  * Information about a receiving or transmitting bitrate
  * that can be mapped to struct rate_info
  *
+ * @__HWSIM_RATE_INFO_ATTR_INVALID: reserved, netlink attribute 0 is invalid
  * @HWSIM_RATE_INFO_ATTR_FLAGS: bitflag of flags from &enum rate_info_flags
  * @HWSIM_RATE_INFO_ATTR_MCS: mcs index if struct describes an HT/VHT/HE rate
  * @HWSIM_RATE_INFO_ATTR_LEGACY: bitrate in 100kbit/s for 802.11abg
-- 
2.43.0


