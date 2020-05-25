Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C351E069D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEYGEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 02:04:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:54830 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgEYGEO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 02:04:14 -0400
IronPort-SDR: 9kSyWfSvVnFiImzQbfz4lfIRwXxW/sD63mkQRaKZGh7bhhMRGEHBYKuLmej4Zq60gbVydad3Mp
 /r10NfXqxlXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 23:04:14 -0700
IronPort-SDR: D6ARfgQKmyak0pTwPydc2j7ckIr9NtLPXVLz1XKc05GS8ByFc4i5VGMgDD4Q82WDtgMcEiUALi
 kbJ9mr/PTk1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="413409315"
Received: from xianrong-mobl1.ccr.corp.intel.com ([10.249.173.7])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2020 23:04:12 -0700
Message-ID: <e7655f68dd3d351720905c9a281dcf9a45a54d7d.camel@intel.com>
Subject: Re: [PATCH 1/6] iwlwifi: use thermal_zone_device_update() for
 temperature change
From:   Zhang Rui <rui.zhang@intel.com>
To:     Luca Coelho <luca@coelho.fi>, linux-pm@vger.kernel.org,
        gil.adam@intel.com
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com
Date:   Mon, 25 May 2020 14:04:11 +0800
In-Reply-To: <bc0d0a9155f198f0ae34045932598b237e82d157.camel@coelho.fi>
References: <20200430063229.6182-1-rui.zhang@intel.com>
         <20200430063229.6182-2-rui.zhang@intel.com>
         <4b6a9dbf43a33354c01d760f7fab3723e5882269.camel@intel.com>
         <bc0d0a9155f198f0ae34045932598b237e82d157.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-18 at 14:21 +0300, Luca Coelho wrote:
> On Tue, 2020-05-12 at 09:58 +0800, Zhang Rui wrote:
> > On Thu, 2020-04-30 at 14:32 +0800, Zhang Rui wrote:
> > > thermal_notify_framework() is an obsolete API, and iwlwifi is the
> > > only
> > > user of it.
> > > Convert iwlwifi driver to use thermal_zone_device_update()
> > > instead.
> > > 
> > > Note that, thermal_zone_device_update() is able to handle the
> > > crossed
> > > threshold by comparing the current temperature with every trip
> > > point,
> > > so
> > > ths_crossed variant in iwl_mvm_temp_notif() is probably not
> > > needed.
> > > It is still left there in this patch, in case the debug
> > > information
> > > is
> > > still needed.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > Hi, Luca,
> > 
> > Any comments about this patch and patch 6/6?
> 
> Hi Rui,
> 
> Sorry for the delay, we have been making some small changes in this
> code to support a new interface with our firmware and I wanted to
> make
> sure things work together.
> 
> I'm adding Gil, who is making the changes, to this thread so he can
> also take a look.

thanks, Luca.

Gil,
can you please take a look at this patches series?

thanks,
rui
> 
> --
> Cheers,
> Luca.
> 

