Return-Path: <linux-wireless+bounces-2575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7383E1F7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 19:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219F31C2197A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944D21370;
	Fri, 26 Jan 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF80mY99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C721EB49;
	Fri, 26 Jan 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295177; cv=none; b=CHBZqaGzc94bwt8CrK30D0EBu+thw1iT8HvZQGg+viBEYpIjCmh7LzfYhe803uXfFL8AGHDgvfZ/5iXxBo//eH2mujUc8M7g+R92JJKfEnkK5v+/bo9mXEpeMGVvGkl+hl7nsjXijdxGnsS9zRfUKICfhr4sqazyjWDsP2yWTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295177; c=relaxed/simple;
	bh=2a40bGvjRwdY9ASx8Lm0SrgXIqTYTumaVvR7c6Nvgok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCyiHCPdCtHWsK7gosdavnw7LbMqmNPncL9lEgpLocF1YFWX4mGJCD0hJOz1Ssk2Jq39mlqiIGMQBs4CZdZbHWyYStCunPzQBeH969QTcVuuPS/H89bZWKswt5PCkFaJ4i/Kiqe8KH9Oi2EqlX1LTP+pia4ed7tjEXXQf9KpA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF80mY99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AB5C433C7;
	Fri, 26 Jan 2024 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706295176;
	bh=2a40bGvjRwdY9ASx8Lm0SrgXIqTYTumaVvR7c6Nvgok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MF80mY99iCvgVm9pUnFihCXSRamZfm4OOuvQoBO3LvCkkaxky5h68P0NiFIXRjOoX
	 dY2nFLb9YK073PLGLl3+OKp5eaKPvoJVnhL9go7KUR+OOZVDn8UMLdUZOMysOuYI5C
	 o2ekcQ6tNgcSpApiS6DI1uPL8CCD2B7aQ3cdCQBonrjLswjwXXs46pAbxB2s+MMjwj
	 q6NGQFJ9Dk6R3O8MGQBplHywBhVCkKJfiHpLfFPbrix7iMSIPjz0QQOPXfr3dllxow
	 ukqJdVBzTiYVsSqaWgD4TlPh2K/yvbvMy3L5ZR0X7oWrp8hnd8naNkbBCdoR4BmLFH
	 Fk8heiM/6DZrA==
Date: Fri, 26 Jan 2024 10:52:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-01-25
Message-ID: <20240126105255.5476cf85@kernel.org>
In-Reply-To: <877cjwz9ya.fsf@kernel.org>
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org>
	<87r0i4zl92.fsf@kernel.org>
	<18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<877cjwz9ya.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 12:05:17 +0200 Kalle Valo wrote:
> > I thought checkpatch would signal that or is it a sparse warning.  
> 
> I don't run checkpatch except for ath10k/ath11k/ath12k, too much noise.
> I ended up adding this to my script:

We run build with sparse and W=1 and then diff the number of warnings 
to weed out the pre-existing ones, FWIW. 

