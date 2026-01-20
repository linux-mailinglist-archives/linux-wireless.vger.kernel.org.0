Return-Path: <linux-wireless+bounces-30991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF4D3BEEC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCB8E35E90F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AB2EDD41;
	Tue, 20 Jan 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BkfsUwfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A1C2EA;
	Tue, 20 Jan 2026 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888850; cv=none; b=JLv4kuMm3wMEGpbkW2KLIalrzgY7CRBW/gSIcpsnRBZvMkz+hQufcxGf6TW1DVwoznyNLyjDbVLjlGhX3dkRVH1kTwFwggqC0tIecRpu6RrOfu1CbTEpcGxDom9rbo1wBPYaTWfpQbTqDgmFgEtFj2KVZBF589amq1WRAGIMkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888850; c=relaxed/simple;
	bh=X3diWE39LSpOeMvjCSkX/NDB8S0lspwAi/++8XYVyc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trWJkMcNj0j8in1kIL7M15w9NuJ2s8e0oRJoM1XfnX3opA2Eb0hrOODPrP7XPsxQvB2f9W0mDNW7sR4MQnMEIk0UC6oZiIvbiFcW703HZH50eiJGOnuhstOcgVmW9+LvLPNw8aon98KV+huLODai+H+pRqb61AenodpwZ926yig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BkfsUwfN; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3141cf57d;
	Tue, 20 Jan 2026 13:55:40 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: baochen.qiang@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	jianhao.xu@seu.edu.cn,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] wifi: ath11k: fix memory leaks in beacon template setup
Date: Tue, 20 Jan 2026 05:55:38 +0000
Message-Id: <20260120055538.2355920-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <55fad8d1-ab4f-48b8-8712-24664a6bab2c@oss.qualcomm.com>
References: <55fad8d1-ab4f-48b8-8712-24664a6bab2c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd9f91c0303a1kunmb9fdaa681f5558
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGRpIVkhCS0sYSkseT0JPHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=BkfsUwfNtqwDiPfF0hpUYvGViw3aAOLXb76GmGlUQqdqIwrz3DZQQwywUrTWzxhXk07L/vXahh8rq+6Z6HDvmLHt2EH3QWoC8O/IHvK0MoxxR/VrnlrMPheL00twvA7GgclQjrbFg+1xfDOr6oqiQKJgdVTWAgPpjVvqFYYzJQY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=n1zVpj9IsnuM0bk4jSFrQkBRULk/cZDI0jQfItOtmuo=;
	h=date:mime-version:subject:message-id:from;

On Tue, Jan 20, 2026 at 10:52:54AM +0800, Baochen Qiang wrote:
> below would be better?
> 
> @@ -1622,19 +1622,21 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
>         }
> 
>         if (tx_arvif == arvif) {
> -               if (ath11k_mac_set_vif_params(tx_arvif, bcn))
> -                       return -EINVAL;
> +               if (ath11k_mac_set_vif_params(tx_arvif, bcn)) {
> +                       ret = -EINVAL;
> +                       goto free;
> +               }
>         } else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto free;
>         }
> 
>         ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
> -       kfree_skb(bcn);
> -
>         if (ret)
>                 ath11k_warn(ab, "failed to submit beacon template command: %d\n",
>                             ret);
> -
> +free:
> +       kfree_skb(bcn);
>         return ret;
>  }
> 
> >  static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)

Thanks for your suggestion. I will send a v2 to change it.

Regards,
Zilin Guan

