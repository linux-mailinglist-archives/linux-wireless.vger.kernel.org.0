Return-Path: <linux-wireless+bounces-5861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E08984C2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E015F1F22970
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB9839E5;
	Thu,  4 Apr 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocrj+i/P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAD839E2
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225306; cv=none; b=rBkWkV5M1xtKT9whcCdQOp7wH5MhQ7SwHjszViC3/3ph3g4QRcdkBjuwsAgCdKlzrpgzs/LZI6mpAB6qtJZUq+fqqIrWQe0cskIA2Zh6AfP7mc+TJ8vqaJrMAPoOzRrcqw7MqA/RnXu2KqMm4GF+SOuDTYO/MykB7Kvwyj54LSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225306; c=relaxed/simple;
	bh=iONgwx5VKFrj0a7+RUjApCndLdD/ZOia0aT6oUbbeYM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aJiTgW7j1hyC34nAgs8CiAhd0uu5+xLhtuPILaNuCP7b7ePQ8sPAi2Szi4C5Tx78AgMU5yK3uKrEfR1gctvavZufEMXahflGFZDt1Tnz4Je6nipNw2AehCdmKOMHXVU9vjXtaoHF9TH/JUOSD+D3eb65YPWtM+UfuYXYozBTchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocrj+i/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48DDC433C7;
	Thu,  4 Apr 2024 10:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225306;
	bh=iONgwx5VKFrj0a7+RUjApCndLdD/ZOia0aT6oUbbeYM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ocrj+i/PpSM3aZ9cn/EaHoL0/p8pEYyx5j4+kMw+LxFQMGNicrMx8QssPq+9XUxfG
	 wGLjflwrO2V9VKKnk1+aYU42KI4saB7ArncgW8W2xiozX9yGi0COG5kVIrtBp5dC46
	 VtCWJaBODU7fAC1vnYuZ3Cojud/xKXc4xBkCHQ7+j/hkKJPZD0BZNov2KD9icpp9Gf
	 7aScoBqNv62EB3zOYANBDzn89D94pc+OpVyvDFxzYCPZ/nnSC/w6a+ljyehJcz3ga7
	 JjD4+gATVMtGTeUhSO+VgKQ5q5uXLqL4JOVOuRqVeK17+KSON4DLg4lmOwFLjOG/k9
	 XGxhJSe/EGm/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix missing endianness conversion in
 wmi_vdev_create_cmd
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240322003726.2016208-1-quic_miaoqing@quicinc.com>
References: <20240322003726.2016208-1-quic_miaoqing@quicinc.com>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222530320.1806092.7305157488548373424.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:08:24 +0000 (UTC)

Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:

> The WMI commands are in little endian byte order, fix missing endianness
> conversion in wmi_vdev_create_cmd.
> 
> Tested-on: WCN7850 hw2.0 WLAN.IOE_HMT.1.0.2-00240-QCAHMTSWPL_V1.0_V2.0_SILICON-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2adcddd8a316 wifi: ath12k: fix missing endianness conversion in wmi_vdev_create_cmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240322003726.2016208-1-quic_miaoqing@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


