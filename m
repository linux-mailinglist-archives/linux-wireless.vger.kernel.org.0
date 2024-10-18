Return-Path: <linux-wireless+bounces-14184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130769A323F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 03:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE6828430C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 01:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243639FD9;
	Fri, 18 Oct 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uJYxvIwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D920E327
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216106; cv=none; b=XbzSCWDQEPmTzo9nQYnSoBuEMQw/NuWJVOgnz2O7TjTAm5KNftAwjLzDpu80vuWY2njaxaHYseWPl0JoA1v76+PmX7BkdoVoIANljh27o9677NO8Pg77YhKj5I33S9HMTL92XIQ1KtesRCmxweOvEDXHnao64r01/14WXGD6uN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216106; c=relaxed/simple;
	bh=fYmZlbDI8LwU2ZR9owMoRZlB79TnjT6ZB2KE6ilr3yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Luvq2h2o3fBPi25rzEnl/8G8BQJSZ51XNshZc18VQRDOaxESQJ2AFwig2f3j/du23PZ2ckPufIS8FsXfEnWtLfNt2Z5Zu+YIAXP+HfR4lVMQSLcNkCDGyvZHhT3TKyAbyRZONrL8kx1k7bZp1YgL4wCIZTqx+EFRIaxmqSn7GmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uJYxvIwh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I1m8umD1287289, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729216088; bh=fYmZlbDI8LwU2ZR9owMoRZlB79TnjT6ZB2KE6ilr3yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uJYxvIwhufmMIq1VUUqtQanTnxNZ2DMjBP0k3QSn4qw+zMe5RamoOt3jHodpLKNOE
	 0w+1rFuXQMdCOrr8n98MOKQeAj24EJ5teOPM0ZbMNfF1Ck/CZ/1N22sKlo/AU2TYaH
	 cEqAIEpyKHA8dC0MZw5elbOiS/Q6tsGA+jhB2W5ifwp8KHEsEsQBMMOVbnRcfApsiz
	 1C1RgWi1yQnpigDC2LdCyqMEHn+MgeEH42wWKOQF078zZx6iAUEGZIuMcWHJXW3FNV
	 CQvJdx6CjopSYSUCzEeXZkvTa0m+hoGBxojamsOgb2pKV3NFIty3rHEEnUQQB1HKGb
	 cUWHeBWXPtG6A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I1m8umD1287289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:48:08 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 09:48:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 09:48:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 09:48:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH 2/2] rtlwifi: Remove unused firmware images
Thread-Topic: [PATCH 2/2] rtlwifi: Remove unused firmware images
Thread-Index: AQHbIKgrKBNsTJOjZEOj1hqWHuhyqLKLp86Q
Date: Fri, 18 Oct 2024 01:48:07 +0000
Message-ID: <7b298bde63ef426bb01ea463c783d9e3@realtek.com>
References: <20241017152043.10205-1-zenmchen@gmail.com>
 <20241017152043.10205-3-zenmchen@gmail.com>
In-Reply-To: <20241017152043.10205-3-zenmchen@gmail.com>
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

Zenm Chen <zenmchen@gmail.com> wrote:
> The firmware images below are no longer used by any in-kernel driver,
> so remove them.
>=20
> rtlwifi/rtl8192eu_ap_wowlan.bin
> rtlwifi/rtl8192eu_wowlan.bin
> rtlwifi/rtl8723bs_bt.bin
> rtlwifi/rtl8723bu_ap_wowlan.bin
> rtlwifi/rtl8723bu_wowlan.bin
> rtlwifi/rtl8723defw.bin
> rtlwifi/rtl8822befw.bin
>=20

I have confirmed these files are not used, but distro can select and pick
firmware by module info. Not sure if cleanup is necessary.

By the way, I found some firmware aren't added to MODULE_FIRMWARE():

rtlwifi/rtl8723ae/sw.c:         fw_name =3D "rtlwifi/rtl8723fw_B.bin";
rtlwifi/rtl8821ae/sw.c:         wowlan_fw_name =3D "rtlwifi/rtl8812aefw_wow=
lan.bin";
rtlwifi/rtl8821ae/sw.c:         wowlan_fw_name =3D "rtlwifi/rtl8821aefw_wow=
lan.bin";
...

I will prepare a patch for them.=20



