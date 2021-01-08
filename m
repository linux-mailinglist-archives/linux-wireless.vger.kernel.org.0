Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373FB2EF87F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 21:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbhAHUDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbhAHUDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB3C061381
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jan 2021 12:03:00 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kxxxf-003h79-VK; Fri, 08 Jan 2021 21:02:54 +0100
Message-ID: <0efec65815ff9e26b3da69cb35d503a90086760c.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Date:   Fri, 08 Jan 2021 21:02:53 +0100
In-Reply-To: <20210108105643.10834-1-shayne.chen@mediatek.com>
References: <20210108105643.10834-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This looks wrong to me, am I missing something?

> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> index 9135b6f..9991a6a 100644
> --- a/net/mac80211/debugfs.c
> +++ b/net/mac80211/debugfs.c
> @@ -120,7 +120,6 @@ static ssize_t aqm_write(struct file *file,
>  {
>  	struct ieee80211_local *local = file->private_data;
>  	char buf[100];
> -	size_t len;
>  
>  	if (count > sizeof(buf))
>  		return -EINVAL;

This ensures that count <= sizeof(buf)

> @@ -128,10 +127,10 @@ static ssize_t aqm_write(struct file *file,
>  	if (copy_from_user(buf, user_buf, count))
>  		return -EFAULT;

We copy, that's fine.
 
> -	buf[sizeof(buf) - 1] = '\0';
> -	len = strlen(buf);
> -	if (len > 0 && buf[len-1] == '\n')
> -		buf[len-1] = 0;
> +	if (count && buf[count - 1] == '\n')
> +		buf[count - 1] = '\0';

This I think really was meant as strlen, because if you write something
like

 10\n\0\0\0\0

before it would have parsed it as 10 still, now it gets confused?

I guess I'm not worried about that though.

> +	buf[count] = '\0';

But if count == sizeof(buf) then this is an out-of-bounds write.

Same for all the other copied instances.

johannes

