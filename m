Return-Path: <linux-wireless+bounces-9934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D47592661F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27757282F88
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6002BD19;
	Wed,  3 Jul 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBQo1wK7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959E17C7C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024108; cv=none; b=W2B8JpCHpuQMyhMbltUSKu6zZg65jc7H2afE9XFz/LKe9baOdnNuAubi0U8EqPvOsbNxY9KP2XprKORybeRTlqeJxNEPMrHdlRh+mmvFfaYOkONmFMceWnrUqADQyN53cSN+w2Cef+AIX9UQ5D8PKeyvu+ULn5pBdFOfceu84K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024108; c=relaxed/simple;
	bh=JkAcz5kIc6nLWgxw60e44YUTFyAuUCAwVALGXMhvrLg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FSgbL4hQy6AET2A3e+eBaiAbeHkevWxcPnOKdVgVqxT36sqcTSCus8B3Vqjy1gg/eTZ2hUNeqSYyvQ4orgzPWsClpjCymh/1mu2PF/O8Jt/V++NbHmK2O2dKJ5sI1IrBQpZsuLByfEAk27akqnwM53YtS7dw+xLDC8QUH9xPbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBQo1wK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71385C2BD10;
	Wed,  3 Jul 2024 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720024108;
	bh=JkAcz5kIc6nLWgxw60e44YUTFyAuUCAwVALGXMhvrLg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DBQo1wK7TyFynKUVl7/4XDE7hXaARLW022bOfaxMVOzwJOKwEEa79onqpyQuxuoRr
	 uOVxRxXVILqNHhanvBd/5u8dpHQfHhHbfTC1xBz4yKb9tEr8njQ33rqQWmVQ+eNgv1
	 V2wGVTVQkniHdXTA0Xc9uZvzd7dtse2p+nUs2rMdouQKcN8XUasv9B1PO6kR5uC7im
	 VAePHcT0M6dlR9dM6LFmfZVW14P5CYX4sS/81ED+0TnkxI5VxABtUy9A4DsyyMJNd2
	 FutGLeIfdhWbbWRd6Rj6x4+PUaenXliUoe7o23jctNZL+K/n9Dj5QNccQKZNZdQgXT
	 4Ue9jsIdO0tvQ==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v8 7/8] wifi: ath12k: refactor core start based on
 hardware group
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
	<20240531180411.1149605-8-quic_hprem@quicinc.com>
	<87plsuql2y.fsf@kernel.org>
	<dd2488bb-43f9-d546-7617-2a54ca3d1a1d@quicinc.com>
Date: Wed, 03 Jul 2024 19:28:25 +0300
In-Reply-To: <dd2488bb-43f9-d546-7617-2a54ca3d1a1d@quicinc.com> (Harshitha
	Prem's message of "Fri, 7 Jun 2024 19:19:09 +0530")
Message-ID: <87ed8ae8ye.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

>>>   +static void ath12k_core_device_cleanup(struct ath12k_base *ab)
>>> +{
>>> +	mutex_lock(&ab->core_lock);
>>> +
>>> +	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
>>> +		ath12k_hif_irq_disable(ab);
>>> +
>>> +	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
>>> +		ath12k_core_pdev_destroy(ab);
>>> +
>>> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
>>> +		ath12k_mac_unregister(ab);
>>> +		ath12k_mac_destroy(ab);
>>> +	}
>>> +
>>> +	mutex_unlock(&ab->core_lock);
>>> +}
>> This patch is just abusing flags and because of that we have
>> spaghetti
>> code. I have been disliking use of enum ath12k_dev_flags before but this
>> is just looks too much. I am wondering do we need to cleanup the ath12k
>> architecture first, reduce the usage of flags and then revisit this
>> patchset?
>> 
> yeah., more dev flags :( but flags were needed for the race conditions
> when multiple devices where involved in a group, some devices would
> have completed till pdev create some might not. Some crashes were seen
> because hif_irq_disable was called for a device in a group but that
> device was not even at the stage of core register. Will check the
> possibility to  reduce the flag usage but it seemed necessary for
> multiple device group clean up.

I think the core problem here is of mixing enum ath12k_hw_state and enum
ath12k_dev_flags, it's just a mess even before this patchset. For
example, these flags look like they should be part enum ath12k_hw_state
instead:

	ATH12K_FLAG_RECOVERY,
	ATH12K_FLAG_UNREGISTERING,
	ATH12K_FLAG_REGISTERED,
	ATH12K_FLAG_QMI_FAIL,

If we have an enum plus set of flags to handle the actual state then it
will become difficult to manage it all. Instead we should just have the
enum for tracking the state of the driver.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

