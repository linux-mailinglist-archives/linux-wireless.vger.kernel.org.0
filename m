Return-Path: <linux-wireless+bounces-8563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79E8FD04F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73F81C23F79
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF09819D88C;
	Wed,  5 Jun 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="NB52GCUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0063D
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596034; cv=none; b=TLsL8fm2sSRZ0PEJ/SIuIUWW+rbHpg4UAkKD2g6q1YhAGFa13PmHk7uN3Y2jKkYFAULP+lUpwBmqVtLLQSr2Lf8JaBdr3W8ijqPPEhepOm0+xLPQfGkwhcbTOWXrqPL2+N0uBK8mC1T6QxbZUb7viopOpxrzOtFiw0w9zWlAPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596034; c=relaxed/simple;
	bh=A77GkF0LLBQA7Txt2ipwUtppct2n1oL1D694pT7X6TI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=FdzK3NINxJL2e5ZFIimzOcpTx0gNcBKHnToKbVTqyxiqX1kfV3KDOMlHjLYAhx8ei6In5GsMFAoJJPRIK9LDTtPo6paay/ZlXWgpHa4w2gWShpdNszxi42l+fYBEqOJL/A1d0rW8P60QNyPOGyybDZ2NfikDQqZCYggQi9bY9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=NB52GCUT; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sErBg-008ucS-0j;
	Wed, 05 Jun 2024 16:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A77GkF0LLBQA7Txt2ipwUtppct2n1oL1D694pT7X6TI=; b=NB52GCUT/5M3+Cn0TPYZFZJ7yn
	Q6WnbxaIDgAVs2gvl2pd11Bjal3Ggik6CZmHST71IvFxOdwlyhZP/4gOWhXDDg73rG6EV8dsNxZym
	TMhNB5PMNBkvFXpenl5rSINsnMxpj7LCmFM6V8xM4QB6sE9ZvuaEkCIeB8BzuaAyRc0fBPv6y6TMU
	AXJ63XZxDqtZJLvtdp2TvlHhzLQHRpU9gRV8LwbrV4mT6IMNAxHerP21/8eF+xVMQ4gTSv8xXC2r4
	WG1E8mJYFAeLZHqyd93mTdt8ih8CacAvm6Yqdd27VMxeVWguPIU6Xi6qkXf9zxUG9pveUa155xK+s
	wm9/zFQw==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sErBV-002hfv-1m;
	Wed, 05 Jun 2024 16:00:14 +0200
Date: Wed, 5 Jun 2024 16:00:13 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: briannorris@chromium.org, francesco@dolcini.it,
 linux-wireless@vger.kernel.org, linux-firmware@vger.kernel.org,
 lukas@wunner.de, tszucs@protonmail.ch, yu-hao.lin@nxp.com
Subject: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware git
Message-ID: <20240605160013.6bea8d4d@aktux>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I am a bit wondering, but there is mrvl/sd8987_uapsta.bin
referenced in the driver, but apperently it is not in the firmware git.

https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/nxp/FwImage_8987/sdiouart8987_combo_v0.bin

seems to apparently work. How to proceed? Should the file be renamed and added
to the fw git?
The uartuart8987_bt.bin needed by the btnxpuart driver is there.

It is just nasty to have a driver for a device but some manual matching of firmware

BTW: there is also https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/nxp/FwImage_8987/sd8987_wlan.bin

Regards,
Andreas

