Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6592C4E575A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiCWRXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiCWRXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 13:23:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A4A7CB22
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 10:22:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7040524pjb.5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Vcs/ijmM+IYtFvRxEnf7jKzIhxJi8SzEvbU3lDOat44=;
        b=kYrI/ns4ocHbwGR8sPCY3GF2uKSRUMIDNXZHiv2x2s8Ir/8A+gi/C+zdSgtFYvnMme
         i5FXhdwsyX7uPG2544bS34TPM7fNzf0fW9vefEk3Dyrz6bHVqzeVwUZqWfIKtYde5+7U
         1bE7cb4skl6axuKP5JcvkmeA6N7UDLQk3P3jmYE9wJZd6NoI42oMUcyzvnqAytqSQbhZ
         GuKyXOsWqjgSkbxX9rio3XMKobBcvdCwFIzblWHjWkiy1idcoEi4jWuD9nv+u96hiMXE
         cGOZpLqO63k1LOxstYqr4letaqEZbOt+cJwWHrkMWv7FBCqBY7onPXyWtSyXdSq4NT/z
         03cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Vcs/ijmM+IYtFvRxEnf7jKzIhxJi8SzEvbU3lDOat44=;
        b=61rz9oBZBxD056pOIXbghFIZhCHtXGo+54xuWN5wqGdHMdk3K6Rlzi/XUBovmAgWz2
         8h9mS8rXuhyKEOwdtiyPzHcP/iROU5wHqboIWcZuxxdDgnGgGVqW1yNooQXZAA875suc
         JSvBmOgKZ6GPLHL1tK6ZLiH6ynoP0nTX2R7/CjxVOAaPrwlunn49QWP61yy8TaWUCle9
         10NP4qq4f1+nWbFNIFCDGbDWahMiME3HMXF1IRxH7n3YoWxXNHDjBxwy7iZaaIMXZpRn
         4x6jClcNYPh/3SE0JLHmjFcJmE/YwpgGSmJllNRrBmLOyyDpupzRpAQIZ1XzvkLfxmC3
         3gYA==
X-Gm-Message-State: AOAM530/UVFUdooVpURg59cZ6by/n717mCZ9WRmYTWQp4N2exypONtOr
        k0uQvo/AWwZacCbCuvfOd1STtqLS3Wo=
X-Google-Smtp-Source: ABdhPJwryMq2E6OAnaqTO7P633o5ddWO8oqxNj7Q9x953gTYMt6utoMde7rZ6FieAekESoDF+101rA==
X-Received: by 2002:a17:90b:38cf:b0:1bf:42ee:6fa with SMTP id nn15-20020a17090b38cf00b001bf42ee06famr12887365pjb.9.1648056130662;
        Wed, 23 Mar 2022 10:22:10 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a071700b001c67a95e7fbsm288522pjl.47.2022.03.23.10.22.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:22:10 -0700 (PDT)
Message-ID: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
Subject: poor beacon/scan reliability with mac80211_hwsim
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 10:22:09 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We use mac80211_hwsim and our own 'hwsim' daemon to test conditions
like poor signal strength or dropped frames. For quite a while we've
noticed very poor reliability related to scanning when
HWSIM_CMD_REGISTER is used to process frames. Scan results are just
empty.

We've put in some work arounds like only registering for tests that
absolutely need it and repeatedly scanning until the expected network
is found, but there are cases where this is not possible.

I'm hoping for some ideas on how to actually fix this problem rather
than continue trying to come up with workarounds. I have tried removing
any frame processing (just an empty function) and noticed the problem
still occurs, basically just calling HWSIM_CMD_REGISTER causes these
problems.

I will admit this seems to happen more on slower systems, like inside a
virtual machine environment, or in tests which create more than just a
few radios (like ~5-6+) so it does seem like mac80211_hwsim/wmediumd
processing the frame is just taking too long for beacons.

Thanks,
James

