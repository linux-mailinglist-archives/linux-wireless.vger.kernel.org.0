Return-Path: <linux-wireless+bounces-11153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6F94C7E3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA701C2146C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325638B;
	Fri,  9 Aug 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BXffRjkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33614C7D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165732; cv=none; b=uX75SoeFQPWb3CQAOjuu6rP4TX5j0UqIdYI4uNOzKq5elFopmkfcZK4olH1nDXDal/1XzmJk3wHUW0rZH/b9VL17j3tnUS9UmrONnJUpB9qcoDLqtx/vQn+i2fUV5C7VHFT9WkB1ORQddjHfkKu4e71R+vDVmFyuXAChmOBEbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165732; c=relaxed/simple;
	bh=xRyVIGAhnT588mTqVChmj77An8dMtRXXwEPTL8x+oeI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=o86hq+ZpsQvqea6C6qbFDHs6fPeMVIDcQzoOwDkzr4/CZTAyDhSEkyILPcINx4rjCse4OwekrNuBFtB74qhiRl62fVEcvALSoiO2BtdVRBmDc7FE8/QUMyzxttCngTYUlTMl54vtZOPBf0jLj+OvlypQQkiQe+fskmxuBPI+Oq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BXffRjkv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47918ZZ80143371, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723165715; bh=xRyVIGAhnT588mTqVChmj77An8dMtRXXwEPTL8x+oeI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=BXffRjkvdWeQMScplhOjehZPCyf+hohxTxnqmmINX0cckZRK5A2A1YkwAXW1OZpfI
	 PhN646jp9+14MhdAItbMjjzaezzCxwvKLqIKxAKRjzhuDulN2g2K9xUjE8U8cjxRXU
	 eSZgwekn75qzOhgE8V7ZzV7aQE0/GESFgyW3Xwb7zbA3zn573M+Kb4SDkZVSVYVvqU
	 Rgbofq2jigLyyuL3ESwpNjrNEFXlkdMedEeTgjx0ZOpnLMwZt3huVA/k8axNPZ9QBH
	 KaODQJs/WuVrwFKR2tzQ6GPrQ2tdq9+DjDdXCv35JAGFRn0YoUQFUogTojHoqG6X9+
	 HHaZ10PCIydLg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47918ZZ80143371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 09:08:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 09:08:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 09:08:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Peter Robinson <pbrobinson@gmail.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: drop reference to staging drivers
In-Reply-To: <20240805221910.3765214-1-pbrobinson@gmail.com>
References: <20240805221910.3765214-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <73c4d850-a0bd-43e6-8b7a-321b55c75c2e@RTEXMBS04.realtek.com.tw>
Date: Fri, 9 Aug 2024 09:08:35 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Peter Robinson <pbrobinson@gmail.com> wrote:

> The Kconfig notes mention staging drivers that have
> since been removed so update the driver's description
> so it no longer references the staging rtl8723au and
> rtl8192u drivers which have now been deleted.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

1b84378b8fe1 wifi: rtl8xxxu: drop reference to staging drivers

---
https://github.com/pkshih/rtw.git


