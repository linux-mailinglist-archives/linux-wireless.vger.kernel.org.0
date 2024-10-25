Return-Path: <linux-wireless+bounces-14488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096989AF74C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C94A2827AC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC31E89C;
	Fri, 25 Oct 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rJI7U4BB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E73FC2;
	Fri, 25 Oct 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822572; cv=none; b=dCcoHrBSWUq80egBT6lJTApYm2xdZthQXaVNkvk30cSkAoXMdvloiAta2gZxCy42QstLk50YdpTlik1W2PPflhkrhDjtydsS8q3JTTVjLuxmG7mxmC96/04Rjz4UQBkPvy02rOsiUnS/bRyxBKHBL69IGUQCAQIngcHiJ5uR0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822572; c=relaxed/simple;
	bh=fAgb2z3BkjXBzDU94j/sDchKeauwi+gQEKMjhzvHXb4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=CJw7Q48uGCHAiw751txyFpySWKPFXjyCKFDfXxHkJcP8o+3h3chRk8FAK2IfHJrAa3rTQZnC+MHBfMGG9WQ0nF7JGWwp8kuaqiL+dW8pjnzoK9m7zoQrpuNIOZJkpcpmKfI6w2u2NlB7gYqS29/c9LxuIGLKghp5nBvx24AyhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rJI7U4BB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2FpmT64064862, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729822551; bh=fAgb2z3BkjXBzDU94j/sDchKeauwi+gQEKMjhzvHXb4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=rJI7U4BBDmwM9tGnFwt9/rOhpIeaZR+r9f6OLzIagsK/5meYoCgASbRCa3xgJfRTE
	 JpPbLjAk0L/O8Kbqp1oXOp2iV79AsebT8gML/Bl/OKo+S/2lVt2LQUxXrJn9baujzk
	 khDcIKODzpc1cYJSFpkwaqqLQnkoALY7pbDZ1alVJAVZTv9WJBUu43T7N6S4z/h8E/
	 7DCMu2QXsUhprUO9JhEn6UTXiAHC/karvnjvOttXO9FxIETsbcTB4OEpqVUWS2GT4e
	 7js7nNqUdFu5F88jJHkpovLRlnOQkHZD85iyV/APTOhxeRtFPaQiQI1bwKW7jTn/FP
	 43CycjG7JFVEg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2FpmT64064862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:15:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:15:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:15:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "Mohammed Anees" <pvmohammedanees2003@gmail.com>,
        kernel test robot
	<lkp@intel.com>
Subject: Re: [PATCH v2] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
In-Reply-To: <20241017080638.13074-1-pvmohammedanees2003@gmail.com>
References: <20241017080638.13074-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <32bc24c5-3347-4222-94e5-69c1e8d9b3bd@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:15:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:

> The previous implementation included an unnecessary else
> condition paired with a continue statement. Since a check
> is already performed to determine if the band is either
> 2G or 5G, the else condition will never be triggered.
> We can remove this check.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171143.OnFlgIwK-lkp@intel.com/
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

7846f0b63562 wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate

---
https://github.com/pkshih/rtw.git


