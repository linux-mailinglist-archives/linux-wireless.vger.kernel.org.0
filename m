Return-Path: <linux-wireless+bounces-16924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693C9FEBF4
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 01:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DC0161F6A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB23D64;
	Tue, 31 Dec 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OWMYS5Qa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0355195
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606135; cv=none; b=QA3dkx5aN9DgKStdEeNeBqha5UqDRV2bDofGzkYT5XNYEtwWoyDinDFhQQ4DzJIxS7cMlxWhr2dVMO5Bpy2Cg6kc9OgRmTwPohlBcXDYUtFcPDGVPzj8NBlMbkKkx6DVjEibY9lXGHUUKImO7FPnz+jYPA2hojeAtUm2QYYdrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606135; c=relaxed/simple;
	bh=ElsZmgxqD/eqQkXc5DmRWHIFNq1Cc3qT21Nzobdophw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hi0iJqYVvrnUiqZNlytccIhvqSsfp1wK+mMusMNHVyTzkPLStmVz8ShQ011tg9ZhDrKeTUy9jnqqUIxEBbA856F1vnTN9FrIY9yGJs7zWUk/eSsj3OgOzNFHWU835QZ3aZGsMXkAx67hXgosggQbs9Dv2IFTQUCM+sW+O/0jsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OWMYS5Qa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV0mmGU3791441, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735606128; bh=ElsZmgxqD/eqQkXc5DmRWHIFNq1Cc3qT21Nzobdophw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=OWMYS5QayAgzIrmfZZ61XkCjfqrjctGIZCNVcaZ/XhbAppikjlEFp09q8qECxNzRc
	 +nzh8rPusaB3DkyUUBcLNS0PSfv2kKjfDvr+WlC4ggdhHIsw5kEYhHOeth0Y+dEp1o
	 +WQFceu8KkYTfc9rxhJ6aXeIKkh5JMNS8Q05nMhHExvcKpblVwkRqknlzE1uUV6QhD
	 iz5GusqJA48K6wODitY5x7of5BNREORMu+imbqKoB7ZE2etGUkusL8ymIPRwfY+y2s
	 RzgGRRVIKmHoUlz3IrLD9ooKpqf1+pJcOmWqExzHoHnBBG40Vl37ej50ZX6D6Qllsb
	 kV37LrjcX8NHA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV0mmGU3791441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 08:48:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 08:48:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 31 Dec
 2024 08:48:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: fixes MCC and header conversion issues
Date: Tue, 31 Dec 2024 08:48:07 +0800
Message-ID: <20241231004811.8646-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

First two patches are to fix issues when multiple vifs operate in MCC mode.
The last is header conversion issue, which should be enabled according to
MLO connection only.

Po-Hao Huang (1):
  wifi: rtw89: correct header conversion rule for MLO only

Zong-Zhe Yang (2):
  wifi: rtw89: fix proceeding MCC with wrong scanning state after
    sequence changes
  wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()

 drivers/net/wireless/realtek/rtw89/chan.c | 29 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h |  9 ++++-
 drivers/net/wireless/realtek/rtw89/core.c | 11 +++++--
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 40 +++++++++++++++++++----
 5 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.25.1


