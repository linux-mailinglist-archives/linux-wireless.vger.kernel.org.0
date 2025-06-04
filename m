Return-Path: <linux-wireless+bounces-23715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F92EACE1FC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B845218946DB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398AF1A0730;
	Wed,  4 Jun 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="PZiEpIsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746A146D6A;
	Wed,  4 Jun 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053588; cv=none; b=CrkURoPMBuy5n3W9xnprAlBHYo4tp5DmIxhq+iI2h59F9u4E4aqLcxPlqpWIHev4pMHnd+h4bV+yBTqd4VBPU+/elVch/W3HMDEMzn7IEcnTum4PHU4wrBc+lVy+/J/VbaDmFBhH2m1jrfKwFCx9A6c+SDonp35efi9A2FnGCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053588; c=relaxed/simple;
	bh=fB2UD26wzMl1GY+lHaukD4lWmoYr5jXMlH+/ugTc4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b21t60lGt9bOJ8o+29VkYifc2WxKd/e8bsl5gOcGu1Bf0hDXOo5OCbSkmHhETbz8ifkd5NSVtxS6eIdiNQSslOtJLOLJhJJK7rQ7JA42qXyu35QTYGmeiyVh4HrU8PCQW9IFMDRDijyyrnak/W8Xg0TA6SWP+6gPrqsmNEoYdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=PZiEpIsE; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 56334407618E;
	Wed,  4 Jun 2025 16:06:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 56334407618E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749053180;
	bh=srOffEYPm8C2RDInEtO8Jo4/UKBSIM6ojmOSklDGXgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZiEpIsEb7xdqrOCjwzC05dxDw8244WL9mulD7qcA8mUMlXD6msBCg+dZ0VwzeI3T
	 /vKpPi2gRrN+RPO6Wy8880JyQ4xr29xdBwbakhXRX/hytV0KMVhGkHzjpD5LQ2BD+N
	 Ayzxm2lT4eFr/FzS52MpwzhoGMr+WApOvRHf91IM=
Date: Wed, 4 Jun 2025 19:06:20 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: sar: drop assertion from
 rtw89_sar_set_src()
Message-ID: <ose7mun3sogq2434ba6v7pnzgpctusmhdfk4x5khwk5qnwhyoz@4bfb4jcljrae>
References: <20250603152642.185672-1-pchelkin@ispras.ru>
 <aa24adf30a1e4944acefa4effff46dfd@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa24adf30a1e4944acefa4effff46dfd@realtek.com>

On Wed, 04. Jun 01:28, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > Urgh, this one wasn't caught as my system doesn't have any SAR available
> > from ACPI. But it would be falsely triggered, too. If I saw it earlier,
> > I'd better prepared this as a followup patch in a series though..
> > 
> 
> Good catch. 
> 
> There are two consumers. One is rtw89_apply_sar_acpi() which should not
> assert wiphy_lock, but the other rtw89_apply_sar_common() can be. As I know,
> the assertion is added for the latter one initially.
> 
> Another way is to assert the lock under condition of 
>    test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags)
> 

Ok, thanks! So I'll fold this reworked patch and the other one [1] into
a series and send them out.

[1]: https://lore.kernel.org/linux-wireless/20250603144614.175003-1-pchelkin@ispras.ru/

