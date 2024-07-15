Return-Path: <linux-wireless+bounces-10222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6B9312C8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29277284003
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB29187321;
	Mon, 15 Jul 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQ9UOM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D38186E5B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041509; cv=none; b=JqPsBGjkg0IYPFi9ZOzxroL0M5IUdVQ17BwLQxsnM6678R3kShM8CUcJCv0q79ffVCc23KFImGGsPjKohb0wSlDmtEZN/RbT+Rjv01icW1IILVN3oKX/Elz6rE3B7BC5b7JAlHnRw3FWOh3Mu//0iEF2QzjmHufyXENjKNwgWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041509; c=relaxed/simple;
	bh=BKGCF57ktGcwFavmZdke3GjE0czge/kXI1/7/ewu2ns=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G/Z9icaT5edVAKhY88s2glVfVPdJ515detQ2UJ0dYeObWEuK6pQKxgpkG2GSm/Pap+jJuzMio1EYrLOz02lDBPEETEAlnEb4Bqmv9r7FB3DSS3kNTiz4JMPHd48LuZ1WOi+03cSpmM043qmR4rWT+RA/tLVq1FwE94s6w358Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtQ9UOM0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e7420697so542361766b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721041507; x=1721646307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4f5pbtly4kxRWOwiegDAN7Z5vBr7/pebQsXpWTnPms=;
        b=NtQ9UOM0LzgSs7MfI8hQmS9lfSl3ckyskwzAvs3vYzQVDnJzf4ZNru3Ins6R0j400i
         he8huNYvu477Rtvz08L1OBYnRSmETK5bL4d31c2teUqM+Xc62QU5K8l+Gyc6yixMQJJ1
         qSiAzy4V1C8cSdHpp5DhF2/ANW0BFqYQU1sXHOIv4kNzfEHDDRa/mj49dX+h36HK7Dmz
         mKJiABkn/i+wWC6AxFKkYMc+awV8xqfrzUYTbzER/015SmXPDasDBf2VQ0C73oySEhOa
         ui1JLpQ1h16RstueVmbfFDyTaUDDv9+PDhO0Dr8jqVG2HjrnsVpwGyfrBXJoK8oIoIv0
         SxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721041507; x=1721646307;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4f5pbtly4kxRWOwiegDAN7Z5vBr7/pebQsXpWTnPms=;
        b=gnySuZfgf43jmIsV/njKqHlGSX4G6Y7FJUUw5n8Az4R4NMW6ZxTtYdHXJJvbfeafeF
         ajXDaIqsC/0JCuBhemVNHANBQuCotvq3zp9/aO5s7ipQs9EYu50o34WRSNFhKusGiw2m
         CglpJykk+NRzbrSx3FddZiMZvBHCrxV5U3f2+lFr9GtX4AEbelPTi4GAow+IzGlELuFp
         bN4u0S8Hnlu187nQB/FLA6pdCv4Gi2dzSH5HgsQ0oIsAievpCjQBRiFBs9vSL2Y7ZrQY
         hSgb+78KmBuKfFGmp/hEZTRvoNpJXIPiq+aeSsHxfPjli7rp3D5xy+bZANgR8n7RL4h+
         8x7g==
X-Gm-Message-State: AOJu0YzUQLfzlNgdaHPplfCv6toBbakyxbA333uV7oZE/jZMSRDAhcEp
	hR8hijI7t7TTtYp4an6A2vToY1roZRg/LxU2pUT3tAQCQIzY+FrcFnM7Ow==
X-Google-Smtp-Source: AGHT+IGV7VrrCn75Epul1xx+0ruGrPW5UFThmgwBfPlTagHAUO2RnLBTgrp7FkD0XenZNiuYZt4oDA==
X-Received: by 2002:a17:906:4886:b0:a77:b5e7:ee7b with SMTP id a640c23a62f3a-a780b89cb94mr1006353866b.71.1721041506315;
        Mon, 15 Jul 2024 04:05:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820f2bsm201579966b.206.2024.07.15.04.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 04:05:05 -0700 (PDT)
Message-ID: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
Date: Mon, 15 Jul 2024 14:05:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtw88: The debugfs interface reads registers from the wrong device
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

To reproduce the problem, you need a computer with two wifi
devices supported by rtw88. It's especially easy to notice
the problem if one of the devices is USB and the other is PCI,
because the PCI device will have various values in the
registers 0x300..0x3ff, but the USB device will have all
0xeaeaeaea there.

1. Let's assume the driver for the PCI device is already loaded.
   I have RTL8822CE.

2. Mount debugfs:

   # mount -t debugfs none /sys/kernel/debug

3. Check page 0x300:

   # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
     00000300  f7138000    33330000    ffffb000    00000000
     .....

4. Plug the USB device. I used RTL8811CU.

5. Check page 0x300 again:

   # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
     00000300  eaeaeaea    eaeaeaea    eaeaeaea    eaeaeaea
     .....

6. Bonus: unload rtw88_8821cu and check page 0x300 again to get
   a null pointer dereference:

   # rmmod rtw88_8821cu
   # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3

