Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E451C3D2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381277AbiEEP0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381266AbiEEP0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 11:26:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4E5640E
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 08:23:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c9so4005708plh.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 May 2022 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJq/qvj4FZwE6s96MeqFpqf47Ys+qQjfKC+Vl3h47kk=;
        b=0ZXwdSgZILgbSfTpRkGbOJLVKuFNZdzEMsvyDK9VwGYCP4HAvpLQqNRHaQFb347qjx
         sMhXEbywu0DRM8W+2CmTVBhZiERNFd466mUcCNFBvbbLb0hgAvd4AlPdm2Nrd7zOXoPX
         GDR3wBK5Lwh/pzItEnf7XXi4WfM0GqS0ElL49JvpA+EKoV+e8mRvVOQlhWkWKYrcu+P+
         D8D/diMJGVSskmjPOWEB46Jypy6v9lxrQus7d4p9hc9c0kTFrBl4pa+BE4bOIrKm5DpW
         D9Vz4bytZ/mBDRg/dbwbTK7ZK+vc69do+KtwVbP7CzWumFO6LpcTZdp/ZCY0XSrHe/GA
         d/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJq/qvj4FZwE6s96MeqFpqf47Ys+qQjfKC+Vl3h47kk=;
        b=yzs6yfeNSLbMXMMK2tG/ZhixVb6iwbiGyA1WCH91ic2bDutSvwS9tXBLoi9SBJNDqz
         SfPnh3fJrpzBZI8P8/QVQKlvWH+J0LNBApkSkSEHpaUTUjl+s19xJghJSp0ZdHHp9FmQ
         TfRfXljeW2pX4Lz1lHpiqFoFnrvA6sYCfo1Q//6yiZOxnZcM8vZARC3CTXciZNZW0QgO
         fZ/cBNcKJi9C/3fmR5W6mUawJmBcHshfj2v9FlDSZgB1z4nczeGxXUHI1m60/lSGIniW
         nQ38VL1HbvEvYivD/D7zVyq9Ke5kZxmEMS9mXnNGI5ZRU+1i6A1+h/clf6BpBaigkjxT
         FSiA==
X-Gm-Message-State: AOAM532Enr+k0kd7godn5gjHgLivX7VblL0TyVVpAQ+vnelAQerB7XTy
        pAnCK8ef3hcWo8/kBBNwwrQbKA==
X-Google-Smtp-Source: ABdhPJzxxrHLaaFrj4SdCqEuXu2hYIOTSHOTO75S5Lm125KA7NuKgtEdnmV4IUFHvVLXOo11hjpJ1w==
X-Received: by 2002:a17:903:1d1:b0:15e:9607:d4c9 with SMTP id e17-20020a17090301d100b0015e9607d4c9mr24712752plh.41.1651764179686;
        Thu, 05 May 2022 08:22:59 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id i14-20020a62870e000000b0050dc76281ecsm1496229pfe.198.2022.05.05.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:22:59 -0700 (PDT)
Date:   Thu, 5 May 2022 08:22:56 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Gonsolo <gonsolo@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Suspend/resume error with AWUS036ACM
Message-ID: <20220505082256.72c9ee43@hermes.local>
In-Reply-To: <CANL0fFQRBZiVcEM0OOxkLqiAKf=rFssGetrwN6vWj5SsxX__mA@mail.gmail.com>
References: <CANL0fFQRBZiVcEM0OOxkLqiAKf=rFssGetrwN6vWj5SsxX__mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 5 May 2022 08:29:52 +0200
Gonsolo <gonsolo@gmail.com> wrote:

> Hi all.
> 
> After a resume I get the following error:
> 
>  +0,000007] UBSAN: invalid-load in
> /build/linux-lowlatency-fSdu7c/linux-lowlatency-5.15.0/net/mac80211/status.c:1164:21
> [  +0,000004] load of value 255 is not a valid value for type '_Bool'
> [  +0,000004] CPU: 22 PID: 387 Comm: kworker/u256:5 Tainted: P
>   OE     5.15.0-27-lowlatency #28-Ubuntu
> [  +0,000004] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./X399 Phantom Gaming 6, BIOS P1.31 01/14/2021
> [  +0,000003] Workqueue: phy0 mt76x02_mac_work [mt76x02_lib]
> [  +0,000014] Call Trace:
> [  +0,000003]  <TASK>
> [  +0,000003]  show_stack+0x52/0x58
> [  +0,000006]  dump_stack_lvl+0x4a/0x5f
> [  +0,000007]  dump_stack+0x10/0x12
> [  +0,000003]  ubsan_epilogue+0x9/0x45
> [  +0,000002]  __ubsan_handle_load_invalid_value.cold+0x44/0x49
> [  +0,000004]  ieee80211_tx_status_ext.cold+0x4e/0x5f [mac80211]
> [  +0,000068]  mt76_tx_status_unlock+0x111/0x160 [mt76]
> [  +0,000010]  mt76_tx_status_check+0x68/0x90 [mt76]
> [  +0,000009]  mt76x02_mac_work+0x14b/0x240 [mt76x02_lib]
> [  +0,000008]  process_one_work+0x222/0x3f0
> [  +0,000006]  worker_thread+0x50/0x3f0
> [  +0,000004]  ? process_one_work+0x3f0/0x3f0
> [  +0,000004]  kthread+0x13b/0x160
> [  +0,000003]  ? set_kthread_struct+0x50/0x50
> [  +0,000004]  ret_from_fork+0x22/0x30
> [  +0,000006]  </TASK>
> [  +0,000001] ================================================================================
> 
> This is a stock Ubuntu Jammy lowlatency kernel (with Nvidia drivers).

Contact Ubuntu.  The rule for upstream is if you load out of tree drivers
than that kernel is unsupported.
