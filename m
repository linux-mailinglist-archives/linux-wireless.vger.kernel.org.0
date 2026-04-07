Return-Path: <linux-wireless+bounces-34480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDhgKpkm1WnB1gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:45:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A03B13BC
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EBCE3024001
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E353CEBAE;
	Tue,  7 Apr 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcQRK2Pt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046A3CE4B5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576724; cv=none; b=md8ZLLF9pjFG8o7oPduwpeoO6QSd7li+eGBA+axFWm5d38Tk4XnNfWrvAZAtMtr8HeG/xA8EZTn+krREIPnrf0cEz423vFFs6vjChS5XBD6lIc7/znJlcYVzHwH4cFllhyPTxlvgJR4FsVx2LXjUV58qtcFrnHRgSaYer7UKgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576724; c=relaxed/simple;
	bh=SuWl3tjZsAfYMRt8x4bSIskei8uiSlKXsRGVBV5mucM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5znmnEPklCZRVx/X1a4+AZnfMyHY0iiSHjr5cMAmQXe2hzmzN0iBms2sDO0z1yST+pbn8ufTvAApUjrWNwqZTSRA5Npv/YLIgWD6+8KbwY+jcq4wD2j6SKlYpZv5DHJyj9rZL71YxXYDYhI8uMDO+Evkt/XOS+zj6wlftuUCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcQRK2Pt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b258576d8cso33031505ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775576712; x=1776181512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdgebIX8WCshNHCphbYwlC8WuuoYhJuJww2bMe0846A=;
        b=bcQRK2PtHV1PtGHf0Fve3dTdRAdmawhl/JP/RqaSCAVHXHQN+Mg57h+qwEvtn5dETE
         IJw4Tn26m+ZdhOJHsWTGb7o9o5Oo4P4PCE2qkqKu/ez7dIzG0DXEYtNT2aAwhdc44qny
         ek/A19AoHRrxw36P55aLNlQzd2rufywCoXCgMoBGjtiMw/X/0FgBva6aWcVdOaalnTvn
         Ei6v3QlqRjrlV7j3woAU5VgjMQbxAq/6wpLbA/HYgKoGlk6dxNew/UHBbzoZKV+QQW51
         PrlGz/LqlBtkjoxHx41tiSSxZGdx8MqTkxKnZsOpVY0vKzSO3KwOSoGwgh9qtgvy4wxK
         eMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576712; x=1776181512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdgebIX8WCshNHCphbYwlC8WuuoYhJuJww2bMe0846A=;
        b=b4YVShAtEoiastEWndi/iG/R+waNEmacv0x1cqRA8B6aYVyMTnWkB5QpizQg2oklgD
         wSfAgSbV9TicOkmn7NhCseYPaApdxCtsw6EFvIiuRSijrIF3r9VAZUKPvKPYz8bh6xHS
         8KbvPrHWzSBBsoq4joaMvBdbpunKpatsNOhNOJTa6+DZcIx0zqqoD4rPrU738agFSork
         lmW+z38YULHHCXUlGQ1RXfK5zHHninE43qqHaeEP60eaI4+mgj/ZRfWY9VYUiGPfwIRo
         KIYKY0ahn1TXOtIoYncCu36CKTh4MxL41qpWwB7WLE4UuHR/M7dm2PbK0msagWsMuxqI
         iBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp8cCEH+3ydcxLodYMCl/YMb6MIWAEtqUBsEpmxg1klMh8sXcPiZDr+jxE03k9AyZFB9PU53kqOiA6klDl7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJv/tgjV4uMq18r4C5YVXvtOYdj7wvrSCS5e2FrQSGf2ja1Ar9
	ejM4/E4qQa2SnPGHUidte6qSbjms8+01tFcEQncJKAAl54oIC0lIV2eY
X-Gm-Gg: AeBDiesJmaO14Vac4AM3PdFbrkexKxWavCWnxMcgod62S3NSoxLsCUR7D7mXscoC9fW
	Zw5KKkzo+cYczcQUbxcGe/LSPWXSNgUlfeEGgXgKG7llVhQKBMxK8MkMYXBHBY1ufuniD7Gv6cy
	gDURPgLr5/SORgDXCtC0Sh73skz+OVf/+Zd8ukIYMEiRR/aXutrM9S4dbitR3cxhEhjk6YZ74L9
	nc1wzHY8FIURXuMj2I129pUjBx7fJJLxhDdmvCq5lUeWRk+MGOJNvrk+Rz1T1yE3ftbWv/PwUGf
	lDxTZpSo5AYonZ98Y7a+tkL35c0vaxl1bB1WjVT6198rj1BH15H871Uw0gne7hNzcoSbo9pPSVo
	/zVnSKfTEwyJztj75RrwSFK+EcMsFKXxRKbwlhYTjTMR/GWhs0kbrVGUAef6tyVwl+cDYenIoJ3
	6Bh08OpH/2AgebYezmzdavMIQ=
X-Received: by 2002:a17:903:1aa8:b0:2b2:42b1:ad9a with SMTP id d9443c01a7336-2b28182be11mr183382875ad.19.1775576712346;
        Tue, 07 Apr 2026 08:45:12 -0700 (PDT)
Received: from BM5220 ([49.215.226.71])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm230992905ad.11.2026.04.07.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:45:11 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH mt76] wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S
Date: Tue,  7 Apr 2026 23:44:30 +0800
Message-ID: <20260407154430.9184-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-34480-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-hardware.org:url]
X-Rspamd-Queue-Id: 4A2A03B13BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ID 056e:400a to the table to support an additional MT7612U
adapter: ELECOM WDC-867SU3S.

Compile tested only.

Cc: stable@vger.kernel.org # 5.10.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
This ID was found from [1] and adding it to the device table should be 
enough to make it work. Hardware probes at [2] can prove its existence.

[1] https://bushowhige.blogspot.com/2019/08/ubuntu-1804-mediatek-usb-wi-fi.html
[2] https://linux-hardware.org/?id=usb:056e-400a
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 01cb3b283..459c4044f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -16,6 +16,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0e8d, 0x7612) },	/* Aukey USBAC1200 - Alfa AWUS036ACM */
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
+	{ USB_DEVICE(0x056e, 0x400a) },	/* ELECOM WDC-867SU3S */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
 	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
 	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
-- 
2.53.0


