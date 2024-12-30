Return-Path: <linux-wireless+bounces-16880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16D9FE193
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267AD1881CDF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4233F6;
	Mon, 30 Dec 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mabyZmdZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764258F4A
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735521911; cv=none; b=VbBFK1pgezdgjcPhUiPO6ousa2khDD10Cb7GGLPckBQJwwCifQF4mMVttgGrxSbQsIi5KfUediZ1r2vIOtecf7NQXNxSgqo3E+zD3p3x46Mm2TSPhpvBx7D380GNmt5YUKXCPcAFD0WVzd/mSvyOJnOerPBGwGSzi9ypofjhY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735521911; c=relaxed/simple;
	bh=lb/LFVokK47+UeHR5XG3UU+z/VfIC0EJUfDiBlk0YlI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=IY/kGjOVrp4jorWE9XzzfjY6jFqIF/aAhGGLNPBoFtSh/7/vD8Wb6V5WN3amWRh74MF2MKxaEAtkqEFUxSBp/wjtK/HRn4JPLre8bTqc/eoAH1t7eVw5pWB7GOn7KgOCTc3EHSzPheGpAh8+74cGYXAcobB77i//P0mfBo5FeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mabyZmdZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BU1P4bR43529524, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735521904; bh=lb/LFVokK47+UeHR5XG3UU+z/VfIC0EJUfDiBlk0YlI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=mabyZmdZ5pC/GAKwxMKkqYptG828hf1rNMFUHH0tEARMoVr3wtglgu9zEU+HLeUF2
	 8oxt+ZJFfR00xeTUEYbLZrKBtqmPXUeryGn7jvPtPJ9JcxsfK0ztymEFHW+LCFq5o/
	 Q1//QxZ83HbfkgAESChEhtNBJrBdRjqgyjXRtQKM5hOqLhKpCuQAglN4/T6KAHsmjr
	 SDNT1GkF+u44ZqabHItDht+RtKypqlFoY8TDXOjJZv7Gkhic8SuduhoNz2JuiEcnHw
	 E8WkuitapMi87QI7gLQdM6YwhCDZ5MtsIzycGabKi10mYGW+BpaotQIp5ypSBsNksq
	 HoUoEAFQ6N2Yg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BU1P4bR43529524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 09:25:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Dec 2024 09:25:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 30 Dec
 2024 09:25:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID
In-Reply-To: <20241219014511.9056-1-pkshih@realtek.com>
References: <20241219014511.9056-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e573a9d0-1a68-4558-903a-fe528e415cae@RTEXMBS04.realtek.com.tw>
Date: Mon, 30 Dec 2024 09:25:04 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> To have better tuning of TX duty for fields usage, adjust thermal
> protection step to 5, then TX duty reduce to 75% at most. Add RTL8852BE-VT
> ID to enable this function by the way.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f8bcfb207633 wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID

---
https://github.com/pkshih/rtw.git


