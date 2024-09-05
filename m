Return-Path: <linux-wireless+bounces-12537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA696DFBF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33B1C23548
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01251A4E70;
	Thu,  5 Sep 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="TBfvl91J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB31A08BC
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553825; cv=none; b=DSkZdtq4LUcK8P1DYqNcBXHceLrCdlnmPDhAaEoBg+4uOvkqEdUfg1RvoMSsJIo+OR5EO81eM/LqGPuLjXt2yJhUSfzabFF76b+4F+/3s5Fn1btvng/mAf4anRXkRpyFW7AhzjZvjZYgxnCnJ/lBekbDC/Smd6x6VfTtOAF8yNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553825; c=relaxed/simple;
	bh=tDdyPYqkM7Q9lwGajP4Pjg+nYzVtuUQulSXJIfI5RvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNOvgJfmXkm/VuILzGRIRFiqiK4InyfHGyxtojF9/5UUakUJVhsLrRKYh0WRWaHSUBmBy3B01vn3LwAb+Isqa/ZPLBk8WShB9Jbtho6dgp82RtxiIFXmHlfwuB3jHbdoO6UQIjKE9xKMmRacFV5intRtfoOLO3DgnlITXAncTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=TBfvl91J; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1725553274; bh=tDdyPYqkM7Q9lwGajP4Pjg+nYzVtuUQulSXJIfI5RvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TBfvl91JrdZKAQ6W4pnSe5IxH7Yue1naIoQUdFthVOjtFYSbwvrHWpSzvQqxbn4Pp
	 GPU3N1oBUdx5T5CUeU3gBALWcCndxlWrilyz5nd8fuHP+RTFrhN9Vm10roH+YqpnnY
	 HEHaPKuLYlaUNRLIzjT/jRN+KdwnVABcLzyFV5rvVrAXXujLOoCjQlR8gpubvHmHJJ
	 DaeM1SWo5DFAzcHOK2+Kbsw6sCrQzhicWNNAnXvu+F8XR1pj/abOsbXI3mGzjoQ9NQ
	 HpRA25mX+KWrMhUkuETBSf761oUSvo/GXbUvqPNjU77clJweJikBsoLGbj9gSXCE7F
	 GFpMg3ILv4DSQ==
To: Li Zetao <lizetao1@huawei.com>, kvalo@kernel.org
Cc: lizetao1@huawei.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH -next] ath9k: use clamp() in ar9003_aic_cal_post_process()
In-Reply-To: <20240830011858.603514-1-lizetao1@huawei.com>
References: <20240830011858.603514-1-lizetao1@huawei.com>
Date: Thu, 05 Sep 2024 18:21:14 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878qw6hy11.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Li Zetao <lizetao1@huawei.com> writes:

> When it needs to get a value within a certain interval, using clamp()
> makes the code easier to understand than min(max()).
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

