Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5D1F59E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfEONcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:32:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEONcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:32:45 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQu1T-0008Kh-Bd
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 13:32:43 +0000
Received: by mail-io1-f72.google.com with SMTP id y15so1828331iod.10
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 06:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ7zVLl9pn27V4CtgnPBdr2cnJN7Avbjtf6kgEMl0SE=;
        b=QkPSZvb7YznbMB0X7tFciv7ERI0BrLz6ptZIyNB/X4t3uF7oCNabmrGkJiDvq/N6J4
         5o1Taa7qzDC0zlVZI5X2i8CEMyMliwdV44TqVTYrz3uaXd9iC88h8i2Tgo6a6+GsAENO
         DyD+tfGpkN+ryOjzSzBS6GVJN+MpUHTpyt0NO4D7GL5YB2NRJu0Yj9jIId5uSorkcf/N
         IdkIIE0jgyl9ihiXaggSO7SgyL+HQAJlwV+GYopUuvmWYSi58yBEbpTA5dk/YZBCq4k8
         BEDukMDyeSJkUOzh7CjVuZJmWXFRQOJ8LYfFd1Hn9rmRt8r64AxSrKq3PrlAILTk7PWP
         LGMQ==
X-Gm-Message-State: APjAAAXaU2RaRHlcZpAlc7Idbj7pWuXkDdPBVtRMXIXZsxR5A+UI297t
        oBJhIMa045EXai3FBmQl7zGAR31TeFzAUc0HdkPabf+Zb1hD6gdkhFV7EzUN/QXev8Es2+8stN9
        5M3zeSuoYcFMbPi1PxMUL6wrdJwR1XBzd4Uhp06Ym7iUp
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr19406279ioo.0.1557927161965;
        Wed, 15 May 2019 06:32:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMbr60t1T5vL88Uni67Lsu9uDp9nyHODi5K3dAdyTiV9mPZ4JRS25RKCIoV/0P2XMRvX3JSg==
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr19406252ioo.0.1557927161727;
        Wed, 15 May 2019 06:32:41 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id 8sm607437ioe.1.2019.05.15.06.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:32:41 -0700 (PDT)
Date:   Wed, 15 May 2019 08:32:40 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Vladimir Koutny <vladimir.koutny@streamunlimited.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Japan (JP)
 on 5GHz
Message-ID: <20190515133240.GB4357@ubuntu-xps13>
References: <82a15f3c-fe0c-a5dc-9846-13b3efb01f0d@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a15f3c-fe0c-a5dc-9846-13b3efb01f0d@streamunlimited.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 01:50:59PM +0200, Vladimir Koutny wrote:
> According to multiple sources channels 8-16 (5030-5090MHz) were only
> allowed in Japan until Nov-30, 2017 (later extended to Nov-30, 2018).
> 
> https://www.tele.soumu.go.jp/j/adm/system/trunk/wimax/5ghz/index.htm
> http://www.dspr.co.jp/wp/wp-content/uploads/2017/10/The-expiration-date-of-some-frequency-of-the-5GHz-band-radio-access-system_eng.pdf
> 
> Signed-off-by: Vladimir Koutny <vladimir.koutny@streamunlimited.com>

Applied, thanks!
