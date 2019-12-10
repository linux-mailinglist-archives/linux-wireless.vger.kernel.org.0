Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7275811926F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 21:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLJUtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 15:49:47 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54114 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJUtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 15:49:47 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iemRy-0022rM-KV; Tue, 10 Dec 2019 21:49:42 +0100
Message-ID: <ac29ab4d325cc8f33befa95d416c27e1131a2ec9.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 10 Dec 2019 21:49:40 +0100
In-Reply-To: <bd06b9c7-a8c7-7ec6-ab98-8f59deb807af@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
         <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
         <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
         <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
         <98682dcf98525b9b7db16c30f85628d5a2725eb9.camel@sipsolutions.net>
         <f4e526b1-3afd-9eee-8416-46f3e97fdb00@candelatech.com>
         <9cf0c2edcfa3ade4b53263b718b0dabf3d39e9f5.camel@sipsolutions.net>
         <bd06b9c7-a8c7-7ec6-ab98-8f59deb807af@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-12-10 at 12:47 -0800, Ben Greear wrote:
> 
> We see about 675Mbps pktgen upload, and about 1Gbps download.  AP is
> /AX and configured for 160Mhz, but AP does not actually transmit at
> more than 80Mhz it seems.  I currently have no good way to see what MCS and BW
> AX200 is transmitting at.
> 

Try this

https://p.sipsolutions.net/d421d04b8aef81c4.txt

That's our internal patch to fix this, will be going upstream soon I
hope.

johannes

