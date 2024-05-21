Return-Path: <linux-wireless+bounces-7876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B48CA999
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D31C2132B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74E55E48;
	Tue, 21 May 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBzxfYVf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9855C35
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278686; cv=none; b=XAJjaWPXx7UcfhQ8izMiPMAe0qOurCnrlHjzNL5cXZQDtg8mxzneLS8dQSybOj04xbXSqGzc9Fp2vXYmvquirziPOUZkT+DjAZEOHgSLts+Mr9fsC+78q1hyDgxosw8RK926PGBZTP/ZuWfJBSjqi/5EgZ0LgOCmjjwix8zFFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278686; c=relaxed/simple;
	bh=NcSOlTnJ5jJM2S0GNJGH62zu9GD9MTBkYBrkBqGgDEg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TmySoG80Fbd+lGQirbIDP/ZoY9t7PPgd0oUfsA9/KGSj9Fk2FTKPN/oZM2Jn7zlhpKu1ij7BHMgSjgVakHfhvuiFjSZchmCLcTiZBfQ6j9XfBfOtINo5kwGmJyEYL+SEefsXbwWAyEAo4PBedC5PrP5pl6xUQBFqon/o3CFVws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBzxfYVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3EBC4AF07;
	Tue, 21 May 2024 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716278686;
	bh=NcSOlTnJ5jJM2S0GNJGH62zu9GD9MTBkYBrkBqGgDEg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZBzxfYVfMM5kjS3o7b9dJPKhCOWKG0l8tzSOGNJkshTr224PlDU6Ezz+S7gVstZ0x
	 35KoKFWoAJeguv1hUk6jY3FISE+AMFSa6YLGIhKn3+AcUgO5JqNLaja30ZmBadXs0W
	 OqHqetta8olXlD9PkmKz7JEXq3tcvLXjWSKy58yItN8eNAat9weTfN000ZYXCKkcJS
	 O49s7ujfLJqz1/sCjfYfk98yAF8NS3MzPXjk5ynVrJmwt9n9NFb5sTq4P3TY/UjAj/
	 ctkLFM44r1FecPR2DOjleP8zvxwRRw1xlFp/sz5nIjmxJwsVKQYOo0ZGdIGjjmFVcF
	 Fo4ZGuXN7eljQ==
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
 <quic_cjhuang@quicinc.com>, Luca Weiss <luca.weiss@fairphone.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171627868306.3970531.273322605619339350.kvalo@kernel.org>
Date: Tue, 21 May 2024 08:04:44 +0000 (UTC)

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> WCN6750 firmware crashes because of num_vdevs changed from 4 to 17
> in ath11k_init_wmi_config_qca6390() as the ab->hw_params.num_vdevs
> is 17. This is caused by commit f019f4dff2e4("wifi: ath11k: support
> 2 station interfaces") which assigns ab->hw_params.num_vdevs directly
> to config->num_vdevs in ath11k_init_wmi_config_qca6390(), therefore
> WCN6750 firmware crashes as it can't support such a big num_vdevs.
> 
> Fix it by assign 3 to num_vdevs in hw_params for WCN6750 as 3 is
> sufficient too.
> 
> Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch should go to v5.10 but I'll wait for Luca to test this first. No
rush with testing, this is just a status update.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240520030757.2209395-1-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


