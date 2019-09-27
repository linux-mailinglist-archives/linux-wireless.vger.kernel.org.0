Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4350C06DA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfI0OAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 10:00:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55990 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfI0OAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 10:00:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iDqnG-0000z2-UJ; Fri, 27 Sep 2019 16:00:23 +0200
Message-ID: <41aff25b6f14cdfd5ce1e0e157c49bd8c9b3ebd3.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim: packets being transmitted through the monitor
 interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 27 Sep 2019 16:00:22 +0200
In-Reply-To: <CAK8U23bUjYuG2=trtuEpcYT1xL1+kTugWrQKi=UTuMnFN-XDSw@mail.gmail.com> (sfid-20190927_150130_471576_DD589F69)
References: <CAK8U23ZyFnYt+ePreGjFA2VFXnpu21SPthscvJhP-5xjQCb0OA@mail.gmail.com>
         <49ded6ae8a23c29168ab7061235292ac7a853e0f.camel@sipsolutions.net>
         <CAK8U23bdmJGARCT=TXKyfknhmz-V0qUJ8dj0Mhko-CkvW+uW1A@mail.gmail.com>
         <6d62fe25faca3c000964e4f712bf3ba2d974d2f2.camel@sipsolutions.net>
         <CAK8U23bUjYuG2=trtuEpcYT1xL1+kTugWrQKi=UTuMnFN-XDSw@mail.gmail.com>
         (sfid-20190927_150130_471576_DD589F69)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-09-27 at 10:01 -0300, Ramon Fontes wrote:
> > A monitor interface created on one of the (hwsim or other!) wiphys shows
> > all packets seen by that device.
> 
> Weird. When I try to reproduce the same with a physical network
> interface, I can see no packets. It only shows the 802.11 protocol.
> With mac80211_hwsim, in turn, I can see, for example, TCP packets and
> their headers include the 802.11 header.

At least with mac80211 drivers that should work everywhere, though you
may get encrypted packets if software crypto is used, or crypto headers
if hardware crypto is used etc.

johannes

