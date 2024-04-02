Return-Path: <linux-wireless+bounces-5747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1E89522F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CC1F24937
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1409664B7;
	Tue,  2 Apr 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkuyX4dq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB665664AB
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058366; cv=none; b=QWuZrAu9dqVPAzS7cVEnqPARFFbGU3FNec9vze5YQNAhVvz/gnm/IqoHN143e8VmZsrnY9a2LEItPtRGgSPdskUHKMgaZ5xHVPtHd623zVPUPLQqBM0iT6MMDcMEP/QcMf+HuGoWL24pj1mT3F2dZLBAhrkL3FosswykFD0x7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058366; c=relaxed/simple;
	bh=ZuTKkEoH1PBM0P+GfAAbMX6nlQ4qj3EKg3MZpaePW7k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qnOLHgYKYXLwoV/OEpE7SaV974VPnQx3xKSMpfomsLVk/mebwxUV1aqprtoDqL9qO2vVG8jlyJulNn7qRyyUahb7SyJ+HPXbysZ7OT5PipQmVbGyNDqKCeIIrYMtmNikDgRSfQOFQhYNOjcFkrvsaakVqqx3ZpV/7+OTq3i8mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkuyX4dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAF0C433F1;
	Tue,  2 Apr 2024 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712058366;
	bh=ZuTKkEoH1PBM0P+GfAAbMX6nlQ4qj3EKg3MZpaePW7k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CkuyX4dq2xAN5XWVkmILrJe5t3MLyOwtfoHZy2ZfGu+0j+ea8Huvkl5S4QDuw4/aK
	 sZtHyLhZjYlz/s7h4+kTLHyDNIPNtMethZ/1GYJZxlFiLkG1GdzOQ01d0cK6zv3mJ3
	 lekPwcwfOY9sPF5xgDCW0pdpCK89KxWiBxMQyI53xE2pUeenxCAgZ/Micrm9Ksi3fa
	 D9DSfWZZuhy3Syme86UgI7VO92JzoHLismPH0DzrjkJQ30XeBSKceNYNvd51zidSBw
	 5tjXBodYJa8Yq5IAS+y8HujF7Ax6qaWCgLumbEC4ToKAPhQxUXqYmxO1e6cak2aqX8
	 EoUyKfArJ2UZg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  P
 Praneesh <quic_ppranees@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath12k: fix BSS chan info request WMI command
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
	<20240331183232.2158756-2-quic_kathirve@quicinc.com>
Date: Tue, 02 Apr 2024 14:46:03 +0300
In-Reply-To: <20240331183232.2158756-2-quic_kathirve@quicinc.com> (Karthikeyan
	Kathirvel's message of "Mon, 1 Apr 2024 00:02:31 +0530")
Message-ID: <871q7o6l8k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> From: P Praneesh <quic_ppranees@quicinc.com>
>
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
> Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>

What about backwards compatibility with older firmware? And what about
WCN7850?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

