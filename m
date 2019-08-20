Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1D95C80
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 12:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfHTKpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 06:45:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:32840 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTKpk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 06:45:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="185877433"
Received: from pkacprow-mobl.ger.corp.intel.com ([10.252.30.96])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2019 03:45:38 -0700
Message-ID: <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Stuart Little <achirvasub@gmail.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Date:   Tue, 20 Aug 2019 13:45:37 +0300
In-Reply-To: <20190817214448.GB1070@chirva-slack.chirva-slack>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
         <87y2zsf9ps.fsf@depni.sinp.msu.ru>
         <20190817214448.GB1070@chirva-slack.chirva-slack>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-08-17 at 17:44 -0400, Stuart Little wrote:
> After some private coaching from Serge Belyshev on git-revert I can
> confirm that reverting that commit atop the current tree resolves the
> issue (the wifi card scans for and finds networks just fine, no dmesg
> errors reported, etc.).

Sorry for the delay in responding, I had to go and dig in our FW
sources to see what was going on.

Unfortunately when this feature was implemented in the FW, we forgot to
add the usual flag (capabilities TLV) that we add to let the driver
know whether the command is supported or not.  So we need to match on
the FW version instead, but apparently that doesn't work for all
different NICs.

I'll have to look into all NIC/FW-version combinations that we have and
update the iwl_mvm_sar_geo_support() function accordingly, which is,
BTW, the easier place for you to change if you want to workaround the
issue.

--
Cheers,
Luca.

