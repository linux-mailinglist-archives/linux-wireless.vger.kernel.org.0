Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150596E8DE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfGSQg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 12:36:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:24763 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGSQg5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 12:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 09:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,283,1559545200"; 
   d="scan'208";a="195998381"
Received: from mzoranov-mobl.amr.corp.intel.com ([10.252.2.145])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2019 09:36:54 -0700
Message-ID: <280dad08ba9864755c3c45ed3ce26d602fe18a49.camel@intel.com>
Subject: Re: Regression with the latest iwlwifi-9260-*-46.ucode
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dor.shaish@intel.com, Josh Boyer <jwboyer@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jul 2019 19:36:53 +0300
In-Reply-To: <s5hr26m9gvc.wl-tiwai@suse.de>
References: <s5hr26m9gvc.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding Dor.

Hi Takashi,

Do you have full logs of the crash? We can't see much from the log
snippet pasted in the bug report.

In any case, today or tomorrow, I'll release a new FW version for 9260,
hopefully it will solve the problem.  I'll send you a link so you can
test it when I push it to our tree (which feeds linux-firmware.git).

Thanks for reporting!

--
Cheers,
Luca.


On Fri, 2019-07-19 at 17:35 +0200, Takashi Iwai wrote:
> Hi,
> 
> we've got a report about the regression with the latest iwlwifi 9260
> *-46.ucode that landed recently in linux-firmware tree.  WiFi doesn't
> work any longer on some Dell machines with that firmware.  See details
> in:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1142128
> 
> Currently we're reverting to the previously released firmware files.
> 
> Is it a known problem that has been already addressed?
> If not, shall we revert the changes as a tentative workaround?
> 
> 
> Thanks!
> 
> Takashi

