Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8443B041F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFVMU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:20:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48512 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231381AbhFVMU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:20:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfMS-001avq-Bi; Tue, 22 Jun 2021 15:18:37 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <20210621080159.12883-1-emmanuel.grumbach@intel.com>
References: <20210621080159.12883-1-emmanuel.grumbach@intel.com>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfMS-001avq-Bi@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:18:37 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation
 with
 CSME
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> wrote:

> iwlmei is a driver that handles the communication with the
> Wireless driver of the CSME firmware.
> More details in the documentation included in this patch.
> 
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

4 patches applied to iwlwifi-next.git, thanks.

f90c5b67155b iwlwifi: mei: add the driver to allow cooperation with CSME
1d29ed03260a iwlwifi: integrate with iwlmei
eb69dbb955ea nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
25b74f1897c8 iwlwifi: mvm: add vendor commands needed for iwlmei

