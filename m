Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD93AADE5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFQHpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFQHp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:45:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091AC061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 00:43:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ltmgB-007xZi-EJ; Thu, 17 Jun 2021 09:43:11 +0200
Message-ID: <03ef297b35b87ed8f3c111cf7e67592b1c8e29a9.camel@sipsolutions.net>
Subject: Re: [PATCH 11/12] iwlwifi: pcie: remove TR/CR tail allocations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 09:43:09 +0200
In-Reply-To: <iwlwifi.20210617100544.b5c639f3866f.I4d5de1929be048085767f1234a1e07b517ab6a2d@changeid> (sfid-20210617_091102_610763_E92F4BD5)
References: <20210617070852.496985-1-luca@coelho.fi>
         <iwlwifi.20210617100544.b5c639f3866f.I4d5de1929be048085767f1234a1e07b517ab6a2d@changeid>
         (sfid-20210617_091102_610763_E92F4BD5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-06-17 at 10:08 +0300, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The TR/CR tail data are meant to be per-queue-arrays, however,
> we allocate them completely wrong (we have a separate allocation
> per queue).
> 
> Looking at this more closely, it turns out that the hardware
> never uses these - we have a separate free list per RX queue
> and maintain a write pointer for that in a register, and the
> RX itself is indicated in the RB status (rb_stts) DMA region.
> 
> Therefore, remove the TR/CR tail allocations completely.

I guess you should've updated the commit message when squashing in the
fix here - we do need to give it dummy pointers, and the hardware *does*
use them, just for no relevant purpose :)

johannes

