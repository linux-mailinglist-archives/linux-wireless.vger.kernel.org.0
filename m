Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D6E8374
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJ2Ins (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 04:43:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40441 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfJ2Inr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 04:43:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so12637684wro.7
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U88yheObN+4ggJffRHrczNdJdHrli+5k282weA3zmys=;
        b=UWxTNpUj0SpmspSoeCVT8jWoJw3f34L0dLvZYLStfybqEFBCPn2e2AlgHmO0xhvKGm
         grjbzGyIrKbP7lal6JDVcB+aInE+hHfT06WpRjlM7fFAlIF2Hjh+x4p92KBB66jvpE04
         +QZSbvcAXfUbscunom8hd1nr1oMy9rEwVVEZaa4wTytbntlAryf+Yw+XNmBWbVIDLVzC
         /oCHObbo6+47ZgaTp7NhAQMTxqfzgpt2lC6UqRUX7Sm23lwPVXJ9VMs/mbtKCxIH3cGk
         XUI/fK+UDK79JK6ztv22QRiRQOMI6Gwa1snOn8g5PAIH4B1k00fs+fo4MSZ6ZK7/G+T7
         v2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U88yheObN+4ggJffRHrczNdJdHrli+5k282weA3zmys=;
        b=lxs9UdNkR7FC74ZJRVPjXogX9FaisxFFrOtNqgGtI8w48yDpYX7HrU0/E8zjZ8mX4z
         cIWL6CebnpvyeppKe8zmyR7bOod/6ZHJ1DGTxneirU9qysAIYL8Sw35SJMlRZzlekDy2
         pXOkiGS8sWu3mD/cGuyZuJBlzlHh1QipJXC3SJuuXK9AvQt3QwO0OacqEDsX5szF0+Vy
         Ev8FJuqA51Uo8A1M3nC8rslDebqTlpnL7MgJ0gwb1OlC3Gh9QRMVnZJgec1pcRuUAVr5
         7s8aB2Yyd0aBE9s6abV0oiXQdfabbVOpkFnKgVS41BG1YRaykFtjkg4gINpCJMnUJSqi
         q6MA==
X-Gm-Message-State: APjAAAWU60Bizj60X50ALCd4Iyyrl4WU/i7drbgaNWB5sT9j39CSnIWz
        bhR66nOnqY3zxxytC2ouCLGSng==
X-Google-Smtp-Source: APXvYqxRRsQAmnunlnuxpBCGvAUEzg9Kx7yBGFf0A1pBDmvOd/v+CXTq3tGGCyX6dcNLA0ezvj2JBw==
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr19959327wrx.171.1572338626088;
        Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id u10sm2793363wmj.0.2019.10.29.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:43:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:43:44 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Joe Perches <joe@perches.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        kvalo@codeaurora.org, davem@davemloft.net, swinslow@gmail.com,
        will@kernel.org, opensource@jilayne.com, baijiaju1990@gmail.com,
        tglx@linutronix.de, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] b43: Fix use true/false for bool type
Message-ID: <20191029084344.GD23615@netronome.com>
References: <20191028190204.GA27248@saurav>
 <20191029082427.GB23615@netronome.com>
 <055503c8dce7546a8253de1d795ad71870eeb362.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055503c8dce7546a8253de1d795ad71870eeb362.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 29, 2019 at 01:30:34AM -0700, Joe Perches wrote:
> On Tue, 2019-10-29 at 09:24 +0100, Simon Horman wrote:
> > I wonder why bools rather than a bitmask was chosen
> > for this field, it seems rather space intensive in its current form.
> 
> 4 bools is not intensive.

Thanks, point taken.

> 
> > > diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
> []
> > > @@ -3600,7 +3600,7 @@ static void b43_tx_work(struct work_struct *work)
> []
> > > -				wl->tx_queue_stopped[queue_num] = 1;
> > > +				wl->tx_queue_stopped[queue_num] = true;
> 
> 
