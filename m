Return-Path: <linux-wireless+bounces-35130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M16Esda52l87AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:08:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDB439ED4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA8BF300B190
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022163BD654;
	Tue, 21 Apr 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tK0UNuSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE253BD62A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769731; cv=none; b=YgwTPZUn9RmSYVSrufgJlJbtscPw+NZ6XXAcGwpGTW0FxWD1gL41OWH2uOacWg1LmdnrIiQAuFzxhSTXdrF0uJ17rAiKe5PxCJLodfXUHzukofzQk4W2aMjwWRbjaquOP7IpZgiBqj633trKrzf5CtQhIWCWMXe+4WAaxW/bcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769731; c=relaxed/simple;
	bh=W8jRFpBUaQuQW6ou3LHF++dWPa3sR54jkS5sxP4hDp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9/fr/hw+pvT/nNMJXX/1ZFJRAHu2eovQyRf8wQT+BlIyj8ldTO5WWcdwoRADrMF+qn4qo0jp5Eo9YKmkCvvhNzmPKyLVC4AUYFa5OGS1Ecjox4GE0+dRaarttgVMm7XiHM5uRtDlwHq1a3G0iyka+901E7SVGUb6auGm/PZgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tK0UNuSF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W8jRFpBUaQuQW6ou3LHF++dWPa3sR54jkS5sxP4hDp8=;
	t=1776769730; x=1777979330; b=tK0UNuSFv/Q5SAWIZiy7dPwnd1H78EWNZPjM2KScp8oQeCJ
	497PndDh1aaHRoB6QwypviSFQdsmgVewTYsKOxNsX3oREmE/7cFfYlbv9AfUyctmh/0GJhuS1WW7J
	KLnv3udY0ZIJaDy/R1qcfpZ0hSmkTGLMdZVvWR18ac8nRfP3I8VpGfUXlXBuYuWdim5LlO2lfO4e4
	n6bi7pPBoypPTB8Qxl7VuMEyvuos3eYvNVIY8mhHzoWdDip/GluoWwNB2TmF70tthBX6yAwW7WUSX
	yunhua/x2YzCBrw5Vjxu1tixMRQtsHIcCOsAvRwg8xfkbOBuw2jUbZLAPUlEHmXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wF8yF-00000004xH0-3057;
	Tue, 21 Apr 2026 13:08:47 +0200
Message-ID: <152dc405d288d6a8cb3cb695362e00b6319102e3.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in
 link lookup
From: Johannes Berg <johannes@sipsolutions.net>
To: Tristan Madani <tristmd@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Date: Tue, 21 Apr 2026 13:08:45 +0200
In-Reply-To: <5160c46cda019dee1a01406fbd13cc0b9b02b3e2.camel@sipsolutions.net>
References: <20260421110133.2957818-1-tristmd@gmail.com>
		 (sfid-20260421_130137_392604_8BC916E6) <5160c46cda019dee1a01406fbd13cc0b9b02b3e2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35130-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: D1FDB439ED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 13:05 +0200, Johannes Berg wrote:
>=20
> Please stop sending patches until you've figured out how to generate
> patches that can actually (and reproducibly) be *applied*.

FWIW, I've just dropped *all* of your wireless related patches except
three that provably worked, you can see it here:


https://patchwork.kernel.org/project/linux-wireless/list/?submitter=3D22141=
1&state=3D*

Feel free to resend after you figure out how your sending email path has
(not even subtly) corrupted most of your patches.

johannes

