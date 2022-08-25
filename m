Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202B5A1ABB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiHYVCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiHYVBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 17:01:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F44A927A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 14:01:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q7so26126574lfu.5
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rMhaiuia9CmujPaYL9dJRVPvKvvGMSUMUutx6AkpMQw=;
        b=VC0VsqBm6hf9b/XYfHcXBRa0OTcZlYVj3/HjJfn5w7kxJoSsCAYi0wfVeVjxZ9h532
         FWlZn6cFyJIxqPtUckpqB7t1aCWeRGMXRa/FbtxDW8A0Bhqir02pfz65pCNcexH3HZVq
         Ybohht4H4Y0iCRmS+x4RMJcU5SiLFtKrYVrPBs4CQ8RLGtvKbt5Jh9HYHDprldzOnTjW
         PtcEWBK4Z9cBjXZPf4ySpuKtbH1jzDeqDsVmIVpuqXg/gUs/z8qqgKXkKGtdT1fx+fNM
         s9kJABGGCrHoGqO5i6Qgnz/n7JT4ypUjDw/1yzlUjvJ99XvjSOcGUckDJy5GiOnE7s+e
         5ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rMhaiuia9CmujPaYL9dJRVPvKvvGMSUMUutx6AkpMQw=;
        b=qTsxwqNxy0K6/BxhPORukNvrHnyLEUo6GbyLcL4JF5hFsMPDTO0YZtw3B3myoVPQuN
         vP9bE1us3X3AtdiC87wbLygwUpgiXoDSV/9SqkJ+Ad2nBtTvFKp2KqTgqFWVPNDi8Sry
         QbbCcAU3OPI5FvmxWMlfErLT8625BgSsjRD6dtSjnHbzbrXSraTWBHKNnhT4UpmMOzfj
         +D6VRPxF0TU1Kz/2NI1PiobL1ov9YkKChGGNF+bOQVDqQ5J1Ln4Zp0xBbjCtOlbjmWrf
         E8J2NRhulpOAHhm1k7LV8SwhCrmp9CcAgiImCs/a9+Uw1ki/6rapn98Y2Zj/tQ5iKeee
         GgNQ==
X-Gm-Message-State: ACgBeo1rNdLEJdV5XEKeqc+/dhs/CdtbuJ5b/XbTroHFRAHSWC1hwXXB
        aO10IbaXI7xNEKmNctPGtWc=
X-Google-Smtp-Source: AA6agR7NrWMq1nTl/P3ubkLCxRkmdp6ndW+rPAU8dNYG4VEu1Aj07c5m3A15cTGzLM7Eps0c0fI0jg==
X-Received: by 2002:a05:6512:4004:b0:492:c4f2:9451 with SMTP id br4-20020a056512400400b00492c4f29451mr1531844lfb.666.1661461300801;
        Thu, 25 Aug 2022 14:01:40 -0700 (PDT)
Received: from ?IPV6:2a02:2168:88a0:5e00:a4c7:4ba3:4116:3? ([2a02:2168:88a0:5e00:a4c7:4ba3:4116:3])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05651c0b9a00b00261cc85c32fsm87243ljb.31.2022.08.25.14.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:01:40 -0700 (PDT)
Message-ID: <ccdb8f94-0879-2c06-5b48-25c2340d1659@gmail.com>
Date:   Fri, 26 Aug 2022 00:01:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
 <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
 <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
 <7e00cc36-3a07-92e2-c60e-a3c8939b407e@amd.com>
Content-Language: en-US
From:   Mark Herbert <mark.herbert42@gmail.com>
In-Reply-To: <7e00cc36-3a07-92e2-c60e-a3c8939b407e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
>> The changes that I have posted will not work on other targets like 
>> WCN6855 as is. It requires additional changes and therefore lots of 
>> testing.
>

Will the changes be possible for QCA6390 as well?  Currently this chip 
only activates power saving mode when it is connected, but behaves badly 
when not associated to any network. So there is a chance that this kind 
of solution will help.

