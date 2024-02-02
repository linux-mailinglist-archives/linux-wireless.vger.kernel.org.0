Return-Path: <linux-wireless+bounces-3014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C4846F4C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713EF1C2568E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50A779F1;
	Fri,  2 Feb 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOKjlCv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064035FDC3
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874188; cv=none; b=liPvaGLuMFjJMLUGQtmD6rqpEyGW1X2bOg9V5hyFasOkyNm0csPLHN2Pt/UO/XtnQsZaBVFXe0dBiw0NuyZpYcOyJ6DXO49PhS4JfTclGyihvBhPS7XrWeN9e8VGxRNowUd/BS9c5m4IMbQA/9RO7TzJc6+l9A968em5qNVR84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874188; c=relaxed/simple;
	bh=XydI6xT5hhzbAD6CD+gBysVeg8PlHDgGQwcXTq31HfI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rfgv+qHq/ek549M1EPhWEC3tQCw9ciVLJdDpdWIJhlrZgxP/t8nk8QwYfD9xbiNGSF0kC+bMpVb8z8+x+91vD+kJCMcWRMJt3BwswZWKpneR3ygovHCwHql+w/L0MQ9+t00zDOZhfhdp4a35dWDSnKhZQFVA/EWOU3oA1qXpRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOKjlCv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936C7C433F1;
	Fri,  2 Feb 2024 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874187;
	bh=XydI6xT5hhzbAD6CD+gBysVeg8PlHDgGQwcXTq31HfI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lOKjlCv7rq2w8m+UOTFXL/XfRRUT6NlPNKc+2cUGHuGhRwVP98Z8xwq6omHyXF56/
	 YfI4StYFfh27NqLf46IrnTRrxIkdiVi/EbSnrsxb9YDZQRCSHaGhnVlL+TpuGt1b5h
	 GOfWXj90AiklO5xTLGrQDrB3zztJmimmIx+f0YrTMxKwVk4Z6YXNKcC9fhOaushG5v
	 okDVuY8cWOrsAXCiQBVT0fPzGNMFrulfZjVcdqvlSNaeStF0GkuhB2MnHtTnoIRFTG
	 uAcm7duw1ndSNqUDGDZZlM/hN3VjOxS2wuX4Qu4toLAFw0PW7gXMThPS/2ECU1lCgC
	 URyL0IFmXf+7Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add firmware-2.bin support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240123122812.3811251-1-quic_rajkbhag@quicinc.com>
References: <20240123122812.3811251-1-quic_rajkbhag@quicinc.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687418485.3200018.10517939278018200198.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 11:43:06 +0000 (UTC)

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> Firmware IE containers can dynamically provide various information
> what firmware supports. Also it can embed more than one image so
> updating firmware is easy, user just needs to update one file in
> /lib/firmware/.
> 
> The firmware API 2 or higher will use the IE container format, the
> current API 1 will not use the new format but it still is supported
> for some time. Firmware API 2 files are named as firmware-2.bin
> (which contains both amss.bin and m3.bin images) and API 1 files are
> amss.bin and m3.bin.
> 
> Currently ath12k PCI driver provides firmware binary (amss.bin) path to
> MHI driver, MHI driver reads firmware from filesystem and boots it. Add
> provision to read firmware files from ath12k driver and provide the amss.bin
> firmware data and size to MHI using a pointer.
> 
> Currently enum ath12k_fw_features is empty, the patches adding features will
> add the flags.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

12f491cd6d81 wifi: ath12k: add firmware-2.bin support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240123122812.3811251-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


