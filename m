Return-Path: <linux-wireless+bounces-14042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0629A01DC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EF9B25586
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B7199221;
	Wed, 16 Oct 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCnTvzid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354E170A37;
	Wed, 16 Oct 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061851; cv=none; b=KjirwOc4Pysl6fve5awXxbw0KrWRZpxCAEoHiFP3xhB1tOPkRlgZiaeRoK2HAWzRH65M8ruKAl2vNO+R6hWrn3Z6NazXQ2csVkjvwDsPmtL7zgvam6B750JogUgNsEVnDPu1zAy63kZKjiYE5Gof5VE0nefNcW6tmMbaOmps1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061851; c=relaxed/simple;
	bh=nueV4zW9DYaKNQYqepHGVVpmRCUZwWuMQ6ahTdofusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezfOWWBooWFJC4pENqlLALda262kd0XKp5UKw/4SnfyPlyIRZbyQhT84x46HdE6TQNsRCUE/ATLkpwVwF5ltxOER6MdrhFkz7d2dTl0BZU0TnxE6QQHXlbGo59EXtDBoJy7oIPK/C7CrXJt1r76SYsFLwzgZy8hDb/YYDQg3hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCnTvzid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5067EC4CEC5;
	Wed, 16 Oct 2024 06:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729061851;
	bh=nueV4zW9DYaKNQYqepHGVVpmRCUZwWuMQ6ahTdofusk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCnTvzidshFBNh5H2Dwnz5y11dT8NyAFjt5jPCgNdiPfN432LHzDuivAILLKq/LVl
	 uQIn6u5fQ7SLcYtOIv6XsuIjCymgNBgbDQEStSiDpn1zqVtFqRf4vmFXAZwYMPGzxs
	 2uaf2M2saJOrZpdXlYl5cFhDoqgPG46UN19TYAXNBB0WHYN7SBk/1PWhATsxOeNFhI
	 NKSqhXLJPmb8ryrZn1Hmq1vzq+N3eTBlyv2gKau7czgPt9DTbkZGP6e/ycbfxws+MG
	 0XAqujvHS0UCrU/H58qO/oYZsufioCZlhNnnWERReb3anQuGTAUP4cEISvfylGuGX6
	 8/ZrhRDDlHyFA==
Date: Wed, 16 Oct 2024 08:57:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 00/22] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
Message-ID: <ou5kgedz5aga4dtda6k23uhybcjy7mfwie74p6q3qyn5bdajz7@ftejp7lqrise>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>

On Tue, Oct 15, 2024 at 11:56:15PM +0530, Raj Kumar Bhagat wrote:
> Currently, Ath12k driver only supports WiFi devices that are based on
> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
> Ath12k AHB support for IPQ5332.
> 
> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
> device:
> - Add hardware parameters for IPQ5332.
> - CE and CMEM register address space in IPQ5332 is separate from WCSS
>   register space. Hence, add logic to remap CE and CMEM register
>   address.
> - Add support for fixed QMI firmware memory for IPQ5332.
> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>   AHB support.
> 
> Depends-On: [PATCH V7 0/5] remove unnecessary q6 clocks
> Depends-On: [PATCH V2 0/4] Add new driver for WCSS secure PIL loading
> Link: https://lore.kernel.org/all/20240820055618.267554-1-quic_gokulsri@quicinc.com/
> Link: https://lore.kernel.org/all/20240829134021.1452711-1-quic_gokulsri@quicinc.com/


These are series targetting other subsystems. I do not understand why
you created such dependency. It does not look needed and for sure is not
good: nothing here can be tested, nothing can be applied.

Best regards,
Krzysztof


