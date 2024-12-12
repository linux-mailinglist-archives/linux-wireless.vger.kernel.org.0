Return-Path: <linux-wireless+bounces-16279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC49EDDBB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD20282D71
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B042AA0;
	Thu, 12 Dec 2024 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ll2ihioT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8D18643
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733971453; cv=none; b=Dt8fH2+wZZAyVlRbIHWFpTYMKaFlYimCSqKZKBlJK+lDEfehR9QJL/g1+d1upAnfVBazerPIJU0lMgYJtYvdljqmVwxM/SLls+k8a+nRj4stiEPa4xYNQefY5v/1lE25VWk0vopSdM2GUA3isyAN7BsQGxRkKo0uvQSH3qBTaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733971453; c=relaxed/simple;
	bh=ASG4oYz7lw2/foKtrHRz97Mu9DO7gbFUojJIHzNPwPU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=NGXHrVTaOG455Tj57PaSDv6x7ZKaBzAShK/L9aLSvPo2LL9bgMCbm0yM7hwmLPH70zOQyKgZ56Zyj6zojjuUfI/lRdxJmBSVVfNglAXNzTp+NdTWVKo3HNuFAYC+k8ujYmYLkiLBklxfQlIhVZ1NXqJV7NJNjEBT8jVdnSrNm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ll2ihioT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC2hkwtF498243, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733971426; bh=ASG4oYz7lw2/foKtrHRz97Mu9DO7gbFUojJIHzNPwPU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ll2ihioTftLfpi9tuJ/BAgyowNs/3nnYSBHMjIutEuEN0eHyMtnyxfxajptIexKRM
	 GhlTfFWFytuRlcKYOuhtZ2ACpjSyQKG/JKpoZ9pD+J+PRJSLMMCo95ZMXkqAPnv4Wz
	 Uso/5oBLbRiG0iQc92XlJPH6cdlkPOCluLzm+JO2Qr13vqbb8sz/0X0Hp9c+F+L7OX
	 HzuWRUv2mvZen01UYPEnIXXsOE6SNhLPvFtAYPqa4yMgYCsvPMbYlw1eWjpflGRo0T
	 3wynQ9VIu8FerXehYnOBSU2RMpXDOb3iOPpteUcyNPYbGsK8UArwRhLGtbsGiSppGq
	 y7xSziBjUw1HQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC2hkwtF498243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 10:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 10:43:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 10:43:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <kernel-dev@igalia.com>,
        Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH v2 1/4] wifi: rtlwifi: remove unused check_buddy_priv
In-Reply-To: <20241206173713.3222187-2-cascardo@igalia.com>
References: <20241206173713.3222187-1-cascardo@igalia.com> <20241206173713.3222187-2-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cd1ad5ec-cb29-44a7-a7b9-faab35742af2@RTEXMBS04.realtek.com.tw>
Date: Thu, 12 Dec 2024 10:43:46 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:

> Commit 2461c7d60f9f ("rtlwifi: Update header file") introduced a global
> list of private data structures.
> 
> Later on, commit 26634c4b1868 ("rtlwifi Modify existing bits to match
> vendor version 2013.02.07") started adding the private data to that list at
> probe time and added a hook, check_buddy_priv to find the private data from
> a similar device.
> 
> However, that function was never used.
> 
> Besides, though there is a lock for that list, it is never used. And when
> the probe fails, the private data is never removed from the list. This
> would cause a second probe to access freed memory.
> 
> Remove the unused hook, structures and members, which will prevent the
> potential race condition on the list and its corruption during a second
> probe when probe fails.
> 
> Fixes: 26634c4b1868 ("rtlwifi Modify existing bits to match vendor version 2013.02.07")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Correct wording reported by checkpatch in commit
"wifi: rtlwifi: fix memory leaks and invalid access at probe error path"
during committing.

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

2fdac64c3c35 wifi: rtlwifi: remove unused check_buddy_priv
d8ece6fc3694 wifi: rtlwifi: destroy workqueue at rtl_deinit_core
e7ceefbfd8d4 wifi: rtlwifi: fix memory leaks and invalid access at probe error path
b59b86c5d08b wifi: rtlwifi: pci: wait for firmware loading before releasing memory

---
https://github.com/pkshih/rtw.git


