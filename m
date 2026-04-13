Return-Path: <linux-wireless+bounces-34716-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJRFDqeG3WnvfAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34716-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:13:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB53F45EC
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 02:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B87D73005A8F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C963770B;
	Tue, 14 Apr 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="PumOAm6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2E33E7
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125602; cv=none; b=h2/yS8Vq0EDPb/NeHDynXfEAM7yCHHcE/m5NNjlAHCBzsRdbyzqsnnFQj4y7y32R6vXaFF1/3AoA4BmtWZf7OgayLKBOARIYTCmReAVzt8+wh8EJ+LZJiIi5BJ63cW9+rKcWAP1NR1Om4d/H04N3nU4s1K04cFvHnYRJVgX026Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125602; c=relaxed/simple;
	bh=jL9WLZFDk2hi9oFYTtBZIRNy5tdekSoo1/lRAL9IAqs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=fvGs61ZaDeAp2SVOnlUV/Ddq5XIZDfBfsSpo0mtqyo/INSsbnuj5TaogQKWWLjmlT4Al63F+RESz2+x+xV0sDYJW4zCaze5Z8iMuXhvjY3Bw0uHKeelfTY4Cl3kow85txgrIHq/pXR5kUWyU/UHpIplwN+v4ESPfeJ3K3LkDJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=PumOAm6q; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com; h=To:
 From: Subject: Message-Id: Date: Content-Type: Content-Transfer-Encoding:
 Mime-Version; q=dns/txt; s=fe-953a8a3ca9; t=1776125599;
 bh=jL9WLZFDk2hi9oFYTtBZIRNy5tdekSoo1/lRAL9IAqs=;
 b=PumOAm6quTaoWwGfG7kWLrUOYuLZLe9mVCkos79sdCVmchBpDZtWc+MFQnATd2DO5kLEOQL9t
 Myg91cVATcYewi9jcqajLpods23ZaqcdJDXTiJfUiNltJBeDRktk2LI+H/AMr1DOWqhxZ3gcTmQ
 1IppyKmhWsbjjzJSlJmlQmTSZyJofHhRlug1rgc6kJqpwsjZiIrGLxmDmfCfhl6yRRWGQCwzaTU
 sHgacL7A2OQRSeqWT2h3NCIkxEw+4DTEn1LVC7Itwfml0gOD5TFuOmXtpajRCU2zEOP7QbcmH1g
 ldXB8YINeXO1Mslek+gczxCY/W3EnXmG52gtkYjcFJmQ==
X-Forward-Email-ID: 69dce51911ae2e8efa0d45ca
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 13 Apr 2026 08:44:07 -0400
Message-Id: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com>
Subject: Firmware for reverse engineering b43?
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: <b43-dev@lists.infradead.org>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ubuntu.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ubuntu.com:s=fe-953a8a3ca9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-34716-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ubuntu.com:dkim,ubuntu.com:mid]
X-Rspamd-Queue-Id: CBBB53F45EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

As I've been getting into kernel development, I found the b43 driver
as a suitable place for me to work in, given its status as orphan and
my access to it having an old iMac.

When it comes to figuring out what code to write and how to implement
functions, I see that there has been a mix of answers across the driver.

Lots of functions refer to specs RE'd from the 4.x firmware[1], but
my own install uses 5.x firmware. Additionally, the 6.x firmware is
available.

For my reverse engineering process, I opened the firmware in Ghidra
and basically try to map the functionality to the driver, which appears
to be what was done with the 4.x specs?

But, as I compare to the newer firmware, some functions have been moved
or replaced. And sometimes, the newer firmware functions contradict the
RE'd 4.x specs, or have extra steps in its process.

Take b43_nphy_perical, or as known in the v4 firmware,
wlc_phy_perical_nphy. I got to this function because wlc_nphy_init calls
it. But actually, the RE'd version says init calls
wlc_phy_perical_nphy_run, which the firmware says is not the case
(it goes through wlc_phy_perical_nphy first, which has its own
conditions).

So, which is the best source of truth(s) for this driver? The v4.x
specs, the v5 firmware, or the v6 firmware? Which one should be used,
and which has a higher priority level over the other?

Keep in mind the v4 specs came before the release of Ghidra; now that
it exists, we can refer to it instead of manually probing functionality.
I've even seen Ghidra show different instructions than the 4.x spec.

Thanks,
-Josh

[1]: https://bcm-v4.sipsolutions.net

