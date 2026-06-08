Return-Path: <linux-wireless+bounces-37500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ZyNHeKUJmpIZAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:09:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E56654DFD
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="nMHUWN w";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37500-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37500-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9FDE30CBBAF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B83D8903;
	Mon,  8 Jun 2026 09:56:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93833D3CF2;
	Mon,  8 Jun 2026 09:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912561; cv=none; b=SAER4fl7sRPdowfVeuQPhY4HNA+n56XM9XJoX1Juqq3JTF0OuUqspNTPORIpJ3mTORYhH2E27M4DkRzAAiabnm5STdchQkc1jo8eKHH9HTEzFlBs8ep93JBLxGntm4RZakCKvSSXn9fPM+EgeydKZL6LsX3EMqhfep0/Jc1XXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912561; c=relaxed/simple;
	bh=c3lGNyP1bLtWX1BDvu7Fgmt6+lElIKWYxuUNS5rFbjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NVED0nEViU16ys4z8+Xt7zgeEXNfDrbKDejCeUqT7wPfFHy7zCNbkFhfhZIaor1cLEGjloH4r116rEnQx4kH2EIlHQMlrPLgddAa0AWYYefEs9Jf++oGn1927EqSRhILYxWiDlXfkQIs3FXqXBRFYCqgiyCDLNgG2kxVmyrzNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=nMHUWNwd; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-00BS6s-UI; Mon, 08 Jun 2026 11:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=e80/0YVKthCQIrwUaTRWz+WPnntfuM+L1eNTR9xj0gc=; b=nMHUWN
	wdfAhkiW2ndjrxrseKK1YF8Z8u49YjJQe5TYX4vEnt7XL7rzeyzyPb+CmGyHIZaTHo+nrOY8ExYbQ
	bdqr/WDHxphM7NomOK40tTB3Gwmze+iGXCYgzfsHpwXUfTnj+mDLqZRxCvEFltPD1k6SPgywq73tI
	44jdUTDS0G3jxki7+sYtRIEh+Z6XO/0xq5Hmx10JrbZZPyqrtW/ueMfTP6b0MaZ9ABTshqeqoFavV
	n+tco5MlOFbusH40Ma4YzloE3eja7w4aZh58GJAlrfQZ7vJzl435zTfVfjI9vJHup615Y2ML4psAm
	9iTd2zB0jsevFHeArc5joEqhaEHA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-0003iq-7O; Mon, 08 Jun 2026 11:55:56 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhl-00Ag6G-V3;
	Mon, 08 Jun 2026 11:55:38 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/wireless/intel/iwlwifi/iwl-trans: Replace kzalloc(... strlen()...) with kzalloc_flex()
Date: Mon,  8 Jun 2026 10:55:15 +0100
Message-Id: <20260608095523.2606-31-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37500-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:arnd@kernel.org,m:miriam.rachel.korenblit@intel.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,runbox.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4E56654DFD

From: David Laight <david.laight.linux@gmail.com>

Save the result of the strlen() and use memcpy() instead of strcpy() to
copy the string.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 16b2c313e72b..f8e6209a4b45 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -33,6 +33,7 @@ iwl_trans_get_restart_data(struct device *dev)
 {
 	struct iwl_trans_dev_restart_data *tmp, *data = NULL;
 	const char *name = dev_name(dev);
+	size_t name_len;
 
 	spin_lock(&restart_data_lock);
 	list_for_each_entry(tmp, &restart_data_list, list) {
@@ -46,11 +47,12 @@ iwl_trans_get_restart_data(struct device *dev)
 	if (data)
 		return data;
 
-	data = kzalloc_flex(*data, name, strlen(name) + 1, GFP_ATOMIC);
+	name_len = strlen(name) + 1;
+	data = kzalloc_flex(*data, name, name_len, GFP_ATOMIC);
 	if (!data)
 		return NULL;
 
-	strcpy(data->name, name);
+	memcpy(data->name, name, name_len);
 	spin_lock(&restart_data_lock);
 	list_add_tail(&data->list, &restart_data_list);
 	spin_unlock(&restart_data_lock);
-- 
2.39.5


