Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA14663A4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 13:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbhLBMbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 07:31:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50148 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240476AbhLBMbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 07:31:42 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mslCD-0015GS-0K; Thu, 02 Dec 2021 14:28:18 +0200
Message-ID: <eec1431093f754a0d0b12f8db69cf4199f9a7742.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 02 Dec 2021 14:28:15 +0200
In-Reply-To: <iwlwifi.20211129152938.8efcf1856975.I130f678e4aa390973ab39d838bbfe7b2d54bff8e@changeid>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.8efcf1856975.I130f678e4aa390973ab39d838bbfe7b2d54bff8e@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 04/16] cfg80211: Use the HE operation IE to determine a
 6GHz BSS channel
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-11-29 at 15:32 +0200, Luca Coelho wrote:
> From: Ayala Beker <ayala.beker@intel.com>
> 
> A non-collocated AP whose primary channel is not a PSC channel
> may transmit a duplicated beacon on the corresponding PSC channel
> in which it would indicate its true primary channel.
> Use this inforamtion contained in the HE operation IE to determine
> the primary channel of the AP.
> In case of invalid infomration ignore it and use the channel
> the frame was received on.
> 
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

As you know already (but for the record), this is totally broken. 
There were some conflicts due to the refactor that happened in this
function and I accidentally ran the wrong script to test compilation
before sending this series out... :(

V2 coming up soon.

--
Cheers,
Luca.
