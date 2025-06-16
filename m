Return-Path: <linux-wireless+bounces-24150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FBADAF10
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAF9188C272
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57882BD58C;
	Mon, 16 Jun 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GUD6fZkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254412C08A7
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074549; cv=none; b=X1AuW3lW4mnHxANqpRV7DmQVxhxhBMUWCHWGuNumAU588zR1BlPHvAmcoxwzUSLxrZPT/2l5f/6p7/Ami7B0+JLmSRu+3FDglXCIeD3PIyY5WnjE1Ig6Q/dMDEzv+FVK56L/K2A8aZS1zWEeKkpenFw/UtpSLzQmE3JMjCLW2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074549; c=relaxed/simple;
	bh=zAKZcmxw1OdAIJn2ZgJNzXxNXbf2IJxJ003EAATgiGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKWPvmpbikd+LSSfezevbgoOSJEKXwr2IaHqydRbRgjLr4yQlxbloADSUPMFOkzyoXZKublEPd3P4zPg9iADkrBWTI31OpqwOQ9knFZw34upKvvKp4WtWAxuXDOk1gDbaOoWVrHdNgk9yTrdWfghp+XexZNd/Wc2gIJkucIPnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GUD6fZkr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Yk2vEM6Qic0O2p0bIcEeqegf+DC6AEZ0fO4OH1S4tgc=; t=1750074548; x=1751284148; 
	b=GUD6fZkrs2uLP6V4LUZRmD5rxJDSxKSbTXh8WyqGhupIbkOMHBkx61xh08c7iMz0EFUUJzFOTEW
	0a3Bsc9jIR/buP9Oip7fzZSDhDWB9xBQQ4ezC5RttudabEsFEH5GspyW25Gve0kUKzsKm51X33JYe
	jgb5Ckwl/2m1v99TF4Dm0jFLNFxRzqRNDIVka7AzcrZkjL6/HoelIfd0OOESHmeUmCPshYgf3cH8D
	gNHkofDuLgLoTnLY+1lUmZicFjBYSmC9ERu30yiJaC9N3czo2AGS1o5DsHeEtuQPmG2oI9uVpHR94
	RhLXHt/7jf9HaEYJSD5gjoi0YfeT5Cuei7lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uR8Kn-0000000CDKZ-0bIe;
	Mon, 16 Jun 2025 13:49:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: dvm: restore n_no_reclaim_cmds setting
Date: Mon, 16 Jun 2025 13:48:36 +0200
Message-ID: <20250616134902.222342908ca4.I47a551c86cbc0e9de4f980ca2fd0d67bf4052e50@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Apparently I accidentally removed this setting in my transport
configuration rework, leading to an endless stream of warnings
from the PCIe code when relevant notifications are received by
the driver from firmware. Restore it.

Reported-by: Woody Suwalski <terraluna977@gmail.com>
Closes: https://lore.kernel.org/r/e8c45d32-6129-8a5e-af80-ccc42aaf200b@gmail.com/
Fixes: 08e77d5edf70 ("wifi: iwlwifi: rework transport configuration")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index dbfd45948e8b..66211426aa3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1316,6 +1316,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		     sizeof(trans->conf.no_reclaim_cmds));
 	memcpy(trans->conf.no_reclaim_cmds, no_reclaim_cmds,
 	       sizeof(no_reclaim_cmds));
+	trans->conf.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-- 
2.49.0


