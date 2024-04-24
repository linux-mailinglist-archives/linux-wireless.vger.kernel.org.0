Return-Path: <linux-wireless+bounces-6768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AA8B091E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFBB22695
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2115A4BA;
	Wed, 24 Apr 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMhX2I3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516111DFCE
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961238; cv=none; b=QDw01sTma790zz2vG7bbBWtwugovzMKn4e2wk02KvY2QGKT1bismNE8TNYiRMLboCiYoxt6YWz5cWe0hgCfQNmMur14d5a3qMhQWx4p+JZJPbVqScKfwGuzCHH6MuFhC8WwUx81c68bpvM0MywiivVe1izQuulONK5iL41458qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961238; c=relaxed/simple;
	bh=9z/dwUBt/YCH6nE7fyydHYHQPhYb6AEbu6BFuSqaymM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=idFyOXVwn4vgMBOJNE44rLHxN5wpigSxkLduBITO7oZirSXO3OmbZiw46sM//NZ0/mTe6+pyWxgIeE7XRedBM7cs7olDQJKBmHEg/JUnVXiSie+40jP7rN7RZ9Hqb9JlE1QPjwldJzFDFj81IdvMkBTHbqC7HmrzOLejsNHQzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMhX2I3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F347CC113CE;
	Wed, 24 Apr 2024 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713961237;
	bh=9z/dwUBt/YCH6nE7fyydHYHQPhYb6AEbu6BFuSqaymM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZMhX2I3gXmMQ7JSi6/Ly0yFRG20ERwQ0ArAC/hUF/uqzZdoSG05c2Gf4IOmQGMshw
	 z8k+/r793R87rcMkDS+JmrPUJcqBsZ1HJSbwJdfpsiaGEJgBG8vU+idOuLjj+bNCOO
	 FT03CEop59ISQ5QuLu35EokJuExwYEU4bx5RZ4liI3elxND+chWjVyyu5nXnoQCbMY
	 zQd4R8N7P/gnNgao26yBajyQctcLuGcS1t0iw5IWRTSgHTIHxQYe/iwiNduNYncQyh
	 0BQHq30wnEZtTn51TVg3/Aad15d0onQZaitDXQpG0v4TEMEeomL9181KRaOL/djDRX
	 P9CVlzOjGKPpA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
Date: Wed, 24 Apr 2024 15:20:34 +0300
In-Reply-To: <20240424064019.4847-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 24 Apr 2024 14:40:19 +0800")
Message-ID: <875xw7t0j1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> ath11k fails to connect to 6 GHz AP.
>
> This is because currently ath11k checks AP's power type in
> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
> However with above commit power type is not available until ASSOC stage.
> As a result power type check fails and therefore connection fails.
>
> Fix this by moving power type check to ASSOC stage, also move regulatory
> rules update there because it depends on power type.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>
> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> v2:
>  - add check on 'arvif->chanctx.def.chan' in ath11k_mac_op_sta_state()
>    to avoid NULL pointer dereference.
>  - add 'Fixes:' tag.

Thanks, this seems to fix the crash I saw.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

