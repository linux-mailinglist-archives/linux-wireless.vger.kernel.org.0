Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A56117602
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIThm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:37:42 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36852 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIThl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:37:41 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ieOqd-00GROU-5f; Mon, 09 Dec 2019 20:37:35 +0100
Message-ID: <9cf0c2edcfa3ade4b53263b718b0dabf3d39e9f5.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Dec 2019 20:37:32 +0100
In-Reply-To: <f4e526b1-3afd-9eee-8416-46f3e97fdb00@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
         <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
         <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
         <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
         <98682dcf98525b9b7db16c30f85628d5a2725eb9.camel@sipsolutions.net>
         <f4e526b1-3afd-9eee-8416-46f3e97fdb00@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-12-09 at 09:49 -0800, Ben Greear wrote:
> 
> ommit 1416758748a12963b7dc619a54fb9cef4354fa2e
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Nov 20 12:26:39 2019 +0200
> 
>      iwlwifi: pcie: fix support for transmitting SKBs with fraglist

OK.

> Please point me to the other one.

This one:

commit cb1a4badf59275eb7221dcec621e8154917eabd1 (tag: wireless-drivers-2019-11-14)
Author: Mordechay Goodstein <mordechay.goodstein@intel.com>
Date:   Thu Nov 7 13:51:47 2019 +0200

    iwlwifi: pcie: don't consider IV len in A-MSDU

but maybe it's included already?

I just tested (in conductive setup, open network) kernel 5.4, still see
TP significantly lower than what I'd expect... But even in RX?

johannes

