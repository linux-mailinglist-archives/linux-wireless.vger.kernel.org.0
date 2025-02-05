Return-Path: <linux-wireless+bounces-18544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF6A29A0D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4759D3A5238
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20A1FC0E9;
	Wed,  5 Feb 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="R78GR4w7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from resdmta-c2p-547356.sys.comcast.net (resdmta-c2p-547356.sys.comcast.net [96.102.19.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959038F82
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.19.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783657; cv=none; b=mGtfSNb5Vy/HS2yI9MKI1LV5//u+l2tbO1dKzuVEacVyhhHNxXbd0qL1KGfljqNWanweFFOyqHRKh/KVY0zZGnNaOyvtCCYaXaJJjBoQmt3dPehguoX971K2e3UqIgyjlS8hunVaxEyFbLgnXJ4mDioMPmY3649OkBAA7ziS4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783657; c=relaxed/simple;
	bh=VMaD5wMUDh6t5fp67taIxAjITXgdWaoU3+sImos/VCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPqdiXk/iLBVE0iGLXTi5wodYXbhLK1VjLLfJhQoAHVqu8j1eq52VVRZm7PRbWvf29j4V94bSTm8ywDkxKm34Myxfij/5eIDtnUkbP2k4fL8QtoFD5DGCMnSmoJ35WRds2OdKfvUOSl29Q+DN3kZKojGf59eR9fuKiqiqRF4p/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=R78GR4w7; arc=none smtp.client-ip=96.102.19.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-c2p-555441.sys.comcast.net ([96.102.18.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resdmta-c2p-547356.sys.comcast.net with ESMTPS
	id fh1gtdg8NU6XqfkyxtmJqg; Wed, 05 Feb 2025 19:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1738783363;
	bh=RPvLEV+VGJRXaDwsNbsFF19ilaFfOPab2PZdeBwRj5s=;
	h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
	 Xfinity-Spam-Result;
	b=R78GR4w7+S5Jrg7xEtk8TdD6nULHegq0kSbBRNqbZduI4zMJ22N9+Vb3HMAetGJzI
	 4Qc+14HibIFL1ErAQiUS+9n1mOty7MeeOOLsGQF4qPzeN4DET44RjSWAlJ/YR27fEy
	 XLsWdIxgBIeT0PerItE6guvznEcIHHMppsD1LbOMf1mOVDWoI/mr1hwVTuVwcpePA3
	 ZSGFJxIxnIkREAxKn5euJvaMGgsuhFE4gF8ZlXkGGShEiGlVcbL0eQJyIUC2EHY4z4
	 EcWLJrGQnR1QuVrDO+h9u3kAZ/d6OdC0LiVcq+OJLU0H1jV2/PSgkApBEk4OsttZIy
	 XzeHyd7KPVTRA==
Received: from jack-livingood.hsd1.ca.comcast.net
 ([IPv6:2601:647:4d81:b870::c894])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-c2p-555441.sys.comcast.net with ESMTPSA
	id fkyMtTTIvMQOGfkywtgIJO; Wed, 05 Feb 2025 19:22:43 +0000
From: jack Livingood <jacklivingood@comcast.net>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	jack Livingood <jacklivingood@comcast.net>
Subject: [PATCH 2/2] 	modified:   drivers/net/wireless/intel/iwlwifi/iwl-io.c
Date: Wed,  5 Feb 2025 11:21:49 -0800
Message-ID: <20250205192149.357710-1-jacklivingood@comcast.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLQ750UGgBmjvgFWomzNQCmv0l58VFKHnhFdspkFVeFt0oxioPeFjY5caOYwgNa4gnfU9YKGhv4kEPFnvzcCWP+dX7v4PFWYDhpAa2ax6yHF83zPgFKX
 eS7C1iJaAW0SgNmQrU3aQ91ngmDu2qC86a9+UFHR77yx/TzU2gNbhWOWWJ5B31tL1ZBz7Bz7pbAiVBT2gChPxPknyvVqeNxeyqaZvATN7ai4042d4lFrIA17
 9xJAq7xdfMO0PDGlmSgKf2mD2xaqE6PzVxko6vl33x2pCNbPs/qRBbMbqQ7vFmJdW5Qde/1H74DNh1o6YgnMnyE5wOvyUmmogSfkDzLbGpOwpRjJD9BxzLBS
 FMros0iL

---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index c60f9466c5fd..cd7eebe6a7b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -114,6 +114,7 @@ IWL_EXPORT_SYMBOL(iwl_poll_direct_bit);
 u32 iwl_read_prph_no_grab(struct iwl_trans *trans, u32 ofs)
 {
 	u32 val = iwl_trans_read_prph(trans, ofs);
+
 	trace_iwlwifi_dev_ioread_prph32(trans->dev, ofs, val);
 	return val;
 }
-- 
2.48.1


