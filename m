Return-Path: <linux-wireless+bounces-38870-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iOaEKjs+UmpWNgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38870-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 14:59:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56B74198B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 14:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tutamail.com header.s=s1 header.b=et9UftJR;
	dmarc=pass (policy=quarantine) header.from=tutamail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38870-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38870-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17C2130434CF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4763C943F;
	Sat, 11 Jul 2026 12:58:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B3C8184
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 12:58:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774696; cv=none; b=EIAQT5HNtIzYhKBaB1CTxy9ETQSn+isyt3a6U3B+H9WqcAslTrPZ2amjE9SerJ8gsc+vPcawntXtGYAr9Eo89RMLgUBKckCFkioM0EbhbuH2KKq3SDiGzDfd5fKveP9Q8HynFunfUiBylX5yaeeSy1Lo/jK4LoadXtMX/7gY5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774696; c=relaxed/simple;
	bh=KU/xc53FV2LLSnw7qwMFhqFxpL+8249vIfym/hEw4iQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NKytGdulvD0JWlBDC1UJt7EPvGsx5jz1981S7BROjHshJCKiyU2OoXVIJx7TSwSsnfluupIiaq8RIcamNRILPxIW8dBqWnv59SWCdkzAhJOigDQ5ckTu4pYrIXm7PvBfreOBm7AxyBLyKlibeDoU+2/FEU1+Hd/521spTFb2JjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=et9UftJR; arc=none smtp.client-ip=185.205.69.213
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 35B3115C87DF8
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 14:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783774687;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=KU/xc53FV2LLSnw7qwMFhqFxpL+8249vIfym/hEw4iQ=;
	b=et9UftJRkVFYZ7KQlpVZDKs5A4fkqSHRdQ1h0A2kGwgFkV4Q3/dzxsvDvhcmRRIW
	7Xn6hW15pz5oAsqnDW5y0nJV8ak0ML85cRqhWZ+yN/2jBDuLg/W2RZTSlHEB3vl5gHR
	JyZl9wTZCwaDRmlPe29cy0wncIjUDhlyLFQhjUMIUPHXG0P6k+XYbw4VfbPLCDfzHij
	WZDTQ1O8YA6vzA8FNz/0PGaTDAS7YGtltsqieLY4q1mjveZc+0mNVPkMHHpQfNEFQZ6
	gLsYXTMYyGPUTSxBUI54DETYrXAtEueqvU+5HO0KL4xNU7cn8WjtvsgmxW3SMbnF2/u
	l0gkhj2VeQ==
Date: Sat, 11 Jul 2026 14:58:07 +0200 (CEST)
From: cybersnow_2001@tutamail.com
To: John Scott <jscott@posteo.net>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OxGFM45--F-9@tutamail.com>
In-Reply-To: <OwscydZ--F-9@tutamail.com>
References: <OwQQjLm--J-9@tutamail.com> <c2163c6ee67e982fd95d1f965ecf0b853f687214.camel@posteo.net> <OwscydZ--F-9@tutamail.com>
Subject: Re: Atheros AR9280 / AR7010 Initial low scaning signal range
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jscott@posteo.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38870-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tutamail.com:from_mime,tutamail.com:dkim,tutamail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C56B74198B

After doing more test, I re-confirm that the signal link quality and the signal level goes up by 200% after it connects to a 5Ghz network. I see the link quality "double" from 30% to more than 70%. The signal level goes from -85db to -67db. When it connects first to a 2.4Ghz, it seems to be blocked at a low level, until it switch to 5Ghz, then the signal goes up suddenly after 1 minute... strange behavior.

