Return-Path: <linux-wireless+bounces-34918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMTnEivo4WmKzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:58:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C84418494
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04596307F4EE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5434FF76;
	Fri, 17 Apr 2026 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dPJzprPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3934347512;
	Fri, 17 Apr 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412574; cv=none; b=LzbAuMN0KERRKeMi3RAKUS4gdItsyDIkew7Qilj8zq9wvEDXk4I/d4t6c4gLC+SaoywisGUHAvh3ZqTfYxukKeRwjUKiaOgLj0oejV572xLd2NplHvv474KS6ailnx83UaXSwgKNiqDcTAHMJu16JjktsIxPN4qT2Wc9K9VPN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412574; c=relaxed/simple;
	bh=vF96Zn3Bs1MyVYu+yBMbM3mkvqfs8qlxL16ireJDrLI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSOO/9LYK5k/t0GGZyAYZ90tBVBMruH9VCYqijbGShxSGHWrQDrH4C9d6JIT93pcPzacMcTx30TWMOX6rjxI27mwujsgia3I1ZotN/FsQSVq1eti/sxMdDrSNhbtt/QIT/E9/SYpXicy04E0B17mIAgZ4vrXAXOaFXlZJtvWmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dPJzprPw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vF96Zn3Bs1MyVYu+yBMbM3mkvqfs8qlxL16ireJDrLI=;
	t=1776412572; x=1777622172; b=dPJzprPw+uD6sJNq4H8CI7Zwjxz7ym0u7EPcpgujIvxpt6V
	Z938JTL76dHxqS0A7Rl58zUHU1gXgHSVnFjowLptUYGy2Xnf3OVqmeMoUKBmIzr92+SjZuUpA2hUR
	LxVD6H0bgw6HgBcZpliP0dLZX2E44dEdsk/unO+r3j7WA4/xuNH9ICvlfJ1soL1aYRm9cAceGV3mn
	XvbxTpZaZUM6EsgUrR3bbDr2r5Whsx4Weeslu2Il0sRZQYXZMpP2zHXkYrReCUl6j2x5LfbWh59yz
	8KhdchkW26KbKF3OD9Qo5uNE3xeNvBQJ2SV5nIZ4FrB48+xlPxfBekPq15mB5O5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDe3e-00000008MkW-0Q9g;
	Fri, 17 Apr 2026 09:56:10 +0200
Message-ID: <f0fe4e35db01e4718e1bc5b62f161e1a2c46cb73.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: debugfs: bound queue state formatting to
 PAGE_SIZE
From: Johannes Berg <johannes@sipsolutions.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 09:56:09 +0200
In-Reply-To: <20260417074604.18976-1-pengpeng@iscas.ac.cn>
References: <20260417074604.18976-1-pengpeng@iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34918-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: B3C84418494
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 15:46 +0800, Pengpeng Hou wrote:
> queues_read() formats all queue state lines into a fixed stack buffer
> that budgets only 20 bytes per queue and appends each line with
> sprintf().
>=20
> The queue-stop reason bitmap is printed with %#.8lx, whose width is not
> capped on 64-bit builds, and the pending queue length field can add more
> digits still. The cumulative output can therefore run past the end of
> the fixed stack buffer.

I'd agree the code isn't optimal, but this simply isn't true.

> Format the output into a PAGE_SIZE heap buffer with scnprintf() and stop
> once the debugfs read buffer is full.

And the fix is just strange.

> Fixes: db2e6bd4e966 ("mac80211: add queue debugfs file")
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

There also should be no blank line there.

johannes

