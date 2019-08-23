Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD99AA8A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403806AbfHWIjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:39:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390859AbfHWIjK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:39:10 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6DE69081
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 08:39:09 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id l15so4901321edw.15
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 01:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FEChvyYJDid1Eoz0Uy7rSJIaS/vQA0YWw6nWi+DAOys=;
        b=pRcdBUgNV6yTDnnDFAjSQNUVWqKJvwZ9uPL9UR4X5Vnr5mKDf488qAaptUSS9/6NkT
         Wb1ckOuVKPb1Si4P/YKas9nWfOsI7vCQ0P/yZqhRVZTVRrpT1wLwjsey1+7rp5RiBYpk
         Gu7qyho29c91bVY8HenyqHeK0DGqiwuXRae5vJyytIfTZ8QqSIIB7s3j4ikrQB9h5E53
         4lPQDK0ZSlCKfSn6aVH4vblNUY2kzO+8d1dI0NgRRCOsZC/cBsnZknvuuAlE5mvDJtiY
         GHo9icRJM/rnwqMIQro+uGHlUyOj+l5fK6CWt1DnTJU0GONmvgso+3W+acEkZkQeKYu/
         1J5g==
X-Gm-Message-State: APjAAAUBAq5gY33eP8khJOi62BVQYM/bBNJL2x00WgJET68jK5VSYFNM
        BHTvZivDu3uy57ypTpAy3vCtnATmXMq/R+nfDhx4ePkzslcygbYH4CHnLBM5YHu93RhKPGoQIAJ
        hzkMvPwo9ireNHjDmLyN9KZQK/4E=
X-Received: by 2002:a50:a5dd:: with SMTP id b29mr3252560edc.34.1566549548600;
        Fri, 23 Aug 2019 01:39:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4vpB98rtsMnX02fNDGrQzVhDzRaXKcUoRjGDf64B3TdfNHFnesExKQx/4Hw2fBCgka4NAAA==
X-Received: by 2002:a50:a5dd:: with SMTP id b29mr3252553edc.34.1566549548486;
        Fri, 23 Aug 2019 01:39:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y9sm390623eds.49.2019.08.23.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 01:39:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B257181CEF; Fri, 23 Aug 2019 10:39:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@qti.qualcomm.com>, Wen Gong <wgong@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
In-Reply-To: <250d064103394dfd864c1281f0da3d83@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-5-git-send-email-wgong@codeaurora.org> <87blwkt480.fsf@toke.dk> <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com> <8736husub0.fsf@toke.dk> <86d0eabcc63849efa914f2c14a3cd59f@aptaiexm02f.ap.qualcomm.com> <874l29pffy.fsf@toke.dk> <250d064103394dfd864c1281f0da3d83@aptaiexm02f.ap.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 23 Aug 2019 10:39:07 +0200
Message-ID: <875zmonums.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Sent: Thursday, August 22, 2019 8:12 PM
>> To: Wen Gong <wgong@qti.qualcomm.com>; Wen Gong
>> <wgong@codeaurora.org>; ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [EXT] RE: [PATCH 4/7] ath10k: disable TX complete indication of htt
>> for sdio
>> >> What's a typical limit in the firmware?
>> > It is 96 data packet in my test. It can changed in firmware code.
>> 
>> Right, I see. Is this counter available in all ath10k firmware, or is it
>> SDIO only?
>> 
> It is only for SDIO.
> For PCIE, it does not have credit limit, firmware memory only need to save
> The tx descriptor, not need for palyload.

OK, too bad. Thanks for the explanations :)

-Toke
