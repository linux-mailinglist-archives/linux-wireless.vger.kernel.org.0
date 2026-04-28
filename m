Return-Path: <linux-wireless+bounces-35450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC18IHdu8GmgTQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:23:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2F47FEFF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 861443096241
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462933D3322;
	Tue, 28 Apr 2026 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="gmLWafRo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237163CEB9B
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364225; cv=none; b=A3xemk0bgLhrd+Q1Lm2niaHyqTStRMX3byeNPZ/ug77Sh/lvGsUCmU/Xmuyuwi21znT0CM136On/WvtvzPH+mBs3yOs8CFuG9jSlbLGVR3e2HRUvEU6cHRAMTZRQ2aYISp4I8UP+b4PKQLqF/gZbLaeSLDtyjobPE7bDo4tti48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364225; c=relaxed/simple;
	bh=sxRqhIL8slZnqs3/le2jB84okHOeuP47N8piHjlyeL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCP5tkLegrLBLmsKQx2AkANet1u6Z0NC/SLA460TLPF4Xo0E7pNzU4MuPWnma/ON4UyttAPPrKG4otTXTKGxGD5O43Ff/xFey5GUcT4gnVFGGI7qftHGOmXK10Z8Duo4qdwK4BfRjM8qZUupHGdLVQhoUUelTK6ie85Td8zeabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=gmLWafRo; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a419:0:640:4647:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 773FFC0FEE;
	Tue, 28 Apr 2026 11:16:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp) with ESMTPSA id nGUM56HYmGk0-d0UMnUVZ;
	Tue, 28 Apr 2026 11:16:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1777364212; bh=kTsGyFAu7NxYzeVwt1GgRjw+PgYKW++MjWdqNjwBocU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=gmLWafRo0n9lAoU6kMlbe85mh5AGQRc1D3RI80mE3TGV/KpKKaCSXzIx5VaG2pO5m
	 T1Y4GSRhzrwo7Jf0ji1Revr9jAhP9n2TUsZOPY4WCiYsVyAyuLMP9S5ABWvkCMwuzp
	 ppO/+NZ3O4121NN6cHecoYRS9mUmrpSk3U3zEg3g=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <b9d9d6e1-91c4-487f-82af-e53d4148c11b@0upti.me>
Date: Tue, 28 Apr 2026 11:16:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless-regdb: allow 320MHz channel width for Russia
To: Louis Kotze <loukot@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Valeriy Kosikhin <vkosikhin@gmail.com>,
 wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250708-russia-320-v1-1-53641e8dd417@0upti.me>
 <20260428074500.ru-320-review-resend@gmail.com>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <20260428074500.ru-320-review-resend@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EEF2F47FEFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0upti.me,quarantine];
	R_DKIM_ALLOW(-0.20)[0upti.me:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35450-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[0upti.me:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@0upti.me,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0upti.me:dkim,0upti.me:mid]

On 2026-04-28 10:44, Louis Kotze wrote:
> 
> Note that the patch base predates the recent RU power update (commit
> 6873bfe in wens/wireless-regdb), which changed 5925-6425 from 100 mW
> to 200 mW, so this needs a rebase on current HEAD before it can be
> applied.
> 
I can resend a rebased version if necessary.

