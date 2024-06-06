Return-Path: <linux-wireless+bounces-8627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BF8FF1BA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638FCB32121
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F3197A88;
	Thu,  6 Jun 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyGGc5vV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5C19307E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689509; cv=none; b=hyQwts2/sSi/9U4iAZ3tTb/0/9F5tMwAWmMT4OJsW6y5mqUfFPUNF0N03Q7pusLDlWywAB1hfLsj1JmEb4EZD0tfC7nJ78uA36xxlO8nXOM8PboOUhjhCo5mm1QAKfxh+/Aac9DAesfNptY/MLaRKmav+UPxZAu0yStz/ynVccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689509; c=relaxed/simple;
	bh=x4LkoXUC1lOHnZKMT6+/MzqqhBtpIKox2EqW2nwl8is=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JVez6eWAlthJk4Ks17fy2oHg9lo5naTaIJ6zEvp1pZMaI43l1ELVuE8pTAQfl3KZDj25psSgsUPXUdHyUPexogxR4YhwIC8abtiq1jZHal20XMsto04IipvZabU3UTztNNPuqZJl4f7eXiLQqqDlV24HjZvrQsNx+sbcnExBYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyGGc5vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CB2C2BD10;
	Thu,  6 Jun 2024 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689508;
	bh=x4LkoXUC1lOHnZKMT6+/MzqqhBtpIKox2EqW2nwl8is=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OyGGc5vVuONRSFWsNZqZrovUyE0LbotcGuztP85NBRVqCO/cKwOmGQaAFPXiCkgzY
	 4uBih+rKJgalL9l3xVE86jEq0buml/7+uCwQ1Sr4pHtRJpjqihum+vJxZMoWl+ATpQ
	 I5Uygk06eu2nIuvcJH09EUc5epqNIlTgsyLGZw+1KuBSYyVWsyhHozUuR/QLG7U/JR
	 +xY1FgP5yydnddVgILE7FAv+FvNCWWcKrrFUyn6taDg2647c8bFUEP64tBEf5zQdUM
	 sqblzaUv/b7oQjEfdlOgSXg4/9mbMrpdYOjviH3bHj2qBhDguPsSUKaju7pfJZFGpW
	 QVDwfV7dAqiSQ==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v8 6/8] wifi: ath12k: Introduce device group abstraction
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
	<20240531180411.1149605-7-quic_hprem@quicinc.com>
Date: Thu, 06 Jun 2024 18:58:25 +0300
In-Reply-To: <20240531180411.1149605-7-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Fri, 31 May 2024 23:34:09 +0530")
Message-ID: <87wmn2oyfy.fsf@kernel.org>
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

BTW I'm not sure if Device Tree is the right approach to configure the
groups. For example, that would mean that systems not using DT would not
support MLO at all, right? And also it would not be very flexible to
change the group setup.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

