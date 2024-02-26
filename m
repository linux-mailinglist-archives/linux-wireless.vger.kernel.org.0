Return-Path: <linux-wireless+bounces-4004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F11938671F4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0481C21DC1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091F56743;
	Mon, 26 Feb 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH9ZnHw9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9756742
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944341; cv=none; b=YRhhGKEkj1af1+FHt9wYBjVjXVZguCiGmLNsHSrEze/OCyrY3ooKVGmZ7gItn+8m65RIvQg3rci+3apQDzWP7TwLVntPAZwx5yKOdrwBZqkzM/jCT4AiLxQegKHXgMCrYZpg70iQJOz8TrYBdpF2N4efTrmXyQ4mdPCZSVApnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944341; c=relaxed/simple;
	bh=ypJbOTquQXZ2hbU4PVAHyt/Olgkjp1gpiGx1r5vbjQY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gMJ3rlDb9vMMobydlMPYe8/opwOetd3A3OUYpRbqAYOOMfF9gt51/6+rDcWEGjochw5RnZqN9De8tows6814npcoRPTVJKbgLBBpfRCLlxpyG9DDslcYuOIp3AxJx9DVCN+or2hkh7EV/RXtd1sklQTB/mi+hnQsIF8pBj5wFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH9ZnHw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B29C433C7;
	Mon, 26 Feb 2024 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708944340;
	bh=ypJbOTquQXZ2hbU4PVAHyt/Olgkjp1gpiGx1r5vbjQY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SH9ZnHw9CyL3pjRvThozbJOjG2Yn27xzP+zRcI80M+gurpSsL+MQ7NRQG8aGTXmB9
	 uEpAlB6rW34FOW4KFiiYNjBqbT0Sg/sKQWR4kvqVdNQ5tIEk3FRj0U+EapwUkoat55
	 QdDWtmAWSL2r8dmjEKbPOAXgyKAR5TNXPTS5irMazbg+8ouEFnzQ+NHCbpnbpR4Iff
	 zWn483aSpYLu4lEtO62o6O1kxjJ2KWbLnETdON7K4NY5WTwNgxM4TlpsLed1q9o0lk
	 8KydPqDSdnGamdl5eaMnZC1kmVa5TfOtk46ju4GcipUPnctVijWLHUV8QWcudSOJH4
	 swu6H7yOiI4Lw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath10k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath10k: poll service ready message before failing
References: <20240221031729.2707-1-quic_bqiang@quicinc.com>
Date: Mon, 26 Feb 2024 12:45:37 +0200
In-Reply-To: <20240221031729.2707-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 21 Feb 2024 11:17:29 +0800")
Message-ID: <874jdvld0u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently host relies on CE interrupts to get notified that
> the service ready message is ready. This results in timeout
> issue if the interrupt is not fired, due to some unknown
> reasons. See below logs:
>
> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
> ...
> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
>
> And finally it causes WLAN interface bring up failure.
>
> Change to give it one more chance here by polling CE rings,
> before failing directly.
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>
> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros
> 802.11ac CQA98xx devices")
> Reported-by: James Prestwood <prestwoj@gmail.com>
> Link:
> https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

[...]

> +		/* Sometimes the PCI HIF doesn't receive interrupt
> +		 * for the service ready message even if the buffer
> +		 * was completed. PCIe sniffer shows that it's
> +		 * because the corresponding CE ring doesn't fires
> +		 * it. Workaround here by polling CE rings once.
> +		 */
> +		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
> +
> +		for (i = 0; i < CE_COUNT; i++)
> +			ath10k_hif_send_complete_check(ar, i, 1);
> +
> +		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
> +							WMI_SERVICE_READY_TIMEOUT_HZ);
> +		if (!time_left)
> +			return -ETIMEDOUT;

I think it would be user friendly to also print the end result for the
polling, for example something like this:

if (!time_left) {
        ath10k_warn(ar, "polling timed out");
	return -ETIMEDOUT;
}

ath10k_warn(ar, "service ready completion received, continuing normally");

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

