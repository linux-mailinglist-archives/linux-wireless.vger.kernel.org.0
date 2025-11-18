Return-Path: <linux-wireless+bounces-29070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC2C6707D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5E1F828FE7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F82D0631;
	Tue, 18 Nov 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HQdQZwiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB91D2F42
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433275; cv=none; b=VBDPVfp5ckXDN4bRPcVdq6j7Iat4Oxbiw3RIoCTmfhBwXfBBkKeKAw1mz7VTclWQ9z99VpzO5mFyz27GkzPQfVvtmNfKPCOUxQIo6MmLHvjtp/JcitozNFraxnbE1EK/vEs/N8T4YHMuOyKtXjX7w45B7ell7spGPzD18O2w33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433275; c=relaxed/simple;
	bh=QCUbabH6UaeWXYB4ons/8XQsXHL16/CggLMTK4BGbl4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=LuPFEaqyAtwr3hQJYLJ8Eh6Tn2/PQQOeYQT++ndD0fV/0PguQQ5KAV6ZzWBuGOfk/hPsz3w5+cMwsPRU+cOKe9D8nt1L839VbBmtgQT3PKX+ODZHKn7VC4ImqCH7ZGrUYV9WalUedTbVXh4IYtPzaPZB78XdWp6nsKjA8hMBI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HQdQZwiM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2YT6s8649669, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763433269; bh=AWvZ3sX9I9b5uZzvfQGkbfPHdeXaZ0R5rGIW5eqd7Lg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=HQdQZwiMreUqI/uXPV3LLjGZ9wdb9ZkGV28uh1REXiklg3tr3o3fX/++a5yZVrmCS
	 Z59fLH74oMKOKyP7iJRrt/++HjabApbzfy5ZbP3j3jcjk817NlMRSfyK7svDmG/S3l
	 MgrMoeRecEqVx0oKSzVcUUDVp4XWCp05nVXyL5ftL9bneMFlhlQIXVMorMFoNWsWFU
	 xfVxSchv6muXAJxCACnwXYB4P1ykCCzDNRIseiwD8IPCrsup8Qf6q9+d1KrfktlfiK
	 0ah+JWCdQ+9sCMb1K/tS2stpzLOzFKoWsIWooYKYVf9fBNLwebQEvNAfqc7nK7apwz
	 bXA933dCyVkiw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2YT6s8649669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:34:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:34:29 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:34:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 18 Nov 2025 10:34:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>
CC: <usbwifi2024@gmail.com>, <zenmchen@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU
In-Reply-To: <20251116234403.8803-1-zenmchen@gmail.com>
References: <20251116234403.8803-1-zenmchen@gmail.com>
Message-ID: <ef465b24-d8ec-41a9-bf9c-09b1aecd03d4@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 18 Nov 2025 10:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zenm Chen <zenmchen@gmail.com> wrote:

> Add 0bda:b831 for RTL8831BU-based adapters that use this default ID.
> 
> Tested with TOTOLINK X900USM in station mode very briefly.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c453d9c5bb8a wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU

---
https://github.com/pkshih/rtw.git


