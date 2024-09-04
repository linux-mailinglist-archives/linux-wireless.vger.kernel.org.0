Return-Path: <linux-wireless+bounces-12506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C796C668
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E25F1F23927
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701D1E132C;
	Wed,  4 Sep 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="dHIvLbFS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7141E1A0F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474551; cv=none; b=rPOEQ4Hb9ODkHgfbH2Jv1dbIUa8xNnK0VeEzaDvvF54XH4KEY5o3+PMQ3BszcGOW+KR2KKli1sCdJkukpCRjYbQF554bKtesrPc9i/agNPz0hlY3WAgEpb9Bizv2OwCJZ+e/fE/rMJkRN/yO3h2Dn+otw1EDDSLSIp/kiRx6EfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474551; c=relaxed/simple;
	bh=Bx0NfChvS/WRzwXKgzFXcOJ4I2pWdn1qR9pxH9TDklE=;
	h=From:To:Cc:Subject:Date:Message-Id:References:In-Reply-To:
	 Mime-Version:Content-Type; b=cf+iN/jGGboG5yz74Q51ivwkVb9LZHVbPf2nWVLE3XF1ttT2RjeAdqNmxCKcI3Ax03P3TvHtYlr5AOa7kB0wra02z9A0bJTpgPvjPyf8+0ILUXRLxEcP+o9jYg7NRnVH0DfYD+T0k/Sxq4Ri/x6FtQtDbhM0zr36bTnYpwBYjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=dHIvLbFS; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-5549df4ffc-zc8mb
	(smtpc-mxe-5549df4ffc-zc8mb [2a02:598:64:8a00::1000:566])
	id 3f8f2cc5c17b9e6f3f01a2dd;
	Wed, 04 Sep 2024 20:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725474526;
	bh=Bx0NfChvS/WRzwXKgzFXcOJ4I2pWdn1qR9pxH9TDklE=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:References:
	 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
	 Content-Transfer-Encoding;
	b=dHIvLbFSoCy6SLun53I7arXesqBJEuo6+FAQKPDYbKR6aQ2HPrVjMacDR5+hoOHby
	 zWS1fSuHb7mGs6S986h671ot3WpSmc0ghZMiaTL0DbgEXLjcphYpkgamz/iWXSqxOv
	 4jDIp8NqGQ5Nrt4VsWDPq2+edLpW7XCHsCYJ2L4pLsXC+9ETZH587YeGJ0rfBBj831
	 SO4kI0S78pJYmHgvcKGQTJHI1iQAXtdast/W4xnvV+6kAq88nzkENxAqMn43mzABdx
	 fZ7tsiu6yHbDoyusZETy4K1KBMiD3k97gCZowvRNKhpd1dkLx441QAGRqDuZbYJbXw
	 fh/AYPe7MhrxQ==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Wed, 04 Sep 2024 20:28:41 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>,
	<ath10k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath10k: add USB device ID for Atheros QCA9377-7
Date: Wed, 04 Sep 2024 20:28:41 +0200 (CEST)
Message-Id: <56o.Zbc9.7x3xmPitckT.1csARP@seznam.cz>
References: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
	<8b7d9777-e239-4173-bec5-607e15b98130@quicinc.com>
In-Reply-To: <8b7d9777-e239-4173-bec5-607e15b98130@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Also the Tested-on tag should include the firmware version information a=
s well.

Hi Jeff,

I tested it with manually converted firmware from https://github.com/8devi=
ces/qcacld-2.0/tree/CNSS.LEA.NRT_3.0/firmware_bin/usb which does not inclu=
de any explicit version.

What version should I write in the Tested-on tag in this case?

Best regards

Tomas

