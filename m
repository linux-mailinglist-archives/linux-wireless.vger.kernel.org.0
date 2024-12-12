Return-Path: <linux-wireless+bounces-16278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8D9EDDA6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 03:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE6616085B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D013D531;
	Thu, 12 Dec 2024 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FHY77Vi3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF0257D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970522; cv=none; b=ifxjTMCZSBsyHa3lOMSemd245WBoShgQ5zDlmWkE7932Yig573lTL2OGvJsWLHeHVPk7f+t2CQ1FovvLRhob8rm80BfWzReRoSAf3zVd0Ethq0IfBQ/ItcBV1ZHFknlWh2RDh3L/VmKAcERmKztmWNXxXDCXqyS3JjqKnogEVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970522; c=relaxed/simple;
	bh=LWfJsQFy6qm2ZNALtOrrBCBMJglRS66Ges0HW5HCADE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=G0+N2sEEw5lmP2Er+1DXHLRuvKKMo7VmvXQiDETxtNtlOdOPb623+60As5iO7cplU92CGY2qgpPDfZjkxuZQL/5yrmh+pkxiicgUT45zJQZ5i16ME/DPJxsaxlHh9KVTD58JK1scTVYfMGca/hja4qkUt+zCrY0IgWKkyYeOVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FHY77Vi3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC2SZCV0485479, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733970515; bh=LWfJsQFy6qm2ZNALtOrrBCBMJglRS66Ges0HW5HCADE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=FHY77Vi3e/3DnqfugoDXbt18UlR1zOPa0p2Tz1ri9sNh9CE/n4TSuzm0N7yAunnZm
	 ODENLmAS5J0ypmvRnyAVBO8q6YXqDTRU/TEHUE3/UT88RFUXTaa7UtOZqeuuCoKU+v
	 If4dY9jxVW+NhEzpCOoxRAvrDDP73+OCBWiDV5rxoFVLXb99xJALKdwBb3ePITXGaf
	 JbaT1avKo75aUQFfppEBZkw0FZdQOsUN88uK+40Yxnbloe4AaiRHb9W/m4bLhwRy++
	 3sXoHhDt5ROgbJjtcY34PYJAUDXch7lYxAuzUtW2vVFVzkVLYoeWW0cQ8zyc0p3Ln4
	 cDS/XwHIaYDhw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC2SZCV0485479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 10:28:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 10:28:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 10:28:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/7] wifi: rtw89: ps: refactor PS flow to support MLO
In-Reply-To: <20241206055716.18598-2-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com> <20241206055716.18598-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <18b60d63-d285-4435-a08b-66f5c689daf9@RTEXMBS04.realtek.com.tw>
Date: Thu, 12 Dec 2024 10:28:35 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Firmware can only support PS on single one VIF operating in station mode,
> so argument of PS entry rtw89_enter_lps() should be rtwvif insetad of
> rtwvif_link.
> 
> To enter PS under MLO, for each rtwvif, driver sends H2C command to tell
> firmware which mac_id will enter PS one by one, and afterward asks
> firmware to enter deep PS.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

1015d6157080 wifi: rtw89: ps: refactor PS flow to support MLO
8c86036693a3 wifi: rtw89: ps: refactor channel info to firmware before entering PS
5b4ca804792a wifi: rtw89: ps: update data for firmware and settings for hardware before/after PS
f0441c540fe8 wifi: rtw89: disable firmware training HE GI and LTF
9ddc6ee0b215 wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability differ
a2854ac33830 wifi: rtw89: regd: update regulatory map to R68-R51
9ae817c779df wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2

---
https://github.com/pkshih/rtw.git


