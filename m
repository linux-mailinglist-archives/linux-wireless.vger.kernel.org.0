Return-Path: <linux-wireless+bounces-10613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3593F31F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700A7282903
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F27140E30;
	Mon, 29 Jul 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OeySpQXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE861422C4;
	Mon, 29 Jul 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250155; cv=none; b=i1LNZkIi5iIZyT/JmZJv5HLDvLyBVmakq/fDcw5ftdM/CMqJzmIsRkhnaVWUIn7UzkInjQRvJlwSZRYUQA60MbL+j3gAAfJM/1Kro8WV1OmNq241BfkpLqWaiockz+sWESoWAOwM6DRoSzLZ4a7Q5Nm7yLYJj/LSIG7+GMuKW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250155; c=relaxed/simple;
	bh=CqQ8DmPPhq2TvPaqtF3O+JgsIqNtShF40ckYnKHsZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC6Lc9IpPc4oce52Y1iONzyFTs0mlJmr8rhDnBH8VnTZaEvmcc5bU2JR2FzKujBCUPzbblTpQ9glEilr+E8bTjp7BZztfWebN8AR9iJ3LJYp1PoxwTn0lzMWsVtgijzqVv+ctmU5+ALD3XCT4DqSK6CQPOR+i/U8YwuAwGdJSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OeySpQXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01878C32786;
	Mon, 29 Jul 2024 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250154;
	bh=CqQ8DmPPhq2TvPaqtF3O+JgsIqNtShF40ckYnKHsZu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeySpQXbSIROUa1sOMij9e5RnCuB3nQS9PHR6Gix8a87jwPTFZbskfiZ88Ss6ZKcU
	 8+JSCqo5YJzrwPtLuKbVAXNXN6ZH2Ouwta4/dv9fPwNZd4HKK0ZhqQ8oAgRsYDeLlh
	 ID0MWdwh99Cf41JoE7ABZKSa+w3UoOdvGYqyfggw=
Date: Mon, 29 Jul 2024 12:49:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com, quic_ramess@quicinc.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: stable backport: wifi: mac80211: track capability/opmode NSS
 separately
Message-ID: <2024072900-persevere-lecturer-b749@gregkh>
References: <6d402141-a457-4096-a487-56b4140361be@hauke-m.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d402141-a457-4096-a487-56b4140361be@hauke-m.de>

On Sat, Jul 27, 2024 at 12:54:21AM +0200, Hauke Mehrtens wrote:
> Hi,
> 
> Please backport the following patch back to the stable series 6.6 and 6.1:
> commit a8bca3e9371dc5e276af4168be099b2a05554c2a
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Feb 28 12:01:57 2024 +0100
> 
>     wifi: mac80211: track capability/opmode NSS separately
> 
> There is a small conflict in the copyright year update in
> net/mac80211/sta_info.h, just take the 2024 version.
> 
> 
> On kernel 6.1 please backport this patch first to make the other one apply:
> commit 57b341e9ab13e5688491bfd54f8b5502416c8905
> Author: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Date:   Tue Feb 7 17:11:46 2023 +0530
> 
>     wifi: mac80211: Allow NSS change only up to capability
> 
> 
> 
> This commit fixes a throughput regression introduced into Linux stable with
> the backport of following commit:
> 
> commit dd6c064cfc3fc18d871107c6f5db8837e88572e4
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Mon Jan 29 15:53:55 2024 +0100
> 
>     wifi: mac80211: set station RX-NSS on reconfig
> 
> On older kernel versions it is harder to backport the fixes, maybe revert
> the offending commit in Linux stable 5.15 and older.
> 
> This regression was found by multiple users of OpenWrt in Wifi AP mode.
> See the discussion in this forum thread:
> https://forum.openwrt.org/t/openwrt-23-05-4-service-release/204514/111
> 
> Thank you KONG from the OpenWrt forum for finding the commit which reduced
> the Wifi throughput.

This is a bit complex, please provide a series of backported patches for
each tree that you have tested and done the needed changes to get
working properly.  Otherwise, the above descriptions are going to take a
long time for us to get to, sorry, as we have much more "simpler" things
to backport at this point in time.

thanks,

greg k-h

