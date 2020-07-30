Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC6C2334D0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgG3OzG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3OzG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:55:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12CC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:55:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19xX-00DamX-8l; Thu, 30 Jul 2020 16:55:03 +0200
Message-ID: <accbebe93a2c851080b3544759eb5d17c15e646d.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] nl80211: support SAE authentication offload in AP
 mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Date:   Thu, 30 Jul 2020 16:55:02 +0200
In-Reply-To: <20200623134938.39997-4-chi-hsien.lin@cypress.com> (sfid-20200623_155000_965089_06BEA254)
References: <20200623134938.39997-1-chi-hsien.lin@cypress.com>
         <20200623134938.39997-4-chi-hsien.lin@cypress.com>
         (sfid-20200623_155000_965089_06BEA254)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-06-23 at 08:49 -0500, Chi-Hsien Lin wrote:
> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> Add support for SAE authentication offload in AP mode.

It seems to me you need a new feature flag for this, just like in the
PSK case, because brcmfmac in fact already sets this, and in fact as we
can see in patch 4 it would now set it in two places depending on
*different* firmware support conditions ... that may be OK for the
firmware right now, but it still doesn't really make much sense.

Please change to add another flag here.

johannes

