Return-Path: <linux-wireless+bounces-33187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCk9Fv23s2nbaAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:08:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CE427E82A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 684533015117
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B31F987;
	Fri, 13 Mar 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ng1R6iWM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B529B224
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385723; cv=none; b=ZvT2PuCWo5lXkNux4rkKRmseII5W1/9hAvSR2z37iGIiqVGXIZ3Qa1L2fV4u8yFJqnPXDbPyLAk3Oq5Nk8TUz+gf0mPnggB/AxhLsSm1gHXjZdYdZED3a2hj5RYRdj6XU+uBnDdIGOk2KoN0m+dZSt3kRYPpGnkT3nB+9+BPnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385723; c=relaxed/simple;
	bh=A1P2sLZEqvY5rhdDJz4F0VfN7UXYlsqFPfTmdPIulGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBpodZkmOAuwc3DJdtZmdrjR+QS1kyIglovgQvb9TL+DIrodZnKb2QTSJsclWPglEucUAey3BR3pwbl5yRunKMg2Gqe6SyN0fGS+tRIFHjCeQLECv2MHX9Lgchl/J3Dk9BScfCT9gNj7A915x3bttesxXDp1qDqgCCOsoD4LV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ng1R6iWM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A1P2sLZEqvY5rhdDJz4F0VfN7UXYlsqFPfTmdPIulGY=;
	t=1773385722; x=1774595322; b=ng1R6iWMx7/5mmSUhy6WSjEYRyNq99sAnBSwduRc9SarFaB
	S4HjAD17DDhI/yvet7Hl6pyFXpDUnEXyyjmU6RXyLeFIY4Klj8cpzynO1vRMwdRbsBPHL7rS+D2Oz
	4DY3U30KnmPNvvAcjdoUiChGIB128NY2ULy7cuWqGQ2ntY7uc3BBvC25XkXSTGbhbZ8o2AX4evYF4
	NkeKSR4SeKQyoThbFGh9+wbDpjnYRpgA/D/IheaXYxZ8cu6Ui0fhvZPHf45jup3VnV7cHb1RYRL2N
	aYXgw7Pi+PVqaN0OXBOq2IkY5p9R8HVyD6ROkInQCojzOPIAr/7G0aeal+nxB2lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0wdR-0000000GmXY-3bxM;
	Fri, 13 Mar 2026 08:08:38 +0100
Message-ID: <e7f3ba3acca1308bc0871a3892da9e15525d5038.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: stop hardware before clearing driver state on
 reconfig failure
From: Johannes Berg <johannes@sipsolutions.net>
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, Christian Lamparter
	 <chunkeey@googlemail.com>
Date: Fri, 13 Mar 2026 08:08:36 +0100
In-Reply-To: <AM7PPF5613FA0B697F9C2D2DC13F462DC029444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
References: 
	<AM7PPF5613FA0B697F9C2D2DC13F462DC029444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33187-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hotmail.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3CE427E82A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 15:30 +0100, Masi Osmani wrote:
> When ieee80211_handle_reconfig_failure() is called after a failed HW
> reconfiguration, it clears IEEE80211_SDATA_IN_DRIVER flags on all
> interfaces but does not stop the hardware.

Yeah, but ieee80211_do_stop() via cfg80211_shutdown_all_interfaces()
should call it later? Now you're calling it twice, which seems odd?


> This creates a race window:
> cfg80211_shutdown_all_interfaces() subsequently calls ieee80211_do_stop()
> which runs sta_info_flush() to destroy stations, while the driver's RX
> path may still be delivering frames that reference station data being
> freed.

How is that possible?

> This race was observed with the carl9170 driver: when firmware
> deadlocks during a restart attempt, ieee80211_reconfig() fails
> at drv_add_interface(). The subsequent interface teardown triggers
> sta_info_destroy_part2() while the USB RX tasklet still calls
> ieee80211_rx_napi(), causing a use-after-free kernel panic.

That doesn't make sense, station lookups should be protected, either by
locking or by RCU; there's synchronize_net() in __sta_info_flush() for
that.

Can you please report the actual bug?

> The fix stops the hardware in ieee80211_handle_reconfig_failure() before
> clearing IN_DRIVER state, ensuring no driver can deliver RX frames once
> the teardown begins.

I don't think that really is a good fix, and if it that crash can happen
here then it can likely also happen during normal teardown, and we
should fix it differently.

johannes

