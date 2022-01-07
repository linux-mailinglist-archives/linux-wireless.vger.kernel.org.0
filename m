Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2817487496
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiAGJSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 04:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiAGJSn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 04:18:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984FAC061245;
        Fri,  7 Jan 2022 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oK6uBavdA5Gnt8mEB1fkktbayvYWRTqUAEziGOUdNos=;
        t=1641547123; x=1642756723; b=T50b+xb1EVsoX/LYS2H1+sF35SQVRh6urP7juC+EKzvQUjz
        0SvcOuAWimdi44xMjW9LwyyWtH7cOx+2KgSpXKaakk+rb894iDYRwIKwSBTqoPwv8EkjKuNqIpHCv
        erRIozk2tTIwdNwawMF+tgSd2oz/n5I2auW6/OZ69n+NNQi1Wnqlc68cMVxux9ew/ous/pIRwK6Jp
        oh3qiP/9SaZMhX1QrE/JaQ0GqQbw36WYTp5izdFuLp+sRxXjv5X/S1AxgiqNthhPgQQaJhC4hgYEK
        R2AUz///Rzlc2hIarijigvZSWgutYXSl46kENsJhPJbw4j8QT3/RESO/v5IuA/Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n5lOF-002qrE-GQ;
        Fri, 07 Jan 2022 10:18:27 +0100
Message-ID: <f61c6a25c7ad1ed452b4facf38c7e451d47c5dc0.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7915: fix a couple information leaks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 07 Jan 2022 10:18:25 +0100
In-Reply-To: <20220107073609.GH22086@kili>
References: <20220107073609.GH22086@kili>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-01-07 at 10:36 +0300, Dan Carpenter wrote:
> Unfortunately this code has stumbled into some deep C standards
> nonsense.  These two structs have a 3 byte struct hole at the end.  If
> you partially initialize a struct then the C standard specifies that
> all the struct holes are zeroed out.  But when you initialize all the
> members of the struct, as this code does, then struct holes may be left
> with uninitialized stack data.  This is from C11 section 6.7.9 and how
> it is implemented in GCC.

Wow, nice find ...

> +	memset(&data, 0, sizeof(data));
> +	data.cmd = cpu_to_le32(MURU_SET_TXC_TX_STATS_EN);
> +	data.enable = enabled;
> 

Maybe add a comment? This is not going to be obvious in the future.

>  	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
> &data,
>  				sizeof(data), false);

Or maybe instead just mark the thing __packed (and/or explicitly add the
padding if needed), it seems weird that we'd send something to the
*firmware* that has a struct layout subject to compiler/arch padding
rules.

johannes
