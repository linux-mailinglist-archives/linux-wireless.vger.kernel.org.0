Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8665EE0D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjAEN7w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 08:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjAEN7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 08:59:33 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31EC15F31
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 05:57:29 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b12so24551615pgj.6
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jan 2023 05:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnPTTZBQxeUaGmr3kM8/hj78PXm2U95GjDvhf9qEzdc=;
        b=k6UgecyzrnaDlQF/U4Ucqwk1+n4vLnnF4AZjImX0LDU6yQbCVJj6awiwpR2ltrPq96
         +IQzBk54n1W5NuxTbtemdMKp/yHKJBAv2/VwlRAStqJSWeQD94x66ISdoOi2BsPta/9P
         L/328kqldOx2gxZB2Yj1VjXHzmQ0sAO+4eoUOBxwzXsDcGY3Z74FxqgR1sC8XvR3wiHu
         okDfMKQbBX7lC2auQdXsem/ea6VRhtSZaAKLqKAoFQvIXu0U70Bo99JX48GvC2G7IXL5
         znfC+9pIBYF44TLzWiwcZOjOZxO02yFFePZ2Jq64TN6JgRXexk2KkEfyTq+t4NxCIpRL
         2isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnPTTZBQxeUaGmr3kM8/hj78PXm2U95GjDvhf9qEzdc=;
        b=Lbi0CIWYa5awQCUKlMjwV+JnWMRS09bds8Wl82IvjwYlvH3qaai4phPWKw7oZzFTsS
         oh74lVVrHFDgFGrk/ZRtfOnpYpGDl+awEkVZNtSAZ9cZ1v3qRojBBU3x/mgFgJyJQ9qq
         /UVhb4eHYsa8D15UIcK6flUEywHgPAL1300kl1sROF7C3TntuguupXtwKmKrlaNJsSZz
         uVfSv1c+qeTzwJiYniwiA4i3TYjN/k6RXckcL3r0L3FgpjWfsxfv5S/V0ZuA9Z3IhaSw
         VihOpSdlvYCSO/zQFRpqp6E6X/ZoWVl1ahSDtaudVNnYRM0FjtZOsr1U47/w5epppBA3
         2VzQ==
X-Gm-Message-State: AFqh2ko6Hx2VcIwhuz064rqot8afGg/N1dy4sk3izCEuOP9g/w+lpWjt
        aO2G4kRJL949Tp3pi7OUAXfdSA==
X-Google-Smtp-Source: AMrXdXtscTc883URlpW45mC1YQ7zXRZBVh/czHCs5ScfTjmicT7ACG8h7+KhxgKs6LOTGl8aM30nNQ==
X-Received: by 2002:aa7:8284:0:b0:580:e549:559e with SMTP id s4-20020aa78284000000b00580e549559emr37040352pfm.17.1672927049337;
        Thu, 05 Jan 2023 05:57:29 -0800 (PST)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u4-20020a62d444000000b005809542aaf3sm23296669pfl.135.2023.01.05.05.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:57:28 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:57:26 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     stf_xl@wp.pl, helmut.schaa@googlemail.com, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] wifi: rt2x00: Remove useless else if
Message-ID: <Y7bXRivrmsVq6nUW@nanopsycho>
References: <20230105085802.30905-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105085802.30905-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thu, Jan 05, 2023 at 09:58:02AM CET, jiapeng.chong@linux.alibaba.com wrote:
>The assignment of the else and else if branches is the same, so the else
>if here is redundant, so we remove it and add a comment to make the code
>here readable.
>
>./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:8927:9-11: WARNING: possible condition with no effect (if == else).
>
>Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3631
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>index 12b700c7b9c3..36b9cd4dd138 100644
>--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>@@ -8924,9 +8924,7 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> 
> 				if (i < 2 && (bbptemp & 0x800000))
> 					result = (bbptemp & 0xffffff) - 0x1000000;
>-				else if (i == 4)
>-					result = bbptemp;
>-				else
>+				else /* This branch contains if(i==4) */

I don't see how this comment is useful. Better to remove. One way or
another:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>



> 					result = bbptemp;
> 
> 				if (i == 0)
>-- 
>2.20.1.7.g153144c
>
