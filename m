Return-Path: <linux-wireless+bounces-35253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a7MAGYON6mnK0gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 23:22:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACA457C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 23:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512AE3011763
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4B3BBA15;
	Thu, 23 Apr 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="hGHBB4aB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F003BADBA;
	Thu, 23 Apr 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979324; cv=none; b=ROQat/MQzOovQXK1AVLTlLoEZW9j8JOgHZrpRSxxEN5mDO9GtRqQNEWj7LXhSiiZ4jybvoeUKcnrM3xYaXLpTKAPheJIofVcNaDzErrTQyCoE0SzG0fyrBzq626It+3vZtlaP4cjHPukbeJlMqJSeS5AN3r6cKoNwdDyh71+M/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979324; c=relaxed/simple;
	bh=Wpf9+RHRQLbm+e634wXmhtYt8E5vE7ldEKHpQYlLgkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UzrMJjDF7mPjhg3zkTtBE+eAUZpN10p88f47PnGVY/oudaK6cXKlqLoib8Zd5rS8v8FO3nwiQPkonz7fwuLcWicIose93l0+X1wdNfyjYOTmCORYWpQy7i1erQoGiDyzhkgHcrVpfH82Ubnozhclpyb1IFwcdfwt48iU+RGKSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=hGHBB4aB; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4g1plJ1Y8FzDqTF;
	Thu, 23 Apr 2026 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1776978908; bh=VkI+kJH653kLgpHLSQ4P+17HKlApcKg+ogIwy7rHFZs=;
	h=From:To:Cc:Subject:Date:From;
	b=hGHBB4aBDapVSTWnZoFdYYkvcrzoqtyu3MNoXtiySZLSBiqPjvPdtNUGPrSs50jAv
	 I/vb1rx04mg0MSPzqEZb/BYBU5a/I8QKfdVzMAasPh96FGY0taBIgw2zbQuE/dRKkB
	 T2ybJ9biZ2daf8jBH8JAoacdP/Z9zSPymdCAnn+o=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4g1plB3Y0vz9smD;
	Thu, 23 Apr 2026 21:15:02 +0000 (UTC)
X-Riseup-User-ID: 1C3BC6EB3A684F2CA7FD9299946DD4FA0670C2ADF181111521174CAB2B0814B9
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4g1pl92zQ1z22My;
	Thu, 23 Apr 2026 21:15:01 +0000 (UTC)
From: =?UTF-8?q?Santiago=20Ruano=20Rinc=C3=B3n?= <santiagorr@riseup.net>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	kfarnung@outlook.com,
	koike@igalia.com
Subject: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
Date: Thu, 23 Apr 2026 18:14:54 -0300
Message-ID: <20260423211458.458911-1-santiagorr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[squebb.ca,outlook.com,igalia.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35253-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[riseup.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[santiagorr@riseup.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email,riseup.net:dkim,riseup.net:mid]
X-Rspamd-Queue-Id: 37ACA457C5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
table") added some Lenovo platform IDs to the quirk table to address a
wakeup from suspend issue [1].  However, at least two more platform ID
are missing in that table: P14s Gen 5 AMD, as reported by Kyle Farnung [2]
and P14s Gen 3 AMD.  This commit adds one ID for each.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23

Tested-on: P14s G3 AMD.

Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
---
 drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee..56938d5d42a1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -957,6 +957,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G3 AMD */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
+		},
+	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
 		.matches = { /* P14s G4 AMD #1 */
@@ -971,6 +978,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s Gen 5 AMD */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
+		},
+	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
 		.matches = { /* T16 G2 AMD #1 */
-- 
2.53.0


