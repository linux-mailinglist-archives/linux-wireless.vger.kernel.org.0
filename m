Return-Path: <linux-wireless+bounces-35220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E2CMHHc6GnOQwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 16:34:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AA4474B0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D05B330193B9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4356373BE0;
	Wed, 22 Apr 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWy9XAG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015030E0C0;
	Wed, 22 Apr 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868459; cv=none; b=jXT2XeUe1OzGfnfgjcP1WAxm9fz1DojEHNdHTfs4iUlhogK9wcP0d7uryWbIeFiLgn9m/qEdcFid1GF6eIxD7tXXjL1BqOhDZadspPY1MANPBrbajqxB/HYVnWUxQPjCnKFG750jlSrcbtNwxxbqb06nz0MfJmhBzx3g2qlZ2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868459; c=relaxed/simple;
	bh=UmaIxeoeK2QX+j2dmuQ0WkRWY2DaTK2Yjfzl9MUl+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnrUh3YMKPke2+eQDW7nFTaTq4StWme5oZ6FTYJzBj47rJngui8sPKBhM+/VmgW1Nd8v6AJ7hgTKx6z+ztwaOEcRnVcRQ9JHCfbvF79T1t7YTKrlGLJGFSne5dAeh3huBNVulbJEOdKRw/OJEuY655ALj8MShBqSRMyC4rxaNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWy9XAG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9F0C19425;
	Wed, 22 Apr 2026 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868459;
	bh=UmaIxeoeK2QX+j2dmuQ0WkRWY2DaTK2Yjfzl9MUl+sM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWy9XAG8DAsuKdS/HNps9d/J1Ee9nrR9VqxbYj9W74X+UI9UzU+Ug3iewOUvUoUBe
	 aCjO0LqhSzyb7qvYllgXH9aF2JPmA2qX3x9n3EL14R4fj/JIZtIvFLCoL+LZPW8+dd
	 a9zmnHXQY9esri6M9O+4Omlz+N0+FTCsZDMGDNEnGe60NkVWJKffknxCJ14l72i+5J
	 N5nqi/PXEcV2w7FHQeRC36cZhj3XxLjHutX9/9vcJkB03lcX6Hu9Quml1vYxaPkiwc
	 UU6RG1lIqjR7j28LvCmin6T/eOCvtiHOJHFoYOF5UAyEzYIb1tHyg50uARmtd7LNzC
	 1iYmtw7AQdn7Q==
Message-ID: <0bb445e0-658f-47e1-a455-7fc4513c8fb0@kernel.org>
Date: Wed, 22 Apr 2026 07:34:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: prepare REO update element only
 for primary link
To: Thorsten Leemhuis <linux@leemhuis.info>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
 <ed0ecf21-54b4-41e0-92a9-3c7a0e140882@leemhuis.info>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <ed0ecf21-54b4-41e0-92a9-3c7a0e140882@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35220-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jjohnson@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A56AA4474B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 2:30 AM, Thorsten Leemhuis wrote:
> Lo! Top-posting on purpose to make this easy to process.
> 
> Jeff, what happened to below patch? It was supposed to fix the
> regression linked below, but unless I'm missing something (which might
> very well be the case!) it seems it never got any further than this thread.
> 
> Ciao, Thorsten
> 
> P.S:: Adding a stable tag might be good to ensure this fix is backported.

No, I dropped the ball on this. Let me pick it up for next week's -rc2

/jeff


