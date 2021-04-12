Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7035C3F2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhDLK2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:28:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44606 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239060AbhDLK1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:27:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVtms-000KwV-TF; Mon, 12 Apr 2021 13:27:24 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210411132130.3d710091a0bd.I37a161ffdfb099a10080fbdc3b70a4deb76952e2@changeid>
References: <iwlwifi.20210411132130.3d710091a0bd.I37a161ffdfb099a10080fbdc3b70a4deb76952e2@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lVtms-000KwV-TF@farmhouse.coelho.fi>
Date:   Mon, 12 Apr 2021 13:27:24 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 1/8] iwlwifi: mvm: don't disconnect immediately if we
 don't
 hear beacons after CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> When we switch channel, we may miss a few beacons on the
> new channel. Don't disconnect if the time event for the
> switch ends before we hear the beacons.
> 
> Note that this is relevant only for old devices that still
> use the TIME_EVENT firmware API for channel switch.
> 
> The check that we hear a beacon before the time event
> ends was meant to be used for the association time event
> and not for the channel switch time event.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

7 patches applied to iwlwifi-next.git, thanks.

55479e240a84 iwlwifi: mvm: don't disconnect immediately if we don't hear beacons after CSA
668b20543dba iwlwifi: mvm: don't WARN if we can't remove a time event
5bae940ed691 iwlwifi: bump FW API to 63 for AX devices
0e6f59832e4a iwlwifi: trans/pcie: defer transport initialisation
e7a33279d670 iwlwifi: fw: print out trigger delay when collecting data
3ba2a6e76c03 iwlwifi: pcie: Change ma product string name
1a9674efd536 iwlwifi: dbg: disable ini debug in 9000 family and below

