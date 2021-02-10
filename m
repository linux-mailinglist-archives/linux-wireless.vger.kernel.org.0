Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15D13174D7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 00:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBJX7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 18:59:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45486 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232318AbhBJX67 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 18:58:59 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9zN5-004AD5-4O; Thu, 11 Feb 2021 01:58:11 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
References: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l9zN5-004AD5-4O@farmhouse.coelho.fi>
Date:   Thu, 11 Feb 2021 01:58:11 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2] iwlwifi: pnvm: implement reading PNVM from UEFI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> We now support fetching the PNVM data from a UEFI variable.  Add the
> code to read this variable first and use it.  If it's not available,
> we fall back to reading the data from the filesystem, as before.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to iwlwifi-next.git, thanks.

a1a6a4cf49ec iwlwifi: pnvm: implement reading PNVM from UEFI

