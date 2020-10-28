Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018E529F5A4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJ2Tze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 15:55:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:21352 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgJ2Tyw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 15:54:52 -0400
IronPort-SDR: 6SZBjc0IQvxbtndxXRWmRbvJYREnkxulju584f5UZgveGGLUQSx/0hBFw5S6m2yYuqPusDBusj
 AJ3cG1QKEQMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168598586"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="168598586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:54:51 -0700
IronPort-SDR: 88k2oDCUJaWQkiLOPI4OdBpblCnqxFqfssFde4r32qerDHQzVjLNdtiOlGMAaKJ7W1YyQzvx+a
 IeM5YVI9FdiQ==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="469258630"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:54:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYE1Y-001Twp-7A; Thu, 29 Oct 2020 21:55:52 +0200
Date:   Wed, 28 Oct 2020 17:21:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>, verdre@v0yd.nl
Subject: Re: [PATCH 0/3] mwifiex: disable ps_mode by default for stability
Message-ID: <20201028152115.GT4077@smile.fi.intel.com>
References: <20201028142433.18501-1-kitakar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028142433.18501-1-kitakar@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 28, 2020 at 11:24:30PM +0900, Tsuchiya Yuto wrote:
> Hello all,
> 
> On Microsoft Surface devices (PCIe-88W8897), we are observing stability
> issues when ps_mode (IEEE power_save) is enabled, then eventually causes
> firmware crash. Especially on 5GHz APs, the connection is completely
> unstable and almost unusable.
> 
> I think the most desirable change is to fix the ps_mode itself. But is
> seems to be hard work [1], I'm afraid we have to go this way.
> 
> Therefore, the first patch of this series disables the ps_mode by default
> instead of enabling it on driver init. I'm not sure if explicitly
> disabling it is really required or not. I don't have access to the details
> of this chip. Let me know if it's enough to just remove the code that
> enables ps_mode.
> 
> The Second patch adds a new module parameter named "allow_ps_mode". Since
> other wifi drivers just disable power_save by default by module parameter
> like this, I also added this.
> 
> The third patch adds a message when ps_mode will be changed. Useful when
> diagnosing connection issues.

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=109681

Can you attach this to the actual patch as BugLink: tag?

-- 
With Best Regards,
Andy Shevchenko


