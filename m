Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924D43B0421
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhFVMVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:21:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48520 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229912AbhFVMVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:21:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfNA-001aw0-Np; Tue, 22 Jun 2021 15:19:22 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210617100544.80fee3171b53.Idfb69643f4044ec26865d023d0c2a1d6466694aa@changeid>
References: <iwlwifi.20210617100544.80fee3171b53.Idfb69643f4044ec26865d023d0c2a1d6466694aa@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfNA-001aw0-Np@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:19:21 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 09/12] iwlwifi: advertise broadcast TWT support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Shaul Triebitz <shaul.triebitz@intel.com>
> 
> If the firmware supports broadcast TWT (know by TLV),
> add the broadcast TWT HE MAC capability.
> 
> Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

2 patches applied to iwlwifi-next.git, thanks.

aa66e4a781e0 iwlwifi: advertise broadcast TWT support
3eaad5e670b2 iwlwifi: pcie: fix some kernel-doc comments

