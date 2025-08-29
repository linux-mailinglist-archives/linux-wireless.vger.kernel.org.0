Return-Path: <linux-wireless+bounces-26850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A5B3B2B8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5849D566E87
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 05:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60531225397;
	Fri, 29 Aug 2025 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iU3tDbSw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1E2192EA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446782; cv=none; b=qprdPpD1ERjkKNl6lKlyBsfVbcgSU2vEBKvijOqtMQKGjx78aTfWPLN3L3mH6ga4Sh3On79rwUTz2YC5cmI2GKDKpvmnS9cCkljccdj0b43TMX1ikzkGvlQap7o0NuREHpUccfK0HsyO8Q5x59WsqpsSgwd8PvPSz8CjBAiCLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446782; c=relaxed/simple;
	bh=QmdByfBtyCstHlhq5eyVyaBdcSOJ+bsrUI8sGuDNRX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfO1lwIn7CoY/oXGvQIAo9O1USLZhiULGMWx+OVFhyiKxaV15PNElScXYD0aAnmjzy4RTS5WeW9WnEJmsZWoMfQIavymsrgwTzAJT61TFHNTGN/OJ5YDn7vWcEQkelsu4JPkWRkXpEXnx3TvjVJjwQ/+uUlDVR+yCyYD74R44Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iU3tDbSw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T5qsNrB3084094, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756446774; bh=1iaTsekzXIBgyIiCXp4h89TVwf5JYaJNQ13ILAtHdoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iU3tDbSwAbDR8tZDsJTyUEqnViEotb7jTNoqAOPd40ua1lAOrPC2hxJLJxJAUsI93
	 WNCejbriC5QFEAgVAKbJ1bXsDV8cvV/4rZLqxwsuM2XyvJ6CHvUQiVo3tXGowAA3kN
	 /EFLUBBmRu3HemWQ1ks9DxPVyRf9p93p4wRwbDkvTgUVgzV485k5L/ouz+0PmpuntP
	 53dbi4aU7CnuVdvYJyEUYsBotF/K84m2k1ZGcF3U2ajPKwYHVbRGsD0eGg89hwTk+b
	 u37SON/gw9Nm/yzOZ3t8NvaHcaI3vJDlQnsgdyuC65/LeCvyuoyuTgGuxfYvPWdwwM
	 C2GoL3t7aMjGw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T5qsNrB3084094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 13:52:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 13:52:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 13:52:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 13:52:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "oldherl@archlinuxcn.org" <oldherl@archlinuxcn.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Possible Regression of RTL8852BE on linux-firmware-realtek
Thread-Topic: Possible Regression of RTL8852BE on linux-firmware-realtek
Thread-Index: AQHcGKFX8JNSoDTnmkyK6CXXtzDeBLR5HJmA//98DYCAAIfeEA==
Date: Fri, 29 Aug 2025 05:52:53 +0000
Message-ID: <19ceb132bd1a4382a71caa744ab6505e@realtek.com>
References: <2082485.tdWV9SEqCh@alphecca>
 <c85ca611f0d74d2eb8bc400ebaaadb9b@realtek.com>
 <9ab95a57cffe13bcdfe6ad8b8027e41d@archlinuxcn.org>
In-Reply-To: <9ab95a57cffe13bcdfe6ad8b8027e41d@archlinuxcn.org>
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

oldherl@archlinuxcn.org <oldherl@archlinuxcn.org> wrote:
> Sent: Friday, August 29, 2025 1:45 PM
> On 2025-08-29 15:38, Ping-Ke Shih wrote:
> > Did you use Bluetooth too? Please try 6.17-rc to see if it can improve.
>=20
> I do have bluetooth enabled but at that moment no bluetooth devices
> were connected to the laptop. I will try 6.17-rc later.

Please also try to disable power save by
   iw wlan0 set power_save off


