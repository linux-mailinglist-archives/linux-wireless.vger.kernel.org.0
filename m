Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E750CF48E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfJHIG1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:06:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47456 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730414AbfJHIG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:06:26 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iHkVi-00032y-HM; Tue, 08 Oct 2019 11:06:23 +0300
Message-ID: <ac3ccd1eb498629b771645829ca080b642cffb36.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 08 Oct 2019 11:06:21 +0300
In-Reply-To: <df659853170ddf7a309c2f132eb749a35fbd8caf.camel@coelho.fi>
References: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
         <20191008073330.7nuwzwpwgzgjfswm@bars>
         <df659853170ddf7a309c2f132eb749a35fbd8caf.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: AX200 crash on udp upload, cannot restart
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-08 at 10:58 +0300, Luca Coelho wrote:
> On Tue, 2019-10-08 at 07:33 +0000, Sergey Matyukevich wrote:
> > > We have a system with several of the AX200 NICs in it, kernel is 5.2.14+.  We ran a udp upload
> > > test of 10Mbps across all radios, and after about 10 minutes one of the radios crashed and could
> > > not be restarted.  The others continued to run so far.
> > > 
> > > I will open a bug in the kernel bug tracker.
> > 
> > Hello Ben,
> > 
> > We observed similar issues in our tests as well. All the details
> > have been described in kernel bugzilla issue:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__bugzilla.kernel.org_show-5Fbug.cgi-3Fid-3D205061&d=DwIFAg&c=MHZppzMdXMt3JYjCV71UsQ&r=RFH8dgrFzz0_hnNXpEl_u3TZqD-B6kYLzfvbDuCKw3U&m=opeh64GEVevn0071vriL-kH2B_orc25yacBPa3YdgLI&s=CKuyBZ0VdAQocDiZGOIDyDC6GG9w4E7OikmGvzblazU&e= 
> 
> Thanks for the reports!
> 
> Ben also added a bug in bugzilla[1], let's use that one for tracking
> (I'll mark Sergey's as a duplicate).
> 
> This is a know issue and our PHY team is already working on it
> internally.  I don't have much more details at the moment, but I'll
> update the bugzilla entry as soon as we know more.

Actually the bug Sergey pointed out is not the same.  It's a different
sysassert, 0x103C and it will be investigated separately.

--
Cheers,
Luca.

