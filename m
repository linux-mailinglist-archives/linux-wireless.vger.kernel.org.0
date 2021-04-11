Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7835B32B
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKKab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:30:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44548 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229804AbhDKKaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:30:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXM2-000K1O-1y; Sun, 11 Apr 2021 13:30:11 +0300
Message-ID: <42815732c3c08868ca8fb7f8be5ff620c25bab41.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:30:10 +0300
In-Reply-To: <iwlwifi.20210411132130.f95c0cfd50f7.I15ab8fc214edc35f1f362006a9e1a22b89e7ed8e@changeid>
References: <20210411102545.438654-1-luca@coelho.fi>
         <iwlwifi.20210411132130.f95c0cfd50f7.I15ab8fc214edc35f1f362006a9e1a22b89e7ed8e@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 8/8] iwlwifi: mvm: add support for timing measurement
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-04-11 at 13:25 +0300, Luca Coelho wrote:
> From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
> 
> Add support for timing measurement in extended capabilities, used for
> time synchronization.
> 
> Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

I'm going to drop this one for now, because there is a dependency on a
change in ieee80211.h that is not in yet.

--
Luca.

