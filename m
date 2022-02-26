Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9A4C56DC
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiBZQkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 11:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBZQkB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 11:40:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978672836B4
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 08:39:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i11so11507121eda.9
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eH77j8raadPVaGeR/XTLM6vHmIwKR9OlXjwbpcvIVEQ=;
        b=pqhtPA2ZEz+dhnL8Iw7rpagboZsjLyg+R0N791bjIzzO8EsFzOT5Kvj9+lfsumSbY1
         Pg+besS4B1pzKHAgkCopfJMCPyqa84pRmDMMmE+H4MLkKuGE9MxPvOXnLoS2wnjne2A+
         7tNHtX7oJ/e+pEsMniQN3YJXZY55DFQntxK4pTWPgy1pjCUZkQ6qVhUD1JdgmuukaDI0
         WIbBhJM+O9y2t+DpdPrwRx0OYWFx4ZAfezUPdX/BF5ii7LRC7rfEa0LuSo8eiDvMCqmI
         6D+2dVeaLu/z/qIKFtJg6X7XXiSOi8OXeCDB6txh1UuK5dcsu9eFeG6yHVk0UvSq2w+j
         b12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eH77j8raadPVaGeR/XTLM6vHmIwKR9OlXjwbpcvIVEQ=;
        b=1Z05+O/iI74sPsgFzOwAaF50iO2HMgLx+YWVLkREs3GQYoPdSANossnmfTuoI611g0
         MVItcd6GeN0q88b9ofblzAtryiuBMXOLRT/q0uFVn94dXwB0wnbHv2jSrei6w6+bNd0T
         PHFI8xaExxdZqguGWF5rGxOHfDw1oA9kdkm+kRaNPimSg8iCFPF22jflcgb44LvN5Oeq
         xUS7BQbxgqDY/52AfwMghcrGENKcHfAViP/Wp1DoWxuSU92xZbpweTEVQnE9wax7lmvI
         niAOMa9QnR/QhJhnKCfurIc9MQfEc9FiurnO/CcCC3h3jiURE6YFYodC9k0APUP6zWlD
         pEBQ==
X-Gm-Message-State: AOAM530xg7e6aJz2noSNBOjyX2yGDoG1zE0IdFfmox2jomeBoYCWwKW0
        eTmCLLoSYAhjyE1EHEAfn4o=
X-Google-Smtp-Source: ABdhPJz+CyhmDrTOWZ1uH2qhHIWWO+6Z6qo5z7Swx3UcTpFuHmaS6sdtpGiWVwzCQDNJCdQzUiyvdQ==
X-Received: by 2002:aa7:d591:0:b0:411:6c4f:1725 with SMTP id r17-20020aa7d591000000b004116c4f1725mr12014177edq.342.1645893565007;
        Sat, 26 Feb 2022 08:39:25 -0800 (PST)
Received: from debian64.daheim (pd9e29a04.dip0.t-ipconnect.de. [217.226.154.4])
        by smtp.gmail.com with ESMTPSA id n23-20020a509357000000b00412b325b05fsm3003164eda.74.2022.02.26.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 08:39:24 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nNz9I-0007KG-Mr;
        Sat, 26 Feb 2022 17:39:23 +0100
Message-ID: <fa37099b-4d5b-7265-888c-fae3f48f6e9a@gmail.com>
Date:   Sat, 26 Feb 2022 17:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/5] ath10k: QCA4019 hw1.0: update board-2.bin
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        ath10k@lists.infradead.org,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>
References: <2ce6ca92f529aca13984db205ed38fa0fa6d436f.1645645875.git.chunkeey@gmail.com>
 <CA+5PVA5hPn9QDkmwJE3E7NU3hv08t416DfLvxeJFJCxWSzSCDg@mail.gmail.com>
 <87sfs5squm.fsf@kernel.org>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <87sfs5squm.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 26/02/2022 14:24, Kalle Valo wrote:
> Josh Boyer <jwboyer@kernel.org> writes:
> 
>> On Wed, Feb 23, 2022 at 2:53 PM Christian Lamparter <chunkeey@gmail.com> wrote:
>>>
>>> syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
>>> <https://github.com/kvalo/ath10k-firmware/tree/master/QCA4019/hw1.0>
>>>
>>> Includes the following changes:
>>> 93591ce ath10k-firmware: QCA4019 hw1.0: Add ZTE MF286D specific BDFs
>>> [...]
>>> f305604 ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A62 specific BDFs
>>>
>>> Cc: Kalle Valo <kvalo@qca.qualcomm.com>
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>
>> Forgive me, but I have to ask.  Kalle, is there a reason you aren't
>> sending these or including a Signed-off-by?
> 
> I have not sent any new pull requests to linux-firmware while we are
> trying to sort out the notice.txt problem discussed in the other thread:
> 
> https://lore.kernel.org/all/CA+5PVA4WEuJDB3OCKfYK-BPaccpVWd9t_au9S7MCEtpy7cdF-A@mail.gmail.com/
> 
> My plan was to send ath10k and ath11k updates once we find a solution
> for the notice files. I'm guessing Christian wanted to get these board
> files to linux-firmware quickly and decided to submit them directly, I
> was not involved with that at all.
> 
Thank you for telling me about the notice.txt issue. No, I wasn't aware
of that happening.

My reason for creating the patches is that OpenWrt (www.openwrt.org)
is moving forward with the next 22.xx release. OpenWrt pulls firmware
and boarddata mostly from linux-firmware.git - so having those
up-to-date in time for the upcoming release is all around a "good thing".

(OpenWrt uses the monthly linux-firmware.git releases, so there's an
extra delay to account for.)

The current situation is: OpenWrt has those board files (as ~40 separate
files) all lined up in:
<https://github.com/openwrt/openwrt/tree/master/package/firmware/ipq-wifi>
Once the board-2.bin in linux-firmware.git is updated and a new release is
made, those files can simply be deleted.)

Cheers,
Christian
