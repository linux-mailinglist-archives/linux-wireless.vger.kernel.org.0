Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238744371BC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhJVG1w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 02:27:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229944AbhJVG1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 02:27:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdnzg-000beE-Fz; Fri, 22 Oct 2021 09:25:33 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210826224715.820c2ae18c2b.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
References: <iwlwifi.20210826224715.820c2ae18c2b.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.7
Message-Id: <E1mdnzg-000beE-Fz@farmhouse.coelho.fi>
Date:   Fri, 22 Oct 2021 09:25:32 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 10/12] iwlwifi: Add support for getting rf id with
 blank
 otp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Matti Gottlieb <matti.gottlieb@intel.com>
> 
> When having a blank OTP the only way to get the rf id
> and the cdb info is from prph registers.
> 
> Currently there is some implementation for this, but it
> is located in the wrong place in the code (should be before
> trying to understand what HW is connected and not after),
> and it has a partial implementation.
> 
> Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

3 patches applied to iwlwifi-next.git, thanks.

c5dd7b08bae0 iwlwifi: Add support for getting rf id with blank otp
f2bc2f70292e iwlwifi: Add support for more BZ HWs
ca5b81f972a8 iwlwifi: Start scratch debug register for Bz family

