Return-Path: <linux-wireless+bounces-16071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2A9E9ACD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6051656E3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273A2FC52;
	Mon,  9 Dec 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3pvPSK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339073D76;
	Mon,  9 Dec 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759145; cv=none; b=MFxBdQZ0Evv3Zu+m4ncPyicA1utaaJInJadsYaD1FK0AE4l/E930/4B2YKS97IFlwQn4FI3ByhdPHZN1bS0tsAhn5SDz2mBBFHiPiMwitzS9YmFIubzebe/NNJmu8TfC/b5d25QqhB6VbUecdDuUVqbjPaquKlPNQ29sb0hKYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759145; c=relaxed/simple;
	bh=BEtGeaVHypoezdbTPZ5vIhGMqwRUde0JQlPRxfPmkTg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y+SaPUR3n2cR4P3fgOzqI88cIYtgreZSLx0XLPwHbDk+/hOUYWcrTTeg023ADSYMKcPM03w6VuLnHwhwdP04Tb6Kh/pZ1YIPB4VxXZNE5a6TAunr1xXBYK87xrVzfaUax7u6O6R5ze8JCoqlu5Kr7ezF0RWo3F7jScCkBydc2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3pvPSK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07374C4CED1;
	Mon,  9 Dec 2024 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759144;
	bh=BEtGeaVHypoezdbTPZ5vIhGMqwRUde0JQlPRxfPmkTg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W3pvPSK2vuLBIv5KGIc/OL0H/u6mRwibECnmQGwYhfVDHNcsakXhg2S3dio6fdbst
	 EbLH7v34IMFQSHFdBINSW390AomZj2oSB+Yd0VHpVar5ZosblOMjCalCYBbaVchBlB
	 yQByBCBv62lNYLausBOdawWPEm4kw4iN4o3l3w5AB/PaQoYDi+9bVEiZfaAdybHbKc
	 /mCYdA90ylCt69H2p9Jbba0DLzTXcNB+bLBEjQcEd88cLzn3yAmzyuGomvYFh3rn/g
	 Hb2EepfNSeczp0T6Wol0uZRAIkTKX0f9bQYLjsjUI1NXUUgdp9Zo3ftDBkZy8KgkR3
	 z9AllRYGZ36tg==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sriram R <quic_srirrama@quicinc.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath12k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: ath12k: Off by one in
 ath12k_wmi_process_csa_switch_count_event()
References: <755becb1-819b-484d-8fac-9a2db53ced1b@stanley.mountain>
Date: Mon, 09 Dec 2024 17:45:41 +0200
In-Reply-To: <755becb1-819b-484d-8fac-9a2db53ced1b@stanley.mountain> (Dan
	Carpenter's message of "Fri, 6 Dec 2024 15:52:29 +0300")
Message-ID: <87ed2gsvve.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Carpenter <dan.carpenter@linaro.org> writes:

> The ahvif->vif->link_conf[] array has IEEE80211_MLD_MAX_NUM_LINKS elements
> so this should be >= instead of > to avoid an out of bounds access.
>
> Fixes: 3952657848c0 ("wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

