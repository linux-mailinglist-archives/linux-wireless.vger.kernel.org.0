Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB418FFA6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 21:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWUhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 16:37:09 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:42401 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCWUhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 16:37:09 -0400
Received: by mail-qt1-f176.google.com with SMTP id t9so9067607qto.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/b2WdSlm5s5H1j1++VHY3mMCF0veTtRIz2jgQ5LN20=;
        b=TqsxwB2xWPEUuJw17hNzlcQbT+uFDbTdFxZbl5XM4JIYE0mzdFKccLfvuBY4yDGhpM
         /hSqEEW/Dr17jzEg13LKtRHhI9CjCl/bd2OemCcC7zR7P77siyTRRJlQ5ge7AK6w9n18
         LnoaE59ZCMDpO22oV8B9lUgcqahLCnld971Zxng9da4wh3epMW2hZ08upBcfpwxtVqgX
         njW8I/XsVgHOPkvrPkKFuUKOK0qQF1YQP8n9jdllJmu0sjNtEyi48Up3q36kDvbrvuKg
         Ef4etNlBhptzI/AhYUcZ0lL8e0ZqNQpsI8ffmdyaJ6T1Frp1Kf+mskSFiuezWgFEBiOT
         r9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/b2WdSlm5s5H1j1++VHY3mMCF0veTtRIz2jgQ5LN20=;
        b=X9doyPrcRsZvqcmCOZDaaupJzno+n2Onh0f/Ie3tgY4bEY5YQLgy+mqYO1Mu1DuRf3
         4/wh12RNotZ3mJGeV3TepQCSF/xlPaxunnQO2MLEDWD/664R7JEZdRuMGbEvi0Y4FehM
         ugBlB1HOJaU9+k3TwSpDUj+F1WlSlhiQxrfL7e6RaFNVxJ7CElY6s0KhJJ4J6/IeGrKD
         4YdbPthTTMniaRMV0xcnT1A/qNMHdj7enzUAaKLkP+Vukp/cOyr4HelwzaIKfHxTqIUN
         h5Rk5MoKBDZRhVJJkDqXH9fpFTSdbH+aPW7qfH7QQtMvJiUwYk2iZ2d2DcN3kKPmEJlL
         legg==
X-Gm-Message-State: ANhLgQ3g4QL47saUCWgkXH9X+jcoBBJzrRvNVYpdrXViZQPu9DHlyqDH
        dsk9m3FNEoU9ShBvbkPsVsxPEwvPpsM=
X-Google-Smtp-Source: ADFU+vvMvND3D9JVs0XfhTQ+lZnck9p9F0sDg+Jqi0UIxgcevmB+M09BzdC3TPrdFqlwF2oe7f7wxA==
X-Received: by 2002:ac8:7609:: with SMTP id t9mr15545278qtq.27.1584995826554;
        Mon, 23 Mar 2020 13:37:06 -0700 (PDT)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id s63sm3095259qkh.64.2020.03.23.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:37:05 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 8AE08FC007E; Mon, 23 Mar 2020 16:37:04 -0400 (EDT)
Date:   Mon, 23 Mar 2020 16:37:04 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 7/7] wmediumd: don't treat management frames as noack
Message-ID: <20200323203704.GA10713@bobcopeland.com>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
 <20200323162245.19716cc94db4.Ib4a8bb12802840a3b9ed7e2e9ca1748a4e77e6ee@changeid>
 <20200323190831.GB5207@bobcopeland.com>
 <e7ac13b53f3bf77e1ec786496200013aa9602d9e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ac13b53f3bf77e1ec786496200013aa9602d9e.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 23, 2020 at 09:12:39PM +0100, Johannes Berg wrote:
> But wouldn't it be the other way around, i.e. they're *less* likely to
> be established without retries (noack)?
> 
> Anyway, doesn't really matter, just caught my eye there the other day :)

Oh, yeah, well, dunno :)

-- 
Bob Copeland %% https://bobcopeland.com/
