Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2439017F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhEYNCT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhEYNCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 09:02:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665DC061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 06:00:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1llWfo-00EOlC-PS; Tue, 25 May 2021 15:00:40 +0200
Message-ID: <47f9c5c2a9c5fd666751e01799a9a167d8776a49.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/4] mac80211: minstrel_ht: fix minstrel_aggr_check
 for encap offload
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Tue, 25 May 2021 15:00:39 +0200
In-Reply-To: <4e50d38c98c407825c6897a034fee3ba6366b0ad.1621453091.git.ryder.lee@mediatek.com> (sfid-20210519_215642_904470_7AA3F138)
References: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
         <4e50d38c98c407825c6897a034fee3ba6366b0ad.1621453091.git.ryder.lee@mediatek.com>
         (sfid-20210519_215642_904470_7AA3F138)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-05-20 at 03:56 +0800, Ryder Lee wrote:
> 
> +	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> +	    unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
>  		return;

That unlikely() placement seems odd?

johannes

