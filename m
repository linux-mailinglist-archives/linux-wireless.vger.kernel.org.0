Return-Path: <linux-wireless+bounces-5973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A636089C735
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479051F2152C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C513E41D;
	Mon,  8 Apr 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS8XbHEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60A768EA
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587089; cv=none; b=lIX2lqay8mp0gJR5n2UiCnDkV+TgxUYUnMF6jIF4Rb5/3hDyX4NUTdJD0fQR7FybOh11j+l45A5Nxb2cv6lh7P8uqHi071PueWgChnDyTUsuxiKFN0mxQeotJOu+0Hmb1fAXeaIfJm238CQ1t/gVKm8rOChqoarFg1tPykFQiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587089; c=relaxed/simple;
	bh=ITSzNKQT5krekzRgoNfiQ3WVQsFXI3XCbtqQSxDHcnc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=pB0PXWPqSSQ58GKiDUUx+XKI43OlKBWxgzbW34VtBv2c5BRJ1ZJsXGP9t2QgUxCoBrQhla0h/gTyJDOC1No/MW/xW5GpRAkeSpYGXpQbH1mQVwsFTFq8DKn/5hwYGAkQZwq075k7ktiXpHOLLXfBpuB8Lybrn9Q4q+62Noycg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS8XbHEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083D5C433F1;
	Mon,  8 Apr 2024 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587088;
	bh=ITSzNKQT5krekzRgoNfiQ3WVQsFXI3XCbtqQSxDHcnc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FS8XbHEHXcp6akdLPyGpgOlaiN8UgnK/u49XdVxdSOcvLLCxQfCEXrL540TPcZu8j
	 i7AanNiEy5rKxcSofnxHHUrzatZGQNC4zGEoQ+CxjFS8R0S47eqxoIQJO8swGXaFUf
	 dockr2BYHQM9FSU5/bfQofEDvMl/u+uN1HgV8DOg0NEC+rqeechZsGMd98JrpY5gSV
	 N5+eGYI6Ye9/zkTCUCxdlhGdyK5V9U0dGqUAhCdRJGMG9rSljoRAnbd+nzbvnfTEHT
	 vXn4kwIzoOTzxAx+7NyS+fOLYunmcw/jJovqfK0YAisqPD/3m5azI/RdncDb/vffdP
	 u81WvjR7VWAxQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] [RESEND] wifi: ath12k: extend the link capable
 flag
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240403042056.1504209-2-quic_periyasa@quicinc.com>
References: <20240403042056.1504209-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171258708599.2816782.535129209108823999.kvalo@kernel.org>
Date: Mon,  8 Apr 2024 14:38:07 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Link capability categorized as Single Link Operation (SLO) and Multi Link
> Operation (MLO).
> 
>  - Intra-device SLO/MLO refers to links present within a device
>  - Inter-device SLO/MLO refers to links present across multiple devices
> 
> Currently, driver uses a boolean variable to represent intra-device SLO/MLO
> capability. To accommodate inter-device SLO/MLO capabilities within the
> same variable, modify the existing variable name and type. Define a new
> enumeration for the link capabilities to accommodate both intra-device
> and inter-device scenarios. Populate the enum based on the supported
> capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

58e8ecda692e wifi: ath12k: extend the link capable flag
b34389c3978c wifi: ath12k: fix link capable flags

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240403042056.1504209-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


