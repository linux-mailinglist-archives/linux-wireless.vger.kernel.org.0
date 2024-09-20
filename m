Return-Path: <linux-wireless+bounces-13062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922D97D824
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE87D2840CE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720017E8EA;
	Fri, 20 Sep 2024 16:16:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792AC148;
	Fri, 20 Sep 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848997; cv=none; b=LTsAdS4+OA33JmtqIXMjr6CVjsPSsemzDB3qEBr8X7Vy2Hn1/By+mSaxi5c/dA/8F9KrQpiMw5cmq/geVxxTaZIA6+m3dMFtXmLyKIQ45/eqJJChAHRMe1J3AIk3Gk+1d7Tvbw7lsKwJ7/4xbxc0hbMkEUwVweTXPJNjOLeoRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848997; c=relaxed/simple;
	bh=pP9QBZ2rj+9jC0RtFYBHQarl6zNZqGJ/s+i2EcjgUxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lbozd1lXFMTEcj2Q37r6rbH3RsyyskJP7UCc0GMLduIdnL+ZH9np/83KL2EaX4WmCreZNGySaoTEukKpAIwDQ6cBT9vMT7ikOd8Bwqjr6nN07a8KutRquYR45rKdMJHY0ij0I0eIBdlMfEMB3Ozf6BqfxQQGR8cO8OUY6kBbbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 20 Sep
 2024 19:16:23 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 20 Sep
 2024 19:16:23 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter
	<dan.carpenter@oracle.com>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/1] rtlwifi: rtl8192de: fix ofdm power compensation
Date: Fri, 20 Sep 2024 09:16:17 -0700
Message-ID: <20240920161618.21780-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch aims to prevent reliably encountered buffer overflow in
rtl92d_dm_txpower_tracking_callback_thermalmeter() caused by
accessing 'ofdm_index[]' array of size 2 with index 'i' equal to 2,
which in turn is possible if value of 'is2t' is 'true'.

The issue in question has been fixed by the following upstream
patch that can be cleanly applied to 5.10 stable branch.

