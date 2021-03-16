Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA31E33D4C2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhCPNWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 09:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhCPNVp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 09:21:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4FC06174A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 06:21:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id by2so9465266qvb.11
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qUY/TfKraaa410J/01mW1vUlGGBXwjKSrYhZht8zlAA=;
        b=yw+X+C6vkoqwlHwhxjMgBf9KG3NoGX+8Dg4C2OL3gAXF1UIEjOc3D+BvnTThWyCRU5
         Kg4RLs+6YIVP/HHu2WDwfXAIa+2/RzsGoIwCbE4WL2XnprDB1SjDaAH9fMNxZhm/oRDM
         1a5KzP0q8gPFiNJN/MGDH4jK04reykJ1vmqwSG1Y7Q8Pbf8/KjmOIXmHUU0wa+t5/7CH
         rdLcdLXMp7YZR7QCBGQs6wRrvsoNqnM2d3siMFbMXwfXESqTKMy1Y+8P84G2/PfgnD6N
         PC6A6naHiUxGH2n8QekvzUHJ1ZGGCKXbiOBHxX5axYEeCTA7bc192/TebMYD4M9I7ZbL
         +sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qUY/TfKraaa410J/01mW1vUlGGBXwjKSrYhZht8zlAA=;
        b=YvshtzepweMekZ+Di/OqJtNN/ebwMk9ky3ixloIIs9Wq9XKPtdqNCoOTAxBSKb+rfV
         8jJ5Ketb3FfBYwfyTMhyIcyLciYHIiI0TO4pTCqipQjTpu64u74MNZc5bi0FVuLnjCqv
         0KP38GOBb/ePPQITGPqIiXiSh0S2QovRTDnQI8k1NYlQcjB+P1XsipbbQ3xjRY4hPcA0
         KpBSfBhCxHcW3JXaqznZ/kt7HCbqV0lGtUx91sbEP+oKQuwK8t50itR6LNyv0QS8vJtI
         TFZkfMaSEvw0gazJHNmTrYWD1PAZOLF3iZw9rqCqY7MzA4bfKT/A+/bQOXiXQizKkE0c
         lqMA==
X-Gm-Message-State: AOAM532aPDQ7xmEgHWCBpM6ELJ2Cxs51vJ81TRWLQ7s4mQBZIDn3DUtu
        vTFHngzjoMXJ1RmOp+Gy7mY4rg==
X-Google-Smtp-Source: ABdhPJwDg0g1aytukRTywSBP5WM37yZV5X9yIDwSwdHyQkKG86wc8C7nrSMBdAYPPOfm5oy6rOOlQA==
X-Received: by 2002:ad4:5bad:: with SMTP id 13mr15656973qvq.20.1615900900140;
        Tue, 16 Mar 2021 06:21:40 -0700 (PDT)
Received: from [192.168.2.61] (bras-base-kntaon1617w-grc-09-184-148-53-47.dsl.bell.ca. [184.148.53.47])
        by smtp.googlemail.com with ESMTPSA id 18sm15626140qkr.90.2021.03.16.06.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 06:21:39 -0700 (PDT)
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: CFS for Netdev 0x15 open!
To:     people <people@netdevconf.org>, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>, lwn@lwn.net
Message-ID: <9ca7fbab-16f0-2e7b-a8cb-1fa834264d9a@mojatatu.com>
Date:   Tue, 16 Mar 2021 09:21:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are pleased to announce the opening of Call For
Submissions(CFS) for Netdev 0x15.

For overview of topics, submissions and requirements
please visit:
https://netdevconf.info/0x15/submit-proposal.html

For all submitted sessions, we employ a double blind
review process carried out by the Program Committee.
Please refer to:
https://www.netdevconf.info/0x15/pc_review.html

Important dates:

June 10th, 2021 CFS closes
June 15th, 2021 Acceptance Notifications complete
July 15th, 2021 Slides and papers for talks are due.
July 15th, Recordings start !!!

For more frequent updates subscribe to the mailing
list people@netdevconf.info or see us at the twitters
as @netdev01

cheers,
jamal  (on behalf of the Netdev Society)
