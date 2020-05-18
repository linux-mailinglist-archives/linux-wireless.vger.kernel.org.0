Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB44F1D76BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgERLVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 07:21:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33210 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726499AbgERLVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 07:21:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jadpb-000cvW-JP; Mon, 18 May 2020 14:21:16 +0300
Message-ID: <bc0d0a9155f198f0ae34045932598b237e82d157.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        gil.adam@intel.com
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com
Date:   Mon, 18 May 2020 14:21:13 +0300
In-Reply-To: <4b6a9dbf43a33354c01d760f7fab3723e5882269.camel@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
         <20200430063229.6182-2-rui.zhang@intel.com>
         <4b6a9dbf43a33354c01d760f7fab3723e5882269.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 1/6] iwlwifi: use thermal_zone_device_update() for
 temperature change
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-05-12 at 09:58 +0800, Zhang Rui wrote:
> On Thu, 2020-04-30 at 14:32 +0800, Zhang Rui wrote:
> > thermal_notify_framework() is an obsolete API, and iwlwifi is the
> > only
> > user of it.
> > Convert iwlwifi driver to use thermal_zone_device_update() instead.
> > 
> > Note that, thermal_zone_device_update() is able to handle the crossed
> > threshold by comparing the current temperature with every trip point,
> > so
> > ths_crossed variant in iwl_mvm_temp_notif() is probably not needed.
> > It is still left there in this patch, in case the debug information
> > is
> > still needed.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Hi, Luca,
> 
> Any comments about this patch and patch 6/6?

Hi Rui,

Sorry for the delay, we have been making some small changes in this
code to support a new interface with our firmware and I wanted to make
sure things work together.

I'm adding Gil, who is making the changes, to this thread so he can
also take a look.

--
Cheers,
Luca.

