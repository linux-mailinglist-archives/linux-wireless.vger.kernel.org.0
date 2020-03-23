Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8899518FD4F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 20:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCWTIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 15:08:36 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:41349 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgCWTIg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 15:08:36 -0400
Received: by mail-qv1-f41.google.com with SMTP id o7so5344574qvq.8
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0LY/BhLfShHnuEYhbgJPvtawlRBv9CHNzcBzN7NqfmU=;
        b=lq2HEv4YC1d+SbmeOmW38CNgSshI1SR6elOKKSBF8EfZCeA0eQi/2m/ETOYLNvL6Tx
         LkOO4vkEMJiyhWCvr4p1tvNoyAUXsWOX0oEXtE4VpQU1j/6BdrCjUB495obrYxj5aXxm
         wJ/NxRsbRw3IYYvVpfLEH4a+/xONcSUzK0Rn3bL9uLDw2rZdB5q11/9JPsoCLYu3p5cZ
         JGDYK6KCG/8DKHfF73QKWZrauN7MUZq3QKcd+olBmD6eDzFb7/cpcqA3YDXvPfuDJuPr
         l7AumjBD/0PZbj+0+NXEtxOWM1st1ThFfR8krNklqhyMR6wdz2GdZg/oDv9H3JtiY6T/
         H4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0LY/BhLfShHnuEYhbgJPvtawlRBv9CHNzcBzN7NqfmU=;
        b=VRBiv5VmRBrtyMkpnF3pCH+Xsyuc/mlZC3Yqq3VaHtgZhNbzbJh/n0zRkAzGyO19/k
         T4HpDh87Q8ZC40bwuxTQyUfs+QLcJfXEisj6t3g4RlqjO9TQGnR7VhMX7JOZ03Msgwrv
         7apT8f5Rv1LyZI9ncXq3s0bJV++LTDEgvVzEroBfZRNrTnOZwkR6tt0WwBmVEcBMGJTs
         2KOe0hXM3EF1FBE6wV7Wa59AaeuE8By1FvXTPVkB/dJPApIglxe28PVu0qeOaxOx1kl0
         D9R8ICYNNlf3lUyTn1OQjpJUX6IAtKJTxojJUrq8R30Fv1fKxWVvGq7BskqJWUS6Q/Cc
         rQEw==
X-Gm-Message-State: ANhLgQ0g7/IHK2ZEGmp/WauEyQcZGO0IOzjgD3VqXgASIL6+NV4Ux6sC
        /TSWl8A0yR6sK1FF3q01xYoUm5A3puQ=
X-Google-Smtp-Source: ADFU+vu1nw3TolKPj/n9lqiDNXoaIKLrEpedy5mxr+aWtHnfBD9joUUhC5OumKKtEro0F6qx/y69IQ==
X-Received: by 2002:a0c:e649:: with SMTP id c9mr21344103qvn.230.1584990514435;
        Mon, 23 Mar 2020 12:08:34 -0700 (PDT)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:1bf2:858:b61:e782:8d89])
        by smtp.gmail.com with ESMTPSA id l16sm12905473qtc.73.2020.03.23.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:08:33 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id BE853FC007E; Mon, 23 Mar 2020 15:08:31 -0400 (EDT)
Date:   Mon, 23 Mar 2020 15:08:31 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 7/7] wmediumd: don't treat management frames as noack
Message-ID: <20200323190831.GB5207@bobcopeland.com>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
 <20200323162245.19716cc94db4.Ib4a8bb12802840a3b9ed7e2e9ca1748a4e77e6ee@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323162245.19716cc94db4.Ib4a8bb12802840a3b9ed7e2e9ca1748a4e77e6ee@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 23, 2020 at 04:25:42PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> It's incorrect to treat management frames as noack, they're
> retransmitted just like any other frame; fix this.

I think it was just a hack to make mesh paths establish even
if snr was terrible, obviously not realistic.  Thanks!

-- 
Bob Copeland %% https://bobcopeland.com/
