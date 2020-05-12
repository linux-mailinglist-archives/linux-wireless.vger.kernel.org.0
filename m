Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED0B1CEA63
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 03:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgELB6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 21:58:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:19157 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgELB6c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 21:58:32 -0400
IronPort-SDR: 64w399iFxKgVqqPMmmrzBQVUNJz4VPSORNPs36c0qdsc6HVJwPk8U5n6nUgv5POcl5fm7JMgUR
 YYOQgB3jNZ3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 18:58:31 -0700
IronPort-SDR: /wi+FMfPtOrjVIxuhWeElC5VdPRFxcpccZVgmRFolElnJhL2nqL+MPAYXcPBkEJFme2SPdn3B7
 NtQwAgffx9oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="286470510"
Received: from xwang69-mobl1.ccr.corp.intel.com ([10.249.168.68])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 18:58:29 -0700
Message-ID: <4b6a9dbf43a33354c01d760f7fab3723e5882269.camel@intel.com>
Subject: Re: [PATCH 1/6] iwlwifi: use thermal_zone_device_update() for
 temperature change
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        luciano.coelho@intel.com
Date:   Tue, 12 May 2020 09:58:28 +0800
In-Reply-To: <20200430063229.6182-2-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
         <20200430063229.6182-2-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-04-30 at 14:32 +0800, Zhang Rui wrote:
> thermal_notify_framework() is an obsolete API, and iwlwifi is the
> only
> user of it.
> Convert iwlwifi driver to use thermal_zone_device_update() instead.
> 
> Note that, thermal_zone_device_update() is able to handle the crossed
> threshold by comparing the current temperature with every trip point,
> so
> ths_crossed variant in iwl_mvm_temp_notif() is probably not needed.
> It is still left there in this patch, in case the debug information
> is
> still needed.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Hi, Luca,

Any comments about this patch and patch 6/6?

thanks,
rui

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 418e59b..6344b6b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -203,9 +203,8 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm,
> struct iwl_rx_cmd_buffer *rxb)
>  
>  	if (mvm->tz_device.tzone) {
>  		struct iwl_mvm_thermal_device *tz_dev = &mvm-
> >tz_device;
> -
> -		thermal_notify_framework(tz_dev->tzone,
> -					 tz_dev-
> >fw_trips_index[ths_crossed]);
> +		thermal_zone_device_update(tz_dev->tzone,
> +					   THERMAL_EVENT_UNSPECIFIED);
>  	}
>  #endif /* CONFIG_THERMAL */
>  }

