Return-Path: <linux-wireless+bounces-8007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D898CD275
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AD92839CE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06850149C71;
	Thu, 23 May 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8hb/JJq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75451494A6
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468254; cv=none; b=omMo4RD7oEt2Mmd5+PL0iEyOBI6lfBrQxoelGWg9wtMQxs723imYNtHBt3PoR/P8hJldm0zB71zMdXsYM+5UackERJk/TH2dzk1mD25egM+K95JO3HvDajyL2cEfS2DF42jXRrZk9E6J2tIANEYndgdTLssghlueGSzfEPg7k1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468254; c=relaxed/simple;
	bh=l7mLZ2DFf3Oq9wE+1CtIHhvmDx4/5DoMK0izVbWUcxs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NqLbBMVV9r5vcN3Z3IzGqQL6rhUyvkmaxO99JbQk5NvCUNIpfDH43x0L/r4MIL7DwsMJuu/f0tGDwBXRA1vGNfHGQqydSBOTAfhaQEwK0JoKzEzBtIx/U59SCUeBVC1moUCpWTbfw242ku4mBqW7xdTstweBJxG3+tkrm7vsYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8hb/JJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF78C32782;
	Thu, 23 May 2024 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468254;
	bh=l7mLZ2DFf3Oq9wE+1CtIHhvmDx4/5DoMK0izVbWUcxs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=E8hb/JJqBYJS++YPBpvlmDLeWlW9ZLnjikwGYAqScSV55J5PDnn/BveBugL48T56o
	 1efXh2COxS9hY5Us4d+n2SlxuNOY+yMiujMCfh/fT+KtAWZ6+iW5vu+G2l0rTQybbA
	 DGRxobcXrx6+pY0KiJyHp/WJpbAwIY/4eA7lqr3P9Q2Nsnsnn3bU4cZ+GM5nNQrhal
	 meOCpaMoDDJ4Fijvj14XcOafKvM24gmT9IxEeY/6IOgwquo4gKEA6nREQrkze2GGIw
	 Tepl2nH4Nu/WEzOdj8/NIbHfzfX0UfmF3l69N/GrsZUG6zuEwyv/uwDoKoh1OW5Hrh
	 5Qb/yH1oCoqBA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix WCN6750 firmware crash caused by 17
 num_vdevs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240520030757.2209395-1-quic_cjhuang@quicinc.com>
References: <20240520030757.2209395-1-quic_cjhuang@quicinc.com>
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171646825167.213015.5353620054103285361.kvalo@kernel.org>
Date: Thu, 23 May 2024 12:44:13 +0000 (UTC)

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> WCN6750 firmware crashes because of num_vdevs changed from 4 to 17
> in ath11k_init_wmi_config_qca6390() as the ab->hw_params.num_vdevs
> is 17. This is caused by commit f019f4dff2e4 ("wifi: ath11k: support
> 2 station interfaces") which assigns ab->hw_params.num_vdevs directly
> to config->num_vdevs in ath11k_init_wmi_config_qca6390(), therefore
> WCN6750 firmware crashes as it can't support such a big num_vdevs.
> 
> Fix it by assign 3 to num_vdevs in hw_params for WCN6750 as 3 is
> sufficient too.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> 
> Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

ed281c6ab6eb wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240520030757.2209395-1-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


