Return-Path: <linux-wireless+bounces-31679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOotLi+UimlvMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:13:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BAD116318
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A0F302B82B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9B2D6E68;
	Tue, 10 Feb 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD3EAKkN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8612D0C94
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689578; cv=none; b=R9hCMZ85pnNRbR5jQpWA4pzf0VIYkmXF0noG0K/ngAzzPDPsM7fvC4Zj9Cvf1WDMbcZy0Q/G3VUTIzBa4uQFZxD/Y+o9Es2CX+4HHlVwsLjjme9vFEbmC8rCyyu3lZOr7MVXn8gPJqSkJmBvXKSr4eHpHeT1Z2VGrJdcEpNC6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689578; c=relaxed/simple;
	bh=/CNu3or6IvmW6a+NEI6b/c1pNPuTW2PtNIWZgOO9Mfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0SeomvMb5lvedkhG/N0mzWfP0HSx7sX2dn1AKRwAXaM4arSelLla1lpSfi8ZlnJ5MRXQ9acRGOdyKPMUbUtY5FSUCHfqyU0iyjjvEpyhiPTWc1TZp4bOHakGJCAn2zZYJoNnt40w97YqDNDznJmEuyv2zloLV9qeAekGRWl2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD3EAKkN; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba68df3687so3043767eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689576; x=1771294376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JS7YM6T2z4NTuWOeAxUIARMzj225fodPnkXEYUrFD10=;
        b=kD3EAKkNFHRxlmaZd7MT3V5uNxPdPBu0Yr/+LInwcpKVM10xZ8YCIxt/A+7cF88hvO
         EDX4X2sBHTxQ93F9xXwPj7lM5dae8qY+ixk2ZUNhC5MVewsIB4UCzecOym9nvbeNtzcc
         8XR/M81kLBOfQ9kl4PwYjQ3lVPZgFZDkD52e6nt51QD/k+0+EfWb7n2U1iUdr5v7awC4
         fruc9SWnqgJSojNoKJiv6HuL9kmUFSasQHvpHkdfOVTAQT+qV2KD8HKJIxLysMO91D7W
         64PVBRe0tBrniqKl9Ey1Q2Q/SGqaVeM5mT02ZXpfU8tDifi2vVedfvSjQk4nJqza/vs4
         nI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689576; x=1771294376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS7YM6T2z4NTuWOeAxUIARMzj225fodPnkXEYUrFD10=;
        b=CEBUz2yeDW2cco3bh1umacFnlPsdL9LWRRRdhQnbDBXNMq2CiWIArSCKw0h08iKRS6
         nWNxBZxN5FBZNQW6sVEt60GG8BoFEnB6m6xpHGM+h+kvv2BFdXUhr+011kcmr0etMctb
         oADkDiC3bstAm9S/yw0cqLMHRiOZIPGdeHgAYE/U7WrMkN/IG6Be3CtbUIqEHO0uubhv
         +rIU179vPNgGDsBngx8xv9l7SRM2Uos2XOmSL88cfjr6AN6zor9K2AheIg0Dv/di6nEW
         ESXZXSRsc3gLh62B6VNPj8EkwoWWCNuRlDLRusKeg1AolPMtlxe+Zyrm+S7JDsKM/uqB
         cpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvM1bBcYtoIOHQzhvlhDF/1HBGTT/tW/33Tz9RQMG1CgOIs0tPT6AWBDY5nPUo+69lSGhXI6XEBYGF/wCTmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpJ/0vwtlDYFvEMXx+2lnzs62V3MBnLF5GlwFuVLdhV2yGFrR
	dLBjDmZzWgUlf3OKlqUNJSQDjmVNxOv1V+CFtdOeEJUTVt2ejGVeDswi
X-Gm-Gg: AZuq6aKM6aZzDR92o4b9XVp3bVY+B3qmUY8xKeThvFXKYD1P+MTgARG7pV+CGAWM09q
	R+tSkSIYRV8Yk+Est9i3Am1T1NHRUnX7TL6/+5Mgt3CIS6HCW7hMNcCho9ye/IdyfsgQTQ1m+tP
	qTpPxtXThptKYVBlCP0i1BvjnUjy/MM9lXVrnNTu0QuO1HN7BvWUzCXOf24UCceLC1oSyQQ+J3J
	WqKkGweeNJTAM/zqflRsRJqCMAw/ATCECRgSz9DPR/fuIaI1XxtUCYVLsuS8Im8/SggDORV8I8n
	ABSsAaMU7fAFJpOPJJ2YC2HOAsjPtw7N8lEMjYvftxZs30Q82g97J/M2uwQBD+4anfLc+ZA332M
	Ra61ZsCk/pZvGVOJtLbRdsWt/KI4dPQugANg/DrcrA/HOdccj2i/5gaduRQLnClUiLr65dOqhGj
	A50x8u0meFxixjzWEIZKNmjsnRkNJep+jOItQqXrOrThi5UsBuSOhYWnpdqJFodI/uikAinA+0n
	KD8Xa/J7DW0d3+2EFmxfVJwexHaHGAdf3ULxky/YfvG1Z/mdkQv66FTqSd4RzbxItZxzfFrze0I
	HS83ib+c6e+NOIVQug==
X-Received: by 2002:a05:7300:e80a:b0:2ae:5d3b:e1ba with SMTP id 5a478bee46e88-2b856836f6fmr5038313eec.23.1770689576354;
        Mon, 09 Feb 2026 18:12:56 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba81eab184sm1472747eec.1.2026.02.09.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:12:56 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alice Michael <alice.michael@intel.com>
Subject: [PATCH v2] net: intel: fix PCI device ID conflict between i40e and ipw2200
Date: Mon,  9 Feb 2026 18:12:34 -0800
Message-ID: <20260210021235.16315-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-31679-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09BAD116318
X-Rspamd-Action: no action

The ID 8086:104f is matched by both i40e and ipw2200. The same device
ID should not be in more than one driver, because in that case, which
driver is used is unpredictable. Fix this by taking advantage of the
fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Cc: stable@vger.kernel.org
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1:
Rebase on latest mainline instead of net-next

 drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3bc3207054f..02de186dcc8f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -75,7 +75,13 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
+	/*
+	 * This ID conflicts with ipw2200, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
+		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 09035a77e775..b0e769da9415 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11387,7 +11387,13 @@ static const struct pci_device_id card_ids[] = {
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
-	{PCI_VDEVICE(INTEL, 0x104f), 0},
+	/*
+	 * This ID conflicts with i40e, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
-- 
2.43.0


