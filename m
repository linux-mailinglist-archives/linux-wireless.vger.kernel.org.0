Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D717D5C3
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHTI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 15:08:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33236 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgCHTI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 15:08:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jB1I9-00AkzT-J2; Sun, 08 Mar 2020 20:08:49 +0100
Message-ID: <e9594f4b0ba1fa595cc1050e9cdb153082489a7a.camel@sipsolutions.net>
Subject: Re: wds link and Radius authentication issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>, Cedric VONCKEN <cedric.voncken@acksys.fr>
Cc:     Steve deRosier <derosier@gmail.com>,
        "hostap@lists.infradead.org" <hostap@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Sun, 08 Mar 2020 20:08:48 +0100
In-Reply-To: <20200307125703.GA4458@w1.fi>
References: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <20200307125703.GA4458@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-03-07 at 14:57 +0200, Jouni Malinen wrote:

> As far as use of WDS and VLAN ID assignment for the same station is
> concerned, I'm not sure there is a good solution for that with the
> current mac80211 design for the WDS interfaces.

Not sure we should even try to solve this on a wireless level? You could
still put the new VLAN interface into an appropriate VLAN bridge, I
guess?

I mean, even for radius VLANs you could theoretically assign each
station a separate AP_VLAN netdev on the wireless level, and put them
into an appropriate bridge, where you have one bridge for each radius
VLAN. This would "port" to a combined WDS AP_VLAN with radius VLAN?

johannes

