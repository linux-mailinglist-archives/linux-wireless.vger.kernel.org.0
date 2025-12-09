Return-Path: <linux-wireless+bounces-29627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31FCB0FB1
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE5630CBB5C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E35304BBD;
	Tue,  9 Dec 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtlozrW/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909A26056E;
	Tue,  9 Dec 2025 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310202; cv=none; b=PMxxv8FNwjn0iliVd5uxnPH+kELHoDXBYE4Y+BMgH3iGbEVyq/QOo4gL+Z/aliRmzS+gy86ASPfHBApw2HJBUEi409v+W8mh6ixBiJWRqohsWMg8ro/Kd/Of8DjGne1xr55CPPAryZ6e1ThCQTpkA1huVfPbbIiMb1SHwk7uoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310202; c=relaxed/simple;
	bh=Dq6vVcM9EIHywsyjVDP17JBVvTmECn0e4FCYDopnSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lecNTAWPMyktibAMzSXzBVjKtyHNY/17POjBaoQp0S0tRYMo2Mo2hLAOmhR7He1IrIUFest46Vgi2Ql9BKXf9XAsE/c42RHXIKRH+YpcApPrZUattgZBcO559zuXcZ/Ta+zyfuEFSsHImnWjcxSQmebQhifrCUsz8oX3NZoIRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtlozrW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67528C4CEF5;
	Tue,  9 Dec 2025 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765310201;
	bh=Dq6vVcM9EIHywsyjVDP17JBVvTmECn0e4FCYDopnSo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtlozrW/QyLbuxYMECeTqRhMFLv3t3F8Z/yFhwQEQUEjzgKxaHuDdxuQJGS9/y4nx
	 DlN0zv1JCeWafL+5CvD1gSwCyCm4r3k5oKzhikRLW4NhuNgXgAM7VD1M9nYZvZ2T7i
	 JtNRg9XjBEy59++fNWESMZrca8gHgcpSJuypMv0VhKAFnxUw5c5AusnR3XbyW1KQmT
	 lg43NdBHFvTYX/7o+EvUtV9EPi/R+y9LhRFLvERGqmotQMF3Cv7mLIjUtvcFNS6lZb
	 Q5Ep3qXsH63zmnjVVpW9pR2LiU7UG3Czt1L6Za7HSPMe3YMCKwqyW7AEeJu/8CoVan
	 8mtt1TGJgfcZg==
Date: Tue, 9 Dec 2025 13:56:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	johannes@sipsolutions.net, jjohnson@kernel.org
Subject: Re: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci:
 deprecate 'firmware-name' property
Message-ID: <176531018921.1011228.15625154455386723373.robh@kernel.org>
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>


On Thu, 04 Dec 2025 15:11:00 +0800, Miaoqing Pan wrote:
> The firmware-name property was introduced to allow end-users and
> integrators to select usecase specific firmware for the WCN6855.
> However, specifying firmware for an M.2 WLAN module in the Device
> Tree is not appropriate. Instead, this functionality will be handled
> within the ath11k driver.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


