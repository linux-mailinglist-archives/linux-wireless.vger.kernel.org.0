Return-Path: <linux-wireless+bounces-13034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA3297D00E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 05:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D4283EA7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE010E5;
	Fri, 20 Sep 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FmGV8C3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6502B65C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801617; cv=none; b=TDdicvle0scVlViurbP6wCtQp1gNUakpO3dOLsfOt0iMCyKthbpqDfNVI3An30chgiL9nXQCkSj9iHVKfbOgdohkRkCXbQ0OO/lbHlDlDpJxlQR8Rde446Im803g3kCx126h1XfofGBHITghFhun/NDiJZYR/qpDv3OIqNtAUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801617; c=relaxed/simple;
	bh=wPpgAIIkM7/WOWM/TM8WahYTSiUm4VqbFrGkdFfvTfM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=mUx7yKL0q8E9KSLPyEL9Lf+n5RBuS48jOH06ULdde8/v3DpQ8ZRYR3Kc69wSf1Jj3d78E4qiVqgvtJpJ/60rk18SHHXeGARIlMIYzhTloudYiAs3rmdpsShdV1IcW8SrBhXsYVD2vMShDdMURLYGFqNUMN8Lv9NF/+r/mJK3x8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FmGV8C3c; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K36pqS6499217, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726801611; bh=wPpgAIIkM7/WOWM/TM8WahYTSiUm4VqbFrGkdFfvTfM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=FmGV8C3cApLKCULBgTEKeOSRTpa3g/u5ufwudd8oEZpftHNGBM0XIEXVbltSGhf2S
	 Taa1/jPuymLuDVHBZQf2KtCKZwQ1mAJxBak3LxESjRtKb2locaBihRttBsG4R4lArB
	 WFucLGJBNbhEE5Gnq8fsJjGDQs1nzFUUM7NLngNyZmuqOc77E7XoJHClznGDAqjUkW
	 42u9CRpTU0nOkppkc4J4Gl9Jei03+vTxYl8+cMrtah6Fyk05FABJoC3N2e9MNsimPm
	 VEyubQUqs1EhBpQo4U6r8URMZS1tXSimlQ5ZjWVeMeash78pvhjhYh9GMqMP97GCDu
	 ZkwhBd8wHDGWw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K36pqS6499217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 11:06:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 11:06:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 20 Sep
 2024 11:06:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: Constify some arrays and structs
In-Reply-To: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9417395c-821c-4f77-b04f-4efa55fe7214@RTEXMBS04.realtek.com.tw>
Date: Fri, 20 Sep 2024 11:06:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> These are never modified, so make them const:
> 
> card_enable_flow_8703b
> card_disable_flow_8703b
> rtw8703b_ops
> 
> rtw8723d_ops
> card_enable_flow_8723d
> card_disable_flow_8723d
> 
> trans_carddis_to_cardemu_8821c
> trans_cardemu_to_act_8821c
> trans_act_to_cardemu_8821c
> trans_cardemu_to_carddis_8821c
> card_enable_flow_8821c
> card_disable_flow_8821c
> rtw8821c_dig
> page_table_8821c
> rqpn_table_8821c
> prioq_addrs_8821c
> rtw8821c_ops
> 
> card_enable_flow_8822b
> card_disable_flow_8822b
> prioq_addrs_8822b
> rtw8822b_ops
> rtw8822b_edcca_th
> 
> card_enable_flow_8822c
> card_disable_flow_8822c
> prioq_addrs_8822c
> rtw8822c_ops
> rtw8822c_edcca_th
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Note: only partially apply patch 1/2 of original patchset.

1 patch applied to rtw-next branch of rtw.git, thanks.

140403599b74 wifi: rtw88: Constify some arrays and structs

---
https://github.com/pkshih/rtw.git


