Return-Path: <linux-wireless+bounces-13211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCFF986A6B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC5F1C21447
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB25208A5;
	Thu, 26 Sep 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WHezS6xx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF74A3E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314301; cv=none; b=lfTTnRTYSt7BWsvMNDPQzffI0yCb6bEvH9VMgGU/BtrpoD+q6lkZEYVh23pFJw7ac8mWsbR02SRCuT+Euppe6EA7uk+WVkpZO7YzX8gtbOg/BDFHNt4aia00wgPnCwYmpRPba2lzY6tAxDlm+OIa3zhWDv5bobJzPVK9JTMjPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314301; c=relaxed/simple;
	bh=X5PFAV2OXhxUcJxNu54OgUqLnY80JDbYRGMUh4U6QKI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=G+Xbzp/1lH0dHOQ3OSFX59LV+oyOcy/Cc+j21B7Q6KUXaCZ8d7QPia+zowBVjoQwH5saVJSBz4ZwIKlZLTVPwEMgsrkkqCHWwxH9ddp++MV3p2lRamoLQLpcNn+nnuyJB1HtsMrD48aAbm1HKZGUf4ADi/rXeq2wGhIGo+ON7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WHezS6xx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48Q1VT8d81206826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727314289; bh=X5PFAV2OXhxUcJxNu54OgUqLnY80JDbYRGMUh4U6QKI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WHezS6xxkpgq0eerZLKIsCKY5FUiE+KhwXECykmpLAMAxoBStCk6vnew6KA1FYDDy
	 0cqqTQ5MCIJf5UpiJr82WSkhVf8K1z4IYrBgbbJdOZmDi9kg5lbycgPkjrxW6tr0PZ
	 8dEOZeXre8E04CwRKn5Dv/3BH+d6Qb3g5fzF9Pl0YaurxdliLFF4BAKrlYlE7a3orj
	 EKO5n7n03jYzsf+RBfhkC0Wp8DrDyH6CNUerF1anMJSVjm5taABrIr5vpePws1k0Mu
	 pDRgRFM/UDqFjTtfEW6ZGYmXHQ38Wuy63TpsKKloYuwN32sbMg2Q7HJGO2K5ItSpXP
	 gSGwnMn1bbm5A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48Q1VT8d81206826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:31:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:31:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 26 Sep
 2024 09:31:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtw88: Parse the RX descriptor with a single function
In-Reply-To: <913f1747-38fc-4409-85a4-57bb9cee506b@gmail.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com> <913f1747-38fc-4409-85a4-57bb9cee506b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <93d9020e-c986-46a1-ba92-949188d156df@RTEXMBS04.realtek.com.tw>
Date: Thu, 26 Sep 2024 09:31:28 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtw8703b_query_rx_desc(), rtw8723d_query_rx_desc(),
> rtw8821c_query_rx_desc(), rtw8822b_query_rx_desc(), and
> rtw8822c_query_rx_desc() are almost identical, so replace them all with
> a single function, rtw_rx_query_rx_desc().
> 
> Also, access the RX descriptor using a struct with __le32 members and
> le32_get_bits().
> 
> Tested with RTL8811CU, RTL8811AU, and RTL8812AU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Tested-by: Ping-Ke Shih <pkshih@realtek.com> # RTL8723DE and RTL8822CE
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

bbb6f9be7f99 wifi: rtw88: Parse the RX descriptor with a single function

---
https://github.com/pkshih/rtw.git


