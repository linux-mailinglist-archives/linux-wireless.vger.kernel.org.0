Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3706648C115
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352128AbiALJfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352111AbiALJfK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 04:35:10 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222AC061748
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 01:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pPA/3Dk8AHPXuw7qUy4aZpwFuX5nyk1msQNRNYWCko8=;
        t=1641980110; x=1643189710; b=eCNvey9JhQs/LVmamcmdsQqaI/F/lWQvmxoLwuBlkc551nN
        nzpDDjYd3ks/dZDUD+THJAWUxHlZQ+ARFIvdt8H9IC3i40yZAmEppPSQLQOC2E4oxJ+38zJs0poW8
        pEPvgpZsssiqPK0JxJB+hpb0tJOhfhaxSyU2yCr824NASUvK0X2LXZBNymggVl+qjcKfcuPBrrD4B
        TDg//08Y7qI4OWmj38Lib9dRoQVS1TfhjTxfmi640KyQcc7oujpJbNOZzi9nf8STrGT7CZoBdN0u0
        24k6cclrwgy+XP5KfmGfdiqbd9hVYZN7kKrFOPrBx/Znp7alas3C9tKNj0fMaoJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n7a23-004k2b-8n;
        Wed, 12 Jan 2022 10:35:03 +0100
Message-ID: <770267e4ad06661383dd16afbd51690cfad58d49.camel@sipsolutions.net>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 12 Jan 2022 10:35:02 +0100
In-Reply-To: <9644c62f580e30a2b7fc3d62b67db0b1e64872c7.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
         <ab9e48ae8dad3187d206d46fc1d997245ecbc3ef.camel@sipsolutions.net>
         <9644c62f580e30a2b7fc3d62b67db0b1e64872c7.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-01-12 at 09:33 +0000, Coelho, Luciano wrote:
> On Wed, 2022-01-12 at 10:27 +0100, Johannes Berg wrote:
> > > 
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > > b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > > index 863fec150e53..f13825185094 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > > @@ -834,6 +834,9 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm
> > > *mvm)
> > >                      offsetof(struct
> > > iwl_geo_tx_power_profiles_cmd_v4, ops) !=
> > >                      offsetof(struct
> > > iwl_geo_tx_power_profiles_cmd_v5, ops));
> > >  
> > > +       if (!iwl_sar_geo_support(&mvm->fwrt))
> > > +               return -EOPNOTSUPP;
> > > +
> > >         /* the ops field is at the same spot for all versions, so
> > > set in v1 */
> > >         cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
> > 
> > I was going to say it should probably return 0, but the caller looks
> > a
> > bit fishy too?
> > 
> >         ret = iwl_mvm_sar_init(mvm);
> >         if (ret == 0)
> >                 ret = iwl_mvm_sar_geo_init(mvm);
> >         else if (ret < 0)
> >                 goto error;
> > 
> >         ret = iwl_mvm_sgom_init(mvm);
> > 
> > should that "else" be removed?
> 
> Yeah, I noticed the same thing when I checked the return value... I
> don't think we want to abort everything if SAR GEO init failed, so
> maybe we should just remove the return value from the function?
> 

Well the only real failure path there is "we cannot send the command",
in which case we might as well abort?

IOW, we already return 0 in the cases where we don't have the data or
something else happened (also for !CONFIG_ACPI).

johannes
