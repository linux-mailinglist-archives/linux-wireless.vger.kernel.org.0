Return-Path: <linux-wireless+bounces-11070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1094A275
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64741F25E94
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22921C8241;
	Wed,  7 Aug 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmhdBrco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEB19412A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018349; cv=none; b=XQHt6lvyFnWQpQS8IvD6+hySZXwxa5hHJDlEHVyjM8BAqqAsY5OoDGBz1qr7BlqNCY/tYi0TVIwptGrszKrLHSOfWkHvEJxvFC8+m0iJjriV46ZCrDAIGHFzdG0E3/KANDdf/+Ep6+qhOgfCbDkoCTsPllGn7sFqkrEpITcVndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018349; c=relaxed/simple;
	bh=z4jy2OldyQ2272u65CGvY4b6tkV3J9CS4dsiIX6ncog=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gqFAA+3Ugpkb63Qc0t3dLM+4nShEhEPmffENbTjZQ5M3mU3pwhagJvD5axhk8tnk9VpOsAm4nHy/uZqZLEN825gBIYAZJTLBEvoeJy4MT2RdOiyOwsga/wWGiNPxq5Xq6nwc7kCjAr3iUbfiKgQTc2rCIW2kr5bs//tRYP8GaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmhdBrco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D27C32782;
	Wed,  7 Aug 2024 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018349;
	bh=z4jy2OldyQ2272u65CGvY4b6tkV3J9CS4dsiIX6ncog=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=XmhdBrco0MnGDmCc8JvBF19yHCzan136xatlPgqlzMktKWkksGfwXriuWfV43z6RV
	 IcSbYC9tnIp12gu0xTFoQsTwtnk6jWcr3qip2JxJMFxleJupw0nQmO+JGfBM+eyqWZ
	 RsiLseKxn/wiDr1Un/Vo0Pav14NcPM9O1uRVPZ+lTCDq6CoSfT7PgfGOylcjQ+h1G4
	 nYuAY0fcaryx7PvHIg4JGDyKH07ln73j2yq5pHG7dVLPxWzj6XdW9owbcYKhUjyGAx
	 1I386TqCS6h5X8E4g2A8hQNrqa5ZhdoTslFbYkG/Djov6PK7+toT7dcL62+3yi1uK0
	 cCKyAiOt8/T9Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix BSS chan info request WMI command
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240331183232.2158756-2-quic_kathirve@quicinc.com>
References: <20240331183232.2158756-2-quic_kathirve@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 P Praneesh <quic_ppranees@quicinc.com>,
 Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301834629.3837211.1799134700273766054.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:12:27 +0000 (UTC)

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> Currently, the firmware returns incorrect pdev_id information in
> WMI_PDEV_BSS_CHAN_INFO_EVENTID, leading to incorrect filling of
> the pdev's survey information.
> 
> To prevent this issue, when requesting BSS channel information
> through WMI_PDEV_BSS_CHAN_INFO_REQUEST_CMDID, firmware expects
> pdev_id as one of the arguments in this WMI command.
> 
> Add pdev_id to the struct wmi_pdev_bss_chan_info_req_cmd and fill it
> during ath12k_wmi_pdev_bss_chan_info_request(). This resolves the
> issue of sending the correct pdev_id in WMI_PDEV_BSS_CHAN_INFO_EVENTID.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

59529c982f85 wifi: ath12k: fix BSS chan info request WMI command
dd98d54db29f wifi: ath12k: match WMI BSS chan info structure with firmware definition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240331183232.2158756-2-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


