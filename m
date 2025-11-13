Return-Path: <linux-wireless+bounces-28880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1DC555E6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C12F3B461D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3942BE7A3;
	Thu, 13 Nov 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AGnW19pN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629A2BE7B5;
	Thu, 13 Nov 2025 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998755; cv=none; b=McucrY5Ubu+GBK9UTmRJAkY4XKJnmyh3Mpn0Y8sx+p28tSj4/mvUM4xKiy65+zIEeKNlyIagV1vVXl71f3eA9Vjvzo4tzF8xQMbu7fFupSBd3vxL/v0C8GTAiiOghrSTxOoAkdF4V+6hx93V2iGvOGG0Xh5vIZZo55W8oEl9EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998755; c=relaxed/simple;
	bh=luvC7UMMg+vekvuvHBZQoxythFXhFsgGjDrkicSEtbU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gu159MkdMWn8oplLsMyeZ271yI6KKyB76Kc3T9Ex/1TMMr0VZxFCajD/Ud+ct1fxn6buhcvsNLpciaIeMyZQaR67tp/TYM+N+VmnNOoG4WwUWJdOtb4HDMj8GgqR99peVS2X0TJaP/XFETT9oFLEt9hygA92BQxbr3ZAMy6HQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AGnW19pN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD1qSBj92729190, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762998748; bh=nVqZb2LmQwCNlb+Oiu4WIKIdNZRxZYnN2Uxjm8lRqeE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=AGnW19pNEkl7pMuOM6uLReRar0f3Ng9DNYDMOqtMCYlQbRG9+AhaoBRcjyZgt4d3f
	 WYl01fR2L6mfsUmtxL+6gp70YArgVlTgde44GdUptorAFEdkqmuxOyFkw0YffBlq8C
	 PT3LCa88ciXqnq4yxw1XvuajSFA/sd22mJsByveF5oLxWemxebBOJYTAUY7UTNd+lF
	 +F4kawzbMXY0f1F5wSLgvThVfnvbhA0ol+XeDZfAU2aqwWYfpi5XE76vwhPdpLSURn
	 SxiYGeCk7aEqvUf3VZUjf6dzNFkxIFJRhDjcLdXkfMZy33OZOKK6qM+/CWkzJzHkOd
	 j22PYrRbmAufw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD1qSBj92729190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:52:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 09:52:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 09:52:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Hamik <dan@hamik.net>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan
 Hamik <dan@hamik.net>
Subject: Re: [PATCH v2] wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle
In-Reply-To: <010f019a76e1a84b-0a6f5e9f-2a43-4a9d-9c30-de4ae6363011-000000@us-east-2.amazonses.com>
References: <010f019a76e1a84b-0a6f5e9f-2a43-4a9d-9c30-de4ae6363011-000000@us-east-2.amazonses.com>
Message-ID: <146a6025-1286-49bd-9e87-767236b7c10b@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 13 Nov 2025 09:52:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Hamik <dan@hamik.net> wrote:

> Add the USB device ID 0x0b05:0x1cb6 to the rtw8852bu driver to support the
> ASUS AX57 Nano WiFi 6 USB adapter.This device uses the same Realtek
> RTL8852BU chipset as other supported models.
> 
> Tested on: Linux Mint 22 with kernel 6.8.0-87-generic.
> The adapter initializes successfully and connects to networks.
> 
> Signed-off-by: Dan Hamik <dan@hamik.net>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ef42cf705ca3 wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle

---
https://github.com/pkshih/rtw.git


