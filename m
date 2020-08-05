Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22823D35A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 23:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHEVDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 17:03:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEVDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 17:03:41 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k3HXC-00086H-Bf
        for linux-wireless@vger.kernel.org; Wed, 05 Aug 2020 11:24:38 +0000
Received: by mail-pf1-f197.google.com with SMTP id e30so21225342pfj.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Aug 2020 04:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lF9ALM9gRuD9sB/pHsvqa0BtUHkbcECALGd1yP2+BEE=;
        b=ZgO0CXv/boayGrmrtdmuXkrYNh9s3XPrMBMosO9FV2U/Qox/hK8NE0aC6wj+VMyTLd
         tmIWGUXTs3XbhaEXCT/h+psV7y+Yfj4C9grY1oLsxfvZymYT0GI4Lusm0bctqjVdAcSk
         Z9gnNr/1EHm+oweaIPS8NVc6z4rliO7HDWGBNrfHVOTvTYw9N/m2Aw8aRg2ihRdh0+Yn
         FR58no8wlI2De8oijbAiom3IILuHG9Hu1auQ9aJsLDHAugDDbhCy0GX7a5Vbhg22m7a3
         2SZPvZGBiwe/n4jpnY1Epov3BpU/1H+CIZnXj2MMJwJB/Zr0m+cDYYf8ocIpd5f8DWlY
         8D+w==
X-Gm-Message-State: AOAM5334fx1iuTwzzczH0A0YZ5fzv85+t2UCh3VD1XPsDq6HRk1MaN3X
        DYq3LQjXPLMkDf3GBwkrWneACm7pYOTf9RPWuc050lnb443JseY1gb7lmSHMMnQqQpJu6aN8Xyw
        bwlhSeSZX9xkiG4BQGFnhzduiNDNB0DPdiNGcw+KdXLfZ
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr2894372pfj.307.1596626676926;
        Wed, 05 Aug 2020 04:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJvZXSuRgwTlY5y0En/vjiU7lqcs7sM2JL0qxNrQv5cxET1ZLz6FnSZD2pMhacVp3VGxyXoA==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr2894345pfj.307.1596626676533;
        Wed, 05 Aug 2020 04:24:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i11sm2613913pjv.30.2020.08.05.04.24.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 04:24:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] rtw88: 8821c: Add RFE 2 support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <c0c336d806584361992d4b52665fbb82@realtek.com>
Date:   Wed, 5 Aug 2020 19:24:32 +0800
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
References: <20200805084559.30092-1-kai.heng.feng@canonical.com>
 <c0c336d806584361992d4b52665fbb82@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

> On Aug 5, 2020, at 19:18, Tony Chuang <yhchuang@realtek.com> wrote:
> 
>> 8821CE with RFE 2 isn't supported:
>> [   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
>> [   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
>> [   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information
>> 
> 
> NACK
> 
> The RFE type 2 should be working with some additional fixes.
> Did you tested connecting to AP with BT paired?

No, I only tested WiFi.

> The antenna configuration is different with RFE type 0.
> I will ask someone else to fix them.
> Then the RFE type 2 modules can be supported.

Good to know that, I'll be patient and wait for a real fix.

Kai-Heng

> 
> Yen-Hsuan

