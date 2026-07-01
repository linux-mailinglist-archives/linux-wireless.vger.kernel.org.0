Return-Path: <linux-wireless+bounces-38426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgNFAMh2RGq6vAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 04:09:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE56E92D9
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 04:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tutamail.com header.s=s1 header.b=X2SB0SHK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38426-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38426-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=tutamail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE384301ACA3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBD38DD3;
	Wed,  1 Jul 2026 02:08:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2453624B3
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 02:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871703; cv=none; b=WgowHfYSqPtoVyKIqGoeG4T1lL3RL//N6OhHeR+cntraFyerBO6UE+fTGqp2AheHwR1Yy7119wv6yYw13DyL36X2D4upAID7jUKeuddTEOmcAdW+t/ZZ0pHo2MMTVtJFNdbtJw5fUPpOTt8OcR+0HIGLmGMz43iVvFrl6mhl3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871703; c=relaxed/simple;
	bh=vSJyvEdXX7YWc2I+4Zheq8MA175X0IiSEBY5hGNUa38=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=mUlx9tZQz8dLdHm8CnmVj2bQNzjcmxdbMh6c0ue8TtmV5ilOxYUbXLry/6ul/S38LWDIhcNrNZrJDZE0R7zw34mbmJl4ZjJeQkGdFyGrOefy+4J9c6K5llWoApJBAwk7XEmhaHAe6pjjyu696CkyrmREeCABsWSIk0LvRwvLMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=X2SB0SHK; arc=none smtp.client-ip=185.205.69.213
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id A0799156C130A
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 04:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782871700;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=vSJyvEdXX7YWc2I+4Zheq8MA175X0IiSEBY5hGNUa38=;
	b=X2SB0SHKn25CBDtfy5/owkmkzC9ghNscOTUoFRAhhQ94XzuQhsbBedRY3QhYw2pa
	tHQHJBjAMYC1WQPcP9PeIYqRPm6yXiHbn+Dh/IM9xC7maFJjrLs5WDDUjMKoSK+KiwQ
	tNcX76sF7ocQ5Nagb2crXDEb2s+BaUa3j16MmfCww0gHp5pouIu0bxU8niZ9R4U+1UC
	3g1Y1bpgp6Rgt+MzVHmgcAlosHXYWY0SbW76Iv0FzEsMjTBhijUluNRsZMuHaK8TiDZ
	CLxxW3oAGw6P9kPASB86KIL6Diw8G1uuD2ShuTZUWnxsTvJaf7bMJdypmIFIjyI9R5h
	asT+FB5/pA==
Date: Wed, 1 Jul 2026 04:08:20 +0200 (CEST)
From: cybersnow_2001@tutamail.com
To: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OwQQjLm--J-9@tutamail.com>
Subject: Atheros AR9280 / AR7010 Initial low scaning signal range
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0148cefbf77245a42b8d92790169c2e5f3889e2ac922109814e9377b88997be23fd058959082c4e525ef1b19740c34b7ef4478cd506e389835ad86d84f5ca78a4f:TurnOnPrivacy!:tutamail
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tutamail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tutamail.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38426-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cybersnow_2001@tutamail.com,linux-wireless@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[cybersnow_2001@tutamail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[tutamail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,tutamail.com:dkim,tutamail.com:mid,tutamail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07DE56E92D9

I'm using an Atheros AR9280 USB dongle (Panasonic UB94) under linux. I think a few years ago, it wasn't doing this behavior but now, I think it's starting to be a serious issue. When I plug the USB Wifi key, I can only see a few Access points but not all. Even near the main AP, the signal is seen as very low (1 bar out of 5). Sometimes, I cannot even see it. When trying to connect to it, it connects hardly. But after a few minutes, the signal becomes strong and all the neighborhood AP are shown. When the AP advertise the right TXPower, it seems to fix all the issues. The others AP appear and the signal become stronger on the actual connection. I see the signal jumping from 30% to 70% and the RX Rate jump too.

I suspect the ath9k_htc module is not enforcing a high enough TX Power at first glance or something else happening I don't understand with this chipset... The country code is set at 00 at first USB connection. But until I connect to an AP, the AR9280 stays at a low power state and on this country ID 00. Also, it's like the 5Ghz network scanning isn't activated. I don't know...

I've read in another forum that people experienced the same issue after a kernel update, maybe after 6.8. What do you think?

