Return-Path: <linux-wireless+bounces-15653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0D9D74E0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D911A286E7B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBD1FE092;
	Sun, 24 Nov 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGMMk8Fg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586821FE08F;
	Sun, 24 Nov 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456578; cv=none; b=VvIx3EMyAQidThqooxxU3ntrwXj8gkHNsf3akMdhXgTK8iWy/6OxosOP9ZR0RaZAjklYPdbZ6tk0bOY6C7wJY1g/UdNlchVLNilqhiWTP4cgwDgSYAzeJqRmjlEkbjextdLKO1zn73Z2nWycjMbJesiIrQP4h/c6qUP20IPzcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456578; c=relaxed/simple;
	bh=LmhhAUpzqYQy5AQcuG9UQg7aQiXz3kdeEf+fxnjFYy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCgOdHgBKyQXLCNCrjnD3w/cI1Ix7j30YWk5F4yMUllaGt/aevNfA4OG8ppfzg6lAL9QFZ18mKjiTcvrJYGLu9tSVtWUkM++WaiwtsUCu+mV76Z9307iX53ZylqH1e7u38a10SEQ8dWrmg1+tz/7qNex6iyPPBHuIffVnpfSKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGMMk8Fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4683C4CED1;
	Sun, 24 Nov 2024 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456577;
	bh=LmhhAUpzqYQy5AQcuG9UQg7aQiXz3kdeEf+fxnjFYy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGMMk8FgyqDr5Zr4tPa7dRjfirURTCkxU4gWbjYNcaKruxKMI0vmqRWLz8n+1zYFl
	 E3u5U1SYBlrx1WqerkXeJXwS9u/7e15ijU2zb51di7tzvzMxzETK7g9OY86LqkGDxH
	 Wzz6sl4UqSrcZ+OL9scLxH00bdXA4pd9itb6r88oNcEIRVJsyAh1RsgpRN0WEqWhG+
	 zLX0Fqftv7mTu1iR1biJZ0SZBnUrLL0C76MBbSPFGZKzVgfMqcAoe06ly2aGOG+j6P
	 70OFi2pIMDqIRN84E/pYxIHoV/11+Fj7tHwW1tY2SZfV27+JWiSpO6lXFsGXmTvNIA
	 bWOzdfIz+dp7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	mickflemm@gmail.com,
	mcgrof@kernel.org,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/28] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:55:15 -0500
Message-ID: <20241124135549.3350700-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit f3ced9bb90b0a287a1fa6184d16b0f104a78fa90 ]

Arcadyan made routers with this PCI ID containing an AR2417.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Link: https://patch.msgid.link/20240930180716.139894-3-rosenp@gmail.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath5k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index b7f62c472b879..e58da21b28ef5 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -47,6 +47,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
 	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
+	{ PCI_VDEVICE(ATHEROS, 0xff1a) }, /* Arcadyan ARV45XX AR2417 */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.43.0


