Return-Path: <linux-wireless+bounces-10018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6C928F5E
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B105F283174
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B714533C;
	Fri,  5 Jul 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgJV9Ktf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF117A955
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219263; cv=none; b=u3FU/pnK/2jBwrJa51egObTFak0qlZHcZzDNff2kbRrCF/6Egvd498k0lUCh+/zkdytTkw6+5vVAxrTicfEd8FLPGfQna1bYitQjvXaUKHYqG5BHRe5YdB3OUk5B6tGPhaBHz0Q11dJH1iXRlkJa2yEhIHxnvYZawJhFuTwJxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219263; c=relaxed/simple;
	bh=4uIcDtI0qRFkVXoiyLypFMqrMf9IBbXglbpcUbgtJqY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LEJjqv2q5819Y/AFDM0JPektcdKzuTqm2bnhTW6Z7s5hnPKaYcMDKweqcqq8UJhF6k6suTsgqwGVvI7gYX+IjcWkmtMWRxPJvS2IzeM72tSlZP8rb1NmMkoEnpX6+ZUqUy1hZ9+dpQ5/ZtY9YUg8LQAS4EBrdpjnIQ14P0YWVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgJV9Ktf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e96d4986bso2297464e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jul 2024 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720219260; x=1720824060; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jicozBdYQHephpWXkatNDdcXQ9ZJxqDKyudI3hBS/ZI=;
        b=ZgJV9Ktf21Vw382eXremENKWkA5rWe8gOPkFzVSG0Np9Pkdac5cBkdOohJpai1VwfU
         TNo953C5ghhu1TX3etJevPgo5PCNRXqDOWDBbKUymPxlVbduo0P6M0dRUhXvyekDO9I9
         9seZhGCL2YzKITwaLtjaIVtmWB1Kvqb35Uk3txAONw0EqeC2F5gqdbI7gA93esASTSmt
         4+D4/sjAuMIyVtpxwGG2Zi2So0kVKKaEBMTn9IWIc3L1LBCy7BzVCNkEAFBs4I89WOpv
         sj7bsEnG3uF9GTtbK29p+pUDzBdOPgDoqFe8oooe4Z/6S2GrCQfTd47+mfrCUeAnsKSV
         kbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720219260; x=1720824060;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jicozBdYQHephpWXkatNDdcXQ9ZJxqDKyudI3hBS/ZI=;
        b=bJM1z+qZk8u9U4HS0t+1Ku7fGkm/d9UXkeeS1V3dRUNkszLKnH0kg+Xe4mSuUaMCd4
         tuBXf3WjxQ1x75RD5Ak4nXpOkFKzTw080PoQ4SlTM8LwZ5gmMoBb7sPupSi4ILlntwMZ
         Y6LHz31knJV9vqRthUk1EDCB/EL0r3C2cCJ0b+MCF1D9apRycRflIRLnZ9GOeUMiMdam
         8MZIyg0E4iPWw+Nu8GKyhuHdQJKn3HMQ99qfA9b0zrgJQFgaGKw4zbALFRb0vvMIsAGz
         t7UZtx0Md2MsGrjVo3k3bqiOymmSSEH5MQ4pKGyDOPYwIXLestAC2JSR1MlEZPMtQnPb
         +6aw==
X-Gm-Message-State: AOJu0Ywnlsw85hOnySLGFCwJmPHVCNmy54G8sBaA+62CZSlG4b15yXvY
	UuyCLv6FTw24urfSh11mf+2xcL7l3gNBwrR3R6wrJ3faHss5iDbhbXlk/g==
X-Google-Smtp-Source: AGHT+IEYGu4x2MQadOuPi5T9T9k8LRsLWSopyp1OTBL97BH8yXpmBWvJEjd+Bja3clqAv3DxHF7WbQ==
X-Received: by 2002:a05:6512:3c8d:b0:52e:a7a6:ed7f with SMTP id 2adb3069b0e04-52ea7a6eea2mr2103489e87.60.1720219259596;
        Fri, 05 Jul 2024 15:40:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7525fb8387sm490231966b.94.2024.07.05.15.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 15:40:59 -0700 (PDT)
Message-ID: <8ccc9e13-0d45-417d-8f88-93a0ad294f77@gmail.com>
Date: Sat, 6 Jul 2024 01:40:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: Set efuse->ext_lna_5g - fix typo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

efuse->ext_lna_2g is set twice and efuse->ext_lna_5g is not set at all.
Set each one once.

Nothing uses these members right now. They will be used by the RTL8821AU
and RTL8812AU drivers.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..9d9d33a4a503 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2005,7 +2005,7 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 	efuse->ext_pa_2g = efuse->pa_type_2g & BIT(4) ? 1 : 0;
 	efuse->ext_lna_2g = efuse->lna_type_2g & BIT(3) ? 1 : 0;
 	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
-	efuse->ext_lna_2g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
+	efuse->ext_lna_5g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
 
 	if (!is_valid_ether_addr(efuse->addr)) {
 		eth_random_addr(efuse->addr);
-- 
2.45.1


