Return-Path: <linux-wireless+bounces-14493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C99AF764
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CCEB21BE1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27BC16D9AA;
	Fri, 25 Oct 2024 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OFXWvgGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BE86AE3;
	Fri, 25 Oct 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823296; cv=none; b=BcWJv7g39mXuRkbum4+bhx4qDTVjkt9vDuGB3qRI/tvtVoVGuoYFABJDHpp3TrxMxg8RSSlHEo9Qv+R7FiMl5zj0UNhgayXUHN3whC12Ek0ljY527Lgao3h4LXxetkat/dRn8jixFaGLCdBy8Ym55Y7cGd8VmYoztSV4gTP7rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823296; c=relaxed/simple;
	bh=1849vjclysJZlv+ENKSy1ekASMxaCS8EE6Us0leGmdQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cvZ7pITHCY3y3Hv14G/LNUXYhD4lXo4V6o9HdfBIbbqn4x/ckyOQJyh3mK2WnKE+PV792Tu8k8bmoWErw6hu/PYDYTZxhzircJp5Hrj7FyJZxSFjEz8QqCT0bPZejXTnJVqXF9E141dRHqg06FKC94m7jpK2XUcTcGvaubnBuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OFXWvgGF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2S6R404101373, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729823286; bh=1849vjclysJZlv+ENKSy1ekASMxaCS8EE6Us0leGmdQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=OFXWvgGFl2ZMFjojvOxi4nrT6OXTfPVv1m0EqkZs1vvqd8g2xZlmY0NZxQLOoyDQb
	 rYHQ81/3wtgAY4X4CEKCsSgKBrvCGsz470uofBSxoQM5xjKuSZRINUGxnF6ZW8AWoS
	 iZmP9a6OeWUMWlDJpBSp1VlIRTU/d1lixI9Gc+PUuVTUdnEfH2HVmmMCLGc9Edc+jE
	 gj9jtzHlHQMG7Rz/LmVP28ATtc/1dy8Q3ll6h083B47IGWGx8GRkJJBOtewr6SgrFn
	 Nh57RuX2jHFoVppHZjrJZRWd3PoxPN5z2RX4RJOhJpNvGcHQf0FtmAzoLHbhPfy9Pb
	 dS5gpeGQ5gvJg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2S6R404101373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:28:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:28:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:28:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()
In-Reply-To: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fb15987b-3e1c-4922-890a-15b57d356136@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:28:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> We need to call mutex_unlock() on this error path.
> 
> Fixes: aad0394e7a02 ("wifi: rtw89: tweak driver architecture for impending MLO support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ac4f4e5a2039 wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()

---
https://github.com/pkshih/rtw.git


