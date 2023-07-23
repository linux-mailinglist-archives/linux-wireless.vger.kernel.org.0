Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63575E4AB
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGWTzc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jul 2023 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGWTza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jul 2023 15:55:30 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 868EE134
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 12:55:27 -0700 (PDT)
Received: (qmail 1824359 invoked by uid 1000); 23 Jul 2023 15:55:26 -0400
Date:   Sun, 23 Jul 2023 15:55:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Wireless mailing list <linux-wireless@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        PCI mailing list <linux-pci@vger.kernel.org>
Subject: Re: Nomenclature for USB-connected WiFi devices
Message-ID: <fa6bc5b7-489f-455d-a26b-1789de6d6934@rowland.harvard.edu>
References: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
 <b6e48f28-c832-7a05-d05f-e35514bec7b8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e48f28-c832-7a05-d05f-e35514bec7b8@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jul 23, 2023 at 07:05:40PM +0200, Oliver Neukum wrote:
> On 23.07.23 18:04, Alan Stern wrote:
> > If you've got a WiFi device that connects to the host computer via USB,
> > do you refer to it as a "wireless USB device" or as a "USB wireless
> > device"?
> > 
> > The second would seem to be more logical, by analogy with things like a
> > USB mouse or a USB thumbdrive -- we don't say "mouse USB device" or
> > "thumbdrive USB device"!
> 
> If you are doing this, why not go to USB WiFi? We want to know what
> kind of wireless device it is.

Doing that would require more knowledge than I possess.  :-)

I don't know what kinds of wireless device these different drivers are 
meant for.  Presumably most of them are WiFi, but are all of them?

Besides, if the original authors felt it was appropriate to write 
"wireless USB" instead of "WiFi USB", then most likely they will also 
feel it is appropriate to change the text to "USB wireless" instead of 
"USB WiFi".

Alan Stern
