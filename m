Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307556E4B64
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDQOW7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDQOWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:22:53 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A597;
        Mon, 17 Apr 2023 07:22:50 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 3EFC1200408;
        Mon, 17 Apr 2023 16:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1681741368;
        bh=kTItlP2YI88NnNFYbognrrCdZc5bTlLjB1ZMOm34g6U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MsSERrn9h14PSHh54N2ikHlA+O74JGfn36OIedPCdtTmuMqOnBVBAAsLewloQRRCe
         rrpRlg2tSOtadjkCAj2ew+lRBDyk1YeRiAqg/wHArTL9vMqeERTfowuhsHCLXSJoOQ
         xHv9cLQjw5pSUPmN7/qHUyQLijPOBwGpB+uVsBopNA8nDFexILcm0+56twRPvvOc1S
         GAX6FyFjz1sE/PSzriMkUKtDcMFOZ4s9zZGd+nJ2oyKNbm5LNAWkEalID9QYNDxc+m
         VQgfGbtQg/cAkIfN6hWw/UrH40uaUB/yqW20LzE908hom1sUa+j39Ww/OFDM7VFoDk
         pjSk2EQJOj0Fg==
Message-ID: <ac5d9c2e-13c3-7f99-a20c-d857282c6451@free.fr>
Date:   Mon, 17 Apr 2023 16:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Performance regression] BCM4359/9 on S905X2
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     AML <linux-amlogic@lists.infradead.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Christian Hewitt <christian@hewittfamily.org.uk>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
 <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
 <CAFBinCA+JOxCGzML-Mohryawrn6Vghd8Ns22=2ZfvWov43aeEg@mail.gmail.com>
 <74feca6f-4177-5645-6614-bc5f3dbf0be1@free.fr>
In-Reply-To: <74feca6f-4177-5645-6614-bc5f3dbf0be1@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        NUMERIC_HTTP_ADDR,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/04/2023 18:35, Marc Gonzalez wrote:

> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
> 100 1024M  100 1024M    0     0  9747k      0  0:01:47  0:01:47 --:--:-- 9544k

I was able to import the bcmdhd driver from:
https://android.googlesource.com/kernel/hikey-linaro/+log/refs/heads/android-amlogic-bmeson-6.1/drivers/net/wireless/bcmdhd
as pointed out by Neil.

I switched from brcmfmac to bcmdhd with:

-CONFIG_BRCMFMAC=y
-CONFIG_BRCMDBG=y
+CONFIG_BCMDHD=y
+CONFIG_BCMDHD_FW_PATH=""
+CONFIG_BCMDHD_NVRAM_PATH=""
+CONFIG_BCMDHD_SDIO_IRQ=y

and hard-coded the FW paths in dhd_set_path_params().


Here are the benchmark results on the bcm4359 (AP6398SR3 module)

# curl -o /dev/null http://192.168.1.254:8095/fixed/1G
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1024M  100 1024M    0     0  17.3M      0  0:00:58  0:00:58 --:--:-- 17.4M

which is noticeably faster (80%) than brcmfmac results.

FTR, system was 18.5% busy for this benchmark:
   81.5653%        195114        0:swapper        
   13.8287%         33080       57:irq/17-ffe03000
    1.3967%          3341      173:curl           
    1.1350%          2715       63:dhd_rxf        
    1.0455%          2501      129:ksdioirqd/mmc2 
    1.0004%          2393       62:dhd_dpc        
    0.0167%            40      171:perf           
    0.0088%            21       19:ksoftirqd/1    


I was not able to get the driver to work with bcm43752 (AP6398SR32 module).

It loops with:

[   15.221622] wl_run_escan: LEGACY_SCAN sync ID: 0, bssidx: 0
[   15.221661] CFG80211-ERROR) wl_run_escan : 
[   15.221664]  Escan set error (-37)
[   15.229067] dhd_ioctl_entry_local invalid parameter
[   15.233902] CFG80211-ERROR) wl_run_escan : 
[   15.233904] error (-37), cnt=1
[   15.241056] CFG80211-ERROR) wl_cfg80211_scan : 
[   15.241059] scan error (-11)

But I may have bungled adding the "new" chip, since the driver architecture
is... [censored].


I suppose the conclusion is:
1) bcmdhd is 80% faster than brcmfmac in one download scenario
2) CPU usage scales linearly with throughput (on this system, 1% ~ 7 Mbps)

Regards


