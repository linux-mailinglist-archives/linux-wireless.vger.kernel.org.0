Return-Path: <linux-wireless+bounces-17245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EACA078E9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 15:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCF47A4E73
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040A21A434;
	Thu,  9 Jan 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="RQSO3nzP";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="MlmHLJjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405621A422
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432095; cv=none; b=f3mR3KodU4WsS8YFJF7E1O1HCKhsOVXTKWDAxYKAnqdLGOywg3i0fZkx3v4wRvvv/nwlenwFM+bcvLbV/OMRppZF3225uLFiln8BGe7ArK4FUhpWPyPJrbMpZp2mhQ2YbEJlZP8SaoiDXnUeIWZ5YTlTpKZ7lpc340uFo+3zMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432095; c=relaxed/simple;
	bh=vyEMLclEiZl+B0nlmDQ+FeDI9kax3nmEGT+1QmRXWQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn4qTr3kV/sk73UQcqj44ApD3J7o5oPy4CmVZkriXXU+Vuu6VD/Xe2a34Inpi5+cfc+FNNz1IdU1g0LfS8EcB1Iz72ia53rO5uKsLfQ+yR3MVzgqQd95HO3Bs6EEo+LfOS2DG44Q+TpkyIUyyqRTuqXiJg8BtFTaigBDnfk6FlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=RQSO3nzP; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=MlmHLJjw; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1736431185; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=W81NM/aAsn0km28xNBRfVumWprgAsipiPyT2j51YIA8=;
 b=RQSO3nzPDmjV+rMXaIUVHG5hxEM7Fo4KjH2WfD2CADltvNdoh5Uj1fatFeWE7tXexwNrr
 zbOC2bw2nBHl8gAYwVXKRwZxv4tWLLM6n3kOoRZ6BDyAm+qFOJOQtGJj099XwHq/2Gt7Hyd
 MLiQA8KIt2GHQuyBoNpsAsggYMVjkQBk3dbWnaFAsZdWioMYFWa3XNIqDtQpD+5oOU8LXWE
 5vOgkOCCQ2ZIgEaQa00WH+h+DCV2Krhzic1Fd5BMgms6NHLTxt64HvPntb6OK8YvL2j+gyj
 4q8lFmuQ7CZ0E/AqaCVBcSnjCs6/VSYPk+rnvibHZEojRbVZUgVA2vazIM4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1736431185; h=from : subject
 : to : message-id : date;
 bh=W81NM/aAsn0km28xNBRfVumWprgAsipiPyT2j51YIA8=;
 b=MlmHLJjwi7QW90EQDZFKm4en5ltFyqGgFoe5mbaiF1g9/0kT3JZLS6QbRpV5Vr4qMS56D
 K2sTCxbdnAGBCjEtw/12exGAfIJP7oc6j9m301hJ/Lg5ywj08XGpBy0mvdxqtYE5e3kxLZ8
 ayZidOtvqzkHwi6Vv/mS+5mdfBjdEX+0OgJrTkVgD8887kssxPq5NRJccbRzbxTKIbyBgyV
 GIAUkoE3vL1CgcXjQFUS+W0kl4u4bEFRxyW+qYgbbaZs/+7tyVpLaWMeQdvpDKLWq/vwrFA
 khoKvYje+qV78F46XxNunbDg1RDEJlvCxEL+GCQRhqMaIf3Y5jg4xLEAcgmQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tVt4R-4o5NDgrjoLk-mRMC;
	Thu, 09 Jan 2025 13:59:35 +0000
Date: Thu, 9 Jan 2025 14:56:35 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	Cedric Veilleux <veilleux.cedric@gmail.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
Message-ID: <Z3_Vk6doGyavKSea@pilgrim>
References: <cover.1732293922.git.repk@triplefau.lt>
 <87ldvkdtqn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldvkdtqn.fsf@kernel.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sMuY_9l13u
X-smtpcorp-track: mubGJEY_p2Ut.rNwOfJYEFXC1.-ghhCwuUZh3

On Thu, Jan 09, 2025 at 03:03:44PM +0200, Kalle Valo wrote:
> Remi Pommarel <repk@triplefau.lt> writes:
> 
> > It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
> > radio silence could be observed followed by the error below on ath10k
> > devices:
> >
> >  ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
> >
> > This is due to how the TX queues are flushed in ath10k. When a STA is
> > removed, mac80211 need to flush queues [1], but because ath10k does not
> > have a lightweight .flush_sta operation, ieee80211_flush_queues() is
> > called instead effectively blocking the whole queue during the drain
> > causing this radio silence. Also because ath10k_flush() waits for all
> > queued to be emptied, not only the flushed ones it could more easily
> > take up to 5 seconds to finish making the whole situation worst.
> >
> > The first patch of this series adds a .flush_sta operation to flush only
> > specific STA traffic avoiding the need to stop whole queues and should
> > be enough in itself to fix the reported issue.
> >
> > The second patch of this series is a proposal to improve ath10k_flush so
> > that it will be less likely to timeout waiting for non related queues to
> > drain.
> >
> > The abose kernel warning could still be observed (e.g. flushing a dead
> > STA) but should be now harmless.
> >
> > [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> > [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> 
> On what hardware and firmware did you test this? As they can behave very
> differently knowing that is really important.

This was tested on QCA9888 hw 2.0 10.4-3.10-00076.

Not sure to see how a different HW/FW could have prevented that though.

-- 
Remi

