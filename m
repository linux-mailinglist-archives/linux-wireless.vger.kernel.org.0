Return-Path: <linux-wireless+bounces-10954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B89478CC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EE61F2157A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4D137C37;
	Mon,  5 Aug 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqx0Hgaa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3610953
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851811; cv=none; b=JMQafmb7pMmDopbQHkcpBV49Te0vA5AWLAnBAnfN9nTdRmgA2VCk9slrXw4dygAou4/y+kxzIe64aja589L26qDA9OUxzJUdx27+aIeIUiHKnRaIJB7nrpfs/4OMSqy2P/jN3QF4KqserzNqGVzq7FA3xDYINUUgUxR3AMvKp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851811; c=relaxed/simple;
	bh=kE/2fNW+HYfr/+/bFE8saaUkp5t2GeyDZLSLZcPFuwk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aKA/HElIHH74sbODdwJJAK2K3/kGusVel7L/3ad4S1ch1FW5nRj96TO+IOEbDlpF5LUlHypSj142C4bHAeltZuKtKR4oM291fcivbjRn9qM21oCZ4zvelnOXSzr7k1tHVK45ZJLetveM6prlEyTC8m1sUfgjNLwBmRO8r5mgFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqx0Hgaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EF9C32782;
	Mon,  5 Aug 2024 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722851811;
	bh=kE/2fNW+HYfr/+/bFE8saaUkp5t2GeyDZLSLZcPFuwk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aqx0HgaaGhpP+qdOXW40Hkbl4dFu32a+ESKECMNPTnXpJqVw4H2NqMtDXzZpaj20D
	 Z0UMLnl3YZ0OR0r9gPW/uVpHGjarfi8WvK6YK49ENj/ISgfROC6M/vqqSGR6HN9ePa
	 lCyLQjt/GH0vbnqHAz+eQbZgBdEP/PYic+WzbmKPuUu9smKaXTWi9wfuYg4rfK+z5r
	 TrzGK0x/kCslPqa6B3BYZ2HcvduJ0BJJw7ApCfeoFj22zK73pnXSUb11ravllKK0zK
	 POZ3LV2HrhfMNB1VTNtYAS7E6VTA3UodcXP/5qbQyu2oI5afJSrwgHEepArDsIU8/L
	 8ct9X/JDQ7THA==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
	<20240711165511.3100433-2-quic_ramess@quicinc.com>
Date: Mon, 05 Aug 2024 12:56:48 +0300
In-Reply-To: <20240711165511.3100433-2-quic_ramess@quicinc.com> (Rameshkumar
	Sundaram's message of "Thu, 11 Jul 2024 22:25:09 +0530")
Message-ID: <87frrj70nz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> From: Sriram R <quic_srirrama@quicinc.com>
>
> To prepare the driver for MLO support, split the driver vif
> data structure to scale for multiple links. This requires changing
> the use of arvif to per link and not per hw which can now
> comprise of multiple links.
> Also since most configurations from mac80211 are done per link, do refactoring
> of the driver functions to apply these configurations at link level.
>
> Split ath12k_vif which is the driver private of ieee80211_vif to store
> link specific information as ath12k_link_vif. For default use cases
> the ath12k vif will have a preallocated link vif called deflink which will
> be used by non ML and the first link vif of ML vif.
>
> With MLO Support to be added, remaining link vifs will be allocated during
> channel assignment where vdev create/start happens. These link vifs will be
> freed during interface down.
>
>        		Current ath12k_vif(arvif) structure
>
>              +---------------+      +---------------+     +---------------+
>              | ieee80211_vif |      | ieee80211_vif |     | ieee80211_vif |
>              | private data  |      | private data  |     | private data  |
>              |               |      |               |     |               |
>              |  ath12k_vif   |      |  ath12k_vif   |     |  ath12k_vif   |
>              |  (arvif)      |      |  (arvif)      |     |  (arvif)      |
>              |               |      |               |     |               |
>              |  +----------+ |      |  +----------+ |     |  +----------+ |
>              |  |*ar (2GHz)| |      |  |*ar (5GHz)| |     |  |*ar (2GHz)| |
>              |  +----------+ |      |  +----------+ |     |  +----------+ |
>              |               |      |               |     |               |
>              +---------------+      +---------------+     +---------------+
>
>        	Proposed ath12k_vif(ahvif) containing ath12k_link_vif(s) (arvif)
>        	(deflink is preallocated member which is always the first link if
>        	 ieee80211_vif is MLD and is the only link otherwise)
>
>        			+---------------------------------+
>        			|     ieee80211_vif               |
>        			|     private data                |
>        			|                                 |
>        			|   ath12k_vif(ahvif)             |
>        			|                                 |
>        			| +-------------------------------+
>        			| |ath12k_link_vif deflink (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(2GHz)     |      |
>        			| +-------------------------------+
>        			| +-------------------------------+
>        			| |  ath12k_link_vif *link (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(5GHz)     |      |
>        			| +-------------------------------+
>        			| +-------------------------------+
>        			| |  ath12k_link_vif *link (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(6GHz)     |      |
>        			| +-------------------------------+
>        			|                                 |
>        			+---------------------------------+
>
> To refactor existing ath12k_vif to make use of link vifs, following
> changes are made,
>
>  1. ath12k_vif now called by variable name ahvif stores multiple
>  arvifs(ah12k_link_vif) and also has a back pointer to ieee80211_vif.
>
>  2. In this patch set, only deflink is used to be on par with the
>  existing code. When MLO support is added the link id will be used to
>  fetch the arvif.
>
>  3. For mac80211 ops which doesn't use specific link_id, the config or info
>  is common for the vif, hence apply the config to all link vifs.
>  The links_map in the ahvif, will be used to identify all the link vifs that
>  are setup.
>
>  4. Change ath12k_vif_to_arvif() as ath12k_vif_to_ahvif() to fetch the
>  hw level vif. The link vif can be fetched from ahvif->link[], or the
>  deflink can be accessed via ahvif->deflink. API to access link
>  vif(arvif) by passing link_id can be introduced with MLO Support.
>
>  5. The ieee80211_vif can be accessed from ahvif using ath12k_ahvif_to_vif()
>
> Locking:
>  Currently modifications to members of arvif and arsta are protected by ar->conf_mutex
>  and it stays as such.
>  Now with these hw level structure (ahvif) being introduced, any modifications
>  to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>  needs to be protected for writing and ah->conf_mutex is used for the same.
>  Also, atomic contexts(say WMI events and certain mac_ops) that we currently have in driver
>  will not(shouldn't be allowed) do any modifications but can read them and
>  rcu_read_lock() is used for the same.

Please elaborate more about your locking design. Because of past bad
contributions from Qualcomm the bar is really high for adding any new
locks. I'm doing the locking analysis right now but it would help a lot
if you could provide your own analysis.

My first impressions:

It's really confusing to have two locks with the same name (conf_mutex
in struct ath12k_hw and struct ath12k).

struct ath12k_hw already has hw_mutex so I'm even more suspicious about
this locking design. That's not explained at all in commit messages.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

