Return-Path: <linux-wireless+bounces-30145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D03CE52AD
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7142D300A1E8
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40D217704;
	Sun, 28 Dec 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="gCF3cvYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB620FAAB;
	Sun, 28 Dec 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766938341; cv=none; b=bzr8LPlznNa+ZT51UjdrtCrC6+hG03eK5y+aEpH9NHo7dxUVPWvwHrZ1N2xLqUCGCgAycRUysEsdOEekjN8moM2//dqGAymXbOZcKcYGf/K6w+UjO+3aDlgRODn91I982bw76SWYLmSm3P8qtgXixMTlLMG7gZ34WWZrx5Oq2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766938341; c=relaxed/simple;
	bh=uQvlVeJZ34pERZt79+zBpNmBXv/xfToAcBhszokWimY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vbk8L6AF+/7In9Oi8NMXZjQLAfGmjFwUp8IgTNVVQXK408QP28tkOSbKraidTTI49Hy6zOx6s1UBuIsLNvmHVbj2KTtAy6OvJTnSpzLwWc2yHY0QPkJVdmUdL1hA94RzEIe2gHGYas9DS9+1fktk05ANxXoHBfIjpS8sG2gkFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=gCF3cvYL; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=gCF3cvYL;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BSGBMPV1236900
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 28 Dec 2025 16:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1766938282; bh=zklBFMW/AlGQ/7gdXMtLcdA06o9WVsBmCI5Z77APoaM=;
	h=From:To:Cc:Subject:Date:Message-ID:From;
	b=gCF3cvYLlZfaTpwgc6ugGCBR9PBLxCofl1X3NDOpJ77E+Sa9rX9cnkjpAxI00T+a2
	 YYs3/ztt+rsIZI69L5ijJU9BQswfjLkImc2ZrvkLNwnkrrDFlqnRjuA1Lc+IfTZIjf
	 O6nwyX/eir4iIoHXVCN4NKr9dML62/UwQ8fsj5u4=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BSGBMRh2208669
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 28 Dec 2025 17:11:22 +0100
Received: (nullmailer pid 1424925 invoked by uid 1000);
	Sun, 28 Dec 2025 16:11:22 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: Felix Fietkau <nbd@nbd.name>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] mt7996: trust eeprom data from nvmem for now
Date: Sun, 28 Dec 2025 17:11:06 +0100
Message-ID: <20251228161106.1424861-1-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

The iFEM/eFEM classification does not currently support some of the ADIE
combinations in use by vendors. Trust nvmem provided data instead of
falling back to wrong defaults.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 mt7996/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mt7996/eeprom.c b/mt7996/eeprom.c
index 8f60772913b4..3e7670a60fea 100644
--- a/mt7996/eeprom.c
+++ b/mt7996/eeprom.c
@@ -172,7 +172,7 @@ static int mt7996_eeprom_load(struct mt7996_dev *dev)
 
 	if (ret && !mt7996_check_eeprom(dev)) {
 		dev->flash_mode = true;
-		goto out;
+		return 0;
 	}
 
 	if (!dev->flash_mode) {
-- 
2.47.3


