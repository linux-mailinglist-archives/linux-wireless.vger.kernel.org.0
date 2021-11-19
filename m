Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309F54566E1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhKSATQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 19:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhKSATQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 19:19:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74498C061574
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:16:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np3so6516994pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=iuwwnMA6cvubz8EdCrjzJ01VvI9NjV+RtDHQRMkl53Y=;
        b=bDb//A0ik1zLvtAiU0sjYAJKOsaUxjZcJfhfoCEbMo87rYNaCHx3ZnWof4+3TGNC2c
         rMBYOGz4HFtkXz4Jd1wAv2/VinXKC0Q0Q+PlxR6v3JjuunLQJnHKwWhc7rs5VcaZ5hqh
         YxtlVlcZD7Ghkm/krPFnQYcpPvdrl29jg4RNpqII+c/OSA5UNwG+De8WZ82tfyRppV6I
         dz1b9xJZBixcMHOkIhHA81qU4rXkbalO53eC4mkUuE5cXGybLc2xvthA0Af+KWuEi1A0
         FuqYsNQiwjGTF/a8DZWJfbnshYRSl9aRxG/7uex8xNUCN9gjVBKbld4TQh7Hkb+IEQNR
         HKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=iuwwnMA6cvubz8EdCrjzJ01VvI9NjV+RtDHQRMkl53Y=;
        b=UHevO29DdxnOABBddYbWJ8zWTo5/c6UoEI1ii5CO0tF3XoU0rg6zR4m3q4PWAlpv2r
         KwainweON1ZYYcXU8vUYqTBq2j6v3AqQB3/g9xViXR57x2Sz1mqAx2KXQju8AiGEgFRT
         TwaezWQo+4hnzQuEbq0tNt3DW8W01xCC62IPIrW3dhN1TicPdSxBKV0CHva6fyCK+Svy
         fX9uUbFV27+SUULGAWa1sENo1ZqO+RLpJI7OjAi7Xgq0ONlE7zaMqA4owMcSMd9zLNa4
         Q7CM3lmAMunx8WmN73Y4/+D2SKZEwLm/I4nIK1siq+8bE6GHjhSFRFDiZShogX2EplGc
         rHvw==
X-Gm-Message-State: AOAM532lu+8NgLX6H1/vWabmFf5qc/aMdOvxe+5wceILoE2qT0Gu8smv
        quO18lsZ3uATJYR1VP16MZV/irS2ZAo=
X-Google-Smtp-Source: ABdhPJyZdgbQ1QlXhSezWUHvAps+S+x8CrXmAIy5UE8jkYgrIW4aubVFwTop4kLSxIb4zdo4OpZEPQ==
X-Received: by 2002:a17:902:aa43:b0:142:6919:73da with SMTP id c3-20020a170902aa4300b00142691973damr71519065plr.39.1637280974783;
        Thu, 18 Nov 2021 16:16:14 -0800 (PST)
Received: from [192.168.254.58] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id z7sm747309pfe.77.2021.11.18.16.16.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 16:16:14 -0800 (PST)
Message-ID: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
Subject: Adding CMD_SET_CHANNEL for station iftypes
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 18 Nov 2021 16:11:40 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I see CMD_SET_CHANNEL is only supported for AP-type iftypes (AP,
P2P_GO, etc). While this definitely makes sense in most cases,
protocols like p2p/dpp require going off channel for an undetermined
amount of time.

I could go into the exact scenarios but in short your REMAIN_ON_CHANNEL
could end at very inconvenient times.

Specifically when a station is not associated to any AP is there any
harm in allowing CMD_SET_CHANNEL? Is this purely a software limitation
or do drivers not allow this?

If this sounds reasonable (and possible) I would propose adding the
station iftype to CMD_SET_CHANNEL in addition to an extended feature
e.g. NL80211_EXT_FEATURE_STA_SET_CHANNEL so supplicants can detect
support or fall back to using REMAIN_ON_CHANNEL for these specific use
cases.

Thanks,
James

