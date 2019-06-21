Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6F4E916
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 15:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUN1a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 09:27:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36460 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUN1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 09:27:30 -0400
Received: from marcel-macbook.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id E9BD1CF169;
        Fri, 21 Jun 2019 15:35:55 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
Date:   Fri, 21 Jun 2019 15:27:27 +0200
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DD31C097-2B3A-4455-9A47-F115A36AB394@holtmann.org>
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>> If the wdev object has been created (via NEW_INTERFACE) with
>> SOCKET_OWNER attribute set, then limit certain commands only to the
>> process that created that wdev.
>> This can be used to make sure no other process on the system interferes
>> by sending unwanted scans, action frames or any other funny business.
> 
> The flag is a good addition opposed to having handlers deal with it. However, earlier motivation for SOCKET_OWNER use was about netlink multicast being unreliable, which I can agree to. However, avoiding "funny business" is a different thing. Our testing infrastructure is doing all kind of funny business. Guess we will need to refrain from using any user-space wireless tools that use the SOCKET_OWNER attribute, but how do we know? Somehow I suspect iwd is one to avoid ;-) I have yet to give iwd a spin, but this SOCKET_OWNER strategy kept me from it. Maybe iwd could have a developer option which disables the use of the SOCKET_OWNER attribute.

when running iwd, we expect reproducible behavior. Meaning we need to ensure that nobody else is messing with our interfaces behind our back. A testing infrastructure that does that is really no good in the first place since you yourself are introducing unclean behavior.

When testing with iwd, we are testing the D-Bus API of iwd and you can at the same time take PCAP traces with iwmon. If we are able to store trace-cmd information also in the same PCAP file, we can extend iwmon to do exactly that. So far iwmon allows you to grab the netlink communication and the PAE communication which means you can easily analyze what was happening without having ask nl80211.

If you require extra debug information or triggers, then this has to happen via a D-Bus debug interfaces. However I see no benefit of not using SOCKET_OWNER. As I said above, if the testing uses different options than the real environment, what good is the testing.

Regards

Marcel

