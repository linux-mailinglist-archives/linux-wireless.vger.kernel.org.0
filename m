Return-Path: <linux-wireless+bounces-31573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBF9LN4rhGla0QMAu9opvQ
	(envelope-from <linux-wireless+bounces-31573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 06:34:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B3EEC14
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 06:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA603006170
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 05:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916031AF1E;
	Thu,  5 Feb 2026 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaVssOsM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB32FE578;
	Thu,  5 Feb 2026 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269493; cv=none; b=jj28L3Ri/n5ryZkSQ3U6VTkl5WCoV+2zueJcuUndZxEc5V581I7acvsSVDYdYiW/7/NhRG3mwGXwXUn0aT+9+WM5HMM8qOnDY4R7/bbePPrdprWZyyGI6PQ9U2zeXaUr9lYIVxZUHHwNm3yYll/cLVfwLLUHlNRiYwlTswmZeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269493; c=relaxed/simple;
	bh=U1VZtBF0HeNHjbcHf0A6jSGSsmutR7kcpX9RfsF15aY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euAtgVxljWEDP6HWvTnzvlb0d3pQhe2JWMB4mR7iXAJs4ECz05TXc4ZCo3udCQbmAerJgFbFd1C8dKGGTCWs8RGM4jndU9NoGK+q4gGzteJoUeoi57l3+J0lUsJgBUXB//II2gK9tt8eNQS/W5CycIt4ImVrfkr3ASqdOQRiMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaVssOsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A083C4CEF7;
	Thu,  5 Feb 2026 05:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269493;
	bh=U1VZtBF0HeNHjbcHf0A6jSGSsmutR7kcpX9RfsF15aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CaVssOsMrpEG2aEJ9HgPExLHt/HQKuYt/9VfpOcLPuOQz9+O9Kj4i8/KEAtuhJ1CK
	 Y1oGSw+PnRDwees+07DVWfpaKe5NOuAynhd8aNnvHxRxZTklqrDle0GVRJXgdfgSJ8
	 USScrtiKbQN35t3rz0sBGi3bHDt7MKj069iAG7MpNkbXQZO1WL/Y4x4EfIP0hd778p
	 Jv0TyxRz4GIHw7m4WCV8i69GvfZJlrbZ7yQyXSY7+KO65SABoRUlh+q6GN8t06GKrt
	 aA/lK8cf3Z+kIRwNQKj9L4ab3k+iRMT4DdpLwLRukewszF9pk2taOuUwhac1xI7Azc
	 alJnRrqYkq+5Q==
Date: Wed, 4 Feb 2026 21:31:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2026-02-04
Message-ID: <20260204213131.3b0ec018@kernel.org>
In-Reply-To: <20260204121143.181112-3-johannes@sipsolutions.net>
References: <20260204121143.181112-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31573-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F8B3EEC14
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 13:09:51 +0100 Johannes Berg wrote:
> And here's a final set of changes for the -next tree.
> rtw seems to have the biggest changes, refactoring to
> support a new device.

Pulled both, thanks!

