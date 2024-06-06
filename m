Return-Path: <linux-wireless+bounces-8611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F48FE79C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128501C23654
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F10196C65;
	Thu,  6 Jun 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6AGzlym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A51607B2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680041; cv=none; b=Y+XQW8eJmy5eF+D84MO/CkP81du8qCvK8UEb/8+omKeQGHuVnLgGr6y5R9gXCC4rAlA1Fy7lqjaRlS+XOuX3hF76aeP+Zl3MTULRWAUZq7j0F9c+3uzvKQlyfuqp5S68Ep/TKNYQoBrKwJ3N/PMwFEGA2r8JkieYAjyG9cFupr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680041; c=relaxed/simple;
	bh=p1e4aBHZ3YsRU1nPl3dRfnOZbbOmwhj+LhrDGnUEJMk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KuyQHUWa74pEMXN6Oh/xMUwQ0km2bffsUZHscVH/1G++TZtTk+1gchgnkDTPKZHwlBqOSRvX31oRbdmGsa7dDka6W6degd7JWt0pWlb2ZjhgRzlq5G6CeQbLe/r0nhF8iRWsTRDWJoaf4ZGNkic/6+HNyBY/I5oCPrbxl3mkC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6AGzlym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCBCC2BD10;
	Thu,  6 Jun 2024 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680040;
	bh=p1e4aBHZ3YsRU1nPl3dRfnOZbbOmwhj+LhrDGnUEJMk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=s6AGzlym0r58jnIRrUSMF7IFB4ZSvYnsCzoMLwCUIPY6GkCeYPnJ5xNi9uJLRTWIN
	 On5tkRLsrl1JcKJwcq34jHjWSxVs4518r3DTj5w98peESmlSe30d0l23TDcyXKtBxY
	 dwM8i1ivk6UmGXXIdsRH8UptWMOu+BCv5974UfizoWZinoiMJBmQ2ONEzq27Paexy4
	 DfB+wvg8+q7UHR4+YfhMfcKAA9nFRsh4QRTgOfC9asR0vofLbE3VIxzpWkLoN8HgMx
	 hYJRNdzTXi2TQZlKRFHFQpheH6Xy2m8Fexs3A/I53AQOWnxZ7TROJNfSNCCYSBwIeZ
	 RNcpyCHoDtvUw==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v8 6/8] wifi: ath12k: Introduce device group abstraction
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
	<20240531180411.1149605-7-quic_hprem@quicinc.com>
Date: Thu, 06 Jun 2024 16:20:37 +0300
In-Reply-To: <20240531180411.1149605-7-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Fri, 31 May 2024 23:34:09 +0530")
Message-ID: <87le3iqkbe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>
> Currently, single device is probed and once firmware is ready, the device
> is registered to mac80211. For multi-link operation, different bands of
> different devices or same device would be part of a single wiphy and for
> this, hardware device group abstraction would be helpful.
>
> Hardware device group abstraction - when there are multiple devices (with
> single radio or dual radio) that are connected by any means of interface
> for communicating between them, then these devices can be combined
> together as a single group using a group id to form a group abstraction
> and register to mac80211.
>
> The grouping information of multiple devices would be based on device tree
> during device probe. If no such information is available then a single
> device will be part of group abstraction and registered to mac80211 else
> multiple devices advertised in device tree are combined and then registered
> to mac80211.
>
> For device group abstraction, a base structure named ath12k_hw_group (ag)
> and the following helpers are introduced:
>         ath12k_core_hw_group_alloc()    : allocate ath12k_hw_group (ag)
>                                           based on group id and number
>                                           of devices that are going to
>                                           be part of this group.
>         ath12k_core_hw_group_free()     : free ag during deinit.
>         ath12k_core_assign_hw_group()   : assign/map the details of group
>                                           to ath12k_base (ab).
>         ath12k_core_unassign_hw_group() : unassign/unmap the details of ag
>                                           in ath12k_base (ab).
>         ath12k_core_hw_group_create()   : create the devices which are part
>                                           of group (ag).
>         ath12k_core_hw_group_destroy()  : cleanup the devices in ag
>
> These helpers are used during device probe and mapping the group to the
> devices involved.
>
> Please find the illustration of how multiple devices might be combined
> together in future based on group id.
>
>                 Grouping of multiple devices (in future)
>
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+

This is a good diagram, thanks for that. But how does struct ath12k_hw
fit into the diagram?

> In the above representation, two devices are combined into single group
> based on group id.
>
> Add base code changes where single device would be part of a group with an
> invalid group id forming an group abstraction. Multi device grouping will
> be introduced in future.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Like I have said before, for adding any new locks there needs to be a
proper analysis for the locking and good justifications why new locks
are needed. I don't see any of that above.

BTW I will from now on require proper analysis also for additions to
enum ath12k_dev_flags.

> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -21,6 +21,9 @@ unsigned int ath12k_debug_mask;
>  module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
>  MODULE_PARM_DESC(debug_mask, "Debugging mask");
>  
> +static DEFINE_MUTEX(ath12k_hw_lock);
> +static struct list_head ath12k_hw_groups = LIST_HEAD_INIT(ath12k_hw_groups);

I can somehow understand/guess why this mutex is needed (even though
there's no documentation) but the naming is not really clear as we
already have struct ath12k_hw::hw_mutex.

> +/* Holds info on the group of devices that are registered as a single wiphy */
> +struct ath12k_hw_group {
> +	struct list_head list;
> +	u8 id;
> +	u8 num_devices;
> +	u8 num_probed;
> +	struct ath12k_base *ab[ATH12K_MAX_SOCS];
> +	/* To synchronize group create, assign, start, stop */
> +	struct mutex mutex_lock;
> +};

But why we really need this mutex? And does it really justify the extra
complexity it creates?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

