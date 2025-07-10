Return-Path: <linux-wireless+bounces-25165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A7AFF826
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DB7B300B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1D283FDF;
	Thu, 10 Jul 2025 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wds4JoN8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E52F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752122670; cv=none; b=hc11pmsKlEmprio0jR3agYkzBttNGWoR//kf0t3t+ksaoYJMNC01IeU6htb916ZDZH4VVqH0IMwWYL63QRlirhRoa/9NqbwsGK8fbOYR4oh7dpPxhuNKnzyt1i7t2gclP82xHlFGZnjpLAlbaRH+vYw3Q3iF4DGTVfJb43Nv2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752122670; c=relaxed/simple;
	bh=hOnAkJ5IgOdiNR8vedi7ctomD2vPW/oVMcHh5gKmmoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOoyTAZjEiKgM2Kt2SXiIzlPNmkSNvr9BuJ0ALI3e3oNuumyrb5WOxFA8QsTPv/PilVIQNgXHtD4y/KmOs3zxe9hJpq6JJ44BwIjrpX7+hVQ+RjA/82fbLuu5ewUpcS8lGSC2+Dc+N7IC/CnQUF1gqINa+foLd2pKYGf9R7r5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wds4JoN8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4i1g652471628, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752122641; bh=hOnAkJ5IgOdiNR8vedi7ctomD2vPW/oVMcHh5gKmmoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Wds4JoN8/cowm3+BqtouqITvNQcxpsJmgdHWdDD+D9T0pqu0vma0H2WEQVcCXWrnu
	 dW/4JB1DG09uGBiCma1fHe3jxvFdZr8sthEtC0RbyKub7hlEVMAFdBYaKSg7mAHN5H
	 ZgrN46obFVaNHoQNBtuVDq2oz6EkTEKYljt3IF5ZiYu2qFh3XgZCxoinmytj5xDNZk
	 bB6CLykuGDNtgs2m+/d5Qx6oCjm8OrtpPQfkGxZzmh8e/tY5IgTPlAf4XohNxL3IPD
	 Su1yqZBV0e6wtYpQbJx7ihKhxGFe43v8BDf+sddfnPVIXR3nRdFyUdi3s2Nt37y/UO
	 KGdDnAjua4OrA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4i1g652471628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 12:44:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Jul 2025 12:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 10 Jul 2025 12:44:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix RX skb size for aggregation disabled
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix RX skb size for aggregation disabled
Thread-Index: AQHb8Mss9Ikf8sQhxUyZ3JyD0WC4VLQqyMWA
Date: Thu, 10 Jul 2025 04:44:00 +0000
Message-ID: <75dcf79857984c9aafdb0fff680eb3f4@realtek.com>
References: <20250709121522.1992366-1-martin.kaistra@linutronix.de>
In-Reply-To: <20250709121522.1992366-1-martin.kaistra@linutronix.de>
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

Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> Commit 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for
> phystats") increased the skb size when aggregation is enabled but decreas=
ed
> it for the aggregation disabled case.
>=20
> As a result, if a frame near the maximum size is received,
> rtl8xxxu_rx_complete() is called with status -EOVERFLOW and then the
> driver starts to malfunction and no further communication is possible.
>=20
> Restore the skb size in the aggregation disabled case.
>=20
> Fixes: 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for p=
hystats")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



