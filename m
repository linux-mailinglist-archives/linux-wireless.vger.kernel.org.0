Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA10CD05BD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfJICzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 22:55:33 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:34168 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICzd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 22:55:33 -0400
Received: by mail-pf1-f176.google.com with SMTP id b128so635480pfa.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 19:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qE6p286c8/HUKD9YlOpzetQfcoGTOIt7sbmPaMrpQFM=;
        b=ikqUbuR37QdA5XzUpp+vk1gVX5XEx4aQzW5PZSHI0af3USyfZMLgEWrNdHUO2SE2qn
         3LhM907yNhBRpFeRf5uMC8+zpbiCwF73Qme0OK6NUucx7skdVJBE61J2KSep7mIJTXDD
         1kuAC9mpHp/f+bEon9dt36HujveYgknTQjPkJBPNUKytLwvxqdJflb3ziBqF1d7IIhZ3
         R6f8Tz/gn0yFzVO4sixh+HCkE6TBsoBpZ8AFoh48fFFi9bdViECTIKyAjAgeE2PdgPk4
         JxCcRpl7hiJScKbkBlXfdWP1w3oSQileDNedkQWZP3sAPMizlycg7tMj+4ATHD2CHXjS
         0yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qE6p286c8/HUKD9YlOpzetQfcoGTOIt7sbmPaMrpQFM=;
        b=H2Zj80CWIB+Qnxpu7xOsLbEMeHL2oBg8M2CJGxHBqoP3oP7bg0CXus34x+wINov0wW
         CqDJY1+7TepqeiWljNd1JLLJ9nAI+ichlVSF8kevpqGyZNzkXcqvPGFlhYInjqvHgkck
         W6tk8SdpeNPiCZQGEkWTYwQPnMGkPuOaoshqk2HfC4QCEEKfzqpedPrprsTZTPcGqFZM
         pYReEeUbCkkzlU1jClXrZkRQg0hPUKydtCptVKQd2q/8fcHvqUxjEIj9vQ2mpbos5c8r
         L/YpHxObH/cn/8+shkhDg79wqBP0YCpldHrN9ODn/6J/qchlyBO5zl1cD27i9/q/MrIz
         FMKA==
X-Gm-Message-State: APjAAAXDAasyoLZ6RERUJJhsYUTgNgizQRgblrlhejlXy2xVcytafgpf
        bTfJ+3ZhkGFse1h55HGDiN4q+A==
X-Google-Smtp-Source: APXvYqzE+zjTVtsipvEV46fA9VPQUJtnpAjQbDBrsqhMeYmvE25XQhyp8rbQ+xcrpp7kV5XGmO1UZg==
X-Received: by 2002:a17:90a:34c1:: with SMTP id m1mr1332101pjf.89.1570589732900;
        Tue, 08 Oct 2019 19:55:32 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id k8sm429841pgm.14.2019.10.08.19.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 19:55:32 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:55:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: pull-request: mac80211 2019-10-08
Message-ID: <20191008195520.33532bbe@cakuba.netronome.com>
In-Reply-To: <20191008123111.4019-1-johannes@sipsolutions.net>
References: <20191008123111.4019-1-johannes@sipsolutions.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue,  8 Oct 2019 14:31:10 +0200, Johannes Berg wrote:
> Hi Dave,
> 
> Another week, another set of fixes.
> 
> Please pull and let me know if there's any problem.

Pulled into net. Let me know if did it wrong :)

FWIW there was this little complaint from checkpatch:

---------------------------------------------------------------
0006-mac80211-accept-deauth-frames-in-IBSS-mode.patch
---------------------------------------------------------------
WARNING: Duplicate signature
#14: 
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0006-mac80211-accept-deauth-frames-in-IBSS-mode.patch has style problems, please review.
