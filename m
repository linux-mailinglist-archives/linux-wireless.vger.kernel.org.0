Return-Path: <linux-wireless+bounces-35797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJJgM71892kpiQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 18:50:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A704B6994
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 952983005AFC
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02417BA6;
	Sun,  3 May 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK16SjkX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745852E8B81
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827002; cv=none; b=h1JPYOUaH3zhBHkexHetURX8Bxv+gId2BIERNbVYz6TfSIQiJ0mSsN9jLDlig5kd6DSZiwMQz4aB3GdQRqqf0OyYTu/nWqqSfQrMuvmms2Ga/ro9eX3GIvcBM8hBmMnM1PCZBySY9oeXDfWzxhPgA4aP8eyz013wa8euis0i6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827002; c=relaxed/simple;
	bh=MAesLbO3pFPQdmzgxMe1gJcBgyrryDC3PINM8UT9X5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJF+h7RvgrWoeRx++tbIG6EOQuxhf3L+Fq51wV3zmOgcmADLO7SKkYZcQwk9NU0mf3NqsLXIdErZOyRUmWDRpe4PO2XKcYlJfytfOcSxR8Z3iFG//L+oWCQe638FLlawLe4EGmILuNji1725NLcOWZtJ9Fgy7UWvx/Rcy5Byrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK16SjkX; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726ef332so5170064c88.1
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827000; x=1778431800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWQc0FrxtuCv5JOC4nMJvPeh+aN3vn/WOEafPkyT4Nw=;
        b=gK16SjkXjiBoULIIpyOn5LceApM97qrBFQabT49yZqJ+Hx/OIk0WpLMIxqmLVyH8dU
         K9kg5khDlnMtjHV4BA+iWKBI6hKduzNPc5c14O/veGjQC6Y81Edb16uJmGZsDQconHQq
         oo5JpW4dsMnwQQNkJRYzj6hm7oUPJHzsCPeg4fP3O+KJB50M5D8eGa8MT5GScwTS61tC
         T2HGgykzwdOIiw/7MaFH8g9olgEbZBKtwI2gfP5iVQUFECvCGKdPLYQrESUAKzDLF/rn
         wVg/y5WR+/8tGajQ4Y8WXTpcs7qEqyUb8DZ45LGP8FWnmRC8YRf3PuzKPtMVaxhiJlXm
         Xiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827000; x=1778431800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWQc0FrxtuCv5JOC4nMJvPeh+aN3vn/WOEafPkyT4Nw=;
        b=IBDdOeoOEsCXbwnb7VpnmTKmkMjrE8rlDAl4E/hqJcRLtChSBi711UizrYo72yJgZR
         JFQNXsKKSx+FcBj0xozU9FsrsvkAydtAlCspGh5TXlfBQppbaKt75gxzRi17eHvaT4AR
         9HJ/kbgkrcNqOBqNyz2MyjEppf0qp+M7NGLlJs/0nZiMtH5p5fh0xGb4nyyLhOnyBV2F
         Fssc94m34hh3C0hwOzGhuJEAvxPJR8GXIeCPhxkFqb1gypaWIEfayf3RwrpFSv7W+9UC
         DBxIV6ozuuGFDCnrB6W1kcJ8UIz5oem39OR3r41WxIxoQ9vsGQ0aJP881fLOP6eet0X6
         uovg==
X-Gm-Message-State: AOJu0Yyk/1eNUEl7CL94l3+X/ZOGOXHxANdctdPDVNMLXMZQRyFWPczF
	qXpDWRCZoRsLgMcDUijlycVrRSXPLa/HeSJ7/2H5jqtyFVAKtnyWyT4EzlrpbI2y
X-Gm-Gg: AeBDieshq2EkXvjeNLvqFhZFXIw0KmssFGWrn5FytjjMfvBa5DrBPWV4M+LlJBeSwN2
	QvXjGRKiC6qtAn9/Y0hxTu2Lb9/tm3DtEnbcwy+r/ExPJyZxXnoZP6rCkEgcC2NyJS4rXUzg9sq
	GzjkGj0yVzshbS8tgMZYgHFtB74j+6G3AQIO/Zh7TVH4WJg8mI7uwznuQW3RoBSqzdkoFiAlIMA
	28CDr0Oawj9LFEDExpdXRj8aSD2XekuIzgXOw65UXrfs5Kvmd34JWT2oEmGjX5AYzzbVSkFeR1b
	mbdTPsmVHiXDV6fTN6dkYG8RsghUYzvGhCXMicCDBi2nRoid6CkXlkko4urO7rhIdjwyOmFKTKp
	dn2aYkXn4wINZmEt1m4DRGHSLahG5z8WOZvWWrtFsstQzTQ10Er0AWi3qjiMvhuRCBkq3FWFg8J
	i717UIJqJm22d1zJWd4XaHoK6CStJpnPdmbCgiPJsw
X-Received: by 2002:a05:7300:f194:b0:2e2:a4ba:84ae with SMTP id 5a478bee46e88-2efba28b2f0mr2830806eec.25.1777826999983;
        Sun, 03 May 2026 09:49:59 -0700 (PDT)
Received: from fedora ([2804:14c:f288:8f8d::1b2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb63c5fsm12316928eec.25.2026.05.03.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:49:59 -0700 (PDT)
From: Gabriel Maia <gabrielvinicius.damaia@gmail.com>
X-Google-Original-From: Gabriel Maia <gabriel_v_maia@estudante.sesisenai.org.br>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	kvalo@kernel.org,
	Gabriel Maia <gabriel_v_maia@estudante.sesisenai.org.br>
Subject: [PATCH] wifi: rtw88: add quirk to disable deep LPS for ASUS VivoBook X515JA
Date: Sun,  3 May 2026 13:49:44 -0300
Message-ID: <20260503164944.27114-1-gabriel_v_maia@estudante.sesisenai.org.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44A704B6994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35797-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gabrielviniciusdamaia@gmail.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sesisenai.org.br:email]

On ASUS VivoBook X515JA laptops equipped with a Realtek RTL8821CE
802.11ac PCIe adapter (PCI ID: 10ec:c821, subsystem: 1a3b:3040),
the driver periodically emits the following messages:

  rtw88_8821ce 0000:01:00.0: firmware failed to leave lps state
  rtw88_8821ce 0000:01:00.0: failed to send h2c command

The firmware fails to leave the Low Power State (LPS) in time,
causing subsequent h2c commands to be dropped. Disable deep LPS
to avoid this issue.

Signed-off-by: Gabriel Maia <gabriel_v_maia@estudante.sesisenai.org.br>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index bba370ad510c..b0eae0971ef4 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1770,6 +1770,15 @@ static const struct dmi_system_id rtw_pci_quirks[] = {
 		.driver_data = (void *)(BIT(QUIRK_DIS_CAP_PCI_ASPM) |
 					BIT(QUIRK_DIS_CAP_LPS_DEEP)),
 	},
+	{
+		.callback = rtw_pci_disable_caps,
+		.ident = "ASUS VivoBook X515JA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop X515JA_X515JA"),
+		},
+		.driver_data = (void *)BIT(QUIRK_DIS_CAP_LPS_DEEP),
+	},
 	{}
 };
 
-- 
2.53.0


