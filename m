Return-Path: <linux-wireless+bounces-26324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC206B22DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC48B3B59C6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EF2F8BF9;
	Tue, 12 Aug 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMms5c9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02D305E26;
	Tue, 12 Aug 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016024; cv=none; b=THLrGC2PcvS3/FCrS5NxYSkx4piNp46dU2S+kME15lnpKEPv+GpzzLXPsIrjthPHs+Yednif04JX6W287UvdwkOpiJn7V1OPGZYQgf/2Rmg30bb+BDtjV1s1tBVocputq8FI8M0rN1gTOK3uiDWBz+/UcJhWq7Kf4V1g6/ZqF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016024; c=relaxed/simple;
	bh=SgiOIo0+U4m4CywXjwqcS9SUXLMQx+94iYxhv5zSRsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz9m0bj6cAJDpsR+QBVl4dymZmzPUrAa5VqBAEGKj6xn8jvkasjoz8bjfCHnff6uSTaOUtqthVwSHyVS35MRaejj7HE6dJjJfEXhOFl1mqYt6/7E38rushMTnJMWrsSHVn1oWNz/lYADzzuCq6ZCfJkjgVKF2swjWqzvsWY+iqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMms5c9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A32C4CEF8;
	Tue, 12 Aug 2025 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755016023;
	bh=SgiOIo0+U4m4CywXjwqcS9SUXLMQx+94iYxhv5zSRsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMms5c9Qi4DHUwgY+Aw7KJLEV9yTjvxrFpsuZPx+ShTdFzHOki5+WybI+mPNMu+Ob
	 N/539NLmMcc1FBQUfaPVfLPmsiercNs6laHW35vGZ6y9gquFv/K9XEwuMAxZtuhmIi
	 l8OWmP5k9sqpuRL6gS4exGypqsPHCoe3Ll/w9mP4=
Date: Tue, 12 Aug 2025 18:27:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, Gregoire <gregoire.s93@live.fr>,
	Sebastian Reichel <sre@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: Stable Request: wifi: ath12k: install pairwise key first
Message-ID: <2025081240-trustless-secret-1354@gregkh>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
 <053a7887-c08d-4272-8ada-cf4a008894f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053a7887-c08d-4272-8ada-cf4a008894f9@oss.qualcomm.com>

On Tue, Aug 12, 2025 at 08:58:52AM -0700, Jeff Johnson wrote:
> Stable team,
> 
> Per https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> Option 2 (since the patch was merged before being identified for -stable)
> Please consider the following for -stable
> 
> subject of the patch:
> wifi: ath12k: install pairwise key first
> 
> commit ID:
> 66e865f9dc78d00e6d1c8c6624cb0c9004e5aafb
> 
> why you think it should be applied:
> This issue impacts all products that use iwd (instead of wpa_supplicant) for
> WLAN driver management
> 
> what kernel versions you wish it to be applied to:
> All LTS kernels from 6.6+

It only applied cleanly to 6.16.y, so if you want it backported to older
kernels, please provide a working backport.

thanks,

greg k-h

