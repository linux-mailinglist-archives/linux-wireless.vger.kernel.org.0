Return-Path: <linux-wireless+bounces-4685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA987AAFA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28114B21CF5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB613FB1E;
	Wed, 13 Mar 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUkWXc1V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394913FB1C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346820; cv=none; b=qJhBbhbB73kazdWqK3xP5No6ApNc0uGwTpeaLxYxKqkI4875RThe7HJGHz3xZ/arY/Z8dVt1Z8ohhu1Ge9pnlw2MVhZ2Tatu36rbx7yfE2DKuVKSCfJYKtI6KCL4W0j9HrWdyIV+JoLwij1VIfKOsk7RTzsDzirtj6ClfhBbe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346820; c=relaxed/simple;
	bh=3wzUd65sE8PPvf1zN3NvhnEeMECYa7wGQzfd/IvjO6w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=N2LkftbyJIWOo3CWKFoFcmvAV1rcuwmpFwm3qH45mGBj55JOFZnLz1Ke1h1SHT8Rau1fG2DxbnKmoAwBnS76zV2hM3wXGqNKTg8qzJaeqTHrtwRsjozPEHBdodsPRQuY62cq9/QEvEnLQCSrps+xrpmjlKoNC4UJY6eFpa2hJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUkWXc1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118EAC433C7;
	Wed, 13 Mar 2024 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710346820;
	bh=3wzUd65sE8PPvf1zN3NvhnEeMECYa7wGQzfd/IvjO6w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gUkWXc1Vna8dqL+5VHZMrmtHvkyLl+rrknPwD0/f1Z0sVi+lSmBSRbZBsaS9LGVJI
	 XdqjRf6HkoBS6mLuoGr2Vq/IWr9LOmv7+JxfayMxusLVl6RXAYloO93MigHAqxJNHw
	 0vh19tK2LCy/wvLCf0N1MRBLaY6ZvcwQoLlvyv3vcW+Ljmuhz/9ayEs9ZOKWKoMg8N
	 Vhx0Q9+YSqWNe2gxE1YLbUS32N7JG287uLY+i4IerSCqyBl4eQAETT/BAavdG0eA0x
	 NabcnvywWlPsdoqwOFXgCJsOrnJP8Igw0AjhKSKiXaCzwOv5IoZg66UGC3MPMP7tXa
	 GHhpaWek6lMtA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal
 strength in station mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309121129.5379-1-quic_lingbok@quicinc.com>
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171034681684.2322265.9660346495295315212.kvalo@kernel.org>
Date: Wed, 13 Mar 2024 16:20:18 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, the calculation of the average signal strength in station mode
> is incorrect.
> 
> This is because before calculating the average signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm, if the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

What about AP chipsets like QCN9074, do they also work similarly?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309121129.5379-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


