Return-Path: <linux-wireless+bounces-31512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB2qJ2HAgmljZwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 04:43:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AEE1585
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 04:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46E943008D1B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 03:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332222C11FA;
	Wed,  4 Feb 2026 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnr9Sa6I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA69243954
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176605; cv=none; b=k0/OW+CY/iWuHxbMcFFpIn05PomYoIOlF9uuTky7XmVo2NGJotfnPWRkPd8jfoR7alnuHFPuyK4LjMY2qFc6I/Spk0s6rR20TX/IE/8dudarLGEVDJqpMEdB3vR+2q2ofPN78afniy58LDVNXn42rTa6nAbF3eZDfjSiwrzM6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176605; c=relaxed/simple;
	bh=kQ/ERtPP7p9PZXpGbCbXhbGlyWanAWjvnU7Wnyr2Fjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YZNb+tgA0kMeAq+f48AVG0YXvfoWQoZjqcXyruK02XPbYlMScxWbo28Np5eHEDceWOCcEztZ9s3Mm6IJho7VyPJmdVvcftswzEbND1sgVVqOStVZhSH+zl5yem5+bySAaUw+bisbQRTPcxONtkmlJDfFWB0OjewStuBq11XDoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnr9Sa6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A96C4CEF7;
	Wed,  4 Feb 2026 03:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176604;
	bh=kQ/ERtPP7p9PZXpGbCbXhbGlyWanAWjvnU7Wnyr2Fjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dnr9Sa6I1SUxLgBQa5j+Qb7oXB72eZlbYwNZznfLPFmGMSsNwbGeh6Ewhyyh7Z843
	 b9PQ+7jemQRbPsTaPzVoAQizKq4VFuGJfuUFWxksrauFiRcGrRELcvcO3Hq7zXBQTA
	 Tazny8xvODg2j5N6Sk92VLIEfbZe7KQhwQr74CbHYF34Bqnc3YvsNG+AZ+CVKOXHjb
	 gLQk6t5n/T0+nMmgbIcCtWa7NexI+BVQTMqnbTn+A4STwOAh7hT8HO31+YEadASuTH
	 bAAiLdMbYwpHZ8cxkwyBE0H8FoDQhBm/H2Epfr/UPASbyq16ostUcKxAPWQjYX10yi
	 LLZh4Y9G/tEhg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id D3FD65FBBD;
	Wed, 04 Feb 2026 11:43:21 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: druth@google.com, Ping-Ke Shih <pkshih@realtek.com>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
 Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20260128074236.965019-1-wens@kernel.org>
References: <20260128074236.965019-1-wens@kernel.org>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Canada (CA)
 for 2025
Message-Id: <177017660183.3007562.5582386138915193564.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 11:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31512-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC6AEE1585
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 15:42:34 +0800, Chen-Yu Tsai wrote:
> Canada issued a new revision of its regulatory standards for 2.4 GHz
> and 5 GHz license-exempt local area network devices - RSS-247.
> 
> Update the rules to match the new version. Fix up band boundaries and
> power limit values and units to match the text.
> 
> Note: the database is supposed to have values for e.i.r.p.. Most
> regulatory documents specify e.i.r.p. as well, except for FCC ones and
> any regions that have rules based on FCC ones.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Canada (CA) for 2025
      https://git.kernel.org/wens/wireless-regdb/c/1a729aef1a0d

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


