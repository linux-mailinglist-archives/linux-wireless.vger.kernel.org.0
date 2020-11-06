Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0ED2A9815
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKFPKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 10:10:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43130 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKFPKh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 10:10:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id c27so1296310qko.10
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 07:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PD7QQRv+MIfve+JLTyRulZvQFoTHtxEldwj7POOmMgs=;
        b=PU8cvZwZlP6H39TvIdAkFLu3slUWGpDFthm0wRk2eYFtjQ+vu/Vq5zMh/x8ewuMof/
         yJeAFvcIjb7C+nGgsiQGHJc0rIRD4LgIcLe4Q6bDi28WyjHIbRafvieOGtddYjoJeBXP
         GjQF8yZgjEP6vK3Dph/CQiBhhiGOmMpzCYcscHPnWwa7XvMWzhaO9B7H4DTnIi3MHx/E
         3B/9TCqE8hB01C1HqlbqlT4RYNgiqAdsOcdYnQ6o/X3Z4ga+mVTtH4s1c/JwlUU8pnvh
         /0FkeMwj0P7rRTsI/AW0aCWLPsQgV4zkfJ5BYfI0RiRiqHQ4/ubT335gj5QIkVtR1PEp
         mdTQ==
X-Gm-Message-State: AOAM530TL0PuzBIsZ3J8dlH4LVWjLj4p8jdrtJcwnni3BOTnkJGGY3FE
        uqh38fVkPuX0PNhleENcn1bStSyx2XuXu1kf
X-Google-Smtp-Source: ABdhPJzc5clA3GvckM/GbhKOMdm13E1fsB5UAjFnANpe8KDkmaIry5vMNMVoMHctKPFbWlK1YVP66g==
X-Received: by 2002:a37:7e43:: with SMTP id z64mr2027820qkc.184.1604675436236;
        Fri, 06 Nov 2020 07:10:36 -0800 (PST)
Received: from ?IPv6:2600:1700:1850:1780:6d4e:4120:8f66:6d6? ([2600:1700:1850:1780:6d4e:4120:8f66:6d6])
        by smtp.gmail.com with ESMTPSA id 21sm66020qkv.78.2020.11.06.07.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 07:10:35 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
From:   Brian O'Keefe <bokeefe@alum.wpi.edu>
Subject: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO
 device-ids
Message-ID: <b9e1523f-2ba7-fb82-646a-37f095b4440e@alum.wpi.edu>
Date:   Fri, 6 Nov 2020 10:10:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
the wild. This hardware exists on at least some Acer SW1-011 tablets.

Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c 
b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 5b1392deb0a7..7256d55fcc1b 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
  	{ SDIO_DEVICE(0x024c, 0x0525), },
  	{ SDIO_DEVICE(0x024c, 0x0623), },
  	{ SDIO_DEVICE(0x024c, 0x0626), },
+	{ SDIO_DEVICE(0x024c, 0x0627), },
  	{ SDIO_DEVICE(0x024c, 0xb723), },
  	{ /* end: all zeroes */				},
  };
-- 
2.25.1

