Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC15426C4D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhJHOFO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJHOFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 10:05:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB227C061570
        for <linux-wireless@vger.kernel.org>; Fri,  8 Oct 2021 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TYu+1zYR43xAxoHI39OSxNvmGCOL7NaMXo0mEayFmqI=;
        t=1633701798; x=1634911398; b=YlOyXDQWN4Ffw7bl2JK18TjDB0/aUwsazjtNDZ4YUTozQVu
        xWoTVkdUt8AQJpcOIjWdNA6mAFlgz737a3veKo1k8ENzmrlGioaBBIP5tpBB2St93Eo1uxJ7/0D2j
        adF8g5CvG+MFWQZ1EzVTLXqllzCm31TMnt9Nf5ZKADaHTO48fgrbZoktjr7JD9SdaEHY2eEusbQuk
        FzPMeWZ+H5MusDmpOaTFwiGu8DocNWd0QedblYXRyNnTSC4M9NWNyjEPTgP+OQGfgzYppWRz4Yopc
        xTWftZ6oYzsLMCBtn3y/0KoopNdor89mQWUDuvQyvrvrT/GDHACxPp6zfcTY1lpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mYqSt-00HE5c-Mu;
        Fri, 08 Oct 2021 16:03:12 +0200
Message-ID: <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Fri, 08 Oct 2021 16:03:10 +0200
In-Reply-To: <20211008130007.GA23161@kili>
References: <20211008130007.GA23161@kili>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-08 at 16:00 +0300, Dan Carpenter wrote:
> 
>     1146         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
>     1147                                         sizeof(req), true, &skb);
> 
> If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg()
> then "skb" is not initialized.
> 
>     1148         if (ret)
>     1149                 return ret;
>     1150 
> --> 1151         res = (struct mt7921_mcu_eeprom_info *)skb->data;

Looks like possibly 'skb' is always initialized if
mt76_mcu_send_and_get_msg() returns 0 (success)?

But I guess it'd be nicer to write that with ERR_PTR() and actually
*return* the pointer (or ERR_PTR), rather than the output parameter.

johannes

