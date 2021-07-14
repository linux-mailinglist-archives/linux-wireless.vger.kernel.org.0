Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A163C7F64
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhGNHek (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbhGNHej (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 03:34:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10EC06175F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RG1iCBaT6E1VgpQV+JwxWmlLZlmtPr/DHuj0X5NRrws=;
        t=1626247908; x=1627457508; b=EMH6028hJevw2RRnDbc8IdUH7buH2s02ecyEFZHITK8dUo7
        +Ssu3pBBgkMcQaXvsCP6Ju4mOKJvh6NFNKjopVJR+8GUFYsjeg9EFpEtMtsqkLICXyn56uN6C7ib8
        fJZ/jJ1Aye8F8MolUj7ySXrFiyOIhNJWPwmTbo6HKayGODGmms1g8XzN/B4xyJrRqBugzc+zXX6vs
        NGHm4U9z4pg5Qtpf0TZKa4nA7h8IpcMOK6HuVdez2rgiQc5aY+qKDBZzq87Hl8xa9iYqTjL8qxGfo
        Z4NM4nz93G2zbzkqSqY8VZ1W1Z7i5U8+lSixF4EpC8cfAe291XB81Hnek5xLg2Vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m3ZMo-0025w2-Pe; Wed, 14 Jul 2021 09:31:38 +0200
Message-ID: <59ca83f01601a47bf3cfaf38e85570b8a3c5c72a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] mt76 mt7915: take RCU read lock when calling
 ieee80211_bss_get_elem()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 14 Jul 2021 09:31:37 +0200
In-Reply-To: <510ef14986079c731ea2879b3095831b60e4f648.1626240767.git.ryder.lee@mediatek.com>
References: <510ef14986079c731ea2879b3095831b60e4f648.1626240767.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-07-14 at 13:36 +0800, Ryder Lee wrote:
> 
>  	if (!elem || elem->datalen < 10 ||
>  	    !(elem->data[10] &
>  	      WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT))
>  		data->tolerated = false;

Unrelated to this patch, but that looks like an off-by-one?

If datalen == 10, then you can only access data[0] through data[9], not
data[10]?

johannes

