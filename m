Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5328074C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgJAS5t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 14:57:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53654 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729047AbgJAS5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 14:57:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3ly-002NCS-U9; Thu, 01 Oct 2020 21:57:47 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200930102759.58d57c0bdc68.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
References: <iwlwifi.20200930102759.58d57c0bdc68.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3ly-002NCS-U9@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 21:57:46 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2 05/15] iwlwifi: mvm: split a print to avoid a WARNING
 in
 ROC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> A print in the remain on channel code was too long and caused
> a WARNING, split it.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Fixes: dc28e12f2125 ("iwlwifi: mvm: ROC: Extend the ROC max delay duration & limit ROC duration")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to iwlwifi-next.git, thanks.

903b3f9badf1 iwlwifi: mvm: split a print to avoid a WARNING in ROC

