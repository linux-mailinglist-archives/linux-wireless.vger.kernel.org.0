Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB3E8A32
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 15:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfJ2OBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 10:01:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40913 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfJ2OBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 10:01:17 -0400
Received: from mail-yb1-f199.google.com ([209.85.219.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPS3e-0000ak-Uv
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 14:01:15 +0000
Received: by mail-yb1-f199.google.com with SMTP id t48so10553507ybi.22
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 07:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sKqjHwiingwKgFhuisYvLG6eXqqbw54egTHXR+92zxA=;
        b=uXnYEhVHsN/VQXrA77UsoGUQgojyAPX4w4Wzl7lqgT9AkB6Ar1sQhOq+VLKT+LargB
         UasN0i8dEWtvk5M4AXzCNS/uPaTRnkKEy1qffwTLvvnr/Euv6dINdP8rSOR37kafoUlR
         8ep16hA/ozLqPcgkFEMfdlSmrWPE1xgk3o5ugg6nFjE+KYxPXvUTIQBJzyAozAEeybF9
         w0nZTEqzMZa3up6fCZkZobrY2ar36iGU2Xl3OgPUm/2uc0cstAc5JvOK1YlMEYTjpuH7
         7xanVLMbDsAYbAhQDKaCrDXcJpNsNkJUlzdSX9LWQIT2ffO9Yn+yXnmVQ03W4Vq+pRIF
         4zNQ==
X-Gm-Message-State: APjAAAV5qKxN8aw2q+Q4pWiBVNZJqbtJEsEp7NZphjI6thqtYhKj9cC8
        0Zz/AcZvVUmOVDY/ALZ377bgLTbE+Hh7gmwJTpQ0nAXH6m06Uw2z5jAPOgd32mLobufeLXiVcjE
        ftyBvMDKxhqckr1USV51WKnAKY8SPZ3B5LLhGs2RXq/Nn
X-Received: by 2002:a25:146:: with SMTP id 67mr19753983ybb.471.1572357673953;
        Tue, 29 Oct 2019 07:01:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTNF1r2tUfTbH1DLqbBkm9c94zW9VQIN89jhnxg1CSD++xeSK0iOMblN5Ouk+/QFuRTRyEgA==
X-Received: by 2002:a25:146:: with SMTP id 67mr19753946ybb.471.1572357673548;
        Tue, 29 Oct 2019 07:01:13 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id r67sm8221445ywr.48.2019.10.29.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:01:12 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:01:11 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] regdb: fix compatibility with python2
Message-ID: <20191029140111.GQ30813@ubuntu-xps13>
References: <20190822194628.4910-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822194628.4910-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 22, 2019 at 09:46:27PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Various changes in the commit mentioned below broke
> compatibility with python2. Restore it in a way that
> makes it worth with both versions.
> 
> Fixes: f3c4969c2485 ("wireless-regdb: make scripts compatible with Python 3")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied, sorry for the delay. Thanks!
