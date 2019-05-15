Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D951F542
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEONPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:15:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43814 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfEONPi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:15:38 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQtku-0007GF-Ep
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 13:15:36 +0000
Received: by mail-it1-f200.google.com with SMTP id m20so2261297itn.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 06:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTYhlJ094zJt/vNwV3kdaT2+0TA4LhAFNVXEjPr34X0=;
        b=pkyuGU9oXnB9hRfwiWN67o1lLkqZxDwyy6bhDvMTvtb3Vij5HCQUtvcBfV9ZCWeXp+
         xcF5Kz/0vgXeqjT1yEU6TgFcpyotve/lykrf85XZ1wiNIYc9dJEK1rfFKzOlpLvMrx7t
         YnrpzaTREO5jICrbr2gdVGjfXfHW+/TJX7Viv2ZxtaQGoB3NAAxL5i0l5yA79ZLcUJxP
         FWLn2qKT8+Gy/X2EpBoROJMxYIw6rWiAWjAM1B2VCr+3vNVBZDp7eYaKiPQUPT6L4K3u
         KwhqmiiVj5xk1PAtLx/kW23WcKmiJyYs5ksOeRFwKA/DyUC2NE54WB26i2WFKDqA7Qnh
         eumw==
X-Gm-Message-State: APjAAAVGqWa/eqYqSelQVAjnlSImrXKH40yhQdVORDjNOpZZBN8Xd4QK
        tWLZr35gzf9eM1jmwmO+2xN+r7WR5iKdda76WjcgFOG1bKyMHXioMgmKfSk8TyfRjl5hmVmUOGK
        EI5blGsSlGveQ1oXczJ2xXxQZZjb1pN20WSIhTAgv2bOf
X-Received: by 2002:a02:828c:: with SMTP id t12mr27575145jag.18.1557926135157;
        Wed, 15 May 2019 06:15:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPIeOtbAYG4Y5WvYIE87JrZO9jmf2xm88TWXxvPkhyq8yk1bjBEVUjzA5BFENiH2sTBAuIGA==
X-Received: by 2002:a02:828c:: with SMTP id t12mr27575115jag.18.1557926134893;
        Wed, 15 May 2019 06:15:34 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id z21sm681596ioz.16.2019.05.15.06.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:15:34 -0700 (PDT)
Date:   Wed, 15 May 2019 08:15:33 -0500
From:   "seth.forshee" <seth.forshee@canonical.com>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     "junping.xu@jaguarwave.com" <junping.xu@jaguarwave.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb <wireless-regdb@lists.infradead.org>
Subject: Re: [wireless-regdb] wireless-regdb: Please update regulatory rules
 for Japan (JP) on 60GHz
Message-ID: <20190515131533.GZ4357@ubuntu-xps13>
References: <2019040118074276659215@jaguarwave.com>
 <20190408124829.GD15126@ubuntu-xps13>
 <CAPuHQ=EvWzXtxk0fLOT6PyeYkcNOOXmw0ck-yT-JsqhhDmu2gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPuHQ=EvWzXtxk0fLOT6PyeYkcNOOXmw0ck-yT-JsqhhDmu2gA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 26, 2019 at 12:00:22AM +0200, b.K.il.h.u+tigbuh@gmail.com wrote:
> This seems to be the page for the previous standard:
> https://www.arib.or.jp/english/std_tr/telecommunications/std-t74.html
> 
> And the following should be the new standard, but I don't know where
> to obtain it:
> https://www.arib.or.jp/english/std_tr/telecommunications/std-t117.html
> 
> The description fields here do note the range of 57-66GHz, though:
> https://www.arib.or.jp/kikaku/kikaku_tushin/desc/std-t117.html
> https://webstore.arib.or.jp/en/products/detail.php?product_id=288
> 
> Similar mentions in the news (search for T117):
> https://www.arib.or.jp/image/osirase/news/1044.pdf
> https://www.arib.or.jp/image/iinkai/kikaku-kaigi/rireki/101.pdf
> 
> Testing procedure is described here, not sure if it's considered useful:
> file:///home/bkil/chrome.root/Downloads/60ghz2_1_19_4_2_1.pdf

Thanks. Judging by these and numerous other third-party resources I've
found, I think it's safe to say that the range was expanded back to 57
GHz quite some time ago. I'll send a patch to update this range.

Seth
