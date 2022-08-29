Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46C5A4FCD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiH2PGs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiH2PGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:06:47 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 08:06:45 PDT
Received: from xmail.hs-nordhausen.de (xmail.hs-nordhausen.de [195.37.89.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0CA86B54
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:06:45 -0700 (PDT)
Received: from smtpclient.apple (10.1.10.8) by db1.ad.hs-nordhausen.de
 (10.1.10.5) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 29 Aug
 2022 16:51:39 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
In-Reply-To: <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
Date:   Mon, 29 Aug 2022 16:51:39 +0200
CC:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Content-Transfer-Encoding: 8BIT
Message-ID: <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Originating-IP: [10.1.10.8]
X-ClientProxiedBy: db1.ad.hs-nordhausen.de (10.1.10.5) To
 db1.ad.hs-nordhausen.de (10.1.10.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On 29. Aug 2022, at 16:45, Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> On Mon, 2022-08-29 at 16:41 +0200, Jonas Jelonek wrote:
>> Transmit power control (TPC) per packet hence per station can be used to
>> manage interference and increase overall spatial reuse and therefore
>> increases sum throughput in WiFi networks with multiple APs and STAs.
>> Although several of today's wifi chips, e.g., from QCA and from Mediatek
>> support fine-grained TPC per packet, the Linux mac80211 layer does not
>> provide support this annotation nor control yet.
>> 
>> This series proposes several changes to introduce TPC support in
>> mac80211, in particular to annotate tx-power per packet/per mrr stage in
>> the Tx control path.
>> The patches include new nembers in the Tx control path structs, a
>> modified tx-power level support annotation, hardware flags and an
>> utility function for the convenient use of struct ieee80211_rate_status
>> (introduced by 44fa75f207d8a106bc75e6230db61e961fdbf8a8) for tx-power
>> status report in drivers.
>> 
>> Compile-Tested: current wireless-next tree with all flags on
>> Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
>>        Kernel 5.10.137
>> 
> 
> That seems just a little old? Not sure I'd trust that given the major
> changes in the tree recently?

Good point, we can test this with 5.15.63 by enabling the OpenWrt testing kernel … would that be ok ?

> 
> johannes


Greetings Thomas
