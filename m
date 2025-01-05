Return-Path: <linux-wireless+bounces-17084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8556A01801
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 05:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21D9162A47
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C581DFEF;
	Sun,  5 Jan 2025 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="S6QbZZh6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9383442F;
	Sun,  5 Jan 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736050084; cv=none; b=sGafD9MelqTPFtqYgWGdIbsom/Cd+8eHPKzgOC7AP8CFnWlxd9d39+zC55nLgux2CmCG769C1XBaKyaKENmkWaL8D/XOE9dWvRQiJ0CSSkglWd2vgxvhLvGPgENiagRZcfMROWz6fTzN12SciDrRG+4pYwAPOmoP8yRFXgbTgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736050084; c=relaxed/simple;
	bh=90+x2RjiN0d1WTwTmBN4pZjkDM0LElpAVBWh3nmtQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIyl7sDIXHoXRP3/CeFrVypMQ0/1P8qt14pUV8mD6/Ic1mLdXGPDdow9nYqOGWQuevaZxSJn4A4XtOl9/xJyFSdQFgBTmcPdN8ODwFMGdRjgo0IK65dZHRYZ2s4/I8FaPm4h0r3aKKowmFXTtbHpfRa7Hoq/F1Yl93UeCQG9+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=S6QbZZh6; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1736050017;
	bh=hlFS13odVb55GccO5hmoQYgmewqIs0Q10x0eG5VUCq8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=S6QbZZh6+2/v+OtWdm65JKqeiTrBIEDkBYxpEZzMnVXw9irQPf2grj3z/WrG3MGGt
	 ktvenTxzB8vn8PDsbsWQTOWOu7XcbA+1cwDO+N4s35Z5w9q8ZxE2JzODNpXmoj0jyL
	 nQO7nQ462+qHztzjh9owCE8nRaVQhu2xRH5vA5rM=
X-QQ-mid: bizesmtpip3t1736049974t9n3jgf
X-QQ-Originating-IP: r3BhvYPkQ0Z7fN4+I8N2dlayxH2rSIzco4OOtcliAm8=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 05 Jan 2025 12:06:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12459793524915979078
From: WangYuli <wangyuli@uniontech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	chui-hao.chiu@mediatek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	raoxu@uniontech.com,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	cug_yangyuancong@hotmail.com,
	lorenzo.bianconi@redhat.com,
	kvalo@codeaurora.org,
	aleksander.lobakin@intel.com,
	michal.pecio@gmail.com,
	dzm91@hust.edu.cn,
	jiefeng_li@hust.edu.cn,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND PATCH] wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Sun,  5 Jan 2025 12:06:07 +0800
Message-ID: <D4B9CC1FFC0CBAC3+20250105040607.154706-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: N4ZILu3POr3O5rZq/TjewF2i6XEMk/wSLT1i5iBLaDCBMNXTVo/TgVHO
	cB/+PIlqLfXHyZnUDe85e7uY1PL71h9kVKmTnXVF/HS49g+475BGQGs4T+0mXHDHJ+Ik7b4
	V4x3h6aNkLd0Gdq8++si9GytujjwQuK3/TnyJLO0nTP7wbCJ1ZpTuxQyWivsR2jQNAFtGU0
	5VrCOEPzCvhc6CwYYylQujPRDnTwpRRt/e6PutNMN/1yCptNk2YCBJMppkCKEdtxFoHRlQZ
	Nb96sxjhYOWXX9MqJPmjrgYpYL+dfgdwONVdydM08vrV96D016X7je6PX7YoP39X7u0jVxX
	MxSWXWYuH+bpKrFjCSWDW7itkXW8TbZlSasEKaDxXe1DgGD64cV26TH7IViYBDRtbPj4Jto
	sKavLN9hMpvfeW3kRFBvRQUT9DtfuSAheVQswfGQe4muHouygZAS00bbzaqtwL3/nBMVnMy
	FGTkm87LjNyXSE5TFC3AIDt6CzDjCm0Ie+b3YRov9VVVAFxIpwuBHDRS3A1cuGwl/HpjK/J
	i0xYCAC9/NsIDGQ5GylSz+Eoh5EBNhWyq5NjraWOnnaYwgCQqJ/TETgvliV2xtgOGWfPDn5
	/pKBmBYNvaNSEVTdDjSyJZ3py9f0Qkt/60YfwWyYg8hPr5CNBE2qHzDh4NPJz6CkNUKWHgd
	BT36teTv65i5t4XnYa9mn9BTBApQ7IDAtkKuACXlm8ah+krsKWseDNUKybIV929IhOEEB9d
	V9JUmXLKev6U6i4qaZB8JFGmMWKPo8MpCB8fiNLYJVQS1sPiiOGhKtd/j/VMlvD6dTE42i2
	KeAdP27O8SB+6JDhtuD6MqKXHeoP7SYmlkRCBkhfz1z8FK20bTCuwBnzbv94aIEwxKClFDV
	qBzJMgpfwU64Mi6WK2VpEUXpzEItv3LvnMY55HDYw4iudqxFK/vQKbMQ7koDtOt4Vt7cG/G
	0FPvvjiSAYoMBRU4+7SBvzS4A9oT5z/B3166sBkFPfL/eiul+CoX6yzV93sYC0d+ZWVc1cx
	VbYGnMTRYOVLWptE/Ths0KnkQpPes=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


