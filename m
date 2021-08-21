Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D83F3B8E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhHURAI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 13:00:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32311 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhHURAH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 13:00:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629565168; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Nt9pzXKJDUv/DQgPrt7jt7TNjX1oAUMXDG/AkozcObw=;
 b=IqxmeUYpTajsoM80k7hHLa5dIyrJgKgu7hA6Prn/OhnpUYFyhBGIXML1uQNl99JA1u+rYsYO
 h83Gnl8jJ05NGYQIgyrz6AtpK90sL18R9ww/78o1OwTw/T2hBq3+uyjR+JfjLAVGetu8GoiJ
 7qrBwXFAJwji97eRmQeTCMvTXkc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 612130dd0f9b337f11b0dbef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 16:59:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F90DC4338F; Sat, 21 Aug 2021 16:59:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA7FDC4338F;
        Sat, 21 Aug 2021 16:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CA7FDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210802170904.3116223-1-sean.anderson@seco.com>
References: <20210802170904.3116223-1-sean.anderson@seco.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-wireless@vger.kernel.org,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Tejun Heo <tj@kernel.org>, SHA-cyfmac-dev-list@infineon.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        Sean Anderson <sean.anderson@seco.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821165909.3F90DC4338F@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 16:59:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sean Anderson <sean.anderson@seco.com> wrote:

> This puts tasks submitted to the SDIO workqueue at the head of the queue
> and runs them immediately. This gets higher RX throughput with the SDIO
> bus.
> 
> This was originally submitted as [1]. The original author Wright Feng
> reports
> 
> > throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
> >     Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
> >     With    WQ_HIGHPRI TX/RX: 293/321 (mbps)
> 
> I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
>     Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
>     With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)
> 
> [1] https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Arend van Spriel <aspriel@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

41b637bac0b0 brcmfmac: Set SDIO workqueue as WQ_HIGHPRI

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210802170904.3116223-1-sean.anderson@seco.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

