Return-Path: <linux-wireless+bounces-30076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E084CD8050
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 05:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 955A13000B00
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927851FD4;
	Tue, 23 Dec 2025 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TSycL6Cy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921755661
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462665; cv=none; b=mbjQdq+5t29GqVLQwlwiszY1B2tKvN9QVlDC+lKLHgLZ7AqnG3OpELqn0NuU8Jpl7PvOe1gsQajmOvcPZ3jJqctDt/CRyesmQqanqwd578+nmfcWQeMFwsdHWd+QT3lmvSHwSyPeXVph3IzVd6zY3AxpIB/JRpShIvSCQU3xMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462665; c=relaxed/simple;
	bh=xxETDOFB8FnbVfm9pqoVxIiYJVOa2BOuRCUKVKp9zBM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=KNmiMf+RQb493QyM/zGlSZa5f4ShOeMuoLKCsYqxRoUrXl4QtjcEP3WFNJRXzII0Up0Xszmny5MFr61V01ZQpiX6QAsuzxDhae9MSZ/MhZuJn9WidAAVbYGwUGCHLhJ1xTFpmKQz4A66Ja9gk7GB36xgk1WmDlnGVU5+doHG5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TSycL6Cy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN4497Y0646466, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766462649; bh=ukL1kDttKEXxil4lJL7M8xDXuAbbtINti49C894yc9g=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=TSycL6CyBzrrSo/uS1zoETrNzqKUa/W+PKm81yyogEewGDEhkHvkprlbhpsM+r00r
	 9p2/28uxIG3sV4hY8AQe3vhROeaQXKAxYApdsK6Zu7xnhtMFkuf268/7ptI8vDoy2Q
	 Pnvq9EPie84HVNjr8Zg+W6kPvbrzHGNKntBWG+GcStaofFD+c6JIKiwuTRTUM54JkW
	 ZFldg21B3oIWSgsKa6xgovno+q6wd5djhQrSjhsR70fljgosOP20YLgTUufvk1YCpn
	 NUYLqY8shw2ANeJaDo/Ngj0TvP/Rhdoo7JAjI9nHufTW8OWgldD8PVtHxsrwyhmohy
	 DzyVbjx+7BkPg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN4497Y0646466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 12:04:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 12:04:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 12:04:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <pchelkin@ispras.ru>
Subject: Re: [PATCH rtw-next] wifi: rtw89: correct use sequence of driver_data in skb->info
In-Reply-To: <20251217072646.43209-1-pkshih@realtek.com>
References: <20251217072646.43209-1-pkshih@realtek.com>
Message-ID: <e4a5de60-84f4-48ca-aa72-e7977c9585af@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 23 Dec 2025 12:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> As ieee80211_tx_info is used to assist filling TX descriptor, and layout of
> IEEE80211_SKB_CB(skb)->driver_data (accessing by RTW89_TX_SKB_CB()) is
> union, so driver_data must be used by/after rtw89_hci_tx_write() or just
> before calling rtw89_hci_tx_write(). Otherwise, ieee80211_tx_info::control
> data is overwritten.
> 
> Found this by using injected packets which uses ieee80211_tx_info::control,
> but always sending incorrect data rate.
> 
> Cc: Fedor Pchelkin <pchelkin@ispras.ru>
> Fixes: d5da3d9fb05f ("wifi: rtw89: process TX wait skbs for USB via C2H handler")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d3a9e132a4c6 wifi: rtw89: correct use sequence of driver_data in skb->info

---
https://github.com/pkshih/rtw.git


