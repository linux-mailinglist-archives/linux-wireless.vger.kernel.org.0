Return-Path: <linux-wireless+bounces-37499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +uOUKZaTJmruYwIAu9opvQ
	(envelope-from <linux-wireless+bounces-37499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:04:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6E654D56
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="Sc50sQ f";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37499-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37499-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84853307835A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FB3BD62E;
	Mon,  8 Jun 2026 09:55:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81C3B83EE;
	Mon,  8 Jun 2026 09:55:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=Xq9OSNON6nXdzhyWSj7DJKA+PSBqJuYbkiR1LHZwyrfB/WcZbtoODwCuElZOASezGFd/+CwyV11yQ31VH3kPW94DQ807w7CalVhBFNWqS9POFMg0ebFlApjmQy5Id731HldABOtXyTj/2Mn7dMiI7v3NNvk0eFY+NaHFC8NOdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=1adYdBswyTfJyxkVS47yXOR9EW2XKEdW3V3CnEHrmfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jk46vKcOXqUIX62v9k3jrYiDe8tVbQyx+AnwYk2Vr2An+w2Za28GzR3BmznuRsvMuIhaXqFndkg/c3ui3bCKl+exOe3MmfIdfbj7l+ksbu4c2qyljhtaCLicwc15bgzHfPosHT1ufNbYhFWl9dTexhOFuEpEysT/XUA1gKcJK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Sc50sQfl; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-00BRyL-U0; Mon, 08 Jun 2026 11:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=kwUAKZVIljGeQ14hKwZcWqCUMIz4UFBg8Q5CAZLBU/k=; b=Sc50sQ
	flaYzXaLKCSPlS7iRXdYE2kb2Y4VGlRespRIib2wDXi2jQkw3z5GE6QXaygTILNuNUSRFmlbg9mrP
	CWqrHPlbn0SsCS1FQl/621wo9mNNmZIjzgyKQf/rRnyM1cj8alBg9OmpJTJocXu2T9qyZ+6X52CKP
	vUA6xaG7FcWCR1QfjkBr1B2I3BdF4cRQ3PEiI32k1+0JMYFHibGFuVbvno2hUdO3cJ4NcHlKIwQhA
	rZincjgrXhLZeIWpVto3+3VzlPIfhxya9t7YV55WgJ6v2f9M9jnv8lVRdIaNVsKV6cpvOgTr8pZ2p
	tNlydp4a0E6FCG4j8dpNvaLbh8LA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-0003eS-6S; Mon, 08 Jun 2026 11:55:41 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWha-00Ag6G-Ju;
	Mon, 08 Jun 2026 11:55:26 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/wireless/marvell/mwifiex/sdio: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:47 +0100
Message-Id: <20260608095523.2606-3-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37499-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,gmail.com];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:arnd@kernel.org,m:briannorris@chromium.org,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02D6E654D56

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

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

 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f039d6f19183..d269bc4fdce2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2512,7 +2512,7 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		if ((val & card->reg->host_strap_mask) == card->reg->host_strap_value)
 			firmware = card->firmware_sdiouart;
 	}
-	strcpy(adapter->fw_name, firmware);
+	strscpy(adapter->fw_name, firmware);
 
 	if (card->fw_dump_enh) {
 		adapter->mem_type_mapping_tbl = generic_mem_type_map;
-- 
2.39.5


