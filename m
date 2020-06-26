Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5071020AA95
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 05:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgFZDKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 23:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgFZDKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 23:10:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C1C08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 20:10:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e2so3888734qvw.7
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDqR/RH5eRkONL+suVWhCYNskZgQprosUuo7AumUTCs=;
        b=EaOQ9h9mfMIZEReqVNO0z1kaodGmWr5V8Jirq50qHbfm9x6Tkoi4k8/0WqjdhQc1/2
         j1AERER4kfaN8xOm7bUf6YBtt8Z7qi+WUJKz2bcht+8TNwqdbfJzAql1arfxeuHEGcVw
         OiirTQFr9bL7qqzPbzL8Rjfw0ieUuF/o1HqyxSt6cIc5R7G+EaqR1GxjfqF2nxCAIAIu
         tayUHnSmViZTmN7igqPs/FSi8n148J62SnzGeZL1J4S0Bbf/QgSulpBMelr7Qqy0flyi
         cC93MxmcWjyZ5i0qWO74v1GmEmg3R9WeRi5DzTZFZeVto2wnvq1Wdb/hhElDROgCfKwL
         lohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDqR/RH5eRkONL+suVWhCYNskZgQprosUuo7AumUTCs=;
        b=tjne87UjgsLwvVCiE6duBo838jxgDUa6RSAUDytajmT9TapHww3O6hM9HtgUM5f94z
         7ZjaTRDhCkcMhONVyafeKAEXTVOfxF+1QrlKFDbpx1MIJPuthCwH6QWyncLSlvmuZUXK
         iYaL+WEPJsKHK3DCMoPtQUleac/YM+F1cvas7nNEG1f0l88kQHxZWQjTswMRogZJLtBs
         ha3jjEXnqNDvnoFXDl+msAi95EDsoYYDF/zNegRhrI+Z5ZNVcNbjggR0f2MEiF3fhxJJ
         OflQYlHTFuX0Hy0UvGVazC2vrKbE8OzD8oy3I2yHJsc5c7xd8Oq7T40myGdCDGORfK19
         /nTA==
X-Gm-Message-State: AOAM533BeoT+6p3mH5kTBLvGP7SRhF5D7z26SFAb8I/W/6wZ/eV7igoa
        ObnWd6mcGL49KIROwFf/jYaN8A==
X-Google-Smtp-Source: ABdhPJzWyuFF6czLJEoY4/WYYRuzL6zDojokSJhxWny3hGU5R/jTKsrRhCRcvnCrBz/DEVKSl8Af1Q==
X-Received: by 2002:a0c:a8d4:: with SMTP id h20mr1118653qvc.41.1593141008939;
        Thu, 25 Jun 2020 20:10:08 -0700 (PDT)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id e203sm4461342qkb.87.2020.06.25.20.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 20:10:07 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 9A3DAFC00B2; Thu, 25 Jun 2020 23:10:06 -0400 (EDT)
Date:   Thu, 25 Jun 2020 23:10:06 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     me@bcopeland.com, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 7/9] wmediumd: add the ability to write a pcapng file
Message-ID: <20200626031006.GC14303@bobcopeland.com>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
 <20200625150754.554b7fc226a1.I14409b6cb5998e7bd087c1329952fbfa1a30d45e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625150754.554b7fc226a1.I14409b6cb5998e7bd087c1329952fbfa1a30d45e@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 25, 2020 at 03:08:42PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add the ability to write a pcapng file containing all the data.
> The radiotap header is currently very minimal with only the
> frequency and the signal strength.

> +	if (!filename)
> +		return;
> +
> +	ctx->pcap_file = fopen(filename, "w+");

I know it doesn't actually matter, but would be nice to close this
somewhere.

-- 
Bob Copeland %% https://bobcopeland.com/
