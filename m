Return-Path: <linux-wireless+bounces-9120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97E90B699
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9193EB39C12
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42C1607B4;
	Mon, 17 Jun 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDGq1++s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4101607B3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635597; cv=none; b=qKv6q6zaROlgrVdK9HIfXRejexjNgD0m33IOTo1fP1KxWKPPevbXVjDclFRxp8N7h0j2UD0EOyLYb5yD0Ggb1zLrYjVjze4ImCYdtuxfBVLQLC32JEanFXKJ/8g+w8ukXQPzWLYSqEbwiR/TpOVGIUr5i1DS6oX7e/EJh4fEkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635597; c=relaxed/simple;
	bh=IbcA056kCP+fyaAgZ6tZpqCHgjbNEZC0YjTh3ybgQfY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cX0hAVLpm6uCuLd/3aA9apcJi7AlO2l7Ed1BMq07Ptj+UkeN6G96V2ANooL+ifakNKpnbXalK50m/mhCGDZvQurV5Y+Q4V9V7/RWZJEQ3NlKWrQ52CD4NalUq+9SpKrmTqDoEa5lFUto8wsG2NhhNPur89aZPnsj3I3YG+hOe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDGq1++s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C5BC2BD10;
	Mon, 17 Jun 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718635596;
	bh=IbcA056kCP+fyaAgZ6tZpqCHgjbNEZC0YjTh3ybgQfY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=vDGq1++soky9PDf2/SO78qSbjmKXO0M44N5kyUUs9YJKGswrYtpXV1KSWo7EZcHM3
	 bJHrk3VPXF+KpQoybqAK5oZFSz0K7CYRYhC4QCQ9obsBLBH6WaJ76XcFED0aky1jul
	 QWK5wHFjbvW1wOTyiFXMNJIkXzN8gufvU0mR3MwtfDyp6ctptB4XHEDZXY9OarEf8P
	 RaWRHAwMkDX8i9/4nwYGkxSrk6voWBR7LOwlnAVInO65vNdmNd4kRnJToGmatR5teT
	 VB7+z9FmGtpfy65D5ezjjc62Zurks+Vr7igph/YgEPa35+4aFwKVIbKNIzj6MAWHWA
	 a9hpksVxHj89A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Remove unused ath12k_base from ath12k_hw
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529060939.4156281-1-quic_hprem@quicinc.com>
References: <20240529060939.4156281-1-quic_hprem@quicinc.com>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Harshitha Prem <quic_hprem@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171863559405.53335.7477660274917067643.kvalo@kernel.org>
Date: Mon, 17 Jun 2024 14:46:35 +0000 (UTC)

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> Currently, device (ab) reference in hardware abstraction (ah)
> is not used anywhere. Also, with multiple device group abstraction,
> hardware abstraction would be coupled with device group abstraction
> rather than single device.
> 
> Hence, remove the ab reference from hardware abstraction.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4f15b06e5782 wifi: ath12k: Remove unused ath12k_base from ath12k_hw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529060939.4156281-1-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


