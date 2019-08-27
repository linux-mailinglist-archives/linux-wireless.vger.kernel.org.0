Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214ED9E2B0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfH0Iao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 04:30:44 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:37387 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfH0Iao (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 04:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lz3osODEUPjBC59yNMazlxf9VZyBoemJKN2ReZcKz24=; b=kHnPKJyLEYuyDWZ85ep/6V8Rwf
        fafN7eUElmpmO0N5kbpdAunQoJutW0s7zZX+s8Z/uYb818FhHf/x4iFkEC8xz1B4ovpTv9AuaL7/Y
        ofPUbZYFZ/+A46RqQ8T7pQCVaFJUwnLQF9CKmOwQrABVo8YB+LxVRHgXKgwbkWqaNkuwLL1zmN1lS
        tWXsaaEWj+9VgTB48tTY5zYn0I7zx4KaVYfbhkuvO+h5ouoU8DZY7QiPjUXh2eIwXoXfeHHSN+dod
        uBuMs0hcfQbECxo883CQos81Pd4Ot8Zwv1LCcj9S2PCYPM6N+Nac2MRIOTj1g46yaRfnegLGiKYpV
        K5gUb7VQ==;
Received: from [194.100.106.190] (helo=lettuce)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jekarl@iki.fi>)
        id 1i2Ws5-0006NV-8h; Tue, 27 Aug 2019 11:30:33 +0300
Date:   Tue, 27 Aug 2019 11:30:32 +0300
From:   Emil Karlson <jekarl@iki.fi>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Tomislav =?UTF-8?B?UG/FvmVnYQ==?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>,
        Fredrik Noring <noring@nocrew.org>
Subject: Re: [PATCH 5.3] rt2x00: clear up IV's on key removal
Message-ID: <20190827113032.42e69b72@lettuce>
In-Reply-To: <1566564483-31088-1-git-send-email-sgruszka@redhat.com>
References: <1566564483-31088-1-git-send-email-sgruszka@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 194.100.106.190
X-SA-Exim-Mail-From: jekarl@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 23 Aug 2019 14:48:03 +0200
Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> After looking at code I realized that my previous fix
> 95844124385e ("rt2x00: clear IV's on start to fix AP mode regression")
> was incomplete. We can still have wrong IV's after re-keyring.
> To fix that, clear up IV's also on key removal.
> 
> Fixes: 710e6cc1595e ("rt2800: do not nullify initialization vector
> data") Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 19
> ++++++++++++------- 1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c index
> ecbe78b8027b..28e2de04834e 100644 ---
> a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c +++
> b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c @@ -1654,13 +1654,18
> @@ static void rt2800_config_wcid_attr_cipher(struct rt2x00_dev
> *rt2x00dev, offset = MAC_IVEIV_ENTRY(key->hw_key_idx);
>  
> -	rt2800_register_multiread(rt2x00dev, offset,
> -				  &iveiv_entry, sizeof(iveiv_entry));
> -	if ((crypto->cipher == CIPHER_TKIP) ||
> -	    (crypto->cipher == CIPHER_TKIP_NO_MIC) ||
> -	    (crypto->cipher == CIPHER_AES))
> -		iveiv_entry.iv[3] |= 0x20;
> -	iveiv_entry.iv[3] |= key->keyidx << 6;
> +	if (crypto->cmd == SET_KEY) {
> +		rt2800_register_multiread(rt2x00dev, offset,
> +					  &iveiv_entry,
> sizeof(iveiv_entry));
> +		if ((crypto->cipher == CIPHER_TKIP) ||
> +		    (crypto->cipher == CIPHER_TKIP_NO_MIC) ||
> +		    (crypto->cipher == CIPHER_AES))
> +			iveiv_entry.iv[3] |= 0x20;
> +		iveiv_entry.iv[3] |= key->keyidx << 6;
> +	} else {
> +		memset(&iveiv_entry, 0, sizeof(iveiv_entry));
> +	}
> +
>  	rt2800_register_multiwrite(rt2x00dev, offset,
>  				   &iveiv_entry,
> sizeof(iveiv_entry)); }

Seems to work when used with the previous patch on top of 5.3-rc6
tested-by: Emil Karlson <jekarl@iki.fi>
