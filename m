Return-Path: <linux-wireless+bounces-14402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28989ACBFB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB351F223FB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F353368;
	Wed, 23 Oct 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZgjpon4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36291BB6BA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692795; cv=none; b=LhWVUv910ecD4kCWO18RK5LY9H5AtYSVICGTIryg7qcsjJg7RZysNDgBEOVFreIcILjZjhdMbg/nDEb86HrUxCol/18tyf0AUTtZ3wii5T8OGbHrEsvV3dcgrrPms3esqsYIQYMbtJAzYrVYdfPu2BJrNukjanonD2r5SQj79L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692795; c=relaxed/simple;
	bh=0+tX+jNr01AShchf1lFMQGLgeAwApIzX6qy/TgHX6iE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEWGn3RHG8uKasJKI9dyn6beH66H5o24hu5zxfAZkD/2lUzlZZ+lew5d27FfzmLS3EaozDNYe/PDk5MBOOYa6sXeYH4NGVfqL1Dv8wRdY+al8G285HCA8/o7jOtaJKWtDL3VfZ70YxO48m5AOTZphVuiONFEkkN7KVssfL2hftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZgjpon4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so8862470a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692792; x=1730297592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32mIsbqT2SA//XutzC/pQOv2ACcg2b4dB/lHG4jCB0I=;
        b=BZgjpon41i4tYDeGNN7j537wxkxNB+YSGY7UG7rSSsEh0yxf3dpeyBn9Nx+khV5kY6
         fE6wVCs1pWHFokG2qc9+4Kq2dIvpX4KdIFa78MGkY+P7VCepWtY260QlndtBpHN7I+ah
         DfBBkIqH7wFuqAm72dql3lzGpBg3Iqx+Trc2g/i4rUwDhHBw+hrK8nIEVv2EOngWIkwY
         JAPm3zscPCAhLjps9++gh5VhK6DHuONk8KdaK2ZgbUym88S9vNc5nmfYTyaU1BjLFnUl
         mdkBaRHdK+bHJK/s/L6NNVRsFut3XSCs2shMBwxxLPocEiItgJ8cFXazNl73PlLoTqpr
         cbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692792; x=1730297592;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32mIsbqT2SA//XutzC/pQOv2ACcg2b4dB/lHG4jCB0I=;
        b=dHYv857V2ivui7gr2jNMlH8MAH+fnsNec9gaVchBD50FUHEbZrskxebBcwAmU/zRzp
         WrZODInDu9VYIRmw9AJKheFu4Nh2efLZyCm0yj7nWvU1ik3e/SsRNQooaNBVgkeDzEn9
         JkD9dluRnsV5uqd6ZxVH+R2Ob8gKzd9pfjBsHAMRfRDnN+Ci3NruM/qwpDQWXriBJsX/
         tNhK5VSBMuSthwhGQOMeURpkH1izb7QQPJb3bCONDtMDyx+fg8ERP14HMRScyOQx+rSu
         KkFPFZGGnOitE7Jb8i9ZlyqS1ie3B4WGoCDNxjD/FNruKfo4nj5k8OtJ+cm0XzA3YNED
         T8lg==
X-Gm-Message-State: AOJu0YyChkhXgfuiCn5l9JizIr0Ub+tnsbBuvtz/LZW53t78jGeza+kR
	vBiKRILWU4WNok9IZ0wS3+WsIG76E+RQfkCmMvVsInrr+IoxCju8AtOKCQ==
X-Google-Smtp-Source: AGHT+IGf9zVhW0OdOF51k6esK4ZlDruP1p+JSiZ7S7qbZ48CKWJXHyZiy920bzdb5mqEOB2XvE3sqg==
X-Received: by 2002:a17:906:c14e:b0:a99:f977:70c2 with SMTP id a640c23a62f3a-a9abf96e7d1mr271166466b.48.1729692791893;
        Wed, 23 Oct 2024 07:13:11 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6383sm482808966b.6.2024.10.23.07.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:13:11 -0700 (PDT)
Message-ID: <e443f5d9-4b53-4f64-985c-64313ec80bef@gmail.com>
Date: Wed, 23 Oct 2024 17:13:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 11/22] wifi: rtw88: usb: Set pkt_info.ls for the reserved
 page
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"ls" meaning "last segment". Without this RTL8812AU can't upload the
reserved page in USB 2 mode. (Somehow it's fine in USB 3 mode.)

Also tested with RTL8822CU, RTL8812BU, RTL8811CU, RTL8723DU, RTL8811AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.

v3:
 - Mention the tested chips.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a3d2b40ec67b..6fa3c37205f5 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -478,6 +478,7 @@ static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 	pkt_info.tx_pkt_size = size;
 	pkt_info.qsel = TX_DESC_QSEL_BEACON;
 	pkt_info.offset = chip->tx_pkt_desc_sz;
+	pkt_info.ls = true;
 
 	return rtw_usb_write_data(rtwdev, &pkt_info, buf);
 }
-- 
2.46.0


