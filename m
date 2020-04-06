Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3D619FDF2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFTQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 15:16:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46506 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFTQu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 15:16:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so794638wru.13
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cE+iUtARfpAbpnYwGWN8p/sN84pPLlS+ycR4J0TYUCQ=;
        b=DkKPyYJ2bKe8zYPtX18ncU0y8AHIPNuwNzax8yDaWWL4wEqRWebsV/uUXCqHO8skm1
         Z0+UzgYn0seA9s7d2inQ5hWmrqGqK0iVy8G8s9VyLrZCJw54j0YgiU1bYstX9ijLe8a4
         k+d27rtXJQM8odL3AY1gqipxQo6KBriaMSU7N0CcWPDtD3VbGVwQueRsLhQ4BS0aQX1y
         yiJCtiTVIy00sfJkQ2xYJxH4BhHXwN2bFkGQ3ZoK6aQpCzgjywkEuBQa4jJCkNErXUMW
         gh5z2wFiUOeP7MtP+Qv2UZLX8gQiF/M43TFHTMBGZfXkbVz9p2y2UK0LXzYyzMMw8S2t
         S/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cE+iUtARfpAbpnYwGWN8p/sN84pPLlS+ycR4J0TYUCQ=;
        b=GwGyJr5bpEo0q3xjVMzkkpPhL99ID1a4e16ebUj2v2YuHuHiuJ8DW9hU2Ws7/jlhCi
         cC1KmkLXzenCa312Xs9nJs2RxVkwC6uXcomdX5uFQ0creXAfNnSGjE7gRQhHl7iI99oG
         qyHzgGqQi2Dfb7VPoqZzA7el819ZQ5vp6vpc+6l7WHusmAJSG93Tv2HhE23Al59CJDJ/
         b7W6QxrZXN0cBst5rfasuHD+JVdl2UKVmhQpEcw3wrDdYTqg547qlYDPNPc9PsVfwiQO
         N3eg6VqX5c90SwE8l/oOKd29Dn8vAESl4vpZ/DWPrcTv/rbB0d0CI540RK/MjM+tDf0p
         5hxA==
X-Gm-Message-State: AGi0Pubp5pIRxtcxuuuJKAlKA6FSVByOilGkkRRQrEVyyIe4hwqZapQL
        RuiCf+DSMBCdM/QGQ9fsG/JWb6eo
X-Google-Smtp-Source: APiQypIlMP6ohQsalXMgRrT4k/Cpx1Lv+Y8XSStKRPrmW+TrbyLcYMr5wrP6CbP1v8DwJaJ7+s/USQ==
X-Received: by 2002:adf:f641:: with SMTP id x1mr770799wrp.239.1586200607593;
        Mon, 06 Apr 2020 12:16:47 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id j11sm22431050wro.51.2020.04.06.12.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 12:16:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: vt6556: vnt_rf_setpower convert to use
 ieee80211_channel.
From:   Malcolm Priestley <tvboxspy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
References: <6e9ffe4d-a651-d17e-ebf2-2bd6f766e6dd@gmail.com>
Message-ID: <02cdc49a-b59a-31c9-1f51-793a9a6a4ea5@gmail.com>
Date:   Mon, 6 Apr 2020 20:16:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6e9ffe4d-a651-d17e-ebf2-2bd6f766e6dd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop these patches I have just noticed a mistake.

Regards

Malcolm
