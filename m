Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8476518FD59
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCWTLh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 15:11:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35092 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgCWTLh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 15:11:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so4844793qki.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pq0wBQnoKNNjy/cMCLp0u8AzX+vhqO6QCI7zGhLvUtc=;
        b=Yj+qW/h1Bg2jDGW7stnb77oVhjcqZnqYgI0jdW7AdWKDOPb8+GDc52kUjsbofpJWQG
         Dj9N7Ljmq1uyN41kWHJReHHA8Dni9PHwhvxqyMOZEl9a9uKAFcmCNDmd3MHulJnIuA3L
         dIwuCuL7+uPSH+r5Kd++95s0ap+rMAzDjg5L9lmgGBQfVL0k1kl4fvpjOxtdXc+Z7uQ7
         Z3xlPiEFoptYv7uq2oroM3NJlRBK+muLZVYB2Gogvz4ge7GfkK46NZ9lmLo3W3Ocun0H
         JQoiR9JqVwNjbBRZas8Dog89JkIqmtum9xBtFM/TpTA7UJytrPDsXRW02IgLIzvAe2lx
         3ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pq0wBQnoKNNjy/cMCLp0u8AzX+vhqO6QCI7zGhLvUtc=;
        b=egLMDKJSRQnZ3306HOFw/VnFuIncwOMiNM7SvPFU+k/R0i4ZOaiIm/gWnItOLq/rU+
         M/gt9/P7pbgxWrh6ngM4HO2DKeNaL5B28uKGr/VBO80j9D+S0Vu84O2QCPgXPB1s7bEP
         emOJMyC2gQoaSKZrs573xZA4RvWYViXZOZSz6LOval5i9aRu62sWCTF8UPLvSeAt3J4h
         Myj+tvbgWU2ttXO7TXr8GRpctn9EeQ8OVABWirXW7Np7jbweJTxpj9Pd8CdGgW/X9+wV
         S9Tq6Q1EPrn0pwxenkEVGF8nN3nJww9hyt+yr2OmnaC7XnvR3p1BXvvlCb2Mm/RXI5Fi
         HnJg==
X-Gm-Message-State: ANhLgQ3QtgLd3jm40l4PVU+z1PCSpGHrOO/a/590NHo4kAkNVv9KQCmE
        /dKVEuQ6xbVszodAM/eq4cbs9w==
X-Google-Smtp-Source: ADFU+vv1m/5nCHVXmVZRcMNH1AvgBp3SxlZfiUeI9BSKpRZ8z+FM7bKPR7EBfcs1I+DvndftWSEr3w==
X-Received: by 2002:a37:9a54:: with SMTP id c81mr22294183qke.185.1584990695990;
        Mon, 23 Mar 2020 12:11:35 -0700 (PDT)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id g2sm11572422qkb.27.2020.03.23.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:11:31 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id CD44DFC007E; Mon, 23 Mar 2020 15:11:30 -0400 (EDT)
Date:   Mon, 23 Mar 2020 15:11:30 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/7] more wmediumd updates
Message-ID: <20200323191130.GA7508@bobcopeland.com>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 23, 2020 at 04:25:35PM +0100, Johannes Berg wrote:
> Some of these fix my previous patches, but I also have a patch
> for some code I just posted here:
> https://lore.kernel.org/r/20200323162358.b397b1a1acef.Ice0536e34e5d96c51f97c374ea8af9551347c7e8@changeid
> 
> to make it possible to use random-scan and other stuff, adding
> each MAC address from hwsim into the wmediumd "MAC".
> 
> Also sanitizer support (helped catch the use-after-free) and a
> small fix for not treating management frames as noack, not sure
> why that was ever done?

All applied, thanks.

-- 
Bob Copeland %% https://bobcopeland.com/
