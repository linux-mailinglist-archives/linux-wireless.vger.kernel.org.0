Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255523F8FBD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhHZUjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:39:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33550 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229966AbhHZUjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:39:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM9C-002XND-M2; Thu, 26 Aug 2021 23:38:52 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210826224715.9dcd5210b7e5.I76f6977cde852de0f251344e279ad85076eef8d6@changeid>
References: <iwlwifi.20210826224715.9dcd5210b7e5.I76f6977cde852de0f251344e279ad85076eef8d6@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM9C-002XND-M2@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:38:51 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH v2 01/12] iwlwifi: mvm: add support for range request
 command
 version 13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Avraham Stern <avraham.stern@intel.com>
> 
> This version adds the following configuration options:
> 1. Set the BSS color for NDP ranging
> 2. Set the minimum and maximum time between measurements for
>    non trigger based NDP ranging.
> 3. Terminate the session in case the responder requests LMR feedback.
> 
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

830aa3e7d1ca iwlwifi: mvm: add support for range request command version 13
bd34ff380e78 iwlwifi: mvm: add support for responder config command version 9
b05c1d14a177 iwlwifi: move get pnvm file name to a separate function
fb3fac5fafa8 iwlwifi: mvm: introduce iwl_stored_beacon_notif_v3
cde5dbaa35ed iwlwifi: mvm: support broadcast TWT alone
090f1be3abf3 iwlwifi: mvm: Fix scan channel flags settings
e257d969f365 iwlwifi: mvm: don't use FW key ID in beacon protection
765fdb17276a iwlwifi: export DHC framework and add first public entry, twt_setup
4956fe796656 iwlwifi: mvm: add fixed_rate debugfs entry to public DHC
610666bec1ea iwlwifi: Add support for getting rf id with blank otp
cc6358a93c3a iwlwifi: Add support for more BZ HWs
1b740380f5fa iwlwifi: Start scratch debug register for Bz family

