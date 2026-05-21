Return-Path: <linux-wireless+bounces-36781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDb+M7CVD2o1NgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:30:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4C5ACBE5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C5D306FC22
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC30314A86;
	Thu, 21 May 2026 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzu0JzJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F67495E5
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405737; cv=none; b=Yah1LcF0DKlABfwcFQ6XounUfPA+a0I+Jo81b8rO0Uy+BfER9G3tPR3WaTEhFCRio6N/9iSkwy+0AIzIydj5AOYuxhsBQcAOS0Zfr0lw+z6HaWt/FBLjVoFCCb+16W9FY/hAt+raEproWRZAQkArst3xMd3mSN+PDfptIrJCL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405737; c=relaxed/simple;
	bh=ketTHLhkINZ/drrC9LXpM2yZ0xWJ/Bx9f+laljnyVRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJ3YcDb3A5T84DF/nZuo+IpFrMMGojGzOaz96hck+4UuH+QEN9Dr9KOJ+Vw5WWzP69v1BjTUoii5DVrlTPYB8s0QMqMGQ21gFLhu7+rvBFIti4WmzVxi+rsivxdlhV7hUf1ADP0xrUJMm5JYJlnI1iBlBLN9272ExNzrt7mVTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzu0JzJm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so70140296d6.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779405735; x=1780010535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UKOPT9vpO7tVqgXvj3ava3zXsZTtMZdAs3/7bhxkzs=;
        b=Zzu0JzJmIoTwEcImUrbS6N1vD5lw9J7iBm9/r8c3sSHLIoZbeH/ATtLHjfNAiUq7Sv
         3c2v16Pzy8LteaCfJxmT9RU6GLTHkT7pfrFIZ/brp2q4FnVG4ZX+QostYPHymSQv6ZSe
         OZlst0A4KlCM6Wga16s340fH3+XZT8l9UCFNFDhea1oMbwQX/JthTzM5yYZekA68jwNf
         XGLxgu77b5QwE/gGmxhOVuC7ctEfXaTB9Mb9pRIoNLJ+celWCV2Yyxz8BBEDIcomntAt
         VnGjB5y7mYVMe5o2zim/Nq+7ZXwS3Jc3ifjY/8dcgIfIHy5AiJwhuiVtCcfgL/K3Wpha
         9HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405735; x=1780010535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UKOPT9vpO7tVqgXvj3ava3zXsZTtMZdAs3/7bhxkzs=;
        b=h7xgKvZthGqqaY9J6sD4HUx+IkXxW4MSiUU5qjypWVauyXei8s+mmYegpJHQD08js7
         S1CZaYL4sX5dQYP3y4ZrBQarofdM+phMKON5DfhHWNaTYuDeSDIZAmUmMB1iTlDxlqgb
         Ki4epFPTfKeRUbni4g1VmiFO9CXuEE8wVH/8pN97sTEee1Jv8ESNtnwejpXXrNi97kN4
         fggFQP3NfnOcNv0gc7PXAHy9GKaF/Tf14G58GDFL5V6V21ta3Y2iZeSm9AVLqa0D7oKb
         ql5E3RdKScoy53Kj6f+0hfLoBPFomDG732QXs+aOdwy9EyhRaWczZnDUIRZNzEnalhDG
         vXOQ==
X-Gm-Message-State: AOJu0YxKI4ien7dQJOCG8qPqFEEuTsaecHtKOgLay1VMJN5c7qh3zqSJ
	WC896sZYjvqpLLuukN/gNFJwrnKeeDI4W7m/gHxSFYmDHOrk/SRNCc1HzbhNCw==
X-Gm-Gg: Acq92OF5WQBpOL4SuW50bKuGpCoLRuL0gnOIR4LDfsQB0inu5cd8v6kihMr/+CFH/OP
	54u8f29OIpGb/Ig9IyT89IfVf+oOX5LV5ihBwaNJQPEpnHv3RftSEE3qcjf4zcJhUOtCset4B/B
	RXJw9abFMq/fcyoPuZnc5li0k/NYXfpWIoGhd8sCCKbDjCrgAJl34mBx3g1fPxhuuga5ruI773Q
	T++hc9jjyuN609dUgSiZL/nClTId2lBaoFI97huwQ45+iG0+uLnnWM+732JftDa3cTMvFZlwzHh
	s2sYrNjjkGTmOdrVoJx+4mWTGXjqPfes1nqOtnd0w9Qc5Wx868KrL3qzXWS9NTt4FrXOmhGkuEF
	gPeVf/KxXyItUJx89yPwUFLjd9zqGG2pstEz3FfKkvxgW8M48vcUTyPnPBi2ZsBgQ1bMTvkbJNu
	iVriPmHvLd024HX+nx/QWaQ9Dkrwkotl9Lgxy3N+BxPdOeIWVllTyJ9qDwTsfQ42Iw7mJ8Qa8nx
	hZvdqvuq9IWisjnKWdpFL60cyINzZ/Z6jblroMbnLLZHw==
X-Received: by 2002:a05:6214:501c:b0:8ca:1e0f:f20c with SMTP id 6a1803df08f44-8cc7b5f0c35mr25342536d6.4.1779405735302;
        Thu, 21 May 2026 16:22:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80df081asm1663276d6.18.2026.05.21.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:22:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: owl: remove misleading error message
Date: Thu, 21 May 2026 16:21:57 -0700
Message-ID: <20260521232157.261575-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36781-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 38C4C5ACBE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The error is about the firmware failing to be requested, not calibration
data. Just return directly anyways.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index b9ef34709202..4460ee7f44e1 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -204,12 +204,8 @@ static int owl_probe(struct pci_dev *pdev,
 	scnprintf(eeprom_name, sizeof(eeprom_name), "ath9k-eeprom-pci-%s.bin",
 		  dev_name(dev));

-	err = request_firmware_nowait(THIS_MODULE, true, eeprom_name,
+	return request_firmware_nowait(THIS_MODULE, true, eeprom_name,
 				      &pdev->dev, GFP_KERNEL, ctx, owl_fw_cb);
-	if (err)
-		dev_err(&pdev->dev, "failed to request caldata (%d).\n", err);
-
-	return err;
 }

 static void owl_remove(struct pci_dev *pdev)
--
2.54.0


