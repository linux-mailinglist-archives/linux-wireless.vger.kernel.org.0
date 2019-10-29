Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816BFE87F5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfJ2MUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 08:20:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38398 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfJ2MUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 08:20:39 -0400
Received: from mail-yb1-f200.google.com ([209.85.219.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPQUH-0003pI-4X
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 12:20:37 +0000
Received: by mail-yb1-f200.google.com with SMTP id 202so10392738ybe.13
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 05:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLMmdpvy8HtaWQtMsgU9D7lhTfDKEpzlWeRLQrltMzM=;
        b=o3vmaNg6s18HmEf25s6R6I2Up6eveCUbNBrwS2frrOSmX3+YjDI7+fJ1lSC0gu/meJ
         cobSqvK0tJezxjHbfjuVxvQjzOuzFjVu08V+T5iAunDrl1KpVxq1QMGPvXlekbOBHmBB
         LQyWsH/8zVqc38rYIHWHTnpDJgnvmluWaUvpNgYowWn72+PYqPSlWbHB+26ImAVXdLQW
         c9kQhx0OxKpIyekVPgTM3Yq8KDDTfmxP+S/dmoJlKhrvrDA858VZdXkrUj7J9l2y/0wj
         Es9+OnRimkLfImaZD2iykU1RHD5+lBr8x9qTJJJMrgPaUqLmPSD0xtjP1AeckZv2k8Bx
         5GvQ==
X-Gm-Message-State: APjAAAXURRikgG4HtVVvzLSxDilT78QzLPtdUsxwfTckvgklH0Wd69sT
        RYVUl9sjD5NvxckVVC7f5jBKbFaTCpNMj1iygUlBNNiKI/5Kn8uvmaxCZeitsxIK7ZuhA9fb8w8
        buf1bG+T1sMC7iNybsE4UeEppaUxg2PdnlWfRPMP1ilpw
X-Received: by 2002:a81:7990:: with SMTP id u138mr2573142ywc.232.1572351635492;
        Tue, 29 Oct 2019 05:20:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmOWF7ONg9HJkvNrtRzqlpE+5m59Dvq0AQtPsbgHwViV8PwrkoVHmxkZFVhVSJK0Oaw69H5g==
X-Received: by 2002:a81:7990:: with SMTP id u138mr2573116ywc.232.1572351635050;
        Tue, 29 Oct 2019 05:20:35 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id u7sm17353044ywu.45.2019.10.29.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:20:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 07:20:33 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Extend 5470-5725 MHz range to 5730 MHz
 for Taiwan (TW)
Message-ID: <20191029122033.GK30813@ubuntu-xps13>
References: <20190726030538.16784-1-wens@kernel.org>
 <20190809205025.GP10402@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809205025.GP10402@ubuntu-xps13>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 09, 2019 at 03:50:25PM -0500, Seth Forshee wrote:
> On Fri, Jul 26, 2019 at 11:05:38AM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> > 
> > This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> > The Linux kernel however does not seem capable of considering them
> > most restrictive subset of multiple rules.
> > 
> > Since 5725 ~ 5730 MHz belongs to the next range which has looser
> > requirements, we can do this manually and extend the range by 5 MHz
> > to make the kernel happy and be able to use channel 144.
> > 
> > Also, looking at the US regulations, which the TW ones are based on,
> > The DFS range ends at 5730 MHz, while the next range starts at 5735
> > MHz. This doesn't match the actual regulations, but is skewed to meet
> > wireless channel boundaries. I prefer the database match the law,
> > and be adjuested only if necessary.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Sorry for the delay, applied now. Thanks!

