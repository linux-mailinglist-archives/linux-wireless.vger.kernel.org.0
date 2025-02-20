Return-Path: <linux-wireless+bounces-19164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F7A3D129
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A703B24B5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5E1DED4A;
	Thu, 20 Feb 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bywJPc9A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22C1E0B86
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031853; cv=none; b=fOn1O+qkByyArSi3SChp6nArU6hwPVxRkpIZw4FlpDIKhaeFknnPm5YQOz2NSd/Kpjh1Q8CD6mh3NChqk1P2vZBP6J9aJZAWb95gdLvlcUBZE0n9HIoGdKD9OFm3JhK0gu/OLb8UBl+pL69TiOlwz7aEmCvXsgiFAN44ZfLgJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031853; c=relaxed/simple;
	bh=lGAjn5bc8OFgUoOsombTGZIaCgtisLR176utPxH6iJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAY+5wSoJZAiOtb09xs/j6hEGKJF4UdWeDGAf4JpalVQ2Wet0HDqh7hGSgxRdaVYaGTulbwrePxcP6+SCscVldvYVn96jDQsCB1Xp7aGr9qvtqH+b8UA/0wvseyGxO+MXPGpkwui74SdyHqTrksWYS+1G4R8FJXhMznNeBEoA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bywJPc9A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51K6AKqY4657404, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740031820; bh=lGAjn5bc8OFgUoOsombTGZIaCgtisLR176utPxH6iJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bywJPc9AsN/i+JPHmLjvm7tQxjjYFsmdRHg4lKuIE67swPUiSqCYsYE0yU2OTW7lB
	 Q9oUpnZit7qJYRUwoq0wLbDMqqr7jQa3KPha8Qd7qAymT8kcQwoWT5PYo6WaKhC93C
	 hl75vfIlUTmQgdtF9kokGpYM2LDsKa707KyGkSWEbrRcucKc5A2MAHkO9cczRzSlnm
	 4ypLZk7LpQKKQ32o3SlrEsrKbqOpU2aOPx6NYb+yl8M5hn6R/sLZRrytD+m7VVQhXz
	 dlSdf4Qg9gLwxGfH4QTAcYh3cXbCoZcRdpJ81OlbTHx5aYI5I2cS/OqEQ5zUGbWnqs
	 2VQZRnXQNYqXg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51K6AKqY4657404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:10:20 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 14:10:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Feb 2025 14:10:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Thu, 20 Feb 2025 14:10:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Reto
 Schneider" <reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v1 3/3] wifi: rtl8xxxu: Make sure TX rate is reported in AP mode
Thread-Topic: [PATCH v1 3/3] wifi: rtl8xxxu: Make sure TX rate is reported in
 AP mode
Thread-Index: AQHbgvcQIkcxe4+B1E+giYVaTvRevbNPs64w
Date: Thu, 20 Feb 2025 06:10:20 +0000
Message-ID: <d3ac3a1dbf964956899896f40f041595@realtek.com>
References: <20250219175228.850583-1-ezra@easyb.ch>
 <20250219175228.850583-4-ezra@easyb.ch>
In-Reply-To: <20250219175228.850583-4-ezra@easyb.ch>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ezra Buehler <ezra@easyb.ch> wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>=20
> Without this change, e.g., "iw station dump" will show "tx bitrate:
> (unknown)" when in AP mode.
>=20
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
> Note: The code was simply copied over from rtl8xxxu_bss_info_changed()

The code seems to report the highest rate as initial (fake) TX rate.
Please add a patch ahead that moves the code into an individual function
but don't change existing logic. Then, this patch can use the function
to get your expectation.=20



