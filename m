Return-Path: <linux-wireless+bounces-33346-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CMUOOs3uWk8vgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33346-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:15:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338A2A893D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F23B306C472
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26713A7F5D;
	Tue, 17 Mar 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AbeO/2KI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C934A775;
	Tue, 17 Mar 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745928; cv=none; b=iCH/M5/iTHEIHQol2JvJMtpwRewi+0mDDvYKgU2SrtZE+bMnF6Hl0YXzqDkxS6dPTQFsNZXCySc0RR79Y0i/hPMh6577ixa20sOp/hsqxHCOvoMNEDH1b2+Ycf3D5iOIUIoSrdtqiUcm9ZiuktmZSEh0G/enC7v7o3xP6qJiKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745928; c=relaxed/simple;
	bh=UpMbgdGpif1VYGxms0CsIIG4VYoqm+CrqUZVO+7ixKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ks3p3OIsilPJYnuSvAjlIEt05bVrEQvAlyU7PR8dG/I/JbwN2VWByQoVObCJWK3g8dgKyN3bvVrBpw1SVkWT1bU11DiyRnYH6mhmAKlVQCul/Do9dEEyTm2W4Jus83uIjs/9o9RRPuYk30p3k89Oqgg1p1eP0AcQg38E/rdeIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AbeO/2KI; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cWxcmL/wzD9sIbxY9dY33pmEH2ZkxNt9cL7up/78YR4=; b=AbeO/2KIxISN9bz4EwO+aNxxrp
	2SpEtQUK0o7Um0w4cLmLHfy/F8TWd7XEOEDPLFVVslPlzRN7TcesbuFo25UgAPj6ZLdrv6KuNhqgX
	2fY8l6B3QoCSg7FSGwxgqs93X7FoGFeM4b+OBiKzTkMu5aoKJPOnen825QJr9B68ptSvOvCoD57/L
	RDSszh/QtDRl38TjmCKl5sY6W0aPvsZSHNthISb86rOm8FvnVNfmPBQK/jJZdOGDIQ5JGL/89Xo+u
	odT/Xz9TUhdQJjORS/HhJSiUg7tZzdcQGneoKzGkYGk0/ZeRwgCzk2baJn3VIscV6g9nuy9M+5ejb
	ovKYTQ8Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w2SLE-0007KF-1x;
	Tue, 17 Mar 2026 12:12:04 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w2SLD-0005Ox-30;
	Tue, 17 Mar 2026 12:12:04 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] wifi: brcmfmac: silence warning for non-existent, optional firmware
Date: Tue, 17 Mar 2026 12:12:01 +0100
Message-ID: <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27943/Tue Mar 17 07:24:09 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33346-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email]
X-Rspamd-Queue-Id: 4338A2A893D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver tries to load optional firmware files, specific to
the actual board compatible. These might not exist resulting in a warning
like this:
brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4373-sdio.tq,imx93-tqma9352-mba93xxla-mini.bin failed with error -2

Silence this by using firmware_request_nowait_nowarn() for all firmware
loads which use brcmf_fw_request_done_alt_path() as callback. This one
handles optional firmware files.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c         | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 4bacd83db052e..e84cec58470c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -714,9 +714,10 @@ static void brcmf_fw_request_done_alt_path(const struct firmware *fw, void *ctx)
 		if (!alt_path)
 			goto fallback;
 
-		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
-					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done_alt_path);
+		ret = firmware_request_nowait_nowarn(THIS_MODULE,
+						     alt_path, fwctx->dev,
+						     GFP_KERNEL, fwctx,
+						     brcmf_fw_request_done_alt_path);
 		kfree(alt_path);
 
 		if (ret < 0)
@@ -779,9 +780,10 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 					    fwctx->req->board_types[0]);
 	if (alt_path) {
 		fwctx->board_index++;
-		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
-					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done_alt_path);
+		ret = firmware_request_nowait_nowarn(THIS_MODULE,
+						     alt_path, fwctx->dev,
+						     GFP_KERNEL, fwctx,
+						     brcmf_fw_request_done_alt_path);
 		kfree(alt_path);
 	} else {
 		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
-- 
2.43.0


