Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14132357BF
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHBOzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 10:55:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgHBOzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 10:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596380101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kkoTewt7Fx4Q+2DDC1UGcR4JlqqtBcQK2oUP1r3rTc=;
        b=e2q4VBe63VmQzXjMK+Wmnv8PjqWU5smJNLwCiil1LtXW+t0tVKyC31xOVDsdXe7F3iczgk
        WLH2i0gor41O+QutifzU593W5KBem/X5CMxciNb1ll3Q04B7EgGd6mRQWGJEt2PyJkLAaX
        UNiXd+6TpctOzkV2keGdIN5DnRt4bv4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Bw577weGMauYJv7-St-3pA-1; Sun, 02 Aug 2020 10:53:51 -0400
X-MC-Unique: Bw577weGMauYJv7-St-3pA-1
Received: by mail-qt1-f199.google.com with SMTP id m34so3694364qtf.10
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1kkoTewt7Fx4Q+2DDC1UGcR4JlqqtBcQK2oUP1r3rTc=;
        b=V7TOFA8E6b8mkpYaUfIKX2DdRmoboCEO0KZoXERGjznhvuFZzFBuLME2pj/DwBimPN
         DErQF7c2BJsZ9ZTb2KDJp5klxKffm99aYRRAnJFdNc8lBNWlF1MxLYpBnTt6M8QURqEW
         IydAJ3rGNPrqKsNWg3xJ/83QZqb7Ha0UvXXopJKFpN8R2fHoxt/QJM0sl+nDbP484Ng7
         wCAYo3cNgSjDgORB1BO+VbkQapCtZ2pIpwBa43LSoQI4G0eUG62K/u6NxKeF1KGe+ZwN
         WevX2MwyCknVsJ0r/jp0Pfa7oGuOgKvNgt6Nl5fVp1mAZC9d0MZq23V//Z9Iwhqr8p60
         lHog==
X-Gm-Message-State: AOAM533Gk7NWVWu7j7F0EO1qk/Tc26/xLqhdImTbI+badR6uGHQ3N1AX
        hm3F94f+iY56sqA6PDRsSmRi6Ee5worJFDiIsZRNEqaHPDkqrE3HX1cacerKDMK4cdv1Bbi4QHM
        apfxQpXQpmAcMND3u/ElqZhVy+iA=
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12711377qvk.53.1596380031293;
        Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsaj772ZR8xxDSmSbCv1i3DbzhNyKSnnIAtdh3ZvECGhzafck69cLoHqLTgfamrb5jJgzXtg==
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12711349qvk.53.1596380031093;
        Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t127sm16326265qkc.100.2020.08.02.07.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 07:53:50 -0700 (PDT)
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
To:     Borislav Petkov <bp@alien8.de>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-edac@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801125657.GA25391@nazgul.tnic>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6ecce8f3-350a-b5d5-82c9-4609f2298e61@redhat.com>
Date:   Sun, 2 Aug 2020 07:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200801125657.GA25391@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/1/20 5:56 AM, Borislav Petkov wrote:
> On Sat, Aug 01, 2020 at 01:24:29PM +0200, Saheed O. Bolarinwa wrote:
>> The return value of pci_read_config_*() may not indicate a device error.
>> However, the value read by these functions is more likely to indicate
>> this kind of error. This presents two overlapping ways of reporting
>> errors and complicates error checking.
> So why isn't the *value check done in the pci_read_config_* functions
> instead of touching gazillion callers?
>
> For example, pci_conf{1,2}_read() could check whether the u32 *value it
> just read depending on the access method, whether that value is ~0 and
> return proper PCIBIOS_ error in that case.
>
> The check you're replicating
>
> 	if (val32 == (u32)~0)
>
> everywhere, instead, is just ugly and tests a naked value ~0 which
> doesn't mean anything...
>
I agree, if there is a change, it should be in the pci_read_* functions.

Anything returning void should not fail and likely future users of the proposed change will not do the extra checks.

Tom

