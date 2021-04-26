Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4636BAA9
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhDZUYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 16:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbhDZUX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 16:23:59 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC04C061574;
        Mon, 26 Apr 2021 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pECq693NLfz1M+nZ7gy7VWyiFp04Gu/D/8GHShtkwfw=; b=QMVmYBRm7X7IX2MnfSJzbVoGoq
        RM9xtvzDrFlxMkQ3aN5pd7ZVbbWhb66jovqRuVj0UOZW+hXG+SOwxQzuKOcDy/Pk/pHto22iKAGB5
        qtVleC79W7taE+VT7zau5WRcKzURt7J2L61ATZF3Bbuk8y7aEWPGaZ7Ywanot8Gr2wdvuHO/CbzOA
        ABxdgG4bJSLPxgrKeBBfNj34lJuXJ7ZZ/Dw7LIuonMvQsv1lFLgHMHSyGX4aQK0oBApqxjK9QcEwY
        znW36xVuuwsWT2fwqVEQ181aQHbF/w1owgGYKhG5P6uZbBVVxJu2eMOwLWhHjo1xmI162U/GXGjdY
        uW3DGsTw==;
Received: from [2a01:79c:cebf:7fb0::17] (port=39832)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1lb7lB-0002St-Cq; Mon, 26 Apr 2021 22:23:13 +0200
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
 <6e1052a5506acb0c5ba3b4954f199ee0c494c1c3.camel@sipsolutions.net>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <1bacfbe4-12ac-7ee2-59d1-7490d6cfe0f0@skogtun.org>
Date:   Mon, 26 Apr 2021 22:23:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6e1052a5506acb0c5ba3b4954f199ee0c494c1c3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg [26.04.2021 21:19]:

> Probably hardware (well, driver), cfg80211_destroy_ifaces() calls into
> the driver.
> 
> Which wireless driver are you using? 

ath9k
-- 
Hilsen Harald
