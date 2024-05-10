Return-Path: <linux-wireless+bounces-7446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0967D8C21EE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4AC1C20A6A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491B168AE9;
	Fri, 10 May 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a23nI+g4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09392233B;
	Fri, 10 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336339; cv=none; b=rVLIOR7DJuJ646ujwHJ5fBMgZ/bva+TLIbzSvbvTxhoH4znrBi4uNS1xZ5Yc6mAnwBkZOLbVjRik84wQxWh5+l7J9q8atj+C9FNf+MzDEDU86qdiusJXUWhLEXCMD3rEXOqQgqZkgrKvp8oMSNVFrJV45prHwFJO6P5AXwuE0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336339; c=relaxed/simple;
	bh=Yiu+qkyJjBmS6HAy7q+jESZdM+IpPiaNYPekdHCehtE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Mn8bCegXRtSDuhrODReTrh/D5s0tzr7ntW4vrQCIiAz0nclj/XXBeKfMpUNHIpdLVZn2L1DfAn8RDCNMf+cVtLxD5bL4AfeGj+78nYRvGyie8Xy2Kjg3UGcyfflCccqqpA77FRd9o6zN2BIxo5SfsaTCstbGs8GjAp7Bsk++JX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a23nI+g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D9C32783;
	Fri, 10 May 2024 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336338;
	bh=Yiu+qkyJjBmS6HAy7q+jESZdM+IpPiaNYPekdHCehtE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=a23nI+g4n1oFGG/z7seERI3vuJEHB65S2SinVvd9/DkwNDlh/i8EvTXTsrED695cr
	 iXJ0hgWJuJ4uNJiHmk37g+XDhLIe+YqJcIlB6126AQhF88h6lvkA5P2LL3+ByQxziA
	 SL2ce8BMpstt1K08z/XFk5puZLq0J3EVMdm86fkwQWn/VcbcSBO3a1b1MY8vb6is30
	 THuGraOiNB5pdZ18cjqwIbfUACx0CXqXlZBPQ1Q1RGIGnyZ8ZaVNY3SbXHeOB63dka
	 0tmUua8EcJH9j3ljGBfPA30Xgxy8sQdGbT7wBNUoNIv+rWYRht4WrJdrFJyRz/1nIX
	 HSjrtFysFXnHw==
From: Kalle Valo <kvalo@kernel.org>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Carl Huang" <quic_cjhuang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,
    regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
	<20230714023801.2621802-2-quic_cjhuang@quicinc.com>
	<D15TIIDIIESY.D1EKKJLZINMA@fairphone.com>
Date: Fri, 10 May 2024 13:18:55 +0300
In-Reply-To: <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> (Luca Weiss's message
	of "Fri, 10 May 2024 10:22:50 +0200")
Message-ID: <87jzk2km0g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Luca Weiss" <luca.weiss@fairphone.com> writes:

> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>> Add hardware parameter support_dual_stations to indicate
>> whether 2 station interfaces are supported. For chips which
>> support this feature, limit total number of AP interface and
>> mesh point to 1. The max interfaces are 3 for such chips.
>>
>> The chips affected are:
>>  QCA6390 hw2.0
>>  WCN6855 hw2.0
>>  WCN6855 hw2.1
>> Other chips are not affected.
>>
>> For affected chips, remove radar_detect_widths because now
>> num_different_channels is set to 2. radar_detect_widths can
>> be set only when num_different_channels is 1. See mac80211
>> function wiphy_verify_combinations for details.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Hi Carl,
>
> Unfortunately this commit breaks wifi on a QCM6490 smartphone
> (qcm6490-fairphone-fp5) and makes the board crash.
>
> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
> provide address list if chip supports 2 stations")) makes wifi work
> again.

Thanks for the report. So the broken commit is:

f019f4dff2e4 wifi: ath11k: support 2 station interfaces

This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
fully broken in v6.9? Not good. And most likely Linus will release v6.9
on Sunday so it's too late to get a fix included in the final release.

Carl, can you fix this ASAP? Or should we just revert the broken
commits?

Adding this to our regression tracking:

#regzbot introduced: f019f4dff2e4 ^
#regzbot title: ath11k: WCN6750 firmware crashes during initialisation

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

