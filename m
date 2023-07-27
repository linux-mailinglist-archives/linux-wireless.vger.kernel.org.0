Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E155764311
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 02:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjG0Al4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 20:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjG0Alz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 20:41:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5319BF
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 17:41:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3b7fafd61so370752b6e.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690418513; x=1691023313;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mqigwr5ia3Ychv8I75g/uyfX3tdE8els6aDl5BRDFA=;
        b=sFqZ9TjDp3QocGgV7VZ+XvkyHNHSf2voUUQ/pnTegv70r8wTUi4RDDcrifAKCiwGdU
         X9DDyjkmm4hR7omXv3KvWyCcNvfATJyqcCdSLYZeiJLELW77XcHxcHSf7ehurD+h99zp
         lfjGs2RPv0gkfx0BMfOaqPviT5LHYFqQ7/gjgHjliksjjrGgWUIFnFe9mX8S8ZdyPsCr
         iuTzQrPRwYQCnU0/JyVr8w0vRcW98Gdaf01As4nizVctRQZouztPop/O6r3kXSwhHKaB
         YVcBh05jAHCaycZLjmO/cqjFZzLxVRZAkSeVKJCkbH4fHaujOV4PWCqY7g6MsKaZOOHE
         c3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690418513; x=1691023313;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mqigwr5ia3Ychv8I75g/uyfX3tdE8els6aDl5BRDFA=;
        b=idBwoB1dIg5WqZza9OtB4Icysea1pNVjpnqd1z9v4P4ll4ZkzmYg7HUNVtjwBfHJSM
         tj5Jh1q0vc0BehQsPQiIuOjacMt3obSpsfTsu76/aQCMJ2DXxd7D3loq6kFKxIvi47iy
         msyjbFSAuM3+zdTRSc8sWVFjUHVhEGvF5yZOPWJPp6UbPp0Ha3xCGjjTSO457wHzvqKd
         q8mbMijVnumYh7OtX3SYm9CEJzjdeeankBV8sH4T/GAQuCsvSMCUMTdfbP8X3y0rNeXq
         aecM4fcsfoMKxCDr6iP1TZZklMrFEHxu+148nV7Aq4XElCE+eMKpRYMLNjByqTP9QJ1/
         CTig==
X-Gm-Message-State: ABy/qLZbr5V8SLUO/3kxg5lj78HFVkvVeYnYei3n/8OeG6+11GLdzL8F
        qpyxVJxd/0qbXO7QJ17wEOhwBbpKVaI=
X-Google-Smtp-Source: APBJJlFZR5lozVLk+/92aud713juqgkkhU2L/3IfOrzIC3US2O7W8/jwPY8ov5IrtXw56Qz8cIeafQ==
X-Received: by 2002:a05:6808:ecc:b0:39e:b58c:13d5 with SMTP id q12-20020a0568080ecc00b0039eb58c13d5mr1225793oiv.17.1690418513440;
        Wed, 26 Jul 2023 17:41:53 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 22-20020aca1116000000b003a384aa4c63sm159297oir.52.2023.07.26.17.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 17:41:53 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <52233a6e-e880-5160-7042-5a0dcce21b03@lwfinger.net>
Date:   Wed, 26 Jul 2023 19:41:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Pkshih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Problem with rtw8723ds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am trying to help a user of rtw8723ds. The original problem was that the 
vendor driver was causing a spontaneous reboot. As I have no interest in 
"fixing" that driver, I steered him to my rtw88 repo.

The driver loads, and then nothing happens. With the debug mask in rtw_core set 
to all ones, his log shows the following:

[  150.131387] rtw_core: loading out-of-tree module taints kernel.
[  165.352077] rtw_8723ds mmc1:0001:1: rtw88 SDIO probe: vendor=0x024c 
device=d723 class=ff
[  165.359853] rtw_8723ds mmc1:0001:1: Firmware version 48.0.0, H2C version 0
[  165.818336] rtw_8723ds mmc1:0001:1: hw cap: hci=0x06, bw=0x03, ptcl=0x02, 
ant_num=2, nss=1
[  165.818350] rtw_8723ds mmc1:0001:1: use rfe_def[0]
[  165.820320] rtw_8723ds mmc1:0001:1: use rfe_def[0]
[  165.820333] rtw_8723ds mmc1:0001:1: phy cond=0x0304f400
[  165.820412] rtw_8723ds mmc1:0001:1: txpwr regd 3 does not be configured
[  165.820423] rtw_8723ds mmc1:0001:1: cfg txpwr regd 3 by regd 0 as alternative
[  165.820438] rtw_8723ds mmc1:0001:1: txpwr regd 4 does not be configured
[  165.820448] rtw_8723ds mmc1:0001:1: cfg txpwr regd 4 by regd 2 as alternative
[  165.820462] rtw_8723ds mmc1:0001:1: txpwr regd 5 does not be configured
[  165.820472] rtw_8723ds mmc1:0001:1: cfg txpwr regd 5 by regd 2 as alternative
[  165.820485] rtw_8723ds mmc1:0001:1: txpwr regd 6 does not be configured
[  165.820495] rtw_8723ds mmc1:0001:1: cfg txpwr regd 6 by regd 0 as alternative
[  165.820508] rtw_8723ds mmc1:0001:1: txpwr regd 7 does not be configured
[  165.820517] rtw_8723ds mmc1:0001:1: cfg txpwr regd 7 by regd 2 as alternative
[  165.820531] rtw_8723ds mmc1:0001:1: txpwr regd 8 does not be configured
[  165.820540] rtw_8723ds mmc1:0001:1: cfg txpwr regd 8 by regd 0 as alternative
[  165.820554] rtw_8723ds mmc1:0001:1: txpwr regd 9 does not be configured
[  165.820563] rtw_8723ds mmc1:0001:1: cfg txpwr regd 9 by regd 2 as alternative
[  165.820755] rtw_8723ds mmc1:0001:1: regd init state 0: apply alpha2 00, regd 
{10, 10}, dfs_region 0
[  165.820952] rtw_8723ds mmc1:0001:1: regd state: 0 -> 0
[  165.820969] rtw_8723ds mmc1:0001:1: get alpha2 00 from initiator 0: apply 
alpha2 00, regd {10, 10}, dfs_region 0

There is no more output. I see nothing wrong here, but I have no SDIO 
experience. Am I missing something?

Thanks,

Larry
