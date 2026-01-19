Return-Path: <linux-wireless+bounces-30979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 841BFD3BA08
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 22:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC40A300969A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB623B604;
	Mon, 19 Jan 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pZsbY9/l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547092236EB
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858386; cv=none; b=YgzD45n9OeBSzjlNnRf2Ab1D1uUtFF4VEKvbuuOQFVFGfv7KL4jK+Kuky8+/C0cbmxDqs3srNfy4wh8IHd0WuOXXactwADq26z5fmCHw5T3U0Ko+8nIQ0GbAdVBzhhGgU1YRQTvzoG9pGQUelBXlJJrXZ9bEiAuBrCyZK0HVVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858386; c=relaxed/simple;
	bh=8oQWoZ7Q+zZzaGw2k2EIKgVgPXXoy0g+IZ7fXp8XxNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ7z6gDu1hYjxGpULibLPvWGu8BdCwPYtrAYwBLBdWEtWZyKZiJBoeZwI3BHjVfPXkVAovp1h8x5HF9ouLK9sZN1rIH5BF6g4zegF1hPB5/2mMCTitB3XGxgIxQ/Es3JLCk6Fi96pdgyhhxXFpxGTwKpc3sd4tJJrSg/EcU5/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pZsbY9/l; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a28ff161-b417-46c0-b56b-d4cb6e11dc48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768858382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85T4LKKp4AM9DPzqBSjlAynKdfYbv5/ZBLnLYV6vWjw=;
	b=pZsbY9/lzitryFRG46wLk+ArgG3J2+NfVzRZ6wFW8F1fQqh9ZR1M6UoTAjjNloxNQy9PhY
	domM2cgfNucwMjQtALHZnoxyBg7Dddssez2bsaRIk5eqGut8sK+m15JQWRnXslXLvvQMUq
	NZYW0/qGLEwU1A31zGOJvLYiGB2Yj5s=
Date: Mon, 19 Jan 2026 21:32:58 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP
 removal
To: Junjie Cao <junjie.cao@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
 Avraham Stern <avraham.stern@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>,
 Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
 Luca Coelho <luciano.coelho@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>, stable@vger.kernel.org
References: <20260115161529.85720-1-junjie.cao@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260115161529.85720-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/01/2026 16:15, Junjie Cao wrote:
> iwl_mvm_ptp_remove() and iwl_mld_ptp_remove() call
> cancel_delayed_work_sync() only after ptp_clock_unregister() and after
> partially clearing ptp_data state.
> 
> This creates a race where the delayed work (iwl_mvm_ptp_work /
> iwl_mld_ptp_work) can run while teardown is in progress and observe a
> partially modified PTP state. In addition, the work may re-arm itself,
> extending the teardown window and risking execution after driver
> resources have been released.
> 
> Move cancel_delayed_work_sync() before ptp_clock_unregister() to ensure
> the delayed work is fully stopped before any PTP cleanup begins. This
> follows the standard pattern used by other Intel PTP drivers such as
> e1000e, igb, ixgbe, and ice.
> 
> Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
> Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

