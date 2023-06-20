Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18973775C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 00:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFTWTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjFTWTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 18:19:17 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E91726
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 15:19:12 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-55e04a83465so3452041eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687299551; x=1689891551;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ce4QfuuodxHFezw7VCzltNktuKT6CSbcqfGp2refbzw=;
        b=cIPFh/DNYYbSBhcM8dRfb5bOb5+wVuuXSg5AKwN0bMrGywjnqCDF2rgJ4yaCSHTj8p
         rmzrkCSuDIusUYT7izkGwQHd6UwPi4zLYNYvdILlvoFM+0qRWs0mqsmZXTBN7nQdVO7N
         MxcMnNCspj5+aK0+bZa2KripVvK3ccawN1/Jk7Nzf3PV8lhH+mpmsXmyTIGl8LBJXv7e
         Z+KIg/4B2lDwjSQhxUYLx+Ju79iY+2iN0x7zc58WENDPuIC0xDxvCutY57ebAxhGecb2
         e6iHTpOY86HD/go8e8iB86SN0bIeqxnzDCmqCFUjA1OvJCFPRka0a2rqVilfubjwmiPS
         YGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687299551; x=1689891551;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce4QfuuodxHFezw7VCzltNktuKT6CSbcqfGp2refbzw=;
        b=fLMZ66bxkud9qZFrNensNvm8E40qw+MIOJ2CzRBRN4DG8dOg4wmWF3jJoC0r7jV2wS
         WiS9xVL3//3+xfLFTUor74RwbdnOEG6Fgy4y3NdHo9b+SHl/xR498o0eiXGWuJMm+KFM
         yr832Mg8PXyICF+Pw/ScCaWIeXrNL7i887GNedjnVuuOKbg535bNzkwi3+EfxcjX4av8
         nNxA6KsBfNf0CFwC8HnHFXYUfFK8HKhKRK6cfI4Hi/usYN318Eh3g0HSb+dGwlNQR4xN
         bcTTrUwNAZhxDIvaTJJgJMc6VURT/Mm8fYsBFwx1gz1f0L8kAU36xXS3QO8RFxBNzbjp
         zXnA==
X-Gm-Message-State: AC+VfDw9aaxoMeFqya6catWmDRAfRqwwO/mZHxWREOeIr0KxnSCn2JCI
        VqiAPv+Rq9gJWFNKKcGw5q+ezThTTaA2Og==
X-Google-Smtp-Source: ACHHUZ4YifOrMoGYGt+0r1l+MyiRzsLRw4gjNrrut01oVwRkbyMWouq0A6KC5qT2ZOk7nmroVTat2A==
X-Received: by 2002:a4a:deca:0:b0:558:b4cb:b18a with SMTP id w10-20020a4adeca000000b00558b4cbb18amr9721150oou.6.1687299551335;
        Tue, 20 Jun 2023 15:19:11 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d21-20020a056830045500b006a62aac5736sm1379317otc.28.2023.06.20.15.19.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 15:19:10 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9b2a7e8f-f875-cd74-2f79-dae385be901a@lwfinger.net>
Date:   Tue, 20 Jun 2023 17:19:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Wanted: GitHub successor maintainer
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

A resent event reinforced my feelings of mortality, thus I am asking here if 
anyone is interested in assuming the role of surviving maintainer of the GitHub 
repos for Realtek wifi devices.

The major repos are the ones for rtw88, rtw89, and to a lessor extent rtl8xxxu. 
These repos make the latest wireless codes from wireless-next available for 
users with older kernels, at least for v5.4 or newer.

I also have a number of repos that support the vendor drivers for devices that 
have never had an in-kernel driver. Maintenance of these involves updating them 
for the latest API changes.

I feel quite strongly that this work is too important to be abandoned, this my 
request here. I plan to keep doing it as long as I can, but just in case...

Thanks,

Larry

