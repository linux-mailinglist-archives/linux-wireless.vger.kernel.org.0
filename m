Return-Path: <linux-wireless+bounces-16527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05239F611D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16415169949
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BC1922F9;
	Wed, 18 Dec 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BQ4v/j/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEC158208;
	Wed, 18 Dec 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513134; cv=none; b=df7UICZsumPFeZv+8IIXRbCypIeHJav4JO4x1mbFb1vCb8dJKOO2G7Ul+Su7yRR4R7yUW/0qgP9Yy/iuWqqp53x/Ueiv2znBlhOKOFCCAoGttJNc3hp2ozczZkCb0jKvNv/o89VJrS+fH8K2CJgZqHifxczKqKJnA08Qk795kL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513134; c=relaxed/simple;
	bh=m1nH9k1mfGAKPFfwMW45ncE2Y8cDxmK05/T/+o2NdFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHftCTBrVq74uFeeWHeG1Fu/jezL5chIVi1ajDwK9inwR304Wm0GZELULiOoSuegsh3sUDVYaSDUYs3McDfM2jEuLv+++QMkT5y+/OJuKcXLE4d0Bl/5fiE6K2LmlzsgEbuSvKD1zsazat707Dipm2NCgMbtdPZSEAi7ZRgZLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BQ4v/j/u; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1734512974;
	bh=oSmadU8r0m/jAstE7lBKy2o54FyM5MvoTj7czqiYO4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BQ4v/j/uUMScDCAzrIEmC+8R+DfMkcHVHNwkJCPULPijoB2qO4PLHMmHMAHl6mnLn
	 by8LwSerGGRp658O36mVTSR3OBPDlSANJD1nASyh6uFcNWKyy0781ziXrqX4KW1TH2
	 a1DZE12H3O2sWI2T3GbLwTzdyMevzUtWXEG8JKx4=
X-QQ-mid: bizesmtpip4t1734512924ta12gj3
X-QQ-Originating-IP: dKoav+z8nrulxgB/v6xyTXVff+GrvYyc2HS0hpJYez8=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Dec 2024 17:08:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8655085733377736607
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
Subject: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Wed, 18 Dec 2024 17:08:33 +0800
Message-ID: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MbBTNOOgGymjBp86sgvxqBOtFIOA/TcHsfMJNuMKI3EXNtS7QBezWtI0
	hg/RKrNMPHsOs9Oh1aU4BaE6d+xXrVWlRY8wkODdcala0D/xW0o6pJ3DcS9mtsdSw/AyZpk
	cCumhSyTBHSB9ZQizW7III//YFYeFoXKDwit3jRvjZw4BP7PjE/Si+TNCxUPqzsL8bqXvVm
	Tjm0bwGlnr+fa+/Wm0tnS8mQHEK48M43rgjY58EXwI61HjM6G2mh0332nSUFQo1u5cdNOvk
	lPytHW9YTTPFuviSg64wzBWUeYm2HrqihMQQ+jwcydPN7FcETniPwVw0i26jGgP6AXJyivt
	4IUbZYQbXHAAmKZq3qKcV9QUIA271BdtSSFCMZGljKpxCIi56GxrGv4nUHKRCxOqo1yVvTX
	I5ZO/vVqkKt2d4goGDHrixYpXG4HPrW6Eula9SgNYy7/2JEt7i2WATzts2l+gTxtSpDll2Y
	8dRSfuclbzoCYKzKZPcstMs+vSYAI5XJm5P8NQOQf1gy0MCxfSFJI124TgYHeDu8MLib+PE
	yOC6zTCZFhx4RSvCE4tOmxZ8OVB2M/Ose9HJQit9sxi5PdEoXlVbC5YyWqdEFMDRpvvU6Iz
	ulLxxlBjyAqJtXZ/svAmGUDtEpTnLD88hNinfR+VlgvqJb4dIcpGw9mjPKz7fBoi591Y06q
	Rr1nwc1qi+wyeBv0Dx7tvRkp0pXiqWIq4wNdA5Dp5B8cDTNa0S9UPOBV86Ac8ri1LYNNUOo
	GPDYfjQbgVYs61313HO7E/09Q9q8z6vZOenCAGuSuiwCltTHoG3T6Aa0okG2wwTFG+JBKf/
	kXIdvotqu2a79LWVyG02GDiepHHUBBvHQBvVH9ceDPs1Om4pd9vXS3OodSHc59yOIGbqOlN
	YrA2PFenbmI69rjfpRYlgbD+FV3McGATEmTZ0G2OYWY24N/QFz2UoEFlzPoksu7ANXfT2aI
	roobMCPJ5BF+fZBlpV1EdTgybT51W/1AQb8qbN1lxt7uByg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

When initializing the network card, unplugging the device will
trigger an -EPROTO error, resulting in a flood of error messages
being printed frantically.

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


