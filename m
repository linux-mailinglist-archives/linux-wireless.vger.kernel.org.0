Return-Path: <linux-wireless+bounces-20991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E62A75EE5
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE457167AAF
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E644157A5A;
	Mon, 31 Mar 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FdI/Qh+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F41519AD;
	Mon, 31 Mar 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403273; cv=none; b=eY5n+ydUQCE39daIU1F3szwIrDHerfYyLfjijnIek4QsmD8dSG9LOuEOWaZhTtBCRZj3W2kNbiq/nhQVHyJTBiRJc5bmeWVkCO1EEfi3wgsgNqxPfFDxfPclea1r7V8GK790VcPVoN3UvDzt4PRzwuWh1OS2/nd2GGzbXDEHAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403273; c=relaxed/simple;
	bh=CQMUeawrnbn3960xAvV4VdQ6wKzEGLxky/5XdT+GlgI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=BiL9C1dbUMhMmlyoHSPHGSJQ2XhkNsRbBHyLehqOOkiDCYVNd4oCoUfRf+n4AZkkZBfW294Tau309k8Ir3N1AczqqBstSHHNpSjdSt95yb9mq6GYwwblLMmNZXQjTXep0OQW9NZlUZ188owCrmDfe26vdPYrjf69Ekorj5snOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FdI/Qh+m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V6f3D412916751, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743403263; bh=CQMUeawrnbn3960xAvV4VdQ6wKzEGLxky/5XdT+GlgI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=FdI/Qh+mYWsZPu9CMU91LdqqVZGhtK6gir8Xq51cBEdnCOGkFRwtJvh99UuxALhF+
	 NXdHbROuFvMiJlHvgPrk3WX8uy//lzActtDlH6QCpAontTOPAuhuFU4pYXJ8rzPfYe
	 5oYX9LPNaLzdcJQ9xVpcEtG+/OsG3NkChfZ5wmwjJM0Dpg/WO5eSqnUXFno9a+fy4c
	 TgNGxoucWmyVsrEzCOxzS5qCeqjiyxOkBnQdFhisRkMI/sJ33Sk2QflT5DL39RnxXM
	 PT7uvFPkRHCbVPZzuiyonFJYeSausdR1DQd/XI1YxNZEsHRzlCjHZCc9anTzYoGQR9
	 k1uDC/xcWfcMA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V6f3D412916751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:41:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:41:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:41:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chen Ni <nichen@iscas.ac.cn>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH] wifi: rtw88: sdio: Remove redundant 'flush_workqueue()' calls
In-Reply-To: <20250324075910.407999-1-nichen@iscas.ac.cn>
References: <20250324075910.407999-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6ca3cf39-3fe9-45db-af97-51dda65bd42e@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:41:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Chen Ni <nichen@iscas.ac.cn> wrote:

> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> 
> - flush_workqueue(E);
>   destroy_workqueue(E);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5c4cf36c538b wifi: rtw88: sdio: Remove redundant 'flush_workqueue()' calls

---
https://github.com/pkshih/rtw.git


