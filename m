Return-Path: <linux-wireless+bounces-24609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E68AAEB041
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE77A16CE47
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277F21B9E2;
	Fri, 27 Jun 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHT+f6H7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFA218E96;
	Fri, 27 Jun 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009991; cv=none; b=tjfxqDhNOzxPgFM3LOUq9h5i4VDvfgklpzE7oaFeipZ1CuXqO42NSwBLr3Cbtuv/in8euQmDVE8CuHkd7nooLmCrSSA3xya+nRRGTPaIfX8m1xbu5UlPKpvPHqUtQXwQ3MvtpbuMk6BvXlDj1O/2MzQqGTUe59ekRw4iRQkS93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009991; c=relaxed/simple;
	bh=Vr3ciGbUBECVXTyaRD7kyJd4xFPIaK8NPuTFXbZGnZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXgkI0oarlPBbcDqpkBOuJIo0t8oQxDa5aoaB07oioHQlWqeWSxW+eQ417tHQe06cJr0Z/B3wrQVV23z5VpnGXWt76vXD8F5wtrK4lTyx/W9u2NcwJFElVKr4f60mSbObr8i5Xail6Wz93n6sSnhjWLIfejqWYFHLirlqCOdIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHT+f6H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4D1C4CEE3;
	Fri, 27 Jun 2025 07:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751009990;
	bh=Vr3ciGbUBECVXTyaRD7kyJd4xFPIaK8NPuTFXbZGnZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHT+f6H7BOh5vJA8ftR/Qoz65ardOB+vyVzODm+a5FQqvBzQo1KrQpN9NU2sR5w4a
	 Lyh02Y/UNxwtoUPgP4gmq16d8DTowNj1V0yPopOvInLFoT8f+GVi+3fcW4ywNFv2bl
	 Xxt6H9apxCFO5I8y5lefaZaPpB+xz6KX6hJCQ6QgOzTL13yCYq3WT2DGMf7500jKPu
	 ji2FygFEmmtx7JPP4VTYBN28cCemrehrALINZ7pqIpfCJq1pBi/i5fVKu7yGa8Bk2g
	 jS1691C0ZREd3LDT0msPIQXLU34BrTHRZr6leDyrOtM01Lo2jTRylKsS/GlHIEFBxr
	 7tozF8pNXt3wQ==
Date: Fri, 27 Jun 2025 09:39:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	conor+dt@kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martijn.de.gouw@prodrive-technologies.com
Subject: Re: [PATCH v3 2/2] NFC: trf7970a: Create device-tree parameter for
 RX gain reduction
Message-ID: <20250627-truthful-versed-civet-375ea4@krzk-bin>
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
 <20250626141242.3749958-3-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626141242.3749958-3-paul.geurts@prodrive-technologies.com>

On Thu, Jun 26, 2025 at 04:12:42PM +0200, Paul Geurts wrote:
> The TRF7970a device is sensitive to RF disturbances, which can make it
> hard to pass some EMC immunity tests. By reducing the RX antenna gain,
> the device becomes less sensitive to EMC disturbances, as a trade-off
> against antenna performance.
> 
> Add a device tree option to select RX gain reduction to improve EMC
> performance.
> 
> Selecting a communication standard in the ISO control register resets
> the RX antenna gain settings. Therefore set the RX gain reduction
> everytime the ISO control register changes, when the option is used.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>  drivers/nfc/trf7970a.c | 91 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 11 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


