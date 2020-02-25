Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB56216BF55
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 12:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgBYLKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 06:10:34 -0500
Received: from mail.w1.fi ([212.71.239.96]:59712 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728975AbgBYLKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 06:10:34 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 06:10:33 EST
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 02D3E10F41;
        Tue, 25 Feb 2020 11:00:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m2yBmsIMQrxJ; Tue, 25 Feb 2020 11:00:54 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Tue, 25 Feb 2020 13:00:18 +0200
Date:   Tue, 25 Feb 2020 13:00:18 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
Message-ID: <20200225110018.GA7561@w1.fi>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
 <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
 <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
 <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
 <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
 <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
 <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
 <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 24, 2020 at 01:35:51PM -0600, Denis Kenzior wrote:
> But it seems like the benefits outweigh the drawbacks?  At least we have
> been super happy with how control port works for us.  If you take the
> pre-auth path away, I'm really not sure there's any point in (at least for
> us) keeping support for the control port path.

Do you use the control port for RX only or both TX and RX? The RX side
is mostly harmless _if_ something filters unprotected RSN
pre-authentication frames that are received between the association and
the completion of 4-way handshake. That something would either need to
be the specific user space application using the interface or
potentially mac80211 with some special rules that are different between
EAPOL and RSN pre-authentication ethertypes.

For TX, the control port path will likely result in more problematic
issues. I'd expect drivers to use higher priority and/or higher
reliability for delivering the frames. That is justifiable for EAPOL
frames, but unnecessary for RSN pre-authentication frames. Being able to
bypass the port authorization control would be undesired from security
view point.

The key point for me here is the concept of authorized/unauthorized port
for normal Data frames based on the IEEE 802.1X standard. Only the
frames critical for the authentication service (establishing protected
link with the current access point) are allowed to be transmitted and
received while the port used for normal data is unauthorized. For IEEE
802.11, only the EAPOL frames are such Data frames that are needed
before the port can be authorized. RSN pre-authentication frames are
used to establish a new security association with a different access
point once the port with the current AP is authorized. As such, RSN
pre-authentication frames do not need to go through any special path
from the protocol view point and in fact, it would be incorrect to allow
them to be transmitted or received before the main port has been
authorized.
 
The IEEE 802.11 standard describes this with "communication of all
non-IEEE-802.1X MSDUs sent or received" being authorized/not-authorized.
MSDU is a reference to Data frames and "non-IEEE-802.1X" in this context
to any ethertype other than the one defined in IEEE 802.1X (EAPOL).

As a more specific example, the EAPOL frames are expected to be
transmitted unencrypted during the initial 4-way handshake (and with
some old IEEE 802.1X/WEP designs and some WPA(v1) implementation, even
during rekeying). On the other hand, RSN pre-authentication frames are
never supposed to go out unencrypted over the air (i.e., they must not
be sent or received before the encryption key has been established for
the link). The IEEE 802.11 standard describes this with "A STA shall not
use preauthentication except when pairwise keys are employed" and "As
preauthentication frames do not use the IEEE 802.1X EAPOL EtherType
field, the AP with which the STA is currently associated need not apply
any special handling. The AP and the MAC in the STA shall handle these
frames in the same way as other frames with arbitrary EtherType field
values that require distribution via the DS."

I understand that there is a different view point for this from the
kernel--user space interface side and it may indeed look more
convenient to use the same path for both EAPOL and RSN
pre-authentication frames from that view point. If that mechanism is
used, it needs to be understood that the rules for EAPOL and RSN
pre-authentication frames are different, though, and it is not clear
where that difference is going to be enforced if the same interface path
is used.

-- 
Jouni Malinen                                            PGP id EFC895FA
