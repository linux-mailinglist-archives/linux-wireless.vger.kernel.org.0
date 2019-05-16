Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D1204CD
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPLgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 07:36:03 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45460 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 07:36:03 -0400
Received: by mail-ed1-f46.google.com with SMTP id g57so4726359edc.12
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ABrVTP7tfNstYHlzKLELFT1T8Cqmuc4h4Q2Nb4CnxtE=;
        b=FDW8pGuKbCJJXcInHZJE+oeQT+pWHvG4Hj4HJOqDn/Q+Vy8vgejYeOgUa3lrSaYnXj
         GWG8vwvOGx5sQg9HlZ6s+GSuqYVTrdIu/lnHo8+HnI16QEr90Wp7CPMnxH9mAttE5V+o
         IxWIVzXU60xczTnQGkUNHKxnq8JbUiDALc6oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ABrVTP7tfNstYHlzKLELFT1T8Cqmuc4h4Q2Nb4CnxtE=;
        b=MndhX2byjiuKtxJlutPtJ4FHn34PIhC8oEBe8Xkpe1icDMoDuO26bIzHCZDQkHjJan
         2TIzR8n3T1hIvIxCFxEu+ItHDDdVgtqwzF6b4aR69Gdm4agwFJGO1dvBwGB++8e+LlrR
         skRuzCWhh2wRf9kRTpQ+XCk7HtRsAlCgfErNx/d+Y5MHiiy/McJWqv8GG6j8M2CSI4o+
         GZrNaTKZIB2cE/AUC15SqZwyItC0OS0nJL1knP21Ehkro2x2WYmnRtImiGmDawNwjgHF
         qVpunHy375ur5aTL3anFtuBcyKdGpPTbMvVUaJI4XbGdEmoUzI7FxqutqNDWD8EFSD1i
         kk7w==
X-Gm-Message-State: APjAAAUttVPFTjKD49fwWuzo+WrvSRHh4zVbYDQiqpcJ0aQ4yoXy4Vpt
        Nw4+TyGktgTwAc8LXKD7gdDJVw==
X-Google-Smtp-Source: APXvYqzY8ZkwhHTuVhimaYiXS2Aj/XQSkH+JNlE7KZ6PuHoVOzLaNjhlAwgu/jUUwMgoFOavmfYV7A==
X-Received: by 2002:a50:ca45:: with SMTP id e5mr13596691edi.1.1558006561564;
        Thu, 16 May 2019 04:36:01 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id w54sm1836109edw.40.2019.05.16.04.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 04:36:01 -0700 (PDT)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: SPDX identifier
Message-ID: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
Date:   Thu, 16 May 2019 13:35:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle, Thomas,

I added SPDX tags in brcm80211 driver sources. Although it is a 
no-brainer I decided to run checkpatch for the changes and quirky stuff 
started to happen. For all files I added:

// SPDX-License-Identifier

but checkpatch started complaining I should use /* ... */ instead of //.

WARNING: Improper SPDX comment style for 
'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h', please 
use '/*' instead
#29: FILE: drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h:1:
+// SPDX-License-Identifier: ISC

So I edited all patches and ran again. And again it started complaining.

WARNING: Improper SPDX comment style for 
'drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c', please use 
'//' instead

So now I am in a bonkers state. It seems for header files we want /* */ 
and for c files we want //. For real?

This is on wireless-drivers-next so maybe it is already fixed, but I 
think this should be fixed.

Regards,
Arend
