Return-Path: <linux-wireless+bounces-32502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JwyDjxjqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:04:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A65210444
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68AE630C5EC2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8337A4BC;
	Thu,  5 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBoxF9WM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783521B1BF;
	Thu,  5 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708296; cv=none; b=nWtiAo5ItyYiFh9x0DDtLZLYsglzNDrMbtflrETFnijQlct0iCsdnT2mgycIsGsrrYsln7OyxHQMJt/HBh+DnqBjNQseDwXml9/gqcg9H+3ioghYKRgN3ptBBFYnI/x0yDlvchjBISGJxg+TXLfWyN0kK42oGEjpINzF7i8R2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708296; c=relaxed/simple;
	bh=CldXdF4K1Mffbg5Hf+ZzFSSzMyz/wwpC433QQhvr9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A64OSm2ZnC2Ac6PVqx1f/naPr2pvg2IfTE3J6BKwYAEvMan9QrpVpD3dUP5vEQ1FXGC7iKwqBWdfAhuQK96QXfF2XUxgDD91gq47mh8lKLm+9Vo9sQLSEUA5zy+1mq0sHoly9LCWBqkWQSUuBEd9HA/T1gxu3kHg01erD9ZZEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBoxF9WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ECAC116C6;
	Thu,  5 Mar 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708296;
	bh=CldXdF4K1Mffbg5Hf+ZzFSSzMyz/wwpC433QQhvr9WY=;
	h=From:To:Cc:Subject:Date:From;
	b=XBoxF9WMzE8dwmnHVT6lOflO8O8kKv3qZLwK9SdJsUBY0koyMTZvOk2gfqZikMtrz
	 5uVGoEz8FVWpYRSDX5Mylxjuup1W/M3mkbj9msKLvg1eSTC/BwxjdpFe8DpdM3xdji
	 UxHtdultRBnTm0L0bgRLC1tmtuO9RIzXiKAcY7BZjzVsXUvYaYv7tsWfZwSyHew1zg
	 HgJxS2psvCZKeioGe2/Rvlit3qJXk5tyN1sZSaYWsDL1xthmKSRsFM9NFUNtGOBHCS
	 5BdsZf05grvw8Ptw5aiUQr9sv+Y7TpeI0qsBS9yDg1nlqd9fjEZnms/uR4aXDDPYN4
	 ToQ1PXWmvPesg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6PF-000000004Qh-2vM8;
	Thu, 05 Mar 2026 11:58:13 +0100
From: Johan Hovold <johan@kernel.org>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] wifi: ath9k: drop redundant device reference
Date: Thu,  5 Mar 2026 11:58:03 +0100
Message-ID: <20260305105803.17011-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4A65210444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32502-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 8533b88974b2..821909b81ea9 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1382,8 +1382,6 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 		goto err_alloc;
 	}
 
-	usb_get_dev(udev);
-
 	hif_dev->udev = udev;
 	hif_dev->interface = interface;
 	hif_dev->usb_device_id = id;
@@ -1403,7 +1401,6 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 err_fw_req:
 	usb_set_intfdata(interface, NULL);
 	kfree(hif_dev);
-	usb_put_dev(udev);
 err_alloc:
 	return ret;
 }
@@ -1451,7 +1448,6 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
 
 	kfree(hif_dev);
 	dev_info(&udev->dev, "ath9k_htc: USB layer deinitialized\n");
-	usb_put_dev(udev);
 }
 
 #ifdef CONFIG_PM
-- 
2.52.0


