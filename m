Return-Path: <linux-wireless+bounces-27269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81CB557D2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3090AC402A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3952D29CA;
	Fri, 12 Sep 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRkAZYZC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846115C0
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709960; cv=none; b=mkV20rXpUV312BfthkJMAegA3UIEknC8Rn5tc+r1QGvdLrd5cPxSzXgHTx9sERlVESAfJDSbdrTcVHRlmKZKnE9G8aFWKUEHOklBg+DqvMx9ou8PRXAjUzBmFBLQyTDaJdkwJGP1BUK23h+rYnhxbR4fh/cDnHOpLkUFGnXZODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709960; c=relaxed/simple;
	bh=pRQDPtc98XZXPyJsfYq1WEyLesiYNBiwIFGSQ2eZrTo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=boiXhqvUST0BLlrKC4vohdXi1BJt6NBtYd+xs2+mDVsWXk3gVg3GgNLrLcyHpXIZ0CbuOs2ryE5jVOCP4syjzQ/Oj3a6/0OPFesz3QUJJ+qkmlPFA9b792/STLr6elk3mosAJlZu1cpmoCfBWBrsweOjZpIJ4gmLZw0Jj3tlbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRkAZYZC; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-745a415bf72so932316a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757709958; x=1758314758; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bZDPRfL8I496CAzITwBcmgDccZDsjO0kPZ35dZpbKU=;
        b=ZRkAZYZC/Go9YHv5iYKS3dGwb2UAoKKjnKbYfRL9uEKVag6jwpKxRYPkWH5CpnhMjv
         TvUW3HasVTCtdvgLPZPGsu+o7yXYKs02iH7hmTBSFUnQ4A48yK7VXI/PpI9OePlF4adQ
         vOcJwMvLicOswhMjrFUPQCjGzyPB9bIXgPGyBVYitUpc6f0MykAKhWrv64hJ+6Ps+V1V
         bvY76grQjD5847esOVFX+yb3W1bS0OIRz67JVRn7UYAIYzphgSdrBQyeXCoKkcHruaSV
         Ef+ymRAArnH0EVGzFvrrZNuk3rz43SjaqP+J27F3wXRZtTZrBrWC1Or5nK5W49BiUH8x
         BhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757709958; x=1758314758;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bZDPRfL8I496CAzITwBcmgDccZDsjO0kPZ35dZpbKU=;
        b=nc5H2QEdWq8/i0cVzGkEi7YNqZ31Di5w3+QB5XUoRrSPaj7bnboODu8rOngKi1fvHq
         Apd4S04qANWNXBfi1StZp0edgjW+Y7IC76Zg6Qmv7N/bcAbb6rufK/yBAW3utP+R6Mu6
         FD72hlvsCLEH8wn3AllOiI/gfeAoHooD9aMiYTdbk0Jmv2W2HiXnAsnQKgJYSOu7feR3
         XsELg3MwWU2qLB7GGpkfVPqg+WnuEdZ81j8grtHP48lHZza/LtImAdTfYG78ZiSBcIEh
         qqykFSd8gpKMvWJYvJdf4PHQhmdnHDDq8vLOPb41ZoeunpLoaunjrKkT1vmar3/cj1CA
         z9dA==
X-Forwarded-Encrypted: i=1; AJvYcCVLbktl59YpLp1s6cqnF9AF9Ew3T+Y3+bqScrIUaIXxe9n5U6uBIFErcFHFAzTiiX8BBEjn87+6EhylrjlnwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUmkp/KRPAx009wFFAejaZH4BxdsAFrREqg/25kqw4kjPEd86
	1M+vh4bG3QlFbMormvvqWzHN6SdzUeU8Eit+vCsoGZ42fj64UdhGFUY=
X-Gm-Gg: ASbGncuGPfjjcJIXaxkICMzCQmoNRFgsDDwEX899whamMTXoj32GHTp/H8jx/tYAYb+
	g3rO95xF8+Efj1vueXhsVcF7JWjEO+k4jdrvxfeyjK06RgHrDVz6Do/9h/4fL8jeYHe53/QC8OW
	kB27YB6nslVkDLgWBqpuG/E9jEzQ8xa6GRZLlZy8YZig8eTo57CtSkiwojKFLiYhwx8OCriiC34
	t3+3HAet9QffYA8cJvI8as/Ok+54lT+XTKXTvVt+K7kANMeGR6bWzYVUz+vma1Ee843fZkW9yYt
	fNaZFw604oBZpgYH6+u2k98emz6BazNZ1jSqjWUr1BKvGxx0qckdTRQsehNN5dxiFcYjgenvFAC
	z/ksAaz/Epx8Y2rDd0XzatmaspxPL+dK5/FN9OmnyrhSbuGi4SqiU60bexjj5VUrO8C2twpwcj+
	4=
X-Google-Smtp-Source: AGHT+IEm1gTbQxjO8LE+RY3w2iaAsCuuqbHiw9gMqHoXCsgjRZ47DUQ8KukdsPyjfgulgrRK1ZU78Q==
X-Received: by 2002:a05:6830:490a:b0:748:8b42:779e with SMTP id 46e09a7af769-75355ac0c4bmr2565621a34.27.1757709957857;
        Fri, 12 Sep 2025 13:45:57 -0700 (PDT)
Received: from ?IPV6:2600:8804:8c40:ef:8da2:cce2:d418:6b9d? ([2600:8804:8c40:ef:8da2:cce2:d418:6b9d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1221296a34.23.2025.09.12.13.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 13:45:57 -0700 (PDT)
Message-ID: <80bacfd6-6073-4ce5-be32-ae9580832337@gmail.com>
Date: Fri, 12 Sep 2025 15:45:56 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Autumn Dececco <autumndececco@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 linux-wireless <linux-wireless@vger.kernel.org>, stable@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>
From: Nick Morrow <morrownr@gmail.com>
Subject: [PATCH wireless-next v2] wifi: mt76: mt7921u: Add VID/PID for Netgear
 A7500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Add VID/PID 0846/9065 for Netgear A7500.

Reported-by: Autumn Dececco <autumndececco@gmail.com>
Tested-by: Autumn Dececco <autumndececco@gmail.com>
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
 - added missing tab in patch

---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index fe9751851ff7..100bdba32ba5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
     /* Netgear, Inc. [A8000,AXE3000] */
     { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
         .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+    /* Netgear, Inc. A7500 */
+    { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),
+        .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
     /* TP-Link TXE50UH */
     { USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
         .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
-- 
2.47.3


