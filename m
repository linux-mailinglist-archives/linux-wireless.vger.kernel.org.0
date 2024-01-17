Return-Path: <linux-wireless+bounces-2121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CD830C7A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938BF2827C1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F022EF6;
	Wed, 17 Jan 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBl7Bvs8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18722EE0
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515042; cv=none; b=peDCfEf3OXk7KXXvVI5Kp5DUkmXXj8iTNHGCre9Fq/MpCWUxiACVzt3L03RtJo2nU0FeQmS2i0EilIp05t/PA0J4B2cyqx+ZFL1VYW/Ugqmj0pgMn+YS/ISQiyc3jqvrV0ykMdkpgSYX8fdEn+/350Ntc11T4O/EqT56GxEKwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515042; c=relaxed/simple;
	bh=RTRyEp2WNcu13qaBMTceLYJiUr8QpjU4P2esWE0WBWs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=FmahMcKlh8wqdwwUz04ZIM4oJzSYFUwXkoJUS4rXQmjXCRrcm3uh+KYC0BUfzY2XMPAa2fjxOfB/s6RQA8JvC+W5vsZbcWvkt1xttfNUtNW28iu00UXw7Z/NSZjvFJo02fUOEPCAiFe6n1sXttBIv0+MlshWzi/tzYY/4JD7dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBl7Bvs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7FEC433C7;
	Wed, 17 Jan 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705515041;
	bh=RTRyEp2WNcu13qaBMTceLYJiUr8QpjU4P2esWE0WBWs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qBl7Bvs8naFzAmPvyUpHcIl1d8CKQB11eXSTW2r9+fGKeNPQ6XAmlxM65bCoKypLW
	 T3tvJyvw8EKwBBFPftuFiQxw1I5ysnLaK4Fh4JfzakGCeXH4yjMUb3mf1xWHwH66lR
	 ygEX+m1pQDJ9Z4zUYWSi/CXHVZzg4EdupB2NqY4Gda2+eqCOHKCH1FxcUugnkw4lsp
	 AHBYZHb4/p4kebKMkwnVuUZnb1VoluebhhHTgGg3zG34siab+yxwqIsgb2OZkkaHK2
	 9DcOABGNsdJVFMMgA/b1x0R1Duo5ZKKlfBgSSU0eBCa6hwHXolf3FHOLt/UsM77Kyi
	 dnlFN8/McCE6Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <benjamin@sipsolutions.net>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3] wifi: ath11k: rely on mac80211 debugfs handling for vif
References: <20240115101805.1277949-1-benjamin@sipsolutions.net>
	<26a42f14-dd38-4c67-8f66-16baaff25885@quicinc.com>
Date: Wed, 17 Jan 2024 20:10:38 +0200
In-Reply-To: <26a42f14-dd38-4c67-8f66-16baaff25885@quicinc.com> (Jeff
	Johnson's message of "Wed, 17 Jan 2024 07:14:18 -0800")
Message-ID: <87r0if4yqp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/15/2024 2:18 AM, benjamin@sipsolutions.net wrote:
>> From: Benjamin Berg <benjamin.berg@intel.com>
>> 
>> mac80211 started to delete debugfs entries in certain cases, causing a
>> ath11k to crash when it tried to delete the entries later. Fix this by
>> relying on mac80211 to delete the entries when appropriate and adding
>> them from the vif_add_debugfs handler.
>> 
>> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs
>> entries as appropriate")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218364
>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

This also passes my tests, thanks Benjamin. If there are no objections
I'll take this to wireless tree tomorrow and try to get it to v6.8-rc2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

