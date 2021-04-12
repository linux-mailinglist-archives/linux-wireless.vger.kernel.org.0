Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042D235C687
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhDLMpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbhDLMpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 08:45:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9DC061574
        for <linux-wireless@vger.kernel.org>; Mon, 12 Apr 2021 05:45:07 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lVvw8-00AhLv-6S; Mon, 12 Apr 2021 14:45:04 +0200
Message-ID: <18627505ec45f8e5a0e424c3f3f9ca204cb1830c.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7921: remove 80+80 MHz support capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Mon, 12 Apr 2021 14:45:03 +0200
In-Reply-To: <20210411104751.24103-1-nbd@nbd.name> (sfid-20210411_124815_153590_D48D247A)
References: <20210411104751.24103-1-nbd@nbd.name>
         (sfid-20210411_124815_153590_D48D247A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-04-11 at 12:47 +0200, Felix Fietkau wrote:
> This mode is not supported by the hardware
> 
You say this "mode" (singular), and the subject says "80+80",

> -		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
> -		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);

but you proceed to also remove 160, was that intentional?

johannes

