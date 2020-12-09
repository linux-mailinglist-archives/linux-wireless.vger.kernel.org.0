Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7792D4D60
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgLIWNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:13:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35998 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388623AbgLIWNZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:13:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn7hK-003E5H-2J; Thu, 10 Dec 2020 00:12:34 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20201210000657.0fdbfc3d7352.Idb648536faf21716e2ab2c6d6890d3e49f719cd3@changeid>
References: <iwlwifi.20201210000657.0fdbfc3d7352.Idb648536faf21716e2ab2c6d6890d3e49f719cd3@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1rc1
Message-Id: <E1kn7hK-003E5H-2J@farmhouse.coelho.fi>
Date:   Thu, 10 Dec 2020 00:12:34 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v3 34/47] iwlwifi: mvm: add support for 6GHz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Add support to the 6GHz band (aka. Ultra High Band or UHB).  This
> allows us to scan and connect to channels in that band, including all
> the relevant features, such as preferred scan channels, colocated
> channels etc.
> 
> Co-developed-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Co-developed-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Co-developed-by: Tova Mussai <tova.mussai@intel.com>
> Signed-off-by: Tova Mussai <tova.mussai@intel.com>
> Co-developed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Co-developed-by: Tali Levi Rovinsky <Tali.Levi-rovinsky@intel.com>
> Signed-off-by: Tali Levi Rovinsky <Tali.Levi-rovinsky@intel.com>
> Co-developed-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Co-developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to iwlwifi-next.git, thanks.

eae94cf82d74 iwlwifi: mvm: add support for 6GHz

