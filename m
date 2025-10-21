Return-Path: <linux-wireless+bounces-28120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A5BF4A5C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4EB466D02
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8BB1BFE00;
	Tue, 21 Oct 2025 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TVZ2Mf3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4371F5EA;
	Tue, 21 Oct 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024904; cv=none; b=fw57H8ZRKxB0OPpsizlzaxNuyZzyvIeGW9XnfFzcmA5qHm6pYum77XNJylCoq+XA7+dmm92Q5EAntdwxi11WaCY0rDL3r4rok1RZrB/KGlIDf5jH3cPkKRSElbokWcG98fSRra4LZICTGhp151M4lldpP723SgTUEv54KRzAa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024904; c=relaxed/simple;
	bh=6daIoFHkGVoXZ0S9cbFiBXHtVGuBdrpmrycf98mRDmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i9xh5ZkemtL/LTKlcQtabVkR3c+rjZwyPOsL49FBYjtrPWdzmxGpt6ggWVRXvf5w2IBnDTKNvp7L5b4F75BQ2rj8QBsQNFZK/BprUsZ+FIl77ecylHYwHtKqmqonvuGufI2hiFyx52xOoUHuUqjMHV8FN9TQ/srhsReydA9tlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TVZ2Mf3R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59L5YuFG22467330, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761024896; bh=6daIoFHkGVoXZ0S9cbFiBXHtVGuBdrpmrycf98mRDmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TVZ2Mf3RsZCOGbC99wn48q7rIHK2XEUz5Y/i96O9TVA/OXFo3rgePggjPFAQygkQn
	 Z7WZBnrT2/oXqaMV+nn1aATpvYWpbfGOAe1PJtBmkFo6VpbDpREzvWoZAE7UVh63cF
	 1dBiap2mA72hiHAkfTeMbiFUSXq+gvIslTAZixnIdQg3tVe+h9NoObpCyWnd9teWi3
	 TqHf0g5FVRGqU4N2rRsYQr1GH9yipHQg/vSm3E2BeT6Gv5+wuyWBW4y5I1an9/d7kf
	 kA3aUTIaOtveMe9AqPejetHFg3Eq7OStIE1QTL5VcZ3hBw4O7JQKv8ttt34lR6GpxU
	 nqQoHWpwUXUWQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59L5YuFG22467330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:34:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 13:34:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 21 Oct 2025 13:34:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link
 AN3U rev. A1
Thread-Index: AQHcMPU4LFvfPiVdyEmxJ5atcfU8NbTMNsPA
Date: Tue, 21 Oct 2025 05:34:55 +0000
Message-ID: <1f24e396e16143ac9ad9c64a57e78bb1@realtek.com>
References: <20250929035719.6172-1-zenmchen@gmail.com>
In-Reply-To: <20250929035719.6172-1-zenmchen@gmail.com>
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

> Add USB ID 2001:3328 for D-Link AN3U rev. A1 which is a RTL8192FU-based
> Wi-Fi adapter.
>
> Compile tested only.
>
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3f9553f65d0b wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1

---
https://github.com/pkshih/rtw.git


