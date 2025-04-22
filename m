Return-Path: <linux-wireless+bounces-21844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CBA96DBB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCAA17FDA1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2927BF7C;
	Tue, 22 Apr 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ShfWQH/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948828150D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330424; cv=none; b=ad0J3funq7UQ0BCVCrQsMGna9iB8gzGp9xOYzUM08twr9J8Zge0XRWeFh3iWsHCKYK6U3eLe4WYPPwm1pz2/cW72giNR0ZTWwijX2LDsmsOlqnIjWTsWuJFamGD9VUnlCDsAVUX8+NeKJRwT38vWuMUHL4nd3B1cBK6V7Ylkz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330424; c=relaxed/simple;
	bh=mzZbLvUB96XEGZujH0lpwX/9Jp9TDeHyk72aNvKD6go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/3ZjWkd6S/YdVDlD59nEy56dQt5JXSb0FEVwUV/xcvxSHLLNhD8sv4SH2zfAFlPZM8drqN8zrYIqmVCbUwtQuETATjNmerRY7QpVFzq7BN57guFnSg39qV62bWug1hJoXDfjAu5tQhF8aNJJPm3Q+8DIdYp1THAIJwfAb9FVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ShfWQH/Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ySf7k09YleJhTki2aP7ZS+hIoU6onGztnjHnhgPypxE=; t=1745330422; x=1746540022; 
	b=ShfWQH/Zh+fKOliYAqRH2PD03B52sHcgJ0OYtlDTfJn+E3uhsWdWEwsjtkxicYozw1yD2nqOPUo
	fJxfKjtR3JoG9xJPhQzJulpHNf8XJIPOCnCMTTEiwul2y+pTDOvUOkNL9NLRpjKqttOuBQMB980cg
	3bJx/098Ap4OXGOwtJYW3sFVp57z9bpS9J589ffMUK41ipc7gLlwbzOquk10Ewg7y8qQqqGsJdiHy
	ZM3YgOAt3SJQ26di2RLNNvgR5IBRNjDU1G8WUhPdhyihUupPV0KTJq6QrRdz4bTKsSIITxR3fdEpx
	Ed1PBTEpsd7+tI+xGUUZk7YtC3RIDLppIxYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7EAd-0000000CDPt-0Tbr;
	Tue, 22 Apr 2025 16:00:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: iwlwifi: mld: ftm: fix switch end indentation
Date: Tue, 22 Apr 2025 16:00:18 +0200
Message-ID: <20250422160017.6d4cff49cbf4.I8e5570a6fe94faa9f17a89352b7ba645fc875e77@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The terminating brace for the switch statement is erroneously
not indented, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
index f77ba21a174d..3464b3268712 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
@@ -94,7 +94,7 @@ iwl_mld_ftm_set_target_chandef(struct iwl_mld *mld,
 		IWL_ERR(mld, "Unsupported BW in FTM request (%d)\n",
 			peer->chandef.width);
 		return -EINVAL;
-}
+	}
 
 	/* non EDCA based measurement must use HE preamble */
 	if (peer->ftm.trigger_based || peer->ftm.non_trigger_based)
-- 
2.49.0


