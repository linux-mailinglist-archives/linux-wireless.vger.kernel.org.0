Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642F534B111
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZVJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 17:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhCZVJm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 17:09:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F13C0613AA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 14:09:41 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lPti6-003cyy-S5; Fri, 26 Mar 2021 22:09:38 +0100
Message-ID: <249e2022c17f2555445061e533353ccd6f9e9b60.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] mt76: mt7615: 0-terminate firmware log messages
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 22:09:35 +0100
In-Reply-To: <20210326205505.74383-1-nbd@nbd.name> (sfid-20210326_215548_974123_3E7CAD0D)
References: <20210326205505.74383-1-nbd@nbd.name>
         (sfid-20210326_215548_974123_3E7CAD0D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> +	skb->data[skb->len] = 0;
>  	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
>  }
> 

Are you sure there's always enough space to write to the skb? Following
the code up I'm not even sure it's always a linear skb :-)

Might be safer/better to do

	wiphy_info(..., "%s: %*s", type, skb->len - sizeof(*rxd),
data);

instead?

johannes


