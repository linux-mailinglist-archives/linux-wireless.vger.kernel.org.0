Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097C05FD04
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfGDSef (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 14:34:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45689 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDSef (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 14:34:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so5484699oib.12;
        Thu, 04 Jul 2019 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwqlPWLgtWbam3S8PbEk2DL4IkYoPJjyq8Eby5PvYJs=;
        b=koAL6oSvGwR8rO0HfCPdKDRa7eF6Kb7VQRlYLZnMUXFD1qEKJmLQREJVGrb/3GN5DF
         Wr9RCs68zdQN6/UteMzhYEBV1F+qKF48gORJPlqqSZ+A+YS++U7R2T6pKHmrx7ZyCy46
         AyKqpsRWL3B6zYiwxRHMyTc6PEJq1KrQtiDbzcJvubVXP8LQzn01bYk+Mjat0my+C8Vl
         Q/Du1iaCJPiMsulRD+K09oqdZNF86E3eSVc/NFaDyThrzTOsXtgUoCRVsrkq/z1vdmKh
         DclroLpyvSCbbN28DD5f62lDziuxYwsTtWsv8iB7kQTKQ4GHsNQnaKT7R+KzaX/KDmEZ
         fSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwqlPWLgtWbam3S8PbEk2DL4IkYoPJjyq8Eby5PvYJs=;
        b=JI4BDP8vceoA/tybjKDlEGO8dZr/fc+pS3BLcg5QJiFPREoBFHp3f1ohzV21twbKwE
         o97hhDdca11po6S+hCupce5+i4YRkffiyp7Gb8FUXPJ5Fl9t54udnvZHId8jvSQFzcve
         g2VOKt7sec/PlzjO6x+mvZM68+4VarDAKhVaHWA5LgKUBXzQ8w5XviQYB8nAMGmhrhj1
         ZSnXLjyXXkgrZ/z6iacjCdL7JOd+v8JBcU3SiVr2E86jzsAxnbEkHOgjtC6ASn6rERm1
         wgcgvWk4rlB8c9SYtvT7Q0PavRdYR6Yx1HbyMSVIp5bSthIIoVmksgsQ2wjy5DOLy8Zd
         +ORQ==
X-Gm-Message-State: APjAAAXIQQEVlI2f77o5fyXkCQT46/pXCnzOtvDrvyRiOtQKK6Ur6aVD
        Hzwq4c10Ohu3t8OAU4tO6oQdyoMSgeA=
X-Google-Smtp-Source: APXvYqzhe2miRwma3M2OJqqQShuQRsy1E1uZjK0GrouEWgWluPmRhMcGqh9HlMj6OOB5nv5PmVuCYg==
X-Received: by 2002:aca:3809:: with SMTP id f9mr533032oia.119.1562265274455;
        Thu, 04 Jul 2019 11:34:34 -0700 (PDT)
Received: from rYz3n ([2600:1700:210:3790::48])
        by smtp.gmail.com with ESMTPSA id 103sm2029850otu.33.2019.07.04.11.34.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 11:34:34 -0700 (PDT)
Date:   Thu, 4 Jul 2019 13:34:33 -0500
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior
 in bit shift
Message-ID: <20190704183432.av37fjd5s3zcho6m@rYz3n>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
 <20190627032532.18374-4-c0d1n61at3@gmail.com>
 <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
 <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 28, 2019 at 03:57:05PM +0200, Johannes Berg wrote:
> On Wed, 2019-06-26 at 21:34 -0600, Shuah Khan wrote:
> > On 6/26/19 9:25 PM, Jiunn Chang wrote:
> > > Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> > > significant bit to unsigned.
> > > 
> > > Changes included in v2:
> > >    - use subsystem specific subject lines
> > >    - CC required mailing lists
> > > 
> > > Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> > > ---
> > 
> > Move version change lines here. They don't belong in the commit log.
> 
> FWIW, in many cases people (maintainers) now *do* want them in the
> commit log. Here, they're just editorial, so agree, but if real
> technical changes were made due to reviews, they can indeed be useful.
> 
> johannes
> 

Hello Johannes,

Would you like me to send v3 with the change log in the patch description?

THX,

Jiunn
