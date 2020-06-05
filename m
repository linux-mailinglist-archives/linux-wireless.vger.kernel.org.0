Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB31EF1F0
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFEHVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEHVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 03:21:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E4C08C5C2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 00:21:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jh6f9-009wbC-Bz; Fri, 05 Jun 2020 09:21:11 +0200
Message-ID: <ec6ea6eea17d7e8a6abaf35e78ffac7568e54831.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7663: introduce ARP filter offload
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     ryder.lee@mediatek.com, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Date:   Fri, 05 Jun 2020 09:21:09 +0200
In-Reply-To: <e91990d20a1a5f8d134fc9d9df152d9356fd15f9.1591340650.git.lorenzo@kernel.org> (sfid-20200605_090717_383122_E28D553B)
References: <e91990d20a1a5f8d134fc9d9df152d9356fd15f9.1591340650.git.lorenzo@kernel.org>
         (sfid-20200605_090717_383122_E28D553B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-06-05 at 09:07 +0200, Lorenzo Bianconi wrote:
> 
> +		.arp = {
> +			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
> +			.len = cpu_to_le16(sizeof(struct mt7615_arpns_tlv)),
> +			.ips_num = info->arp_addr_cnt,


Surely there's *some* hardware limit, after which you need to disable
the filter? Or does the firmware take the data and discard it, it it's
got too many IPs?

At the very least, only 255 fit in there, and at least theoretically you
can assign more to the netdev :)

johannes


