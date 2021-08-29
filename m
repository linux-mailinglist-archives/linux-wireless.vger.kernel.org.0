Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92293FAD0C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhH2QQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 12:16:56 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50228 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235648AbhH2QQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 12:16:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mKNTU-0001fM-LE; Sun, 29 Aug 2021 19:16:01 +0300
Message-ID: <e048218dbe3338124ba09908cb1e49ec89214a96.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Aug 2021 19:15:59 +0300
In-Reply-To: <87wno44i8k.fsf@codeaurora.org>
References: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi>
         <87wno44i8k.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: pull-request: iwlwifi-next 2021-08-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-08-29 at 14:12 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > Hi Kalle,
> > 
> > Here's my pull request for v5.15 with all the patchesets I sent
> > earlier.  This is all normal development, new features, bugfixes and
> > cleanups.  More details about the contents in the tag description.
> > 
> > Please let me know if there are any issues.
> > 
> > Cheers,
> > Luca.
> > 
> > 
> > The following changes since commit e3f30ab28ac866256169153157f466d90f44f122:
> > 
> >   Merge branch 'pktgen-samples-next' (2021-08-25 13:44:30 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-08-26
> > 
> > for you to fetch changes up to d9a406ac813dd6a4cfc92bc2576adf43219792ef:
> > 
> >   iwlwifi: bump FW API to 66 for AX devices (2021-08-26 23:39:05 +0300)
> > 
> > ----------------------------------------------------------------
> > iwlwifi patches for v5.15
> > 
> > * Support scanning hidden 6GHz networks;
> > * Some improvements in the FW error dumps;
> > * Add some HE capability flags
> > * A bunch of janitorial clean-ups;
> > * Clean-ups in the TX code;
> > * Small fix for SMPS;
> > * Support for a new hardware family (Bz);
> > * Small fix in the scan code;
> > * A bunch of changes in the D3 code, including new FW API;
> > * Finalize the refactoring of 6GHz scan;
> > * Initial changes in the SAR profile code;
> > * Fix reading one of our ACPI tables (WTAS);
> > * Support some new ACPI table revisions;
> > * Support new API of the WoWlan status FW notification;
> > * Fixes in SAR ACPI tables handling;
> > * Some debugging improvements;
> > * Fix in ROC;
> > * Support for new FW API versions;
> > * Support new FW command versions;
> > * Ongoing work on support for Bz devices;
> > * Add new DHC framework to help with debugging of FW flows;
> > * Some other small fixes, clean-ups and improvements.
> > 
> > ----------------------------------------------------------------
> 
> I'm not convinced about CONFIG_IWLWIFI_DHC option yet, that needs more
> discussion.

Okay, so just let me know what the issue is (now that we depend on
EXPERT) and let's decide what to do with it.


> As the merge window most likely starts today, and I didn't want to
> unnecessarily delay rest of iwlwifi patches, I decided to pull from a
> commit before that DHC stuff:
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git e257d969f36503b8eb1240f32653a1afb3109f86
> 
> So pulled, thanks.

Thanks for pulling! But we also need at least the top patch in my pull-
req, the one that bumps the FW API...

--
Cheers,
Luca.

