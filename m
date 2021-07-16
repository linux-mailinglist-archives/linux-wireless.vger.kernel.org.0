Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21313CBAA3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGPQnR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQnR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 12:43:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67422C06175F
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 09:40:21 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10484480otl.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHD3bsfusj2mr0aNIndDSdET2tgorIMEstvbAyiTb1w=;
        b=Mugo6aW7ZRNSmNjQoePTIQ31m1KyvbyLiz4eD4K+Kr3xAN3btUF++tTMi1IQ9GIYNW
         ZZ1QIzz6nq+PqqVBrdETGqSCP3dVvV0ZszqKWl39e/fXNlgvT1XiaskLpqXxMwH1+9rJ
         XOAj1GoAnV9KizObdJJJYNwe8iw3WumufVCqRO1V/uFoKKzBxB4ZhgkQRdlK1wtMuWvN
         qoAArJTGA3FqjTG5HRK8TVOQ6KUSGJdagAfsCk39uwTBVJQGrxeFBRFo5plXJTCGpca+
         vvKNFC1E5rA2OmiN2AjJYVoIS2eGZ3mp23GcS569huncbEJodEl9ppXjTdLSzJTGPHZ2
         nTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHD3bsfusj2mr0aNIndDSdET2tgorIMEstvbAyiTb1w=;
        b=E5sq/udS7b/xmsOYGggpVHypV+bF10H7LldyynZj41kOCRvsjWv3TQ51de07n+oglp
         QltRbXwZLvd9iivXCcLYyVcj569mQ2FtFE9Yz/I/APnUyRUwUastlyDsW43r4ZtxgE15
         pw+3g4ljHgOr99ByY+tXcf1icWUx5PlEcJ1tzPZrBqgNRIDYMqot6xIEbeQc+1OMBobr
         MttflFu7mqooAORSkNJj7u8N3N9O/j1qgymsTfE5hKAlxDDKxHWkljVqOY5EHpijBCgT
         xdZ0a1JY6aUZNIeph3dPIl0lQPqbB/tbwz4tSywXOgHBZsRDjBRMcxeIv9kSk6618/WN
         O6dw==
X-Gm-Message-State: AOAM533EeSvBCLhD6l69ZN2chhbCMudh0jktyyqyhDWgXt2SFNxr6qRQ
        pOEC6vKtdWHLz8GFr2Zb8hnEzxvMGeI=
X-Google-Smtp-Source: ABdhPJwXiSaLw+79dOTmaynAwuKQ+ifuzg3Go+OKhBKK7SzP3ECP613zjDeXg9OPGs2CNaBP6h+9ZA==
X-Received: by 2002:a05:6830:4b0:: with SMTP id l16mr8919792otd.97.1626453620505;
        Fri, 16 Jul 2021 09:40:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id n23sm1337577ooq.48.2021.07.16.09.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 09:40:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Difficulty connecting to AP using rtw89
To:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
 <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <28f2a476-b690-24dd-df7e-f88f45b9292d@lwfinger.net>
Date:   Fri, 16 Jul 2021 11:40:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/15/21 10:17 PM, Pkshih wrote:
> Hi Larry,
> 
> I'm not sure if the problem the users met is related to security or not.
> But, we have a solution to deal with similar symptom.
> Please apply and try attached patch to see if it is helpful.

Ping-ke,

Two of the 4 users with the problem have reported back that their device now 
works. Thanks for the patch.

In a separate question, will v6 have provisions for IPv6?

Larry



