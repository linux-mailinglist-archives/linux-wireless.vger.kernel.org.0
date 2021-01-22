Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD92300AEA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbhAVSQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 13:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbhAVRYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 12:24:30 -0500
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jan 2021 09:23:34 PST
Received: from mout0.freenet.de (mout0.freenet.de [IPv6:2001:748:100:40::2:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E9C061788
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 09:23:34 -0800 (PST)
Received: from [195.4.92.127] (helo=sub8.freenet.de)
        by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1l302u-0004OT-GY; Fri, 22 Jan 2021 18:16:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=01019freenet.de; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F7R+5WwCBnW2Nj2NOoKa9qkQMSNslBEtRYuMY0W8xh0=; b=kg1Cck7rxqYta9rj55SjkSB7I+
        Oy7btzdztrKY7wLDqGNR4MxrQ+nedvksriB7Ic3ARSRHLGOd1NP1/wagBxgIFq5GJb0dvjtyBETec
        +FPNGQoSyFuxDHToKhACQIq5at0GuldraBjng3CVQAswfl/oBD2fzp18c/Fn4noD0/eU+z7du5++n
        WLMD8fuPYqe4VinPLl/9ueWK9M62F03WLcbShdA9625uNKREHMVNHegum8IQ6we92VneH3o6/2SR6
        omX9ZS8ogEJBVSgNzqS+ZmU6zk66ypNMqOk1pICSEPbGczbXF1/x5LkzlFjnzW0hcATlWY3YfIAny
        mx7oc23A==;
Received: from p200300de573c8400505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:573c:8400:5054:ff:fe15:ac42]:48696 helo=mail.maya.org)
        by sub8.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1l302u-0000Ux-1k; Fri, 22 Jan 2021 18:16:28 +0100
Received: internal info suppressed
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <greg@kroah.com>, stf_xl@wp.pl
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
References: <20210122104342.12451-1-stf_xl@wp.pl> <YAq9bt6q9dfk4F+F@kroah.com>
 <b0025964-490d-d8a0-f9af-f916d44e4f52@maya.org>
 <4690235c-9676-7985-12a1-b8bcfd195a43@linux.intel.com>
From:   Andreas Hartmann <andihartmann@01019freenet.de>
Message-ID: <43ebb270-2069-4672-f277-1222979305a8@01019freenet.de>
Date:   Fri, 22 Jan 2021 18:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4690235c-9676-7985-12a1-b8bcfd195a43@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:573c:8400:5054:ff:fe15:ac42!48696
X-FNSign: v=2 s=8666CD2CC0E41124E56968FE17014D8EA7B0CB9D1539FAAFAC6C32596E456D50
X-Scan-TS: Fri, 22 Jan 2021 18:16:28 +0100
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.01.21 at 16:22 Mathias Nyman wrote:
> On 22.1.2021 15.17, Andreas Hartmann wrote:
>> But anyway, there is from my point of view a basic problem with xhci_hcd,
>> which just seems not to be completely backward compatible to existing USB 2
>> drivers (see https://marc.info/?l=linux-usb&m=161130327411612&w=2) if the
>> device is plugged to an USB 3.x interface.
> 
> This looks like a different issue, lets keep it in its own thread.
> 
> The xHCI usb host controller handles both USB 2 and USB 3 speeds.
> If the USB port is connected to a xHC controller then the xhci driver will
> be used. If the port is connected to a EHCI then the ehci driever is used.
> EHCI does not support USB3 speeds.
> 
> It's very possible that something that worked behind a EHCI host has issues
> when connected to a xHCI host.

I would be very glad to get this sorted out. At the moment I absolutely
don't know where exactly to try to prevent to trigger the "xhci_hcd
0000:05:00.3: WARN Wrong bounce buffer write length: 0 != 512"
situation. Is it on the level where the bulk packages are created or
even before?


Thanks
Andreas
