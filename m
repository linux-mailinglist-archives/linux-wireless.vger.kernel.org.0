Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13D02C694
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE1Md0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:33:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41797 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1MdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:33:25 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hVbHX-0007fi-VD
        for linux-wireless@vger.kernel.org; Tue, 28 May 2019 12:32:44 +0000
Received: by mail-io1-f71.google.com with SMTP id s24so15746341iot.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 05:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJC4faTeLfUe+h38+g3iffsCSLuUIxdqKCzCVYdBzBs=;
        b=lh4U+oz7AUHmcBsVOx6lEDgSpVnKHwSbAxjRN9ymci8pQ7DC5E0SCSDTra201dK1Kr
         nXoAKejl8Ed1rGkcDm+d5xLL6Y6hGZ+RvCj3ugynWVGZJtJ5IJwcwJTj1oJ3rJ6W+6GJ
         PUIKEpLQBmmUeqpW8GdnomsfDCccNP+2gk5j6UTSWxKdsfKjkD929kE53GARKBIP7gGr
         9+HuUr5V5ynhA6y8/t/uQsA7B2p4Ek7GrUFxBh5g/96wKqIOIIM8IOehihvltKLCxDMg
         yLKoMVRB+3PX21NdpfgW/CtanXAtMD+ySaz6RFzouXZgCHoaNhf7Ool6pBwSQaz4ig/y
         6gtA==
X-Gm-Message-State: APjAAAWOP5Zf/y+IFcHXclzoQuWo/vy8rJYgMupvFSYGUlPlsi9kzYvk
        nKn9AnddKx0Wd5qwXaPfCzlrH20ri2oJp9bXux4Ch8KSef82dKMpYt94cReP8qWg0pQT/L2FQVc
        lSKbwyz3Rk8Jxc0ujbsh7JlUVvxRUq4/xk+5tj/xPOHis
X-Received: by 2002:a5d:8043:: with SMTP id b3mr69996242ior.115.1559046762629;
        Tue, 28 May 2019 05:32:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrxJ0FkxnvEXNsToKFhzojUgadPWMfYoa9jBJpdn1IEm+V3JBCdXf4/RRZTwLCNM9/9e7Rdw==
X-Received: by 2002:a5d:8043:: with SMTP id b3mr69996230ior.115.1559046762380;
        Tue, 28 May 2019 05:32:42 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:706d:2b0b:401e:a226])
        by smtp.gmail.com with ESMTPSA id c128sm1127853itc.19.2019.05.28.05.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 05:32:41 -0700 (PDT)
Date:   Tue, 28 May 2019 07:32:40 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Peter Oh <peter.oh@bowerswilkins.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-regdb] [PATCH v3] wireless-regdb: Update regulatory
 rules for South Korea
Message-ID: <20190528123240.GK4357@ubuntu-xps13>
References: <1557948501-12579-1-git-send-email-peter.oh@bowerswilkins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557948501-12579-1-git-send-email-peter.oh@bowerswilkins.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 07:28:29PM +0000, Peter Oh wrote:
> From: Peter Oh <peter.oh@bowerswilkins.com>
> 
> Update power limit as documented in:
> http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/
> %EC%8B%A0%EA%B3%A0%ED%95%98%EC%A7%80%EC%95%84%EB%8B%88%ED
> %95%98%EA%B3%A0%EA%B0%9C%EC%84%A4%ED%95%A0%EC%88%98%EC%9E
> %88%EB%8A%94%EB%AC%B4%EC%84%A0%EA%B5%AD%EC%9A%A9%EB%AC%B4
> %EC%84%A0%EA%B8%B0%EA%B8%B0/(2018-89,20181227)
> which revised on December 27, 2018.
> 
> Signed-off-by: Peter Oh <peter.oh@bowerswilkins.com>

Applied, thanks!
