Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEA713E4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfGWIXq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 04:23:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52428 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfGWIXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 04:23:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so37584274wms.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2019 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4DF0GGLGa42vxnbCp3MZUMncfGn6JGgj64QxsG3fH8=;
        b=GOlN6jHjUREj2FyKMBUy58kwhTa203TIie0RU9qpMJlxEKuspgfDCrcnGpdLec7PwV
         xtFmN0Q8DEV3K83DFmUrBdgMAFJ3QSzZkjitadmJ3KAZcLbjlMgX4QXlV1yVqxt9SRq5
         nc1pPHJKVuz7hbq1l7E/5jL9GO6QGjf34QlR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4DF0GGLGa42vxnbCp3MZUMncfGn6JGgj64QxsG3fH8=;
        b=USTdpZ89Hy/f8Vj0G69zkrlRU2CK5xB2jFmUFDZh/OZgxR1bbIZxP0gW/kcqD41vvt
         PTmW0C4h9gUpN8qEJVxNi1xe+pp2CRfOR9p2mPelOFs0pFZVyV0z11Xh7l9vmzaq8FE2
         jAxVEOwo8RklvWjjcqUX76loMn+c5sUShiRUYtS4xiqKIoG2uNJ/kgI4ZGwOTIxQRGkp
         pmyHOntl4dxlx9svJCd/dSdK+zRPtpYE7hq5spk+OTe6mMCg93sKyY6VdRDXO1oJMmVY
         Vna1VXnKPSGQ/6qYXM18RakpJGtjhJkKRY+bPF9rE8T5G5fjM0kXC4tweZiK1NzMrN3P
         TGrA==
X-Gm-Message-State: APjAAAWLsyTsQDEENrlM8+dIQb5g9jkqTrgXgimlCNiAb8o6OzYMK3sH
        0ReS5WQeSXSD9c1/f4eSBX9HGw==
X-Google-Smtp-Source: APXvYqwCpfRq4V/Q5ggplYgNbrhlsfpnTVmLuGTYbY9s3GJSjzV+yCw906U7AG6x9oJn6DXgCZ7uhA==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr71234270wme.9.1563870224082;
        Tue, 23 Jul 2019 01:23:44 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h14sm40591763wrs.66.2019.07.23.01.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 01:23:43 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: don't net_ratelimit() CONSOLE messages on
 firmware crash
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190721195217.26838-1-zajec5@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <652dd333-482c-a467-11a6-a9a57b88b05e@broadcom.com>
Date:   Tue, 23 Jul 2019 10:23:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721195217.26838-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 7/21/2019 9:52 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Firmware crash is a pretty rare event and can't happen too frequently as
> it has to be followed by a hardware reinitialization and config reload.
> It should be safe to don't use net_ratelimit() when it happens.
> 
> For reporting & debugging purposes it's important to provide a complete
> log as the last lines are actually the most important. This change
> modifies brcmfmac to print all messages in an unlimited way in that
> specific case. With this change there should be finally a backtrace of
> firmware finally visible after a crash.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
