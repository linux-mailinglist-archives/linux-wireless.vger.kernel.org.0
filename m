Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685E6E2AC6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 21:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNTud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNTub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 15:50:31 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33149FF
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:50:30 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso3854889oom.6
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681501830; x=1684093830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SP5MHbtlZH4kC7QPSSNKG2p1rvmMxPKH0rNvR2OuTpw=;
        b=pBLka5G92W8fvFnhuTofQM/d8yxWiM54CTWlmNSnZijoRGRyqFQ8qkm/u+ixN3GPM8
         xBf4lpK11mKq18TlrmYXKmJeywaBc0AnDIQM7asrAhivBFOqUz1E6S0qIvjU61VJvZap
         qVNcgEymAvd/IW/38JYlLrKXaUlV1PhdTo/Sh9pZ5anV0drRsRHlgpNv6bRPNsTbF+G7
         5RPIFmhrsnlti6VGnczMe1TpWSDJK5wb9WiZXcQGl4dEuGXH/zUaKX4lSZGJrUsGz+hv
         W9gsbsPoFmzQcrn0fVu04GqukKDoJaSwiY7nPo1BpPsIpqDqgQ1oPuPznqFO/OJNg1En
         C7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501830; x=1684093830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SP5MHbtlZH4kC7QPSSNKG2p1rvmMxPKH0rNvR2OuTpw=;
        b=AxPwcdE1jaCX0aHb1ZOg7nKfSd5WY4Szns0X3w8bjoP0gSoMLMvjTdqAIIbXuGyvfH
         amBqWGkZFVIwBr7gnYRu+Evb3zSBBUdhWGo4cNnMUXBKR6gHAuuI8RkvP4g9LqSppMM1
         YF58cjj/VmSNNEB2+sz7BbM6F96NvGmtxRX0wG2s4JeLxo+24lroVeZtJD5uQgp4510R
         7wK4QxQYe5yCK2p8gS9s8KhOYKVB1A51AwmpcIf6iy1iqkeA1NJ982C87oyAzWPipNyz
         lDkt1Bci85h5rcR1ejLrNa0jHEsN+OOk60OlUZb9xhBOWkeorsXfBcDIz4ylIVYNOPH+
         lM+Q==
X-Gm-Message-State: AAQBX9cyXX/KNv/uSM9DOGBFnG+NZs7Y0XxWEcEIzAersof9pZIws6W/
        J7g8fEOvIzH+cFAyC8svX4gGBd0079E=
X-Google-Smtp-Source: AKy350ZaYP1h60AkqK7Z5gP7Ho8wFDOW8XtD12VaAwCAV7tCweguDeheeallCrkjPvDGHaqEDIvRxg==
X-Received: by 2002:a4a:3706:0:b0:542:616:50f2 with SMTP id r6-20020a4a3706000000b00542061650f2mr2860126oor.9.1681501830036;
        Fri, 14 Apr 2023 12:50:30 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v188-20020a4a7cc5000000b00524faf3d2d7sm2054536ooc.41.2023.04.14.12.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 12:50:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3aaaceb0-1518-49b6-ca18-f7c46c35c65c@lwfinger.net>
Date:   Fri, 14 Apr 2023 14:50:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Question about rtw88 patches
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

Kalle,

Has something gone wrong with Sasha's rtw88 patches to fix the hardware queue 
selection in rtw88 [1], and the corresponding rfe field width fix [2]. These two 
patches are included in my GitHub repo for rtw88, and they fix the ubiquitous 
"timed out to flush queue" warnings.

Larry

[1] 
https://lore.kernel.org/linux-wireless/20230404072508.578056-2-s.hauer@pengutronix.de/
[2] 
https://lore.kernel.org/linux-wireless/20230404072508.578056-3-s.hauer@pengutronix.de/
