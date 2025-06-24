Return-Path: <linux-wireless+bounces-24414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88162AE5F5B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953B94C1C22
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36525B1EF;
	Tue, 24 Jun 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uThBQTZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B19258CE7;
	Tue, 24 Jun 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753787; cv=none; b=EyyQ92fPMWDPX7kMxrjecmjcnyI65acKryJqipPnw/xKEiykwJZ6oHTtV/XbRC/h62cxG8XyWmjU4QZXPtPqbUSbobe+r/+OOvDQ2NIBVGeD5jYZ59nP62X/HIoN3niuK6kE4Qw22eO2A6Ebs7d9nZLHGcBpJHxAgwZzFtaWO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753787; c=relaxed/simple;
	bh=NNre+qgBo2HMN8+Jr1S9NOMmw/QauNCu9wYpQKdLzfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnestsjzpM6vPe6mHmaKjCf9GnG7aL2WQU/7BXXIfQgI8kxpqtN2gyBQj+3Zjfc+TJQu/upTCwHOrkGOv/edSHsLWEUXP/tH1aa0QhC2MNUcngAkBNe4f8oErc+f2j6H1wqubj49pEXoaxvjFMIVsJCTrHlXRXfktDhgCjccac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uThBQTZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF67C4CEE3;
	Tue, 24 Jun 2025 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753787;
	bh=NNre+qgBo2HMN8+Jr1S9NOMmw/QauNCu9wYpQKdLzfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uThBQTZb8Re7UbI1Jb3i7eOkV3cW+lkM/3iz4taJ7Lh2nEFBZag1E1gvpNF7kAPuE
	 SeO7OLsSRqtCauYeizx2bGip5VQKYuIWxK+U7O5YGxEi9nUVGDv9T1UvyMVjCBNEuP
	 xKMLyL6GTT/n8or4/+sJ0jxDkxAA3AYHO0I3cgR4Fx5LRJzzKQegnS77vdjDxduT1U
	 SuS7T0aQGOlhQ3Z7zlBT9gC4+ATo54f/ANL/jp/mx1XIx4HXtW2Bckvzrp3pbPbuBN
	 MjIjn6rcS80D3P9aAYjUwBS/Wz8dTj4+aCCpnv7bK01fj9+RHfxzuCKfzbEsEnSEjx
	 hQ9E2sIBwQg7w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uTz2H-000000005KK-09sW;
	Tue, 24 Jun 2025 10:29:45 +0200
Date: Tue, 24 Jun 2025 10:29:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
Message-ID: <aFph-apaQ2y7piRX@hovoldconsulting.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <51da74b0-d8d3-4520-9fc9-06b50b552bb2@quicinc.com>
 <08a310dd-6982-4e63-9f6a-02bd9d579167@oss.qualcomm.com>
 <5b77ff7e-13c9-4083-9273-b8d3050e5116@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b77ff7e-13c9-4083-9273-b8d3050e5116@quicinc.com>

On Tue, Jun 24, 2025 at 10:11:29AM +0800, Baochen Qiang wrote:
> On 6/23/2025 7:30 PM, Konrad Dybcio wrote:

> > [    7.669494] mhi mhi0: Direct firmware load for ath11k/WCN6855/hw2.0/amss.bin failed
> with error -2
> 
> Thanks, this helps understand the issue.
> 
> And BTW, WLAN firmware is missing in your setup, you may get them from linux firmware repo
> to avoid this issue.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

This is still a driver bug that needs to be fixed. I just sent a fix a
here:

	https://lore.kernel.org/lkml/20250624082022.15469-1-johan+linaro@kernel.org/

Also note that there is no board file for the CRD in linux-firmware
(yet, see [1]), but apparently that is not enough to cause probe to fail
(unlike completely missing firmware).

Johan

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216036

