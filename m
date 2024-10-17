Return-Path: <linux-wireless+bounces-14115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AF9A191D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 05:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2EF287876
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54F7DA7F;
	Thu, 17 Oct 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="djDlbMNi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF87DA76;
	Thu, 17 Oct 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134413; cv=none; b=K2VDXNI1ZBBWpq/8mOwMHUjv/+e8c+3hIJn+pmp61L+FyjfgQ+gAL0uP9M1XYk7Z7vrQZxtcJGeYceIYvJK7gzXn4N1L931V3TYjmLeadvDlhF11bYy3czOnnBR1lJN5C9k42wJCZbI15Qsub3DxKxllNQxnDa9tr3bxfIHQG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134413; c=relaxed/simple;
	bh=4axLk3F3w0ykKUkmu2YQGXDfaHagaySoaKyMLvysj2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvy+FztDq1YfhivnbWx8Woc++E2C40Q1wP7S2K7HBFzjYf2pn7oa1U8bJW2KDFbrwiO/Qv4xMUNT0ApCa8h87JwsAaygurOTxjIv9qOS9dAnMD4Y5JAqUWtLLvk3YW+A9ZD/Dibz5Zi/fKp+mfhu2Flm/ZTZE87Y3oAOpWq3JRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=djDlbMNi; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729134396;
	bh=rGntS9xOFiEeM/CMGDTBCcX5N9b7TzQhEkYEMSmKp44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=djDlbMNi6h37w8nIdlSYs8p0t6fblM0QwmHTN0TBgQjYRzMpvDCkM1MFcmZHaZAIC
	 jopca0MSIVuigelZLkMRjXY2gRC37P0+QCw+Ox8UZ5LOVu0+kB21hN2crZvK6tB1o3
	 YZsiQyAIbKc77z6LsNB/CeUHwvZlANO6POSiJaOo=
X-QQ-mid: bizesmtpsz14t1729134356tiqk8w
X-QQ-Originating-IP: JzxPHKK/gP3irJfApYxXxk8Z6DxYHx70zkel4N+qhuk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:05:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5622655037225638582
From: WangYuli <wangyuli@uniontech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	raoxu@uniontech.com,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Thu, 17 Oct 2024 11:05:50 +0800
Message-ID: <08A72BFE4FA79ABB+20241017030551.85817-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mi8L5y2vR+gqY0zMJJa2wYQZRfXm5Tqpfb7AcdscAy1B2jHl8roNKtXA
	9FbA2xzR1ATCxfsJH+TFaZSvci+E8bW5/9zesVaT4tDVKqS1KAL1UoWUldxE9RTx0qsv06r
	3SL1bw21C5EeC3iqseYMEjXdGjD2rxbcqLh8hE6I0oS2/2sZP4LDPe632CvaBg4Qk2XkfpY
	Ve+8FRSwDX52LPnSU9Tf97FmyeRrzeQ4wXtRTXqhN7VJJpnbpp28LVHhkkGmgTA1Bth8Fsj
	zlXp5gZcaYozEe7yqGy+8srwKEuqMP2vgf8T/jh0kshnNNo1XkBVEiT+Myk+rnW3GPYq3IF
	CQaWjoBKyniDgfYWg8GGmdLmyUnQMvpD5fnEqZWwgo65ZjOhT+XfSC5gWTGD2R3OzFWfdj8
	6Aze2turrYHV+UlwP19W46VlBs5yY1KRGyEZhiXDFqW4b/zPJ6eXFP7bSudmMgju6fHjvIl
	4hi99OPRFUoaAlKseLUK4i+UOYVCA0IRhRHhBuUqf1Wp5k9BeMLTZtT/rnxK81fxVTOSans
	l/RQf3tOOmj3GJFXon4f+SXXYFfCtuzWV/K7c0R4FCABmwZSc1PTzl8KdLRElcRbxTnt/h8
	EkOKX2AmSlnPr2DbZogkRColK/f+VDVYBh7lbm+YhVdfrWSRmKpN5aKzsWo5G0mVL6wHTEz
	klofDehLexJnJniEr26cfjEfYSdsVD74SkyrZ9rhWTVnVPj5NNjZ/wV6mjwK3iW54RitDfG
	Aogfevo8w3ZicRR5m3/Skcsr/1T7IgZBGuVc/OCBJVXkUrOreeUn2KQJ7gH1OKK92iUFupM
	Ehs06fWYDShWkP3oBb82LAFgCS/OlaMTg+o+FQdA3GPiC3LEoomYHZsSz7XnAh0NKmpTUPN
	GKhsNqLfAExG4gpTq27dRkPo6WyDB3Qizl7ggudrIooFVtOV3YiyqP4Rfrvb+KCaB5y8bjA
	1e+kW0pztHoajFfkv3n1RNgH6GLnfOxhZn0MpXUuxrcLVSzYI44cYEQS85ol3h3Tkdw8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

When initializing the network card, unplugging the device will
trigger an -EPROTO error, resulting in a flood of error messages
being printed frantically.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 58ff06823389..f9e67b8c3b3c 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -33,9 +33,9 @@ int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 
 		ret = usb_control_msg(udev, pipe, req, req_type, val,
 				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
-		if (ret == -ENODEV)
+		if (ret == -ENODEV || ret == -EPROTO)
 			set_bit(MT76_REMOVED, &dev->phy.state);
-		if (ret >= 0 || ret == -ENODEV)
+		if (ret >= 0 || ret == -ENODEV || ret == -EPROTO)
 			return ret;
 		usleep_range(5000, 10000);
 	}
-- 
2.45.2


