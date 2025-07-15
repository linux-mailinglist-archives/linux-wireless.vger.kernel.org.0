Return-Path: <linux-wireless+bounces-25439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9793EB05092
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214C47A2BD0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A11A2398;
	Tue, 15 Jul 2025 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv87xMjC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21506EC2
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555843; cv=none; b=A6nnNVeGFYIBRn1H3EdXoNhbZ4TDSEiLafU4I4yej1ite0GeUP30YmyUjEGCFb3lVdcGMJP25zZYGsz0PA2nILe7/yCzALBVFpo6FIxZAseAi0pjfJSX/fztq8jIws9MO/7d+1A8pioqZtef+tFvQ+VsuPPQUsakZ94UptguzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555843; c=relaxed/simple;
	bh=ZXEDXplXmH7B3Gmxrz2M5kb0QTV0cjR+JIHLkCduKSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX9BhGLoABHHVqSsy4CPvUwN592L5fwsdsCeRQZ0rNRBGt61sz126Hq2m91CUXGcNltZujTRftzQRUivuGaJnYvUsZpfQN+xRSFGg3qv3jdGlzZI7eeJAG8/946AT35sbUdOBlX4BTzUb35OOEV8w2BSseYFA5AiVrUN1SL5fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv87xMjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F33C4CEE3;
	Tue, 15 Jul 2025 05:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752555842;
	bh=ZXEDXplXmH7B3Gmxrz2M5kb0QTV0cjR+JIHLkCduKSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv87xMjCUBqkt2D71YSvnK4Aslo8+wa+dqcw9rMILJ26HEKtwi65pHNnQUK9OWcAG
	 X2hLLfI+HdEp+Mn6IRknAujBVJTT8oXzLUPZl8sSd3z2KUrUtFI5Jyr9F2b3qM2JkL
	 EL2gXvmz+/YjFpa/8OuROm5eDm1sev+8PeDNj3wKbI+p/V+YIEnVCNXJV2cT8DuxIT
	 eEe8fpPGbjCWO6JCZc6k6AhRWrXQ4zrI4jWhwzfdYaWbcUdrZ+fGdiqiycgZwaj1B1
	 ndmh0UerfKZ1StD4PJ6jPM1/DWD09kZsoOpOn68HqV3SbMUObIYijz/tYsWRvqGHHO
	 BUQcqtb63nlpA==
Date: Mon, 14 Jul 2025 22:04:02 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Haoyu Li <lihaoyu499@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com
Subject: Re: [PATCH wireless] wifi: cfg80211: remove scan request n_channels
 counted_by
Message-ID: <202507142200.D315742C@keescook>
References: <20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>

On Mon, Jul 14, 2025 at 02:21:30PM +0200, Johannes Berg wrote:
> If we really wanted to fix it, we'd need to separately track the
> number of channels allocated and the number of channels currently
> used, but given that no bugs were found despite the numerous syzbot
> reports, that'd just be a waste of time.

This mismatch between "quantity allocated" and "quantity used from the
allocation" is repeated in more places that just wifi, and I'd agree
that it has caused some confusion. The intent of __counted_by is to
track the _allocation_, so my mistake was trying to apply it in places
where the allocation size is not retained, and to shoe-horn it into the
"used" tracking member.

Any opposition to adding such a field here, maybe "avail_channels"?

-Kees

-- 
Kees Cook

