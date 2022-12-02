Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5F640ADC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 17:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiLBQcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 11:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLBQcc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 11:32:32 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1F24A5AD
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 08:32:29 -0800 (PST)
Received: from smtpclient.apple (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id C899DCECFF;
        Fri,  2 Dec 2022 17:32:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Bug report: Can connect with 'wext', but not 'nl80211'
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20221202131315.GD444432@w1.fi>
Date:   Fri, 2 Dec 2022 17:32:28 +0100
Cc:     "Matthias G." <maps4711@gmx.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <B2ABE23B-1D1C-4105-A9AD-D5E5E4027E97@holtmann.org>
References: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
 <f694e9d9dbf36b870f278f8eabed14d5dede55aa.camel@sipsolutions.net>
 <f8dea92e4fa8e26bd1cc7ff8c6ba6ccd4843d8eb.camel@gmx.de>
 <20221202131315.GD444432@w1.fi>
To:     Jouni Malinen <j@w1.fi>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Matthias,

>>> Sounds like the AP is broken and doesn't like some elements wpa_s
>>> includes when nl80211 has certain capabilities ...
> 
>> Just for reference, both my Windows 10 and my Android phone can connect
>> to this 'Congstar'-labelled device without further configuration. I
>> don't know what Windows and Android are doing behind the scenes though.
> 
> If you have a means for capturing wireless sniffer traces of the frames
> exchanged between the AP and these various station devices, it would be
> useful to take a look at what the exact differences in the Association
> Request frame contents. For the nl80211 interface case itself, it would
> be interesting to see what is the exact information element that makes
> the AP misbehave, e.g., by removing them one by one (this might be
> either in wpa_supplicant or kernel) until the association succeeds.

you can run iwmon (from iwd package) to capture the nl80211 traffic and
it will decode the frames for you.

You might want to also compare it to running iwd instead of wpa_supplicant
since I have some vague memory we had this kind of issue and handled it
somehow.

Regards

Marcel

