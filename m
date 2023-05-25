Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70099711049
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjEYQDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjEYQDG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 12:03:06 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5C1AC
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:02:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19a3a8784c3so847463fac.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030576; x=1687622576;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RJjitsWH1jb4I7x2jWyH3odaiBPiXidgRhwFsENkWFE=;
        b=QIf0lrc/oA5KojOj5F2NJ9VlEM9S+YccxLNSH5TgWo3LO9kMsf5BT7r1gBcm1+kc7A
         1NtvKTHulJCde6WYmuPj9tts/tFuoqfHNfDApmYQSKeJKZcqhCOxAGs5Qr27nh/Fe2PG
         gC0bGOFNdpBx+8yv8f3ofAjRvravEk6giu/oHv1BA1JwAZIm7hCekJXt9+izAiLprt1o
         WFKVoECuT0M1j9iuoptQIFut6dmZaVTYt8L8u62K99x9rkPPIrZcGElvH8Pw61qEYANX
         KNuGeEEg7c2xv6E4qXQgLT1tDOxdf8e4FdoZLJDXdVd4efS9p5ZGXuZGvLPe4QnIKs3I
         t4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030576; x=1687622576;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJjitsWH1jb4I7x2jWyH3odaiBPiXidgRhwFsENkWFE=;
        b=PJzWQuva38OB6lhiezKVB3THWJEsWQkE1jQSywRi2JCXv+zHvCkx33bGn9uS8BSpaJ
         5g/aOhbhcuVm5ql7sJemPoOzHHOQ3b+cob5Xmws5l3ncPOnHAX47yKr9vwDwAe1AoXk0
         Rv1XLeAFaOHuqGQWBABQHHJpS3FdohWReKvcyttDkxwTboeWU516M2cFUetUcHIvXRKX
         +Jvgta9eyxCXIJg50cl7bWSo6EkxQy1ezqgmMA6rlhgliCUsOn+g3tF4M5bRvtrTe0CW
         KwpMDtsPnqZic6a+Hw6uA/v9C75qTbl2Y3LT4Xq8LETSpUVuPtcE6wf+n9UBFCYcDuXb
         DgGg==
X-Gm-Message-State: AC+VfDy6KgM2kkUK3w4GdLMLB8BZ9e4k18SpXpm0RvhIz4hp7gia1Qai
        DQfwSt1ImKNqqcmirSLQfanq9++wQNw=
X-Google-Smtp-Source: ACHHUZ5B6i1irUZyuwAMTN/BFZxgReVpAPKKIy5xB3gDmZ88MQ9QfTdArskflixGbC0S66s1qFsgKQ==
X-Received: by 2002:a05:6870:c382:b0:19d:732:1c32 with SMTP id g2-20020a056870c38200b0019d07321c32mr2156324oao.8.1685030576439;
        Thu, 25 May 2023 09:02:56 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ea23-20020a056870071700b0019eee680504sm455928oab.0.2023.05.25.09.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:02:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
Date:   Thu, 25 May 2023 11:02:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Question about power save
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

Johannes,

One of the users of an rtw8821ce found an increase of power usage from 272 mW in 
kernel 5.19.13 to 579 mW in kernel 6.2.8. If he reverted commit 28977e790b5d 
("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS"), the 
original power usage is restored.

This patch says:

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 52a41416b8bb..e5c058db451d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1787,7 +1787,8 @@ void ieee80211_recalc_ps(struct ieee80211_local *local)
         int count = 0;
         int timeout;

-       if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS)) {
+       if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS) ||
+           ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS)) {
                 local->ps_sdata = NULL;
                 return;
         }

The driver in question has both SUPPORTS_PS and SUPPORTS_DYNAMIC_PS set, thus 
this patch enables the dependent part of this test. Is this what was intended? 
If so, then rtw88 is not supporting DYNAMIC_PS correctly.

Thanks,

Larry

