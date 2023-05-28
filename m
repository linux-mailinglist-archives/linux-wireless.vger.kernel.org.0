Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB5713B56
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE1RnT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1RnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 13:43:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9508A0;
        Sun, 28 May 2023 10:43:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3943fdc59f9so1605560b6e.0;
        Sun, 28 May 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685295797; x=1687887797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AX5B3WOQq1rvcjtNA4/CCiTraahwaHBQG9yZxTuFtSA=;
        b=YvUFNKt3D0pgit6jIqLZtiimJrba2ifPny6RjXpK9R/ZEguBGTBfiXk2x9tZ2LQ9bH
         tznZ3u4IU8kO+zvpFe4hHA1GKwlYMiokf14sRYJ1YpXsdLf6o9BYa5yJVZsLq8B+uK7c
         h2v7r8HYnjUnHNLQ2Yt26Oz4CcQ3C9R4TQhzwyY3CfunQpR1Ey1+kXPBX4UpxwR0aJVm
         BvbPIAUaZA8QeBNVKw+GETjK1F/1OJ8HrTV4m9lu6COOXF1cY8fEB6hQlW9PLghdFIYF
         tj8of4mx+lNQ70iooIBszH1aJyq3bJHrD9xfnvqK+O9ddm2034Q+R02U/zwwI6sdKLBg
         3Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295797; x=1687887797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AX5B3WOQq1rvcjtNA4/CCiTraahwaHBQG9yZxTuFtSA=;
        b=EX90QLPjhKuixyo3lAgazZf1UJ1SCrJtx2u3bQvHPbG3dKZ7nlB5bOHwjbBpCH2wt+
         qHNDhcVO3vTt2PJbK/ijDx7LeitILYsIUquNUOE+hWiKD3Oqx0Pu/Oo2/7XdecpA1ws/
         2RbKw8buKGLAw9cUFscjNY24Kw+K7CXEabtEEz1EzufDgeW5l51ZSncZTRz4xiDznIBu
         8mb9wF7Qi2W5bDElp4ZNblEqqghWhyH9Hff1vKcJfgqKqAwlCRntKLYoVzjPO84XgiH8
         L6N5t6NyvZWEsKmyfRlqJBB/StUN68jkF7J8PdPeibuS5+S9dTcqnlfOa0nhLlixG4zq
         9WkQ==
X-Gm-Message-State: AC+VfDzOffK7x8kuYnoqML6vOC/xl7arn1wpWVmmcvlKMApLAcHLDjWX
        ZKHLna4ErYdpqBD/Dy3QPJOsc0r/B5b4oA==
X-Google-Smtp-Source: ACHHUZ4h6rm0678jjIEyBpe+/bgbJyCAFtPXY2WS6mDb+kCzK0Mt/eku+ltKcxmTKLKPbcJPxLPyWA==
X-Received: by 2002:a05:6808:54:b0:398:57ac:2412 with SMTP id v20-20020a056808005400b0039857ac2412mr3859053oic.50.1685295796684;
        Sun, 28 May 2023 10:43:16 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d3-20020a0568301b6300b006af99ac5832sm3845996ote.47.2023.05.28.10.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 10:43:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e89ad5e5-1ec9-4d0c-f33c-363169fae8a5@lwfinger.net>
Date:   Sun, 28 May 2023 12:43:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] wifi: rtw88/89: add PS calculation to repair PS mode
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org,
        tony0620emma@gmail.com
Cc:     stable@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20230527082939.11206-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230527082939.11206-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/27/23 03:29, Ping-Ke Shih wrote:
> The commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
> introduced by kernel 5.20 will skip to recalculate IEEE80211_CONF_PS
> of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.
> 
> Since this problem was happened since 5.20, patches 1/3 and 2/3 should be
> applied to kernel 6.1+.
> 
> Patch 3/3 is to remove redundant/unnecessary check, so this can be seen as
> an independent patch that can go either wireless or wireless-next tree.
> Note, I can't combine this into patch 2/3, because this redundant check
> is introduced by upcoming kernel 6.4, but patch 2/3 would go kernel 6.1+.
> 
> Ping-Ke Shih (3):
>    wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
>    wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
>    wifi: rtw89: remove redundant check of entering LPS

The patch for rtw88 has been added to the GitHub repo, and fixed the issue. [1]

Thanks Ping-Ke,

Larry

[1] https://github.com/lwfinger/rtw88/issues/129


