Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50487E83B8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjKJUZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 15:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjKJUZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 15:25:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130546AC
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 12:25:46 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6cf65093780so1329394a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 12:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699647946; x=1700252746; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HOerzP/ZTANSGvYKt9EpJiSCt0T990lefLZx6t5PXRI=;
        b=NLtGiotcKB+nwEdW6DcVCujXN4okWvU6uvJplcADWdgLxWOYeZaB4Xcpqt5lkmicZA
         EOluxZWGY/RbCrJVDiEiVhKAtXDvhcPLYUeBEq2T2tPPYjhzB2B/1h6a+rcQjYgohg84
         5TO1qZ/hAgcXiJIW5y/Oqu1EAQ7SlHebL9uBe4ZxOdgYUkV/vyrYCA8ls9eDwZLXBfpq
         jsqwGWYeY5B2ektluZW/75qC6voMrA5YGfJU4le8GVGZgx3teJOMXs75jrhBlY+5KBUt
         /PnLsfiEc/nbgKuoPQ3kERbhRigodDOXzVkUhQhRxAKMsdfObGLzKso0rc2tauHdXxHQ
         AECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647946; x=1700252746;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOerzP/ZTANSGvYKt9EpJiSCt0T990lefLZx6t5PXRI=;
        b=qojEWyUnIrHsDwlOBo1de2hf7vSemtXMv4Wof86d+cYxKlEDmyFIvgqcR9Z3swET18
         QFfOQCjcgUae6pxx3HaNmK0cWe6O+Hmu2EYRvfT9r9IAtmKlhmjtW+KKV9acDJqiqyJC
         7E1N6QrrvyT7tmvGHmz/r9K6IFtSJw60iENdN2iWKYy7xVpRmdqwBmiSIIWaWx0lN7y9
         YXF2MUwGJC9uSTECMmQYD8Q2eZHschlDdbPS1dYZ5QAfKR+IGigu1NXNeAgrXbTDrQ4k
         GjpEkAa84M850a8VP8BWOzCHLIwcEUHNNBWZSemfAdOp+Yl2xFxREsu9+4iMwIlIy8OB
         azSw==
X-Gm-Message-State: AOJu0Yz5iTVCCl8KiO6rSNK3RJ83SdGf29UAXiecZjuVWe63q1GBY1+g
        o1OZMZfzbzFhoitpeptJ/vjdiwfk3IE=
X-Google-Smtp-Source: AGHT+IGlQ6rf7/RVLfcDwRTl5OnJe9lE0w5w15+/jawZPPrDfA0hb6zj/+eiLt0dfyHTWYBfx1ATDg==
X-Received: by 2002:a05:6830:3111:b0:6cd:924:4658 with SMTP id b17-20020a056830311100b006cd09244658mr184215ots.30.1699647945824;
        Fri, 10 Nov 2023 12:25:45 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q9-20020a9d7c89000000b006cd093a0ea0sm48222otn.5.2023.11.10.12.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:25:45 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
Date:   Fri, 10 Nov 2023 14:25:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: EFUSE in RTW8723DS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin,

The commit 9be20a822327 ("wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) 
efuse parsing") indicates that no additional information is extracted from the 
EFUSE? Is that true, or did I misread the code?

One problem we are having is that some devices come with zero programming in the 
EFUSE, and even with supplying a valid MAC address, the performance is poor.

Larry

