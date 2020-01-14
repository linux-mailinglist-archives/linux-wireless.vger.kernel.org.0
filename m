Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8112A13ABD2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgANOEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 09:04:31 -0500
Received: from mimmi.uddeborg.se ([62.65.125.225]:52908 "EHLO
        mimmi.uddeborg.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgANOEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 09:04:31 -0500
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 09:04:29 EST
Received: from mimmi.uddeborg (localhost [127.0.0.1])
        by mimmi.uddeborg.se (8.15.2/8.15.2) with ESMTPS id 00EDfrqD2259387
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 14:41:53 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 mimmi.uddeborg.se 00EDfrqD2259387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uddeborg.se;
        s=default; t=1579009313; r=y;
        bh=7wv3U30CroOhxhk+GkVH5y25WsLoYQb2VjsmcDPRxbM=;
        h=Date:From:To:Subject:From;
        b=ph1WchygktE2CckPejL/8jqwS65C0/MK1qNbZ+W0X9m4ouEi5vbl40cOLsh/EznaA
         lu+oZJ4+QXUhisdpUBxSHxhmbPxPewHD9gC6nwuAkWTJoH+5EUrCfzFzgpXtv28kZr
         26wmKblholRn8EXs7YWh4uK4rInkbnSvWwlS9mRM=
Received: (from goeran@localhost)
        by mimmi.uddeborg (8.15.2/8.15.2/Submit) id 00EDfrSg2259386;
        Tue, 14 Jan 2020 14:41:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24093.50465.43201.93073@gargle.gargle.HOWL>
Date:   Tue, 14 Jan 2020 14:41:53 +0100
From:   =?utf-8?Q?G=C3=B6ran?= Uddeborg <goeran@uddeborg.se>
To:     linux-wireless@vger.kernel.org
Subject: Unreliable AP with rtl8188ee card
X-Mailer: VM 8.2.0b under 26.2 (x86_64-redhat-linux-gnu)
X-Face: Y!dkPRvB0]![*xB\M-!MfkgZ"n-BHD$BA(TZCt2r%n^o6|o1dWGQnY1<Y4}|@3?LNnN])Lp
        SKhC?f4OE*BqS>T)l5dc&vd#fDAE#]Dk;{]D@+o+?X(RqRh{#-D^87?5uml$Phvma*@_~1OS(i`D.v
        &0;f<h{bI;v5]m?&\Qh06/0CP6O$1MkZJR_~XTYm~cAwU($ioR86{'%h
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEUkIEVaTSwADXunZTaDcoNz
        SS8bJn4cQcTi2rrjx3JYLCkhM6DXlXwkGQn7wQfSAAACXUlEQVQ4jW3TP2sbMRQA8HRt6CCCFtOC
        yeAh0KGoN7iom0uGdDmElpvcEDIYMucLFHo3O6WnVosIWgS3dPFw49nYIhqaocuBvkufzr6zz/Rh
        L/ohvz9+OjnfxjV8yxCL+22cnLcxup0qvLm6P4LR1JgBYpv0CK5fFs94ghjfPPVhWngfa4aeH5c9
        GL7y3vP4jBfYTg7gFsF5fRYxGumxXO/h5o2vDScVFSJiIu9ghIpacUKtSNO5tptvLXypfY0ZsSJP
        0+zD2H1tATIbzogLkM5fz+XlDiCzagDO0yyu7A6GDcB5A+mKfP4/fEeTdQe1biDkSOdocnkALFQb
        7mTy3WSfvNaEEOqczQE+HQImHOoCzFPxfrno+qhxbGAmUcJcDtA2+NYbhAde0USzygo+aWHojYq9
        /5snpqZUxFfddL0xhS90vlL1gIrIHdwo6sLoXEJ6IuJ2JCFHCL4RFYxYcNJWdQeAYwwQmhekm+5d
        YTCHPvIMIBOVaGFmwt/BHzcAqRCrcQsXcIORRFMh4cfknK5bMFtgdDUGyLqqhsYgHhmjjWNW2ixr
        qxopozhPIJGIqLR51nWuB4Zz+EAS5oTN95A0fcChrJy0PzqYFQYhHRalonZ+szjYdoUG0D5UTO1D
        7xkoFBfeMCukXfbgRcy5pi7AUw9mMeLNMkrXhwuEQDixzv3qwUihMGBo5AggOwoXApQ9gEYwg2WU
        9BiMwvCoHKEP5aIHsFuhLgZQLg6h8ApxFMPcf5+c7gHmAQ8X8kD+n/5P2QIs0ACWTiEGzYuP/rTc
        ATwpFLLjBgRcKf8B/C7q8i6VUCAAAAAASUVORK5CYII=
X-URL:  http://www.uddeborg.se/g%C3%B6ran/
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's with some hesitation I send this mail to what looks like a
developer list.  According
https://wireless.wiki.kernel.org/en/users/support it should be ok to
send end user questions here though.  If it's inappropriate just let
me know and I'll go away.

My setup is a home server which among other things acts as an AP.
Recently, some devices have had problems connecting to the network.
It works some of the time, but fails other times.  The frequency
differs between devices, mainly different mobile phones.

The message in the phone is that it can't get any IP address.
Authentication is via WPA-PSK.  As I understand it, the the
authentication itself works; at least I get a different behaviour in
the phone if I intentionally type the wrong password.  But as far as I
can tell, the attempt from the phone to ask the DHCP server for an
address never arrives to dhcpd.

The problems started around the time the server was upgraded with new
core hardware components in the machine, including a new wireless
network card, which makes me suspect it is somehow related to the
driver.  The rtl8188ee driver gets selected for the card, and it
identifies to "lspci" thus:

    05:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8188EE Wireless Network Adapter [10ec:8179] (rev 01)

The OS is a Fedora installation using

    hostapd-2.9-2.fc31.x86_64
    kernel-5.3.15-300.fc31.x86_64

In my attempts to debug, I have listened on the interface with
"tcpdump".  It sees only EAPOL packages.

    11:44:44.362818 EAPOL key (3) v2, len 95
    11:44:44.389702 EAPOL key (3) v1, len 117
    11:44:44.389951 EAPOL key (3) v2, len 151
    11:44:44.408127 EAPOL key (3) v1, len 95
    11:44:44.408324 14:1f:78:3e:76:5c (oui Unknown) > Broadcast Null Unnumbered, xid, Flags [Response], length 6: 01 00
    11:45:20.771775 EAPOL key (3) v2, len 95
    11:45:21.772681 EAPOL key (3) v2, len 95
    11:45:21.788413 EAPOL key (3) v1, len 117
    11:45:21.788721 EAPOL key (3) v2, len 151
    11:45:21.824727 EAPOL key (3) v1, len 95
    11:45:21.825064 14:1f:78:3e:76:5c (oui Unknown) > Broadcast Null Unnumbered, xid, Flags [Response], length 6: 01 00


When it works, these are immediately (well, a tenth of a second later
or so) followed by DHCP packets.

Looking in the journal, the pattern is the same.

    jan 14 11:44:44 mimmi hostapd[2287864]: wlo1: STA 14:1f:78:3e:76:5c IEEE 802.11: authenticated
    jan 14 11:44:44 mimmi hostapd[2287864]: wlo1: STA 14:1f:78:3e:76:5c IEEE 802.11: associated (aid 2)
    jan 14 11:44:44 mimmi hostapd[2287864]: wlo1: STA 14:1f:78:3e:76:5c RADIUS: starting accounting session D15F3A088F96AE62
    jan 14 11:44:44 mimmi hostapd[2287864]: wlo1: STA 14:1f:78:3e:76:5c WPA: pairwise key handshake completed (RSN)
    jan 14 11:44:44 mimmi kernel: rtlwifi: -----hwsec_cam_bitmap: 0x10 entry_idx=5

Again, when it works, these lines are immediately followed by logs
from dhcpd, but nothing like this appears here.  At first I was a bit
suspicious about the rtlwifi log from the kernel.  After googling it,
it seems to be a red herring, though.  Additionally, such kernel lines
appear also when the connection is successful.

This would seem to indicate the phone was misbehaving, but why would
that happen only some of the time, and to several different devices
starting at the same time, if with different frequencies?  In
addition, when I try to look at logs on that side using "adb logcat",
it DOES say it sends a DHCPDISCOVER.

    01-14 11:44:48.389  2684 17585 D DhcpClient: Broadcasting DHCPDISCOVER

The full log is quite large why I don't attach it, but it is available
at ftp://ftp.uddeborg.se/pub/wifi/adb-logcat.xz

I also tried to debug using the hostapd_cli command.  It doesn't tell
me any more than the above, but is available as
ftp://ftp.uddeborg.se/pub/wifi/hostapd_cli

It seems to me the DHCPDISCOVER package disappears somewhere in the
hardware itself, or in the hardware driver before it reaches the more
generic network code where wireshark/tcpdump would see it.  But my
understanding of these things is pretty vague.

I haven't been able to find any probable pattern when it works and
when it doesn't.  Does anyone have any suggestion what could be wrong,
how to debug it further, or any other tips on what to do?
