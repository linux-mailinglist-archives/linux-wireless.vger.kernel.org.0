Return-Path: <linux-wireless+bounces-27688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC6BA7761
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519707A9F8D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516D271470;
	Sun, 28 Sep 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="hTCP0k1c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3D34BA2D
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759089671; cv=none; b=hzHJ0u3g4O2z3qUJ3c5vmk5fvfjwt3znlt3tb5QqAoQXUgmo++LhIjxkvQSBuG+mCPt3QJCmjplrf8odJlNKOgfBps/OE0f/DJl77O15bNAEqaCNfCeQh3ZUMpeHk6WU0cfSC0ab7wVuqu+PZWphrsttpNZRUfQ07JelZEJMu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759089671; c=relaxed/simple;
	bh=DMEKAsi4XsPuSlx1wzyOiiPwWktMbrjUEk759KS+zQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdjduSEJT0lPf3P70+6nQ0Lm55lDkmQgwGNOFyqapQyjcnpnLaNyvt17Dqe0W1gR0PrxeweTP/2Ui/YMtNUhpyaexrj6YNJnXpVbIFWHBD3WDuolPOHuQbyA+l+Eq5Of88Xzl789RhrH/AWLWHwGNvSuyr+k7jSDLLZsmOsUnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=hTCP0k1c; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
From: kemal <kmal@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1759089660; bh=DMEKAsi4XsPuSlx1wzyOiiPwWktMbrjUEk759KS+zQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTCP0k1cx0jsMlZXiITuOVY1gWWnFb4CLoOPB3gWfm+pG2ouqVcN0EvqH8MBHUDQ+
	 0EHxCETWMng/n7bDforPEGZ1fxFNKuwQVXOpdjLu0YYQFvY5B2FkFSuwP3ZIwC7nhp
	 nZa70n/q0CMhrNJffWeUstoY9n5btHhIDlsSjHgT9CKEtc6qYwzwzGlBFGtaCmURKu
	 X8ejPw4ArGJlLhELpN/lTVt6Y3kNFE5EpyYF2mVx2Q2bVWcj9Gh8g+4W25JErrPBfA
	 djE8EUeX9g7Ah6Rt1EIq6BzKNbXXTlYUbe/Qg+7QlIluLnSoF4AFAeb4IMiM594ZsG
	 8bM/GvYsaXTTw==
To: hmtheboy154@proton.me
Cc: deren.wu@mediatek.com,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	kemal <kmal@cock.li>
Subject: Re: Requesting MT7902 support for mt76 driver
Date: Sun, 28 Sep 2025 23:00:10 +0300
Message-ID: <20250928200010.8401-1-kmal@cock.li>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <zJTdgBCk5Us_-6bstYmzg2Trn-ntC0_mJyMLOvAQya5Jxg-wn17E3E_go5qM3aqvz1ncA2MV8bqTy_8udMubwLvsxkZuWCfav--IlrA-I8c=@proton.me>
References: <zJTdgBCk5Us_-6bstYmzg2Trn-ntC0_mJyMLOvAQya5Jxg-wn17E3E_go5qM3aqvz1ncA2MV8bqTy_8udMubwLvsxkZuWCfav--IlrA-I8c=@proton.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu Sep 25, 2025 at 2:30 PM +03, HMTheBoy154 wrote:

> Hi, could the mt76 driver be updated to support the MT7902 Wi-Fi card?
> Recently a lot of hardware like laptops & motherboard come with the PCIe version of this wifi card.

There are 1k reports for the card on linux-hardware.org, which shows
its common:
https://linux-hardware.org/?id=pci:14c3-7902


It would be great to have support for this card.



