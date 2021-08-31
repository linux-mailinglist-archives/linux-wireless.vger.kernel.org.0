Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD183FC732
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhHaMTH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhHaMTG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 08:19:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A39C061760
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 05:18:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d2so14360199qto.6
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Tu4+uxp4XyX6aEhdHL/PmBEnSH2qrVBxKdrE8vdWq/o=;
        b=xK+DfoI9N93Yh6XrQT8RzbaSazNDgeIEY2V59Sm0StmIQ6wo4l+OfOJtAdCjXV+uCa
         kDqe3tmZi/EeyD9ZAvEhb0OUAGRe6jQkD79LsyqV+ZBnHojErQckiKe2ztJvLSLTA/aE
         MufAaQIR3Fb5UggnHfIyWEGqDrQ/vQbO6lGNIlDy6LN7LG6RdlkRQfdt0ImO41W3kcpT
         M4IjCsWN1kBVyrn/q/NswcIJUX9HVbgTYyWut6J/8DPJrRJ8GJCqbqpQnLEWqiLZ8SoL
         Uoi7FvyMlJtbvN8PI9CxQIgb1jkVxBQngEeu1aJHbmijZZ+i9NUJVyYQ4Ob8L0SC1gyO
         V4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Tu4+uxp4XyX6aEhdHL/PmBEnSH2qrVBxKdrE8vdWq/o=;
        b=Q8vvR4jPEH7pwZGcpr73+mbGAEuzcqSWpXswayElvC/qWKwEiQvYuxP3gGHIl8DxMa
         /C2JpbAw77x1UEERoSz4zWeA23DQuJaikxpMHrXuyByseBwo1yuRpCZ/fAOCbb6xsEdb
         jlJeBVn1kXKhEFi1MgOouU0SVT+V5zsqmnmn/t02Vkpgyytm0pruY3m0AEbJkYniwtFg
         sSHn5rqr0lWMCuYYhHUW22CduLDGQ67ywDlpRldlC/96gsxR0NPQk0rGDeJTFEvNJPbI
         6bXQsTZ8iv4xjCz3apVe9soOz1MgqiHCQyQyeEeHtdtU5QCKzzgEd1dtzMESEWVfRZ2r
         fL2g==
X-Gm-Message-State: AOAM530Vt5IQm9tZhapcoA8JB+LmAmw+1rkBBgXVNT3dY3FomX/ut3b+
        yemSqh3bF9t0crppebjOOfqGk9pot9G9ew==
X-Google-Smtp-Source: ABdhPJxr3llu+9b2eKzBDY/xfPMRJ0ZbGzZ7C6K2RqOfFd67Bnw2BlSLl/LjjUfJdI2KBswVm1iv9g==
X-Received: by 2002:a05:622a:1908:: with SMTP id w8mr2407784qtc.269.1630412290585;
        Tue, 31 Aug 2021 05:18:10 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-47.dsl.bell.ca. [184.148.47.47])
        by smtp.googlemail.com with ESMTPSA id p1sm13822151qkh.115.2021.08.31.05.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 05:18:10 -0700 (PDT)
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Netdevconf 0x15 slides and papers up
To:     people <people@netdevconf.org>
Cc:     lwn@lwn.net, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        lartc@vger.kernel.org
Message-ID: <12a6899a-3d65-86c9-8610-c1b171d45cb6@mojatatu.com>
Date:   Tue, 31 Aug 2021 08:18:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks,

We are pleased to announce that the videos for 0x15 are now up.

All the slides, papers and videos are now up. Visit:
https://www.netdevconf.info/0x15/accepted-sessions.html

The videos can be viewed directly on the 0x15 playlist here:
https://bit.ly/netdev-0x15

Unfortunately we couldnt capture within the videos the full
textual chat sessions that were ongoing during the session
(platform should have it next time we do this).
For access to the text, registered users can still login
into the airmeet platform and replay any session. The content
will stay up for another 11 months.

cheers,
jamal
