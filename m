Return-Path: <linux-wireless+bounces-37447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDIvBhKkI2qWwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 06:37:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6475464C5EC
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 06:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ekze.org header.s=purelymail2 header.b=sl3F+bSZ;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=hvLA5FyI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37447-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37447-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ekze.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DD2B302C7AF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 04:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B5223DFF;
	Sat,  6 Jun 2026 04:37:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DD1D9663
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 04:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780720652; cv=none; b=rW4JohfTjLDgs/oUe9k5yQ+vGhh6aHggIF+H7915yX51eaLMtiFalCmyDYhVHjwq7G48kQ+D0U4qYx1lvFX6RHHVZqKZc6PYc2ttQD6uApiPRvMBs7cuTN6+xG7Q+BNxLSeOG6TUegYuV9iGjqyqHfAvh9Iv4stG2T4NfnTenuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780720652; c=relaxed/simple;
	bh=ZZ7/N3EErjlHBqvD7NERSpKnh/m8zxvPSGhZHmTqH64=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LObmWKYgwl3Qwdi0XI06zd2SC6MJFECHsBr+57xd8Lm9vbpRdeMz6hKQ72I/Rx/avgu92b5pqULkczBLki6lr9K0TQznOdUAJgvWJ3u1X6tSdHHqV9fG4Cv+dJKWeQr+7OLjmP3wcVnEqXUQ1kt52vJEnh1nlSV3CS6hTUDEIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ekze.org; spf=pass smtp.mailfrom=ekze.org; dkim=pass (2048-bit key) header.d=ekze.org header.i=@ekze.org header.b=sl3F+bSZ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hvLA5FyI; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=sl3F+bSZE2V7IpuK++mGELg2TlYIlXw2Ax/VYCLTR4ICVkZvoH5RhYvjTbTHNKbGarGnpbS8qpx675+YvNPxyi57OVJIC7yHIWo4p5czdZd/e3TC2PpVtUqLpdjRaQXvvwbJ24He1V5d3kHTxyCISKQa9jrD3cclJVX0rcyLruRpCeZCdXvlD4yS4eTrQ8TomiiKVuCbGjw+t2pRNI3NCwdkO8H2b5+knGVXCfoFiTA4PLcLbIit0mjxQJHp8Sn+USzJ3nrg6SJmgxRMUWuAGYmNUa4eJoEBkUSJrKDUBo+i+zDBFZoeqQGSK17ic4oNtvtf+xU7e1B3CWBi6V2S+A==; s=purelymail2; d=ekze.org; v=1; bh=ZZ7/N3EErjlHBqvD7NERSpKnh/m8zxvPSGhZHmTqH64=; h=Received:Date:To:From:Subject;
DKIM-Signature: a=rsa-sha256; b=hvLA5FyIbwEqd+JJ6Nj3SgCTj8TGQLetfidRyMNL0H3QkYemlWv+yAiyd/WYJxmZQi6M2RXS8E7RuTdVRsC6bMG5XdnpHAbAnlqG51M/BfYM/JlaNEIJNOCFYnonFvX8E1KWyfdFB3QuFr52st0SVGwRJUr0MMtxSVoggSBjNOpYT15w5IFh2c/mRK6yeQI1KXXM/Q+WxMoV+cLkRNkL7DGVzHkoefeHNr033480/pJPfggI/fBXdBEXnvOXAnqnBQBtJGFje8Q1WprQc7nomKOcfTh8mr0V+3/cVBICNyy/5i/aHuo2p7zxdIqwGgoRycuDIdiN1jHAetXa7G1Q2g==; s=purelymail2; d=purelymail.com; v=1; bh=ZZ7/N3EErjlHBqvD7NERSpKnh/m8zxvPSGhZHmTqH64=; h=Feedback-ID:Received:Date:To:From:Subject;
Feedback-ID: 815493:39682:null:purelymail
X-Pm-Original-To: linux-wireless@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -180570768
          for <linux-wireless@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 06 Jun 2026 04:37:29 +0000 (UTC)
Message-ID: <cd0a8084-9ce9-4715-8a39-d97e0f7c754e@ekze.org>
Date: Sat, 6 Jun 2026 08:37:27 +0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: ekze <nya@ekze.org>
Subject: wireless-regdb: Missing 5470-5725 MHz WAS/RLAN band for Georgia (GE)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ekze.org,reject];
	R_DKIM_ALLOW(-0.20)[ekze.org:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37447-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[nya@ekze.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[ekze.org:+,purelymail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nya@ekze.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ekze.org:mid,ekze.org:from_mime,ekze.org:dkim,comcom.ge:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6475464C5EC

Hello,

I noticed that the current wireless-regdb entry for Georgia (GE) does not
include the 5470-5725 MHz WAS/RLAN band.

According to the Georgian Communications Commission frequency plan, Georgia
allows WAS/RLAN operation in 5470-5725 MHz with 1 W averaged EIRP, subject
to mitigation requirements based on EN 301 893, including DFS/TPC
requirements. The document also notes that if TPC is not used, the EIRP
limits should be reduced by 3 dB.

Official source:

Georgian Communications Commission, National Frequency Plan / Frequency
Allocation Table:
https://comcom.ge/uploads/other/14/14075.pdf

Relevant entries in the document:

- 5150-5350 MHz: WAS/RLAN, 200 mW averaged EIRP, indoor only
- 5470-5725 MHz: WAS/RLAN, 1 W averaged EIRP
- 5945-6425 MHz: RLAN, 200 mW averaged EIRP

The notes for 5250-5350 MHz and 5470-5725 MHz reference EN 301 893
mitigation requirements and TPC, with a 3 dB EIRP reduction if TPC is not
used.

Would the following update for GE be appropriate?

diff --git a/db.txt b/db.txt
--- a/db.txt
+++ b/db.txt
@@
 =C2=A0country GE: DFS-ETSI
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (2402 - 2482 @ 40), (20)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (5170 - 5250 @ 80), (18), AUTO-BW
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (5250 - 5330 @ 80), (18), DFS, AUTO-BW
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(5470 - 5725 @ 160), (27), DFS
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (5945 - 6425 @ 320), (23), NO-OUTDOOR
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (57000 - 66000 @ 2160), (40)

I used 27 dBm here because the official document lists 1 W EIRP with TPC,
and says that the limit should be reduced by 3 dB if TPC is not used.
Please let me know if a different representation would be preferred.

Thanks,
ekze


