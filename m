Return-Path: <linux-wireless+bounces-2149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C669C831575
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057D71C20ADB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596DD125A4;
	Thu, 18 Jan 2024 09:06:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E9D51B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568791; cv=none; b=uZU7tDiOLMXnRjcrTBeGTCnzTn/0xtItnnqaDkOdf745/di2lZ8408h/KKV5uvY/KcRbf080M7jYU8nqdFHXaRud5a6onOkF3rLM17eBpEXOZf9LeCUoGTiM9ENeqAV00D3NLVgUsn2ds/eDUFk9Il7KF4ugPpB+ehvljiOKRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568791; c=relaxed/simple;
	bh=WrKebkie09SKQFrlQSv7o4XfXhosc+96Y7hZu+An+oo=;
	h=X-SpamFilter-By:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:x-originating-ip:
	 x-kse-serverinfo:x-kse-antispam-interceptor-info:
	 x-kse-antivirus-interceptor-info:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-KSE-AntiSpam-Interceptor-Info; b=uPnVozydbKehZ0VCb3ATtf3JeoB5eyUQhpb+RupoGdDrkeicA06HSbz0YLL0OQrS7z6n82t3fkoxdgHF3z3A+RojSLj1whFb5NNyAOC++Qwq0thPAxwGvv6C2K5tiL1iZtjMEkcB1/iSekDPcY21d+qwfV/t/4c1jwK+drSfw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I96OJ701580326, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I96OJ701580326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:06:24 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 18 Jan 2024 17:06:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 Jan 2024 17:06:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Thu, 18 Jan 2024 17:06:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: Hsuan Hung <hsuan8331@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/6] wifi: rtw89: 8922a: implement more chip_ops for 8922A
Thread-Topic: [PATCH 0/6] wifi: rtw89: 8922a: implement more chip_ops for
 8922A
Thread-Index: AQHaRPyc7MAnXHT4zkSg2AdD/yK1obDfUOsw
Date: Thu, 18 Jan 2024 09:06:24 +0000
Message-ID: <9c174b7bf6824b18b67207a3bec7e2b9@realtek.com>
References: <20240112021033.20104-1-pkshih@realtek.com>
In-Reply-To: <20240112021033.20104-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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


> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Friday, January 12, 2024 10:10 AM
> To: kvalo@kernel.org
> Cc: Hsuan Hung <hsuan8331@realtek.com>; linux-wireless@vger.kernel.org
> Subject: [PATCH 0/6] wifi: rtw89: 8922a: implement more chip_ops for 8922=
A
>=20

Please drop this patchset, because we found some problems in this patchset,
so resend v2 to correct them.

Thanks
Ping-Ke=20


