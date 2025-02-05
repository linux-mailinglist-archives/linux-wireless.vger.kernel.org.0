Return-Path: <linux-wireless+bounces-18547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42294A29B87
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 21:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D042F166E5F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 20:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A0211A22;
	Wed,  5 Feb 2025 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="5hwirHwz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from resdmta-h2p-564583.sys.comcast.net (resdmta-h2p-564583.sys.comcast.net [96.102.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8AE2144A3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789076; cv=none; b=P0P46VdeVMopEiirtM5TkROi1e2aWhbZcvyaHkcJVEmkle7r0AQpZeN8aClWPJaqrzQC30xnfnrf5c7Ifs8nO2k/xNiXpS6ghMDrnbxTJrFv4kj0CmdMNrKlOaRe8o8Cwmj4+3SSGKcLCrmMI4s3M06UpfZJtPvC8iS5UvoOORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789076; c=relaxed/simple;
	bh=lZdHoVBigG3cLld57gL5OfTq85teJkmVCYMQWe5OmHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQtKZy43VoKteNOj+++gz1JcwOmKLFOAHy6CDLdid40JWhJlEClC7Z5p8RvwCju5zbPMD29YSr/rNsVtV6CebZaN3K4idS2HEkLPQX36jrRHXII3k/Pz+DlQ5sLJTfV95QzFh4xUC09FMNOROL1duVozctImvSUa5iHHAnZ16Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=5hwirHwz; arc=none smtp.client-ip=96.102.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-h2p-540626.sys.comcast.net ([96.102.179.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resdmta-h2p-564583.sys.comcast.net with ESMTPS
	id feTJthx4hEPtrfmQYtI5lZ; Wed, 05 Feb 2025 20:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1738788918;
	bh=X/NawfgTLiQ55H9r0tROYwzqwwvjRME6a88QmH10FcU=;
	h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
	 Xfinity-Spam-Result;
	b=5hwirHwz7zdlumJrN9yK72+SVjA4PJzUG/GFDOXbxreP6+CELVenl/zXyfXBJ7L87
	 Feu0qFEVClQe5lc5fFxs28UVKOtfsY65y1BijF8MvUQl9xqPFLWj0QNIOHgIkxm4Rz
	 O18Uy3y5B4WzDfUbAkVj7Umd787KfYrYkphovtZhq97GncraZITgtmjZBDogSOaqzh
	 D77jsvCUpdQ9odfibQE9KydHs3WuHB0Hbch6Ggi0H1rZ2wx9vA91PCkVwdGGouL+fq
	 enMd6+0kZV3F00wpPB6UW20e59SqeEJibFq3miMx+wiK29owJ6rIsNUhijVCx6JUX7
	 axkaFyMrWqzIw==
Received: from jack-livingood.hsd1.ca.comcast.net
 ([IPv6:2601:647:4d81:b870::c894])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-h2p-540626.sys.comcast.net with ESMTPSA
	id fmQJteUqXOMcTfmQWtDFnn; Wed, 05 Feb 2025 20:55:17 +0000
From: jack Livingood <jacklivingood@comcast.net>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	jack Livingood <jacklivingood@comcast.net>
Subject: [PATCH 3/3] Undoing Macros with flow control statements.
Date: Wed,  5 Feb 2025 12:54:52 -0800
Message-ID: <20250205205452.384911-1-jacklivingood@comcast.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDczuCDeuc3ID0Zcc3NmSJgtgDgcdjn5f3ixGmCRw86uXh85LBg6sGVboEfo+5Gv0eA9tbwOiJvnCodYxYHuD5+iU6P8LRB3XqVozvK8WdI4ge6hrCHL
 wM628IdiyWAIwMBDMsyvgqlB6XoKmbFwEGiXqhkqlDk3WsaNgCQMHmksGRUg4uJO8edKIrW49xT1YySxC0CIo7pO/9xsa5Uc5KGqBW/C+PLJnggauN7P/aY8
 v9c9yOge0yIte2auEyrAQ0UqZ+5YPO7xWuVWHpNrS2OqdWbq8jt/oxFk9fjCjgY027F6t7ehKGzpwhogQwrMq103RqZwRh/nYdts9I0oIlijKA8IbHwENPuD
 UWJ1MqEZ

Signed off by Jack Livingood <jacklivingood@comcast.net>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index cd7eebe6a7b1..957000d5df68 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -230,15 +230,19 @@ IWL_EXPORT_SYMBOL(iwl_force_nmi);
 static const char *get_rfh_string(int cmd)
 {
 #define IWL_CMD(x) case x: return #x
-#define IWL_CMD_MQ(arg, reg, q) { if (arg == reg(q)) return #reg; }
+
 
 	int i;
 
 	for (i = 0; i < IWL_MAX_RX_HW_QUEUES; i++) {
-		IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_BA_LSB, i);
-		IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_WIDX, i);
-		IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_RIDX, i);
-		IWL_CMD_MQ(cmd, RFH_Q_URBD_STTS_WPTR_LSB, i);
+		if (cmd == RFH_Q_FRBDCB_BA_LSB(i))
+			return #cmd;
+		if (cmd == RFH_Q_FRBDCB_WIDX(i))
+			return #cmd;
+		if (cmd == RFH_Q_FRBDCB_RIDX(i))
+			return #cmd;
+		if (cmd == RFH_Q_URBD_STTS_WPTR_LSB(i))
+			return #cmd;
 	}
 
 	switch (cmd) {
-- 
2.48.1


