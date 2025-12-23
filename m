Return-Path: <linux-wireless+bounces-30089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED04CD9886
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7EB301E6F6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D82F12C5;
	Tue, 23 Dec 2025 14:00:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D82DC76B;
	Tue, 23 Dec 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498440; cv=none; b=CLKUIlro4v+r4LOEiTvg4yjhr4pV4/FDIqTAcvHKDelpT74gTzm1iAQQFr1OGISFbVWAgS7Nww14u8UjWopVJoaVO6E3NUFJcLkFcty+8mmQ6vB4pb7tMQlJyIpqGmtCpe5cR+vV0A/8GRSPFlyyScpZ2DvwKQyAmvIOl/L6kMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498440; c=relaxed/simple;
	bh=0XhwVDlRT33NFRn3iSqCXxw+ekivMtK1ULpu7Tc/Wp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk6/FIfqkGF6LZhe5QSy3JQPl8qBSyLQhv3+k7LVxm241JudEZEYd3sAkkqAks3mbhnq2WQb7MB0qTB164piPU2OptxC6Hy2ecWFrKAllgyntApEPx8MwuSoNW6UX5gFd5BtTXF5/tLMJ7qzMSmoDUJQEU38Be4GadRmVDO98Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.210])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e4b91070;
	Tue, 23 Dec 2025 22:00:25 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bmork@telenor.net
Cc: amadeus@jmu.edu.cn,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com
Subject: Re: [PATCH 1/1] wifi: mt76: mt7996: fix mixed FEM check of mt7996 chipset
Date: Tue, 23 Dec 2025 22:00:16 +0800
Message-Id: <20251223140016.235771-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87fr96tp7w.fsf@miraculix.mork.no>
References: <87fr96tp7w.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b4b82da7a03a2kunm837becb939d506
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8YVhkdGE9LSBoYTk9LSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSUpLWVdZFhoPEhUdFFlBWU9LSFVKS0hLSkxLVUpLS1VLWQ
	Y+

Hi,

> The problem is that the patch breaks the other device variant, which
> used to work before.  If we assume the eeprom data from Zyxel is
> correct, then this variant is iFEM.

Do you have the specific model name and what the RF chips are?
The eeprom seems to be fine.

Thanks,
Chukun

