Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0D95F91
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTNLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 09:11:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729260AbfHTNLa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 09:11:30 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i03v0-00006M-T8; Tue, 20 Aug 2019 16:11:23 +0300
Message-ID: <f0938a84217761470f95a54337e5a2784cef01a6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Thomas Backlund <tmb@mageia.org>, Takashi Iwai <tiwai@suse.de>
Cc:     dor.shaish@intel.com, Josh Boyer <jwboyer@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Aug 2019 16:11:20 +0300
In-Reply-To: <1736104d-3ef4-83d1-2672-00f36b922ef7@mageia.org>
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
         <1736104d-3ef4-83d1-2672-00f36b922ef7@mageia.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Regression with the latest iwlwifi-9260-*-46.ucode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-09 at 22:00 +0300, Thomas Backlund wrote:
> Den 06-08-2019 kl. 16:04, skrev Takashi Iwai:
> > On Mon, 05 Aug 2019 14:03:55 +0200,
> > Now we got a feedback from the latest linux-firmware (20190726) and
> > surprising the result was negative.  The dmesg after the cold boot is
> > found at:
> >    https://bugzilla.suse.com/show_bug.cgi?id=1142128#c26
> > 
> > The kernel is 5.2.3, so it should be new enough.
> > 
> > If anything else needed (or something missing), let us know.
> > 
> 
> I read on some forum that some commented that the "Add support for SAR 
> South Korea limitation" fix is needed, but it seemed weird...
> 
> Anyway, with theese on top of 5.2.7
> 
> 39bd984c203e86f3  iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version 
> < 41
> f5a47fae6aa3eb06  iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT 
> support
> 0c3d7282233c7b02  iwlwifi: Add support for SAR South Korea limitation
> 
> 
> We have confirmation from an affected user that its now stable with both 
> older and newer firmwares...
> 
> And we earlier tried with only the:
> 39bd984c203e86f3  iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version 
> < 41
> 
> But that did not help (not that I really expected it since its loading 
> version 46 firmwares anyway)
> 
> So my guess is that the newer firmware actually subtly expects to get 
> the behaviour of the:
> 0c3d7282233c7b02  iwlwifi: Add support for SAR South Korea limitation
> 
> Of course that's still guessing and I assume only Intel fw guys can 
> verify that...

Yes, you need the 3 patches.  The first two should solve the
"BAD_COMMAND" issue and the last one fixes the "NMI_INTERRUPT_WDG"
issue.

The first two are already in v5.3-rc4 and in v5.2.9 stable.

I'm going to send the third one to stable now.

--
Cheers,
Luca.

