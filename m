Return-Path: <linux-wireless+bounces-26370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEFEB24FE5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19A2170852
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37A26E6FE;
	Wed, 13 Aug 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C3wwanf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9591F4C8C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102250; cv=none; b=BfuNEl8QLT5/lhDO+buTMS0sb8DlWWfko4WsfoYEGy/jmU41sG5ufbr20b7Cc784GzE8AHQHqvEmDFpf+tI0lqa9hgXl+4CXz6Uap28CSh4J+++n+cq6Z7VztJKfWxQElQ0HKYHOTrQ43uymTSY5joKAoEDqHASOZLvCRQv5r0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102250; c=relaxed/simple;
	bh=MD6WCoZ1Gvdd/oqFMCSNaXJwQnNQWyh9pTH4uMikq4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSu5DEYboQNsRApv1npWRp9sGxYjApOVuomwDgYlVKx+4NGJTIK0mK1iAtnT0ms7I6nznGb8Y9uK3vpaPNoaJCwcdyMmqzpFbe4lnqIwEyyv1DJbdojCaDKGZQyxkZ9dUoS93iL96vZTVH5i2z0J3WAs72zojpDDmqoMHEQumAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C3wwanf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44F7C4CEEB;
	Wed, 13 Aug 2025 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755102250;
	bh=MD6WCoZ1Gvdd/oqFMCSNaXJwQnNQWyh9pTH4uMikq4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3wwanf4AX/iQGKyvzmChuM4YdocLBNai8yUKtWBl3/ToeiaqcC7dU7BpKtA3MoEM
	 nTg6QJXZlhLDLKwi66ATCju6tmVBsRxQ4iyXUDPKconv/DZURUY4cd6ZIcHVNqaR/f
	 34wQIlz0H3NRED+IZsq6bEUHe+dpHDFkTZlyqqbs=
Date: Wed, 13 Aug 2025 18:24:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kiran Venkatappa <quic_kiranv@quicinc.com>,
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH ath12k-ng 03/13] wifi: ath12k: Move Wi-Fi 7 WMI
 configuration to dedicated file
Message-ID: <2025081320-coastal-graded-40a2@gregkh>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <20250812-ath12k-mod-v1-3-8c9b0eb9335d@quicinc.com>
 <00a72188-8ac7-4527-8128-352d0882754f@kernel.org>
 <b62af6d9-eea1-41d0-997d-b9585f2a9533@oss.qualcomm.com>
 <f6b046b0-d230-41e6-ab18-686cc7b65f16@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b046b0-d230-41e6-ab18-686cc7b65f16@kernel.org>

On Wed, Aug 13, 2025 at 06:00:44PM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2025 17:43, Jeff Johnson wrote:
> > On 8/12/2025 10:52 PM, Krzysztof Kozlowski wrote:
> >> On 12/08/2025 19:09, Kiran Venkatappa wrote:
> >>> +}
> >>> diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58
> >>> --- /dev/null
> >>> +++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
> >>> @@ -0,0 +1,15 @@
> >>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> >>> +/*
> >>> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> >>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >>
> >> Don't rewrite the copyrights. Original file had different one. GPL FAQ
> >> also EXPLICITLY asks for date in copyrights and does not allow one
> >> without the date.
> >>
> >> (and before you bring internal qcom regulations, let me remind that they
> >> do not matter. we discussed this in other thread)
> > 
> > Wi-Fi team wasn't party to the other thread, and this series was following the
> > legal guidance we were given. I'm circling with the core kernel team and the
> > legal team to make sure your concerns are resolved.
> 
> +Cc Greg,

Oops, I just responded to this issue elsewhere.

> Please follow legal guidance expressed in:
> https://www.gnu.org/licenses/gpl-howto.en.html#copyright-notice
> 
> and the license you agreed by signing of the patch:
> LICENSES/preferred/GPL-2.0:
> 
> "Copyright (C) <year>  <name of author> "
> ...
> "... publish on each copy an appropriate
> copyright notice and disclaimer of warranty;"

Nope, we do NOT force the FSF's legal intrepretation of copyright marks
on any company at all.  It's up to the copyright holders themselves for
how they wish to mark the copyright, if at all.

And really, Qualcomm is a company that is run by lawyers, they know what
they want to do for whatever reason that might be...

> Just to remind - you as author sign off your patch, not your legal team.

Agreed, but in some cases, I have forced legal teams to sign off on
patches, so don't rule that out :)

thanks,

greg k-h

