Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBF90FDE
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 11:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfHQJtT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 05:49:19 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:46430 "EHLO
        8.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfHQJtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 05:49:19 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Aug 2019 05:49:19 EDT
Received: from player695.ha.ovh.net (unknown [10.109.159.35])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id D08811AA203
        for <linux-wireless@vger.kernel.org>; Sat, 17 Aug 2019 10:31:36 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player695.ha.ovh.net (Postfix) with ESMTPSA id 61A2E8CB9791;
        Sat, 17 Aug 2019 08:31:31 +0000 (UTC)
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566030690;
        bh=0+nRS2PBRtbp9fdU+6Rd+dNPiQtWIn50tssT+qzhOC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YKbUTYBzKsybhWXnQ3dPJa78NCXtDFvhT1UdF+8UKG+g+R34MX0ZfxKC/U/MuMZrv
         4ksfpivKMPqNPJ98bDCen61xor+TR6koymYu1MnwvlLkhvV+d4XxjJQMhn2Fms3hwm
         +bEmaWrbThFVnvtd45jD/JJ62xuHtrVOL8oCQ9yY=
To:     johannes@sipsolutions.net, Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
References: <20190629195015.19680-1-alexander@wetzel-home.de>
 <20190629195015.19680-4-alexander@wetzel-home.de>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
Date:   Sat, 17 Aug 2019 10:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190629195015.19680-4-alexander@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13504043483087379708
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefhedgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> All iwlwifi cards are able to handle multiple keyids per STA and are
> therefore fully compatible with the Extended Key ID implementation
> provided by mac80211.

I just tried Extended Key ID with a AX200 card and it really looks like 
it's incompatible:-(

The card is starting to use the PTK key immediately after installation, 
encrypting EAPOL #3 with the new (still Rx only!) key.

Digging around in the driver code it looks like we do not even pass the 
key information any longer to the card: iwl_mvm_set_tx_params() is 
bypassing iwl_mvm_set_tx_cmd_crypto() completely when we use the "new tx 
API". So all cards setting "use_tfh" to true are now incompatible.

Therefore it looks like that all cards starting with the 22000 series 
can't be used with Extended Key ID any longer.

Is there a way to hand over the key information within the new API or is 
the way forward to block Extended Key ID when the "new tx API" is being 
used?

The card is fine with using keyid 1 for unicast keys. But it looks like 
it assumes that a new key install also tells it to use the new key 
immediately... Still digging around but pretty sure that's happening now.

Alexander
