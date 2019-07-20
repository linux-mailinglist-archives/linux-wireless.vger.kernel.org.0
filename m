Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4372D6F0CA
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfGTV0G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 17:26:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46019 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfGTV0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 17:26:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so23985171lfm.12
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2019 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vgsIptlTZKe/9Kf2Zk8CaUR37DHmJPExyaciRidUETc=;
        b=LdzZYXdHcd4rqYHLuSP2oZ5R1TMSK7bCfxWjeNvzbNacZ4yMz6TAIOamjrZYUPW1k/
         ii23PYgPS6BdEPLYYLqvf9IX95HTf1ufCFVHqj4yB6XtfGxUnoTRhzxVL82mkyHBqsQF
         2PCXqhykkIN/F/h2BMd41iS2RkIjIRYi0l5KFy7XgxhTD3Xv0VQtVbrgPjKPOYJrrdVJ
         2wdp4rD/S4rPnyxP7+Ru0ULqWmsuJkbQGPjSUOX8TMAPKbvJ9q+nM1fLQYdLAHfj91hO
         uhK8Qfm1OZdECrA/3dtKB9cckr8yXq6jQ2ziHD6r/8stpsbu9WgkP5METZ+HHgcg7KvB
         wbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vgsIptlTZKe/9Kf2Zk8CaUR37DHmJPExyaciRidUETc=;
        b=WHu/WSH9dFDnc+aAb7YLzbNnh9inG2MeCYl3hSdgN9LbSNH0zstdIurroWRhE6Upy4
         kFB+jt2rkBw+e/mBXim+Dj5NVkEgV80G3EwfupLH8GlpjrfPB2M4LigwytDZnjRadx2G
         6cYMYDZP5pon2KttLDUX32SAD1upcCRKyXJvw0aw95QCpVoSI0Qk8mtaViakubhWFJej
         LqozfddeAhcHzpS3/DXOD6HE1Jf4ie+a+SyokeUxl3P3fRKFRKnACfYXDPEvqc572s3p
         Tey1UaVHBZPzxex0UmM8sx2BZOIZciRaIF774xqEw9cYtdxCSKdYpfJxtuhyGlhfSNlT
         quWw==
X-Gm-Message-State: APjAAAXX17GG9Q7z0TVSBo5kphFh3mgVVEzEGPKET9EV+3VbwqViDO0k
        V0sJqOnDZu9LY0lnSF7GDuE=
X-Google-Smtp-Source: APXvYqxy75apcd5R6wz7ACK2qJagQwg1V6+v99xKpvyqxg6QyWMSI7HehuvC5uiLpXRSCXfGN5KN8A==
X-Received: by 2002:a05:6512:1d2:: with SMTP id f18mr26883912lfp.173.1563657963946;
        Sat, 20 Jul 2019 14:26:03 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w1sm5331997lfe.50.2019.07.20.14.26.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 14:26:02 -0700 (PDT)
Subject: Re: [PATCH 2/7] brcmfmac: change the order of things in
 brcmf_detach()
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
 <1562835912-1404-3-git-send-email-arend.vanspriel@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <92a0a086-e848-6dcd-f1f1-ad8675303077@gmail.com>
Date:   Sat, 20 Jul 2019 23:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1562835912-1404-3-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11.07.2019 11:05, Arend van Spriel wrote:
> When brcmf_detach() from the bus layer upon rmmod we can no longer
> communicate. Hence we will set the bus state to DOWN and cleanup
> the event and protocol layer. The network interfaces need to be
> deleted before brcmf_cfg80211_detach() because the latter does the
> wiphy_unregister() which issues a warning if there are still network
> devices linked to the wiphy instance.
> 
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

This fixes a rmmod crash in brcmf_txfinalize() that I reported in the:
brcmfmac: NULL pointer dereference during brcmf_detach() after firmware crash
<b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com>
https://www.spinics.net/lists/linux-wireless/msg182913.html

Tested-by: Rafał Miłecki <rafal@milecki.pl>
