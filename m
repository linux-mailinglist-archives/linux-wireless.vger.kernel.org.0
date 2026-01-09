Return-Path: <linux-wireless+bounces-30594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B02D075D8
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 07:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF658302929D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE131DF963;
	Fri,  9 Jan 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PQrsztS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949F1F94A
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939365; cv=none; b=ansc6UZOritkJJdjOaBLiPfWwBV18IpOvVxOozMnfL7LDjiYRBhUO66RAgXvgbd5Y3/zMeKwgQpGbDUDULdmE9I/BGdhCX+IFjbxvD72r879YtLVY0i7mNbcmxSq3jttlyhwLXTs/DJHRt4bjpCtNS7ce7vAP/bMMpC5ZWowUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939365; c=relaxed/simple;
	bh=m+kJ/LksYC7Y9dBC6AxBxtKeWARVKZCJyJhNtJ+yOys=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=T27wDDpPuvpRqF62vrUEGzF784qcGbHeVFe1iuRbbVsiCqqY84Ny0aRt5Yui6+QtoYOaLGHlt2Jeyg0jGc0FhSR1rjpueS4sT7rA1tNCmxQvJqRe19nFHtJgLWk9pEXjaJj8r3sRWbu6afZa5V7bmKuuc5sbbD2dDriEyj9iGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PQrsztS0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6096G0FS02637291, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767939360; bh=M9Yyhiq3xK12NiGvJA7JVOhknGTNi8DNE6K/U7DL7fg=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=PQrsztS0UwJXbtrEw9p5Bay9dbuUuCq0uZbYvCuYPvbp8VuJV+wEANYh0SQ/JkR00
	 yvhd+PRrmepGGJQzoELAkQaO/eF6sGx1emxRsPGhHhL5pMW+S9ZOF9vK3uy5MuRX+b
	 ZNVNwwejFuIEHhOiNbL6gGrhydUWEksMpJSAdAJMRP0r0XyFNiBOezAjsLXaIkxJQk
	 /RHdhfEuG7lj7LkNm2ogz4d9p7eiA2ZTC8AvoKlqHGDHSgHCG84wuVQnXkWMAL+TEb
	 MlAp/NWOUKAFCObCB3fN61uhCuArrOiXjuuwCe+AwrZkQh1B3/DSicX/ff9tQsJJEs
	 WJ/fUY7rm0hwA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6096G0FS02637291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 14:16:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 9 Jan 2026 14:16:00 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 9 Jan 2026 14:16:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next v2 01/10] wifi: rtw89: update TXWD v3 for RTL8922D
In-Reply-To: <20260106030911.15528-2-pkshih@realtek.com>
References: <20260106030911.15528-1-pkshih@realtek.com> <20260106030911.15528-2-pkshih@realtek.com>
Message-ID: <6b8ccf3f-f1f5-4b37-afcc-82e6e7f38328@RTKEXHMBS04.realtek.com.tw>
Date: Fri, 9 Jan 2026 14:16:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add TXWD v3 to assist in transmitting for RTL8922D according to hardware
> design.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

2adaa4b36b55 wifi: rtw89: update TXWD v3 for RTL8922D
2b4a2fc32a47 wifi: rtw89: update query RXDESC v3 for RTL8922D
49218572f331 wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
c73607b3a8ef wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D
96f5ceb44875 wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
dfe3dea6b9a2 wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
eccf7b10785b wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
1ddebb8f6e04 wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
483539d89110 wifi: rtw89: fw: consider hardware AID for firmware elements
5fbc19b0f62b wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips only

---
https://github.com/pkshih/rtw.git


