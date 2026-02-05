Return-Path: <linux-wireless+bounces-31577-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcxAdNMhGm82QMAu9opvQ
	(envelope-from <linux-wireless+bounces-31577-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 08:54:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC6EFA13
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 08:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC99300611F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66835FF58;
	Thu,  5 Feb 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1GjaFyx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BD35FF42
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278096; cv=none; b=In01cA4pQRkPLfyWHjk+PoyRqTR2NOqvhMzilQ7cjjmLmxKf+6TyLUdTogugUevpThI7y8lbTE7nc9AfHaWWbOx+1fbKc9KbMrA/Zg3KOyah0fsivrCEd/KtLsHJjK/oBHoQltV71BSqm6KrfPJRvi5mYM7v8xbAu9EMu2b//zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278096; c=relaxed/simple;
	bh=0QPmD3khOolAd8Pn3PVfrdLjo36wnyy1/CNnpQc+9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/T9QKXeZ5OJ5PdqE7zl7WypgIzyhhn0/L6ORNItZb/0U0Z2A4vLXP8xYNnRS2PG3QtPhYu+29CPknHOoPlHQ56+yvfbjab6IocUDEnXIEnnbt1sIsh8kyuduNnoJunviB3eJubvEHBsgFGQclG5iTNOfnNhhtmbnm1v9MdNIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1GjaFyx; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12460a7caa2so910924c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278095; x=1770882895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBBtBB/edst42TJYyd/52k6/BJT8oZp8WOZjI5v+niI=;
        b=U1GjaFyxz667KWALHbxvEBqm7+KBwkhxn17k3vKfnCJGD5+2IFzFku7WgKg7rjr1uX
         tipYHVksbun5YboKWycLlNUTgzP8RwakDVaLJ9DEeEXKt2ZRto6qVPNSx4ArE3qruVdO
         hblI/i6pIFQq/hYYTO23WZR7inwB5aHPhxqOiDoNnZ7DJj/NBd98xbpzIlRonTegd2BA
         OLOnc/IvF0V1LlRJXJh2Tr7D4ZY1jjVQDXATQD0PXpFY46FNJbN41XNQAJUh8UkasbAQ
         SwxG8MqY5HlvxYnFWRBimdPJziJjhYBPDQxyENm4FPQpkHF5f+UWTKc9HA0Rfqb1m9pl
         m2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278095; x=1770882895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBBtBB/edst42TJYyd/52k6/BJT8oZp8WOZjI5v+niI=;
        b=LAMd2fzFGND+ZbhyS4R4EJemAU2A7f/+KDUs+Iz8Qv/MwiC1D9aYhgFx/PnEbyPp9X
         ORgNiuJ4UvJ4aZ48m/9U9Xg+CyD34WEnHWUaget2V6sqTmJ6razzv7wgznS9JLNG4slA
         s9zwJOWKAthhRrTh7KolEjkkeHr3z1+8EMPtKHB7oRVx+NovrG9YQ7x3ottW5bikswZ8
         TPjFHSVCyLtlYb8z5P67sjFX5Q4tqmRparrav6SXr0aOUT2/5MLSqL+s4gHZcTlsUIV0
         eMQeqb/ELPF3Nldipf6qS07CSoCT+zC3nyrVC7FGzmJPPUfD2A8gDy8nDlARthLQAEal
         JHuw==
X-Forwarded-Encrypted: i=1; AJvYcCU/3vIlq6PHvuyO4x7NwcggENim4hweb0btvbmWS0bNDiUt3gVF6iXqMvHJKKFlqR3UsFGz6db3FbDVkFtpKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7sdk6L+Hg1/MFDyg8yE08e6iE17cSbzn7zDyraxWNw799I3o
	RKfGjUAOetcjbAyBmwEx0Hd2ZayQOiHnSkZD5o90fOXfDwJO8dX39RKi
X-Gm-Gg: AZuq6aKKF7+NntXCzETiStglwKRJ6s2DQArCF1UhpsccIv1Qp4noNJAm3YyN1zjOPXC
	vfFTBwz3uDMO47sCeqYxe5cEpwL/CGrK4iPN80LWcpI1sQ9iiOf284QrBvJqIwmdO3aTGyfHRoH
	mYwLXwTdjIwFwkeX8ol0LnddPwiQ8b+0+hGSL9pqNDHgtxBhIjA7APugIKKvLh6O+X8b7PVvWeM
	I9/BC1Bcw/13NrX63hr2VUrRT/zgu9FCBYdUBez1Py3fI4JxRsOR3OyOlHx67e4sfw+eYrJpWsH
	8mqag4iEhZ2WU7+DQAdDF+oGAcUZeegq+F7sbpIx53UbDb48wZ6QvAO+BhfwpsoVoJGu1X3hA9n
	IbgVd82DLxo5yUnNjJxbDY2fWqaBe/63IokZIxvGshfmScLHvlIdq85hHkgNGkC0izbnwjYcxFh
	brVk/I0M4RQWahnPAJzzqXlu8fFdsPfhUgsAfTEyxM6WF3JlgmXC008LSOswLRDLVcViSLUC8cP
	kAafAtiLoot1PTgea12J0EtwFiLnSO6jrtoARf3GMGwEKeIEO/m6dG5jyex5/8HGidDxbVQPjcw
	VwRQ
X-Received: by 2002:a05:7022:252c:b0:11b:9386:826b with SMTP id a92af1059eb24-126f48ea569mr2767700c88.48.1770278095077;
        Wed, 04 Feb 2026 23:54:55 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4bb8b02sm4007563c88.0.2026.02.04.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:54:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Alice Michael <alice.michael@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next] net: intel: fix PCI device ID conflict between i40e and ipw2200
Date: Wed,  4 Feb 2026 23:54:44 -0800
Message-ID: <20260205075445.43347-1-enelsonmoore@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-31577-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FAC6EFA13
X-Rspamd-Action: no action

The ID 8086:104f is matched by both i40e and ipw2200. The same device
ID should not be in more than one driver, because in that case, which
driver is used is unpredictable. Fix this by taking advantage of the
fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b1cc0481027..2c8f449ad659 100644
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


