Return-Path: <linux-wireless+bounces-16749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7B9FBACD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 09:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FDF1884626
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74252192B69;
	Tue, 24 Dec 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k6d2X/hd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561F1925AE;
	Tue, 24 Dec 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030517; cv=none; b=GSaWz2zwsWwRwqHAelEoCnBgdIrzFtxOyws9U8WkwHDxaZ3rn08sdU9IO4KThk3U0LTCskZqBtj86LvAyOVJCkXvKAZ2ZYqBT50unhRwR+YsuTtCRwc0+BQfWIpLUZKTL+lYefD7bGBVnj6hdqOxN+lDCqrmEfWIY2ppaCIX6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030517; c=relaxed/simple;
	bh=90+x2RjiN0d1WTwTmBN4pZjkDM0LElpAVBWh3nmtQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oeyw6X0XRlr9YIWcvSLCUsEB5ugYFNAyQO17AFuiLRnJfAsmYoRLhJt9uS2ADMnxFKps3TlGW5yDVDgvmL2Gpz2D4Ak7u4g/yBNSdaFFIiqiXg9NpcKY3B64YBENyBYwVsBB1zRV+ZjocJKVMFOvp5ZvkXoigLqaoema/QdXHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k6d2X/hd; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735030423;
	bh=hlFS13odVb55GccO5hmoQYgmewqIs0Q10x0eG5VUCq8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k6d2X/hdTdTocZzau6nD9TI9fF6cO9btESnKDPkbjtaJ4jRMem/N3f+BlJDzs9bFS
	 bBsxHwBacxjFUOKlYxK3A8heBpy4wf1dXEQC3Oe/8CrNassAHPaYGZWcS1FQUTs7v0
	 4UpUy+jStKsUNhEKj5I36SvHZUsouEI4zOj4p674=
X-QQ-mid: bizesmtpip3t1735030374tjbdwos
X-QQ-Originating-IP: +Rx9ITqM/H7d062Vb3FxXVe37HRvYxsU2EFSjD4Gbak=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Dec 2024 16:52:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11559618080003878219
From: WangYuli <wangyuli@uniontech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander.deucher@amd.com,
	gregkh@linuxfoundation.org,
	rodrigo.vivi@intel.com
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
	sgruszka@redhat.com,
	keescook@chromium.org,
	markus.theil@tu-ilmenau.de,
	gustavoars@kernel.org,
	stf_xl@wp.pl,
	romain.perier@gmail.com,
	apais@linux.microsoft.com,
	mrkiko.rs@gmail.com,
	oliver@neukum.org,
	woojung.huh@microchip.com,
	helmut.schaa@googlemail.com,
	mailhol.vincent@wanadoo.fr,
	dokyungs@yonsei.ac.kr,
	deren.wu@mediatek.com,
	daniel@makrotopia.org,
	sujuan.chen@mediatek.com,
	mikhail.v.gavrilov@gmail.com,
	stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	leitao@debian.org,
	dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	wang.zhao@mediatek.com,
	chui-hao.chiu@mediatek.com,
	lynxis@fe80.eu,
	mingyen.hsieh@mediatek.com,
	yn.chen@mediatek.com,
	quan.zhou@mediatek.com,
	dzm91@hust.edu.cn,
	gch981213@gmail.com,
	git@qrsnap.io,
	jiefeng_li@hust.edu.cn,
	nelson.yu@mediatek.com,
	rong.yan@mediatek.com,
	Bo.Jiao@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Tue, 24 Dec 2024 16:52:44 +0800
Message-ID: <BA065B146422EE5B+20241224085244.629015-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NMguc1TmhkUh3PCes9G2PpJteC6Exx2Q3HrNXr06xUmGb+BXnEf2VlaE
	Dnpt2EgtfoGzzCfS/PoX1a8i+cqKnNvLc9vi1boa9QS1032/w9MRt1w5L/z+EjqwiOC5TBw
	ohL8PhMyLXP6oqYUvc6n9mFDg5MNO2vSjsCrxLW48WiIKBSmeq+WUI1/qFDrGCkWWNrRu+W
	pIVIQOEjXLrEiPN1zORGyxRiWCfykwYmFc38bfipTfDnFM/GbYBbrLSpRApRfSm9KbZsQJL
	xqGpE5QEhU/9DLByUahXbEIbRhGHZbfwwfN8oduAPdcYwD630CAiqMDCRnnpLPCDaPgG5ud
	kRoqgpYuzSQXkJkBlYGGfRTqr7htb30UErbrmBmFY85DdTHzR/HY+O428AemeuBWtF7SNtc
	ZIDk2FYUH9W+z+ehircpSyrCAvpkWwqptWFCTbEd9UHwGohpnuB3h9TPvaXhiku/5MFAXge
	3hDERKTVda96tCT+G3aaJM74geCFEabyyLmWh+irECpFKEqJTNZ5htBL51AlI+k0zm/caLG
	CJ/nqcpoKz7T8CmTWN/w3ZXZxu9DcZfK+FA+3juNptxfUf+OhDXLxwDNeFvzFPq8u06Be1O
	mE+fXRC3O8//I8aMNZrKUbPwo/1Q2X1Ei32R7Oq+qmLlwX9ngV5ORw8oEiVxjxX6huHBcyH
	kCB3vWdVEyhlEDdI+pD6C0XxjBm2zJQ1jCh8K3SZ5KitKJt5KVmO4ctTtY6w7dAJT231mA9
	Rk+/x5wcMVOzpWzOSrrISgE9Ui00F1LDMEP37CC66KhFgo+iAVqe6hmzMickMBPZ32eEdoO
	GQXgtUl0fm5bbBmC0ddIDgmXlzDVaNyu30Kej9RfEQXP7BfmCsPGQCrT7FGx2KgQ07F1EFe
	s6fEma0+4PgxX/i/EcheWacroOObJ5aoPhcX49GBgD8LvV/IP8TVrrM6qpdFuGmPID4OL5m
	XpZ35BKKzJGMQkHZtTRmzmhK9XX6LfkFrR3ry2dR7DfFR8JNeCv9CFBbxKRiKK8EmTck=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

When initializing the network card, unplugging the device will
trigger an -EPROTO error, resulting in a flood of error messages
being printed frantically.

The exception is printed as follows：

         mt76x2u 2-2.4:1.0: vendor request req:47 off:9018 failed:-71
         mt76x2u 2-2.4:1.0: vendor request req:47 off:9018 failed:-71
         ...

It will continue to print more than 2000 times for about 5 minutes,
causing the usb device to be unable to be disconnected. During this
period, the usb port cannot recognize the new device because the old
device has not disconnected.

There may be other operating methods that cause -EPROTO, but -EPROTO is
a low-level hardware error. It is unwise to repeat vendor requests
expecting to read correct data. It is a better choice to treat -EPROTO
and -ENODEV the same way。

Similar to commit 9b0f100c1970 ("mt76: usb: process URBs with status
EPROTO properly") do no schedule rx_worker for urb marked with status
set  -EPROTO. I also reproduced this situation when plugging and
unplugging the device, and this patch is effective.

Just do not vendor request again for urb marked with status set -EPROTO.

Link: https://lore.kernel.org/all/531681bd-30f5-4a70-a156-bf8754b8e072@intel.com/
Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Co-developed-by: Xu Rao <raoxu@uniontech.com>
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


