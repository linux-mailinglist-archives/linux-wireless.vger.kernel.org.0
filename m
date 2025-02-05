Return-Path: <linux-wireless+bounces-18549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3AA29BE8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 22:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B318885F9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7D214A92;
	Wed,  5 Feb 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="07wt3H1b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from resqmta-h2p-567061.sys.comcast.net (resqmta-h2p-567061.sys.comcast.net [96.102.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2E14F9FD
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.200.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791297; cv=none; b=SpCAbHOTuRiZBYXHRdZQQL9zVUAfgixSuE2UNtQQCld9MTq+XKFL12b7tiydBTXrcbJCO1CTMpIAwnumMwTBTeCPdOVtkG3hcHCtFvaswYQy94bmCkPoEReULwETFPi7u4VzdrjAssOQPrMECADf77jAJY6LwIZJwWqK97mMaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791297; c=relaxed/simple;
	bh=oQtLVW1siMa6dxWv4dHS9/w9ACrM2WhtKnrvk6HC35w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttbMnkbp7c4d0FlsOgo6KXhjfbThFtnaUwrkC9gUJGVRn2XqWUOXswhpeNnlzUA4sjSol3xoZSFeyRPLpQKoBZ0wEKR6HDLcJXQX1Q4unC9ZRs0gVGOXOFgoJi6O/yfwU44pVVDr6u2O9RRZZ41hbCFzy3rrFj1pqO4A1YUE0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=07wt3H1b; arc=none smtp.client-ip=96.102.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-h2p-555357.sys.comcast.net ([96.102.179.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-h2p-567061.sys.comcast.net with ESMTPS
	id fcyRtGcB1v95vfn0Nt442H; Wed, 05 Feb 2025 21:32:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1738791139;
	bh=IIl7Y48FePx+0bkQhG1DEcLr4n1vHh9BatyYE8sM3YU=;
	h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
	 Xfinity-Spam-Result;
	b=07wt3H1bp9/+5xRICm4w/RsJEQTqz85WgNQLVYWPk98C8yJYZL8VWnUBvIbonaFfQ
	 xWkyjbpWX5sPkqDHEdnrAjnvQQABMO4MkWEkvAXBHa9KikmDxEMd5/AV8wYaDl/eJR
	 MWZK/rRjg9i2SITHJ+gV1KSmMPd2QWXsXklkVhhHyP3q1dNWKCj+ZXvM45cnCONY9Z
	 aTuYkh92kDVk/YtVJcEQr+ivXaTUqXKECSqTdE30XBJ3i/Ijz62bM+VVrATptSm12u
	 Z+15LzU5lqHS5OiGWqNHuQ+1L/xTbswZZsnB9paBMgK/Wn0Au9dh8LYcy5Tlf+7ofj
	 vp4S1HfKJPfhQ==
Received: from jack-livingood.hsd1.ca.comcast.net
 ([IPv6:2601:647:4d81:b870::c894])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-h2p-555357.sys.comcast.net with ESMTPSA
	id fn0GtTWwHjSl9fn0Mt3xqM; Wed, 05 Feb 2025 21:32:19 +0000
From: jack Livingood <jacklivingood@comcast.net>
To: juliancalaby@gmail.com
Cc: miriamrachel.korenbilt@intel.com,
	linux-wireless@vger.kernel.org,
	jack Livingood <jacklivingood@comcast.net>
Subject: [PATCH 3/4] Undoing Macros with flow control statements.
Date: Wed,  5 Feb 2025 13:32:02 -0800
Message-ID: <20250205213202.404965-1-jacklivingood@comcast.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEDSNcB1W0vz+jrnPfU0vXFskvZLpLaToA0ExZziQ1t5bObvwwicQoNyQUotcEwc+IynAgnqwePPQtyn3GSM8hmSZNzSNTxq96RR/jLzkOkBvS6iT22h
 L8HFkId5tOqwXYaDwYzJlpTwx3LDODgpwGbXGi5UdXl7VNHgcsE5zUKOgA+jdVuzVWZGeAR/ocWPlCk1DgsnWGSbiWBV6t6J2y4h6zCkzlV1fIezempqrcBQ
 rGg1QnbUtU2h58u1VQ6t0M85DJx04OH7MUXlwhAtuOEnbfKz3+3zyhk+2k1kk6x6K6y+tbWmsyy8QLwE3J8AFMre8aW+exaOkW9vpQcJzU0bQ5TU+Pz66cZJ
 G2YecCjBZY916uEyByzFnlEs7mU2lN8mmzuUPNXvNId02koXTWw=

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
+			return #RFH_Q_FRBDCB_BA_LSB;
+		if (cmd == RFH_Q_FRBDCB_WIDX(i))
+			return #RFH_Q_FRBDCB_WIDX;
+		if (cmd == RFH_Q_FRBDCB_RIDX(i))
+			return #RFH_Q_FRBDCB_RIDX;
+		if (cmd == _Q_URBD_STTS_WPTR_LSB(i))
+			return #RFH_Q_URBD_STTS_WPTR_LSB;
 	}
 
 	switch (cmd) {
-- 
2.48.1


