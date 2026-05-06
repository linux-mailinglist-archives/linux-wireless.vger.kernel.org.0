Return-Path: <linux-wireless+bounces-36040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AFROIig+2kZegMAu9opvQ
	(envelope-from <linux-wireless+bounces-36040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:11:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D29F4E0146
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E891630097D8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33633EAEC;
	Wed,  6 May 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="rPgOx3jt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1295314A86;
	Wed,  6 May 2026 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098286; cv=none; b=ZmD7UV6mQytmkIS0SFujA+2J2mapsT3AbRQgWVLvuHp0jsjtdrxlfNyUnZ8ICLshPx3Tz5pn11gtiQqmyEHD1S4rf7ZtbMFHos/v1N1mHgVoebQI9Am80nQlb96oo/F98Uh8PxWu2OgQeBWJINGZz1fs2OVzqDzNbtCUPaM3NWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098286; c=relaxed/simple;
	bh=ZzWNw099T3hlULv2mT6i+/AwSfAsML1KA3LVuYsrTjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+tnljOmilzyEBkH9Ci8/esvgyXnywePrAHT/4ZUMNMYmjNWDKyleHFE/uS5fJML8FwkyR3YPVyCAjHmrLJWP2py1MAcQOlJ9hoFSUOhWLK63yYggAfycElsuoevi8fvgZTSMy1Tmwdxn59SS0eDr9AuL6Vz8yoz5ZgNUxF3O3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=rPgOx3jt; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4g9mX55J7RzDryq;
	Wed,  6 May 2026 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778097781; bh=FBStJu5AVvcG88W9ms1p6fIs0VIKAoPet7WSD3JdXYY=;
	h=From:To:Cc:Subject:Date:From;
	b=rPgOx3jtlBkq4LCBpLrjAJSaSRO7s2Q1JWuKk4I3t2mDeDODd12RpKuwGHO0e+qdX
	 Zeq+FALXAf7CbkpArY0Hg+IQsgSX2gFWC3bQqmDLj0YpWXb3qUn9w1wbpxMOk/HvdN
	 fLmOYWPyEO9M7fLDbG3sQr1Z0d2ohD+Q/9LMRY80=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4g9mWy6nlBz9shx;
	Wed,  6 May 2026 20:02:54 +0000 (UTC)
X-Riseup-User-ID: CCE37216CA06750F7617076F546FDAFBDF4B17FA4091129CBB3034E01BC13F24
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4g9mWx0SxXz1y6Y;
	Wed,  6 May 2026 20:02:52 +0000 (UTC)
From: =?UTF-8?q?Santiago=20Ruano=20Rinc=C3=B3n?= <santiagorr@riseup.net>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	kfarnung@outlook.com,
	koike@igalia.com
Subject: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
Date: Wed,  6 May 2026 16:54:46 -0300
Message-ID: <20260506200249.317690-1-santiagorr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D29F4E0146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[squebb.ca,outlook.com,igalia.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36040-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[riseup.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
table") added some Lenovo platform IDs to the quirk table to address a
wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, as
reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
table.  This commit adds the two corresponding Lenovo version IDs for
each.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23

Tested-on: P14s G3 AMD running 7.0.3.

Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
Co-authored-by: Kyle Farnung <kfarnung@gmail.com>
Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
---
Changes in v2:
- Merged the Lenovo P14s G5 AMD #1 and #2 related changes proposed by
  Kyle Farnung in
  https://lore.kernel.org/all/20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com/
- Added Kyle Farnung as Co-author of the commit
- Added the second ID of Lenovo P14s G3 AMD, and adapt the comments
  accordingly
- v1: https://lore.kernel.org/ath11k/20260423211458.458911-1-santiagorr@riseup.net/
---
 drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee..c1ce0a11af44 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -957,6 +957,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G3 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G3 AMD #2 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
+		},
+	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
 		.matches = { /* P14s G4 AMD #1 */
@@ -971,6 +985,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #2 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
+		},
+	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
 		.matches = { /* T16 G2 AMD #1 */
-- 
2.53.0


