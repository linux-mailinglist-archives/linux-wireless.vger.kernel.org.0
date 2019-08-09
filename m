Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9458832A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfHITPY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 15:15:24 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:33007 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfHITPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 15:15:24 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2019 15:15:23 EDT
Subject: Re: Regression with the latest iwlwifi-9260-*-46.ucode
To:     Takashi Iwai <tiwai@suse.de>, Luca Coelho <luca@coelho.fi>
CC:     <dor.shaish@intel.com>, Josh Boyer <jwboyer@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <s5hr26m9gvc.wl-tiwai@suse.de>
 <280dad08ba9864755c3c45ed3ce26d602fe18a49.camel@intel.com>
 <s5ho91pzyml.wl-tiwai@suse.de> <s5hwogcxwt4.wl-tiwai@suse.de>
 <b225d043d8581e0fec68cb63f7433161868293f3.camel@coelho.fi>
 <s5hmuh7xrqy.wl-tiwai@suse.de>
 <38635c1b10018859457787ecff4f92a3ceec34a4.camel@coelho.fi>
 <ef32cea91614b9708a474e223f3fbbb85a95501d.camel@coelho.fi>
 <s5hsgqgnczv.wl-tiwai@suse.de>
 <99462e51eda721d5d85d9ea9e2c28da62f8b54f5.camel@coelho.fi>
 <a394850acbe0f05d6428ce466ecac1cfaefadd59.camel@coelho.fi>
 <s5ho912momt.wl-tiwai@suse.de>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <1736104d-3ef4-83d1-2672-00f36b922ef7@mageia.org>
Date:   Fri, 9 Aug 2019 22:00:15 +0300
MIME-Version: 1.0
In-Reply-To: <s5ho912momt.wl-tiwai@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C020D.5D4DC64B.002F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Den 06-08-2019 kl. 16:04, skrev Takashi Iwai:
> On Mon, 05 Aug 2019 14:03:55 +0200,

> Now we got a feedback from the latest linux-firmware (20190726) and
> surprising the result was negative.  The dmesg after the cold boot is
> found at:
>    https://bugzilla.suse.com/show_bug.cgi?id=1142128#c26
> 
> The kernel is 5.2.3, so it should be new enough.
> 
> If anything else needed (or something missing), let us know.
> 

I read on some forum that some commented that the "Add support for SAR 
South Korea limitation" fix is needed, but it seemed weird...

Anyway, with theese on top of 5.2.7

39bd984c203e86f3  iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version 
< 41
f5a47fae6aa3eb06  iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT 
support
0c3d7282233c7b02  iwlwifi: Add support for SAR South Korea limitation


We have confirmation from an affected user that its now stable with both 
older and newer firmwares...

And we earlier tried with only the:
39bd984c203e86f3  iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version 
< 41

But that did not help (not that I really expected it since its loading 
version 46 firmwares anyway)

So my guess is that the newer firmware actually subtly expects to get 
the behaviour of the:
0c3d7282233c7b02  iwlwifi: Add support for SAR South Korea limitation



Of course that's still guessing and I assume only Intel fw guys can 
verify that...

--
Thomas
