Return-Path: <linux-wireless+bounces-9036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB390A24C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078711F24A7C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3F13E898;
	Mon, 17 Jun 2024 02:07:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2179F3;
	Mon, 17 Jun 2024 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590043; cv=none; b=IogtVgdEHhG2u6DZba2BmJ6XlCWD1JVTLE/vf8EE0vFedx72v7nZNpy0ff0MCWEVmoXBwUTe11L8zMBsYldrvuSYZzWbezO2XNu/RguE0m6v2vtkOpebzg3ppfYyzSQixWNNwRxxHtnqaIYFslKrdg2ANzC5U+A4yu9iMvT6nzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590043; c=relaxed/simple;
	bh=3VSCHH1AOXkI5qcx5xgoNWbZlrJ3YH7Z79eeMHytc1c=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=R7FRlFqyowMHRHv1CqoXEeMVChlOOYmxMQCDnuSJwLili4lhyRoZ/Crukkp9UyziygsYvL8DzvwlIZ2vCbC6F8o4WKqqFvwktWR4iD478LN/4/fbY9XFlMvSXYFMQdnvC8tSzZPeSiVc28V6shwdBbXxFPfYuwWcT542kQupw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H272m842559489, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H272m842559489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 10:07:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 10:07:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Jun
 2024 10:07:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()
In-Reply-To: <20240603091541.8367-6-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com> <20240603091541.8367-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <64c6f54a-a76d-4840-85f0-60a4ce19d2ca@RTEXMBS04.realtek.com.tw>
Date: Mon, 17 Jun 2024 10:07:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3d530eeaf8e7 wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()

---
https://github.com/pkshih/rtw.git


