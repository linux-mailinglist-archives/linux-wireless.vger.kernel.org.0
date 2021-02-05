Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B83108A5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 11:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhBEKA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 05:00:59 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43846 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230482AbhBEJ6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:58:08 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7xrW-0044mA-PS; Fri, 05 Feb 2021 11:57:15 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210205110447.f5a3d53301b3.I23e84c9bb0b039d9106a07e9d6847776757f9029@changeid>
References: <iwlwifi.20210205110447.f5a3d53301b3.I23e84c9bb0b039d9106a07e9d6847776757f9029@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l7xrW-0044mA-PS@farmhouse.coelho.fi>
Date:   Fri, 05 Feb 2021 11:57:14 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [RESEND PATCH 01/12] iwlwifi: mvm: advertise BIGTK client support
 if
 available
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the firmware has support, then advertise it to the stack and
> send the key down. Since we re-check the protection in the host
> anyway, we don't really need to do anything on RX except that we
> should drop frames that the firmware _knows_ are replay errors,
> since beacon filtering might otherwise result in replays being
> possible.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

11 patches applied to iwlwifi-next.git, thanks.

b1fdc2505abc iwlwifi: mvm: advertise BIGTK client support if available
e497bed1a284 iwlwifi: bump FW API to 60 for AX devices
46e64deaa868 iwlwifi: fw api: make hdr a zero-size array again
85b7eb490e86 iwlwifi: mvm: slightly clean up rs_fw_set_supp_rates()
6f60fb03c8e7 iwlwifi: move SnJ and So rules to the new tables
930be4e76f26 iwlwifi: add support for SnJ with Jf devices
11f8c533da72 iwlwifi: mvm: move early time-point before nvm_init in non-unified
7f9c3bc465b2 iwlwifi: pcie: add support for SnJ with Hr1
d8cf2cfa9746 iwlwifi: mvm: cancel the scan delayed work when scan is aborted
d8367b124cf6 iwlwifi: mvm: make iwl_mvm_tt_temp_changed() static
e5d153ec54f0 iwlwifi: mvm: fix CSA AP side

