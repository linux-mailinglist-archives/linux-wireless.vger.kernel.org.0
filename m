Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A96B785C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMNDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCMNDQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:03:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DBA1A956
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:03:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd5so14514654edb.7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678712593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY9evwOvsADmwwAiDp2Ryr8omhytshbZxK2CzSV4wZE=;
        b=IXE43z21nDg+78YWl9xY2aQQqehyOyg5olYBSi+p0jw30soNqpIdLuyTcQC1teWc2p
         coFYfE15+fP8k0IkcSF661Jatk/PzET6qfbnbDM8vp2I0dKWBX9YSsifuXNd2nmWpVKJ
         PDSC62cVB1F3Ajuk2+7B8+k8FxkR8olQhODPURvJP7vFjzhShzp0D9KdJWiGQ3gbD7VS
         Q48XGhMCwx6UC0w3yf/Jw9LZ2/lCp+9xP2WaeR+1KDMstt555iGXCVhboJHOUwBSi4OT
         HhjK6z58B0eHPMYVMUrRJAePjhKMNXAkv+IyMQK3l7/ri2C2YoN4Hp8a0PsVD6BTKBa4
         PRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY9evwOvsADmwwAiDp2Ryr8omhytshbZxK2CzSV4wZE=;
        b=1t+672ZY9N/LdJMm/IrpscBz1A3PJUJAIV+FCxOBWPDBys6Xd3wATCAIlsUTiqGxal
         iS//ghocpG6GE1Y3yTglwJ6va2i3+RYfkr1vA05BpjuqiplC0CeS1ppYtJtNW804Avmx
         lBg6QwSBc+aIwYOC6qnPiWGqWhvcNXqFvbP51L5CQASc1nyxuu0Ti5Xw8W0nJ20tI+lo
         kmIYSN40yBSDIijv8eedsWyqUjUWrev7MfXCScO3bw/d3bJNOPFndj8m0A2FyzsBtQab
         CCoQ5YnAP6FemK7BA7ttIWq3QDwN8WXuwfoXlJIQM61ctROoTCJse7Khwdy4O2UPaE+Z
         fdOA==
X-Gm-Message-State: AO0yUKXdQSjAPPGSH9f5sKU+QeX7qJjQp6VAwcXsMX+CTLKiDYe3BsRa
        s9blutev+IrKRhqoyPRKC5gSxw==
X-Google-Smtp-Source: AK7set9EBjX2TmkEuEGP2Gjj4VkpdT7PElW4/9KL6ZLEmEZQVkTxr2fmWoAMambTT7Y/r9d/ZBeN7g==
X-Received: by 2002:a17:907:a688:b0:921:5e7b:1c27 with SMTP id vv8-20020a170907a68800b009215e7b1c27mr8160171ejc.24.1678712593629;
        Mon, 13 Mar 2023 06:03:13 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bb7-20020a1709070a0700b0092b74223806sm649326ejc.209.2023.03.13.06.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:03:13 -0700 (PDT)
Message-ID: <7b08d514-1cfa-4674-2b2a-cffd1f8994a5@tessares.net>
Date:   Mon, 13 Mar 2023 14:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: pull-request: wireless-2023-03-10: manual merge
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230310114647.35422-1-johannes@sipsolutions.net>
 <be8f3f53-e1aa-1983-e8fb-9eb55c929da5@tessares.net>
 <27fdfff6029bc3b8c9ee822a16596e2bac658359.camel@sipsolutions.net>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <27fdfff6029bc3b8c9ee822a16596e2bac658359.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 13/03/2023 10:13, Johannes Berg wrote:
> On Mon, 2023-03-13 at 09:04 +0100, Matthieu Baerts wrote:
>> FYI, we got a small conflict when merging -net in net-next in the MPTCP
>> tree due to this patch applied in -net:
>>
>>   b27f07c50a73 ("wifi: nl80211: fix puncturing bitmap policy")
>>
>> and this one from net-next:
>>
>>   cbbaf2bb829b ("wifi: nl80211: add a command to enable/disable HW
>> timestamping")
>>
> 
> Right, overlapping changes/additions.
> 
> I suspect there isn't much I can do about it at this point, other than
> merging wireless into wireless-next and then sending a pull request for
> that, but that seems a bit pointless?

I should probably update the text I send in case of conflicts, probably
inspired by the ones from Stephen: as you probably know or guess, the
best is to avoid conflicts. If it is not possible, it is good to add a
few words in the pull request to give instructions on how to fix them.

I don't think there is anything else you can do apart from confirming
the merge resolution looks good to you :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
