Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC881CD956
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgEKMGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:06:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60540 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729591AbgEKMF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:05:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jY7C1-000YOo-FH; Mon, 11 May 2020 15:05:58 +0300
Message-ID: <7bc97e4bc723f79053c99624cb466b98b151dd0a.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 May 2020 15:05:55 +0300
In-Reply-To: <878shy66j1.fsf@kamboji.qca.qualcomm.com>
References: <20200508140802.558267-1-luca@coelho.fi>
         <iwlwifi.20200508170402.d1f52b76e1a2.Icb48c8d61bede5dda7ef267bff10e4798e9dc77b@changeid>
         <878shy66j1.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 04/11] iwlwifi: acpi: support device specific method
 (DSM)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-11 at 14:43 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Gil Adam <gil.adam@intel.com>
> > 
> > ACPI Device Specific Method (DSM) allows standardized feature
> > configuration through the ACPI interface without the namespace
> > pollution of the usual mechanism (ACPI method for each feature).
> > Add generic function for evaluating DSM objects and function for
> > evaluating a DSM with no arguments and a single int return value.
> > also implement the required backport for UUID.
> > 
> > Signed-off-by: Gil Adam <gil.adam@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > -void *iwl_acpi_get_object(struct device *dev, acpi_string method)
> > +const static guid_t intel_wifi_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
> 
> Isn't the standard style "static const"?

Yep, sorry, I'll fix it.

--
Luca.

