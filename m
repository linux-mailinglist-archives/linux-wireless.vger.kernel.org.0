Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0E3108A2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBEJ7F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:59:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43838 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230055AbhBEJ4t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:56:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7xqK-0044lu-By; Fri, 05 Feb 2021 11:56:01 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210117164916.1935a993b471.I3192c93c030576ca16773c01b009c4d93610d6ea@changeid>
References: <iwlwifi.20210117164916.1935a993b471.I3192c93c030576ca16773c01b009c4d93610d6ea@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l7xqK-0044lu-By@farmhouse.coelho.fi>
Date:   Fri, 05 Feb 2021 11:56:00 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 1/9] iwlwifi: mvm: don't send commands during
 suspend\resume
 transition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Haim Dreyfuss <haim.dreyfuss@intel.com>
> 
> D3_CONFIG_CMD and D0I3_END_CMD should be the last\first
> command upon suspend\resume correspondingly, otherwise,
> FW will raise an assert (0x342).
> 
> There are firmware notifications that cause the driver to
> send a command back to the firmware. If such a notification
> is sent to the driver while the the driver prepares the
> firmware for D3, operation, what is likely to happen is that
> the handling of the notification will try to get the mutex
> and will wait unil the driver finished configuring the
> firmware for D3. Then the handling notification will get
> the mutex and handle the notification which will lead to
> the aforementioned ASSERT 342.
> 
> To avoid this, we need to prevent any command to be sent to
> the firmware between the D3_CONFIG_CMD and the D0I3_END_CMD.
> Check this in the utility layer that sends the host commands
> and in the transport layer as well.
> Flag the D3_CONFIG_CMD and the D0I3_END_CMD commands as
> commands that must be sent even if the firmware has already
> been configured for D3 operation.
> 
> Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

9 patches applied to iwlwifi-next.git, thanks.

708a39aaca22 iwlwifi: mvm: don't send commands during suspend\resume transition
701625803ccc iwlwifi: mvm: csa: do not abort CSA before disconnect
a1d59263e718 iwlwifi: parse phy integration string from FW TLV
33fa519ac618 iwlwifi: mvm: debugfs for phy-integration-ver
6761a718263a iwlwifi: mvm: add explicit check for non-data frames in get Tx rate
13f028b4f748 iwlwifi: tx: move handing sync/async host command to trans
9aae43a450e8 iwlwifi: mvm: simplify TX power setting
5c255a10711b iwlwifi: mvm: debugfs: check length precisely in inject_packet
ddd83d328c3f iwlwifi: always allow maximum A-MSDU on newer devices

