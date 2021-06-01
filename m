Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF68B3979C5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFASKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFASKQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 14:10:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1702C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 11:08:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h19-20020a9d6f930000b02903c0c4560e99so170210otq.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GYDJMejGJ4+oeD9ME4oTISMMc6WgIG94ApS0mBPJyVI=;
        b=nYl8qw9vZnC749YdXZUiPJkyM6UXGl5lW6y6YHkv1Pl0i96BKrDqTMBEQ5gnqPnRPV
         U8Z+Bf/mHhZQNEAr1nTrIJUXAdVgR1R4cEdaBmqb/TMbQjjMtkD9KgYkvQToNXRSol+2
         Fz8j1LOiDkl7uFte5FRAYgugk3ffmr8mHH3Ln+V9jIhaBS0Tlve8Izvi0JXHFiJ2cJGM
         LrqlMdILnkfRfRozh/9MXE8SY7uz/h8Ai8Ll19KQutVBCqLSk8fHMwESBRYPcJN/uMeD
         nbp2LpwwlwRtpMv3g2Nixo6+zPo/+X+aORmnrjb2Sboan55lPH9lzSNV96WxJ4KZo6c3
         3rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GYDJMejGJ4+oeD9ME4oTISMMc6WgIG94ApS0mBPJyVI=;
        b=cIPycUI+5tH+3qaYPScSutOyYrHMqj9dM5Ggfqs2svg3TVErKimO4Df27Oda1EmrQI
         svjqQDFcRDH7cDuq6UsK/09Gjm4M9XARh8RP+0LVHseYKDrapskCv2OXHt9qPN68bdXj
         v6b6jHrmj0z6vHatMGdrhqLcr4yVaiOWztta9jkLZBlTGRWbRK5aKrnEChZBmLSO+Rtn
         kEYlzxRLYLPEVvUNteN9cvgeQHRYE2DE24+gn7Z92fl4w2L3wiGsviOKaQH92H7V9qcz
         M789EPBJvVh9P0ks/qHBsR//nXT0GV0tU+40kQjYiQhy4nHwSZ+HFw9fmNdilr2tzXjw
         h80w==
X-Gm-Message-State: AOAM532eObLNACuciV27klhCx7J8MCMKEC5wJ9LaZsWEp/gI7aySSmyL
        H+RvEmWE6e2Xh9ymUQEg+Yt72tCTGKE=
X-Google-Smtp-Source: ABdhPJx7tng5Kk5kcngiX1NGDdt7DlWbFtbktazsg6VmE92t7YN39c33SsYC4XD+yc3ET7Iu9sPjOQ==
X-Received: by 2002:a9d:6ace:: with SMTP id m14mr22138031otq.207.1622570910791;
        Tue, 01 Jun 2021 11:08:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x65sm3875439otb.59.2021.06.01.11.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 11:08:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtl8822ce no bluetooh at all
To:     Alfonso <alfonso@el-magnifico.org>, linux-wireless@vger.kernel.org
References: <6d9bc41f-cdfc-2ee5-22ff-72510e084dac@el-magnifico.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
Date:   Tue, 1 Jun 2021 13:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6d9bc41f-cdfc-2ee5-22ff-72510e084dac@el-magnifico.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/21 11:41 AM, Alfonso wrote:
> Hi!
> 
> I have been fighting with this HP 250 G7 laptop for weeks, with no luck.
> 
> It spors a combo wifi/bluetooth rtl8822ce 
> (https://linux-hardware.org/?id=pci:10ec-c822-103c-85f7&page=3#status)
> 
> Wireless works fine, but bluetooth is not detected, no hcix devices comes up, 
> and obviously bluetooth utilities (hciconfig, rfkill) do not work.
> 
> I have tested half a dozen of kernels (from 5.8.19 to 5.12.8 and some patched 
> alternatives), and alternative modules like https://github.com/lwfinger/rtw88. A 
> friend with the same laptop tried to apply a patch (for archlinux)
> 
> I'm attaching the file "dmesg-hp-250-g7.txt", which contains the output of a 
> dmesg after booting a 5.10.0 kernel (backported to Debian 10) with the lwfinger 
> modules loaded, but the result is pretty the same with any other kernel or 
> module. I am also attaching the result of lsmod and lspci.
> 
> Am I missing something? Can I add some more debug info to help with a diagnose?
> 
> Thanks in advance for any solution or clue.

Your dmesg and lsmod outputs do not show a BT driver loading. It is a separate 
device from the wifi unit.

Please reply with the output of 'lsusb'.

Larry

