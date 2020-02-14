Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480A715F4B3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 19:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405299AbgBNSXV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 13:23:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57282 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbgBNSXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 13:23:15 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1A29FCECEA;
        Fri, 14 Feb 2020 19:32:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Droid 4 WiFi firmware loading error
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200214174548.GC64767@atomide.com>
Date:   Fri, 14 Feb 2020 19:23:12 +0100
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Arthur D." <spinal.by@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3D50CC42-1201-4067-ACDE-E9B9F0DC5653@holtmann.org>
References: <20200211232425.GE16391@atomide.com>
 <op.0fu85owhhxa7s4@supervisor.net28> <20200212150722.GF16391@atomide.com>
 <20200212162131.GI16391@atomide.com> <op.0fwkyxvihxa7s4@supervisor.net28>
 <20200213041112.GL16391@atomide.com> <op.0fw0oas5hxa7s4@supervisor.net28>
 <20200213161157.GN16391@atomide.com> <op.0fx4hozhhxa7s4@supervisor.net28>
 <20200214161100.b7aqb6wwsrxmx4ab@earth.universe>
 <20200214174548.GC64767@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

>> WTF :(
>> 
>> Right now the BT driver and the WiFi driver are no aware of
>> each other. Actually the kernel is not even aware, that both
>> drivers are using the same chip. Unfortunately this will be
>> tricky to solve properly. Since a system may have two WiLink
>> devices, the only solution coming to my mind would be adding
>> a link from the BT device to the WiFi device in device tree.
>> Additionally we would need something in the WiLink driver to
>> check if driver has been initialized properly for a given DT
>> node.
> 
> Yeah exactly.. I think the best way would be to export something
> like wlcore_register_bt/wlcore_unregister_bt.. And then have
> wlcore_register_bt return -EAGAIN until wlcore is up.

actually NO.

We have rejected this many times for all hardware manufacturers. Please fix the firmware instead.

Regards

Marcel

