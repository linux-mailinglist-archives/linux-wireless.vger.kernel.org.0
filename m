Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B2608FB9
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Oct 2022 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJVVYc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Oct 2022 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVVY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Oct 2022 17:24:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE4B1F9
        for <linux-wireless@vger.kernel.org>; Sat, 22 Oct 2022 14:24:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m15so18127667edb.13
        for <linux-wireless@vger.kernel.org>; Sat, 22 Oct 2022 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDWA+60UTCYGswOinUmtmnlUgicdh0TCqjY6V84YEMs=;
        b=ccKDdy5mdxppsWOs+ZJWlX2WD1HE00CxnqzU3v5enesmWnFA3mw1xCFbqUzUO3hPzn
         uqQ2wcnlxSBNzFsnupnS9MXGh4kqriqTxGWBCVd7yRQBsSY0XpCjABLknr0AsD2s+X0/
         D4G+WCvNsnIWsHo2vap3bPt33ZIJ5pCd+LQ/ORHJZhb4moXdVSBAEl4AbLgXQVPD1x63
         mWbzDK5+gLOc3sMVf1ttgcJ9aPYHPteu49Sf74kAiGQOOBpPdytj3VVQvM23uU1SiG+b
         Q72Pkmf2QwJVpNpBvXZEqC3Eb2vGNJrLbPUECs/gBfPS+LxWnftoUwkASTjvVrTfecqC
         et/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDWA+60UTCYGswOinUmtmnlUgicdh0TCqjY6V84YEMs=;
        b=DtApOr78DJMQKNoAoL2qBYSWbxM2/fgOOHfk4tFs9uJOzsTDymMt+DKKN0Vy9btGIW
         otF0DWEFDStCGWFzo3/nlqInXaDLMszwJC3KFUDwc6hJPMOZsTAdN3lo/KhK6BPvgdWl
         5xpq5vRzCwp1JNbJDWq9UmLJZ1ahvLIYEjQqwFqLb77f3nyvsmMwamsHBd7Kfq0H8Irt
         7yCYo7zGtLVGF2FpprckZhZXcOP5iWeIxP6k0LmpT8AU3bMsaM4I5Ig3/7JwqSdJ6ur1
         Hz8ecLQqyj1lA8nPWx9ZCmn6JYmpg/A8CBpvf/SdztIKFYkH2CpsCdmgd5DxMtG8qquY
         5DbA==
X-Gm-Message-State: ACrzQf0V3tIaBdpttI7X2ulXWs/NPZWnXPaIWLwO/eK3/a6J/Y3gz74K
        kI2ZpR+9svjV/9kh/e8dBN/9kfX5NcE=
X-Google-Smtp-Source: AMsMyM43FaiQBgGWHROXEWOk2Kf/Vaa04t1uZA7WH9cIllCKi7DnRb8FWKE0hRF5qOD4M1PNJTdRHg==
X-Received: by 2002:a17:906:8453:b0:78d:b65a:abf1 with SMTP id e19-20020a170906845300b0078db65aabf1mr20715928ejy.696.1666473865104;
        Sat, 22 Oct 2022 14:24:25 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id r27-20020a056402035b00b00459012e5145sm15705205edw.70.2022.10.22.14.24.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 14:24:24 -0700 (PDT)
Message-ID: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
Date:   Sun, 23 Oct 2022 00:24:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: How to use the rate control in mac80211?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

What does a driver (rtl8xxxu) need to do to make the rate control work?

I thought it's like this:
1) don't set HAS_RATE_CONTROL
2) tell the chip to use the rate from tx_info->control.rates[0]
3) report if the frame was acked or not

But it's not that easy. I'm always getting MCS0. Currently rtl8xxxu
doesn't ask the chip for TX reports and always sets IEEE80211_TX_STAT_ACK.
I thought this would get me MCS7 for all data frames, but it doesn't.

The rc_stats file from debugfs looks like this after using the connection for a while:

              best    ____________rate__________    ____statistics___    _____last____    ______sum-of________
mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]
HT20  LGI  1  ABCDPS  MCS0     0    1477     5.6       0.0       0.0       1     0 0             0   0        
HT20  LGI  1       S  MCS1     1     738    10.6       0.0       0.0       0     0 0             0   0        
HT20  LGI  1          MCS2     2     492    14.9       0.0       0.0       0     0 0             0   0        
HT20  LGI  1          MCS3     3     369    18.8       0.0       0.0       0     0 0             0   0        
HT20  LGI  1       S  MCS4     4     246    25.4       0.0       0.0       0     0 0             0   0        
HT20  LGI  1          MCS5     5     185    30.7       0.0       0.0       0     0 0             0   0        
HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0       0     0 0             0   0        
HT20  LGI  1          MCS7     7     148    35.1       0.0       0.0       0     0 0             0   0        
HT20  SGI  1       S  MCS0    64    1329     6.2       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS1    65     665    11.6       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS2    66     443    16.3       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS3    67     332    20.4       0.0       0.0       0     0 0             0   0        
HT20  SGI  1       S  MCS4    68     222    27.2       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS5    69     166    32.8       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS6    70     148    35.1       0.0       0.0       0     0 0             0   0        
HT20  SGI  1          MCS7    71     133    37.3       0.0       0.0       0     0 0             0   0        
HT40  LGI  1       S  MCS0   128     711    10.9       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS1   129     356    19.4       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS2   130     237    26.0       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS3   131     178    31.4       0.0       0.0       0     0 0             0   0        
HT40  LGI  1       S  MCS4   132     119    39.6       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS5   133      89    45.6       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS6   134      79    48.0       0.0       0.0       0     0 0             0   0        
HT40  LGI  1          MCS7   135      71    50.2       0.0       0.0       0     0 0             0   0        
HT40  SGI  1       S  MCS0   192     640    12.0       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS1   193     320    21.0       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS2   194     214    27.9       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS3   195     160    33.5       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS4   196     107    41.8       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS5   197      80    47.8       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS6   198      71    50.1       0.0       0.0       0     0 0             0   0        
HT40  SGI  1          MCS7   199      64    52.2       0.0       0.0       0     0 0             0   0        

Total packet count::    ideal 4      lookaround 1
Average # of aggregated frames per A-MPDU: 1.0

It looks like the rate control algorithm is not getting any information. (Also, why are no CCK rates listed? With mt7601u there are CCK rates too.)

What to do?
