Return-Path: <linux-wireless+bounces-36779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLp8IIyVD2o1NgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:30:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B995ACBB6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50AC530ED377
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CEC36CE1C;
	Thu, 21 May 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLSAXmfz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1392314A86
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405507; cv=none; b=hCwXfUzqrLmHfkkyktxr/W6PxFfw//QNempB9NnnRad0fU3p6HDEaj/7cIQZWJkb8m8Dc7zQvYnB57GDZPSXChFbnQSkv93XaJurtVVDKUJua2tTCfCjgYQCJLXwZM/iN2a1mFAekf/P0+Gq+ycia0LUu8FbvZ2fMMqvDgV8ITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405507; c=relaxed/simple;
	bh=aXhNNcanlN/mShDPivoLsZ009hbLKXSsJtrCprAaoQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4z4rmj6HI5B66TO2WQLasd+7Ud3bOQeJYQTrCyN6mmFUAvYfD/eKsLXzHPurUncoxIPDP3D8QqmZ3Dd3JRSpTCim+RH2T85dU1xjUazAJ/dyK6e8leKg6zXPCbu2xOFphlSFWcigJRtyUa+FempTO9VZ2niSPbtK97ARMguzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLSAXmfz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90d042fa745so1145278885a.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779405505; x=1780010305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPwHAZ/pyKI67ku8L9HSP8xOIyt+QF0I1539cMaL9oM=;
        b=LLSAXmfzDc1DDri8S71nyTZBp4dTj+zNi4Y9LdXgkzh2eriu9TH8BQakZ7f6hbnQQQ
         b6Zf4srwVqQpNd0njZr8eyDP9A9DjQ6s6PkueVNiQ4yLxALxPo71/njwVmDQgH1+CM/F
         zjzzhC0gyoOamQpAwoITP7n21J1Dp/4fWZhi1bx9IUXADUUNQbzXdErE1OGthN/M6FRD
         xgqJJUR0VlQ8C+lmeCoT0iFyXZtm2miE3OOyLEqyrZip5PfwMOckTtnKinCHjjxTV/Uo
         e7qcDqQJQuzLgPH8vUf6MXo143QxwRCJvx5j6PVVFxFBqub8xDSoSE+1EE2cEbrh1ETd
         bijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405505; x=1780010305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPwHAZ/pyKI67ku8L9HSP8xOIyt+QF0I1539cMaL9oM=;
        b=BswSLdqDT5ao7PC51iCoq4pQeQijugyC9KUQ83uMgkrloNn47Xg8D3L+Ca4r8TrBZ2
         VBDjIMv1gVMKBSOAFFnHvplphVJnj1/vARmslY+5XBzH7kg3Dj4f1ldLPaR8uD0XACno
         SW4AWhRdKGrLtpyzwu2vmUBwvp8VGq0KPlzbnOc0DK0Mkphm52WWmSbO9kE0vxIcqhHG
         vfoYxBzbzKY4nHfdIVCu9Ltfh+NdqGNbnC0oNjHy7WiP0RkDClXvfMSeZ3+KTQFoPdvo
         j+4VoT9mq/q5AjN+Sjyj/a+1afxZ0BZjPUNfPnoULzwspy1osBLV4uwu1eKg/aLDXODV
         Lpeg==
X-Gm-Message-State: AOJu0YxGNJrqqLFduCvK586Zmt7aWRx8ERynoFBj0s8JM4p1mowHq1iR
	B4dS7/eJb0KSdKBWJxqdVFT/0STNveH0pvq4u/aOQWYbAv4h10l+wdaN2H3+Yg==
X-Gm-Gg: Acq92OFLSX8GjMyCtll6uhax2pYdjaAnuhmOwk3eCdB70B2orxWPF1YjlVqjkPezJX7
	MaH2L97K+qRxPxniF/fgcX6Q45d6awHPXcpg640C2bnKSHrYWsANCzjcinrZapksTQgmczNwNrE
	iHfxF8KRN40ny0pSt5ynvwZKryCDcB7xvJ9LGnGK1RIlBfQeMJmlc3DVUOvPJNRDOphWKUgLizP
	+icz4bp9Dx+37UzZsLFrdChcnhTRNjVfX1+Ig5JmUoDXYNYliTcfW6dF3Go+pXvrN5+vtWFPIJN
	WtO1gNeDDJh0XMhGGY74ejSUTTFUNqtO6rvHhS6euPAMlGnfAMEcKAqeZUGkZ/QRZ1pihImxvuk
	43xpPccn/KHd0c2hxFv1phclaSTdlo3vFZPo4vngx4uEZEpjcHAH2uAGnda3dgEZe5eS2KirxBG
	K7A1CgO0XcX4/ktA5gioaGphpjghi5WAM6/sqJrV+Le+Stx3HNAPS+Vr/T6IZLxFTjOZrvtFP9s
	1JDm4WSlJPn0PStG5W2laWSKG+VqM6BgmMrv/JSq9lSvw==
X-Received: by 2002:a05:620a:4686:b0:90e:6dd4:5d6d with SMTP id af79cd13be357-914b46b998amr233072785a.10.1779405504652;
        Thu, 21 May 2026 16:18:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b5d6b602sm35520485a.8.2026.05.21.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:18:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: remove disabling of bands
Date: Thu, 21 May 2026 16:18:06 -0700
Message-ID: <20260521231806.261220-1-rosenp@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36779-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9B995ACBB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The old platform data code that used this is gone and this serves no
purpose.

The modern way to disable bands is ieee80211-freq-limit, which is
already implemented.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hw.c | 16 ++++------------
 drivers/net/wireless/ath/ath9k/hw.h |  2 --
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index cde318a21a81..9202998920a9 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2527,19 +2527,11 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 
 	eeval = ah->eep_ops->get_eeprom(ah, EEP_OP_MODE);
 
-	if (eeval & AR5416_OPFLAGS_11A) {
-		if (ah->disable_5ghz)
-			ath_warn(common, "disabling 5GHz band\n");
-		else
-			pCap->hw_caps |= ATH9K_HW_CAP_5GHZ;
-	}
+	if (eeval & AR5416_OPFLAGS_11A)
+		pCap->hw_caps |= ATH9K_HW_CAP_5GHZ;
 
-	if (eeval & AR5416_OPFLAGS_11G) {
-		if (ah->disable_2ghz)
-			ath_warn(common, "disabling 2GHz band\n");
-		else
-			pCap->hw_caps |= ATH9K_HW_CAP_2GHZ;
-	}
+	if (eeval & AR5416_OPFLAGS_11G)
+		pCap->hw_caps |= ATH9K_HW_CAP_2GHZ;
 
 	if ((pCap->hw_caps & (ATH9K_HW_CAP_2GHZ | ATH9K_HW_CAP_5GHZ)) == 0) {
 		ath_err(common, "both bands are disabled\n");
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index d9d2f64c5570..b942b8303d8f 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -974,8 +974,6 @@ struct ath_hw {
 	bool is_clk_25mhz;
 	int (*get_mac_revision)(void);
 	int (*external_reset)(void);
-	bool disable_2ghz;
-	bool disable_5ghz;
 
 	const struct firmware *eeprom_blob;
 	u16 *nvmem_blob;	/* devres managed */
-- 
2.54.0


