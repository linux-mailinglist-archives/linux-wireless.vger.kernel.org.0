Return-Path: <linux-wireless+bounces-20486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3309A66D37
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBF33BE474
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430ED1DE4C9;
	Tue, 18 Mar 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbL8ixVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E738FA6;
	Tue, 18 Mar 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284825; cv=none; b=u5EW0TJpBVRmwUUuIVQMVuE6xMkgnsFByA2Z935RJQfajHAYGI6SFDv1mU7S3g4UERWo2iLI+Scrl9iE7ShCKnGgO9wd+buuySDkK0j+6OCYCbZmDZanUuYfKxAHe6vh8pUAo93rOQx7pjzBoLl54X2kPAQcK7/n2dJNgH03HHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284825; c=relaxed/simple;
	bh=q0iAie+/ac8TF5bdE35fwcBMcem45zb0jJnV1wd8xi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddDPp9TVgK+iR0upQ1d2I2A5GSzk9+RZwzzozQJaWVMlaCzuu8+hoDehW0eAUGgG1PMDO9lh65TShb6XopZC+u7oCRdIP9ZIHY56BteffOB+/x8eXkUU62v0LIQ2amlvEG5Q2zXH+lmsdBkdNEJSk9ascuIKVcQYPP7Wxc2CLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbL8ixVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD686C4CEE9;
	Tue, 18 Mar 2025 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742284824;
	bh=q0iAie+/ac8TF5bdE35fwcBMcem45zb0jJnV1wd8xi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbL8ixVCaLmi0JhXDNy7BmPTWxoFvHxUXC2b4VUE0DbnT0l/ZgkzsNGozV+WdM3FN
	 Vj0Kt1acewQ71BM9re0gsKaqQiRUbGoShdF3B7i8qznckuOOF6af0CZfo9nOXZ39TO
	 rLovjZvjmDwFpjV53d6zqobyS3S8kWvzMwRsLlV8c9oKoEAMQlbXtSQpSMk37yYsNW
	 5i/l6RycOh+66MuaYqNnH0WcKgva6oQTPud7fWijAXjMGPBuAQCuOgexfkk5jlFOSI
	 B5TNhAVhy4EMiOQiO2exhSBYBokUehhBMGFLCjPA4/fxofyuSENb5orO3MysFaItvi
	 yub9cagFWkRYg==
Date: Tue, 18 Mar 2025 09:00:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ath-next v11 00/13] wifi: ath12k: add Ath12k AHB driver
 support for IPQ5332
Message-ID: <20250318-splendid-sceptical-gazelle-8abbef@krzk-bin>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>

On Tue, Mar 18, 2025 at 02:16:26AM +0530, Raj Kumar Bhagat wrote:
> Currently, Ath12k driver only supports WiFi devices that are based on
> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
> Ath12k AHB support for IPQ5332.
> 
> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
> device:
> - Add hardware parameters for IPQ5332.
> - CE register address space in IPQ5332 is separate from WCSS register
>   space. Hence, add logic to remap CE register address.
> - Add support for fixed QMI firmware memory for IPQ5332.
> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>   AHB support.
> 
> NOTE:
> The working upstream DTS changes for this series have been posted as a
> separate series.
> [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based RDP441
> 
> v11:
> - Updated Kconfig for ATH12k AHB.
> - Replaced the API devm_ioremap_wc() with devm_memremap to fix ath12k-check
>   warning: "warning: cast removes address space '__iomem' of expression"
> - Rebased on latest ToT.
> - Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
>   patch [11/13] wifi: ath12k: Power up userPD


This is v11 and still sent in a way it messes with toolset:

  b4 diff -C 20250317204639.1864742-2-quic_rajkbhag@quicinc.com
  Grabbing thread from lore.kernel.org/all/20250317204639.1864742-2-quic_rajkbhag@quicinc.com/t.mbox.gz
  Checking for older revisions
    Added from v10: 14 patches
  ---
  Analyzing 135 messages in the thread
  Preparing fake-am for v11: dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
  ERROR: Could not fake-am version v11
  ---
  Could not create fake-am range for upper series v11

Can you fix your process so the tools will be happy? Please read
carefully your internal guideline go/upstream before posting next
version.

Best regards,
Krzysztof


