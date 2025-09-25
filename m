Return-Path: <linux-wireless+bounces-27648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C5B9DF3B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93C519C2426
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4661F26FD8E;
	Thu, 25 Sep 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LiHRCldY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7B25F98A;
	Thu, 25 Sep 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787225; cv=none; b=TLr364Uo8kq3MZXMYjvff1SDhDI0b2H1BJM1QuX75OvvaQoLG3OMUqAMp3KQHL3e7rRdaHgpBl0R1gqBZL6LcQytmXXDK1SEHGMEsneBDp5rxzUkHFUVcqltBDo74NJN5eJFQMsWpYf95WQyv+xFnOrchxdyvV6TrstMqgpEGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787225; c=relaxed/simple;
	bh=G0wE6GDhMjrEgAVeXZdBQvhN3c5CaLo5qSGmNrKn1bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAYu6nKqy9etZMCr0JUkYuuvIqIzMPTL9SHYUbT3gZCu8NrorMp42LMvoyV4xvYT3kd1sa10koXAEmVREnjbM0OW719ctrbiq+Oo8W4aoOsbKAWmQROdm/xn9AqPY7f60HGnvckxgayQPHlnhZr1BcxWrAPFoFpqn97rn2Tvngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LiHRCldY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oraknh3t1E5ZIO7ASTmkAkRYi0tE6MMY5GpktDUviUM=;
	t=1758787223; x=1759996823; b=LiHRCldYIzKlJZSeWybHbOC2FIWYTsQcbadLlopht1H8mhF
	MLIfeaTL4H1msSvm6wAyK5LvyEUQFXFM3aVHCTxIzEQpRjkBZDdOMijVDI8utePf9DyqztGUU5fT/
	Y6s7IP9y6pmE9UVbZ4b/7JZVTz57qdsNW+Qz1YGMTBTvKHjd0glYEh2H97gxJklB+UUtvx1dPvUeP
	GrbmlEZBIxFr4vQ+BQdEV8KiHG2NpKCIK30zyxcPhzLqZ04c/keVj9mdmG5/1UuskPDVOqWu3pZg0
	OBojeMwAqGDUxkl3zNNGl5VaA8MObguVE1X1WC+HgdJag65zuK9yNwaxfMOXQmQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v1gtj-0000000Anv0-0Lmb;
	Thu, 25 Sep 2025 10:00:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	David Wang <00107082@163.com>
Subject: [PATCH 6.16 2/2] wifi: iwlwifi: pcie: fix byte count table for some devices
Date: Thu, 25 Sep 2025 10:00:07 +0200
Message-ID: <20250925080010.9298-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925080010.9298-3-johannes@sipsolutions.net>
References: <20250925080010.9298-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit a38108a23ab558b834d71d542d32c05ab0fb64d4 upstream.

In my previous fix for this condition, I erroneously listed 9000
instead of 7000 family, when 7000/8000 were already using iwlmvm.
Thus the condition ended up wrong, causing the issue I had fixed
for older devices to suddenly appear on 7000/8000 family devices.
Correct the condition accordingly.

Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/r/20250909165811.10729-1-00107082@163.com/
Fixes: 586e3cb33ba6 ("wifi: iwlwifi: fix byte count table for old devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250915102743.777aaafbcc6c.I84404edfdfbf400501f6fb06def5b86c501da198@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 5ca9712dd7f0..de5005815ee7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2093,7 +2093,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_7000 &&
 	    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
-- 
2.51.0


