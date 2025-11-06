Return-Path: <linux-wireless+bounces-28646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE393C38D05
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 03:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AA4634FE09
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 02:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71C8238149;
	Thu,  6 Nov 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLNhkCq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A01DF27D;
	Thu,  6 Nov 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394933; cv=none; b=LlKwYEbxLfBoaFsttsv3hPEwzUPjKRHiscX8ZGdHV5DcE0e4X1VPEN1amr88CnGWcd2dSMU7TLxgZPRY/rRKUWKngD364c+FbCDwRSloQwSqn2flE6bHG25wu5uFhHexKL7vIuKr6mE27J6ZGnBcOJbk8EoXgeFxVPr32vZKJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394933; c=relaxed/simple;
	bh=EFsIVucnCshi7DYoItyeoSF5V7CL2EmZQLG2jOeOy5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7EDWvJpquqDC1SikNR2EJ6o+HS3pqZXEMMnGdgXe77HChGOoOdV427f7n+G/KmTITXCyonvfet5esJhmYSVprVKY4HtiXdw6ybAXOakZIALPiAZ2+s35k4aaPo9lIxPKUxpBMNF3cqEMPKu0NSs7SHOswBjebPERDA7Q0GpvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLNhkCq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5674C4CEF8;
	Thu,  6 Nov 2025 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762394933;
	bh=EFsIVucnCshi7DYoItyeoSF5V7CL2EmZQLG2jOeOy5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mLNhkCq08uPuN8kX89qyxBWb68kOiquhEkf/rsS1gwaFRK6H/9iBAUvP113mb8DGK
	 oN6bUhZBO+tNxOwrJ0iWTuaS/N7aGdBEgJ0js6DtmTSvoVkuTsrGU/tg2V+/P3sVSL
	 oKNVaC4DL29kVIGum3jelRvufuqEztv7Br7Gf8lNFTXHK3m55Pur33QrhxU1ppqTxm
	 6w8zECpl+4FGM5CRY7JlNnPlHl3TFR5vCVnnzjvjYoDgpyqf5SigtIbsaRN7+/URVF
	 WVQPHJEJJnOFG1s0/vj7nWFUZJRny78mTtIOeaPO+8eJbXdJM1pp3ZsoV9h/wVuzRo
	 Nx7UHA+jcKoTQ==
Date: Wed, 5 Nov 2025 18:08:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-11-05
Message-ID: <20251105180852.420d2691@kernel.org>
In-Reply-To: <20251105152827.53254-3-johannes@sipsolutions.net>
References: <20251105152827.53254-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 16:27:39 +0100 Johannes Berg wrote:
> We also have that netlink socket matching
> issue more generally, so will have to fix that in
> other places as well.

FWIW we added genl_sk_priv_get() to avoid having to jump thru all 
the hoops when socket is destroyed.

