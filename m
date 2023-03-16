Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412986BDBF0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 23:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCPWsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCPWsE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 18:48:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A8E6DBA
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 15:47:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t9so3577913qtx.8
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679006868;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKHnnkPazwpfbziiWQy+PBZhHwBmODnl2Umv22BWgNQ=;
        b=eD6bhlCze/JO3I4itK1qOsNecEAVduB6IaCyWS5lLQdxuRewhNsSXdrPY3OeP8JRfx
         WqQil9kGpTWNYwjbz5Sc1dE2AAGqHcbL5cT8xDAgUBYfRy7jOMcmL13bhnI7A53mdd8G
         DuXAyLWuL3/MjX7HsEJBYS1E2TquOnhEYyaKrI7l+T2zgA91AxiPsuThKHSe/8ybHdZG
         J1qQ8H+CBpfEsOrNurwxHn+bPKFoQCQ3xyVoSi45fUkwg1PLeZjUq3JzYm+rbdpxlS0g
         xN+iMvK+aG7/ZZdRh6UzHxgqQqVI9ZIRaOmyTg733t7geJDOsacqGXDcWc+bl2JNPvDx
         nViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006868;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gKHnnkPazwpfbziiWQy+PBZhHwBmODnl2Umv22BWgNQ=;
        b=guIdcQu0SWaK2HY4SDwGKumMgL4DbUqYqjQ9jQIruQORtYTUkfJ+iMvpU+xiNE5G9Q
         vIQ3EJcXNRuGjhXlhIKduEdxemlkyjfPKmCTJ4yF8YGSKsrNhMicMIX6g3X1+YepsCPl
         S0TMudyrM+OcJlLfB5c8ZPR5855/j04g2GOciYzfGzRugBWl3P1QUImkyeMtnLjJaVT1
         tXUpBRK6+F8KrfQ3hibvm6IozoMErjYtjUnu6HU/pzBHZ1EqUdx7k3HuVsNvU/XD21Rj
         bTL8ju5YOFM4p2VqO5TEY0NLzKwCwbaoLD+qOQ3hG60nXNlHLEuE5nyTkqA/Lt4e+8KB
         BK9Q==
X-Gm-Message-State: AO0yUKXlGdg/sPPSKox2OSQVwDfpEXZ4S8rXAktX5/PTQ7X4AFhDRSRj
        8clkasLoi2iGv2LxE8d+G2prNiwksG4=
X-Google-Smtp-Source: AK7set8AXBH+spPXWY7AzFhpAp+wuU9ZMniw4e1ktkX5c0K2dvXMSUs3iaCExywREvWkuPYPz3vXUw==
X-Received: by 2002:a05:622a:2c6:b0:3bf:d946:b04a with SMTP id a6-20020a05622a02c600b003bfd946b04amr8540035qtx.66.1679006867952;
        Thu, 16 Mar 2023 15:47:47 -0700 (PDT)
Received: from [10.8.2.6] ([94.140.11.247])
        by smtp.gmail.com with ESMTPSA id x26-20020ac86b5a000000b003bfa2c512e6sm467184qts.20.2023.03.16.15.47.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 15:47:47 -0700 (PDT)
Message-ID: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
Date:   Thu, 16 Mar 2023 18:47:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
From:   rb <rb0171610@gmail.com>
Subject: New binary rtw8852b_fw.bin not loading firmware not recognized
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Briefly,

I use rtw89_8852be in kernel driver

HARDWARE:
Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:b852]

Lenovo Ideapad 1i

ISSUE:
Newest version of binary firmware 2023_03_10,
rtw89/rtw8852b_fw.bin, will not load/firmware not recognized on Linux Kernel 6.2.5 (and others):

[] loading firmare: rwt89/rtw8852b_fw.bin
[] rtw89_8852be 0000:03:00.0: no suitable firmware found
[] rtw89_8852be 0000:03:00.0: failed to recognize firmware

Issue persists regardless of which 6.2 series kernel is used.

All previous rwt89/rtw8852b_fw.bin firmware from linux-firmware 2023_02_10 and earlier loads and works correctly.

I did file a bug report with the details:

https://bugzilla.kernel.org/show_bug.cgi?id=217207

Thank you,
Rab B.
rb0171610@gmail.com

