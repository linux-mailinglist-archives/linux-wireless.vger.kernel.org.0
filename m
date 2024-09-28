Return-Path: <linux-wireless+bounces-13270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F054988EBE
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2871C20ACB
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76B15B987;
	Sat, 28 Sep 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY8cWr6F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB22AF15
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514999; cv=none; b=sg8cO0CnyQuhLJey81KxVScGj1uHdk5Eq/ooiQM0MEgikXugTGz5SZrFrqQ+cDkgc4s00hZzdFqSoQ+U0p73jzYuRU+xiMrL/GupMTuxvn0q/1UxtYPs+CDr2mo/4kDJmP1atbhxh60yD6TNwrOhWGgNs2MWkRLsAf1lb834x8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514999; c=relaxed/simple;
	bh=LOBf+j+tR+3OBDo0e9/2ULDyl7cpXfdowranANYZDg8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IJThtWx47M+UXxi0LR+M3sF3K6wbQ0wl0ZK0cPyZ8a5x+542iUB8My3jSGd3C+cjE4udJGCmbSTs/Fbq+QHMJd4kAUw51HAiTijmYVOffnIwNzZEAJcLAhoDsYlHfHWkHP9uJHPyNE5qs0apkbRTP4pY9rL9V1Wu3PLP4F1H1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY8cWr6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F8BC4CEC3;
	Sat, 28 Sep 2024 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514999;
	bh=LOBf+j+tR+3OBDo0e9/2ULDyl7cpXfdowranANYZDg8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cY8cWr6F+7+z/2dWiQWuMop9VkNdNfqEW5gzdJ1r0R+00lu5lHodYH+T9O9Bj9tRt
	 rXxIQp5DJqeJBHf/TxuMHHmqbF1F/I8qPJgoqjV/PNRkUyvecsMFFCLgHUbfEkAwUA
	 BgoTaSi2QIkiPVFtYWSnI4HCzZ17daMrHenGxEH6ZTftAlBaKa8GsWFpXEmOaah3X6
	 hEo/HfT1YtmS5iUnMguJ3bbyeXPLkhfMJWopbm9aOJPpQdfIr7so5vS4vk0XzAvGxh
	 MjVAzdrKTESpeHvlvO4qqejZz6wqoPIPPddx3D9IqWIORLy9yU/br1NpwIpuzHu+dZ
	 o8Yx5FJ1wDafA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath11k: fix the stack frame size warning in
 ath11k_vif_wow_set_wakeups
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240829075253.657667-1-quic_miaoqing@quicinc.com>
References: <20240829075253.657667-1-quic_miaoqing@quicinc.com>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751499620.2249584.15547291626292372736.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:16:37 +0000 (UTC)

Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:

> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath11k/wow.c: In function ‘ath11k_vif_wow_set_wakeups’:
> drivers/net/wireless/ath/ath11k/wow.c:461:1: warning: the frame size of 1352 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Remove the nonessential variable 'struct cfg80211_pkt_pattern
> old_pattern' by relocating bitmask to bytemask conversion into
> ath11k_wow_convert_8023_to_80211().
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6f15937833d8 wifi: ath11k: fix the stack frame size warning in ath11k_vif_wow_set_wakeups

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240829075253.657667-1-quic_miaoqing@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


