Return-Path: <linux-wireless+bounces-9621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F30918EB1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 20:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E67CB2110D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35F19047A;
	Wed, 26 Jun 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="untwMYFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F918FC85;
	Wed, 26 Jun 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427175; cv=none; b=FBd0bmbBu2j8FPGaJbLI4VoowPggo1aCav+4YmYWFRjhLXnF2+v9nHVE23x6WsDlfrmO7vR7Q75bAFrjJcELQuSpjm6UCeIYgOuxib55Ux+wj9qOt3Xa6kG49bUHtDS3W0pdf3U073XaZpBn4T8eEJjLeEXMg2hP06xa6F+queI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427175; c=relaxed/simple;
	bh=MlvAd6iA55Y5PL1ah9HFBbBqP2U1yvHevg8uPBUv1x4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IyziD+YN4uiTpPly3To8b0N/v+XFt6Jw8ulB4IXoqPF5bYHG849rfkJ1VEkS8V0ZgqRPXHZJisa8qjzfmZVIa7A66XsJNylYLSS5l+VY29Se0CcCjhpKO+uOhnw3Q/XTFkIQVvGhmVmVX07+Y0wPpxJ+oS949+xYi3oeSdZ4SNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=untwMYFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13143C116B1;
	Wed, 26 Jun 2024 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719427175;
	bh=MlvAd6iA55Y5PL1ah9HFBbBqP2U1yvHevg8uPBUv1x4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=untwMYFV8RNpIuqnQGZdceNnuAvmJt2CtTQ/otHkDnSLmEY8GdUDDzAnTMhOhM/zo
	 heShVoQhzrQVu1Gq93sxlasOgc7wVQOI4JfNn2z4OvGDsIBWh27RFl+ZnpyOBHFzHG
	 MmFKHaNiDuiLj3elwWKXli8+RyuongMqfFupNWduzTwlQdpz8/r4fKGJsp5WwGT8N1
	 zbbKa1zjBgeZxHyZKVd+2oVH3J3rAA6QvDaKj8tdZR6WkiCydPWXki+8u+nUpvV/mj
	 2y3a+aB63rLTtkmv9VJUzADuSQjziuNLZDLDqAplZhe4T6kvICXV4OoA/0nOcWI8eq
	 34/s9S77ZqnQg==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Allow driver initialization for WoW
 unsupported devices
References: <20240626024257.709460-1-quic_ramess@quicinc.com>
Date: Wed, 26 Jun 2024 21:39:32 +0300
In-Reply-To: <20240626024257.709460-1-quic_ramess@quicinc.com> (Rameshkumar
	Sundaram's message of "Wed, 26 Jun 2024 08:12:57 +0530")
Message-ID: <87r0cjh7kr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> Currently during driver initialization, mac registration is allowed
> only for devices that advertise WMI_TLV_SERVICE_WOW, but QCN9274
> doesn't support WoW and hence mac registration is aborted and driver
> is de-initialized.

I changed the title and this paragraph to describe more that we are
fixing a regression here.

> Allow mac registration to proceed without WoW Support for devices
> that don't advertise WMI_TLV_SERVICE_WOW.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Cc: stable@vger.kernel.org
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")

Luckily commit 4a3c212eee0e is only in ath-next, and not in any other
tree yet, so no need to cc stable. We need to cc stable when the bug is
in any of the official releases (v6.10 etc). So I dropped it.

Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=dbe2f0503e5fa9394e6b4e4f442adae89cec4cc7

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

