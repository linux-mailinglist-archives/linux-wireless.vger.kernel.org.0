Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E725FB0667
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 03:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfILBSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 21:18:42 -0400
Received: from aibo.runbox.com ([91.220.196.211]:60602 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfILBSm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 21:18:42 -0400
X-Greylist: delayed 2956 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 21:18:41 EDT
Received: from [10.9.9.204] (helo=mailfront22.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <davep@mbuf.com>)
        id 1i8CzC-0006nc-A0; Thu, 12 Sep 2019 02:29:22 +0200
Received: by mailfront22.runbox with esmtpsa  [Authenticated alias (644123)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1i8Cz2-00013c-LM; Thu, 12 Sep 2019 02:29:13 +0200
Message-ID: <7753f3cd252b35dfa45c921e330fd98192230fe7.camel@mbuf.com>
Subject: Re: Question on Intel AX200
From:   David Poole <davep@mbuf.com>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 11 Sep 2019 18:29:09 -0600
In-Reply-To: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
References: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-11 at 06:49 -0700, Ben Greear wrote:
> Hello,
> 
> Does anyone know how well AX200 currently supports:
> 
> OFDMA
> 
> MU-MIMO (receiver)
> 
> AP Mode
> 
> And, can anyone suggest a good /AX AP to test against for these
> features?
> 
> Thanks,
> Ben
> 

On the AP Mode side, we have a few AX200 PCIe cards. I've been working
to get AP mode working with hostpad. Device says supports AP mode but
I'm hitting some issues with regulatory domains (channel EINVAL).


