Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316E32356F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 02:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBXBqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 20:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBXBqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 20:46:00 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09B1C061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 17:45:20 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v3so383707qtw.4
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 17:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KifinP2uSeHnHoq5vyPTB5LaxGLxzPlPKJ9g8VpQp6w=;
        b=haQ4uM/IRMzkaUR5aqZftA3hy2075+BOO4PzbCKKfMwXCcqK/0PivVe6+1J3ZxPJyc
         c01l2gkD+p+Nx/35O8CJ+0HJE1CLxOBrQLKz4dCnKW5Lc88BwPO9C45q0BqILs5LTrKQ
         161oYvtu48jW2eGH8kop5cJJ1ICiDjKJQHnBncRqqx5aVrp4Hl9RfE1+Jd+S/MmB1DlD
         nfsd78vfBjYtxZWu4D42N8MCnvSr6tc+0Rk7Aey293+Ljzjg626JlBcSOH+SvFbiw+cT
         4NYn+X0a5sof64TGfnRrYOrLxcsirA4onnWqtW/R3vlSHsYyoZTXSPw07ZHlytT/xDpJ
         rQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KifinP2uSeHnHoq5vyPTB5LaxGLxzPlPKJ9g8VpQp6w=;
        b=kTe7+U7DStxmXwI8O3yX7EUmpvYkoFyQp+lXaxlfihtYJYTdI2phAE62L02WrH1zEF
         5k2kzz0st9PFbuu43il5tigxl+dI7GFk+ZIT9F1d6Chg/Jx5b5a4MWm5x4+irVJlKXeo
         xF8sx8DnT4+jk4TqZxfD9oEWmxaGD0jEnVk0XdQLmoST9zqXIcOfyZwNt2YYAhfwQLAM
         UZx//g5D8LxqPSYxVM3wqjqIZHCUKa37d6rcIfmBMXvnv+Bc7wA3+Tn52BZl4IabV/YB
         NFDcvW5a7IFoG4WB4E6L9sLrOBSAX9eQOZi02pps0NU8uomq9fJSGNxe6frW7BgJ/qrb
         2lTg==
X-Gm-Message-State: AOAM531gN3xLNXlvTpOgsQNZ9FylxPBumzmicXEKeJV9BmYAldAUni0T
        FP+mrRERae54OcTYOrhJfhUjGA==
X-Google-Smtp-Source: ABdhPJzEGgb2qEcfaWNVoZ3RwlxfmFn9Qprfp0sak4Dt7CiDA8S+I3eU8vxbz1oObQCJq93ht++a5A==
X-Received: by 2002:ac8:3872:: with SMTP id r47mr16271839qtb.96.1614131119890;
        Tue, 23 Feb 2021 17:45:19 -0800 (PST)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:7d5:d9c6:1353:8483:98a])
        by smtp.gmail.com with ESMTPSA id o5sm452292qkh.59.2021.02.23.17.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 17:45:18 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id BC8E2FC007E; Tue, 23 Feb 2021 20:45:17 -0500 (EST)
Date:   Tue, 23 Feb 2021 20:45:17 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wmediumd: lib: update from usfstl
Message-ID: <20210224014517.GB27894@bobcopeland.com>
References: <20210223212102.2189124-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223212102.2189124-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks, applied.

On Tue, Feb 23, 2021 at 10:21:02PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This updates the code from the usfstl lib, notably bringing
> in a bugfix for a race during the handling of the response
> to UM_TIMETRAVEL_WAIT.

-- 
Bob Copeland %% https://bobcopeland.com/
