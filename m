Return-Path: <linux-wireless+bounces-22124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04542A9EAB0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 10:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D93188B51F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860523814C;
	Mon, 28 Apr 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5oM2tog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D41DE892;
	Mon, 28 Apr 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828741; cv=none; b=etCm9nqenOCtKWlOZ8lRFN4/b4Utxy/I24BRw36uugru1U/WOXy096zlf8LGeQ2FhjuQqKBEmOof1alfjyGZ5KMoGqtgB9aJXqBt/JU2PrXo3/AJ4umDngD4ezt8jyVEx23skzUBtWCuw57gI+ou+6N1eMbws/NdJ5+pwWLBH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828741; c=relaxed/simple;
	bh=yTHxmPegTimTQRX+ehlBAgPugX5B2Xw+Yx43SP2+8w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYHi7h8ub9LUhR+5SynOoAZraJadQ9W4q8bIIkIKHAb3b3kEY7MzwJz/kFSOF7Cc3MhXtG6EumPtk7sA2rypGKQ3OdW8UfcDepkAnTTx1PZ2TXOLwQlvSg8EFE7iffvjnxgJE2T18mLfwjCa0lwcyukl5C+nMr+Zsv9OiII7iaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5oM2tog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30243C4CEE4;
	Mon, 28 Apr 2025 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828740;
	bh=yTHxmPegTimTQRX+ehlBAgPugX5B2Xw+Yx43SP2+8w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5oM2togKlPWPVrgBwV1vWVT6oTq4Rbr+Ly55q0JEUiSugVz+K5Diyp4LeyhEw1tu
	 qa/j8BfyhzjT2ajfsJi/oJaIXVlS/GB3bow8MK/9TYWjVwmJzH/VQzP+h097tPoPpQ
	 ujKMbvkNcRHAkp3EXsSpHoctsmB7OFabPfObCno2kVwuvrxnF/3/Y1i0eABUCyiyi3
	 M0WEoJTMYM8w8QqE/fSZFGhEb+cLOtizRtUE8b09uhwlfmwVTBhkEufXrFi7C+UJ9a
	 pXnxthVIN9a5/ChheCKLPNaa/9omNzQ/x6yoUtvEDQHA5rBJSij1gJfRXutJNYBvAN
	 GaRTepzaAwRFQ==
Date: Mon, 28 Apr 2025 10:25:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND ath-next 1/2] dt-bindings: net: wireless: ath12k:
 describe firmware-name property
Message-ID: <20250428-ruddy-bold-macaw-9ffd28@kuoka>
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
 <20250424005703.2479907-2-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424005703.2479907-2-quic_miaoqing@quicinc.com>

On Thu, Apr 24, 2025 at 08:57:02AM GMT, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators
> to decide which usecase-specific firmware to run on the WCN7850 platform.
> This is necessary due to resource limitations such as memory capacity and
> CPU capability, or performance and power optimization for different
> application scenarios.
> 
> Two firmwares are supported: 'WCN7850/hw2.0' and 'WCN7850/hw2.0/ncm825'.
> The former is the default firmware, suitable for most WiFi 7 STA
> functions. The latter adds support for commercial-quality SAP and
> optimizes power consumption for IoT applications.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


