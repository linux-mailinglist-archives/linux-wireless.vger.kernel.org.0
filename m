Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826D32AF62
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhCCATJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446101AbhCBDDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 22:03:48 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D134C061788
        for <linux-wireless@vger.kernel.org>; Mon,  1 Mar 2021 19:03:07 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id n4so6949927qvl.4
        for <linux-wireless@vger.kernel.org>; Mon, 01 Mar 2021 19:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Ap+lMZ5e7U/+z95W+/q7xprCOW2/VbHhOzWoWjMPbk=;
        b=RMwrkfa8c6nbnhjzbkiDdDGxTayZHbFwg3STR/aDfbX773xuPHCAW+vi4jkNwLH7Np
         lO1aCyUuN+yTN0KVddt58v4hDeaf7SwBpygkzbKe6LnxULbO7R8BWT4P8PQjc1h2rAD5
         4+mDVDNX0ljHKXYqYJ1Jxb/LuvFTY2mt2u+YO5wxZy1487ADFr4zBJDfrY2VAnzs7tKy
         l+NES8YM1z7Zga6sv0c3DjnQ6DAFCJilKwr6IOQPKrA0dWrOH9W61AAZMjEYHukcK0Sa
         JRdYPTYaxH5eXPevuoSHkl6mexg2Dwlb5MttjXN2WuIQoO7XeN5o/I4vvcJu5H668m0k
         QpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Ap+lMZ5e7U/+z95W+/q7xprCOW2/VbHhOzWoWjMPbk=;
        b=qA6PtMDeijlP5LQodlnADFwwv7yMJbXvqvKBjvav91ljDYlcsB/AAM3lJeBoZOVBvG
         LsA06lrNNn2GehGileFbbj+Nf4hYw/UVeIv24+CiADxPdsJoCzrFLyuY9AnPpte7PfNH
         DDBcLg2n76QUWzZZg2dMBsOKGZtXoyGjTz406asTy+HVZdf2Kye5Dd0vd65qBGDx371Y
         Jfe07UdJIg2RuLachLksBf8VcVRmT8N842D1uJWxUKhR9vp6IHCZc8Wez/eAAcqPeCsr
         3slTRKbzv9k+QtiQQjRtefV7z4IKbBqdZyf6+0GTtbUhHDlwoNMQAqLZGYQu81q6x+wR
         BhYQ==
X-Gm-Message-State: AOAM5317wCoEY0af+Tn3siRfEJEd00c+qi28WTrZCAHvxP9OgM0cm3p/
        yctRmoSBwCt+upKuScnGPoQQeA==
X-Google-Smtp-Source: ABdhPJzJq9JUoxi1g5ExnamYWl0X2ddP1wan/s2z0eUPIOvv3Nf9vIB3T0YYfmFAF9yA5Qzx/YuF4A==
X-Received: by 2002:a0c:a5a6:: with SMTP id z35mr1760056qvz.24.1614654186704;
        Mon, 01 Mar 2021 19:03:06 -0800 (PST)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:7d5:a81b:d39d:76c7:d569])
        by smtp.gmail.com with ESMTPSA id n136sm10144384qke.123.2021.03.01.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 19:03:06 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 6B547FC007E; Mon,  1 Mar 2021 22:03:05 -0500 (EST)
Date:   Mon, 1 Mar 2021 22:03:05 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wmediumd: lib: sched: fix another scheduling corner case
Message-ID: <20210302030305.GD27894@bobcopeland.com>
References: <20210225195042.2657805-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225195042.2657805-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 25, 2021 at 08:50:42PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When running with an external scheduler that also uses the
> event loop, we can detect e.g. a client disconnecting from
> a server while in usfstl_sched_forward(), causing us to not
> have a job anymore on the scheduler afterwards, which then
> causes the assert at the end to get reached erroneously.

Applied, thanks.
