Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B591AD636
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgDQGgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 02:36:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56336 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727852AbgDQGgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 02:36:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPKcD-000KLr-Q1; Fri, 17 Apr 2020 09:36:42 +0300
Message-ID: <2f4efddf7bd584b212830ce872c24b026a6345ce.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, emmanuel.grumbach@intel.com
Date:   Fri, 17 Apr 2020 09:36:40 +0300
In-Reply-To: <iwlwifi.20200403112332.d08b8dd271ee.I8dfe8a7d3a7ac9f0bc9d93e4a03f8165d8c999d2@changeid>
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.d08b8dd271ee.I8dfe8a7d3a7ac9f0bc9d93e4a03f8165d8c999d2@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v5.7 6/8] iwlwifi: msix: limit max RX queues for 9000
 family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-03 at 11:29 +0300, Luca Coelho wrote:
> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> There is an issue in the HW DMA engine in the 9000 family of devices
> when more than 6 RX queues are used.  The issue is that the FW may
> hang when IWL_MVM_RXQ_NSSN_SYNC notifications are sent.
> 
> Fix this by limiting the number of RX queues to 6 in the 9000 family
> of devices.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

As Emmanuel pointed out, we have disabled NSSN in the driver for now,
so this doesn't have to go to -fixes and stable.  I'll drop it in v2 of
this patchset.

--
Cheers,
Luca.

