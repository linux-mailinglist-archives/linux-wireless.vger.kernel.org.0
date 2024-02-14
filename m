Return-Path: <linux-wireless+bounces-3570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED498543EC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 09:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC81285CFE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16211CB3;
	Wed, 14 Feb 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaZGd/1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C71173A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898634; cv=none; b=dqyViVrWZaL9MWrLerPBYMNuktfI0S3sN8bDFQkWFaAcj/PgkaG86kowg2XPCdt7dtK0DyGfDT4qW0V7w0HlaKVVPXo5/CWoOaR5OcBUxxIx/LUbxRUTZkxvtv001ctgb63mIbYwKHJmQGPyf8wCV8c8QvouC4Fx1YtlUodldrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898634; c=relaxed/simple;
	bh=BCtWazdp6icgtK7NoWSSj5u5eKBWafsHPj4odfX5HHw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CwPoCFRmXdYhHfMYRbo0TOiWfJYmUR1R5lmedLNgpo4hjKQPzKARDNi2ZR5TxLXwI8CRP66hdAja2AyAav9OV3iycPrRxVAvaBTfsLMlss6WLPT7rcjmoOBouwMY+KFueqNot0YbAedpEeLWYRndmTolWV0pYTrE+IWHjK83ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaZGd/1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A56C433C7;
	Wed, 14 Feb 2024 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707898634;
	bh=BCtWazdp6icgtK7NoWSSj5u5eKBWafsHPj4odfX5HHw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NaZGd/1WalptFAhwAsuV70DrkkPA21efnGoOPQPm7DGMkMcR10jeyBwR6hMNO+8+8
	 wSFnHfoF18LHjhkqYG4FVipomOgX537uiRKDFSdVsY9M7Zqj0Exy5xTXz+RTls1sS8
	 U/cYTGiWFToY72isB8GlGrGs2lCrBet9UhshvrlFl0HE9WaXusLSiurTi1/XrrivDd
	 ZNMQTIr64OBRZemkCA4vZwJKVkeM4igqzf5W/xdUwxLrNtcNOFO7Qkbthnmt+Nl3mL
	 uP+WJBPMkcp+oisyxPdyEhBbUfcGaTBgiX1+xgtV2nDE7eZSMAzNY96rBNadgn7Gub
	 0i3FUpdjte3Kw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: Do not use scan_flags from struct
 ath12k_wmi_scan_req_arg
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240211145548.1939610-2-nico.escande@gmail.com>
References: <20240211145548.1939610-2-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170789863172.3088943.4868050703546189476.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:17:13 +0000 (UTC)

Nicolas Escande <nico.escande@gmail.com> wrote:

> As discussed in [1] to fix the mismatch between the WMI_SCAN_XXX macros &
> their corresponding scan_f_xxx bitfield equivalent, lets stop using the
> scan_flags in the union altogether.
> 
> [1] https://lore.kernel.org/all/4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com/
> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-02907.1-QCAHKSWPL_SILICONZ-10
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

bcdb44f30be9 wifi: ath12k: Do not use scan_flags from struct ath12k_wmi_scan_req_arg
80fd22d7d41a wifi: ath12k: Remove unused scan_flags from struct ath12k_wmi_scan_req_arg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240211145548.1939610-2-nico.escande@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


