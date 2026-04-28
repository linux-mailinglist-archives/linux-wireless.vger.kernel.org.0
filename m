Return-Path: <linux-wireless+bounces-35481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHAnFE6I8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:13:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F34825D3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 203F0309B1CC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ADA3A7581;
	Tue, 28 Apr 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="gzjK+8xV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473434D929
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368712; cv=none; b=NnCYUuYXwqUYCHQjM2C/Cxdcsrb5lz+Ngz/ezuTXloDCVeFsdpCrlhM65GGZ3LNBLXEIjICB/g5aT+ibuqKdvCwGyTy1NLJL5u09AIwsWmDdvUIp440cDhWE6oHzfVoL8+XSH8Ad+MGCHVNxXShuY/ldsUB5DgtkZaaRsFjwsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368712; c=relaxed/simple;
	bh=89u0Nra6HcCxiHVgf4hs8s+ke9wMHVAsbmNUydTt9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmfemwCvw+dFavVG23vjBHf22b4wOMps48o4nT2mDKD64FJJr/owPDxF5QXm6xlkU2JqpvMpQVcN5WphWpKEP9bPzJQdJOwPhhtjUPcKHDPdAYSwXHSDplIrDghjSbrowQQkaS7va+h3oj/oA7+aNUVSzra64dd+9VZgV8gGmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=gzjK+8xV; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id BD1DBC00CD;
	Tue, 28 Apr 2026 12:31:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id QVVcnN0Q9uQ0-UGZNg7xp;
	Tue, 28 Apr 2026 12:31:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1777368696; bh=QanN1hvymPQkfK3pxfbCHGaN5t55yhRf2F2DTrO0/LA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gzjK+8xVMeZy8EWm1TVOI4sgG1FUDod6bB4Nn6zqLu1Hx4XspfuPMQq9yZp7Bp77O
	 AU0iuVe1+KQXdc82+12mLUr1TEXe60/Vi6Xp9haTqOE4iZT3MD80HOEF2VzuCsxrvf
	 IWg1Bcq6Jyz3bHt0Hz2mhh0hHJr/2b6DRLD7nvsM=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@0upti.me
From: K900 <me@0upti.me>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	K900 <me@0upti.me>,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH v2] wireless-regdb: allow 320MHz channel width for Russia
Date: Tue, 28 Apr 2026 12:30:53 +0300
Message-ID: <20260428093058.3672383-1-me@0upti.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C41F34825D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0upti.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0upti.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,0upti.me,gmail.com];
	TAGGED_FROM(0.00)[bounces-35481-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@0upti.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[0upti.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0upti.me:email,0upti.me:dkim,0upti.me:mid]

The entry was added before 11be (and thus 320MHz) was a thing,
and there is no actual legal restriction on channel width, so
update it to allow 320MHz channels.

Signed-off-by: K900 <me@0upti.me>
Reviewed-by: Louis Kotze <loukot@gmail.com>

---

Rebased from v1: https://lore.kernel.org/wireless-regdb/20250708-russia-320-v1-1-53641e8dd417@0upti.me/T/#u
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index c310b7f..de53874 100644
--- a/db.txt
+++ b/db.txt
@@ -1772,7 +1772,7 @@ country RU:
 	(2400 - 2483.5 @ 40), (100mW)
 	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR
 	(5650 - 5850 @ 160), (200 mW), NO-OUTDOOR
-	(5925 - 6425 @ 160), (200 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
-- 
2.53.0


