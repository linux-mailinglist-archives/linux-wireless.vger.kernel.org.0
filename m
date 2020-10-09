Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7374D288963
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbgJIMzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbgJIMzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 08:55:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4CC0613D5
        for <linux-wireless@vger.kernel.org>; Fri,  9 Oct 2020 05:55:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b69so10384603qkg.8
        for <linux-wireless@vger.kernel.org>; Fri, 09 Oct 2020 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gHpUJmDZonPV5j8bU/1gBGhpCio2vFsUWRF9qpU9vW8=;
        b=Lv+1KPQkmVCaxhltL1Bptxe2IohBZ8ELxZYbQe/XYjACfOACvHXKhaHyOm8IR0GUew
         wat8Nj2Kwua/hznueUu76ai46V0xbmWtGqGpay8TEGG3L6pIlpW4gQYKFpBSgfA2vS+z
         9E68uw+n3AT99JdnfW9e4IN0hpwEPbhb6qmGJF7AY1/4uooFoN8UYUvXXaX5eZ2StaXW
         jjPAsYOcCPkui18mRBdvgTk/w/ew74rkYLDr+A5UusbAblZBRZ4CENgT5jXB793qRjrl
         smtWElf1b/JVS6VPvhfcX7WOPh2LvFnmOYbXcdi65lLTWZdbuIXdoHxhBGNEmAIFgp4r
         OMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gHpUJmDZonPV5j8bU/1gBGhpCio2vFsUWRF9qpU9vW8=;
        b=brwaoHEtT3sAkDCBrBUwHjVMDmfxJ0hUWZ5yRKip1R7bYUG9fvNsMzPJeVg4yWgzW6
         ewylKOie+Yfb8uUA0IbOb75hPXgiicWNBMTrt/pJIuHuFrk0MtLbOSW22kFUbuRM+eHO
         nfC0bATlk/ca+pJgEzHkFp6E/93cOvXU68DUQujN3Bzdp+PydbUkl4Knbu60OhHBFeIa
         9W6Aow+16Jqcv1rsV6DwsANAXGM6CwywjtRbT82Blf9FRIxsOTy6TtLj4JA1KWS85Cib
         Xyo4DHE2eQQSNdEok0T3lQYUsUh7P2+15lxr8xYFNfNr+7eP1MbbHDFfr5fJPM1P8Sy3
         msOw==
X-Gm-Message-State: AOAM5319MHrXMwVLdKdwMy9VRAUNaVp7fPRpqAXzMERtVJVB9qzLfU2o
        Fd0942nN2OVvfQoBM3RCAKwYZA==
X-Google-Smtp-Source: ABdhPJyEXSEu+fLH6EcqCWM/nDKyRAe6bzO6Hgdk8YDlZ9eCtXjIZcw4aQ6Gim1mSBxKZLtFvn/A1w==
X-Received: by 2002:a37:c51:: with SMTP id 78mr13313885qkm.30.1602248144600;
        Fri, 09 Oct 2020 05:55:44 -0700 (PDT)
Received: from [192.168.2.28] (bras-base-kntaon1617w-grc-10-184-147-165-106.dsl.bell.ca. [184.147.165.106])
        by smtp.googlemail.com with ESMTPSA id d78sm5775681qke.83.2020.10.09.05.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:55:44 -0700 (PDT)
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: 0x14: Videos posted
To:     people <people@netdevconf.info>
Cc:     speakers-0x14@netdevconf.info, prog-committee-0x14@netdevconf.info,
        attendees-0x14@netdevconf.info,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, lwn@lwn.net,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Christie Geldart <christie@ambedia.com>,
        Kimberley Jeffries <kimberleyjeffries@gmail.com>
Message-ID: <95981c19-d157-0f13-ed3f-ce82b612e12c@mojatatu.com>
Date:   Fri, 9 Oct 2020 08:55:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


To everyone (PC, organizing committee, speakers, workshop chairs,
Tutors, sponsors, and attendees) - thank one more time
for making the conference the success it was!

The videos are now up.

The sessions page is at:
https://netdevconf.info/0x14/accepted-sessions.html

The videos can be viewed directly on the 0x14 playlist here:
https://bit.ly/2SHJWow

cheers,
jamal

PS: apologies if you receive this multiple times...
