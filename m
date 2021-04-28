Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7936D801
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhD1NGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 09:06:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbhD1NGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 09:06:16 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lbjsg-0004IO-7C
        for linux-wireless@vger.kernel.org; Wed, 28 Apr 2021 13:05:30 +0000
Received: by mail-oo1-f72.google.com with SMTP id i11-20020a4a6f4b0000b02901ef8b6e92a6so12138084oof.7
        for <linux-wireless@vger.kernel.org>; Wed, 28 Apr 2021 06:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azd659SGNhyyJJ79qewYn8m0RM6DKPq4+6FyCxUUyOg=;
        b=oq9CoQqAqZ49kVOK3lcglNRDUdY1Ivk3L05R7HxpYAAtLHmqeetke5sdjATje8ANGt
         aIGKCwfvuZvNstck6cBseAuxkUGY0isPck0b7tTrJptaxEltv4PtX/MfVKCFGsUBXIC4
         HLLD2xh2NBrDWipfiFjF4L7/eG9yrhfVlKjUFqhS5eA8I3IZywy/d5+ktZeSarkfJnJ2
         cYWXs6Gir15Hfb3vCEAFvg3zBlqbBz5XTm7q9n+6Q2nYYWYE9gY82XvYVhAfU8Yuciju
         Ad/wExX3WJsqAiGqkLNNR6Kgvmts6pgO8zuRpRUMZoJjJTRzX1xLD58v/vUJNho4VN9b
         rR9w==
X-Gm-Message-State: AOAM531T46MjhuqKqIwpB+K3DSDsIFGZ8U7jDiQnrYcUmzRAcG34lZsW
        yrJvt0r6ZyMxJamFKGXpw+mSLdFjtdMStDEYmgCeL453VvMhXInWw7j0DKrQTZ0qQGmkHW1PiVF
        RWS2f4qVRDx1yBs5QTsKDK2EHk2LX5qXvwnU3+KgScuir
X-Received: by 2002:aca:d90a:: with SMTP id q10mr2754726oig.63.1619615129160;
        Wed, 28 Apr 2021 06:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFwndbQSBTySBJGslqKpKjPyX/NYP2jwjJ0naamTy8zLCDJXG0dDSL0aItWWENW//3z58CZA==
X-Received: by 2002:aca:d90a:: with SMTP id q10mr2754695oig.63.1619615128825;
        Wed, 28 Apr 2021 06:05:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:a354:5786:5e0e:64e4])
        by smtp.gmail.com with ESMTPSA id p127sm688052oig.16.2021.04.28.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:05:27 -0700 (PDT)
Date:   Wed, 28 Apr 2021 08:05:26 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     mj888@mail.co.uk
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Great Britian (GB)
 on 5GHz
Message-ID: <YIldlmkRu633DDY8@ubuntu-x1>
References: <20210428115428.AEB37A0151@smtp03.mail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428115428.AEB37A0151@smtp03.mail.de>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 28, 2021 at 01:54:28PM +0200, mj888@mail.co.uk wrote:
> Hi Seth,   Please change wireless-regdb for Great Britain (GB) on 5Ghz (band C - 5.8Ghz)   As per Ofcom statement from 24 July 2020 - Improving spectrum access for Wi-Fi Spectrum use in the 5 GHz and 6 GHz bands https://www.ofcom.org.uk/consultations-and-statements/category-2/improving-spectrum-access-for-wi-fi    DFS IS NOT LONGER REQUIRED ON 5.8GHZ (BAND C - 5725-5850 MHZ) FOR INDOOR USE / DEVICES UP TO 200MW   
>  I believe required changes are as follows:  - (5725 - 5875 @ 80), (100 mW), DFS  + (5725 - 5850 @ 80), (200 mW)        Thank you     

The proposed changes to IR 2030 are contained in Annex 3 of the document
you linked to. I pulled up IR 2030 from the Ofcom website:

https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf

As of yet this document does not contain the proposed changes. I'm not
familiar with the process for chaning regulations in the UK, but based
on section 1.6 it sounds like the document expresses that Ofcom made a
decision to amend the regulations, but that the document itself does not
have the effect of actually putting those changes into effect. If you
are more familiar with the process and I have misunderstood something,
please clarify.

You are correct though that this range should be 5725-5850 MHz. Seems it
should also be NO-OUTDOOR.

Thanks,
Seth
