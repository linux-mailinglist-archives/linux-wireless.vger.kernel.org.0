Return-Path: <linux-wireless+bounces-6772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479258B0EA6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4382B2C075
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A215EFC2;
	Wed, 24 Apr 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKyP6/lw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86415ECE4
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972869; cv=none; b=V6TQ7jg/jDbHfObqOQjorl+81WhzeHaPO1a9BqcDW7bgrcIKiN70TDIeCNPfqXqafJPhoKhNBnp/GjM3EfXy2R4cc2ot6XzaMUIUHaOo6nu4dditTROlL3DoIIPT2imwFFkJnNH86OeOUZ8fZLq64KYL+KWZk8u21abECWbMUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972869; c=relaxed/simple;
	bh=b4bU31v1VY2Hs/KRS6Y47Mb61FbQN5DRav97Js/jzKE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BwXxJjWM040CgDq9+8dvw7tWhXoiOSSWZ8AqKWW9bCDg9HjJjleNwSvUPtbIChLmpw8IDMQ5TQrJXxVUMzhJc1gAAfv1TmKfjRCyT/wHutHilKu5wpWu8wbxeb2iA25XkzMtFf4+DnjrqafZlwYxIAbv+V7Qlg/zE3RA4h5jloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKyP6/lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B7C113CD;
	Wed, 24 Apr 2024 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972868;
	bh=b4bU31v1VY2Hs/KRS6Y47Mb61FbQN5DRav97Js/jzKE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mKyP6/lwuEHuIbB2l2yu9aUoa/0T5UwS6ctMVe2yJpAKqfxoLWldSvKDSOtqAlZjt
	 7EKlp/d4veOLuLPRekjfIOqstFLZlUSUeukutGSPLciE4JHWxeCiw3oq1t0oDeM0Hm
	 D4fnNfbeEaxwW3PgP2TMG4PP8CfZG/SVnXdgbC7poJ8Rf+v2wJVrc2jMD+hPNsqZry
	 bGIzSj14mDXoD6y23N9TiIHHqkr5soQ9MqQ3JlHqiIT/CFs4RNWEzSlnAwCdvKSN31
	 UdYZYrYE6j97WeZZUgMDl1uSt5PnXRYFP3L5FAGDxl1/rsfSLfAzVy+rDWwT3CG3xz
	 3HUEn3j/0oBkA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: read single_chip_mlo_support parameter
 from
 QMI PHY capability
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240418125609.3867730-2-quic_rajkbhag@quicinc.com>
References: <20240418125609.3867730-2-quic_rajkbhag@quicinc.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171397286596.2560403.7467583806686493830.kvalo@kernel.org>
Date: Wed, 24 Apr 2024 15:34:27 +0000 (UTC)

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> New parameter 'single_chip_mlo_support' was added in QMI PHY
> capability response message. This is an optional parameter added
> in QCN9274 firmware. This parameter states if the firmware
> supports Single-Link Operation (SLO) and Multi-Link Operation (MLO)
> within the same device.
> 
> If single_chip_mlo_support = 1, then intra device SLO/MLO is supported
> in the firmware.
> If single_chip_mlo_support = 0, then intra device SLO/MLO is not
> supported in the firmware.
> 
> Hence, add support to read 'single_chip_mlo_support' parameter from
> the QMI PHY capability response message.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

ae6ec4a38aa4 wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY capability
da3cbd88e780 wifi: ath12k: set mlo_capable_flags based on QMI PHY capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240418125609.3867730-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


