Return-Path: <linux-wireless+bounces-37221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMdQE2DEHGpNSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E139A618480
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E695300360B
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003C3233934;
	Sun, 31 May 2026 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL3bBDHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DF3655DE
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270170; cv=none; b=k7plc9Qtge2nV7usGgCAmV85nZJb9P4PQynTTfzZfDEFxX4LRDwj58mDTf+f0SgcZDFly+kPjPVL76W+k+oOo8SMDSJ+OSLHDABv3ak+80Uh+F8CmgHYa88TWqhKgGNByqAf3VgHey8ekHEBT4/JIdLZJzdzqADx/TBuolOUdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270170; c=relaxed/simple;
	bh=Tv3yUd7zkQg54QXtEpgX2Qj7q2jvTuTPu4zyWGxGPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jov6y9zOui3CWRI1pNbnfEDJRlxjxvI9tfls4OszsjdEPtDHu+fhs7ktNX6CIJKIgczWp8Z9bfdNjq6Mb7haBrYnN+1kTAXFaW5LfdZgHe2B4NPUt/PgcTMz5R/5KEVihqiT6xXjfUyDy64nv50uE1yHk0iQLUldeGhxGEnYjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL3bBDHY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bea7176c72so78493765ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270169; x=1780874969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJp1HpmNECKAQOU+lyEOIpkMRgwogDhaegQj/9sj1fs=;
        b=rL3bBDHYFrYWNaeZr5Cv0YNTFvb/dNNAngxn94h1bqDDULFFpfOrsyj414/PlrffmA
         /YrDvvF9o3UljB0wYYA/D3V9qYVOaBJ41isxv2HvXzou9A/31wOlEmrxU0xK9vH411qs
         Ko/jmanQjm+PfjdwJ0Uw8eZXOfTKaGAA7VzHsODCUB3GN097pFQvBAT/ly9xCRRNUG6K
         CuZUx3kklJMtgDxljt5NUcHMVDojQcknLxdoTGb/0FLwjMnjBPw+T3T//zykZdkrNaaA
         xmPUn4Qhmszt4nbenXjzBV/9ASnBndgw7uOit27kIVosSQ+N7XseAdlmiNR8r4W8DwTi
         3KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270169; x=1780874969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJp1HpmNECKAQOU+lyEOIpkMRgwogDhaegQj/9sj1fs=;
        b=Ebf6BLjIZ+tRQl7SqpytziE3ch09KrI5SRjVpxlkcmx8irKV2OTzGWSQZmLaWszAhV
         0SKWcLl83qnoWNTxgPoRFrjHVk7uSA9Pzbk2zTNRAtLWXlPBC6azddEsAG2DqojB1M0+
         X6kW1FbFtqqpiggWYiaqEEOM8PmY3p3ENUZNyfK9qx9/CjJmOW5CEUwWPZxucNuCE+2g
         S8Dz2frZQG7U+MlXj1czsMYA0dpjoyPOx4IGUL4+5scNVNSA5a3ILXufU3637i8EEg2/
         f+F8elEuGgYF90dRkaI+xI5r4RmebmcrX8DOd95WQTaCYEqOpDKcEcEYh4ku8pwnL/cQ
         hMkQ==
X-Gm-Message-State: AOJu0YxxgxTCVr5q8sDV+2Z+9IkR9O9nbi4bqpz/20Ljop/VAvv7haC5
	CKbaW48a/5C/uU8kDVuPJ+u86JLLsl+qJoez1leonYlfNex5mk7222SYv3XZYH61
X-Gm-Gg: Acq92OHBuwVEZfcf999eHiZxZN/pI8yYeqVHaNjAD1mlxf0DJLhUXFTVTJZNMO0qcoI
	ODSHv8y2X9KPe29HnjBzsS7p8yamGSO60qU32w1iG2puXbkJoWlYiUZKqd5xb+MJgebQL/5kA1D
	T0LfhOLtJ6cCT4N8xBGq+etXeBp4kzrDZXqerMqK5K26thWsOiQbk6wogs2HgvOOR5TxCMb/kbz
	8KCv0PwuJ+SEcKzOzsfWzTnjT3j2ZJwuCXdfY+ahSs68q3nsuD46ftzRTTRKS1LrGtGpGTe+ct+
	lfNNLgMd7r6der5Pj5VcZ/+x4crNcfRXl3SWefbugBfvGKSVhMV+hULEs38arUGrEc0AHcdTDCJ
	YC7nBetzOcaqSRRkdKWS2QKMOmW10Ol6EarfFwydvHQ7/Xua9j1dh1B5GmjHzlOdzvEbTHVaS3E
	k2WFajHsje0EIepH7KcuavMEfARJy4s3aBg3eZhfZVs3tYfzn6su7HTvVs1UYQdfAOPy8=
X-Received: by 2002:a17:903:1905:b0:2bd:d7c5:9272 with SMTP id d9443c01a7336-2bf3679f5c3mr100058975ad.6.1780270168967;
        Sun, 31 May 2026 16:29:28 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm7954473a12.26.2026.05.31.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:28 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next v2 5/5] wifi: rtw89: 8912au: Add support for Mercusys MA37BEH
Date: Mon,  1 Jun 2026 07:29:14 +0800
Message-ID: <20260531232914.4406-5-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531232914.4406-1-zenmchen@gmail.com>
References: <20260531232914.4406-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-37221-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E139A618480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 2c4e:0125 into the device table to support Mercusys MA37BEH,
a new 8912au-based adapter.

Compile tested only.

Link: https://github.com/morrownr/rtw89/commit/73cd715afee2dda3f670cdae5e40fbeba7d9be36
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Add missing "Link: "
---
 drivers/net/wireless/realtek/rtw89/rtw8922au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922au.c b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
index 347bde171..8d22bb387 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
@@ -56,6 +56,8 @@ static const struct usb_device_id rtw_8922au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0125, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010a, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0100, 0xff, 0xff, 0xff),
-- 
2.53.0


