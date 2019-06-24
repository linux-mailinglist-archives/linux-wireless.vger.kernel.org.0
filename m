Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105EC51D29
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfFXVgh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 17:36:37 -0400
Received: from a1i1011.smtp2go.com ([43.228.187.243]:33465 "EHLO
        a1i1011.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfFXVgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 17:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=mb6cr0.a1-4.dyn; x=1561413096; h=Feedback-ID:
        X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
        List-Unsubscribe; bh=yq1MCkN+rcM+KNmedLcYZWN8Gxgffeq5AQ0hktcmMnw=; b=L+shqx4l
        yf2mxgV074s+xoZajg2Uc5sw+0L/zBhky4m49a4HOr4foecbwsoAhqpCfTSXNdS/7QIHelU5HTEOa
        5gxsFGckI00NVfVPRCdYK0JrtbaITdqGgkkZnjUgo315+T8S1gIfLnMnsvhe/avOz1wzUT8Al+swD
        xuv7ddge0OVxAgoC0Kh8dvFGbCTxB4ZeQ88wyvBUNyc+gwtZ6P683U7t/UYm+6tQVuHJNvC6GKuka
        HhBk+IcZqMyHUfUCihvRlM8vNJk/CzJv5B/tzJpa/dv0R5DopUoAOIUwNdOT1q+oFVdKwHWBWiqkq
        zvOhGBRsk6OqFtMK3E+hjW4Dvw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balki.me; i=@balki.me; 
 q=dns/txt; s=s521451; t=1561412196; h=from : subject : to : message-id 
 : date; bh=yq1MCkN+rcM+KNmedLcYZWN8Gxgffeq5AQ0hktcmMnw=; 
 b=CQVTxkc4l8koQA8HIFXRrwV1WKpKNsETdlhaCvs2u68NfoAL8jk7DtaSjVRIYpwsRSL10t
 Kr5sldqJnrQ75GDLYPPwouhQ6urlIk7G0Lr2SR6Ms4Pb2qzo37i1sAyi5L5IA6R3YP44wLI3
 kPQYAI6yg7iwAuIYuRBXWiMbYBg+dwgE0wTLdDsCs0K0NqfG5Slb4yH2QyEDl4ym+NkbkDQ4
 3vstyWyawvA9kzNQkbmdpmhY3+S0qCXzaayC/agxRZBR+V1BdH1mQqRZ8tq/8T6zciHEO2L4
 qsJBmS5nG4asBpGg5p0Tka5WWeFPlzwZ9Yc877diF21f4dwhd/7r7nkw==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hfWda-4pkRsh-5D; Mon, 24 Jun 2019 21:36:30 +0000
Received: from [10.135.23.123] (helo=zadesk.localnet)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hfWdZ-rlZGfU-12; Mon, 24 Jun 2019 21:36:29 +0000
From:   Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>,
        Emmanuel Grumbach <egrumbach@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi module crash
Date:   Mon, 24 Jun 2019 17:36:25 -0400
Message-ID: <2221997.PNfK1iNeOp@zadesk>
In-Reply-To: <CAPuHQ=GLgDFQZDhGv34S4yhOXTQL7AkKOywSqqtyPD8Lv6cCPw@mail.gmail.com>
References: <2455026.F8Aexx8IWb@zadesk>
 <CAPuHQ=Ffq_Gw_KbyjpzR07MWz=+LxmGVEP2-Tn5zDxrUEuxrZQ@mail.gmail.com>
 <CAPuHQ=GLgDFQZDhGv34S4yhOXTQL7AkKOywSqqtyPD8Lv6cCPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Smtpcorp-Track: 1hfWdZr_ZGfl12.EYJZ06sA3
Feedback-ID: 521451m:521451aMgsuo0:521451sZ9B4uoj52
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the tip. In my system the path to remove was below:

/sys/devices/pci0000:00/0000:00:1c.2/0000:02:00.0/remove
Also symlinked here: 
/sys/module/iwlwifi/drivers/pci:iwlwifi/0000:02:00.0/remove

I am now able to restore internet without system restart. Now I need to find a 
way to do this automatically whenever internet goes down.

Thanks,
Bala

On Sunday, June 23, 2019 5:08:32 AM EDT b.K.il.h.u+tigbuh@gmail.com wrote:
> devices/ is probably just a symlink. Try to find it manually:
> find /sys -iname remove
> lspci
> 
> The interesting thing is that my iwlwifi card started to do the same
> thing just recently (some weeks ago). However, I do suspend a lot and
> it only happens after resuming, but not after every resume (maybe
> 5-10%). It always came back after restarting except on one day when it
> needed three restarts, so maybe mine would be more about needing to
> reseat the card.
> 
> > On Fri, Jun 14, 2019 at 4:54 AM Balakrishnan Balasubramanian <linux-
wireless-list@balki.me> wrote:
> >> The issue occured again today. I tried to restart the module
> >> 
> >> > echo 1 > /sys/module/iwlwifi/devices/0000\:02\:00.0/remove
> >> 
> >> There is no folder 'devices'
> >> 
> >> zadesk% ls /sys/module/iwlwifi
> >> coresize  drivers  holders  initsize  initstate  notes  parameters 
> >> refcnt
> >> sections  srcversion  taint  uevent
> >> 
> >> > echo 1 > /sys/bus/pci/rescan
> >> 
> >> Attached the error when trying to rescan.
> >> 
> >> Thanks,
> >> Bala




