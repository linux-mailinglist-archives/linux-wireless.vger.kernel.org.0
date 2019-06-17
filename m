Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD147FCB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 12:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFQKfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 06:35:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41397 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfFQKfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 06:35:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so9357174wrm.8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LdLD6/GLnt8m3EwyYjIGs7rafDrtX5c/RGMl/GKKl8o=;
        b=LbaodTzMAL8u12y2crGYXzc5LcEcD4olP+PnKNNkq1Ry/FFWYTKTvPDF4uTM6VXEOO
         Ok3b/58sc2ip+falSZ1Temq/KsMze8wnfJQLOklfCX2iBleXVj0ObJ1h1Mgls5NXnna/
         SQSig9XOK4T0+hyMOxF8Xhmr/+4C1XqzOEM24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdLD6/GLnt8m3EwyYjIGs7rafDrtX5c/RGMl/GKKl8o=;
        b=ht0WrLfrFykuR5PY9Whzvzkk1zJhpAGroMGYp5oNIOMdk3mCFdbsh8KWmLUjljMavv
         qUCC7lRNUz91iQjrLbBt8S0X/Gr9FDI2DZLAh+UiLDLzpS8l1xzI6siuxBjLkRRxVJa6
         xvbjO9oCViabqet+W1znP7BUMQpuxfzRVaoEunSfGrqYgz2jn2TyV4qFyLbif8GXWk8i
         0xv1mspNry5Bkxs2veMuv2nKcvs2jl50Vpu4W3W7smpdp+4MDnrCYSlAccGwMPuIO68q
         TwSw1eu+mE7WCh6pSvE7mVJaOCCvqrr2npm8UmqJMXnlk3PxoOTiRlRX7+ghkPnlYXQ8
         ykmw==
X-Gm-Message-State: APjAAAWasf5TxKdKS1LAwQemFj8KNY43JdH8SA+6tc16gUjyhLymlDUh
        WVEZQS5w+BJnlRjPBOTgrdZ1Xg==
X-Google-Smtp-Source: APXvYqzFFb4lC949Z60IWxorsffQZyTfPYve5pAYlHt07baOm8aNcHW8hBKNaqDa+JDSAIdRNBcnyw==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr75042119wrq.53.1560767752500;
        Mon, 17 Jun 2019 03:35:52 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p140sm3887001wme.31.2019.06.17.03.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 03:35:51 -0700 (PDT)
Subject: Re: [PATCH v4 3/5] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190613234153.59309-1-dianders@chromium.org>
 <20190613234153.59309-4-dianders@chromium.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <be97a37a-d81b-5756-7a97-418d9b36a381@broadcom.com>
Date:   Mon, 17 Jun 2019 12:35:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190613234153.59309-4-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/2019 1:41 AM, Douglas Anderson wrote:
> There are certain cases, notably when transitioning between sleep and
> active state, when Broadcom SDIO WiFi cards will produce errors on the
> SDIO bus.  This is evident from the source code where you can see that
> we try commands in a loop until we either get success or we've tried
> too many times.  The comment in the code reinforces this by saying
> "just one write attempt may fail"
> 
> Unfortunately these failures sometimes end up causing an "-EILSEQ"
> back to the core which triggers a retuning of the SDIO card and that
> blocks all traffic to the card until it's done.
> 
> Let's disable retuning around the commands we expect might fail.
> 
> Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
