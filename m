Return-Path: <linux-wireless+bounces-31294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPm2DHULe2k6AwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:25:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 896FAAC92F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDF5301727E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0523D2A3;
	Thu, 29 Jan 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGp7+LO1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6B19004A
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671538; cv=none; b=fNgqNUdWOEZ7eaPfMSHZOpxVuc9HbasndKI8BL7jzvrDWCHj8HR54ZnuQh1A9/FA6mL45xJ8j2QOS0LkjtxY2W8GDMEthpu2xVnu4lWiiMd5znA5i0zfJ8YycZNv4QLVhFVOHg4cUitzMRuQQNEnCVHhkuCWluCH3tXLC0ad5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671538; c=relaxed/simple;
	bh=/7AyFwPcIAznIeh0LFvhNaddbtZu8s5ncJX4Z/UOVis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z8+umn+DuKkyj6vhrTVcxMwX/tYxCGBTTm4zgMXHBhYZSwKcIEZV/cqpy/iLKAPtSTuNVQrVLIoMRXnc4/TGWWd3x3Q0urYIGGbKsD0KRs6/q+llOJUNWkMynP5APsD5f4KLwUzdzp9e5QmnVyKRrOOCy6ouTggCEzsYHBiUwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGp7+LO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437DC4CEF7;
	Thu, 29 Jan 2026 07:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769671538;
	bh=/7AyFwPcIAznIeh0LFvhNaddbtZu8s5ncJX4Z/UOVis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KGp7+LO1HqlZsa1npC4QCV5hWu48T+5nwk2aNlfrwpaJOYL+4wXS5czktut6mgSQ5
	 sUBs1dHGKhzZl3eOZ6kF2TYyOGwC1MmifLhnnHlzsUKAdQXjldaGgPxx83sMz2CE+D
	 1sQFGVgGxTu2osoG8MKaHmD+/6UULmmGhAxwjfA9WFF401VPlosyzgsnBO+7dMvZbh
	 lPove/wl8Y/l0knP1v8cWwtWBGg+QJXkq5SYXuSqYSYMvThXtq/o6N9UjQ4/6BHkOv
	 0kaXnvmhi34mAu+b+/s2q3p1YcnKkqXIUNbXNNc+xChWdsxstPH/qW5RuJifne+ug7
	 s70kepLVPIGhQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id A5AAF5FBBD;
	Thu, 29 Jan 2026 15:25:35 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20260128091634.28983-1-pkshih@gmail.com>
References: <20260128091634.28983-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Tunisia
 (TN) on 6GHz for 2025
Message-Id: <176967153565.1254038.8584678463430792930.b4-ty@kernel.org>
Date: Thu, 29 Jan 2026 15:25:35 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31294-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 896FAAC92F
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 17:16:34 +0800, Ping-Ke Shih wrote:
> By decree no. 2024-641 of December 11, 2024 [1], which applies to
> frequency band 5925-6425 MHz, with power limits 200 mW, for use inside
> buildings, in compliance with EN 303 687.
> 
> [1] https://www.anf.tn/sites/default/files/2025-01/Arr%C3%AAt%C3%A92024_4611.pdf
> 
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Tunisia (TN) on 6GHz for 2025
      https://git.kernel.org/wens/wireless-regdb/c/5cefe5536421

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


