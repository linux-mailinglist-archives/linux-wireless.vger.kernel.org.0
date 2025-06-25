Return-Path: <linux-wireless+bounces-24465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F59DAE7DA1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E161888D15
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48229B783;
	Wed, 25 Jun 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDNoeCrK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2929AB07;
	Wed, 25 Jun 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843747; cv=none; b=DdDab5LEmjF9BDTxcSnnBsQROwL5O6cD2vLHuJ95Q3c7cK1mhBpOg910YQSWhxvbv52dJY4pxAA79oMx9/ExNizfHJ1AuyBuTYgAItqiwpQAY+fKV8kRIAZ4u+StNd/PSeoMmdEnKrRN6EYPsMdfOVgQZY1nFNeqwjLzCIVkDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843747; c=relaxed/simple;
	bh=JHAZJ7i24XKSeFxU11UiSJ0cVdDGHBUB4umXE3veDNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la0Kbo7Vkqsw9TVY7QEsuOMQ4PBhgciO1Jka9XLx/7A9X9vMlEFBl2tmWExrfB0NYoKAPv8xNkFatjMySutmuvW9d5349ujTjlJXzIpEm9j3rgpzTsGR24a/ws8xw7CS6K6zE5m9/23LvvuowOyb5AMlm4PhOgRWqeDYtaVkLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDNoeCrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0874C4CEEA;
	Wed, 25 Jun 2025 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750843746;
	bh=JHAZJ7i24XKSeFxU11UiSJ0cVdDGHBUB4umXE3veDNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDNoeCrKYs6P1frIQrIaw1DHvp73obIyVhZO6GIG/aJ+M9eJMve/gYznFcbOBnB8G
	 qkKNiCcZZ4TBK3QA4G13mq/0nwVssj+ObTTVPK0GHWiyUsZRdnMFn60SlYmaIbiSvg
	 i/nx2l5YL5eMUw+Qa60oF4acgMQzsH0C0B16q61LJjp/gqip69kgcGTq+o+856WoHr
	 bd2n4un2vNRoNovRLLww5bzQ+r0GIx1klgb3rF0LcSTtYjkD13ho9/ySjsm3vww1/Q
	 O5j2YqfXro+Ku6PtODi4Fqg6zktf5nsp9Bd1F5g9qJB5+eDSOp8AoT4LRA+STYH3tx
	 tSgNx0RtMjhsw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUMRF-000000000GC-0Sqv;
	Wed, 25 Jun 2025 11:29:05 +0200
Date: Wed, 25 Jun 2025 11:29:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: fix suspend use-after-free after probe
 failure
Message-ID: <aFvBYaTf2SVooUrx@hovoldconsulting.com>
References: <20250624082022.15469-1-johan+linaro@kernel.org>
 <aFpingRwP3foaKJ9@hovoldconsulting.com>
 <43b978a5-c1c3-450d-8340-dc1a6dddc884@oss.qualcomm.com>
 <377affe8-fa88-4ade-9cf8-aaeaaabee679@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377affe8-fa88-4ade-9cf8-aaeaaabee679@oss.qualcomm.com>

On Tue, Jun 24, 2025 at 09:15:51AM -0700, Jeff Johnson wrote:
> On 6/24/2025 8:11 AM, Jeff Johnson wrote:
> > On 6/24/2025 1:32 AM, Johan Hovold wrote:
> >> On Tue, Jun 24, 2025 at 10:20:22AM +0200, Johan Hovold wrote:
> >>> Make sure to deregister the PM notifier to avoid a use-after-free on
> >>> suspend in case core initialisation fails (e.g. due to missing
> >>> firmware).
> >>
> >> Not sure it matters in this case, but forgot to include:
> >>
> >> Tested-on: WCN6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > 
> > I'll add that.
> > I'll also change the Link: to Closes: per checkpatch:
> > 
> > WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

Checkpatch is just a tool and it's output should not be treated as
something that you must follow.

Linus reluctantly allowed Closes: to be used as an *alternative* to
Link: [1], but then there was mission creep and now checkpatch has
started warning about a perfectly valid Link: tag after Reported-by:
without that even being made clear in the commit message [2].

I'll stick with Link: (like Linus still do most of the time), but I
don't mind if you want to change this to Closes: for ath11k.

> Please check pending patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=2418079880408c5ae0b2a93f72af044eaff18cb6

Looks good, thanks.

Johan

[1] https://lore.kernel.org/lkml/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20230314-doc-checkpatch-closes-tag-v4-4-d26d1fa66f9f@tessares.net/

