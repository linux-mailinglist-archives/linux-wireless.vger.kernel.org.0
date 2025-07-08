Return-Path: <linux-wireless+bounces-24905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD6AFC3CB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E964189E5E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F821B905;
	Tue,  8 Jul 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McnzOBb7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B680219317
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958747; cv=none; b=ZSpPfnbDr5yq3iiEEletgrGMWySh6gr+fQGKnDG/kCQ1ufU8ElDwOFgaWoEOcdwUYi/8wLQXrRu8r8wfz9pTOZN3sE/ewHXYubVet7PDIf5Wr6DH3l2RqVdkhfWP4ao7mZK9Wl2BY+pUJW0X62s+nM2CFQYkXw4pejOwOFay99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958747; c=relaxed/simple;
	bh=gjo96x9e45Yxy/9KO1uojpXNo9dbAQFOswgfQn3glyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aIN0ckDj5Aa++pBlDJJiimGHDG4zhg0xj6ksTjLPM5FwZnK5Wgu86m7v34T2PnQrwRJsXZx6dYxGDayzNsucCEeis5lYk8yAb2BVlEQlVOvqJdiM7ZrsIvhHwfKgQOoJZLJpbO1O8n503JHx9xmbB6q3BkAer/AIN/9I/0jmKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McnzOBb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3CBC4CEED;
	Tue,  8 Jul 2025 07:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958747;
	bh=gjo96x9e45Yxy/9KO1uojpXNo9dbAQFOswgfQn3glyk=;
	h=From:Subject:Date:To:Cc:From;
	b=McnzOBb7/RzDNvcdlzM1uSubEdBkiig7ZRA5PyG+8wyb0LBeN+lV/uZNuOuEbTjQk
	 MQfoxQg/Xk3SwjfTZCJiNtFq4h5wqmWi9zTCZYq8sYSVWu4bHMWkKEUb4sQrSWvmxo
	 FdIkGuBQ6iISqJH9gpQdCUMO6wbcaYhhvaS+gtML4Ony8fITM6mKhqwQHnLYN7hL+e
	 Lhdyy+ZJx54sweX/XtZIUzlWfdL7ydaYwgmVBhbBVSC5zogXwMV0d5Pbr10+fzHtm1
	 25j8nRvbnchGllJLG34a4DvTm62xRANOEtVYuyyDns1en2l6i7fi71yWcdxsASwRYf
	 l9UfsK9lJXCWg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/2] Fix MT7996 driver performance in the mixed
 MLO/non-MLO scenario
Date: Tue, 08 Jul 2025 09:12:03 +0200
Message-Id: <20250708-mt7996-mlo-fixes-v2-v1-0-f2682818a8a3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPEbGgC/x3LQQqAIBBA0avErBtQodSuEi2ixhpICw0JwrsnL
 R+f/0KiyJRgaF6IlDnxGSpk28Cyz2Ej5LUalFCd0MKgv7W1PfrjRMcPJcwK1866nqSSxjqo5xX
 pb3Ucp1I+14tdCGUAAAA=
X-Change-ID: 20250708-mt7996-mlo-fixes-v2-d59f6e12189f
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 MeiChia Chiu <meichia.chiu@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Two more fixes to improve MT7996 driver performances in the mixed
MLO/non-MLO scenario

---
Lorenzo Bianconi (2):
      wifi: mt76: mt7996: Overwrite unspecified link_id in mt7996_tx()
      wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid configuration

 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 32 ++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 12 ++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 +-
 3 files changed, 30 insertions(+), 17 deletions(-)
---
base-commit: e553ac0d7616d6bcd06ed0c5f6126ce83097b31a
change-id: 20250708-mt7996-mlo-fixes-v2-d59f6e12189f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


