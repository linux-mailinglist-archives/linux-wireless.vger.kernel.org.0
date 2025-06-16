Return-Path: <linux-wireless+bounces-24121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08653ADA6FB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D44B3ABB37
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B583919CD1B;
	Mon, 16 Jun 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WfJPTLxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FD2B2D7;
	Mon, 16 Jun 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046054; cv=none; b=HeFVSAK4K5kI7QqXiGRf0+7KH+4NP5NhELsvmYaWceIcvpottPJMwPLiL0DGcO8fUw7skAmRLoHu+KOqsJZ9nPkZk2baw8DMLKgwem3QZ+6qBvpxkuSB2qVh5tVg/0REE6A5OReLUqNpWij5NiBw9BWj254BILLDKsYLGAn5zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046054; c=relaxed/simple;
	bh=PV8rThs2JacW6Sd/SyCVh/lDg22Vnd7ArbAbo9rk4yU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=BjEXCfaj5yUyUmqiEl0JqfOYin8Zv8sGK8XuqDEkjbgbkfS2JP0z6PVWjhdvGQq2643tbMXO8LoE8i/hJ2l8A+mp1KQsWjX6CjAlETYtuc2xDu54+VFZG7oEyY4n6XWCc0ANwRyO4U9eMSzXR8kpEmEopLtIbFyfB9GrVW56exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WfJPTLxP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3s8QQ14017165, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750046048; bh=0rSkfoBswAcgu6JyvgpiC+RiDHtdMBEfWIfKopwSJvU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WfJPTLxPRapeH9+z9UQlLTpcDhwU7yBARME04fZVU0urYj8v1hkCsgyzPsorMr8fZ
	 c4c2O1Vzg9xLGRvkUhcjTDt2D8HQviB+xWNhocYkzNglC2tW9jlypHNNbp+sa9QnGr
	 NmVqhRU8ZNnu0DD4Sr5bYQwOaT4QMvz8EGF0ldhiz8Acmss7ncqiicezUTDcrqV840
	 orhe5z09Xxg3FgxnvBmDOcVaps3ldX3HUAKKXAhuNd/jnr8L9LYWdHvY4EX1m41pfa
	 Q/eNiDWIZTQFZ5wR4JqAuWlOiy/m56iX+pQPDg1Jye4o9z7AglWR5/zVc0+llzzQtG
	 NXl/OmNumuo6w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3s8QQ14017165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:54:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:54:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:54:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtlwifi: rtl8821ae: make the read-only array params static const
In-Reply-To: <20250611135521.172521-1-colin.i.king@gmail.com>
References: <20250611135521.172521-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <66d8a2d7-b933-414e-a741-054238b24777@RTEXMBS04.realtek.com.tw>
Date: Mon, 16 Jun 2025 11:54:07 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only array params on the stack at run time,
> instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9b550b98f0da wifi: rtlwifi: rtl8821ae: make the read-only array params static const

---
https://github.com/pkshih/rtw.git


