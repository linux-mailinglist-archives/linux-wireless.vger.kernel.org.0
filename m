Return-Path: <linux-wireless+bounces-27837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC9BC00B7
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 04:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659E13BC651
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05C34BA47;
	Tue,  7 Oct 2025 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F0WOzI7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8434BA3A;
	Tue,  7 Oct 2025 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805530; cv=none; b=NXhwguC+ZE73j9XSCdkOWzz/7khr6Q+ZK33uylgkkY9wtRYexuEnH3hTFsciYE1h1WqrLREiEEo7K5nNYGFKJTVQWx4WZWybzCTBRD0tBYgGgzG6TMrH3ddE8fkGZsSuhrLe4sUEcknpxNeaWi7dUPMpxNarKqZIcEh1HZWBrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805530; c=relaxed/simple;
	bh=M5H7wwUtR2RA/UnnmYkaKvZDEGqRYQ9zhKKlXDNa9Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2/WCuNDzZeFKodZkkSTQ9XnFVSrg/M/EnIQRJlEIdrZRATtcYlR5b6D5mDs9BtuwZqGNHriEzH2W1se4x0v6SNO4kyqbRimNSP9AJ+6LVtRcLdjkV6lmcSd5I1eZWLXoEWe1nQnMAx2hCi6Dgv1CRecsnF8Vrld7JvVtIOp0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F0WOzI7j; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5972pnHrB3410102, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759805509; bh=M5H7wwUtR2RA/UnnmYkaKvZDEGqRYQ9zhKKlXDNa9Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F0WOzI7jEKZ30tVjN0wYFWZfPMcpu0ztywwnO/9Y5wYOKA2+mIyoNj1OgYks1t7HM
	 fBHbdH6RqKJm72e/NBNTm3b9QkwQseeUTY4ewS1AZn+3ZqKFcoMrZkyJlhpGYTrzp4
	 PkIPiYFYRkJmJCPH0Df1dWr5Z12IiHISoqljzNanilz2DUoebGF7xdu5AwSjkAZ4Vz
	 gto1F27qMRDb16lAcBP6TavRI8Gm8FIB+y7TQdrzVZQWZK94DlK112oqhHaKcW///x
	 L92JETxtnbJRfSAnO9d62ZqlQOKXpFdSMG20KKE10V9rbLddWz6lbN1EW7YuDmGXMU
	 lACXS/2tYPvJg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5972pnHrB3410102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 10:51:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 10:51:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 10:51:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 10:51:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 3/7] wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
Thread-Topic: [PATCH rtw-next v2 3/7] wifi: rtw89: usb: use
 ieee80211_free_txskb() where appropriate
Thread-Index: AQHcM9iIek/hsrW3lkGgw3fZsn7g3rS2AuCg
Date: Tue, 7 Oct 2025 02:51:49 +0000
Message-ID: <22ac863bbafb4751bbeaf37c8ed3d2d9@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-4-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-4-pchelkin@ispras.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> rtw89_usb_ops_tx_kick_off() may need to release skb if a failure occurs.
> It operates mainly on skbs coming from the core wireless stack and the
> ones containing firmware commands.
>=20
> Use ieee80211_free_txskb() for the former case.
>=20
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


