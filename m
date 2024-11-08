Return-Path: <linux-wireless+bounces-15133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDAF9C186C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86281286734
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940741DEFDD;
	Fri,  8 Nov 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fGma0MaG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518F1494D4;
	Fri,  8 Nov 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055889; cv=none; b=McshR7OgRrHTc6EWntonJi+VbnH6Hxs2GLayQj90XKoI1lQiGfsoKDh++alLvqunMpf10M3bjPKHYv8mHEyd4WmZEwbQqSy8M5lAsJi4oO+nkVl7BmwgeYbV7lXABkxgX6zx/eFbmh9mWI3kVCg0hRoiXptMPivPZ4lQKYSfD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055889; c=relaxed/simple;
	bh=4axLk3F3w0ykKUkmu2YQGXDfaHagaySoaKyMLvysj2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tps8lfBvi7ZCcaZMGshdz1snjiSp84IYmlOTr9LONTChYNsNHfFSJ9NMuaH0SAitjK+9Cjbbp06Kh49NUPxOJKBwJmWW8QAwlXDnVPgxx06Ml9UGVm/9Czjl3hJXEHVb+vp1zNxnk5BTWMToySU2fqqD8kQLYeQNxFjzwOmM5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fGma0MaG; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731055772;
	bh=rGntS9xOFiEeM/CMGDTBCcX5N9b7TzQhEkYEMSmKp44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fGma0MaGXJqvSiRMFhmXZuzSAbOrQ+E+T2PjWQN4kISfXB7+v2P5lhcZiDccqkN4B
	 P1rIzIv3DujMeJ2qxJoeQ1N9MmLhZqnkyQdQ7Sl7DUM6oOffvJqemITdzVXIm3Q8yB
	 R5gngfRDt/O00amCBzAnz6b2xHHpiGfwiuPhZssk=
X-QQ-mid: bizesmtpsz7t1731055731tg3r48f
X-QQ-Originating-IP: HMuPYdKxHaX+3uAFUvJr/WnEj9U/cZBw6s5Od/w6wdk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 Nov 2024 16:48:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9163737178640773369
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
	cug_yangyuancong@hotmail.com,
	lorenzo.bianconi@redhat.com,
	kvalo@codeaurora.org,
	sidhayn@gmail.com,
	lorenzo.bianconi83@gmail.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Fri,  8 Nov 2024 16:48:44 +0800
Message-ID: <76949420D67A0377+20241108084844.216593-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MR/iVh5QLeie+eRnscg9XS0zFUrlUzPpdNyEUKgvat6AFV1JFtHsyuqO
	Y/BEbAtUHcx8vNoaTFdTsw2GUjVqX9vvWxS7lI8S4+rLbCEPomdxr7DPr+xaPWyS5eyU0vk
	n0skLV4BuMa6SAQ2Nk9WEv3oeEQbYbLwKcrnQMXKSSm2aELnsDbVluQuislP/jwHYh0c2fh
	cJZvn5p8ws2zRl30cGKTuVmxCumpdG976iy6eqKWfziKdSaIxP3rtNd4U1ZDArYwkGQkaZe
	gu7xBCDxoub7x9eV/RZdaQgMAuPy9qndcPEod/EgIoEle9XQGGqWRgdpwoIKzz431A84Z9B
	JJSllxQswbwLqvth+ViZYFShZDyJ3wmLsfomneMTmd9yNiMUh/qFIVvlsoYACJUHy8T3EzU
	0iuzXVAARxtt1nvGiTIrzYnlOb8ITK4voSrTM1TIaVh2bTKm5pN3u7IPJ9fZYAbdIIIdumD
	fIPWNPlysmYlljYtO68b+M5icxvewTOZLu5rwRvHJJ2Dyvrd6uVzqMfhmCnTHx74SHxjjeF
	6ef5jOZUI4ApnO5YDFgS/b8NdLKe662zRcSepEL1dYmzLvdVVpTgxjPmuZHufTv+TGI01cl
	zc6fI2A5RQ3Mz1VaIfh2T2oaXnzLbXUaTcZE0Cf3zQisoLJwlpKhhghNXRDkKBOsd+dD1Cy
	DJqpNZtVz9xuK53M/LBp9vUEpsQU07r9HY391V7NpqGg0aT50S81LoXptJmELYlXovJ26fT
	LE/K6sOF0h1sGXP2kLZ3CHKoRCh9141MNBn2ycQjT5GjwDDR+OLZUcyzF7MUE6R690Yzkuz
	bInwNzeh7P1uQ5L2eO1tk0ddo5lLY3ruMW4jQJhOnidSCp1fi4ZB6Uy2KcFQG7w3ZoaVhNj
	D2olJ0Q3oyjRh0cWh609rs6jNrsHPON3SVeuzAX3YLhsouNWL4fx2XeHqs2eOh7/6zlqukO
	enle2q/araNXGtqPO9eqqSIxOvX1KFGWjrtgMc1h7BvUi0RNUt7HqtTBvxvA39dKSC6ThRL
	dLi0Z5gOhJbiF6zlTcoMmC0Su7fE8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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


