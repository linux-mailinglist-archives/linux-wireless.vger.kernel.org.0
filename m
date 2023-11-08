Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67997E590D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjKHOdk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 09:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjKHOdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 09:33:39 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B31BC3
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 06:33:37 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d134a019cso47561986d6.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Nov 2023 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699454016; x=1700058816; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfPICnN1kq+aCO2JC6xNMF1If99h7PD+jd1NB13o+J4=;
        b=cKrfb+dDNc+E3Kf6cF2LHB995kUokQHBT886TQTogpsowwAPXk6yqf8JkapH2LFQRD
         cfNDWfdYUcaEzNmobP86bfMi7bjJmB7HmdL7oUvoe+1IxwObypSKG0HndM5B7WK6xo5L
         xIQ1x4dLCvPeaWk04zKLGAIvB8ke9DZ+oZP7Hu4YywsBPD6aepCIKCy3UsqOTqlbyZyb
         EXGKkwdg2n7ssSR25zXPTTc60EFdhyY3/1STjvkSDoTedXrmEwjbBLX5hICsseb9J7kf
         WFfDeATUlKTEVEuIAZsdI3bNniSJ07z2+zVu7IlO6b6hcdTeP7ExDYMz+aMlwinvivBo
         /JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454016; x=1700058816;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tfPICnN1kq+aCO2JC6xNMF1If99h7PD+jd1NB13o+J4=;
        b=hjb+5dfv1HqinXNlVu5V4YgX++FuME4ozfjX5HhIetwT6PIit2eaPE7a8ZhL4ZQSZW
         VfIrLAddvgyVUW7/8qki01N+1jZp2aicAto440zGGvFDi2WM8FENhdxPjhNdMUeowT1W
         Ou+yh/JKq6/ZfNfpHXDWHe2s/RAyPbMBNcJScVW3GCoTLj4OSKuhjSXcFOeKgIw/xK2+
         x3jFW/dDpJ6VJId2aSIFzwNF/Hcsw6fUFuSjXfF6yFAnr2lK6XOLbTK75m3vD2+hORy9
         Bb1t3PWWoEA7we9il/E+u3SVGdfgOw2VMANo8RdxCFIqlcnUReBpDfBqwqEdBD0mmk2m
         jEgA==
X-Gm-Message-State: AOJu0YwP2lYaXMvcp0rvNCyn0ItvoMHdai1qbz2g7aR4fcpBFyrNh4T9
        zY6gR3D4ruHoxswf5MQsiJpl4WG67SA=
X-Google-Smtp-Source: AGHT+IGW+tbQug37FPSF5JL+uXaC76dRs3IAh1Tsh8O9K23/ZpAUx2zLTXA/5dcTWJlZ/5J49vUvhQ==
X-Received: by 2002:a05:6214:e4f:b0:66d:3474:a93a with SMTP id o15-20020a0562140e4f00b0066d3474a93amr2130642qvc.30.1699454015907;
        Wed, 08 Nov 2023 06:33:35 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id k15-20020a05621414ef00b006562b70805bsm1110046qvw.84.2023.11.08.06.33.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 06:33:35 -0800 (PST)
Message-ID: <c558e244-b10d-43f3-9f42-f6c2f98d5b95@gmail.com>
Date:   Wed, 8 Nov 2023 06:33:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   James Prestwood <prestwoj@gmail.com>
Subject: Can ath11k automatically enable CRYPTO_MICHAEL_MIC?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm not very familiar with how the Kconfig stuff works, but I spent 
longer than I care to admit trying to get the ath11k support to show up 
in menuconfig.

The issue was CONFIG_CRYPT_MICHAEL_MIC was not set, which removed the 
ath11k driver from menuconfig because of:

depends on CRYPTO_MICHAEL_MIC

Maybe there was a good reason (again, I don't know much about Kconfig), 
but should/could this use "select" to automatically enable 
CRYPTO_MICHAEL_MIC?

Thanks,
James
