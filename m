Return-Path: <linux-wireless+bounces-35755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGy+HiPB9GkDEQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 17:05:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F64AD7E9
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBC3C3010263
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05483CAE60;
	Fri,  1 May 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oR+45DUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887E3A5E73
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647903; cv=none; b=i2wOft3IDEILv/PpRZPuPovRJESHyJv9EKExfHjilVzsHeb1swX6padrTK73jUbRKikqQSMBN/3UTeDUyX8Ap3i+0sdEn+HlK/oercPkjKRutgJlyDDkgFkObpKpYeluFMFSKnoVEuZG8TxaigyKwnvysciIgBuCQH6uTGyE+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647903; c=relaxed/simple;
	bh=/y/gaHlznUUO1DZKGIHAKNrKkujCtryx6gsz82mEeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0NoB8bn5ys9RZ9O0eA5C/my3OG8/bs7/HhjfUAVVCKI+7am5mwYztIbsM7ZaNYFeVWbu9nDZ4duHzUg3JvF4DuOc83t12Cj6/c/ukR7iW0UO8h2S4sKDFbynBSNM/49URzXu018s59F9aKAGKdSPEqzTAkYT3TNNT8pynBYp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oR+45DUd; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777647900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QXqyhe6SNX+aC9KuwAMEIvSlU49jdCuAN0y8S3VOMlA=;
	b=oR+45DUdC6MPNsy498hVXyqCoIuXvI05arsk4DiRdjq36m0Cjq94Fcgb/+qM8x7jWzg/Ac
	jNdGKo/SWVUsx9+rIJCFChit/A/Yg0izsaj68eikuaFznMDbdZyX5Y4uOBSG23sYeM9wRi
	DDsjbaAMNqyg4kGqIw7YFL5YzQicRK8=
From: luka.gejak@linux.dev
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
	Brian Norris <briannorris@chromium.org>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: increase TX report timeout to fix race condition
Date: Fri,  1 May 2026 17:04:02 +0200
Message-ID: <20260501150402.227788-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DF7F64AD7E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35755-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

From: Luka Gejak <luka.gejak@linux.dev>

The driver expects the firmware to report TX status within 500ms.
However, a race condition exists when the hardware is under heavy TX
load and is simultaneously interrupted by background scans or
power-saving state transitions. During these events, the firmware may
go off-channel for longer than 500ms, delaying the TX reports.

When this happens, the purge timer fires prematurely, dropping the
tracking skbs from the queue and spamming the kernel log with:
"failed to get tx report from firmware". Dropping these tracking skbs
prevents the driver from reporting TX status back to mac80211, which
breaks rate control accounting and degrades performance.

Increase RTW_TX_PROBE_TIMEOUT to 2500ms. This timeout is large enough
to comfortably accommodate the duration of full WiFi background scans
and sleep transitions without incorrectly tripping the purge timer,
while still eventually catching true firmware lockups.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Cc: stable@vger.kernel.org
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index d34cdeca16f1..95d15e4f5d34 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -7,7 +7,7 @@
 
 #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
 
-#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(2500)
 
 struct rtw_tx_desc {
 	__le32 w0;
-- 
2.54.0


