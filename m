Return-Path: <linux-wireless+bounces-29238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E8C79238
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82F14366665
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13042343D67;
	Fri, 21 Nov 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPrvmWMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E130E0FA;
	Fri, 21 Nov 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730289; cv=none; b=ub1zUNYfpLTaqKzGReu34ev/m4sw8wTJRZAoaKCsdWgh7t04ntf/D4RFH5qRjqI8umG/Qp3O1DaVGEHZ8WEXQ71X/IVqbqb2x0CUwAZ3VXFbiYzxRq4OU3dBx+MW8bVRkgHSB41yTVW6zi1u/pTnFY0eyCi59XTDGcLVr3NxdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730289; c=relaxed/simple;
	bh=OHJBWC9nP8wgrfg2EA5xm625lTDtIVXg3O1V6xI/YMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyYhU5klK7wRTFP5AOnqCQYOIt0X2YcLCeR+WnOXBwAY259NXAIiqSrKanLcg5WtyiDbv5ajEK5tt4WD2wJ6rWB05bt95YjpxKsiSCaTLSJ1fikd83f/8w3ljKuPPX4ani2N+8Fqtefaj+iAjSoy1FDralL5ZIATV4PUG5xg4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPrvmWMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59116C4CEF1;
	Fri, 21 Nov 2025 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763730289;
	bh=OHJBWC9nP8wgrfg2EA5xm625lTDtIVXg3O1V6xI/YMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPrvmWMJjPpAPh8xfxFS+5CRnJ2ErQihhPiOKWgayV9yAt1ILW2a3QDOLMAY+MxOw
	 nPHDmT7JvVG71uxs4zSSgOm3S93F8sRocgJnxhOxK/jsrrHV49I38e8yEMyxokG2bw
	 2TIZAV+e8mWoiXmuq0xLDKiKE7etqA6/vRYaU0+acQPxOTXQKaO9m9prS2qcY4dciN
	 k4G1WweE9J/oj2oclcLXe1XVZe66DDpEOt5P68T03QGd7BYoLqlVV1ucKKhvOceeBw
	 AU3gYMQTg09tb5HClqp1dT5JNVxYoLxE/uzZHo1QwR7pDyDFIDtt5oiXnslYVkT2II
	 jusdOtANrHV/Q==
Date: Fri, 21 Nov 2025 13:04:46 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath: wil6210: fix a bunch of kernel-doc warnings
Message-ID: <aSBjbqQtQFgRTDS0@horms.kernel.org>
References: <20251117020213.443126-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117020213.443126-1-rdunlap@infradead.org>

On Sun, Nov 16, 2025 at 06:02:13PM -0800, Randy Dunlap wrote:
> scripts/kernel-doc.py reports 51 kernel-doc warnings in wil6210.h.
> Fix all kernel-doc warnings reported in wil6210.h.
> 
> Several comments are changed from "/**" to "/*" since it appears that
> "/**" was used for many non-kernel-doc comments.
> 
> - add kernel-doc for missing function parameters
> - add one function "Returns:"
> - correct kernel-doc struct name to match actual struct name in 2 places
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

...

> @@ -444,8 +444,7 @@ static inline u8 mk_cidxtid(u8 cid, u8 t
>   * parse_cidxtid - parse @cidxtid field
>   * @cid: store CID value here
>   * @tid: store TID value here
> - *
> - * @cidxtid field encoded as bits 0..3 - CID; 4..7 - TID
> + * @cidxtid: field encoded as bits 0..3 - CID; 4..7 - TID

Hi Randy,

I wonder if it would make sense to move the @cidxtid line
so it is above the @cid line. In which case the order of
the documentation of the parameters would match their order
in the subject.

But either way, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

>   */
>  static inline void parse_cidxtid(u8 cidxtid, u8 *cid, u8 *tid)
>  {

...


