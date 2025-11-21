Return-Path: <linux-wireless+bounces-29220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 922FCC77334
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 04:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D12C4E2134
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 03:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CE1E0DCB;
	Fri, 21 Nov 2025 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DpdTCp4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877004204E
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697571; cv=none; b=fJmgUWlRg6nWXzFSH9FAoGlkE2Vs5meClShpMP0ZkJ+U7/ANtimUVRzSOXjL9J0ILvR8xNB6DPvA+Iz2Sw6xhCVVqJr9tG6g9oFaWObzOaHOnUncuxnRIktBRRWL6qEjfOBvAGbJZrD6eshYRBfU3soLZBDJ3hBZ1jZa1emfxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697571; c=relaxed/simple;
	bh=q6pHAe6C74eW+jljh+AcQ/kOhVl2NuHbzxaMlRGdGBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GD1JAAu9MR/+Nxi668GyEEGMlNQ/FEmOCo08O4HW3n6YWxwjgj5j5yBXwawhUrv/W7GyzYC5qhTmZpMgE8HjQ6rwfV8mKymQbrkwvs84bbS/HkO+q4JrNlUZ5IOPuMeJOcXQHIyAPZ7Gar8Ir3ZDdgsCZHcy0EyrT6oWZfVMauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DpdTCp4y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL3xOylD2885540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763697564; bh=I+4tzU8chSE0ONujlZoVWTxeaO7zfg3vHePTYLvbGeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DpdTCp4yGtJCTqg23uSsxShLNjiUQBX/8AilnmeQtOfBO4IO1V1GkXs/OkQGUS2Gg
	 30UqEDq8ho2V4f2qjmssqq8Qn7W67fkvBfPa1EKuaNPog0zZpNF7zGNf5Uq80j+85j
	 jE+yIr+zNmecrAuO8QmCKu4fk7JkjHE1LhI7SbmPOJmSVuatayAkjK+vxf4NjR+Y02
	 fjUJnHcrbtQI9R0Npc11Am7xM3GBd4DtYmG8BJ04N5/uj89G9CJO/ShpUYVO421+zV
	 3UEcyKTNCHWlhuRoWV9siwG8wEVOFA9nJ5WJx+npHpCxPxuwJqHMqXOysiqvlf9ks4
	 5gG8oFRDy3rXw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL3xOylD2885540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 11:59:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 11:59:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 11:59:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: RE: [PATCH v2 rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Topic: [PATCH v2 rtw-next 2/2] wifi: rtw89: avoid to use not
 consecutive mask in __write_ctrl()
Thread-Index: AQHcWct328oIiBTYH0iTlcGUznxEqbT8gmUA
Date: Fri, 21 Nov 2025 03:59:24 +0000
Message-ID: <910a0ce4bf9c47d89f0da8399ef3927e@realtek.com>
References: <20251120031044.12493-1-pkshih@realtek.com>
 <20251120031044.12493-3-pkshih@realtek.com>
In-Reply-To: <20251120031044.12493-3-pkshih@realtek.com>
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

Hi Geert,

Ping-Ke Shih <pkshih@realtek.com> wrote:
> The power value and enable bit fields can be not consecutive mask, but
> normally we expect mask argument of rtw89_mac_txpwr_write32_mask() is
> consecutive bit mask. Therefore, change the code accordingly.
>=20
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: use a macro to use u32_encode_bits() to generate mask before calling
>     inline function to prevent __bad_mask() warning.

I'm still thinking if this change is good enough, so I'd defer it for now.



