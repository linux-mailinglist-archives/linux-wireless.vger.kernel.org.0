Return-Path: <linux-wireless+bounces-14525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228FE9B0278
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CFC1C214A4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826A231C92;
	Fri, 25 Oct 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SElkjssL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792E1F80AD;
	Fri, 25 Oct 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859731; cv=none; b=eSNgY3d5MIX+2gyxGQCeMxc1WXJIOw7ABU5uo2at1svCmkbK1QSjysKLdegOe+N1l6Xmf8Mhja0l1gEYDvjPlAEfO5IxsXOqkQGsJFsPdpHsqFUe5lZ9Y0/276NRYacgbszX4ShVDaYdX7tkyPffW+t9DP0JfeIMUyQr66FXPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859731; c=relaxed/simple;
	bh=NA66e2iqCnEkVY1lqjeKFf0Jyb7rhPBlZOP6atg66ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHc0n3LI6MvL3lEpZO6yXyuJwVthwnPjQajcBONuNPy7a+vD0fnCnp5ExOXcEE0qzgmdAiDxX5ZEbxm6hdC66A+j3ek/km2qDQRsSKGVqkTeqZ0t36lAX7sgNee8W+MMOoM3Wf9Hp7q7IQPyfg28iN4CBjCluxkrHEi4rsWKU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SElkjssL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360EAC4CECC;
	Fri, 25 Oct 2024 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729859730;
	bh=NA66e2iqCnEkVY1lqjeKFf0Jyb7rhPBlZOP6atg66ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SElkjssLyRg4Mp2WWV1UBP28ZwKRHI226LRR9un//LTMBDmUsF7n6lqrtna1ar9Ww
	 iP4+cAmWYOInJ4lfrf0ybfWMLdrbdVPeq8wgMmhHv7dagcOJl26FvTWKfrZt9fSSso
	 jZWreBf5JpG9X+es4LA3yEg0+EKsuA1FeQ8C+cOaAhpWiGj+NE6deZiOpiECqheIh7
	 JcXQxlAMQ3HIUuAqpEBYUQhdi0L0iCJlDeev5CBjOmMcyAftfM6wiUGLTLLMTIAeVR
	 qokX9Hjl2UTeptsgrTMPpKXy8aCmf75zn5EWgjyCr+i7cQ++gu0tXfc+zt1NmdBQ1N
	 UMphlzajmu/uw==
Date: Fri, 25 Oct 2024 14:35:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, quic_jjohnson@quicinc.com, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: net: wireless: ath11k-pci: add
 firmware-name property
Message-ID: <aismpshqdh6pgya5fjxbem2kaqydbiyh72jwuh2hrismli2ysx@zxlos3etmhzc>
References: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
 <20241025100419.2128604-2-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025100419.2128604-2-quic_miaoqing@quicinc.com>

On Fri, Oct 25, 2024 at 06:04:18PM +0800, Miaoqing Pan wrote:
> This is the same optional property that defined in qcom,ath10k.yaml. It's
> useful for the platform / board to specify firmware through device-tree.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Please do not send new versions while old version is being discussed.

Best regards,
Krzysztof


