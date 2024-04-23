Return-Path: <linux-wireless+bounces-6708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007A8AE0FE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8061F22CD6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8456B65;
	Tue, 23 Apr 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMHDQt3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793320B33
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864578; cv=none; b=LVqinq10rZHJ1cK3CSRJEfc1L0ZTl+MNO/qMZW3eCHlChuS0Lf1GwXk2g47gMO3F99bIfoOalZ0cekG0Pe23xowJUAEHZpxM3YTofCv9kxhpitsdcJOBOEXgc0XyAeuElaBWzMhDFFJ3uCXENzWGLQO6s/AQGM+rRb124+rxMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864578; c=relaxed/simple;
	bh=va33LSpfG9xoKbsr+h4NzsKwBQyFiCv1ilCjjh0xDvM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oMTiBce2AjlumRGLriai1/zF0s4VIUbdXZ+fEWKCsNdPDY1b4RZqBJwQy7YhcIXmxZTjGGPSLF1iEZEN7tggZlRHLLwVftbtHSStLlf98iZFT1i5iyF5Ij5wkOYBIjrsKHT9tV8ftLWQiGqaOa0kZ0OcZIajcbssLZ2kkaIdxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMHDQt3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAA7C116B1;
	Tue, 23 Apr 2024 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713864577;
	bh=va33LSpfG9xoKbsr+h4NzsKwBQyFiCv1ilCjjh0xDvM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HMHDQt3StuOWCB6OYEn7ISsjOx4CLQbmx2JP3s5jFBhAg27tG3Qdj1t7OTLjzus2z
	 PNBgfU7tWA5cCXHFeyOCxOZ2+z7k5GuloHEymsFzhHwyZhRYayHr7lrSrliLkK0OHV
	 9ceNF8KBmzQqc3Qyo4Jv6sNzdCpMOU0FDk1K5Ydbw3yxn+NN9spDqtdROmfFmQU7o4
	 f/DRJRum2jEshbN65KGSS3gVaTuGfCrrdO5zbZyQf7eKS9VRRNBqDm/tTS4i9jLCdO
	 6hyWjpt0FTUPZFptOEO/tB2u0+kM3zzieq9lTFHJwzpwwyGY/bTvYuhkBiEFccZHkQ
	 uotCVsBaKT82g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 1/4] wifi: ath12k: ACPI TAS support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240422033054.979-2-quic_lingbok@quicinc.com>
References: <20240422033054.979-2-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171386457473.1790113.408813248801980156.kvalo@kernel.org>
Date: Tue, 23 Apr 2024 09:29:36 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, ath12k does not support Time-Average-SAR (TAS). In order to enable
> TAS read the tables from ACPI and send them to the firmware using
> WMI_PDEV_SET_BIOS_INTERFACE_CMDID command. Besides, ath12k registers an ACPI
> event callback so that ACPI can notify ath12k to get the updated SAR power
> table and sends it to the firmware when the device state is changed.
> 
> ACPI is only enabled for WCN7850 using struct ath12k_hw_params::acpi_guid
> field. Most likely QCN9274 will never support ACPI as the chip is not used in
> laptops.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

576771c9fa21 wifi: ath12k: ACPI TAS support
764883be7ed0 wifi: ath12k: ACPI SAR support
12bccacbcd9e wifi: ath12k: ACPI CCA threshold support
7b5f3cbfb468 wifi: ath12k: ACPI band edge channel power support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240422033054.979-2-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


