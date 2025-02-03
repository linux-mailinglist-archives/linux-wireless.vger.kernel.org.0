Return-Path: <linux-wireless+bounces-18311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339BA26200
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FD43A721F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7958020E306;
	Mon,  3 Feb 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1u0/WIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBD20E02A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738606198; cv=none; b=JAXvBVy1esj7lj8kcD/rsgqMg9+8jYS09a1IBNDmGp24EejiyYwOfnKULboomhLqPRm9WdBaLCvPjJbCaiqaop8yAe6K5eF4xzjbiNBu8HWf/chnkieGvXgcswgrYs8CUZAOuk3LFWdqpolyRADeASkgny0dl9MkgzW941SkDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738606198; c=relaxed/simple;
	bh=+FKLzDimaPYEkaWKrluNJjbsGd9rpbxlDEGIsfJb+rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ydm9aGcRAC8SudLCoSPYvNtWyt5PgWYHNxDrpCM+iZAW8xC++baUil568dqpdsIRAUYGOORt0bIeSPM2KTNeLapdwo/4XWX6c5ilc0ch6zEcabZZaSt0j1LHazMivyazVlftkKEI91qXd0EZ/WvjUzUP+Cs8qL+A0TAL0nsSwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1u0/WIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93691C4CEE2;
	Mon,  3 Feb 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738606197;
	bh=+FKLzDimaPYEkaWKrluNJjbsGd9rpbxlDEGIsfJb+rM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a1u0/WIfK18ypI3VwLM77yHsNhwEv9KmpcdUcQcJ4+//gcTPtZ8apHwa896QGv2Bi
	 jz5B44eXyIDTQD7hzCDFoHr5wfvOMsWM02f7Vwgj1XUao2q4UyIZQeExI7D7kQWdWa
	 u2IIiUQO7ePjqEtPxxvGmHBS+fm97TQ+JDhwPrqTGv0Xf8n8T/Iqb4y7u90Y9xZf3d
	 OMTbARzHyOR4CKe31U+vnI5tp+9SLpNSJ0q1J29wGm2wyPtWceRUCEchgIpFrY8gv9
	 WFrLoEw/WjVYpBs0gBRpEA82GtzGHAMsBuofoRv9MHtP9g6X7RdrgYgIe7l1iCupTH
	 9PwZQHAgGJEKQ==
Message-ID: <f21d8994-5acb-42d8-87c5-bb7ad4f52c0d@kernel.org>
Date: Mon, 3 Feb 2025 10:09:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 1/2] MAINTAINERS: wifi: ath: remove Kalle
To: Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203180445.1429640-1-kvalo@kernel.org>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <20250203180445.1429640-1-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/2025 10:04 AM, Kalle Valo wrote:
> I'm stepping down as ath10k, ath11k and ath12k maintainer so remove me from
> MAINTAINERS file and Device Tree bindings. Jeff continues as the maintainer.
> 
> As my quicinc.com email will not work anymore so add an entry to .mailmap file
> to direct the mail to my kernel.org address.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

With much sadness, and a bit of anxiety...
Acked-by: Jeff Johnson <jjohnson@kernel.org>


