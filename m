Return-Path: <linux-wireless+bounces-15119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E99C13D0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76C0B2116C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEEEBE65;
	Fri,  8 Nov 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HbIFlLvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C01C36
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031047; cv=none; b=AEudCNzmTSFh1HMmSNWfL9GE+c7G3T3R6WO0L+Tp7aohvqu3ciNRR9wULOPaflVAArj722JuFVjJpmrgHYhXZ10olqqWty0S6eS3MokJtH8PZ+SJ/YqZWa1HgAdSvihMsqdOuiKHdW+fNSmRNOJncTmsKMa3atReoSCdzuI97/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031047; c=relaxed/simple;
	bh=NcH2OOHx+rWrlAQ4t6tOpwmo/i043s3T5FOW71+3zJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aq0+ksNtZucEwGyxcLHeUqkKABlbzD/mmNOMQ/PbpGFB4Uf9Rs9CON5qQ+U14ZMWI1YJTmw17bZRyjbIe6+CKvxQIKdEz0AQHLizGKCIQjGQS6kbQXeFilXI68eHcdLsYamSbss7Qlr608Xq4jaeZWCfVLR5dKSG0ENSQxPJaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HbIFlLvW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A81v4wtD1183003, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731031024; bh=NcH2OOHx+rWrlAQ4t6tOpwmo/i043s3T5FOW71+3zJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HbIFlLvWSSVfMjCTNvzW0Gauw3kpsAJkg7Zkd+qEhJLuSI7mCkVHBm4Cbk/am7Jdd
	 pG1w6xkS3r094wa7hHWHqCznCeK55sv92InIb4vrPvP8mNdAZq5FeyxcFLJkfIvBLD
	 t5l1JFDs8IDrPw4SOgIg2MuEllOoHgV5ZDE7FHLVCOTwFPsJMRRtWVInTgjviVDJJx
	 3lNu1dsN5oxYecSLgDZX6QCCd+xhGPlVkp+NK/KGHAClY1lO9zaUq4kWjY0VkRADGT
	 RjgmfI4lbNtCHIrVUr7vdujwmcN2YuhBJooN4h0YO8ZgmTJ9EfWQvA9uytMWU+3K3U
	 Hk2Q1Do/YkfEw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A81v4wtD1183003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 09:57:04 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 09:57:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 09:57:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 09:57:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 1/5] wifi: rtlwifi: do not complete firmware loading needlessly
Thread-Topic: [PATCH net 1/5] wifi: rtlwifi: do not complete firmware loading
 needlessly
Thread-Index: AQHbMRmqFcDqJxvSBUmjciOLTcl09LKsoL0w
Date: Fri, 8 Nov 2024 01:57:03 +0000
Message-ID: <f04e9638f6cc45c79fc50b716c2a7b7b@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-2-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-2-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> The only code waiting for completion is driver removal, which will not be
> called when probe returns a failure. So this completion is unnecessary.
>=20
> Fixes: b0302aba812b ("rtlwifi: Convert to asynchronous firmware load")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


