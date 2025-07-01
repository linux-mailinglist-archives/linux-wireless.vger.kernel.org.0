Return-Path: <linux-wireless+bounces-24716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183DAEF501
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927AD4A3D50
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2726FDBD;
	Tue,  1 Jul 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lvBn6uJh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448613AA53;
	Tue,  1 Jul 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365569; cv=none; b=XIZlQpjm8yiI3JeXHmpetLbB7eVYUDsyv9EpjE7l+34OLjtzuzK+ACHkfvF2bb/wOAeongC1GoHXkPKQljqNU9mMGTjBSMPkrY9jvIF3wsEs5Xv5+aBDkkzRqy66ReTXf1cjcUpbwYn62ubWE1xIO2G+Oo6YjJKpqP6aB0k0r44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365569; c=relaxed/simple;
	bh=EWqF4PS4ux3AR3WZyTBG58Z+5XJMCAN0LTz5K9oLotk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6O4A7Vtz4UyX98iPHjktsSFFGY1T+mn7cXL7mKQnsRy7iXYZNOhOoFBGeA0q9MylbM3u5XKMxxdYcGtSqbLE/aYhNCCrrKLqRSI2NQcgzROsFI/ogkU/3xteWuS6It4teezwBBntC9s1JoBGi4RIbL07Bw8FT5t64A0AFqXUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lvBn6uJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E625C4CEEB;
	Tue,  1 Jul 2025 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751365568;
	bh=EWqF4PS4ux3AR3WZyTBG58Z+5XJMCAN0LTz5K9oLotk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvBn6uJhNChAJjETNk3DJAnFYB7SCcZquwZZWaRxzGYX9ReESOQ54xSrIhO3TOyDB
	 Xb/H+XjBCzjnbO2RJXvwP4EOY8fm2/iRV3ts1iOim1P4uLZvehOPQaRZ3kFMpiFYZM
	 gQQyhjtmV+uUhZqAlDIwpCK5Eppxnr8Lsm2u7dSs=
Date: Tue, 1 Jul 2025 12:26:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
Message-ID: <2025070144-lent-buzz-28ff@gregkh>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630074330.253867-4-usama.anjum@collabora.com>

On Mon, Jun 30, 2025 at 12:43:30PM +0500, Muhammad Usama Anjum wrote:
> Don't deinitialize the device context while going into suspend or
> hibernation cycles. Otherwise the resume may fail if at resume time, the
> memory pressure is high and no dma memory is available.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")

No cc: stable?

