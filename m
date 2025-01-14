Return-Path: <linux-wireless+bounces-17503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D26A11016
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F410160E31
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F941FBE8F;
	Tue, 14 Jan 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoME+fxd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD611FBCBD
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879372; cv=none; b=lkAVRNv9TWTzA4t2g346PUR4EO9xi8v9c5Z6q3QM/1K22zQz/FTgwOy+k41HTccOPIHysnJP3UUxi/HNtrnIpuZU+LVqK+qMq3/NTAiUbWioV5EkSZTyAPHTlmQmjAcRe+OaEf7UXLkCytu2t/yqBo6avrWNv7eu+0FSLFWkLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879372; c=relaxed/simple;
	bh=WOY4AGPayNCfR8xPWYGzZU8DRPDN3/lPA1u+hsfXMts=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M+gFLXbY2g1PpTS/CuheWdpvo+x5QXeCJrJD47qT3akrAaKyOmQtlEOQ3UqndYJSyzxc0M9x9bkorzFSBKG54fhMng1BwQxbbPHkhPpGM7BawuOHkNJwrS/T5IM8bh935OsGutI3286u4eRG419ZrnbbQ13367Tq/+2oJB9WKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoME+fxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0566BC4CEDD;
	Tue, 14 Jan 2025 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879372;
	bh=WOY4AGPayNCfR8xPWYGzZU8DRPDN3/lPA1u+hsfXMts=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MoME+fxdlvCszFOdrwvDLEHl1npu5FYyrXZHekAPDKF3/3Nje8O1N6ogi7eg/1iCu
	 HqKV2jyFO+UoPHAPWcndIkBuEx7g7tcUE8OKat2u5ZhYd/v9A0LkAvDTaoUlnSp6vO
	 PKqfu5A5tS3sBowFX2WKCgG5aDs+fGmEGcNywd+bZbAn3nHJFUc8hY2rc5sMhNvQcN
	 v+mm72kaLudjlw3m91s1+eGTYPSOwDoPCDBvg9oDcJASJEzisKIZcBaoHSCrXW3StY
	 kgefGqaLTKeWXLMpZGaafAw0I6soYcJlqiZz/hKrfOB2CqB+ED716/cde/l3FmVd+V
	 jZj+tIzOK8L4w==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/4] wifi: ath12k: Refactor ath12k_hw set helper
 function argument
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
	<20250112071630.4059410-2-quic_periyasa@quicinc.com>
Date: Tue, 14 Jan 2025 20:29:29 +0200
In-Reply-To: <20250112071630.4059410-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Sun, 12 Jan 2025 12:46:27 +0530")
Message-ID: <87ldvdp7ue.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
> ath12k_hw set helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle to
> the group handle.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

