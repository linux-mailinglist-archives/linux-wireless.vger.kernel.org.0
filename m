Return-Path: <linux-wireless+bounces-30210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B5CEB827
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623AC300FFBE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28B30F925;
	Wed, 31 Dec 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kqvpXDdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E5189BB0;
	Wed, 31 Dec 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767168502; cv=none; b=B4SNwvjveVrp6WPrXZ/VdxoHgcrO/wIXi0PigNOorrj5q/2bTAvzGV7pIOLgMOg6pcjrkJQrErg2J6PmL0kVw3qMkResyODxoD7Jf/6amSBXzWiI+I3LfThI5W2O9kYEYs1UgLBoTiAhWylIbApkARbYzLMa+kfmtHayEK8/yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767168502; c=relaxed/simple;
	bh=JW1BLqhvvHBAxaRR8io3zgL4Bi+efVFTHEmBK41At0U=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=l605SGcJcv4nvYm+nSexqAakrLjEWg6FAXiEl0XEZw5SUe9FaG6/fnqOAfH8J3yIal7uKr+5j+gas/WNzD1qkESTma2DJeK93b2sUV+ml0x/OqpPfrBzueKOrWDmUpZGOThKbFJbFJtVB1ZjqJ+PUQfNuWyN82Pz+gYKhGPtnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kqvpXDdM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV88GCL0804020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767168496; bh=HbsTUo6pLUvdS942Jaa04PtVAWHJdG8hha8lCaKzFZQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=kqvpXDdMgBzfKFLqH1xI9q5q/aWjD6lTSPodQ/oXxHCpCFwxGtIT220LfsLhv9tN0
	 DBL97cBwInyuaBQMEFA4/jRSPANVPJnlpqVOPKT9N2Dofc1hvhuOhMpfKuvMns4Xpo
	 1OMoE5DLc8rbF78yvfNQJQAhiJ7mzKeiVa3InKTx9mqyi5rMzuYdbOjrSMDbMwoYx7
	 GiC9KPYC299PtuExDpOcFvprAybjxTJgsm0TxTU07jPe5WVlnfgPSDYih4kpQdI3dE
	 hpb/OpYyyqEbzWn8DfRECMLf/TWXr+w7sEzRmjkyAvS0GNhEIB9U+wMS5tcX0tv3jp
	 hWOv1CmmXWMRQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV88GCL0804020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 16:08:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 16:08:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 16:08:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Tariq <alitariq45892@gmail.com>, <Jes.Sorensen@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Ali Tariq
	<alitariq45892@gmail.com>
Subject: Re: [PATCH] rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
In-Reply-To: <20251225115430.13011-1-alitariq45892@gmail.com>
References: <20251225115430.13011-1-alitariq45892@gmail.com>
Message-ID: <f05788ea-fb2d-4152-a4cd-016d4f5e8273@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 31 Dec 2025 16:08:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ali Tariq <alitariq45892@gmail.com> wrote:

> The driver does not set hw->sta_data_size, which causes mac80211 to
> allocate insufficient space for driver private station data in
> __sta_info_alloc(). When rtl8xxxu_sta_add() accesses members of
> struct rtl8xxxu_sta_info through sta->drv_priv, this results in a
> slab-out-of-bounds write.
> 
> KASAN report on RISC-V (VisionFive 2) with RTL8192EU adapter:
> 
>   BUG: KASAN: slab-out-of-bounds in rtl8xxxu_sta_add+0x31c/0x346
>   Write of size 8 at addr ffffffd6d3e9ae88 by task kworker/u16:0/12
> 
> Set hw->sta_data_size to sizeof(struct rtl8xxxu_sta_info) during
> probe, similar to how hw->vif_data_size is configured. This ensures
> mac80211 allocates sufficient space for the driver's per-station
> private data.
> 
> Tested on StarFive VisionFive 2 v1.2A board.
> 
> Fixes: eef55f1545c9 ("wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()")
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

86c946bcc00f wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

---
https://github.com/pkshih/rtw.git


