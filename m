Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349FC1BA36D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgD0MQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 08:16:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58544 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgD0MQI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 08:16:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jT2g9-000QHL-Cp; Mon, 27 Apr 2020 15:16:06 +0300
Message-ID: <c916052935b283fa373a291e9af5036f6ea310b8.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     You-Sheng Yang <vicamo@gmail.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Mon, 27 Apr 2020 15:16:03 +0300
In-Reply-To: <f056d364-d85d-8acd-dd74-7d1b64f6d6ae@gmail.com>
References: <iwlwifi.20200424121518.b715acfbe211.I273a098064a22577e4fca767910fd9cf0013f5cb@changeid>
         <f056d364-d85d-8acd-dd74-7d1b64f6d6ae@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: Re: [PATCH v5.7] iwlwifi: pcie: handle QuZ configs with killer NICs
 as well
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-04-27 at 14:50 +0800, You-Sheng Yang wrote:
> Hi Luca,
> 
> I have backported this to Ubuntu kernels in my ppa[1], and it doesn't
> really fix firmware crash on Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless
> Network Adapter (201NGW), REV=0x354 [8086:a0f0] subsystem id [1a56:1651].
> 
> [1]: https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1874685

Thanks for reporting, You-Sheng!

What is the crash that you are seeing? The same one during INIT?

Please note that on v5.6 the code is slightly different, so you need to
use cfg instead of iwl_trans->cfg.

--
Luca.

