Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53ABC9A6EC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 07:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391832AbfHWFJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 01:09:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:27832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391823AbfHWFJU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 01:09:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 22:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="354511719"
Received: from pkacprow-mobl.ger.corp.intel.com ([10.252.30.96])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2019 22:09:15 -0700
Message-ID: <56cf56cdc54aa2deba627c5c1c51b7391e493ab9.camel@intel.com>
Subject: Re: [PATCH net-next 07/10] iwlwifi: Use dev_get_drvdata where
 possible
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 23 Aug 2019 08:09:14 +0300
In-Reply-To: <20190724112738.13457-1-hslester96@gmail.com>
References: <20190724112738.13457-1-hslester96@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 19:27 +0800, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---

This patch is not relevant anymore because we have removed all
D0i3/runtime PM code.

Thanks anyway!

--
Cheers,
Luca.

