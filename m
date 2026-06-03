Return-Path: <linux-wireless+bounces-37346-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gAQ+BXsaIGqTvwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37346-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:13:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90975637608
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:13:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37346-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37346-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C54F31EFE09
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6F46AF12;
	Wed,  3 Jun 2026 12:00:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D16368D51
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 12:00:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488024; cv=none; b=sSVfXNDWaSWA1Z/IDJz/4J4lBwEvMJeL9K/IUI6Q8KNjC1A3vlah3Pxw1bp923QfkHFxNGfP7e9muy5AEmxcvSdoGo1td9RQgwfx3HuYi53LtigaXblbVBKrLdW8aoKf106DoK7vlDhZsIlFzKrA1aL3e2fu9jIJd73sXFtIBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488024; c=relaxed/simple;
	bh=9q183NFC9fS2JbtBL36Ugl1YrAbf8Ci2YCyn/eMtdUU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=fpvrv2ZGF+CoUvs+Me/C+5ROymOhesp0wh+cPynk/R9YlZ4pIDr360G/lVOm4utJKhmGj9icyDTDZxyuaDW2G/ht/qp1hc3yHJv58dRS11hCEMLi99YS/zzLh13JhoOqjEuAD4Yf2Rx13bEUk2YUfGFiB4VPUEmi901DEJhplnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com; spf=pass smtp.mailfrom=ciaorelated.com; arc=none smtp.client-ip=81.19.149.127
Received: from 89-26-47-193.stat.cablelink.at ([89.26.47.193] helo=[127.0.0.1])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <info@ciaorelated.com>)
	id 1wUkGi-000000006e3-0l2M
	for linux-wireless@vger.kernel.org;
	Wed, 03 Jun 2026 14:00:20 +0200
From: Dogan Karaarslan <info@ciaorelated.com>
To: linux-wireless@vger.kernel.org
Subject: Open source social media project from Salzburg
Message-ID: <b6949391-f359-fcfb-e7cf-61564fb628c4@ciaorelated.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 12:00:19 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-AV-Do-Run: Yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37346-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[ciaorelated.com];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[info@ciaorelated.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@ciaorelated.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ciaorelated.com:from_mime,ciaorelated.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90975637608

Hello,

I found your contact through GitHub.

I=E2=80=99m a developer based=
 in Salzburg, and I=E2=80=99ve created an open source social media project =
focused on communities and meaningful connections.

I=E2=80=99d love to share it with you. If you like the idea of an open =
source social media project, I would really appreciate it if you could take=
 a look and maybe star the repository.

I=E2=80=99ve put a lot of heart =
into this project, so any kind of support, feedback, contribution, or =
simply sharing it would mean a lot to me.

Here is the project:
https://github.com/dogankaraarslan1/ciaorelated

Thank you for your time.

Best regards,
Dogan Karaarslan

