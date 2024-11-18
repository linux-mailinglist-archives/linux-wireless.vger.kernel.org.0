Return-Path: <linux-wireless+bounces-15453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF19D1097
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66884283724
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD111193426;
	Mon, 18 Nov 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsmmmuSn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D9190665
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933253; cv=none; b=S+nM2hkepCouT5lCWUGBvMO12wlXFcY8nF9LVmvClQQMxSdXiD2tWKVXdYDyqrx/2NPw3Y2M5BVGUWZzd6x6DRIfFaa2I8H+2iRDWNGnw+9NkHsAbVwj2zb8Ix8g9GuekFiYZfWIMpZLXJ/sxkCWgoKSvD0ggXbWGi7Ym1AnDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933253; c=relaxed/simple;
	bh=AK3VFBJiEXeyudp+DszCWi2dwzhFj45aH9ETUvd2rg8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QzztQgKBZvh4uMwIYgUo8Oe5YWewel4nc3TCWdMzQXgR+JQiMNMqaRXRp/c76PvO1EcclVW3TJs4/Ua0ZI2Qvp5ViiSeuR0GeZjEnXl7qSiyPskVC6vz58AZ94IPiJYo2/rblwMl4RfPSRLelNi6f+5fYT99OpHDUPxtI0nVmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsmmmuSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE1C4CECC;
	Mon, 18 Nov 2024 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731933253;
	bh=AK3VFBJiEXeyudp+DszCWi2dwzhFj45aH9ETUvd2rg8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EsmmmuSnmh7LOAuo0ljU1/LHasr+Ung1Klx9Ak8gV/xsCBKG19N1+2jxqK+cfQxvN
	 j6/W7E8RK2UdOUNT+vEQ5cTAJkI7LM3xDx5rdHM5QpfxrSetbY2HwCaamwGQV0nhEs
	 oegjzakisuQBZ2XBctOJG/HOZo2yxUuGQ5xHoE/OM5U7PiPDqzjFndxBcdPPv64tZj
	 783wbGGPTm38+U4kf3H2ikPz+dOB/nvgTxBaxSyVNKtegcDevF2FuR4VdZAUGqAiZb
	 nXxnj3wm9n6jKYPHAH+NwxzLo6UySprQm6R3X7daeuBr8rkpVCSyuRb1z7l+CuOHO3
	 T0+bjTqJQ4Alg==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>,  <kevin_yang@realtek.com>
Subject: Re: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW
 supports
References: <20241118040255.40854-1-pkshih@realtek.com>
	<20241118040255.40854-2-pkshih@realtek.com>
Date: Mon, 18 Nov 2024 14:34:09 +0200
In-Reply-To: <20241118040255.40854-2-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Mon, 18 Nov 2024 12:02:50 +0800")
Message-ID: <87mshwvhz2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
> called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> And, one function of it is to monitor PS states of remote stations. Once
> one of them changes, FW will send a C2H event to tell driver. With this
> FW feature, we can declare AP_LINK_PS.
>
> For now, driver still needs to determine if a frame is ps-poll or U-APSD
> trigger. So, add the corresponding RX handling in driver, which activates
> only when at least one AP is running.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static inline void rtw89_assoc_link_clr(struct rtw89_sta_link *rtwsta_link)
> +{
> +	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
> +	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
> +
> +	rcu_assign_pointer(rtwdev->assoc_link_on_macid[rtwsta_link->mac_id],
> +			   NULL);
> +	synchronize_rcu();
> +}

In ath12k patches I got feedback that synchronize_rcu() should not be
used unless we explicitly need it, for example if if we free something
or similar. Just wanted to mention this, up to you if you want to keep
it or not.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

