Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7F815DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfHEJst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 05:48:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34084 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727259AbfHEJst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 05:48:49 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1huZbg-0003Tn-A1; Mon, 05 Aug 2019 12:48:44 +0300
Message-ID: <38635c1b10018859457787ecff4f92a3ceec34a4.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dor.shaish@intel.com, Josh Boyer <jwboyer@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 05 Aug 2019 12:48:43 +0300
In-Reply-To: <s5hmuh7xrqy.wl-tiwai@suse.de>
References: <s5hr26m9gvc.wl-tiwai@suse.de>
         <280dad08ba9864755c3c45ed3ce26d602fe18a49.camel@intel.com>
         <s5ho91pzyml.wl-tiwai@suse.de> <s5hwogcxwt4.wl-tiwai@suse.de>
         <b225d043d8581e0fec68cb63f7433161868293f3.camel@coelho.fi>
         <s5hmuh7xrqy.wl-tiwai@suse.de>
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

On Sun, 2019-07-21 at 18:43 +0200, Takashi Iwai wrote:
> On Sat, 20 Jul 2019 22:49:33 +0200,
> Luca Coelho wrote:
> > On Sat, 2019-07-20 at 22:42 +0200, Takashi Iwai wrote:
> > > On Fri, 19 Jul 2019 20:07:46 +0200,
> > > Takashi Iwai wrote:
> > > > On Fri, 19 Jul 2019 18:36:53 +0200,
> > > > Luciano Coelho wrote:
> > > > > Adding Dor.
> > > > > 
> > > > > Hi Takashi,
> > > > > 
> > > > > Do you have full logs of the crash? We can't see much from the log
> > > > > snippet pasted in the bug report.
> > > > 
> > > > OK, I'll ask reporters.  If you have a SUSE/openSUSE bugzilla account,
> > > > feel free to join there.
> > > 
> > > FYI, the dmesg's have been uploaded to the same bugzilla entry:
> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1142128
> > > 
> > 
> > Thanks!
> > 
> > BTW, I pushed new firmwares to our firmware tree in git.kernel.org
> > today.  This is the patch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/?id=b5f09bb4f816abace0227d0f4e749859364cef6b
> > 
> > It would be great if you can try it out and let us know whether the problem is gone or not.
> 
> I created a test package and asked for testing.
> The test result seems negative, showing the same error,
> unfortunately.
> 
> The dmesg was uploaded on the bugzilla entry.

Thanks Takashi! We will look into them as soon as possible (sorry for
the late reply, I just came back from vacations).

--
Cheers,
Luca.

