Return-Path: <linux-wireless+bounces-16730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6889FAB5E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 09:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2A71884019
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B34C70;
	Mon, 23 Dec 2024 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="d4L//E8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B033D1
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734941134; cv=none; b=ZqlQFmxXDSGNsqvk4yRC7eIDtBdXi9cq84ELoIQEUmKGbwrTPeev4Ozq0IyRQ6P6OuRC8QBq8TFLqA3FCZSC9Qap4JV++jZA+QzYcUote5S0TB15aYiv4idG4DkkvCbY5wSb/xH6AAV/RX7XNR6Bd/IXfIydT0Z8ytqfH/VywjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734941134; c=relaxed/simple;
	bh=bbEUjmialyJ/TJOlp/TikegOm38So2yJv6GTNa8XI24=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=UQmifHVxCELC7sDTx5XzOmic0Abjv8QftAQnHBcJWjeYoiYW0PmIGi6R4t4BaBYecdNJ0t3l0YYn9lLCNtfvaqsnrygHMvFV4rK0XP6mvFjHx5ejXpE9n/qtKg1oi1Gq7WHmZku4mub6Bhv6FHaJMRYArluxzriRigTiyhzQdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=d4L//E8/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BN85RmaC1504613, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734941127; bh=bbEUjmialyJ/TJOlp/TikegOm38So2yJv6GTNa8XI24=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=d4L//E8/0ZlJZvUA2b2vvxRN62k836MmEmr/eFzU6yPK+QB/MSIydax4CmMZ5ibPv
	 a/Ytq6m09ehmf5Tn4DVxm2fAzzVSPr6UkqwIJUVRUq2j3M/m4R0D7Qwqpt39bhnx5q
	 Lo+VTbWQ8QgELlVZtqE840tBKwQKIycP35h0PtN8Xw8G1LmmAYCjo5hdr4cw0qycVY
	 qGwKjf54AvpioEEWz+sGN+F8ltPvbTRHbI2YXw1r7GI5uPPsOD73eZpygt7+OsEhxa
	 +gFtzN5LFXkVlkllEVMVU6a+wjGmQXZNbFA6Rlr8MD8dVohSjS6fkvCeYimezLy2c0
	 NzV9x/j7nKoaQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BN85RmaC1504613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:05:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Dec 2024 16:05:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 23 Dec
 2024 16:05:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
In-Reply-To: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
References: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <99202479-fe1c-4f62-b756-8d5bd818f223@RTEXMBS04.realtek.com.tw>
Date: Mon, 23 Dec 2024 16:05:26 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> A user reports that the firmware upload consistently fails when it's
> uploaded in chunks of 128 bytes, but it works when uploaded in chunks
> of 196 bytes. The official driver uses 196 bytes also.
> 
> Link: https://github.com/a5a5aa555oo/rtl8xxxu/issues/2
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply patch. Set patchset state to Changes Requested.

Applying: wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
error: patch failed: drivers/net/wireless/realtek/rtl8xxxu/8188e.c:1827
error: drivers/net/wireless/realtek/rtl8xxxu/8188e.c: patch does not apply
Patch failed at 0001 wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size

---
https://github.com/pkshih/rtw.git


