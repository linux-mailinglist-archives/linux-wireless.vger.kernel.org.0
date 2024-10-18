Return-Path: <linux-wireless+bounces-14210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A379A3B99
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CE11F2549F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8E201251;
	Fri, 18 Oct 2024 10:32:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A51200B8E;
	Fri, 18 Oct 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247574; cv=none; b=bdNbrq7nlBEOC9kGqRL5jVMgpoEWKtGWZWYLVgE46i6sjkOaNL8ZU5nnf2pomqC8ujqvLQU96+pwlvglm95i8hs2/p7s1ulCfjKvo5UVdC2Qoqf+CQIMD9mqX2faN9/rNtzpr7JvMQkPQKvG8bSHiOWbVohF4lW2O0KQKM3hDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247574; c=relaxed/simple;
	bh=okMYu5Tc60lHAN7IyBOAyiG/fgxCIIqv7EXvuRYZN0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LEVY178PC90K5+ZxODp260Y4P/qncxu51Fd979MQypKfE7HaE0N6PJbsZ7UBXRByu+bIEkuzYQdZiDK446LgnHs47wEJLSMFcv22hAgJ7dCmaj/4HCBccqVLZtqLxF2CB/C8DKIy7SunFkAQc2E8NSjlCQsLgIdinDrkcL0pysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/1] wifi: rtl8xxxu: Fix the error handling of the probe function
Date: Fri, 18 Oct 2024 13:32:29 +0300
Message-ID: <20241018103230.437496-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

Svacer reports a NULL-pointer dereference in rtl8xxxu_probe().
After having been compared to a NULL value, pointer hw is passed as
1st parameter in call to ieee80211_free_hw(), where it is dereferenced.
The problem is present in 5.10 stable release and can be fixed by the
following upstream patch that can be cleanly applied to 5.10 branch.

