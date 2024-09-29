Return-Path: <linux-wireless+bounces-13280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91398934E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 08:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2D1C20A01
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2329CE6;
	Sun, 29 Sep 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p/+p2Vx4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84743172;
	Sun, 29 Sep 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727591836; cv=none; b=H+r9HrK13zwXpDh4RUv5/k5BpdfTKCWPVKXYYp+w4b49brAgK8cVcRaDJAM6tHm9DfS+aWnPe4tx5ujVf/44MBSKMK4JFBRvJ/EuLb883H0JQ+1Lpg168ABjjVIvmoQc3MlIcwl7w5K06iag0u0oVP+nWQBVEpLgHLLyM+YE+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727591836; c=relaxed/simple;
	bh=4axLk3F3w0ykKUkmu2YQGXDfaHagaySoaKyMLvysj2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/IfaCqa/A3KM1XvQ8hH0od9M1HCxtjCcpf4n24ZOxga43VfjRc9aZYVa21x921ftdTuJdRK4NJgyL0fqkMCwq15zR9pPVum0/KvXQ7yl4g+6Tj6/EjsLzboCPTOgjnrPhdUclOGXCZ/JdHWct05g1B/Y8upBbe1ojTL06jeoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p/+p2Vx4; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727591822;
	bh=rGntS9xOFiEeM/CMGDTBCcX5N9b7TzQhEkYEMSmKp44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p/+p2Vx404CYWe2z/PdGRr/K1iCHY8km40hECyjVh0i1n0rbZw9RIhXWo1q7BmpYf
	 90grUOuFbkY7KPHMJGw+KygXO7bB5KGZ3Y8Jd/Z1mvjBgb8U/JJDsnPSBLdXW1LA7U
	 WQn+ymsh79CPfeeEygfoopykUD3HYn7wQdEuwuhk=
X-QQ-mid: bizesmtp86t1727591785to4qeecn
X-QQ-Originating-IP: 4QAUQmEcbPL5ZW/e8HH0uHALE+ArVLh7GTVKQP+BLfI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 14:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7147250867363797320
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
Subject: [PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
Date: Sun, 29 Sep 2024 14:36:19 +0800
Message-ID: <B74B0BCDDB8EFA12+20240929063619.925099-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQ1SesBsQjVtzi1gNi4QUxCQjGq153ESe7+NAopDGzh0e1f/QeZqS/st
	aA2kdaidwEU/pHiRchlYus4dEcDkKdvAptfMOjsdk9DmVUaiBkc6pxRPWeExnixVgl7KraH
	qy6RJlmZbvguCL+0cfoHlN8guLRbHfCnJ2Am/8Hhy6S0XMm0htd2Al1gcFcu7wH7bJ6ZJP3
	EikQ1XK0FPm+bVKJGp/prOOp8Uuqq0LirXIvw/m/01UA1sSfdY9VlXS/RFIJ7YjGtH211pZ
	AO59jGXsoyeUE6FNFnB8YI0yXZT4mN+WMiLMMaaw1tUk46G5BA7I0n0jIFlOY2Gjn+az5SJ
	bmOCqneUEaVmKNL4+2qXMencJ5Uz49nkrPWWeES4Wrdj03RFSiYI0Ogi3OfPf0qLal6B3HP
	9ZV/RKecRq06DcRTVAvhVQVX4lAeoFDsugkReIE0BCDQZxzWbKLRdmffTz3EutyUJa4os4f
	RUYq0LlchfS979RPQ12qhOF10YhgYyuMEduvYX/SSZtYul4fVWHfKBEiz2aM978Gly5gS9f
	tn6ceDipbygWsCl3YWPDQPnmjXXoGe0tYzuj19mxo9v3F0OWn5bOzhfI8isPn3G9izNH5B+
	VojMyRdGgK1f85+imCpWgWYvunRll0hPZxjptP5TkIUiW1/AUORLpxvg5gE8JXoWhu8B1+k
	T2fGVhAKLnD9S2PCrTwdNvgcViVH6zEDQC75n1rI9ZYPVOLluUizvg3XMIAtFOp2DepCR7E
	Eq9aKMfrPdjNk5lWqZtdVh/fbeYLxwBRDFpjD2fEMcQbiDjY563LXpLfjy77BjmS8cHQO+H
	/0smVAEXNSxLzOtdWV9/LCPqLEKVHFjUdzz79FD/JFyWHigrKySf6/Z0E5p/2Eybcbl1w+I
	Wd31QybG4hK9Q10J8FTPxaiBotX5nbML9ggvl3fz+/duIR/cugy/SlUzngNDvTUVpdUIRM6
	dFOFJolC6uU27Olm10T9ojqC5NaEYVqJPv/BNf1/FqrEVM6KuK+lAW7UWa/1zCkaAr18ENt
	HRtndWWBolUT6DTYpA
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


