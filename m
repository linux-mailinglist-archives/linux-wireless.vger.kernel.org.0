Return-Path: <linux-wireless+bounces-33347-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNL3MmY3uWnVvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33347-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:13:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB62A88F0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A2D6300C7EC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2634F486;
	Tue, 17 Mar 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j/A0og7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74781371CF2
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745985; cv=none; b=e22oSg+1MSV+SFL0ICYnW6S0kR8Yc8s4An+6J7cnD3CQRMFTx76HbLzDvK2FwJUWLjeYXfnXzx0oSPW+EeYb/qnz1xcppAiHBvILeEg7b29ihXNSSK25MMKnY346F/co55UUwOeXWXqJO4cAG10q2Yn5y5ecMSjQNaX5lOFGbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745985; c=relaxed/simple;
	bh=hRedNgl1KKhzzXq2myT78vzMd/AhdkWrW2cUDx+D98I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D50pUwQA/UwVeZe6EKr3ABJ7IIarDTLkowR5QTMQJjCxWFxsqminUR5aO22h2pUpaqAzbj0vgi55++fhrTFY6hZ30bD/4dquEGR9/VsapxrbAtFt9Np0oyI31IytT9Mqoifq+9VDC1/fxWy9IUHOVrLHNxMZNGVXomlM1AXj9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j/A0og7E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0QdBqsEjf2sOpnX3xwGjARphjEs2NJRM3lce1KpcN+4=;
	t=1773745984; x=1774955584; b=j/A0og7EMvG5yzBKaaDH8lD1uy417Ydb+qqjeJ9+bwk+TQ+
	qmrcA2VINg4v86m0xQm6FaYU0Eu10YMb05El5gJF1Eyt8TLONBiMARTZdPO/jRmbX+I/o5CFHlXD9
	x6C6d3tyThLXS08+ZFJC/hschrP1IhwFjIPDtQ+TjXmebPTQjQnbvznw0XX/7gh8QEDyQPUlRckf0
	X/Gh6oYH0ufY8fSkYRzeMQvMloZugbVet9p/Lyn9NBbsnqyeYGl6TsSfLvMqzsTFibm3XVc/z+vIK
	1EV6CWnjSDcl/EIh/FoHqUdxbiYPUdFKMXQAzIuuAVtp4IkCa9WF/s2r97H7lN3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w2SM4-00000003Evv-3X2U;
	Tue, 17 Mar 2026 12:12:57 +0100
Message-ID: <14dbba2a612dbff4058ac36b6a581f66e4ad6b7d.camel@sipsolutions.net>
Subject: Re: [PATCH 13/16] carl9170: rx: gate data frame delivery on STARTED
 state
From: Johannes Berg <johannes@sipsolutions.net>
To: Masi Osmani <mas-i@hotmail.de>, Christian Lamparter
	 <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 17 Mar 2026 12:12:56 +0100
In-Reply-To: <AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
References: 
	<AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33347-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: EEAB62A88F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-17 at 12:06 +0100, Masi Osmani wrote:
> Do not deliver data frames to mac80211 unless the device is fully
> started.  After carl9170_op_stop() the driver state drops to IDLE,
> but the USB RX path can still receive frames from the hardware.
> Without this gate, ieee80211_rx() may reference station data that
> sta_info_destroy_part2() is concurrently freeing during interface
> teardown, causing a use-after-free kernel panic.

You keep claiming this without ever showing how it happened, that's not
so useful ... I really don't think that should happen given there's RCU
protection involved everywhere. Please show what happens so we can fix
_that_ issue instead of papering over it.

johannes

