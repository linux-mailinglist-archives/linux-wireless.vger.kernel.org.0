Return-Path: <linux-wireless+bounces-17386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C1A0AF95
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1614E1881F1D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7E1C07FE;
	Mon, 13 Jan 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="h9oYIPNr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647713AD0;
	Mon, 13 Jan 2025 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736751824; cv=none; b=FPPgo+qjzmIQwWRmZwTYxP4glHfbNHYb+N6xwW5FDaOJTdkFujXK2km3D1EczK7ak6dyPAqOiyTUqLWZxzMWm9ZGfbOvuIzNRkG6us2OSFA6TfB+BlxoUqv4MwzmiPBXG5Jm2X2vkR+UZasaUbGNmbM+O2BNGZ0bzDQGTrmfIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736751824; c=relaxed/simple;
	bh=vpUAIzxZENNDv58atj4xHgNfohrgiFakzpLmpvVC2AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eb7raI42QPtlbBnqCsY73aIQlJfDP8p5UW9Etf9nZcIc/1wRR0kBzcuC1aqJ+krR+T+LxdhZbawwn6HLzGouAakybSIsRh3sR3wTJAw0CXsqzGm7azGECf3rKJ6WngzAWbE3Izuj3kWNZx20LoR5vbTEGjasJsFWmmeiTWbbs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h9oYIPNr; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1736751781;
	bh=NqfFf4fv96alvmAhC70OVRBAMo6UG+0b5So5mFEFih0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h9oYIPNr8VTOIaZg0lQ6jY/J0s5u2uloGOtLNe2Sks6gJPYa/yZwP5ELxhx4/VffW
	 t8uq+T8+DiERceRd0ZEL7mxe5VUk9Oa/gAHVzyLKAKFYecADuuhO99lPCAT5amG6L3
	 S6zLVw8XpTRNjZ33jX5tZE1lSz8W6lm/4qtSCVOE=
X-QQ-mid: bizesmtpip3t1736751767tk1inzv
X-QQ-Originating-IP: LJtxmZbB0DRaJHg91pmdGdfDROe6I8rMwyDT1D/Zhos=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jan 2025 15:02:44 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12665532747322616285
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
	chenlinxuan@uniontech.com,
	zhanjun@uniontech.com,
	cug_yangyuancong@hotmail.com,
	lorenzo.bianconi@redhat.com,
	kvalo@codeaurora.org,
	aleksander.lobakin@intel.com,
	michal.pecio@gmail.com,
	dzm91@hust.edu.cn,
	jiefeng_li@hust.edu.cn,
	wangyuli@uniontech.com
Subject: [PATCH v3] wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Mon, 13 Jan 2025 15:02:41 +0800
Message-ID: <9DD7DE7AAB497CB7+20250113070241.63590-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.1
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
X-QQ-XMAILINFO: MkkqBHH+kTJApwBfI5ai0tNbU/b+Bo4APgoiwSBXiUcXzTESdO8YSkPA
	tHKYM1fzrLZJ/N64UdfTtbNk/hmICamhrOrNE/CeuMB3/ItB7pPKvq5MGXWFTqZy06xlN9Z
	jb45Gry4ejYodSNCJOR6rhgeuaCZVtRlQNJJ0pz/bDW7GaYqMBESUbkbJt/kdhGpxlEqD8D
	c4SqvkFsTOnXHESpCH8yl6YLSdR4pIxWT+qgEOsLzH4KfzvyoCVpcfk1tSNCEOTu7b7nNbv
	tkVvb0FkvCaEljuLXwFtjH4cHRHFlCtdaRJB33LRq+7+kqkIKAlQlvD+kG/usNbV5AS3Axy
	k+810IBRZJ4bJabZUVih4ooXpxV9fP1MYlGpYkHdFudTgLLJTv0mKAkKnG0uCDzj4MyS9Xw
	Ipd/B26ZTLKqAROA1IE4eiRaY4h4JZBmZ00fWxuE370WWnIHFzSsQ1In6wQpNUuiZDvjSBg
	oIy2/m2RzArg3ZeY7UaI8o5QSlhyIiIv4Elz9Xxje5CnRLnZDCjLionoAi/1AlE+qDT61ly
	W4yABzQ/WDBr2cXgUS2OOXe1kzu/nOrTLXVbXDIKXxjg2M/CFaln9fxen2gYi5hVSddAWhk
	ezIUiAQNQpmeBr/VL8c0fwUmGdUXtlfx8VyvQBjvF/MEr/58eulYKTbK6Z4UoXm3hlCPH6d
	7Eq9Uz8lo7yeb72koKKvn2gPf3i1tOA2u7zxd0jWtUq9GA5DoExMaETpCW/I10oRCsyeQ43
	Ogp2jrJ0HINFQke8A5M7oMfC2dRnTkki1j8VtsPIm3KcR4MbUw0PmMt6aqVQ7nZVWEcJIOw
	99KWyfgnQsgzD4lIDMR+MTRskVwNtGrjL+P3H+ltm5cPsSg/FSh3P5VymrSJHVbXUgFj5ez
	cUQ4308s0/RNcKA0uL9LgWKjhVRdj0UWpyexzWPmNlMhZxbn+jCfA/VUCkbSNs0UZe84/9t
	ro4PsJ2fjaCmHEysiA75t97psg5wQy93Kb1N+Yvmi2Zhif2IQuWT/b5Hh0jHhX3PSNfeXrr
	0qgZTBdDytKJw6BJe7
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
and -ENODEV the same way.

Similar to commit 9b0f100c1970 ("mt76: usb: process URBs with status
EPROTO properly") do no schedule rx_worker for urb marked with status
set  -EPROTO. I also reproduced this situation when plugging and
unplugging the device, and this patch is effective.

Just do not vendor request again for urb marked with status set -EPROTO.

Link: https://lore.kernel.org/all/531681bd-30f5-4a70-a156-bf8754b8e072@intel.com/
Link: https://lore.kernel.org/all/D4B9CC1FFC0CBAC3+20250105040607.154706-1-wangyuli@uniontech.com/
Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Co-developed-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changlog:
 *v1 -> v2: Modify the commit title and message to provide a more
comprehensive description of the changes made. Additionally, append
a "Fixes" tag to accurately categorize the commit as a bug fix.
  v2 -> v3: Add the changelog and fix a typo in the commit message.
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
2.47.1


