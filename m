Return-Path: <linux-wireless+bounces-20254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC6A5E1F2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FD63A4706
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76E1DACB1;
	Wed, 12 Mar 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNsr0Cee"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EEF1D9A5F;
	Wed, 12 Mar 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797841; cv=none; b=WyutPSpfHyqh2gbWmw/mcff50yi0BGW3O03Efpa3MEpwmE/dfsn/5tMwMEgM7X7shcFqapSf1pTFT2XNybhByd+kxsRKQooeGqwCq8lQzcyi7m9ZgLCycocHRgjEk9M9Lv+30H83S9iPCxqP+oDzCen/Bd8fcPUyDNGIs0nUFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797841; c=relaxed/simple;
	bh=aB+fKBf4e/39ssSV8LODysl3QPBeZYXnSlKp30KzAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUir0B/WKuSfS84VH9RawvxO+/Bwc3Yjtm6oZAraosVSYyNAUc9M/IOYAS2tC3zJ67eaNH/r3OxyDobdkhFEl4JzoZWxfDDYjzC53h8HYKL9P5r6zntHHHew6d9ZbXyWV6f8HB73MtkF4e9iiAYfaUJ1v4wQVbRVQ9aIzEAAfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNsr0Cee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDFDC4CEDD;
	Wed, 12 Mar 2025 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797840;
	bh=aB+fKBf4e/39ssSV8LODysl3QPBeZYXnSlKp30KzAZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNsr0CeeK8TEi2ixz6hiv8ukZO6THXnZBB204xkkMpBr+51bI3qaeLVf0S3ZL4q2e
	 GffB/uKwCOWF3uUavWusH7UUGxr4Y5PeICJ681WvjZrQjL5XSNae4P2z6z9eU5t+93
	 ZmXvMOWC7ofl5pV0+IiXVDJ0zwfrlslYE/FTNRDrVuxrA1FJNlm6GYKMmyziW6VJqU
	 gzLDvcoYe7+MvxWiBlg5jFtqf5NRX/m7w7KRuny++hEgkxayEDKDtLsUDF/3LYda/w
	 1Trb4hs5ae5DLM0weY7YCWUTJFrxiSW+tuP188/BkGg9AUuD/Z4/8sNKi0DgqVTAtz
	 qrK05t+pxByJQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tsPBU-000000008A2-3xed;
	Wed, 12 Mar 2025 17:43:57 +0100
Date: Wed, 12 Mar 2025 17:43:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>

On Wed, Mar 12, 2025 at 09:11:45AM +0800, Miaoqing Pan wrote:
> On 3/11/2025 11:20 PM, Jeff Johnson wrote:
> > On 3/11/2025 1:29 AM, Miaoqing Pan wrote:
> >> On 3/10/2025 6:09 PM, Johan Hovold wrote:
> >>> I'm still waiting for feedback from one user that can reproduce the
> >>> ring-buffer corruption very easily, but another user mentioned seeing
> >>> multiple zero-length descriptor warnings over the weekend when running
> >>> with this patch:
> >>>
> >>> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
> >>>
> >>> Are there ever any valid reasons for seeing a zero-length descriptor
> >>> (i.e. unrelated to the race at hand)? IIUC the warning would only be
> >>> printed when processing such descriptors a second time (i.e. when
> >>> is_desc_len0 is set).
> >>
> >> That's exactly the logic, only can see the warning in a second time. For
> >> the first time, ath12k_ce_completed_recv_next() returns '-EIO'.
> > 
> > That didn't answer Johan's first question:
> > Are there ever any valid reasons for seeing a zero-length descriptor?
>
> The events currently observed are all firmware logs. The discarded 
> packets will not affect normal operation. I will adjust the logging to 
> debug level.

That still does not answer the question whether there are ever any valid
reasons for seeing zero-length descriptors. I assume there are none?

> > We have an issue that there is a race condition where hardware updates the
> > pointer before it has filled all the data. The current solution is just to
> > read the data a second time. But if that second read also occurs before
> > hardware has updated the data, then the issue isn't fixed.
>  
> Thanks for the addition.
> 
> > So should there be some forced delay before we read a second time?
> > Or should we attempt to read more times?
> 
> The initial fix was to keep waiting for the data to be ready. The 
> observed phenomenon is that when the second read fails, subsequent reads 
> will continue to fail until the firmware's CE2 ring is full and triggers 
> an assert after timeout. However, this situation is relatively rare, and 
> in most cases, the second read will succeed. Therefore, adding a delay 
> or multiple read attempts is not useful.

The proposed fix is broken since ath11k_hal_ce_dst_status_get_length()
not just reads the length but also sets it to zero so that the updated
length may indeed never be seen.

I've taken a closer look at the driver and it seems like we're missing a
read barrier to make sure that the updated descriptor is not read until
after the head pointer.

Miaoqing, could you try the below patch with your reproducer and see if
it is enough to fix the corruption?

If so I can resend with the warning removed and include a corresponding
fix for ath12k (it looks like there are further places where barriers
are missing too).

Johan


From 656dbd0894741445aeb16ee8357e6fef51b6084c Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 12 Mar 2025 16:49:20 +0100
Subject: [PATCH] wifi: ath11k: fix ring-buffer corruption

Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
breaks and the log fills up with errors like:

	ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
	ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

which based on a quick look at the driver seemed to indicate some kind
of ring-buffer corruption.

Miaoqing Pan tracked it down to the host seeing the updated destination
ring head pointer before the updated descriptor, and the error handling
for that in turn leaves the ring buffer in an inconsistent state.

Add the missing the read barrier to make sure that the descriptor is
read after the head pointer to address the root cause of the corruption.

The error handling can be fixed separately in case there can ever be
actual zero-length descriptors.

FIXME: remove WARN_ON_ONCE() added for verification purposes

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: stable@vger.kernel.org	# 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..423b970e288c 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,8 +393,12 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
 	if (*nbytes == 0) {
+		WARN_ON_ONCE(1);	// FIXME: remove
 		ret = -EIO;
 		goto err;
 	}
-- 
2.48.1


