Return-Path: <linux-wireless+bounces-21024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C8A77A69
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 14:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AC416439F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CB1F152B;
	Tue,  1 Apr 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TR+z+lH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40231EFFB2
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509501; cv=none; b=QzlRElkqE7icX1i7q/jSVwHEB5nari4eLxfM3eswHBcPNFWcd3FIxWTRcHmyz0q2p5kfbdnFHQTuQ5D7zO2KiRRmR116tSjU1s/zdTqg0ACqJM5SK3pNgoaS0TU8R17gW2roGsPPdTquUTfGOUeX72v3xlqzYvAixfM4dCMOVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509501; c=relaxed/simple;
	bh=8qD5qO5+7E8zgiI2yY8R0PZ3fXssoswUz7X9iLaeToQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qClWxqZH7gbvoyMgJPPDFGmlOA+CgFAR5n3fF7m0dPNdrBTUILjZCRLX60E75TDb9KpgcYmIBH509mt6FT7J3Nw+kHjwjy9LCWIcQkf85ePC3q0IzxLAg25aG1fw3H905fe9ecKImsjs2aS/x8J2av6+4Y+BwW89frWF4R38RSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TR+z+lH5; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743509495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Eag8zpNG7MxnvJb1CH9xtij6aAJ0k6ycnZNJhZrMEk=;
	b=TR+z+lH5gX+s/ffz9qiNvdgBmaNWAoct5wLLA4LDCl22t5CGgci9jyS/gEk6nLde+4tQ4h
	Fl4/+g0ZwBeakpl7o+cZXIO3NsSWVRDwNbcGAD/qUUTEHIEhKmiwSRlnNxN+iDoBwy6kTL
	rhKPIDfnmcS70E6/Uk9IwlTBKkVZ8yg=
From: sunliming@linux.dev
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	benjamin.berg@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: iwlwifi: fix uninitialized variable warning
Date: Tue,  1 Apr 2025 20:10:40 +0800
Message-Id: <20250401121040.618791-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below kernel warning:
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:513:16: warning: variable 'ret'
is uninitialized when used here [-Wuninitialized]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6851064b82da..7146116b067c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -475,7 +475,7 @@ static
 int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	int ret;
+	int ret = 0;
 	bool in_d3 = false;
 
 	lockdep_assert_wiphy(mld->wiphy);
-- 
2.25.1


