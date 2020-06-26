Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19D220AA96
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFZDKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgFZDKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 23:10:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3BC08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 20:10:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u17so6521925qtq.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h5OQgXu7IK7UaqfggNDu6u2QXmbLAYaBjyn0BoS8gu8=;
        b=YDjGyf9VcZ77Uj/ndriw9+5sL3XtWpqDTa134ivkwz/7czS6H2K62fS/U7Rl82eN/W
         FWj49rriO1wTu1vM4Iz02Tzir+wjxrqGaS24sUaGgbJM3K5iuuJAFqxGKqjT1f+OmgcZ
         7M5ySnFjap21aF5Qv+VMT16SaRVXtSHisqX4QS5G7UwVshtq/m4eKt/D4lyoYu3HtPXv
         sS5htcdSl4EERe8ZJYybXfMPloRKqmlvpXrGebmZvzRakr+fAAb5kEMtPanZzFrZbu9W
         rkM5b8LScYwsSMa6vBvTGwYmzm8dxZVnToYFXB0dHH25CVpDCc55c+0YuP6Nr1VTDHjZ
         Whdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5OQgXu7IK7UaqfggNDu6u2QXmbLAYaBjyn0BoS8gu8=;
        b=NTGzwFgUd3aSCSCKYMTUsFK19SWgpMppEHjdsr5k+5Av7JR0lRYmBh81U5BMNMiY1x
         SfCXlfLCeuH8gEUy3LaozsUc7gM/uZiiv3AYsCfYn/rQT5lER10+V+BFvwN9LT3UT1lE
         k7tXO4h5HznZkyTgx4NqgQ4YWMpXLb5Duh8wNOeHlijbrGgB4ZmkJQJRXqUWfpqJKcyO
         70EWYnPwpqgyufPdWCw32D7OwtxOVg8FIvHzOOW33oeVqY1U0Jh2v9yn9rivrnvQLhT7
         cEeSHCSCGqc4Ar1OHndHHoIUuGqWGmqWqW8httLzY8WxbZBIVCfN5QCj5CR7PHgxQgC3
         1dTw==
X-Gm-Message-State: AOAM532T01AfisPgfvYnWRKCtQbeqzpyUxORK/wH16teQYN7snhUGPqy
        13NxW1/7R33qLP+U0bYI2ugkYKQI08c=
X-Google-Smtp-Source: ABdhPJzgJidTDJjUoN0k7JSYYvX8jZOLY06tb+PW1bFAc8hXChFbpPuYJ9QXDjsYLPydZQggwaXbmw==
X-Received: by 2002:ac8:709:: with SMTP id g9mr756404qth.276.1593141047269;
        Thu, 25 Jun 2020 20:10:47 -0700 (PDT)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id j16sm7397471qtp.92.2020.06.25.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 20:10:46 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id AC083FC00B2; Thu, 25 Jun 2020 23:10:45 -0400 (EDT)
Date:   Thu, 25 Jun 2020 23:10:45 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     me@bcopeland.com, linux-wireless@vger.kernel.org
Subject: Re: wmediumd: further updates
Message-ID: <20200626031045.GD14303@bobcopeland.com>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625130844.22893-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 25, 2020 at 03:08:35PM +0200, Johannes Berg wrote:
> Hi,
> 
> I've been working on this some more, so I have a few fixes and
> updates. Notably, perhaps, the ability to write a pcapng file.

Thanks, applied all.

-- 
Bob Copeland %% https://bobcopeland.com/
