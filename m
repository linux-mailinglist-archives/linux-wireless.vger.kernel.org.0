Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB151B22
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfFXTEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 15:04:49 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40000 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfFXTEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 15:04:49 -0400
Received: by mail-ed1-f42.google.com with SMTP id k8so23259092eds.7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hTlxyZfOIT8V5suXoVmF0uxe1pORI6gHXwBgsFNXY2E=;
        b=FReORTY3FicfVsQnO8DT5qVNr/U2qRpeJ29xsNIXs9vxw30saCyYTBP2xUAL7Dj6c9
         45FHDrhrOJjT2m2Zi5pOfm639hK6hj5J2+5nw0KV2r7HVbLtmB9TXqWSXAjvO+npdfQV
         O05M/jkD48ccqCuxijOS60kz5mJeUwaxJfiiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTlxyZfOIT8V5suXoVmF0uxe1pORI6gHXwBgsFNXY2E=;
        b=BaKn5dr94HSqKIsrlWsb6HDZzgdWQeUa7mXYYAY5J72qlnWJaTpIOxY01M2pBoZwEV
         4u7R2m2dH37J1bCHA4+ALGR2K1uXqj2n9FgsdCcRcdmHXecQzhJzkb7td6cDrOjAqykp
         NuPhpMPtgr/BdwPk7TY7A4CankdwLblaRw8PQ2OI27In7yUCJcKII8dihbmAox1iuPl6
         oNTh8yLHkKQeUdHW8sLjSGFfukV5lUsz2IrUL7Vex0MoZ0VTEr48ZaVYXA9di/AZN2e8
         cBEvkEW7k7VZHTmMeRxCOzMLwhdiY7BIe+5XQb85X3GhvE5ywJDCXl8p2rfR+39zYTF4
         8p2w==
X-Gm-Message-State: APjAAAWooUBS3zXd3BVUGy8DjwUB36HuzR+BMSs5A8wAFIfLoStKHnVY
        ayDsYr0MJvGCLcFiOoB963Kq9w==
X-Google-Smtp-Source: APXvYqwXQ7+qzf7+/SYoa326HrTt0mRi8Z5/iK5jAl5AniwSb8cwf/Rg6EYEUZBVOYZfqeHf2xJMbQ==
X-Received: by 2002:a17:906:40c:: with SMTP id d12mr73447883eja.29.1561403087196;
        Mon, 24 Jun 2019 12:04:47 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id e10sm2011846ejx.89.2019.06.24.12.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:04:46 -0700 (PDT)
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
 <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
Date:   Mon, 24 Jun 2019 21:04:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Christian,

Here it is. Hopefully unmangled this time.

Regards,
Arend
---
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ec129864cc9c..7be8064c6dc7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -785,7 +785,8 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev 
*sdiodev)
                       sdiodev->settings->bus.sdio.txglomsz);
         nents += (nents >> 4) + 1;

-       WARN_ON(nents > sdiodev->max_segment_count);
+       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=%u, 
host_max_seg=%u, nents=%u\n",
+                sdiodev->max_segment_count, host->max_segs, nents);

         brcmf_dbg(TRACE, "nents=%d\n", nents);
         err = sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
