Return-Path: <linux-wireless+bounces-29225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA0C77828
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 07:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF37634A662
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A602DCBF2;
	Fri, 21 Nov 2025 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hqik/Qvc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12309824BD;
	Fri, 21 Nov 2025 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705406; cv=none; b=PZVmnETjQq7EfSKaDC6RjH1pyr8ws2VZ4XB6/h9qA3zTRM8q2z5tVO1QRBpwGHi1iJFk1LdRsJpP+s+q9LNg9S3AH9lQCs/GG8zR8EAwmSW7ocnN3/W0vxsUwhom/Ulh6hVie1CeMskMQbTai/hdMuUwYYv/dTM9fhP3RY2FXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705406; c=relaxed/simple;
	bh=cVvMv9J7erBcRp6kA5IJc0Jgik/aMRU6KiRRVIGq3tk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=nhMb2uT7t/2Hz6vrnL6H8VSscNu0Fzdf2fhE611qJYEWXOkGqQQKTlXW6Vm5MiVITUW1HpgDHBfRivutvfpWP4tw/rWAwZr4pORtj+vQ0pZz1h/NFrJzzi8yX3EV6pZxwzQAeQKe3QzR5bCjfrnRZzJkp5+Pr5L3BYhrGyG8eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hqik/Qvc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL69uCT23039169, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763705396; bh=WwluALrFamw11xO/dtpTJb5AgQu1/DEMiz2XN2kzNP0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Hqik/QvcchOS5F9486M4AVfHpkdQmqAZOuKtVmPOQU0zvLzocYHHIBAK2y9MC3O6R
	 NBYZfFwdagcAF2GIMoYr98TzLI2pIJmpObUj5Gx+yEX9blecvzCHOiGJR2G6Z/e53h
	 YBCSwCJiptwG8k744M1VT/ndLR5Siu0v9fLorIB2KZy9RmJaEMsFcKtJGS5oggcp2x
	 vYCxLejVC3Y0rZsIFShD4DkLrVsDJkmscX7q7kOg13NhsaZ5qdo9tvBG9+EohZ6PIf
	 U6tMPTap9Ral7GeXNiVyg6mMaKODxUYVm5StidvnYQVRVSNCNxOqQhxuSCxXMVWGwS
	 bFshTtDesHLJA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL69uCT23039169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:09:56 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 14:09:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 21 Nov 2025 14:09:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gustavo
 A. R. Silva" <gustavoars@kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings
In-Reply-To: <aR2I9Sere0W-4VZz@kspp>
References: <aR2I9Sere0W-4VZz@kspp>
Message-ID: <379c0915-4355-4ca4-b563-e62352528d1a@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 21 Nov 2025 14:09:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declarations to the end of the corresponding
> structures. Notice that `struct urb` is a flexible structure, this
> is a structure that contains a flexible-array member.
> 
> With these changes fix the following warnings:
> 
> 9 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1951:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 9 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1945:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

68dc70ca4dd4 wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings

---
https://github.com/pkshih/rtw.git


