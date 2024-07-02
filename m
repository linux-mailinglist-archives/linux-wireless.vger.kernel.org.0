Return-Path: <linux-wireless+bounces-9820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16487923BED
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F2D28663F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3E4CDF9;
	Tue,  2 Jul 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gVv4v8iB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F6381D9
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918034; cv=none; b=YR8kGBhOOiBtG7mWPMz6re+y+BNZ0kfgfSo6/CvB9SKBZdh1IBP8OrAXp+2uApeMJOR7Y8bom1Vlcse3qwWt46xRJjyxuJBB7BTbUIxRXpxPR6koJrnQvgd/RUZfja7JTE3bTtO+SmPhy43XSAsLi3UKyzta4vbDtOV1a24wQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918034; c=relaxed/simple;
	bh=1RN/aEsNTN94B5X97UBnjmCfqktXpwEh92c1y+oI/Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pu9i5OIgqg/zHwrT72TgCKSYZeiT/y+9K0Klou4emLKwWqoGyamEUxLCUQsHw5MmWh42z7gbg0CjF35eFg6UVPhvNyKy86VR9JMcOrJ71EM+fNrfOkDUEK2zA4YAWzgRMS8onVncY6NgrTte9+w99+eU1ox6ukfsc4jXrZWiIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gVv4v8iB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=E4B6hsOhD5qJa7FzKmH9WW769lrR856P2iUEc+ZiCdk=; t=1719918017; x=1721127617; 
	b=gVv4v8iBTLB8gMZ0pY0DTmIkotwbW/i6YkZnnsrs/QRTVI7bY7+ZTUQBvzZ2hfM3uwnXqcSMdPd
	p3V8qLDkUG7zCpD9/pvJ9+9PEbHt3nBF4e2gGEy/0Qot5075xIRV7mMPq8oSbMCjisYR2JIoDJJ1O
	nQa+Li5pBaoLPioFjKoNpdOVq614NfgK5WC2sOI1ASsQxvZ72o4d2eozIXDvTF3LgLeNCVDMwmvjL
	oVZGIIEWo3yTu4JRgQC5TmNxL1+hiLUeDFMjXUzDVMDOTy58EhbM42ucVhfkFhPCkaPpE8SDp3R+j
	E+6R4PD4s40AY/BOEvdHxnVkMe1HfQEi/lFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sObF1-00000005Hhw-2Bfu;
	Tue, 02 Jul 2024 13:00:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH] wifi: iwlwifi: mvm: fix interface combinations
Date: Tue,  2 Jul 2024 13:00:00 +0200
Message-ID: <20240702130001.8c871a3f0b5a.I08a6542f52f63c5bd66bf3feb09e1998ce7c60e5@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The NAN code referenced in this commit isn't actually
present in the driver (any more), and the commit didn't
add the extra NAN entry. Thus, the -1 is incorrect.

Reported-by: Alexander Wetzel <Alexander@wetzel-home.de>
Closes: https://lore.kernel.org/20240702104128.26394-1-Alexander@wetzel-home.de
Fixes: 5c38bedac16a ("wifi: iwlwifi: mvm: unify and fix interface combinations")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 60bfe42d5386..e40f993b17fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -59,13 +59,13 @@ static const struct ieee80211_iface_combination iwl_mvm_iface_combinations[] = {
 		.num_different_channels = 2,
 		.max_interfaces = 3,
 		.limits = iwl_mvm_limits,
-		.n_limits = ARRAY_SIZE(iwl_mvm_limits) - 1,
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits),
 	},
 	{
 		.num_different_channels = 1,
 		.max_interfaces = 3,
 		.limits = iwl_mvm_limits_ap,
-		.n_limits = ARRAY_SIZE(iwl_mvm_limits_ap) - 1,
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits_ap),
 	},
 };
 
-- 
2.45.2


