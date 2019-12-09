Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537171176E8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLIT6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:58:05 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:37464 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIT6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:58:04 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iePAO-00GTzU-N5; Mon, 09 Dec 2019 20:58:00 +0100
Message-ID: <41ae2775522899faca88a4bfbd08139bc7bf4d0e.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Dec 2019 20:57:58 +0100
In-Reply-To: <1dbae50c-28f3-228b-bbb5-710648f2eb2d@candelatech.com>
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
         <1dbae50c-28f3-228b-bbb5-710648f2eb2d@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-12-09 at 11:55 -0800, Ben Greear wrote:
> 
> Please let us know what you actually see and expect and if what mode
> you are using (VHT, HE, 160Mhz, 2x2 vs 1x1, etc).

Yeah, but I need to figure out first if I'm allowed to say the numbers,
sorry :)

Mostly interested in HE 160 MHz, 2x2, i.e. the max our NIC will do.

> Conductive test is not actually isolation from your environment (cables leak, especially
> SMA pigtails, as do radio cards and so forth, and they leak both in and out), so
> you will need a real shield chamber if you want to have repeatable
> testing.  And, make sure you have 30db of attenuation or so inserted
> if you are doing cabled setup, otherwise signal is too hot for the chips.

I'm usually using 22dB attenuation, but yes :)

johannes

